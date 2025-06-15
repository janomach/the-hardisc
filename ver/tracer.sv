/*
   Copyright 2023 Ján Mach

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

import p_hardisc::*;
`define TEXT 32*8
typedef enum bit [3:0] {BASE, MEXT, LOAD, STORE, BRANCH, JAL, JALR, CSR} itype_e;
typedef struct packed{
    bit [4:0] rs1;
    bit [4:0] rs2;
    bit rs1_used;
    bit rs2_used;    
} source_s;
typedef struct packed{
    bit [4:0] rd;
    bit rd_used;
} destination_s;
typedef struct {
    string text;
    source_s source;
    destination_s dest;
    itype_e itype;
} instruction_s;

module tracer
(
    input logic s_clk_i,
    input logic s_resetn_i,
    input logic[31:0] s_wb_pc_i,
    input logic[31:0] s_wb_instr_i,
    input logic[31:0] s_wb_val_i,
    input logic[4:0] s_wb_rd_i,

    input logic[31:0] s_dec_instr_i,
    input logic[31:0] s_dut_mcycle_i,
    input logic[31:0] s_dut_minstret_i,
    input logic[30:0] s_dut_fe0_add_i,
    input logic s_dut_fe0_utd_i,
    input logic[30:0] s_dut_fe1_add_i,
    input logic s_dut_fe1_utd_i,
    input logic[6:0] s_dut_id_ictrl_i,
    input logic s_dut_aligner_nop_i,
    input logic[6:0] s_dut_op_ictrl_i,
    input logic[6:0] s_dut_ex_ictrl_i,
    input logic[6:0] s_dut_ma_ictrl_i,
    input logic[6:0] s_dut_wb_ictrl_i,
    input logic s_dut_rfc_we_i,
    input logic[31:0] s_dut_rfc_wval_i,
    input logic[4:0] s_dut_rfc_wadd_i
);
    int fd, logging,i;
    string logfile;
    instruction_s s_wb_instruction, s_id_instruction;
    string i_resinfo, i_result;
    initial begin
        fd = 0;
        logging = 0;
        if($value$plusargs ("LOGGING=%d", logging));
        if ($value$plusargs ("LFILE=%s", logfile))begin
            $display ("Log file:%s", logfile);
            fd = $fopen(logfile,"w");
        end
    end

    always_comb begin
        if(s_dec_instr_i[1:0] == 2'b11)begin
            s_id_instruction = instr_i(s_dec_instr_i);
        end else begin
            s_id_instruction = instr_c(s_dec_instr_i);
        end
        if(s_wb_instr_i[1:0] == 2'b11)begin
            s_wb_instruction = instr_i(s_wb_instr_i);
        end else begin
            s_wb_instruction = instr_c(s_wb_instr_i);
        end    
    end

    always_ff @( posedge s_clk_i ) begin 
        if(s_resetn_i & (logging >= 1))begin
            $write ("[%6d, %6d, %1.3f] FA: %8x | FD: %8x | ID: (%2x) %-30s | OP: %2x | EX: %2x | MA: %2x | WB: %2x ~ %8x, %c", 
                s_dut_mcycle_i, s_dut_minstret_i, 
                (s_dut_mcycle_i == 32'b0) ? $bitstoreal(0) : ($bitstoreal({32'b0,s_dut_minstret_i})/$bitstoreal({32'b0,s_dut_mcycle_i})),
                s_dut_fe0_utd_i ? {s_dut_fe0_add_i,1'b0} : 32'd0, 
                s_dut_fe1_utd_i ? {s_dut_fe1_add_i,1'b0} : 32'd0,
                s_dut_aligner_nop_i ? 0 : s_dut_id_ictrl_i, 
                s_dut_aligner_nop_i ? "" : ((s_dec_instr_i[1:0] == 2'b11) ? s_id_instruction.text : {"c.",s_id_instruction.text}),
                s_dut_op_ictrl_i, s_dut_ex_ictrl_i,s_dut_ma_ictrl_i, s_dut_wb_ictrl_i,
                s_wb_pc_i, (|s_dut_wb_ictrl_i[4:0])? 8'd86 : 8'd32 );                
            if(s_dut_rfc_we_i) $write(" %x -> R%2d",s_dut_rfc_wval_i,s_dut_rfc_wadd_i);
            $write("\n");                       
        end
    end
    always_ff @( posedge s_clk_i ) begin
        if(s_resetn_i & (s_dut_wb_ictrl_i != 7'b0) & fd != 0)begin
            if(s_dut_rfc_we_i)begin
                    i_result = $sformatf("x%2d 0x%8x",s_dut_rfc_wadd_i, s_dut_rfc_wval_i);
            end else begin 
                    i_result = "";
            end
            if(s_dut_wb_ictrl_i[ICTRL_RVC])
                i_resinfo = $sformatf("core   0: 3 0x%8x (0x%4x)",s_wb_pc_i,s_wb_instr_i[15:0]);
            else
                i_resinfo = $sformatf("core   0: 3 0x%8x (0x%8x)",s_wb_pc_i,s_wb_instr_i);

            $fwrite(fd,"core   0: 0x%8x (0x%8x) %s\n",s_wb_pc_i,s_wb_instr_i,(s_wb_instr_i[1:0] == 2'b11) ? s_wb_instruction.text : {"c.",s_wb_instruction.text});
            $fwrite(fd,"%s %s\n",i_resinfo,i_result);
        end
    end

    function instruction_s instr_i (input bit[31:0] instr);
        string jal_offset, signed_12off, signed_12offs, rs1_name, rd_name, rs2_name, branch_off, csr_name;
        logic rd_zero, rd_ra, rs1_zero, rs2_zero;
        int jal_imm, branch_imm;
        jal_imm = $signed({{20{instr[31]}},instr[19:12],instr[20],instr[30:21],1'b0});
        branch_imm = $signed({{20{instr[31]}},instr[7],instr[30:25],instr[11:8],1'b0});
        jal_offset = $sformatf("0x%1h",(instr[31]) ? (jal_imm *(-1)) : jal_imm);
        branch_off = $sformatf("%1d",(instr[31]) ? (branch_imm *(-1)) : branch_imm);
        signed_12off = $sformatf("%1d",$signed({{20{instr[31]}},instr[31:20]}));
        signed_12offs = $sformatf("%1d",$signed({{20{instr[31]}},instr[31:25],instr[11:7]}));
        rs1_name = reg_name(instr[19:15]);
        rs2_name = reg_name(instr[24:20]);
        rd_name = reg_name(instr[11:7]);
        csr_name = csreg_name(instr[31:20]);
        rd_zero = instr[11:7] == 5'd0;
        rd_ra = instr[11:7] == 5'd1;
        rs1_zero = instr[19:15] == 5'd0;
        rs2_zero = instr[24:20] == 5'd0;
        case (instr[6:2])
            5'b01101: begin
                instr_i.text = {"lui     ",rd_name,", ",$sformatf("0x%1h",instr[31:12])};
                instr_i.source = {5'd0,5'd0,1'b0,1'b0};
                instr_i.dest = {instr[11:7],1'b1};
                instr_i.itype = BASE;
            end
            5'b00101: begin
                instr_i.text = {"auipc   ",rd_name,", ",$sformatf("0x%1h",instr[31:12])};
                instr_i.source = {5'd0,5'd0,1'b0,1'b0};
                instr_i.dest = {instr[11:7],1'b1};
                instr_i.itype = BASE;
            end
            5'b11011: begin
                instr_i.text = (rd_zero) ? {"j       pc ",(instr[31]) ? "-" : "+"," ",jal_offset}: 
                                (rd_ra) ? {"jal     pc ",(instr[31]) ? "-" : "+"," ",jal_offset} :
                                {"jal     ",rd_name," pc ",(instr[31]) ? "-" : "+"," ",jal_offset};
                instr_i.source = {5'd0,5'd0,1'b0,1'b0};
                instr_i.dest = {instr[11:7],1'b1};
                instr_i.itype = JAL;
            end
            5'b11001: begin
                instr_i.text = (instr[14:12] == 3'd0 & rd_zero & instr[19:15] == 5'd1 & instr[31:20] == 12'd0) ? {"ret"}: 
                                (instr[31:20] == 12'd0 & instr[14:12] == 3'd0 & rd_zero) ? {"jr      ",rs1_name}: 
                                (instr[31:20] == 12'd0 & instr[14:12] == 3'd0 & rd_ra) ? {"jalr    ",rs1_name}:
                                (instr[14:12] == 3'b0) ? {"jalr    ",rd_name,", ",rs1_name,signed_12off}: "unknown";
                instr_i.source = {instr[19:15],5'd0,1'b1,1'b0};
                instr_i.dest = {instr[11:7],1'b1};
                instr_i.itype = JALR;
            end
            5'b11000: begin
                case (instr[14:12])
                    3'b000: instr_i.text = {"beq     ",rs1_name,", ",rs2_name,", pc ",(instr[31]) ? "-" : "+"," ",branch_off};
                    3'b001: instr_i.text = {"bne     ",rs1_name,", ",rs2_name,", pc ",(instr[31]) ? "-" : "+"," ",branch_off};
                    3'b100: instr_i.text = {"blt     ",rs1_name,", ",rs2_name,", pc ",(instr[31]) ? "-" : "+"," ",branch_off};
                    3'b101: instr_i.text = {"bge     ",rs1_name,", ",rs2_name,", pc ",(instr[31]) ? "-" : "+"," ",branch_off};
                    3'b110: instr_i.text = {"bltu    ",rs1_name,", ",rs2_name,", pc ",(instr[31]) ? "-" : "+"," ",branch_off};
                    3'b111: instr_i.text = {"bgeu    ",rs1_name,", ",rs2_name,", pc ",(instr[31]) ? "-" : "+"," ",branch_off};
                    default:instr_i.text = "unknown";
                endcase
                instr_i.source = {instr[19:15],instr[24:20],1'b1,1'b1};
                instr_i.dest = {instr[11:7],1'b0};
                instr_i.itype = BRANCH;
            end
            5'b00000: begin
                case (instr[14:12])
                    3'b000: instr_i.text = {"lb      ",rd_name,", ",signed_12off,"(",rs1_name,")"};
                    3'b001: instr_i.text = {"lh      ",rd_name,", ",signed_12off,"(",rs1_name,")"};
                    3'b010: instr_i.text = {"lw      ",rd_name,", ",signed_12off,"(",rs1_name,")"};
                    3'b100: instr_i.text = {"lbu     ",rd_name,", ",signed_12off,"(",rs1_name,")"};
                    3'b101: instr_i.text = {"lhu     ",rd_name,", ",signed_12off,"(",rs1_name,")"};
                    default:instr_i.text = "unknown";
                endcase
                instr_i.source = {instr[19:15],5'd0,1'b1,1'b0};
                instr_i.dest = {instr[11:7],1'b1};
                instr_i.itype = LOAD;
            end
            5'b01000: begin
                case (instr[14:12])
                    3'b000: instr_i.text = {"sb      ",rs2_name,", ",signed_12offs,"(",rs1_name,")"};
                    3'b001: instr_i.text = {"sh      ",rs2_name,", ",signed_12offs,"(",rs1_name,")"};
                    3'b010: instr_i.text = {"sw      ",rs2_name,", ",signed_12offs,"(",rs1_name,")"};
                    default:instr_i.text = "unknown";
                endcase
                instr_i.source = {instr[19:15],instr[24:20],1'b1,1'b1};
                instr_i.dest = {instr[11:7],1'b0};
                instr_i.itype = STORE;
            end
            5'b00100: begin
                case (instr[14:12])
                    3'b000: instr_i.text = (rs1_zero & rd_zero & instr[31:20] == 12'b0) ? {"nop    "}: 
                                      (rs1_zero) ? {"li      ",rd_name,", ",signed_12off}: {"addi    ",rd_name,", ",rs1_name,", ",signed_12off};
                    3'b001: begin
                        case (instr[31:25])
                            7'b0000000: instr_i.text = {"slli    ",rd_name,", ",rs1_name,", ",signed_12off};
                            7'b0100100: instr_i.text = {"bclri   ",rd_name,", ",rs1_name,", ",signed_12off};
                            7'b0110100: instr_i.text = {"binvi   ",rd_name,", ",rs1_name,", ",signed_12off};
                            7'b0010100: instr_i.text = {"bseti   ",rd_name,", ",rs1_name,", ",signed_12off};
                            7'b0110000: begin
                                case (instr[24:20])
                                    5'b00000: instr_i.text = {"clz     ",rd_name,", ",rs1_name};
                                    5'b00010: instr_i.text = {"cpop    ",rd_name,", ",rs1_name};
                                    5'b00001: instr_i.text = {"ctz     ",rd_name,", ",rs1_name};
                                    5'b00100: instr_i.text = {"sext.b  ",rd_name,", ",rs1_name};
                                    5'b00101: instr_i.text = {"sext.h  ",rd_name,", ",rs1_name};
                                    default:instr_i.text = "unknown";
                                endcase
                            end
                            default: instr_i.text = "unknown";
                        endcase
                    end
                    3'b010: instr_i.text = {"slti    ",rd_name,", ",rs1_name,", ",signed_12off};
                    3'b011: instr_i.text = {"sltiu   ",rd_name,", ",rs1_name,", ",signed_12off};
                    3'b100: instr_i.text = {"xori    ",rd_name,", ",rs1_name,", ",signed_12off};
                    3'b101: begin
                        case (instr[31:25])
                            7'b0000000: instr_i.text = {"srli    ",rd_name,", ",rs1_name,", ",signed_12off};
                            7'b0100000: instr_i.text = {"srai    ",rd_name,", ",rs1_name,", ",signed_12off};
                            7'b0100100: instr_i.text = {"bexti   ",rd_name,", ",rs1_name,", ",signed_12off};
                            7'b0110000: instr_i.text = {"rori   ",rd_name,", ",rs1_name,", ",signed_12off};
                            7'b0010100: instr_i.text = (instr[24:20] == 5'b00111) ? {"orc.b   ",rd_name,", ",rs1_name} : "unknown";
                            7'b0110100: instr_i.text = (instr[24:20] == 5'b11000) ? {"rev8    ",rd_name,", ",rs1_name} : "unknown";
                            default: instr_i.text = "unknown";
                        endcase
                    end
                    3'b110: instr_i.text = {"ori     ",rd_name,", ",rs1_name,", ",signed_12off};
                    3'b111: instr_i.text = {"andi    ",rd_name,", ",rs1_name,", ",signed_12off};
                    default:instr_i.text = "unknown";
                endcase
                instr_i.source = {instr[19:15],instr[24:20],1'b1,1'b0};
                instr_i.dest = {instr[11:7],1'b1};
                instr_i.itype = BASE;
            end
            5'b01100: begin
                case ({instr[31:25],instr[14:12]})
                    10'b0000000000: instr_i.text = {"add     ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0100000000: instr_i.text = {"sub     ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0000000001: instr_i.text = {"sll     ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0000000010: instr_i.text = {"slt     ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0000000011: instr_i.text = {"sltu    ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0000000100: instr_i.text = {"xor     ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0000000101: instr_i.text = {"srl     ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0100000101: instr_i.text = {"sra     ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0100000111: instr_i.text = {"andn    ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0100100001: instr_i.text = {"bclr    ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0100100101: instr_i.text = {"bext    ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0110100001: instr_i.text = {"binv    ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0010100001: instr_i.text = {"bset    ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0000101001: instr_i.text = {"clmul   ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0000101011: instr_i.text = {"clmulh  ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0000101010: instr_i.text = {"clmulr  ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0000101110: instr_i.text = {"max     ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0000101111: instr_i.text = {"maxu    ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0000101100: instr_i.text = {"min     ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0000101101: instr_i.text = {"minu    ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0100000110: instr_i.text = {"orn     ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0110000001: instr_i.text = {"rol     ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0110000101: instr_i.text = {"ror     ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0010000010: instr_i.text = {"sh1add  ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0010000100: instr_i.text = {"sh2add  ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0010000110: instr_i.text = {"sh3add  ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0100000100: instr_i.text = {"xnor    ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0000100100: instr_i.text = (instr[24:20] == 5'b0) ? {"zext.h    ",rd_name,", ",rs1_name} : "unknown";
                    10'b0000000110: instr_i.text = {"or      ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0000000111: instr_i.text = {"and     ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0000001000: instr_i.text = {"mul     ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0000001001: instr_i.text = {"mulh    ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0000001010: instr_i.text = {"mulhsu  ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0000001011: instr_i.text = {"mulhu   ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0000001100: instr_i.text = {"div     ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0000001101: instr_i.text = {"divu    ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0000001110: instr_i.text = {"rem     ",rd_name,", ",rs1_name,", ",rs2_name};
                    10'b0000001111: instr_i.text = {"remu    ",rd_name,", ",rs1_name,", ",rs2_name};
                    default:instr_i.text = "unknown";
                endcase
                instr_i.source = {instr[19:15],instr[24:20],1'b1,1'b1};
                instr_i.dest = {instr[11:7],1'b1};
                instr_i.itype = (instr[25]) ? MEXT : BASE;
            end
            5'b00011: begin
                instr_i.text = (instr[14:12] == 3'b0) ? "fence  " : (instr[14:12] == 3'b1) ? "fence.i" : "unknown";
                instr_i.source = {5'd0,5'd0,1'b0,1'b0};
                instr_i.dest = {instr[11:7],1'b0};
                instr_i.itype = CSR;
            end
            5'b11100: begin
                if(rd_zero & rs1_zero)begin
                    if(instr[14:12] == 3'b000 & instr[31:20] == 12'h302) instr_i.text = "mret";
                    else if(instr[14:12] == 3'b000 & instr[31:20] == 12'h000) instr_i.text = "ecall";
                    else if(instr[14:12] == 3'b000 & instr[31:20] == 12'h001) instr_i.text = "ebreak";
                    else instr_i.text = "unknown";
                    instr_i.source = {5'd0,5'd0,1'b0,1'b0};
                    instr_i.dest = {instr[11:7],1'b0};
                    instr_i.itype = CSR;
                end else begin
                    case (instr[14:12])
                        3'b001: instr_i.text = (rd_zero) ? {"csrw    ",csr_name, ", ",rs1_name} : 
                                                      {"csrrw   ",rd_name,", ",csr_name, ", ",rs1_name};
                        3'b010: instr_i.text = (rs1_zero) ? {"csrr    ",rd_name, ", ",csr_name}: 
                                          (rd_zero) ?  {"csrs    ",csr_name, ", ",rs1_name} : 
                                                       {"csrrs   ",rd_name,", ",csr_name, ", ",rs1_name};
                        3'b011: instr_i.text = (rs1_zero) ? {"csrc    ",csr_name, ", ",rs1_name} : 
                                                      {"csrrc   ",rd_name,", ",csr_name, ", ",rs1_name};
                        3'b101: instr_i.text = (rd_zero) ? {"csrwi   ",csr_name, ", ",$sformatf("%1d",instr[19:15])} : 
                                                      {"csrrwi  ",rd_name,", ",csr_name, ", ",$sformatf("%1d",instr[19:15])};
                        3'b110: instr_i.text = (rd_zero) ? {"csrsi   ",csr_name, ", ",$sformatf("%1d",instr[19:15])} : 
                                                      {"csrrsi  ",rd_name,", ",csr_name, ", ",$sformatf("%1d",instr[19:15])};
                        3'b111: instr_i.text = (rd_zero) ? {"csrci   ",csr_name, ", ",$sformatf("%1d",instr[19:15])}: 
                                                      {"csrrci  ",rd_name,", ",csr_name, ", ",$sformatf("%1d",instr[19:15])};
                        default:instr_i.text = "unknown";
                    endcase
                    instr_i.source = (~instr[14]) ? {instr[19:15],5'd0,1'b1,1'b0} : {5'd0,5'd0,1'b0,1'b0};
                    instr_i.dest = {instr[11:7],1'b1};
                    instr_i.itype = CSR;
                end
            end
            default: begin
                instr_i.text = "unknown";
                instr_i.source = {5'd0,5'd0,1'b0,1'b0};
                instr_i.dest = {instr[11:7],1'b0};
                instr_i.itype = BASE;
            end
        endcase
    endfunction
    function instruction_s instr_c (input bit[31:0] instr);
        string name11to7, name4to2, name6to2, offimm6, offj, name9to7, offb;
        logic[11:0] s_imm12j, s_imm12b;
        logic[10:0] s_imm10;
        logic[9:0] s_uimm10adi4, s_uimm10lwsw;
        logic[7:0] s_uimm8lwsp, s_uimm8swsp;
        logic[5:0] s_imm6;
        logic s_rs1zero, s_shamtzr;
        
        s_rs1zero       = instr[11:7] == 5'b00;
        s_shamtzr       = instr[6:2] == 5'b0;
        s_uimm10adi4    = {instr[10:7],instr[12:11],instr[5],instr[6],2'b0}; 
        s_uimm10lwsw    = {3'b0,instr[5],instr[12:10],instr[6],2'b0};
        s_uimm8lwsp     = {instr[3:2],instr[12],instr[6:4],2'b0};
        s_uimm8swsp     = {instr[8:7],instr[12:9],2'b0};
        s_imm12j        = {instr[12],instr[8],instr[10:9],instr[6],instr[7],instr[2],instr[11],instr[5:3],1'b0};
        s_imm12b        = {{4{instr[12]}},instr[6:5],instr[2],instr[11:10],instr[4:3],1'b0};
        s_imm10         = {instr[12],instr[4:3],instr[5],instr[2],instr[6],4'b0};
        s_imm6          = {instr[12],instr[6:2]};
        name6to2        = reg_name(instr[6:2]);
        name11to7       = reg_name(instr[11:7]);
        name4to2        = reg_name({2'b1,instr[4:2]});
        name9to7        = reg_name({2'b1,instr[9:7]});
        offimm6         = $sformatf("%1d",$signed({{26{instr[12]}},s_imm6}));
        offj            = $sformatf("0x%1h",(instr[12]) ? (s_imm12j *(-1)) : s_imm12j);
        offb            = $sformatf("0x%1h",(instr[12]) ? (s_imm12b *(-1)) : s_imm12b);

        case (instr[1:0])
            2'b00:begin
                case (instr[15:13])
                    3'd0:begin
                        instr_c.text = (instr[12:5] != 8'b0) ? {"addi4spn ",name4to2,", sp, ",$sformatf("%1d",s_uimm10adi4)} : "unknown";
                        instr_c.source = {5'd2,5'd0,1'b1,1'b0};
                        instr_c.dest = {{2'b1,instr[4:2]},1'b1};
                        instr_c.itype = BASE;
                    end
                    3'd2:begin
                        instr_c.text = {"lw ",name4to2,", ",$sformatf("%1d",s_uimm10lwsw),"(",name9to7,")"};
                        instr_c.source = {{2'b1,instr[9:7]},5'd0,1'b1,1'b0};
                        instr_c.dest = {{2'b1,instr[4:2]},1'b1};
                        instr_c.itype = LOAD;
                    end
                    3'd6:begin
                        instr_c.text = {"sw ",name4to2,", ",$sformatf("%1d",s_uimm10lwsw),"(",name9to7,")"};
                        instr_c.source = {{2'b1,instr[9:7]},{2'b1,instr[4:2]},1'b1,1'b1};
                        instr_c.dest = {{2'b1,instr[4:2]},1'b0};
                        instr_c.itype = STORE;
                    end
                    default: begin
                        instr_c.text = "unknown";
                        instr_c.source = {5'd0,5'd0,1'b0,1'b0};
                        instr_c.dest = {{2'b1,instr[4:2]},1'b0};
                        instr_c.itype = BASE;
                    end
                endcase
            end
            2'b01:begin
                case (instr[15:13])
                    3'd0:begin
                        instr_c.text = (s_rs1zero) ? "nop" : {"addi ",name11to7,", ",offimm6};
                        instr_c.source = (s_rs1zero) ? {5'd0,5'd0,1'b1,1'b0} : {instr[11:7],5'd0,1'b1,1'b0};
                        instr_c.dest = {(s_rs1zero) ? 5'd0 : instr[11:7],1'b1};
                        instr_c.itype = BASE;
                    end
                    3'd1:begin
                        instr_c.text = {"jal   "," pc ",(instr[12]) ? "-" : "+"," ",offj};
                        instr_c.source = {5'd0,5'd0,1'b0,1'b0};
                        instr_c.dest = {5'd1,1'b1};
                        instr_c.itype = JAL;
                    end
                    3'd2:begin
                        instr_c.text = {"li    ",name11to7,", ",$sformatf("%1d",s_imm6)};
                        instr_c.source = {5'd0,5'd0,1'b1,1'b0};
                        instr_c.dest = {instr[11:7],1'b1};
                        instr_c.itype = BASE;
                    end
                    3'd3:begin
                        instr_c.text = (instr[11:7] != 5'd2 & s_imm6 != 6'd0) ? {"lui   ",name11to7,", ",$sformatf("0x%1h",s_imm6)}: 
                                        (s_imm10 != 10'd0) ? {"addi16sp  sp, ",$sformatf("%1d",$signed({{26{instr[12]}},s_imm10}))} : "unknown";
                        instr_c.source = (instr[11:7] != 5'd2 & s_imm6 != 6'd0) ? {5'd0,5'd0,1'b0,1'b0} : 
                                         (s_imm10 != 10'd0) ? {5'd2,5'd0,1'b1,1'b0} : {5'd0,5'd0,1'b0,1'b0};
                        instr_c.dest = (instr[11:7] != 5'd2 & s_imm6 != 6'd0) ? {instr[11:7],1'b1} : 
                                         (s_imm10 != 10'd0) ? {5'd2,1'b1} : {5'd0,1'b0};
                        instr_c.itype = BASE;
                    end
                    3'd4:begin
                        instr_c.text = (instr[11:10] == 2'b10) ?  {"andi   ",name9to7,", ",offimm6}: 
                                        (instr[11:10] == 2'b00) ?  {"srli   ",name9to7,", ",$sformatf("%1d",s_imm6)}: 
                                        (instr[11:10] == 2'b01) ?  {"srai   ",name9to7,", ",$sformatf("%1d",s_imm6)}: 
                                        (instr[11:10] == 2'b11 & instr[6:5] == 2'b00 & ~instr[12]) ?  {"sub   ",name9to7,", ",name4to2}: 
                                        (instr[11:10] == 2'b11 & instr[6:5] == 2'b01 & ~instr[12]) ?  {"xor   ",name9to7,", ",name4to2}: 
                                        (instr[11:10] == 2'b11 & instr[6:5] == 2'b10 & ~instr[12]) ?  {"or    ",name9to7,", ",name4to2}: 
                                        (instr[11:10] == 2'b11 & instr[6:5] == 2'b11 & ~instr[12]) ?  {"and   ",name9to7,", ",name4to2}: "unknown";
                        instr_c.source = ((instr[11:10] == 2'b10) | (instr[11:10] == 2'b00 & ~s_shamtzr) | (instr[11:10] == 2'b01 & ~s_shamtzr)) ? {{2'b1,instr[9:7]},5'd0,1'b1,1'b0} : {{2'b1,instr[9:7]},{2'b1,instr[4:2]},1'b1,1'b1};
                        instr_c.dest = {{2'b1,instr[9:7]},1'b1};
                        instr_c.itype = BASE;
                    end
                    3'd5:begin
                        instr_c.text = {"j   "," pc ",(instr[12]) ? "-" : "+"," ",offj};
                        instr_c.source = {5'd0,5'd0,1'b0,1'b0};
                        instr_c.dest = {5'd0,1'b1};
                        instr_c.itype = JAL;
                    end
                    3'd6:begin
                        instr_c.text = {"beqz   ",name9to7,", pc ",(instr[12]) ? "-" : "+"," ",offb};
                        instr_c.source = {{2'b1,instr[9:7]},5'd0,1'b1,1'b1};
                        instr_c.dest = {{2'b1,instr[9:7]},1'b0};
                        instr_c.itype = BRANCH;
                    end
                    3'd7:begin
                        instr_c.text = {"bnez   ",name9to7,", pc ",(instr[12]) ? "-" : "+"," ",offb};
                        instr_c.source = {{2'b1,instr[9:7]},5'd0,1'b1,1'b1};
                        instr_c.dest = {{2'b1,instr[9:7]},1'b0};
                        instr_c.itype = BRANCH;
                    end
                    default: begin
                       instr_c.text = "todo";
                       instr_c.source = {5'd0,5'd0,1'b0,1'b0};
                       instr_c.dest = {{2'b1,instr[9:7]},1'b0};
                       instr_c.itype = BASE;
                    end
                endcase
            end
            2'b10:begin
                case (instr[15:13])
                    3'd0:begin
                        instr_c.text = (~instr[12]) ? {"slli ",name11to7,", ",$sformatf("%1d",s_imm6)}: "unknown";
                        instr_c.source = {instr[11:7],5'd0,1'b1,1'b0};
                        instr_c.dest = {instr[11:7],1'b1};
                        instr_c.itype = BASE;
                    end
                    3'd2:begin
                        instr_c.text = (~s_rs1zero) ? {"lwsp ",name11to7,", ",$sformatf("%1d",s_uimm8lwsp),"(sp)"}: "unknown";
                        instr_c.source = {5'd2,5'd0,1'b1,1'b0};
                        instr_c.dest = {instr[11:7],1'b1};
                        instr_c.itype = LOAD;
                    end
                    3'd4:begin
                        instr_c.text = (instr[12] & instr[11:2] == 10'b0) ? "ebreak" :
                                        (instr[12] & ~s_shamtzr) ? {"add ",name11to7,", ",name6to2}: 
                                        (~instr[12] & ~s_shamtzr) ? {"mv ",name11to7,", ",name6to2}:
                                        (~instr[12] & ~s_rs1zero & s_shamtzr) ? {"jr ",name11to7}:
                                        (instr[12] & ~s_rs1zero & s_shamtzr) ? {"jalr ",name11to7}: "unknown";
                        instr_c.source = (instr[12] & instr[11:2] == 10'b0) ? {5'd0,5'd0,1'b0,1'b0} : 
                                         (instr[12] & ~s_shamtzr) ? {instr[11:7],instr[6:2],1'b1,1'b1} : 
                                         (~instr[12] & ~s_shamtzr) ? {5'd0,instr[6:2],1'b1,1'b1} : {instr[11:7],5'd0,1'b1,1'b0} ;
                        instr_c.dest = (instr[12] & instr[11:2] == 10'b0) ? {5'd0,1'b0} : 
                                       (~s_shamtzr) ? {instr[11:7],1'b1} : 
                                       (~instr[12]) ? {5'd0,1'b1} : {5'd1,1'b1};
                        instr_c.itype = (instr[12] & instr[11:2] == 10'b0) ? CSR : 
                                         (~s_shamtzr) ? BASE : JALR;
                    end
                    3'd6:begin
                        instr_c.text = {"swsp ",name6to2,", ",$sformatf("%1d",s_uimm8swsp),"(sp)"};
                        instr_c.source = {5'd2,instr[6:2],1'b1,1'b1};
                        instr_c.dest = {instr[6:2],1'b0};
                        instr_c.itype = STORE;
                    end
                    default: begin
                        instr_c.text = "unknown";
                        instr_c.source = {5'd0,5'd0,1'b0,1'b0};
                        instr_c.dest = {{2'b1,instr[9:7]},1'b0};
                        instr_c.itype = BASE;
                    end
                endcase
            end
            default: begin
                instr_c.text = "unknown";
                instr_c.source = {5'd0,5'd0,1'b0,1'b0};
                instr_c.dest = {{2'b1,instr[9:7]},1'b0};
                instr_c.itype = BASE;
            end
        endcase

    endfunction

    function string reg_name (input bit[4:0] reg_number);
        case (reg_number)
            5'd00: reg_name = "zero";
            5'd01: reg_name = "ra";
            5'd02: reg_name = "sp";
            5'd03: reg_name = "gp";
            5'd04: reg_name = "tp";
            5'd05: reg_name = "t0";
            5'd06: reg_name = "t1";
            5'd07: reg_name = "t2";
            5'd08: reg_name = "s0";
            5'd09: reg_name = "s1";
            5'd10: reg_name = "a0";
            5'd11: reg_name = "a1";
            5'd12: reg_name = "a2";
            5'd13: reg_name = "a3";
            5'd14: reg_name = "a4";
            5'd15: reg_name = "a5";
            5'd16: reg_name = "a6";
            5'd17: reg_name = "a7";
            5'd18: reg_name = "s2";
            5'd19: reg_name = "s3";
            5'd20: reg_name = "s4";
            5'd21: reg_name = "s5";
            5'd22: reg_name = "s6";
            5'd23: reg_name = "s7";
            5'd24: reg_name = "s8";
            5'd25: reg_name = "s9";
            5'd26: reg_name = "s10";
            5'd27: reg_name = "s11";
            5'd28: reg_name = "t3";
            5'd29: reg_name = "t4";
            5'd30: reg_name = "t5";
            5'd31: reg_name = "t6";    
        endcase
    endfunction
    function string csreg_name (input bit[11:0] csr_number);
        case (csr_number)
            CSR_MSTATUS:     csreg_name = "mstatus";
            CSR_MIE:         csreg_name = "mie";
            CSR_MTVEC:       csreg_name = "mtvec";
            CSR_MEPC:        csreg_name = "mepc";
            CSR_MCAUSE:      csreg_name = "mcause";
            CSR_MTVAL:       csreg_name = "mtval";
            CSR_MIP:         csreg_name = "mip";
            CSR_MCYCLE:      csreg_name = "mcycle";
            CSR_MCYCLEH:     csreg_name = "mcycleh";
            CSR_MINSTRET:    csreg_name = "minstret";
            CSR_MINSTRETH:   csreg_name = "minstreth";
            CSR_MSCRATCH:    csreg_name = "mscratch";
            CSR_MHARTID:     csreg_name = "mhartid";
            CSR_MISA:        csreg_name = "misa";
            CSR_MHRDCTRL0:   csreg_name = "hrdctrl0";
            CSR_MADDRERR:    csreg_name = "maddrerr";
            default:         csreg_name = "unkonwn";
        endcase   
    endfunction
endmodule
