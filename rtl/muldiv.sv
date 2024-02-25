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
`include "settings.sv"

module muldiv (
    input logic s_clk_i,            //clock signal
    input logic s_resetn_i,         //reset signal
    input logic s_stall_i,          //stall signal from MA stage
    input logic s_flush_i,          //flush signal from MA stage
    input logic s_compute_i,        //indicates instruction to process
    input f_part s_function_i,      //instruction function
    input logic[31:0] s_operand1_i, //operand 1
    input logic[31:0] s_operand2_i, //operand 2
    output logic s_finished_o,      //indicates end of computation
    output logic[31:0] s_result_o   //result
);
    /*
        DIV: operand1 is DIVIDEND, operand2 is DIVISOR
        MUL: 
    */
    logic[64:0] s_wproduct[1], s_rproduct[1];
    logic[5:0] s_wcounter[1], s_rcounter[1], s_mul_shift;
    logic s_rchngsign[1], s_wchngsign[1];
    logic[31:0] s_roperand[1], s_woperand[1];

    seu_ff_we #(.LABEL("MD_RPROD"),.W(65),.N(1)) m_seu_rproduct(.s_c_i({s_clk_i}),.s_we_i({s_compute_i}),.s_d_i(s_wproduct),.s_q_o(s_rproduct));
    seu_ff_rst #(.LABEL("MD_RCNTR"),.W(6),.N(1),.RSTVAL(6'h3f)) m_seu_rcounter(.s_c_i({s_clk_i}),.s_r_i({s_resetn_i}),.s_d_i(s_wcounter),.s_q_o(s_rcounter));
    seu_ff_we #(.LABEL("MD_RCHS"),.W(1),.N(1)) m_seu_rchngsign(.s_c_i({s_clk_i}),.s_we_i({s_compute_i}),.s_d_i(s_wchngsign),.s_q_o(s_rchngsign));
    seu_ff_we #(.LABEL("MD_ROPER"),.W(32),.N(1)) m_seu_roperand(.s_c_i({s_clk_i}),.s_we_i({s_compute_i}),.s_d_i(s_woperand),.s_q_o(s_roperand));

    logic s_lower_part;
    logic[1:0]s_change_sign;
    logic s_div_change_sign, s_mul_change_sign;
    logic[63:0] s_mul_result, s_div_result, s_result;
    logic[31:0] s_op1_rev, s_op2_rev, s_operand1, s_operand2;
    logic s_direct_result, s_op2_zero, s_op2_mone, s_op1_pzero, s_sovrflw, s_not_started, s_counter_zero, s_signed_op0, s_signed_op1;
    logic[64:0] s_zero_result, s_sovrflw_res, s_fastfwd_result;
    logic[63:0] s_result_rev;
    logic[32:0] s_adder;
    logic[31:0] s_remaining, s_rem_rev, s_quotient, s_multiplier;
    logic[32:0] s_mulop[3];
    logic[33:0] s_mulres;
    logic s_zero;
    logic[32:0] s_initval;
    
    //Operands with changed sign
    fast_increment m_fa_op1(.s_base_val_i(~s_operand1_i),.s_val_o(s_op1_rev));
    fast_increment m_fa_op2(.s_base_val_i(~s_operand2_i),.s_val_o(s_op2_rev));

    //Instruction treats operand 2 signed
    assign s_signed_op1     = (s_function_i[2:0] == 3'b000) | (s_function_i[2:0] == 3'b001) | 
                              (s_function_i[2:0] == 3'b100) | (s_function_i[2:0] == 3'b110);
    //Instruction treats operand 1 signed
    assign s_signed_op0     = (s_function_i[2:0] == 3'b010) | s_signed_op1;
    //Indicates that signed operands should be changed to have positive value
    assign s_change_sign[0] = (s_signed_op0 & s_operand1_i[31]);
    assign s_change_sign[1] = (s_signed_op1 & s_operand2_i[31]);
    /*  Selection of positive/negative value of operandss.
        Multiplicator can count only with positive numbers. If both operands have 
        different signs, the sign of the result is inverted. Diviver is based
        on decrementation, so the DIVISOR's sign is set to be negative. */
    assign s_operand1       = (s_change_sign[0]) ? s_op1_rev : s_operand1_i;
    assign s_operand2       = ((s_change_sign[1] & ~s_function_i[2]) | (s_function_i[2] & ~s_change_sign[1])) ? s_op2_rev : s_operand2_i;
    /*  Indicates that the final result should change the sign. The sign Multiplier's 
        result is changed if the input operands had different signs. The same situation
        is for the Divider if a product of division is requested. If the instruction 
        requires the remainder of the division, the sign of the remainder is set to the
        sign of the input DIVIDENT. */
    assign s_mul_change_sign= (s_change_sign[1] ^ s_change_sign[0]);
    assign s_div_change_sign= ((s_change_sign[1] ^ s_change_sign[0]) & s_lower_part) | (s_change_sign[0] & ~s_lower_part);

    //Check for direct results (in the next clock cycle)
    assign s_op2_mone       = s_operand2_i == 32'hFFFFFFFF;
    assign s_op2_zero       = s_operand2_i == 32'h00000000;
    assign s_op1_pzero      = s_operand1_i[30:0] == 31'h00000000;
    //Result of divison by zero is defined to be 32'hFFFFFFFF + DIVIDEND(r)
    assign s_zero_result    = (s_function_i[2] & s_op2_zero) ? {s_operand1_i,1'b0,32'hFFFFFFFF} : 65'b0;
    //The sign overflow happens for -(2^31)/(-1) -> the result is defined to be: -(2^31) + 0(r)
    assign s_sovrflw        = ((s_function_i[2:0] == 3'b100) | (s_function_i[2:0] == 3'b110)) & s_operand1_i[31] & s_op1_pzero & s_op2_mone;
    assign s_sovrflw_res    = {33'b0,32'h80000000};
    //gathering of direct results
    assign s_direct_result  = (~s_operand1_i[31] & s_op1_pzero) | s_op2_zero | s_sovrflw;

    //Auxiliary signals
    assign s_lower_part     = (s_function_i[2:0] == 3'b000) | (s_function_i[2:0] == 3'b100) | (s_function_i[2:0] == 3'b101);
    assign s_not_started    = s_rcounter[0] == 6'b111111;
    assign s_counter_zero   = s_rcounter[0] == 6'b000000;

    //Results with changed sign
    fast_adder #(.WIDTH(64)) m_fa_res(.s_base_val_i(~s_rproduct[0][63:0]),.s_add_val_i(32'b1),.s_val_o(s_result_rev));
    fast_adder #(.WIDTH(32)) m_fa_rem(.s_base_val_i(~s_rproduct[0][64:33]),.s_add_val_i(16'b1),.s_val_o(s_rem_rev));

    //Result Selection
    assign s_mul_result     = (s_rchngsign[0]) ? s_result_rev : s_rproduct[0][63:0];
    assign s_remaining      = (s_rchngsign[0]) ? s_rem_rev : {s_rproduct[0][64:33]};
    assign s_quotient       = s_mul_result[31:0];
    assign s_div_result     = {s_remaining,s_quotient};
    assign s_result         = (s_function_i[2]) ? s_div_result : s_mul_result;
    assign s_result_o       = (s_lower_part) ? s_result[31:0] : s_result[63:32];
    assign s_finished_o     = s_counter_zero;

`ifndef FAST_MULTIPLY
    //Optimized multiplication
    assign s_mulop[0]       = {s_rproduct[0][64:32]};
    assign s_mulop[1]       = {1'b0,s_roperand[0] & {32{s_rproduct[0][0]}}};
    assign s_mulop[2]       = {s_roperand[0] & {32{s_rproduct[0][1]}},1'b0};
    assign s_mul_shift      = 6'd32 - s_rcounter[0];

    adder3op #(.W(33))m_muladder (.s_op_i(s_mulop),.s_res_o(s_mulres));

    fast_shift #(.W(32),.D(1))m_fs32_mul (.s_b_i(s_mul_shift[4:0]),.s_d_i(s_rproduct[0][31:0]),.s_d_o(s_multiplier));
    fast_shift #(.W(65),.D(0),.MS(32))m_fs65_mul (.s_b_i(s_rcounter[0][4:0]),.s_d_i(s_rproduct[0]),.s_d_o(s_fastfwd_result));

    //Auxiliary signals
    assign s_zero           = ~(|s_multiplier);
    assign s_initval        = s_operand2[0] ? {1'b0,s_operand1[31:0]} : 
                              s_operand2[1] ? {s_operand1[31:0],1'b0} : 33'b0;
`endif
    //Not optimized division
    assign s_adder          = {1'b0,s_rproduct[0][63:32]} + {1'b1,s_roperand[0]};

    always_comb begin : products
        if(~s_not_started & ~s_counter_zero) begin
            if(s_function_i[2])begin
                s_wproduct[0][32:0] = {s_rproduct[0][31:0],~s_adder[32]};
                s_wproduct[0][64:33]= (s_adder[32]) ? s_rproduct[0][63:32] : s_adder[31:0]; 
            end else begin
`ifdef FAST_MULTIPLY
                s_wproduct[0]   = s_roperand[0] * s_rproduct[0][31:0];
`else
                //Optimization: is the remaining multiplier zero? finish the computation
                //Optimization: shift one step right, if next multipier bit is zero
                s_wproduct[0]   = (s_zero) ? s_fastfwd_result : 
                                  (s_rproduct[0][3:2] == 2'b0 & s_rcounter[0] != 6'b10) ? {3'b0,s_mulres,s_rproduct[0][31:4]} : {1'b0,s_mulres,s_rproduct[0][31:2]}; 
`endif   
            end
            s_woperand[0] = s_roperand[0];
        end else if(s_compute_i & s_not_started) begin
            //Start of computation
            if(s_direct_result)begin
                //Selection of the direct result
                s_wproduct[0]   = (s_sovrflw) ? s_sovrflw_res : s_zero_result;
            end else begin
                if(s_function_i[2])begin
                    //Start of division
                    s_wproduct[0]   = {33'b0,s_operand1};
                end else begin
                    //Start of multiplication
`ifdef FAST_MULTIPLY
                    s_wproduct[0]   = {33'b0,s_operand2};
`else
                    //Optimization: jump over 2 steps out of 4 cases or 1 step in remaining case
                    s_wproduct[0]   = (s_operand2[1:0] == 2'b11) ? {33'b0,s_operand2} : {2'b0,s_initval,s_operand2[31:2]};
`endif
                end
            end
            s_woperand[0]   = s_function_i[2] ? s_operand2 : s_operand1 ;
        end else if(s_stall_i) begin
            //Preserve the result, if the computation has finished and the MA stage is not ready
            s_woperand[0]   = s_roperand[0];
            s_wproduct[0]   = s_rproduct[0];
        end else begin
            s_woperand[0]   = 32'b0;
            s_wproduct[0]   = 65'b0;
        end
    end

    //Counter control and information to preserve during sequential division/multiplication
    always_comb begin : control
        if(s_flush_i)begin
            s_wcounter[0]   = 6'b111111;
            s_wchngsign[0]  = 1'b0;
        end else if(~s_not_started & ~s_counter_zero) begin
            if(s_function_i[2])begin
                s_wcounter[0]   = (s_rcounter[0] + 6'b111111); // + (-1)
            end else begin
`ifdef FAST_MULTIPLY
                s_wcounter[0]   = 6'b0;
`else
                //Optimization: is the remaining multiplier zero? finish the computation
                //Optimization: shift one step right, if next multipier bit is zero 
                s_wcounter[0]   =   (s_zero) ? 6'b0 : 
                                    (s_rproduct[0][3:2] == 2'b0 & s_rcounter[0] != 6'b10) ? (s_rcounter[0] + 6'b111100) : (s_rcounter[0] + 6'b111110);
`endif
            end
            s_wchngsign[0] = s_rchngsign[0];
        end else if(s_compute_i & s_not_started) begin
            if(s_direct_result)begin
                s_wcounter[0]   = 6'b0;
                s_wchngsign[0]  = 1'b0;
            end else begin
                if(s_function_i[2])begin
                    s_wcounter[0]   = 6'd33;
                    s_wchngsign[0]  = s_div_change_sign;
                end else begin
`ifdef FAST_MULTIPLY
                    s_wcounter[0]   = 6'b1;
`else
                    s_wcounter[0]   = (s_operand2[1:0] == 2'b11) ? 6'd32 : 6'd30;
`endif       
                    s_wchngsign[0]  = s_mul_change_sign;
                end
            end
        end else if(s_stall_i)begin
            s_wcounter[0]   = s_rcounter[0];
            s_wchngsign[0]  = s_rchngsign[0];
        end else begin
            s_wcounter[0]   = 6'b111111;
            s_wchngsign[0]  = 1'b0;
        end
    end
endmodule
