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

module executor (
    input logic s_clk_i,                //clock signal
    input logic s_resetn_i,             //reset signal
    input logic s_stall_i,              //stall signal from MA stage
    input logic s_flush_i,              //flush signal from MA stage
    input ictrl s_ictrl_i,              //instruction control indicator
    input logic[31:0] s_operand1_i,     //operand 1
    input logic[31:0] s_operand2_i,     //operand 2
    input logic[20:0] s_payload_i,      //instruction payload information
    input logic[30:0] s_ma_tadd_i,      //target address saved in MA stage
    input logic[30:0] s_pc_i,           //program counter
    input logic[1:0] s_pc_incr_i,       //indicates how much the address should be incremented in the ALU
    input logic s_ma_taken_i,           //MA stage contains instruction, which performs TOC
    input f_part s_function_i,          //instruction function
    output logic s_finished_o,          //indicates end of computation
    output logic[31:0] s_result_o       //result
);
    logic[31:0] s_alu_result, s_mdu_result, s_result[1], s_result_see[1];
    logic[30:0] s_pc_offset;
    logic s_mdu_finished[1], s_mdu_finished_see[1];

    assign s_result_o   = s_result_see[0];
    assign s_finished_o = s_mdu_finished_see[0];

    see_wires #(.LABEL("ALU_RES"),.GROUP(SEEGR_CORE_WIRE),.W(32)) see_alu(.s_c_i(s_clk_i),.s_d_i(s_result),.s_d_o(s_result_see));
    see_wires #(.LABEL("ALU_FIN"),.GROUP(SEEGR_CORE_WIRE),.W(1)) see_fin(.s_c_i(s_clk_i),.s_d_i(s_mdu_finished),.s_d_o(s_mdu_finished_see));

    //result selection
    assign s_result[0]  = s_ictrl_i.mdu ? s_mdu_result : s_alu_result;

    //preparation of program counter offset for AUIPC and BRU instructions
    assign s_pc_offset  = s_ictrl_i.bru ? {{11{s_payload_i[19]}},s_payload_i[19:0]} : {s_payload_i[19:0],11'b0} ;

    alu m_alu
    (
        .s_function_i(s_function_i),
        .s_op1_i(s_operand1_i),
        .s_op2_i(s_operand2_i),
        .s_pc_offset_i(s_pc_offset),
        .s_ma_tadd_i(s_ma_tadd_i),
        .s_ma_taken_i(s_ma_taken_i),
        .s_pc_i(s_pc_i),
        .s_bru_i(s_ictrl_i.bru),
        .s_pc_incr_i(s_pc_incr_i),
        .s_result_o(s_alu_result)
    );

    muldiv m_mdu
    (
        .s_clk_i(s_clk_i),
        .s_resetn_i(s_resetn_i),
        .s_stall_i(s_stall_i),
        .s_flush_i(s_flush_i),
        .s_compute_i(s_ictrl_i.mdu),
        .s_function_i(s_function_i),
        .s_operand1_i(s_operand1_i),
        .s_operand2_i(s_operand2_i),
        .s_finished_o(s_mdu_finished[0]),
        .s_result_o(s_mdu_result)
    );

endmodule
