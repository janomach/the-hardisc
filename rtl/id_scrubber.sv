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

// Read-Port Address Scrubbing module for the ID stage (PROT_PIPE)
module id_scrubber (
    input logic s_clk_i,                               //clock signal
    input logic s_resetn_i,                            //reset signal

    input logic[31:0] s_mhrdctrl0_i,                   //settings
    input logic s_stall_id_i[PROT_2REP],               //stall signals
    input logic s_flush_id_i[PROT_2REP],               //flush signals
    input logic[1:0] s_id_free_rp_i[PROT_2REP],       //free read-port indicators from ID stage
    input logic s_aligner_nop_i[PROT_2REP],            //NOP indicator from aligner
    input rf_add s_rs1_i[PROT_2REP],                   //source register 1 address from decoder
    input rf_add s_rs2_i[PROT_2REP],                   //source register 2 address from decoder
    input sctrl s_ridop_sctrl_i[PROT_2REP],            //source control from IDOP register
    input imiscon s_ridop_imiscon_i[PROT_2REP],        //misconduct indicator from IDOP register

    output logic s_acm_restart_o,                      //pipeline restart signal
    output logic s_idop_we_rs1_o[PROT_2REP],           //write enable for IDOP rs1 register
    output logic s_idop_we_rs2_o[PROT_2REP],           //write enable for IDOP rs2 register
    output rf_add s_widop_rs1_o[PROT_2REP],            //write data for IDOP rs1 register
    output rf_add s_widop_rs2_o[PROT_2REP]             //write data for IDOP rs2 register
);

    rf_add s_widop_acmadd[1], s_ridop_acmadd[1];
    logic[5:0] s_widop_acmcnt[1], s_ridop_acmcnt[1];
    //ACM address register
    seu_ff_rst #(.LABEL("IDOP_ACMADD"),.W($size(rf_add)),.N(1),.RSTVAL(5'd1)) m_idop_acmadd (.s_c_i({s_clk_i}),.s_r_i({s_resetn_i}),.s_d_i(s_widop_acmadd),.s_q_o(s_ridop_acmadd));
    //ACM counter register
    seu_ff_rst #(.LABEL("IDOP_ACMCNT"),.W(6),.N(1),.RSTVAL(6'd0)) m_idop_acmcnt (.s_c_i({s_clk_i}),.s_r_i({s_resetn_i}),.s_d_i(s_widop_acmcnt),.s_q_o(s_ridop_acmcnt));

    logic s_acmadd_update, s_acmadd_enable;
    logic[1:0] s_op_free_rp[PROT_2REP];
    logic s_idop_we_aux[PROT_2REP];

    //The HRDCTRL register enables pro-active search of the register file
    assign s_acmadd_enable = s_mhrdctrl0_i[5];
    //Increment the ACM's search address
    assign s_acmadd_update = s_stall_id_i[0] ? (s_op_free_rp[0] != 2'b00) : ((s_id_free_rp_i[0] != 2'b00) | s_aligner_nop_i[0]);
    //Artificial insertion of pipeline restart, if ACM counter cannot increment for more than 7 clock cycles
    assign s_acm_restart_o = (s_ridop_acmcnt[0][3:0] == 4'b1111) && (s_mhrdctrl0_i[5:4] == 2'b11);

    generate
        for (genvar i = 0; i < PROT_2REP; i++) begin : scrubber_replicator
            //Write-enable signals for auxiliary IDOP registers
            assign s_idop_we_aux[i] = !(s_flush_id_i[i] || s_stall_id_i[i] || s_aligner_nop_i[i]);

            //The instruction in OP stage does not need read port 1
            assign s_op_free_rp[i][0] = (s_ridop_sctrl_i[i].zero1 | ~s_ridop_sctrl_i[i].rfrp1 | (s_ridop_imiscon_i[i] == IMISCON_DSCR));
            //The instruction in OP stage does not need read port 2
            assign s_op_free_rp[i][1] = (s_ridop_sctrl_i[i].zero2 | ~s_ridop_sctrl_i[i].rfrp2 | (s_ridop_imiscon_i[i] == IMISCON_DSCR));

            //Update values for IDOP read-address registers
            always_comb begin : rsx_we_add_en
                if(s_acmadd_enable)begin
                    s_idop_we_rs1_o[i] = ~s_aligner_nop_i[i] && ~(s_id_free_rp_i[i][0] && s_id_free_rp_i[i][1]);
                    s_idop_we_rs2_o[i] = 1'b1;
                    if(s_flush_id_i[i])begin
                        s_idop_we_rs1_o[i] = 1'b0;
                    end else if(s_stall_id_i[i])begin
                        s_idop_we_rs1_o[i] = s_op_free_rp[i][0] && ~s_op_free_rp[i][1];
                        s_idop_we_rs2_o[i] = s_op_free_rp[i][1];
                    end
                end else begin
                    s_idop_we_rs1_o[i] = s_idop_we_aux[i] && ~s_id_free_rp_i[i][0];
                    s_idop_we_rs2_o[i] = s_idop_we_aux[i] && ~s_id_free_rp_i[i][1];
                end
            end

            always_comb begin : pipe_2_writer_1
                s_widop_rs1_o[i] = s_ridop_acmadd[0];
                s_widop_rs2_o[i] = s_ridop_acmadd[0];
                if(~s_flush_id_i[i] & ~s_stall_id_i[i] & ~s_aligner_nop_i[i])begin
                    if(~s_id_free_rp_i[i][0])
                        s_widop_rs1_o[i] = s_rs1_i[i];
                    if(~s_id_free_rp_i[i][1])
                        s_widop_rs2_o[i] = s_rs2_i[i];
                end
            end
        end
    endgenerate

    //Update ACM search address
    always_comb begin
        //Enabled from Level 2
        s_widop_acmadd[0] = s_ridop_acmadd[0];
        if(s_acmadd_enable)begin
            if(s_flush_id_i[0] | s_acmadd_update)begin
                if(s_ridop_acmadd[0] != 5'd31) begin
                    s_widop_acmadd[0] = s_ridop_acmadd[0] + 5'b1;
                end else begin
                    s_widop_acmadd[0] = 5'd1;
                end
            end
        end
        //Enabled from Level 3
        s_widop_acmcnt[0] = s_ridop_acmcnt[0];
        if(s_mhrdctrl0_i[5:4] == 2'b11)begin
            s_widop_acmcnt[0][3:0] = s_ridop_acmcnt[0][3:0] + 4'd1;
            if(s_flush_id_i[0] | s_acmadd_update)begin
                s_widop_acmcnt[0][5:4] = s_ridop_acmcnt[0][5:4] + 2'd1;
                if(s_ridop_acmcnt[0][5:4] == 2'b11)begin
                    s_widop_acmcnt[0][3:0] = 4'b0;
                end
            end
            if(s_ridop_acmcnt[0][3:0] == 4'b1111)begin
                s_widop_acmcnt[0][5:4] = 2'b0;
            end
        end
    end

endmodule
