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

module alu (
    input f_part s_function_i,          //instruction function
    input logic s_bru_i,                //EX stage contains BRU instruction
    input logic s_ma_taken_i,           //MA stage contains instruction, which performs TOC
    input logic[31:0] s_op1_i,          //operand 1
    input logic[31:0] s_op2_i,          //operand 2
    input logic[30:0] s_pc_offset_i,    //offset from instruction address
    input logic[30:0] s_ma_tadd_i,      //target address saved in MA stage
    input logic[30:0] s_pc_i,           //program counter   
    input logic[1:0] s_pc_incr_i,       //indicates how much the address should be incremented
    output logic[31:0] s_result_o       //combinatorial result
);
    logic[31:0] s_add, s_sub, s_xor, s_and, s_or, s_sll, s_srl, s_sra;
    logic s_sltu, s_slt, s_neq;
    logic[30:0] s_pc_op[3], s_tadd;
    logic[31:0] s_pc_tadd;

    //Basic operations
    assign s_add = s_op1_i + s_op2_i;
    assign s_sub = s_op1_i - s_op2_i;
    assign s_xor = s_op1_i ^ s_op2_i;
    assign s_and = s_op1_i & s_op2_i;
    assign s_or  = s_op1_i | s_op2_i;
    assign s_sltu= s_op1_i < s_op2_i;
    assign s_neq = |s_xor;
    assign s_sll = s_op1_i << s_op2_i[4:0];
    assign s_srl = s_op1_i >> s_op2_i[4:0];
    assign s_sra = $signed(s_op1_i) >>> s_op2_i[4:0];
    assign s_slt = (s_op1_i[31] ^ s_op2_i[31]) ? s_op1_i[31] : s_sltu;

    //Program counter incrementation for AUIPC and BRU instructions and 
    adder3op #(.W(31)) m_address (.s_op_i(s_pc_op),.s_res_o(s_pc_tadd));  
    /*  If the MA stage contains instruction, which performs a TOC, 
        takes the generated target address as a PC. This can happen 
        only if the prediction was made from the MA-stage instruction. */  
    assign s_pc_op[0]   = s_ma_taken_i ? s_ma_tadd_i : s_pc_i;
    assign s_pc_op[1]   = s_pc_offset_i;
    /*  The program counter address must by incremented by:
        a) 0 if the MA stage does not contain an instruction - prepared outside of the Executor
        b) 2 if the MA stage contains RVC an instruction
        c) 4 if the MA stage contains RVI an instruction 
        If the MA stage contains instruction, which performs a TOC, the incrementation is not required. */
    assign s_pc_op[2]   = {29'b0,s_ma_taken_i ? 2'b0 : s_pc_incr_i};
    /*  The computed target address is saved with the comparision 
        condition result into the same 32-bit register in EXMA registers. 
        The ALU instruction must have the bits [31:1] set to zero. */
    assign s_tadd       = s_bru_i ? s_pc_tadd[30:0] : 31'b0;

    //result selection
    always_comb begin : alu_comb
        case (s_function_i)
            ALU_SUB: begin
                s_result_o = s_sub;
            end
            ALU_SLL: begin
                s_result_o = s_sll;
            end
            ALU_SLT: begin
                s_result_o = {s_tadd,s_slt};
            end
            ALU_SLTU: begin
                s_result_o = {s_tadd,s_sltu};
            end
            ALU_SRL: begin
                s_result_o = s_srl;
            end
            ALU_SRA: begin
                s_result_o = s_sra;
            end
            ALU_XOR: begin
                s_result_o = s_xor;
            end
            ALU_OR: begin
                s_result_o = s_or;
            end
            ALU_AND: begin
                s_result_o = s_and;
            end
            ALU_NEQ: begin
                s_result_o = {s_tadd,s_neq};
            end
            ALU_EQ: begin
                s_result_o = {s_tadd,~s_neq};
            end
            ALU_GE: begin
                s_result_o = {s_tadd,~s_slt};
            end
            ALU_GEU: begin
                s_result_o = {s_tadd,~s_sltu};
            end
            ALU_IPC: begin //includes AUIPC and JAL
                s_result_o = {s_pc_tadd[30:0],1'b0};
            end
            default: //includes JALR
                s_result_o = s_add;
        endcase   
    end
endmodule
