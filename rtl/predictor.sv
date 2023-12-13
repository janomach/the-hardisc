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

module predictor 
(
    input logic s_clk_i,                //clock signal
    input logic s_resetn_i,             //reset signal
    input logic s_invalidate_i,         //invalidate entry
    input logic[30:0] s_fetch_add_i,    //address from which prediction should be made

    input logic s_instr_rvc_i,          //executed instruction is RVC
    input logic s_btb_update_i,         //update BTB
    input logic s_branch_update_i,      //update branch predictor
    input logic s_branch_taken_i,       //executed branch has fulfilled condition
    input logic s_jump_update_i,        //update jump predictor
    input logic[19:0] s_offset_i,       //address offset for prediction
    input logic[31:0] s_base_add_i,     //base address for prediction
    
    output logic[1:0] s_pred_taken_o,   //[0]([1]) - predicted TOC from aligned (unaligned) part of the fetched address
    output logic[31:0] s_pred_add_o     //predicted target address
);
    logic[1:0] s_pred_taken[1], s_pred_taken_see[1];
    logic s_jp_taken, s_bp_taken, s_predictor;
    logic s_taken_align, s_taken_ualign;
    logic[31:0] s_bp_tadd, s_jp_tadd, s_pred_add[1], s_pred_add_see[1], s_base_add, s_basep2_add, s_offm2, s_offsetu, s_offset;
    logic s_ualig;
    logic s_jp_ualigc, s_bp_ualigc;

    assign s_pred_add_o     = s_pred_add_see[0];
    assign s_pred_taken_o   = s_pred_taken_see[0];

    see_wires #(.LABEL("PRED_ADD"),.GROUP(SEEGR_CORE_WIRE),.W(32))  see_pred_add(.s_c_i(s_clk_i),.s_d_i(s_pred_add),.s_d_o(s_pred_add_see));
    see_wires #(.LABEL("PRED_TAKEN"),.GROUP(SEEGR_CORE_WIRE),.W(2)) see_pred_taken(.s_c_i(s_clk_i),.s_d_i(s_pred_taken),.s_d_o(s_pred_taken_see));

    //Prediction
    assign s_predictor      = s_bp_taken & (~s_bp_ualigc | ~s_jp_taken);
    assign s_taken_align    = (s_jp_taken ? ~s_jp_ualigc : 1'b0) | (s_bp_taken ? ~s_bp_ualigc : 1'b0);
    assign s_taken_ualign   = ~s_taken_align & ((s_jp_taken ? s_jp_ualigc : 1'b0) | (s_bp_taken ? s_bp_ualigc : 1'b0));
    assign s_pred_add[0]    = (s_predictor) ? s_bp_tadd : s_jp_tadd;
    assign s_pred_taken[0]  = {s_taken_ualign,s_taken_align};

    //Updating
    /* 
        Prediction cannot be made from the unaligned part of unaligned RVI instruction. 
        The reason is, that the fetch of instruction is always from the aligned address.
        Predicting, from the unaligned part, would cause that upper part of the TOC instruction (blt in the example) will not be fetched.
        Example:    0x1000  c.addi x10, 4
                    0x1002  blt x10, x11, 0x36
                    0x1006  sw x12, 0x4(x13)
        The solution is to predict TOC from the aligned part (s_base_add_i + 2) of address (0x1004 in the example).
        If such incrementation is perfomed, the saved address offset must be decremented accordingly (0x34 in the example)
    */
    assign s_base_add       = (~s_instr_rvc_i & s_base_add_i[1]) ? s_basep2_add : s_base_add_i;
    assign s_ualig          = s_instr_rvc_i & s_base_add_i[1];
    assign s_offset         = {{11{s_offset_i[19]}},s_offset_i,1'b0};
    assign s_offsetu        = (~s_instr_rvc_i & s_base_add_i[1]) ? s_offm2 : s_offset;

    fast_adder m_pred_badd(.s_base_val_i(s_base_add_i),.s_add_val_i(16'd2),.s_val_o(s_basep2_add)); 
    fast_adder #(.ADDONLY(0)) m_pred_offu(.s_base_val_i(s_offset),.s_add_val_i(16'hFFFE),.s_val_o(s_offm2)); 

    branch_predictor #(.ENTRIES(`OPTION_BTB_SIZE),.HENTRIES(`OPTION_BHT_SIZE),.SHARED(`OPTION_SHARED)) m_bp
    (
        .s_clk_i(s_clk_i),
        .s_resetn_i(s_resetn_i),
        .s_invalidate_i(s_invalidate_i),
        .s_fetch_add_i(s_fetch_add_i),
        .s_ualigc_i(s_ualig),

        .s_btb_update_i(s_btb_update_i),
        .s_branch_offset_i(s_offsetu[12:1]),
        .s_branch_taken_i(s_branch_taken_i),
        .s_branch_add_i(s_base_add),
        .s_branch_update_i(s_branch_update_i),
        
        .s_ualigc_o(s_bp_ualigc),
        .s_pred_branch_o(s_bp_taken),
        .s_pred_add_o(s_bp_tadd)
    );

    jump_predictor #(.ENTRIES(`OPTION_JTB_SIZE),.SHARED(`OPTION_SHARED)) m_jp 
    (
        .s_clk_i(s_clk_i),
        .s_resetn_i(s_resetn_i),
        .s_invalidate_i(s_invalidate_i),
        .s_fetch_add_i(s_fetch_add_i),
        .s_ualigc_i(s_ualig),

        .s_jump_offset_i(s_offsetu[20:1]),
        .s_jump_add_i(s_base_add),
        .s_jump_update_i(s_jump_update_i),
        
        .s_ualigc_o(s_jp_ualigc),
        .s_pred_jump_o(s_jp_taken),
        .s_pred_add_o(s_jp_tadd)
    );

endmodule
