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

`include "settings.sv"
import p_hardisc::*;

module c_decoder (
    input logic[15:0] s_instr_i,    //instruction
    input logic s_prediction_i,     //indicates prediction made from the instruction

    output logic[19:0] s_imm_o,     //immediate value for computation
    output f_part s_f_o,            //specify instruction function
    output rf_add s_rs1_o,          //read address for read port 1 of register file
    output rf_add s_rs2_o,          //read address for read port 2 of register file
    output rf_add s_rd_o,           //write addres for register file
    output sctrl s_sctrl_o,         //source control indicator
    output ictrl s_ictrl_o,         //instruction control indicator
    output imiscon s_imiscon_o      //instruction misconduct indicator 
);
    logic[7:0] s_funct3;
    logic[2:0] s_quad;
    f_part s_fun;
    rf_add s_11to7, s_rs1, s_rs2, s_rd;
    ictrl s_instr_ctrl;
    sctrl s_src_ctrl;
    imiscon s_instr_miscon;
    logic s_beqz, s_bnez, s_j, s_jal, s_jr, s_jalr, s_li, 
            s_lui, s_addi, s_addi16sp, s_addi4spn, s_lw, s_sw, s_rs1zero, 
            s_rdsp, s_nzimm6bzr, s_nzuimmzr, s_slli, s_srli, s_srai, s_shamtzr, 
            s_andi, s_mv, s_add, s_and, s_or, s_xor, s_sub,
            s_lwsp, s_swsp, s_branch, s_jump, s_load, s_store, s_op_imm, s_op, 
            s_known, s_illi, s_ebreak, s_pred_not_allowed, s_illegal;
    logic[7:0] s_uimm8lwsp, s_uimm8swsp;
    logic[9:0] s_uimm10_0, s_uimm10_1, s_imm10, s_uimm10lwsw, s_uimm10adi4;
    logic[19:0] s_uimm, s_imm, s_immediate;
    logic[11:0] s_imm12_0, s_imm12_1, s_imm12j, s_imm12b;
    logic[5:0] s_imm6;

    //Final output selector
    assign s_rs1_o      = s_rs1;
    assign s_rs2_o      = s_rs2;
    assign s_rd_o       = s_rd;
    assign s_f_o        = s_fun;
    assign s_ictrl_o    = s_instr_ctrl;
    assign s_sctrl_o    = s_src_ctrl;
    assign s_imiscon_o  = s_instr_miscon;
    assign s_imm_o      = s_immediate;

    genvar i;
    generate
        for(i = 0;i<8;i++)begin: funct3_gen
            assign s_funct3[i] = s_instr_i[15:13] == i; 
        end
    endgenerate

    assign s_quad[0]    = s_instr_i[1:0] == 2'b00;
    assign s_quad[1]    = s_instr_i[1:0] == 2'b01;
    assign s_quad[2]    = s_instr_i[1:0] == 2'b10;
    assign s_11to7      = s_instr_i[11:7];
    assign s_rs1zero    = s_11to7 == 5'b00;
    assign s_rdsp       = s_11to7 == 5'b10;
    assign s_shamtzr    = s_instr_i[6:2] == 5'b0;
    assign s_nzimm6bzr  = {s_instr_i[12],s_instr_i[6:2]} == 6'b0;
    assign s_nzuimmzr   = s_instr_i[12:5] == 8'b0;

    //Quadrant 00
    assign s_illi       = s_instr_i[15:0] == 16'b0;
    assign s_addi4spn   = s_funct3[0] & s_quad[0] & ~s_nzuimmzr;
    assign s_lw         = s_funct3[2] & s_quad[0];
    assign s_sw         = s_funct3[6] & s_quad[0];

    //Quadrant 01
    assign s_addi       = s_funct3[0] & s_quad[1];
    assign s_jal        = s_funct3[1] & s_quad[1];
    assign s_li         = s_funct3[2] & s_quad[1];
    assign s_lui        = s_funct3[3] & s_quad[1] & ~s_rdsp & ~s_nzimm6bzr;
    assign s_addi16sp   = s_funct3[3] & s_quad[1] & s_rdsp & ~s_nzimm6bzr;
    assign s_andi       = s_funct3[4] & s_quad[1] & s_instr_i[11:10] == 2'b10;
    assign s_srli       = s_funct3[4] & s_quad[1] & s_instr_i[11:10] == 2'b00;
    assign s_srai       = s_funct3[4] & s_quad[1] & s_instr_i[11:10] == 2'b01;
    assign s_sub        = s_funct3[4] & s_quad[1] & ~s_instr_i[12] & s_instr_i[11:10] == 2'b11 & s_instr_i[6:5] == 2'b00;
    assign s_xor        = s_funct3[4] & s_quad[1] & ~s_instr_i[12] & s_instr_i[11:10] == 2'b11 & s_instr_i[6:5] == 2'b01;
    assign s_or         = s_funct3[4] & s_quad[1] & ~s_instr_i[12] & s_instr_i[11:10] == 2'b11 & s_instr_i[6:5] == 2'b10;
    assign s_and        = s_funct3[4] & s_quad[1] & ~s_instr_i[12] & s_instr_i[11:10] == 2'b11 & s_instr_i[6:5] == 2'b11;
    assign s_j          = s_funct3[5] & s_quad[1];
    assign s_beqz       = s_funct3[6] & s_quad[1];
    assign s_bnez       = s_funct3[7] & s_quad[1];

    //Quadrant 10
    assign s_ebreak     = s_funct3[4] & s_instr_i[12] & s_quad[2] & s_instr_i[11:2] == 10'b0;
    assign s_jr         = s_funct3[4] & ~s_instr_i[12] & s_quad[2] & ~s_rs1zero & s_shamtzr;
    assign s_jalr       = s_funct3[4] & s_instr_i[12] & s_quad[2] & ~s_rs1zero & s_shamtzr;
    assign s_slli       = s_funct3[0] & ~s_instr_i[12] & s_quad[2];
    assign s_add        = s_funct3[4] & s_instr_i[12] & s_quad[2] & ~s_shamtzr;
    assign s_mv         = s_funct3[4] & ~s_instr_i[12] & s_quad[2] & ~s_shamtzr;
    assign s_lwsp       = s_funct3[2] & s_quad[2] & ~s_rs1zero;
    assign s_swsp       = s_funct3[6] & s_quad[2];

    assign s_branch     = s_beqz | s_bnez;
    assign s_jump       = s_jr | s_jalr | s_jal | s_j;
    assign s_load       = s_lw | s_lwsp;
    assign s_store      = s_sw | s_swsp;
    assign s_op         = s_mv | s_add | s_sub | s_xor | s_or | s_and;
    assign s_op_imm     = s_addi | s_addi4spn | s_addi16sp | s_srli | s_srai | s_slli | s_andi | s_li;
    assign s_known      = (s_branch | s_jump | s_load | s_store | s_op | s_op_imm | s_lui | s_ebreak);
    assign s_illegal    = s_illi | (~s_known);

    //Instruction function and RF address selector
    assign s_rs1        = (s_lw | s_sw | s_srli | s_srai | s_andi | s_and | 
                           s_or | s_xor | s_sub | s_beqz | s_bnez) ? {2'b1,s_instr_i[9:7]} : 
                           (s_li | s_mv) ? 5'b0 : (s_lwsp | s_swsp | s_addi4spn) ? 5'b10 : s_instr_i[11:7];
    assign s_rs2        = (s_sw | s_sub | s_xor | s_or | s_and) ? {2'b1,s_instr_i[4:2]} : 
                            (s_beqz | s_bnez) ? 5'b0 : s_instr_i[6:2];
    assign s_rd         = (s_srli | s_srai | s_andi | s_sub | s_xor | s_or | s_and) ? {2'b1,s_instr_i[9:7]} : 
                            (s_lw | s_addi4spn) ? {2'b1,s_instr_i[4:2]} : (s_jal | s_jalr) ? 5'b1 : 
                            (s_jr) ? 5'b0 : s_instr_i[11:7];
    assign s_fun[2:0]   =   (s_slli | s_bnez) ? 3'd1 :
                            (s_beqz | s_load | s_store) ? 3'd2 :
                            (s_jr | s_jalr) ? 3'd3 :
                            (s_xor | s_jal | s_j) ? 3'd4 :
                            (s_srli | s_srai) ? 3'd5 :
                            (s_or) ? 3'd6 :
                            (s_andi | s_and) ? 3'd7 : 3'd0;
    assign s_fun[3]     = (s_beqz | s_bnez | s_sub | s_srai | s_store | s_jr | s_jalr | s_jal | s_j);

    //Immediate value, note that if LSB is defined to be 1'b0, it is not propagated from the ID stage
    assign s_uimm8lwsp  = {s_instr_i[3:2],s_instr_i[12],s_instr_i[6:4],2'b0}; //lwsp
    assign s_uimm8swsp  = {s_instr_i[8:7],s_instr_i[12:9],2'b0}; //swsp
    assign s_uimm10_0   = {2'b0,(s_lwsp) ? s_uimm8lwsp : s_uimm8swsp};

    assign s_uimm10lwsw = {3'b0,s_instr_i[5],s_instr_i[12:10],s_instr_i[6],2'b0}; //lw, sw
    assign s_uimm10adi4 = {s_instr_i[10:7],s_instr_i[12:11],s_instr_i[5],s_instr_i[6],2'b0}; //addi4spn
    assign s_uimm10_1   = (s_addi4spn) ? s_uimm10adi4 : s_uimm10lwsw;

    assign s_uimm       = {10'b0, (s_lwsp | s_swsp) ? s_uimm10_0 : s_uimm10_1};

    assign s_imm12j     = (s_jalr | s_jr) ? 12'b0 : {{2{s_instr_i[12]}},s_instr_i[8],s_instr_i[10:9],s_instr_i[6],s_instr_i[7],s_instr_i[2],s_instr_i[11],s_instr_i[5:3]}; //j, jal
    assign s_imm12b     = {{5{s_instr_i[12]}},s_instr_i[6:5],s_instr_i[2],s_instr_i[11:10],s_instr_i[4:3]}; //beqz, bnez
    assign s_imm12_0    = (s_j | s_jal | s_jalr | s_jr) ? s_imm12j : s_imm12b;

    assign s_imm6       = {s_instr_i[12],s_instr_i[6:2]}; //li, addi, slli, srli, srai, andi
    assign s_imm10      = {s_instr_i[12],s_instr_i[4:3],s_instr_i[5],s_instr_i[2],s_instr_i[6],4'b0}; //addi16sp
    assign s_imm12_1    = (s_addi16sp) ? {{2{s_instr_i[12]}},s_imm10} : {{6{s_instr_i[12]}},s_imm6};

    assign s_imm        = (s_j | s_jal | s_beqz | s_bnez | s_jalr | s_jr) ? {{8{s_imm12_0[11]}},s_imm12_0} : 
                          (s_lui) ? {{14{s_instr_i[12]}},s_imm6} : 
                          (s_ebreak) ? {9'b0,CSR_FUN_EBREAK,9'b0} : {{8{s_instr_i[12]}},s_imm12_1[11:1],s_imm12_1[0]};
    assign s_immediate  = (s_load | s_store | s_addi4spn) ? s_uimm : s_imm;
    
    //Instruction source specifier
    assign s_src_ctrl[SCTRL_RFRP1]  = (s_op | s_op_imm | s_branch | s_jalr | s_jr | s_store | s_load);
    assign s_src_ctrl[SCTRL_RFRP2]  = (s_op | s_branch | s_store);
    assign s_src_ctrl[SCTRL_ZERO1]  = (s_rs1 == 5'b0) | s_li | s_lui;
    assign s_src_ctrl[SCTRL_ZERO2]  = s_rs2 == 5'b0; 

    //Instruction control specifier
    assign s_instr_ctrl[ICTRL_UNIT_ALU] = (s_op | s_op_imm | s_lui);
    assign s_instr_ctrl[ICTRL_UNIT_BRU] = (s_branch | s_jump);
    assign s_instr_ctrl[ICTRL_UNIT_LSU] = (s_load | s_store);
    assign s_instr_ctrl[ICTRL_UNIT_CSR] = (s_ebreak);
    assign s_instr_ctrl[ICTRL_UNIT_MDU] = 1'b0;
    assign s_instr_ctrl[ICTRL_REG_DEST] = (|s_rd) & (s_load | s_jal | s_jalr | s_li | s_lui | s_op_imm | s_op);
    assign s_instr_ctrl[ICTRL_RVC]      = 1'b1;
    //Prediction is not allowed from other instructions than branch/jump
    assign s_pred_not_allowed           = s_prediction_i & (~s_instr_ctrl[ICTRL_UNIT_BRU]);
    assign s_instr_miscon               = s_illegal ? IMISCON_ILLE : s_pred_not_allowed ? IMISCON_DSCR : IMISCON_FREE;

endmodule
