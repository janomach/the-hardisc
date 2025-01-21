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

    input logic[31:0] s_mhrdctrl0_i[PROT_3REP], //settings

    output logic[31:0] s_p1_val_o[PROT_2REP],   //read value from port 1
    output logic[31:0] s_p2_val_o[PROT_2REP]    //read value from port 2
);

    logic[31:0] s_rf_w_val[PROT_2REP], s_rf0_val[2], s_rp2_val[PROT_2REP];
    logic s_rf_we[PROT_2REP], s_clk_rf;
    rf_add s_rf_w_add[PROT_2REP], s_rf0_add[2];

    assign s_p1_val_o[0] = s_rf0_val[0];
    assign s_p2_val_o[0] = s_rf0_val[1];  
    
    assign s_rf0_add[0]  = s_r_p1_add_i[0];
    assign s_rf0_add[1]  = s_r_p2_add_i[0];

`ifdef PROT_PIPE
    rf_add s_rf1_add[2];
    logic[31:0] s_rf1_val[2];

    assign s_p1_val_o[1] = s_rf1_val[0];
    assign s_p2_val_o[1] = s_rf1_val[1];

    assign s_rf1_add[0]  = s_r_p1_add_i[1];
    assign s_rf1_add[1]  = s_r_p2_add_i[1];

    assign s_clk_rf     = s_clk_i[2];
    assign s_resetn_rf  = s_resetn_i[2];

    acm m_acm
    (
	    .s_clk_i(s_clk_i),
        .s_resetn_i(s_resetn_i),

        .s_mawb_val_i(s_mawb_val_i),
        .s_mawb_add_i(s_mawb_add_i),
        .s_mawb_ictrl_i(s_mawb_ictrl_i),

        .s_r_p1_add_i(s_r_p1_add_i),
        .s_r_p2_add_i(s_r_p2_add_i),
        .s_r_p1_val_i(s_p1_val_o),
        .s_r_p2_val_i(s_p2_val_o),

        .s_mhrdctrl0_i(s_mhrdctrl0_i),

        .s_val_o(s_rf_w_val),
        .s_add_o(s_rf_w_add),
        .s_we_o(s_rf_we)
    );

    seu_ff_file #(.LABEL("RFGPR0"),.W(32),.N(32),.RP(2)) m_rf0_gpr 
    (
        .s_c_i(s_clk_i[0]),
        .s_we_i(s_rf_we[0]),
        .s_wa_i(s_rf_w_add[0]),
        .s_d_i(s_rf_w_val[0]),
        .s_ra_i(s_rf0_add),
        .s_q_o(s_rf0_val)
    ); 

    seu_ff_file #(.LABEL("RFGPR1"),.W(32),.N(32),.RP(2)) m_rf1_gpr
    (
        .s_c_i(s_clk_i[1]),
        .s_we_i(s_rf_we[1]),
        .s_wa_i(s_rf_w_add[1]),
        .s_d_i(s_rf_w_val[1]),
        .s_ra_i(s_rf1_add),
        .s_q_o(s_rf1_val)
    );

`else
    assign s_clk_rf     = s_clk_i[0]; 
    //write enable signal for the register file
    assign s_rf_we[0]   = s_mawb_ictrl_i[0][ICTRL_REG_DEST];
    //value to be written to the register file
    assign s_rf_w_val[0]= s_mawb_val_i[0];
    //address for the write port of the register file
    assign s_rf_w_add[0]= s_mawb_add_i[0];

    seu_ff_file #(.LABEL("RFGPR"),.W(32),.N(32),.RP(2)) m_rf0_gpr 
    (
        .s_c_i(s_clk_i[0]),
        .s_we_i(s_rf_we[0]),
        .s_wa_i(s_rf_w_add[0]),
        .s_d_i(s_rf_w_val[0]),
        .s_ra_i(s_rf0_add),
        .s_q_o(s_rf0_val)
    );  
`endif   

endmodule
