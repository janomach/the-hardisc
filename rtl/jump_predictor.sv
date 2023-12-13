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

module jump_predictor #(
    parameter ENTRIES = 8,              //number of entries in JTB
    parameter SHARED = 8                //count of shared bits
)
(
    input logic s_clk_i,                //clock signal
    input logic s_resetn_i,             //invalidate all entries
    input logic s_invalidate_i,         //invalidate entry
    input logic[30:0] s_fetch_add_i,    //address from which prediction should be made

    input logic s_jump_update_i,        //update jump predictor
    input logic s_ualigc_i,             //executed jump is unaligned RVC instruction
    input logic[19:0] s_jump_offset_i,  //address offset for prediction entry  
    input logic[31:0] s_jump_add_i,     //base address for prediction entry
    
    output logic s_ualigc_o,            //predicted instruction is unaligned RVC
    output logic s_pred_jump_o,         //prediction of jump instruction
    output logic[31:0] s_pred_add_o     //predicted target address
);
    localparam TAG_WIDTH     = $clog2(ENTRIES);
    localparam BASE_WIDTH    = 32 - TAG_WIDTH - 2 - SHARED;
    localparam OFFSET_WIDTH  = 20;
    localparam ENTRY_WIDTH   = 1 + OFFSET_WIDTH + BASE_WIDTH;

    logic[ENTRIES-1:0] s_rjp_valid[1], s_wjp_valid[1]; 
    logic[ENTRIES-1:0] s_valid_sel;
    logic[ENTRY_WIDTH-1:0] s_jtb_wdata, s_jtb_entry[1];
    logic s_jumpp_valid, s_known_address, s_ualigcp;
    logic[TAG_WIDTH-1:0] s_jumpu_index, s_jumpp_index[1];
    logic[31:0] s_target_add;
    logic[30:0] s_tadd;
    logic[BASE_WIDTH-1:0] s_base_addu, s_base_addp;

    seu_regs #(.LABEL("JP_VLD"),.GROUP(SEEGR_PREDICTOR),.W(ENTRIES),.N(1),.NC(1))m_r_jumpv (.s_c_i({s_clk_i}),.s_d_i(s_wjp_valid),.s_d_o(s_rjp_valid));

    seu_regs_file #(.LABEL("JTB"),.GROUP(SEEGR_PREDICTOR),.W(ENTRY_WIDTH),.N(ENTRIES),.RP(1)) m_btb 
    (
        .s_clk_i(s_clk_i),
        .s_we_i(s_jump_update_i),
        .s_wadd_i(s_jumpu_index),
        .s_val_i(s_jtb_wdata),
        .s_radd_i(s_jumpp_index),
        .s_val_o(s_jtb_entry)
    );

    //Prediction
    assign s_jumpp_index[0] = s_fetch_add_i[TAG_WIDTH:1];
    assign s_jumpp_valid    = s_rjp_valid[0][s_jumpp_index[0]];
    assign s_ualigcp        = s_jtb_entry[0][20];
    assign s_base_addp      = s_jtb_entry[0][BASE_WIDTH+20:21];
    assign s_target_add     = {s_tadd,1'b0};
    assign s_known_address  = (s_base_addp == s_fetch_add_i[30-SHARED:TAG_WIDTH+1]);
    /*
        1. The saved address must match the fetched address
        2a. The fetched instruction must be either aligned
        2b. or unaligned but the saved information must indicated unaligned RVC instruction
    */    
    assign s_pred_jump_o    = s_jumpp_valid ? s_known_address & (~s_fetch_add_i[0] | s_ualigcp) : 1'b0;
    assign s_pred_add_o     = s_target_add;
    assign s_ualigc_o       = s_ualigcp;
    
    fast_adder_2 #(.WIDTH(31),.ADDW(20)) m_fa_tadd(.s_base_val_i({s_fetch_add_i[30:1],s_ualigcp}),.s_add_val_i(s_jtb_entry[0][19:0]),.s_val_o(s_tadd)); 

    //Updating
    assign s_jumpu_index    = s_jump_add_i[TAG_WIDTH+1:2];
    assign s_valid_sel      = ({{(ENTRIES-1){1'b0}},1'b1} << s_jumpu_index);
    assign s_base_addu      = s_jump_add_i[31-SHARED:TAG_WIDTH+2];
    assign s_jtb_wdata      = {s_base_addu,s_ualigc_i,s_jump_offset_i};

    //Update of validation bits for entries in JTB
    always_comb begin : jump_update
        if(~s_resetn_i) begin
            s_wjp_valid[0] = {ENTRIES{1'b0}};
        end else if(s_invalidate_i)begin
            s_wjp_valid[0] = ~(~s_rjp_valid[0] | s_valid_sel);
        end else if(s_jump_update_i) begin
            s_wjp_valid[0] = s_rjp_valid[0] | s_valid_sel;
        end else begin
            s_wjp_valid[0] = s_rjp_valid[0];
        end
    end

endmodule
