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

module rf_controller
(
	input logic s_clk_i[PROT_3REP],             //clock signal
    input logic s_resetn_i[PROT_3REP],          //reset signal

    input logic[31:0] s_mawb_val_i[PROT_3REP],  //instruction result from WB stage
    input rf_add s_mawb_add_i[PROT_3REP],       //destination register address from WB stage
    input ictrl s_mawb_ictrl_i[PROT_3REP],      //instruction control indicator from WB stage

    input rf_add s_r_p1_add_i[PROT_2REP],       //read port 1 address
    input rf_add s_r_p2_add_i[PROT_2REP],       //read port 2 address

`ifdef PROTECTED
    input rf_add s_exma_add_i[PROT_3REP],       //destination register address from MA stage
    input ictrl s_exma_ictrl_i[PROT_3REP],      //instruction control indicator from MA stage
    input rf_add s_opex_add_i[PROT_2REP],       //destination register address from EX stage
    input ictrl s_opex_ictrl_i[PROT_2REP],      //instruction control indicator from EX stage
    output logic[1:0] s_uce_o[PROT_2REP],       //uncorrectable error
    output logic[1:0] s_ce_o[PROT_2REP],        //correctable error
`endif
    output logic[31:0] s_p1_val_o,              //read value from port 1
    output logic[31:0] s_p2_val_o               //read value from port 2
);

    logic[31:0] s_rf_w_val, s_rp_val[2];
    logic s_rf_we, s_clk_rf;
    rf_add s_rf_w_add, s_rp_add[2];

    assign s_p1_val_o   = s_rp_val[0];
    assign s_p2_val_o   = s_rp_val[1];  
    
    assign s_rp_add[0]  = s_r_p1_add_i[0];
    assign s_rp_add[1]  = s_r_p2_add_i[0];

`ifdef PROTECTED

    assign s_clk_rf     = s_clk_i[2];

    acm m_acm
    (
	    .s_clk_i(s_clk_i),
        .s_resetn_i(s_resetn_i),

        .s_mawb_val_i(s_mawb_val_i),
        .s_mawb_add_i(s_mawb_add_i),
        .s_mawb_ictrl_i(s_mawb_ictrl_i),
        .s_exma_add_i(s_exma_add_i),
        .s_exma_ictrl_i(s_exma_ictrl_i),
        .s_opex_add_i(s_opex_add_i),
        .s_opex_ictrl_i(s_opex_ictrl_i),

        .s_r_p1_add_i(s_r_p1_add_i),
        .s_r_p2_add_i(s_r_p2_add_i),
        .s_r_p1_val_i(s_rp_val[0]),
        .s_r_p2_val_i(s_rp_val[1]),

        .s_uce_o(s_uce_o),
        .s_ce_o(s_ce_o),

        .s_val_o(s_rf_w_val),
        .s_add_o(s_rf_w_add),
        .s_we_o(s_rf_we)
    );

`else
    assign s_clk_rf     = s_clk_i[0]; 
    //write enable signal for the register file
    assign s_rf_we      = s_mawb_ictrl_i[0][ICTRL_REG_DEST];
    //value to be written to the register file
    assign s_rf_w_val   = s_mawb_val_i[0];
    //address for the write port of the register file
    assign s_rf_w_add   = s_mawb_add_i[0];
`endif

    seu_regs_file #(.LABEL("RFGPR"),.W(32),.N(32),.RP(2)) m_rfgpr 
    (
        .s_clk_i(s_clk_rf),
        .s_we_i(s_rf_we),
        .s_wadd_i(s_rf_w_add),
        .s_val_i(s_rf_w_val),
        .s_radd_i(s_rp_add),
        .s_val_o(s_rp_val)
    );

endmodule
