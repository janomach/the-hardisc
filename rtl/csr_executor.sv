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

module csr_executor (
    input logic s_resetn_i,                 //reset signal
    input logic[31:0] s_boot_add_i,         //boot address

    input logic s_stall_i,                  //stall of MA stage
    input logic s_flush_i,                  //flush of MA stage

    input logic s_int_meip_i,               //external interrupt
    input logic s_int_mtip_i,               //timer interrupt
    input logic s_int_msip_i,               //software interrupt
`ifdef PROTECTED
    input logic s_int_uce_i,                //uncorrectable error in register-file
`endif
    input logic s_rstpp_i,                  //pipeline reset
    input logic[31:0] s_newrst_point_i,     //new reset-point address
    input logic s_interrupted_i,            //interrupt approval
    input logic s_exception_i,              //exception condition
    input logic[4:0] s_exc_code_i,          //code of exception condition

    input logic s_valid_instr_i,            //valid instruction in MA stage
    input ictrl s_ictrl_i,                  //instruction control indicator
    input f_part s_function_i,              //instruction function
    input logic[31:0] s_payload_i,          //instruction payload information
    input logic[31:0] s_val_i,              //result from EX stage
    input logic[31:0] s_mcsr_i[0:MAX_MCSR], //values of CSR registers

    output logic s_int_pending_o,           //pending interrupt
    output logic[31:0] s_exc_trap_o,        //exception trap-handler address
    output logic[31:0] s_int_trap_o,        //interrupt trap-handler address
    output logic s_mret_o,                  //return from machine trap-handler
    output logic[31:0] s_csr_r_val_o,       //value read from requested CSR
    output logic[31:0] s_mcsr_o[0:MAX_MCSR] //new values for CSR registers
);
    logic[31:0] s_mcsr_r_val, s_read_val, s_csr_w_val,s_int_vectored, s_exc_trap, s_int_trap, s_write_val;
    logic s_machine_csr, s_write_machine, s_csr_op, s_uadd_00, s_uadd_10, s_mret, s_exc_active, s_int_exc, 
            s_mtval_zero, s_interrupt, s_int_pending, s_execute;
    logic[63:0] s_mcycle_counter, s_minstret_counter;
    logic[4:0] s_int_code;
    logic[5:0]s_int_vector;
    logic s_max_reached;

    assign s_int_pending_o  = s_int_pending;
    assign s_int_trap_o     = s_int_trap;
    assign s_exc_trap_o     = s_exc_trap;
    assign s_csr_r_val_o    = s_read_val;
    assign s_mret_o         = s_mret;

    //CSR instruction processing
    assign s_machine_csr    = (s_payload_i[6] & s_payload_i[5]);
    assign s_uadd_00        = ~(s_payload_i[8] | s_payload_i[7]);
    assign s_uadd_10        = (s_payload_i[8] & ~s_payload_i[7]);
    assign s_csr_op         = |s_function_i[1:0] & s_ictrl_i[ICTRL_UNIT_CSR] & s_valid_instr_i & ~s_flush_i;
    assign s_write_machine  = s_csr_op & s_machine_csr;
    assign s_mret           = s_uadd_00 & s_machine_csr & s_payload_i[9] & (s_function_i[2:0] == 3'b000) & s_ictrl_i[ICTRL_UNIT_CSR];
    assign s_execute        = s_valid_instr_i & ~s_stall_i & ~s_flush_i;

    //Interrupt and exception evaluation
    assign s_interrupt      = |(s_mcsr_i[MCSR_IE] & s_mcsr_i[MCSR_IP]) & s_mcsr_i[MCSR_STATUS][3];
    assign s_exc_active     = s_exception_i & s_valid_instr_i & ~s_interrupted_i;
    assign s_int_exc        = s_interrupted_i | (s_exception_i & s_valid_instr_i);
    assign s_int_pending    = s_interrupt;
    assign s_mtval_zero     = (s_exc_code_i != EXC_MISALIGI_VAL) & 
                              (s_exc_code_i != EXC_LADD_MISS_VAL) & 
                              (s_exc_code_i != EXC_SADD_MISS_VAL) & s_exc_active;
    assign s_int_code       = (s_mcsr_i[MCSR_IE][11] & s_mcsr_i[MCSR_IP][11]) ? INT_MEI_VAL : 
                              (s_mcsr_i[MCSR_IE][3] & s_mcsr_i[MCSR_IP][3]) ? INT_MSI_VAL : INT_MTI_VAL;
    assign s_int_vector     = (s_mcsr_i[MCSR_IE][11] & s_mcsr_i[MCSR_IP][11]) ? 6'd44 : 
                              (s_mcsr_i[MCSR_IE][3] & s_mcsr_i[MCSR_IP][3]) ? 6'd12 : 6'd28;
    assign s_exc_trap       = {s_mcsr_i[MCSR_TVEC][31:2],2'b0};
    assign s_int_trap       = (s_mcsr_i[MCSR_TVEC][0]) ? s_int_vectored : s_exc_trap;
    fast_adder m_int_vector(.s_base_val_i(s_exc_trap),.s_add_val_i({10'b0,s_int_vector} ),.s_val_o(s_int_vectored));

    //Machine counters
    fast_adder #(.WIDTH(64)) m_mcycle_cntr(.s_base_val_i({s_mcsr_i[MCSR_CYCLEH],s_mcsr_i[MCSR_CYCLE]}),.s_add_val_i(32'd1),.s_val_o(s_mcycle_counter));
    fast_adder #(.WIDTH(64)) m_mistret_cntr(.s_base_val_i({s_mcsr_i[MCSR_INSTRETH],s_mcsr_i[MCSR_INSTRET]}),.s_add_val_i(32'd1),.s_val_o(s_minstret_counter));    

    //Read of CSR registers
    always_comb begin : machine_csr_read_value
        case (s_payload_i[3:0])
            MCSR_STATUS:     s_mcsr_r_val = s_mcsr_i[MCSR_STATUS];
            MCSR_IE:         s_mcsr_r_val = s_mcsr_i[MCSR_IE];
            MCSR_TVEC:       s_mcsr_r_val = s_mcsr_i[MCSR_TVEC];
            MCSR_EPC:        s_mcsr_r_val = s_mcsr_i[MCSR_EPC];
            MCSR_CAUSE:      s_mcsr_r_val = s_mcsr_i[MCSR_CAUSE];
            MCSR_TVAL:       s_mcsr_r_val = s_mcsr_i[MCSR_TVAL];
            MCSR_IP:         s_mcsr_r_val = s_mcsr_i[MCSR_IP];
            MCSR_CYCLE:      s_mcsr_r_val = s_mcsr_i[MCSR_CYCLE];
            MCSR_CYCLEH:     s_mcsr_r_val = s_mcsr_i[MCSR_CYCLEH];
            MCSR_INSTRET:    s_mcsr_r_val = s_mcsr_i[MCSR_INSTRET];
            MCSR_INSTRETH:   s_mcsr_r_val = s_mcsr_i[MCSR_INSTRETH];
            MCSR_SCRATCH:    s_mcsr_r_val = s_mcsr_i[MCSR_SCRATCH];
            MCSR_HARTID:     s_mcsr_r_val = s_mcsr_i[MCSR_HARTID];
            MCSR_HRDCTRL0:   s_mcsr_r_val = s_mcsr_i[MCSR_HRDCTRL0];
            MCSR_ISA:        s_mcsr_r_val = s_mcsr_i[MCSR_ISA];
            default:         s_mcsr_r_val = 32'b0;
        endcase   
    end

    //Only M-mode is present
    assign s_read_val  = s_mcsr_r_val;
    //Selection of write value - based on type of CSR instruction
    assign s_write_val  = s_function_i[2] ? {27'b0,s_payload_i[15:11]} : s_val_i;

    //Select new value for selected CSR register
    always_comb begin : csr_modify_value
        case (s_function_i[1:0])
            CSR_RW:     s_csr_w_val = s_write_val;
            CSR_RS:     s_csr_w_val = s_write_val | s_read_val;
            CSR_RC:     s_csr_w_val = ~s_write_val & s_read_val;
            default:    s_csr_w_val = s_read_val;
        endcase
    end

    /*  Parallel update of individual CSR registers */

    always_comb begin : mstatus_writer
        if(~s_resetn_i)begin
            s_mcsr_o[MCSR_STATUS]       = 32'b0;
        end else if(s_int_exc)begin
            s_mcsr_o[MCSR_STATUS][31:8] = s_mcsr_i[MCSR_STATUS][31:8];
            s_mcsr_o[MCSR_STATUS][7]    = s_mcsr_i[MCSR_STATUS][3];
            s_mcsr_o[MCSR_STATUS][6:4]  = s_mcsr_i[MCSR_STATUS][6:4];
            s_mcsr_o[MCSR_STATUS][3]    = 1'b0;
            s_mcsr_o[MCSR_STATUS][2:0]  = s_mcsr_i[MCSR_STATUS][2:0];
        end else if(s_mret & s_execute)begin
            s_mcsr_o[MCSR_STATUS][31:8] = s_mcsr_i[MCSR_STATUS][31:8];
            s_mcsr_o[MCSR_STATUS][7]    = 1'b1;
            s_mcsr_o[MCSR_STATUS][6:4]  = s_mcsr_i[MCSR_STATUS][6:4];
            s_mcsr_o[MCSR_STATUS][3]    = s_mcsr_i[MCSR_STATUS][7];
            s_mcsr_o[MCSR_STATUS][2:0]  = s_mcsr_i[MCSR_STATUS][2:0];
        end else if (s_write_machine & (s_payload_i[3:0] == MCSR_STATUS) & s_uadd_00) begin
            s_mcsr_o[MCSR_STATUS][31]   = 1'b0;             //---
            s_mcsr_o[MCSR_STATUS][30:23]= 8'b0;             //WPRI
            s_mcsr_o[MCSR_STATUS][22:13]= 10'b0;            //---
            s_mcsr_o[MCSR_STATUS][12:11]= 2'b11;            //previou priviledge mode (only M now)
            s_mcsr_o[MCSR_STATUS][10:9] = 2'b0;             //WPRI
            s_mcsr_o[MCSR_STATUS][8]    = 1'b0;             //---
            s_mcsr_o[MCSR_STATUS][7]    = s_csr_w_val[7];   //MPIE
            s_mcsr_o[MCSR_STATUS][6]    = 1'b0;             //WPRI
            s_mcsr_o[MCSR_STATUS][5]    = 1'b0;             //---
            s_mcsr_o[MCSR_STATUS][4]    = 1'b0;             //---
            s_mcsr_o[MCSR_STATUS][3]    = s_csr_w_val[3];   //MIE
            s_mcsr_o[MCSR_STATUS][2]    = 1'b0;             //WPRI
            s_mcsr_o[MCSR_STATUS][1]    = 1'b0;             //---
            s_mcsr_o[MCSR_STATUS][0]    = 1'b0;             //---
        end else begin
            s_mcsr_o[MCSR_STATUS]       = s_mcsr_i[MCSR_STATUS];
        end
    end

    always_comb begin : mscratch_writer
        if(~s_resetn_i)begin
            s_mcsr_o[MCSR_SCRATCH]  = 32'b0;
        end else if (s_write_machine & (s_payload_i[3:0] == MCSR_SCRATCH) & s_uadd_00) begin
            s_mcsr_o[MCSR_SCRATCH]  = s_csr_w_val;
        end else begin
            s_mcsr_o[MCSR_SCRATCH]  = s_mcsr_i[MCSR_SCRATCH];
        end
    end

    always_comb begin : mcycle_writer
        if(~s_resetn_i)begin
            s_mcsr_o[MCSR_CYCLE]    = 32'b0;
        end else if (s_write_machine & (s_payload_i[3:0] == MCSR_CYCLE) & s_uadd_10) begin
            s_mcsr_o[MCSR_CYCLE]    = s_csr_w_val;
        end else begin
            s_mcsr_o[MCSR_CYCLE]    = s_mcycle_counter[31:0];
        end
    end
    always_comb begin : mcycleh_writer
        if(~s_resetn_i)begin
            s_mcsr_o[MCSR_CYCLEH]   = 32'b0;
        end else if (s_write_machine & (s_payload_i[3:0] == MCSR_CYCLEH) & s_uadd_10) begin
            s_mcsr_o[MCSR_CYCLEH]   = s_csr_w_val;
        end else begin
            s_mcsr_o[MCSR_CYCLEH]   = s_mcycle_counter[63:32];
        end
    end
    always_comb begin : minstret_writer
        if(~s_resetn_i)begin
            s_mcsr_o[MCSR_INSTRET]    = 32'b0;
        end else if (s_write_machine & (s_payload_i[3:0] == MCSR_INSTRET) & s_uadd_10) begin
            s_mcsr_o[MCSR_INSTRET]    = s_csr_w_val;
        end else if(s_execute) begin
            s_mcsr_o[MCSR_INSTRET]    = s_minstret_counter[31:0];
        end else begin
            s_mcsr_o[MCSR_INSTRET]    = s_mcsr_i[MCSR_INSTRET];
        end
    end
    always_comb begin : minstreth_writer
        if(~s_resetn_i)begin
            s_mcsr_o[MCSR_INSTRETH]   = 32'b0;
        end else if (s_write_machine & (s_payload_i[3:0] == MCSR_INSTRETH) & s_uadd_10) begin
            s_mcsr_o[MCSR_INSTRETH]   = s_csr_w_val;
        end else if(s_execute) begin
            s_mcsr_o[MCSR_INSTRETH]    = s_minstret_counter[63:32];
        end else begin
            s_mcsr_o[MCSR_INSTRETH]    = s_mcsr_i[MCSR_INSTRETH];
        end
    end
    always_comb begin : mtvec_writer
        if(~s_resetn_i)begin
            s_mcsr_o[MCSR_TVEC]         = 32'b0;
        end else if (s_write_machine & (s_payload_i[3:0] == MCSR_TVEC) & s_uadd_00) begin
            s_mcsr_o[MCSR_TVEC][31:2]   = s_csr_w_val[31:2];
            s_mcsr_o[MCSR_TVEC][1]      = 1'b0;
            s_mcsr_o[MCSR_TVEC][0]      = s_csr_w_val[0];
        end else begin
            s_mcsr_o[MCSR_TVEC]         = s_mcsr_i[MCSR_TVEC];
        end
    end
    always_comb begin : mepc_writer
        if(~s_resetn_i)begin
            s_mcsr_o[MCSR_EPC]   = 32'b0;
        end else if(s_int_exc) begin
            s_mcsr_o[MCSR_EPC]   = s_mcsr_i[MCSR_RSTPOINT];
        end else if (s_write_machine & (s_payload_i[3:0] == MCSR_EPC) & s_uadd_00) begin
            s_mcsr_o[MCSR_EPC]   = s_csr_w_val;
        end else begin
            s_mcsr_o[MCSR_EPC]   = s_mcsr_i[MCSR_EPC];
        end
    end    
    always_comb begin : mcause_writer
        if(~s_resetn_i)begin
            s_mcsr_o[MCSR_CAUSE]   = 32'b0;
        end else if(s_int_exc) begin
            s_mcsr_o[MCSR_CAUSE]   = {s_interrupted_i,26'b0,(s_interrupted_i) ? s_int_code : s_exc_code_i};//s_exc_val;
        end else if (s_write_machine & (s_payload_i[3:0] == MCSR_CAUSE) & s_uadd_00) begin
            s_mcsr_o[MCSR_CAUSE]   = s_csr_w_val;
        end else begin
            s_mcsr_o[MCSR_CAUSE] = s_mcsr_i[MCSR_CAUSE];
        end
    end
    always_comb begin : mtval_writer
        if(~s_resetn_i | s_mtval_zero)begin
            s_mcsr_o[MCSR_TVAL]   = 32'b0;
        end else if(s_exc_active) begin
            s_mcsr_o[MCSR_TVAL]   = s_payload_i;
        end else if (s_write_machine & (s_payload_i[3:0] == MCSR_TVAL) & s_uadd_00) begin
            s_mcsr_o[MCSR_TVAL]   = s_csr_w_val;
        end else begin
            s_mcsr_o[MCSR_TVAL] = s_mcsr_i[MCSR_TVAL];
        end
    end  

    always_comb begin : mip_writer
        s_mcsr_o[MCSR_IP][31:13] = 19'b0;
        if(~s_resetn_i)begin
            s_mcsr_o[MCSR_IP][12:0]   = 13'b0;
        end else if (s_write_machine & (s_payload_i[3:0] == MCSR_IP) & s_uadd_00) begin
`ifdef PROTECTED
            s_mcsr_o[MCSR_IP][12]     = s_int_uce_i | s_csr_w_val[12];
`else
            s_mcsr_o[MCSR_IP][12]     = 1'b0;
`endif
            s_mcsr_o[MCSR_IP][11]     = s_int_meip_i;
            s_mcsr_o[MCSR_IP][10:8]   = 3'b0;
            s_mcsr_o[MCSR_IP][7]      = s_int_mtip_i;
            s_mcsr_o[MCSR_IP][6:4]    = 3'b0;
            s_mcsr_o[MCSR_IP][3]      = s_int_msip_i;
            s_mcsr_o[MCSR_IP][2:0]    = 3'b0;
        end else begin
`ifdef PROTECTED
            s_mcsr_o[MCSR_IP][12]     = s_int_uce_i;
`else
            s_mcsr_o[MCSR_IP][12]     = 1'b0;
`endif
            s_mcsr_o[MCSR_IP][11]     = s_int_meip_i;
            s_mcsr_o[MCSR_IP][10:8]   = 3'b0;
            s_mcsr_o[MCSR_IP][7]      = s_int_mtip_i;
            s_mcsr_o[MCSR_IP][6:4]    = 3'b0;
            s_mcsr_o[MCSR_IP][3]      = s_int_msip_i;
            s_mcsr_o[MCSR_IP][2:0]    = 3'b0;
        end
    end  

    always_comb begin : mie_writer
        s_mcsr_o[MCSR_IE][31:13] = 19'h0;
        if(~s_resetn_i)begin
            s_mcsr_o[MCSR_IE][12:0] = 13'h0;
        end else if (s_write_machine & (s_payload_i[3:0] == MCSR_IE) & s_uadd_00) begin
            s_mcsr_o[MCSR_IE][12:11]=  s_csr_w_val[12:11];
            s_mcsr_o[MCSR_IE][10:8] =  3'b0;
            s_mcsr_o[MCSR_IE][7]    =  s_csr_w_val[7];
            s_mcsr_o[MCSR_IE][6:4]  =  3'b0;
            s_mcsr_o[MCSR_IE][3]    =  s_csr_w_val[3];
            s_mcsr_o[MCSR_IE][2:0]  =  3'b0;
        end else begin
            s_mcsr_o[MCSR_IE][12:0] = s_mcsr_i[MCSR_IE][12:0];
        end
    end

    //Signalize reaching of maximum number of consecutive restarts
    assign s_max_reached = s_mcsr_i[MCSR_HRDCTRL0][19:16] == s_mcsr_i[MCSR_HRDCTRL0][11:8];

    always_comb begin : mrhdctrl0_writer
        if(~s_resetn_i)begin
            s_mcsr_o[MCSR_HRDCTRL0][31:21]  = 11'b0;    //reserved
            s_mcsr_o[MCSR_HRDCTRL0][20]     = 1'b0;     //the restart counter not counting
            s_mcsr_o[MCSR_HRDCTRL0][19:16]  = 4'b0;     //the restart counter - reserved
            s_mcsr_o[MCSR_HRDCTRL0][15:12]  = 4'b0;     //reserved
            s_mcsr_o[MCSR_HRDCTRL0][11:8]   = 4'd10;    //maximum number of consecutive restarts is 10d
            s_mcsr_o[MCSR_HRDCTRL0][7:6]    = 2'b00;    //reserved
            s_mcsr_o[MCSR_HRDCTRL0][5:4]    = 2'b01;    //acm settings
            s_mcsr_o[MCSR_HRDCTRL0][3]      = 1'b0;     //enable predictor
            s_mcsr_o[MCSR_HRDCTRL0][2]      = 1'b0;     //max consecutive restarts not reached
            s_mcsr_o[MCSR_HRDCTRL0][1]      = 1'b1;     //after the max number of consecutive restarts, try to disable the predictor at first
            s_mcsr_o[MCSR_HRDCTRL0][0]      = 1'b1;     //enable monitoring of consecutive restarts
        end else if (s_write_machine & (s_payload_i[3:0] == MCSR_HRDCTRL0) & (s_payload_i[8:7] == 2'b01)) begin
            s_mcsr_o[MCSR_HRDCTRL0][31:21]  = 11'b0;                //reserved
            s_mcsr_o[MCSR_HRDCTRL0][20:16]  = s_csr_w_val[20:16];
            s_mcsr_o[MCSR_HRDCTRL0][15:12]  = 4'b0;                 //reserved
            s_mcsr_o[MCSR_HRDCTRL0][11:8]   = s_csr_w_val[11:8];
            s_mcsr_o[MCSR_HRDCTRL0][7:6]    = 2'b00;                //reserved
            s_mcsr_o[MCSR_HRDCTRL0][5:0]    = s_csr_w_val[5:0];
        end else begin
            if(s_valid_instr_i)begin
                //stop counting
                s_mcsr_o[MCSR_HRDCTRL0][20] = 1'b0;
            end else if(s_rstpp_i)begin
                //start/countinue counting
                s_mcsr_o[MCSR_HRDCTRL0][20] = 1'b1;
            end else begin
                s_mcsr_o[MCSR_HRDCTRL0][20] = s_mcsr_i[MCSR_HRDCTRL0][20];
            end
            if(s_valid_instr_i | (s_mcsr_i[MCSR_HRDCTRL0][20] & s_mcsr_i[MCSR_HRDCTRL0][1] & ~s_mcsr_i[MCSR_HRDCTRL0][3] & s_max_reached))begin
                //reset counter on valid instruction, or at a try to disable the predictor
                s_mcsr_o[MCSR_HRDCTRL0][19:16] = 4'b0;
            end else if(s_mcsr_i[MCSR_HRDCTRL0][20] & (s_mcsr_i[MCSR_HRDCTRL0][19:16] != s_mcsr_i[MCSR_HRDCTRL0][11:8]) & s_rstpp_i)begin
                //continue counting until the maximum number of restarts is reached
                s_mcsr_o[MCSR_HRDCTRL0][19:16] = s_mcsr_i[MCSR_HRDCTRL0][19:16] + 4'b1;
            end else begin
                s_mcsr_o[MCSR_HRDCTRL0][19:16] = s_mcsr_i[MCSR_HRDCTRL0][19:16];
            end
            if(s_mcsr_i[MCSR_HRDCTRL0][20] & s_mcsr_i[MCSR_HRDCTRL0][1] & s_max_reached)begin
                //try to disable the predictor at first
                s_mcsr_o[MCSR_HRDCTRL0][3] = 1'b1;
            end else begin
                s_mcsr_o[MCSR_HRDCTRL0][3] = s_mcsr_i[MCSR_HRDCTRL0][3];
            end
            if(s_valid_instr_i)begin
                //signalize normal operation / recovery
                s_mcsr_o[MCSR_HRDCTRL0][2] = 1'b0;
            end else if(s_mcsr_i[MCSR_HRDCTRL0][20] & s_mcsr_i[MCSR_HRDCTRL0][0] & (s_mcsr_i[MCSR_HRDCTRL0][3] | ~s_mcsr_i[MCSR_HRDCTRL0][1]) & s_max_reached)begin
                //signalize lock-up / unrecoverable error
                s_mcsr_o[MCSR_HRDCTRL0][2] = 1'b1;
            end else begin
                s_mcsr_o[MCSR_HRDCTRL0][2] = s_mcsr_i[MCSR_HRDCTRL0][2];
            end

            s_mcsr_o[MCSR_HRDCTRL0][1:0]    = s_mcsr_i[MCSR_HRDCTRL0][1:0];
            s_mcsr_o[MCSR_HRDCTRL0][15:4]   = s_mcsr_i[MCSR_HRDCTRL0][15:4];
            s_mcsr_o[MCSR_HRDCTRL0][31:21]  = s_mcsr_i[MCSR_HRDCTRL0][31:21];
        end
    end

    //Reset point
    always_comb begin : rst_point
        if(~s_resetn_i)begin
            s_mcsr_o[MCSR_RSTPOINT] = s_boot_add_i;
        end else if((s_valid_instr_i & ~s_stall_i) | s_interrupted_i)begin
            s_mcsr_o[MCSR_RSTPOINT] = s_newrst_point_i;
        end else begin
            s_mcsr_o[MCSR_RSTPOINT] = s_mcsr_i[MCSR_RSTPOINT];
        end
    end

endmodule
