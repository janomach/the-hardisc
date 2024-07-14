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

module aligner (
    input logic s_clk_i,            //clock signal
    input logic s_resetn_i,         //reset signal
    input logic s_flush_i,          //flush signal
    input logic s_stall_i,          //stall signals from upper stages
    output logic s_stall_o,         //signalize stalling to the FE stage

    input logic[4:0] s_info_i,      //instruction payload from IFB
    input logic[31:0] s_instr_i,    //instruction from IFB
    input logic[1:0] s_pred_i,      //prediction information from IFB

    output logic s_aerr_o,          //alignment error condition
    output logic[2:0] s_ferr_o,          //aligned fetch error 
    output logic s_nop_o,           //no operation
    output logic[31:0] s_instr_o,   //aligned instruction
    output logic s_pred_o           //prediction was perfomed from the aligned instruction
);
    /*  Aligner
        The core is able to execute the 32-bit (RVI) and also the 16-bit (RVC) instructions. They are saved
        in the memory back-to-back so an alignment/extraction of single instruction is necessary before
        decoding. The instructions come to the Aligner from IFB, but it can pull either full entry or none.
        If the data contains part of two instruction, the Aligner can save one part and its payload
        information into the internal registers. It can also signalize to the IFB, that it cannot process 
        another instruction. */
    logic[3:0] s_info;
    logic[31:0] s_instr;
    logic s_pred;
    logic s_saved_is_rvc, s_saved_is_valid, s_input_is_valid, s_lp_is_valid, s_lp_is_rvc, s_hp_is_rvc;

    logic[3:0] s_wsvd_info[1], s_rsvd_info[1];
    logic[15:0] s_wsvd_instr[1], s_rsvd_instr[1];
    logic s_wsvd_pred[1], s_rsvd_pred[1];
    logic[2:0]s_err;
    logic[1:0] s_stall;

    //Saved instruction information
    seu_ff_rst #(.LABEL("ALNR_INFO"),.N(1),.W(4),.RSTVAL(2'b01)) m_svd_info(.s_c_i({s_clk_i}),.s_r_i({s_resetn_i}),.s_d_i(s_wsvd_info),.s_q_o(s_rsvd_info));
    //Saved half of the instruction
    seu_ff #(.LABEL("ALNR_INSTR"),.N(1),.W(16)) m_svd_instr(.s_c_i({s_clk_i}),.s_d_i(s_wsvd_instr),.s_q_o(s_rsvd_instr));
    //Saved information that prediction was perfomed from the instruction 
    seu_ff #(.LABEL("ALNR_PRED"),.N(1),.W(1)) m_svd_pred(.s_c_i({s_clk_i}),.s_d_i(s_wsvd_pred),.s_q_o(s_rsvd_pred));

    //Aligned instruction and information
    assign s_stall_o    = s_stall[0] | s_stall[1];
    assign s_aerr_o     = s_err[0] | s_err[1] | s_err[2];
    assign s_ferr_o     = s_info[3:1];
    assign s_nop_o      = s_info[0];
    assign s_instr_o    = s_instr;
    assign s_pred_o     = s_pred;

    //Stall conditions -> include optimizations A nad B
    assign s_stall[0]   = s_saved_is_rvc & s_saved_is_valid & s_lp_is_valid & ~((s_pred_i == 2'b01) & s_lp_is_rvc);
    assign s_stall[1]   = s_stall_i & (s_lp_is_valid | s_saved_is_valid);

    //Error conditions
    assign s_err[0]     = (s_saved_is_valid & ~s_saved_is_rvc & s_input_is_valid & s_rsvd_pred[0]);
    assign s_err[1]     = (~s_saved_is_valid & s_input_is_valid & s_lp_is_valid & ~s_lp_is_rvc & s_pred_i[1]);
    assign s_err[2]     = (~s_saved_is_valid & s_input_is_valid & ~s_lp_is_valid & s_pred_i[0]);

    //Auxiliary signals
    assign s_saved_is_valid = ~s_rsvd_info[0][0];
    assign s_input_is_valid = ~s_info_i[0];
    assign s_lp_is_valid    = ~s_info_i[1];
    assign s_lp_is_rvc      = s_instr_i[1:0] != 2'b11;
    assign s_hp_is_rvc      = s_instr_i[17:16] != 2'b11;
    assign s_saved_is_rvc   = s_rsvd_instr[0][1:0] != 2'b11;
    
    //Update of internal registers
    always_comb begin : aligner_regs
        if(s_flush_i)begin
            //Flush or clears internal registers
            s_wsvd_info[0]  = 2'b01;
            s_wsvd_instr[0] = 16'b0;
            s_wsvd_pred[0]  = 1'b0;
        end else if(s_stall_i & (~s_input_is_valid | s_lp_is_valid | s_saved_is_valid)) begin
            //Preserve data if stall is signalized from upper stages and the internal registers are occupied
            //Optimization A: save unaligned instruction, if stall is signalized and internal registers are not occupied
            s_wsvd_info[0]  = s_rsvd_info[0];
            s_wsvd_instr[0] = s_rsvd_instr[0];
            s_wsvd_pred[0]  = s_rsvd_pred[0];
        end else begin
            if(s_saved_is_valid)begin
                if(s_saved_is_rvc)begin                   
                    if(s_input_is_valid & ~s_lp_is_valid)begin
                        //Save unaligned instruction and merge both prediction attributes
                        //Note: this can happen if a jump to unaligned instruction was made
                        s_wsvd_instr[0] = s_instr_i[31:16];
                        s_wsvd_info[0]  = {s_info_i[4:2],1'b0};
                        s_wsvd_pred[0]  = s_pred_i[1] | s_pred_i[0];
                    end else if(s_input_is_valid & s_lp_is_rvc & (s_pred_i == 2'b01))begin
                        /* Optimization B: even though the IFB outputs valid 32-bit data, 
                           save only the first part (RVC instruction), because prediction 
                           was made from it. The second part will be jumped over. */
                        s_wsvd_instr[0] = s_instr_i[15:0];
                        s_wsvd_info[0]  = {s_info_i[4:2],1'b0};
                        s_wsvd_pred[0]  = 1'b1;
                    end else begin
                        //Nothing to save
                        s_wsvd_instr[0] = 16'b0;
                        s_wsvd_info[0]  = 4'b0001;
                        s_wsvd_pred[0]  = 1'b0;
                    end
                end else begin
                    //Expected second half of unaligned RVI
                    if(s_input_is_valid) begin
                        //Save unaligned part
                        s_wsvd_instr[0][15:0] = s_instr_i[31:16];
                        if(s_pred_i[0])begin
                            //Nothing to save, becasue prediction was made from the second half of unaligned RVI
                            s_wsvd_info[0]      = 4'b0001;
                            s_wsvd_pred[0]      = 1'b0;
                        end else begin
                            //Save unaligned part
                            s_wsvd_info[0]      = {s_info_i[4:2],1'b0};
                            s_wsvd_pred[0]      = s_pred_i[1];
                        end
                    end else begin
                        //No data available yet, preserve content of the internal registers
                        s_wsvd_info[0]  = s_rsvd_info[0];
                        s_wsvd_instr[0] = s_rsvd_instr[0];
                        s_wsvd_pred[0]  = s_rsvd_pred[0];
                    end
                end
            end else begin
                /*  Save unaligned data if:
                    a) Aligned RVC instruction goes directly to the output, and prediction was not made from it
                    b) Only unaligned RVI (first half) is on input
                    c) Optimization A: if stall is signalized and internal registers are not occupied */
                if(s_input_is_valid & ((s_lp_is_valid & s_lp_is_rvc & ~s_pred_i[0]) | (~s_lp_is_valid & (~s_hp_is_rvc | s_stall_i)))) begin
                    s_wsvd_info[0]  = {s_info_i[4:2],1'b0};
                    s_wsvd_instr[0] = s_instr_i[31:16];
                    s_wsvd_pred[0]  = s_pred_i[1] | s_pred_i[0];
                end else begin
                    //Nothing to save
                    s_wsvd_info[0]  = 4'b0001;
                    s_wsvd_instr[0] = 16'b0;
                    s_wsvd_pred[0]  = 1'b0;
                end
            end   
        end 
    end

    //Output selection
    always_comb begin : aligner_outputs
        if(s_saved_is_valid)begin
            s_instr     = {s_instr_i[15:0],s_rsvd_instr[0][15:0]};
            if(s_saved_is_rvc)begin
                //Output saved RVC
                s_info  = s_rsvd_info[0][3:0];
                s_pred  = s_rsvd_pred[0];
            end else begin
                if(s_input_is_valid) begin
                    //Unaligned RVI, report information with higher prority
                    s_info[3:1] = ((s_info_i[4:2] != FETCH_VALID) 
`ifdef PROT_INTF                    
                                 & (s_info_i[4:2] != FETCH_INCER)
`endif
                                  ) ? s_info_i[4:2] : s_rsvd_info[0][3:1];
                    s_info[0]   = s_rsvd_info[0][0];
                    s_pred      = s_pred_i[0];
                end else begin
                    //Nothing to output
                    s_info  = 4'b0001;
                    s_pred  = 1'b0;
                end
            end
        end else begin
            //Propagate instruction directly to the output
            s_instr[15:0]   = s_lp_is_valid ? s_instr_i[15:0] : s_instr_i[31:16];
            s_instr[31:16]  = s_instr_i[31:16];
            if(s_input_is_valid) begin
                s_info[3:1] = s_info_i[4:2];
                if(s_lp_is_valid)begin
                    s_info[0]   = 1'b0;
                    s_pred      = s_pred_i[0];
                end else begin
                    s_pred      = s_pred_i[1];
                    if(s_hp_is_rvc)begin
                        s_info[0]   = 1'b0;
                    end else begin
                        s_info[0]   = 1'b1;
                    end
                end
            end else begin
                s_info      = 4'b0001;
                s_pred      = 1'b0;
            end
        end   
    end 

endmodule
