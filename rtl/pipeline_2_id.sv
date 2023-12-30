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

module pipeline_2_id (
    input logic s_clk_i[PROT_3REP],                 //clock signal
    input logic s_resetn_i[PROT_3REP],              //reset signal

    input logic[4:0] s_stall_i[PROT_3REP],          //stall signals from upper stages
    input logic s_flush_i[PROT_3REP],               //flush signal from MA stage
    output logic s_stall_o[PROT_3REP],              //signalize stalling to the FE stage
`ifdef PROTECTED
    input logic[1:0] s_acm_settings_i,              //acm settings
`endif
    input logic[4:0] s_feid_info_i[PROT_2REP],      //instruction payload information
    input logic[31:0] s_feid_instr_i[PROT_2REP],    //instruction to execute
    input logic[1:0] s_feid_pred_i[PROT_2REP],      //instruction prediction information

    output logic[20:0] s_idop_payload_o[PROT_2REP], //payload information for OP stage
    output f_part s_idop_f_o[PROT_2REP],            //instruction function for OP stage
    output rf_add s_idop_rd_o[PROT_2REP],           //destination register address for OP stage
    output rf_add s_idop_rs1_o[PROT_2REP],          //source register 1 address for OP stage
    output rf_add s_idop_rs2_o[PROT_2REP],          //source register 2 address for OP stage
    output sctrl s_idop_sctrl_o[PROT_2REP],         //source control indicator for OP stage
    output ictrl s_idop_ictrl_o[PROT_2REP],         //instruction control indicator for OP stage
    output imiscon s_idop_imiscon_o[PROT_2REP]      //instruction misconduct indicator for OP stage
);

    logic[20:0] s_widop_payload[PROT_2REP], s_ridop_payload[PROT_2REP];
    f_part s_widop_f[PROT_2REP],s_ridop_f[PROT_2REP]; 
    rf_add s_widop_rd[PROT_2REP], s_ridop_rd[PROT_2REP], 
            s_widop_rs1[PROT_2REP], s_ridop_rs1[PROT_2REP], 
            s_widop_rs2[PROT_2REP], s_ridop_rs2[PROT_2REP]; 
    sctrl s_widop_sctrl[PROT_2REP],s_ridop_sctrl[PROT_2REP];
    ictrl s_widop_ictrl[PROT_2REP],s_ridop_ictrl[PROT_2REP];
    imiscon s_widop_imiscon[PROT_2REP],s_ridop_imiscon[PROT_2REP];
    logic s_clk_prw[PROT_2REP], s_resetn_prw[PROT_2REP];

    assign s_idop_rd_o      = s_ridop_rd;
    assign s_idop_rs1_o     = s_ridop_rs1;
    assign s_idop_rs2_o     = s_ridop_rs2;
    assign s_idop_payload_o = s_ridop_payload;
    assign s_idop_f_o       = s_ridop_f;
    assign s_idop_sctrl_o   = s_ridop_sctrl;
    assign s_idop_ictrl_o   = s_ridop_ictrl;
    assign s_idop_imiscon_o = s_ridop_imiscon;

    //Instruction payload information
    seu_regs #(.LABEL("IDOP_PYLD"),.W(21),.N(PROT_2REP))m_idop_payload (.s_c_i(s_clk_prw),.s_d_i(s_widop_payload),.s_d_o(s_ridop_payload));
    //Destination register address
    seu_regs #(.LABEL("IDOP_RD"),.W($size(rf_add)),.N(PROT_2REP)) m_idop_rd (.s_c_i(s_clk_prw),.s_d_i(s_widop_rd),.s_d_o(s_ridop_rd));
    //Source register 1 address 
    seu_regs #(.LABEL("IDOP_RS1"),.W($size(rf_add)),.N(PROT_2REP)) m_idop_rs1 (.s_c_i(s_clk_prw),.s_d_i(s_widop_rs1),.s_d_o(s_ridop_rs1));
    //Source register 2 address 
    seu_regs #(.LABEL("IDOP_RS2"),.W($size(rf_add)),.N(PROT_2REP)) m_idop_rs2 (.s_c_i(s_clk_prw),.s_d_i(s_widop_rs2),.s_d_o(s_ridop_rs2));
    //Instruction function information
    seu_regs #(.LABEL("IDOP_F"),.W($size(f_part)),.N(PROT_2REP)) m_idop_f (.s_c_i(s_clk_prw),.s_d_i(s_widop_f),.s_d_o(s_ridop_f));
    //Source control indicator
    seu_regs #(.LABEL("IDOP_SCTRL"),.W($size(sctrl)),.N(PROT_2REP)) m_idop_sctrl (.s_c_i(s_clk_prw),.s_d_i(s_widop_sctrl),.s_d_o(s_ridop_sctrl));
    //Instruction control indicator
    seu_regs #(.LABEL("IDOP_ICTRL"),.W($size(ictrl)),.N(PROT_2REP)) m_idop_ictrl (.s_c_i(s_clk_prw),.s_d_i(s_widop_ictrl),.s_d_o(s_ridop_ictrl));
    //Instruction misconduct indicator
    seu_regs #(.LABEL("IDOP_IMISCON"),.W($size(imiscon)),.N(PROT_2REP)) m_idop_imiscon (.s_c_i(s_clk_prw),.s_d_i(s_widop_imiscon),.s_d_o(s_ridop_imiscon));

	logic  s_flush_id[PROT_3REP], s_stall_id[PROT_3REP];
    logic[31:0] s_aligner_instr[PROT_2REP];
    logic[20:0] s_payload[PROT_2REP];
    rf_add s_rs1[PROT_2REP], s_rs2[PROT_2REP], s_rd[PROT_2REP];
    f_part s_f[PROT_2REP];
    sctrl s_src_ctrl[PROT_2REP];
    ictrl s_instr_ctrl[PROT_2REP];
    imiscon s_instr_miscon[PROT_2REP];
    logic s_aligner_stall[PROT_2REP], s_align_error[PROT_2REP], 
          s_aligner_nop[PROT_2REP], s_aligner_pred[PROT_2REP], s_idop_empty[PROT_2REP];
    logic [2:0] s_fetch_error[PROT_2REP];
`ifdef PROTECTED
    rf_add r_acm_add, r_acm_new_add;
    logic s_acm_add_update;
    logic s_seu_search_enabled;
    logic[1:0]s_op_free_rp[2],s_id_free_rp[2], s_seufix_top;
`endif

    genvar i;
    generate  
        for (i = 0; i<PROT_3REP ; i++ ) begin : id_pc_replicator
            //Stall is valid, only if IDOP registers contains executable instruction
            assign s_stall_id[i]   = (|s_stall_i[i][PIPE_MA:PIPE_OP]) & ~s_idop_empty[i%2];
            assign s_stall_o[i]    = s_aligner_stall[i%2];
            assign s_flush_id[i]   = s_flush_i[i];      
        end

        for (i = 0; i<PROT_2REP ; i++ ) begin : id_replicator
            assign s_clk_prw[i]    = s_clk_i[i];
            assign s_resetn_prw[i] = s_resetn_i[i];
            
            //Instruction alignment 
            aligner m_aligner
            (
                .s_clk_i(s_clk_i[i]),
                .s_resetn_i(s_resetn_i[i]),
                .s_stall_i(s_stall_id[i]),
                .s_stall_o(s_aligner_stall[i]),
                .s_flush_i(s_flush_id[i]),

                .s_info_i(s_feid_info_i[i]),
                .s_instr_i(s_feid_instr_i[i]),
                .s_pred_i(s_feid_pred_i[i]),

                .s_aerr_o(s_align_error[i]),
                .s_ferr_o(s_fetch_error[i]),
                .s_nop_o(s_aligner_nop[i]),
                .s_instr_o(s_aligner_instr[i]),
                .s_pred_o(s_aligner_pred[i])
            );      

            //Instruction decoding
            decoder m_decoder
            (
                .s_fetch_error_i(s_fetch_error[i]),
                .s_align_error_i(s_align_error[i]),
                .s_instr_i(s_aligner_instr[i]),
                .s_prediction_i(s_aligner_pred[i]),
                .s_rs1_o(s_rs1[i]),
                .s_rs2_o(s_rs2[i]),
                .s_rd_o(s_rd[i]),
                .s_payload_o(s_payload[i]),
                .s_f_o(s_f[i]),
                .s_sctrl_o(s_src_ctrl[i]),
                .s_ictrl_o(s_instr_ctrl[i]),
                .s_imiscon_o(s_instr_miscon[i])
            );

            //Indicates empty OP stage, so the IDOP register do not hold executable instruction
            assign s_idop_empty[i]  = (s_ridop_ictrl[i] == 8'b0) & (s_ridop_imiscon[i] == 3'b0);

            //Update values for IDOP registers
            always_comb begin : pipe_2_writer
                if(~s_resetn_i[i] | s_flush_id[i] | (s_aligner_nop[i] & ~s_stall_id[i]))begin
                    //Default during reset, flush, or if the Aligner's output is not valid (and ID stage not stalled)
                    s_widop_f[i]        = 4'b0;
                    s_widop_payload[i]  = 21'b0;
                    s_widop_rd[i]       = 5'b0;
                    s_widop_sctrl[i]    = 4'b0; 
                    s_widop_ictrl[i]    = 7'b0;
                    s_widop_imiscon[i]  = IMISCON_FREE; 
                end else if(s_stall_id[i])begin
                    s_widop_f[i]        = s_ridop_f[i];
                    s_widop_payload[i]  = s_ridop_payload[i];
                    s_widop_rd[i]       = s_ridop_rd[i];
                    s_widop_sctrl[i]    = s_ridop_sctrl[i];
                    s_widop_ictrl[i]    = s_ridop_ictrl[i];
                    s_widop_imiscon[i]  = s_ridop_imiscon[i];
                end else begin
                    s_widop_f[i]        = s_f[i];
                    s_widop_payload[i]  = s_payload[i];
                    s_widop_rd[i]       = s_rd[i];
                    s_widop_sctrl[i]    = s_src_ctrl[i];
                    s_widop_ictrl[i]    = s_instr_ctrl[i];
                    s_widop_imiscon[i]  = s_instr_miscon[i];
                end
            end

`ifndef PROTECTED
            //Update values for IDOP read-address registers
            always_comb begin : pipe_2_writer_1
                if(~s_resetn_i[i] | s_flush_id[i])begin
                    s_widop_rs1[i]  = 5'b0;
                    s_widop_rs2[i]  = 5'b0;  
                end else if(s_stall_id[i])begin 
                    s_widop_rs1[i]  = s_ridop_rs1[i];
                    s_widop_rs2[i]  = s_ridop_rs2[i];
                end else begin
                    s_widop_rs1[i]  = s_rs1[i];
                    s_widop_rs2[i]  = s_rs2[i];
                end
            end
`else
            /*  Automatic Correction Mechanism - read-address preparation */

            //The decoded instruction will not need read port 1 in the OP stage
            assign s_id_free_rp[i][0]   = (s_src_ctrl[i][SCTRL_ZERO1] | ~s_src_ctrl[i][SCTRL_RFRP1]);
            //The decoded instruction will not need read port 2 in the OP stage
            assign s_id_free_rp[i][1]   = (s_src_ctrl[i][SCTRL_ZERO2] | ~s_src_ctrl[i][SCTRL_RFRP2]);
            //The instruction in OP stage does not need read port 1
            assign s_op_free_rp[i][0]   = (s_ridop_sctrl[i][SCTRL_ZERO1] | ~s_ridop_sctrl[i][SCTRL_RFRP1]);
            //The instruction in OP stage does not need read port 1
            assign s_op_free_rp[i][1]   = (s_ridop_sctrl[i][SCTRL_ZERO2] | ~s_ridop_sctrl[i][SCTRL_RFRP2]);

            //Update values for IDOP read-address registers
            always_comb begin : pipe_2_writer_1
                if(~s_resetn_i[i] | s_flush_id[i] | (s_aligner_nop[i] & ~s_stall_id[i]))begin
                    s_widop_rs1[i]  = r_acm_add;
                    s_widop_rs2[i]  = r_acm_add;  
                end else if(s_stall_id[i])begin 
                    s_widop_rs1[i]  = (s_op_free_rp[i][0] & s_seu_search_enabled) ? r_acm_add : s_ridop_rs1[i];
                    s_widop_rs2[i]  = (s_op_free_rp[i][1] & s_seu_search_enabled) ? r_acm_add : s_ridop_rs2[i];
                end else begin
                    s_widop_rs1[i]  = (s_id_free_rp[i][0] & s_seu_search_enabled) ? r_acm_add : s_rs1[i];
                    s_widop_rs2[i]  = (s_id_free_rp[i][1] & s_seu_search_enabled) ? r_acm_add : s_rs2[i];
                end
            end
`endif
        end
    endgenerate

`ifdef PROTECTED
    /*  Automatic Correction Mechanism - read-address preparation */

    //The HRDCTRL register enables pro-active search of the register file 
    assign s_seu_search_enabled = s_acm_settings_i != 2'b0;
    //Increment the ACM's search address
    assign s_acm_add_update     =   (~s_stall_id[0] & ((s_id_free_rp[0] != 2'b00) | s_aligner_nop[0])) | 
                                     (s_stall_id[0] &  (s_op_free_rp[0] != 2'b00));

    //New value for ACM search address
    always_comb begin
        if(r_acm_add != 5'd31) begin
            r_acm_new_add = r_acm_add + 5'b1;
        end else begin
            r_acm_new_add = 5'd1;
        end
    end

    //Update ACM search address
    always_ff @( posedge s_clk_i[0] ) begin
        if(~s_resetn_i[0])begin
            r_acm_add <= 5'h01;
        end else if(s_flush_id[0] | s_acm_add_update)begin
            r_acm_add <= r_acm_new_add;
        end else begin
            r_acm_add <= r_acm_add;
        end
    end
`endif

endmodule
