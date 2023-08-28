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

module bru (
    input logic s_active_i,             //unit activation
    input f_part s_exma_f_i,            //instruction function
    input logic[31:0] s_exma_val_i,     //result from EX stage
    input logic s_predicted_i,          //indicates prediction made from the instruction
    input logic[30:0] s_bop_tadd_i,     //predicted target address saved in the BOP
    input logic s_bop_pred_i,           //the prediction is prepared in the BOP

    output logic s_toc_o,               //transfer of control
    output logic s_branch_true_o,       //result of branch condition    
    output logic s_bp_update_o,         //update branch predictor
    output logic s_btb_update_o,        //update BTB of branch predictor
    output logic s_jp_update_o,         //update jump predictor
    output logic s_itaken_o,            //instruction takes non-sequential execution
    output logic[31:0] s_target_add_o   //target address for TOC
);
    logic s_bru_branch, s_bru_jump, s_branch_toc, s_jump_toc, s_pred_error, s_branch_active;
    logic[30:0] s_target_add;

    //The ALU saves result of branch condition to the LSB of EXMA value register
    assign s_branch_active  = s_exma_val_i[0];
    //The ALU saves target address to the remaining bits of EXMA value register
    assign s_target_add     = s_exma_val_i[31:1];

    //Prediction error happens if target address is different or BOP does not signalize prediction
    assign s_pred_error     = ((s_bop_tadd_i != s_target_add) | ~s_bop_pred_i) & s_predicted_i & s_active_i;
    //Decodes branches and jumps
    assign s_bru_branch     = s_active_i & (s_exma_f_i != ALU_SET1) & (s_exma_f_i != ALU_IPC);
    assign s_bru_jump       = s_active_i & (s_exma_f_i == ALU_SET1 || s_exma_f_i == ALU_IPC);
    //Evaluates conditions for transfer of control
    assign s_branch_toc     = s_bru_branch & ((s_branch_active & (~s_predicted_i | s_pred_error)) | (~s_branch_active & s_predicted_i));
    assign s_jump_toc       = s_bru_jump & (~s_predicted_i | s_pred_error);

    //The Branch Predictor is updated during each BRANCH instruction
    assign s_bp_update_o    = s_bru_branch;
    //The BTB is updated only during new TOC
    assign s_btb_update_o   = s_branch_toc & (s_branch_active | s_pred_error);
    //The Jump Predictor is updated only during JAL instructions (not JALR)
    assign s_jp_update_o    = s_active_i & (s_exma_f_i == ALU_IPC) & (~s_predicted_i | s_pred_error);

    assign s_itaken_o       = s_bru_jump | (s_bru_branch & s_branch_active);
    assign s_target_add_o   = {s_target_add,1'b0};
    assign s_toc_o          = s_branch_toc | s_jump_toc;
    assign s_branch_true_o  = s_branch_active;

endmodule
