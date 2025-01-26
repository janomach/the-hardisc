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

module branch_predictor 
#(
    parameter ENTRIES = 16,             //number of entries in BTB
    parameter HENTRIES = 16,            //number of entries in BHT
    parameter SHARED = 8,               //count of shared bits
    parameter RESET_BHT = 0             //reset branch history table
)
(
    input logic s_clk_i,                //clock signal
    input logic s_resetn_i,             //invalidate all entries and reset BHT
    input logic s_invalidate_i,         //invalidate entry
    input logic[30:0] s_fetch_add_i,    //address from which prediction should be made
    
    input logic s_branch_update_i,      //update branch predictor
    input logic s_branch_taken_i,       //executed branch has fulfilled condition
    input logic s_ualigc_i,             //executed branch is unaligned RVC instruction
    input logic s_btb_update_i,         //update BTB
    input logic[11:0] s_branch_offset_i,//address offset for prediction entry
    input logic[31:0] s_branch_add_i,   //base address for prediction entry
    
    output logic s_ualigc_o,            //predicted instruction is unaligned RVC
    output logic s_pred_branch_o,       //prediction of taken branch instruction
    output logic[31:0] s_pred_add_o     //predicted target address
);
    localparam TAG_WIDTH     = $clog2(ENTRIES);
    localparam HTAG_WIDTH    = $clog2(HENTRIES);
    localparam BASE_WIDTH    = 32 - TAG_WIDTH - 2 - SHARED;
    localparam OFFSET_WIDTH  = 12;
    localparam ENTRY_WIDTH   = 1 + OFFSET_WIDTH + BASE_WIDTH;

    logic[ENTRIES-1:0] s_rbp_valid[1], s_wbp_valid[1];  
    logic[ENTRIES-1:0] s_valid_sel;
    logic[ENTRY_WIDTH-1:0] s_btb_wdata, s_btb_entry[1];
    logic[1:0] s_predu, s_update_pred, s_bht_val[2];
    logic s_branchp_valid, s_known_address, s_btb_update, s_ualigcp, s_predp, s_valid_we[1];
    logic[TAG_WIDTH-1:0] s_branchu_index, s_branchp_index[1];
    logic[HTAG_WIDTH-1:0] s_bht_radd[2];
    logic[31:0] s_target_add;
    logic[15:0] s_branchp_off;
    logic[BASE_WIDTH-1:0] s_base_addu, s_base_addp;

    seu_ff_we_rst #(.LABEL("BP_VLD"),.GROUP(SEEGR_PREDICTOR),.W(ENTRIES),.N(1)) m_r_branchv (.s_c_i({s_clk_i}),.s_r_i({s_resetn_i}),.s_we_i(s_valid_we),.s_d_i(s_wbp_valid),.s_q_o(s_rbp_valid));

    seu_ff_file #(.LABEL("BTB"),.GROUP(SEEGR_PREDICTOR),.W(ENTRY_WIDTH),.N(ENTRIES),.RP(1)) m_btb 
    (
        .s_c_i(s_clk_i),
        .s_we_i(s_btb_update),
        .s_wa_i(s_branchu_index),
        .s_d_i(s_btb_wdata),
        .s_ra_i(s_branchp_index),
        .s_q_o(s_btb_entry)
    );
    
    generate
        if(RESET_BHT == 1)begin : bht_sel
            seu_ff_file_rst #(.LABEL("BHT"),.GROUP(SEEGR_PREDICTOR),.W(2),.N(HENTRIES),.RP(2)) m_bht 
            (
                .s_c_i(s_clk_i),
                .s_r_i({s_resetn_i}),
                .s_we_i(s_branch_update_i),
                .s_wa_i(s_bht_radd[1]),
                .s_d_i(s_update_pred),
                .s_ra_i(s_bht_radd),
                .s_q_o(s_bht_val)
            );
        end else begin : bht_sel
            seu_ff_file #(.LABEL("BHT"),.GROUP(SEEGR_PREDICTOR),.W(2),.N(HENTRIES),.RP(2)) m_bht 
            (
                .s_c_i(s_clk_i),
                .s_we_i(s_branch_update_i),
                .s_wa_i(s_bht_radd[1]),
                .s_d_i(s_update_pred),
                .s_ra_i(s_bht_radd),
                .s_q_o(s_bht_val)
            );        
        end
    endgenerate

    //Prediction
    assign s_branchp_index[0]   = s_fetch_add_i[TAG_WIDTH:1];
    assign s_branchp_valid      = s_rbp_valid[0][s_branchp_index[0]];
    //if BHT entry is >= 2'b2 branch is predicted as taken
    assign s_bht_radd[0]        = s_fetch_add_i[HTAG_WIDTH:1];
    assign s_predp              = s_bht_val[0][1];
    assign s_branchp_off        = {{3{s_btb_entry[0][11]}},s_btb_entry[0][11:0],1'b0};
    assign s_ualigcp            = s_btb_entry[0][12];
    assign s_base_addp          = s_btb_entry[0][BASE_WIDTH+12:13];
    assign s_known_address      = (s_base_addp == s_fetch_add_i[30-SHARED:TAG_WIDTH+1]);
    /*
        1. The saved address must match the fetched address
        2. BHT must predicts taken branch
        3a. The fetched instruction must be either aligned
        3b. or unaligned but the saved information must indicated unaligned RVC instruction
    */
    assign s_pred_branch_o  = s_branchp_valid ? (s_known_address & s_predp & (~s_fetch_add_i[0] | s_ualigcp)) : 1'b0;
    assign s_pred_add_o     = s_target_add;
    assign s_ualigc_o       = s_ualigcp;

    fast_adder #(.ADDONLY(0)) m_fa_tadd(.s_base_val_i({s_fetch_add_i[30:1],s_ualigcp,1'b0}),.s_add_val_i(s_branchp_off),.s_val_o(s_target_add)); 

    //Updating
    assign s_branchu_index  = s_branch_add_i[TAG_WIDTH+1:2];
    assign s_valid_sel      = ({{(ENTRIES-1){1'b0}},1'b1} << s_branchu_index);
    assign s_btb_update     = s_branch_update_i & s_btb_update_i;
    assign s_predu          = s_bht_val[1];
    assign s_bht_radd[1]    = s_branch_add_i[HTAG_WIDTH+1:2];
    assign s_base_addu      = s_branch_add_i[31-SHARED:TAG_WIDTH+2];
    assign s_btb_wdata      = {s_base_addu,s_ualigc_i,s_branch_offset_i};

    //New value for BHT entry
    always_comb begin : s_update_prediction
        if(s_branch_taken_i)begin
            if(s_predu == 2'd3) s_update_pred = 2'd3;
            else s_update_pred = s_predu + 2'd1;
        end else begin
            if(s_predu == 2'd0) s_update_pred = 2'd0;
            else s_update_pred = s_predu - 2'd1;
        end
    end
    
    //Update of validation bits for entries in BTB/BHT
    assign s_valid_we[0] = s_invalidate_i || s_btb_update;
    always_comb begin : branch_update
        if(s_invalidate_i) begin
            s_wbp_valid[0] = ~(~s_rbp_valid[0] | s_valid_sel);
        end else begin
            s_wbp_valid[0] = s_rbp_valid[0] | s_valid_sel;
        end
    end

endmodule
