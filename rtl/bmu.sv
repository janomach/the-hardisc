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

module bmu (
    input f_part s_function_i,          //instruction function
    input logic[31:0] s_op1_i,          //operand 1
    input logic[31:0] s_op2_i,          //operand 2
    output logic[31:0] s_result_o       //result
);
    logic[31:0] s_bit_mask, s_misc_result;
    assign s_bit_mask = 32'b1 << s_op2_i[4:0];

    // Shift mux for SHxADD: s_function_i[2:1] encodes shift amount (01->1, 10->2, 11->3)
    logic[31:0] s_sh_op1, s_shadd;
    always_comb begin : shadd_shift_mux
        case (s_function_i[2:1])
            2'b01:   s_sh_op1 = s_op1_i << 1;
            2'b10:   s_sh_op1 = s_op1_i << 2;
            default: s_sh_op1 = s_op1_i << 3;
        endcase
    end
    assign s_shadd = s_op2_i + s_sh_op1;

    //result selection
    always_comb begin : bmu1
        case (s_op2_i)
            BMU_BCLR: begin
                // Clear single bit: rd = rs1 & ~(1 << rs2[4:0])
                s_result_o = s_op1_i & ~s_bit_mask;
            end
            BMU_BINV: begin
                // Invert single bit: rd = rs1 ^ (1 << rs2[4:0])
                s_result_o = s_op1_i ^ s_bit_mask;
            end
            BMU_BSET: begin
                // Set single bit: rd = rs1 | (1 << rs2[4:0])
                s_result_o = s_op1_i | s_bit_mask;
            end
            BMU_BEXT: begin
                // Extract single bit: rd = (rs1 >> rs2[4:0]) & 1
                s_result_o = {31'b0, s_op1_i[s_op2_i[4:0]]};
            end
            BMU_SH1A: s_result_o = s_shadd;
            BMU_SH2A: s_result_o = s_shadd;
            BMU_SH3A: s_result_o = s_shadd;
            default: begin //BMU_MISC
                s_result_o = s_misc_result;
            end
        endcase
    end

    always_comb begin : bmu2
        case (s_op2_i[23:12])
            12'b011000000100: begin // SEXT.B
                // Sign-extend least-significant byte to 32 bits
                s_misc_result = {{24{s_op1_i[7]}}, s_op1_i[7:0]};
            end
            12'b011000000101: begin // SEXT.H
                // Sign-extend least-significant halfword to 32 bits
                s_misc_result = {{16{s_op1_i[15]}}, s_op1_i[15:0]};
            end
            12'b000010000000: begin // ZEXT.H
                // Zero-extend least-significant halfword to 32 bits
                s_misc_result = {16'b0, s_op1_i[15:0]};
            end
            12'b011010011000: begin // REV8
                // Reverse byte order
                s_misc_result = {s_op1_i[7:0], s_op1_i[15:8], s_op1_i[23:16], s_op1_i[31:24]};
            end
            12'b001010000111: begin // ORC.B
                // Set each byte to 0xFF if any bit in it is set, else 0x00
                s_misc_result = {{8{|s_op1_i[31:24]}}, {8{|s_op1_i[23:16]}}, {8{|s_op1_i[15:8]}}, {8{|s_op1_i[7:0]}}};
            end
            12'b011000000000: begin // CLZ
                // Iterate LSB→MSB; each found 1-bit overwrites with (31-i), last write = MSB position
                s_misc_result = 32'd32;
                for (int i = 0; i < 32; i++) begin
                    if (s_op1_i[i]) s_misc_result[4:0] = {1'b0, (5'd31 - 5'(i))};
                end
            end
            12'b011000000001: begin // CTZ
                // Iterate MSB→LSB; each found 1-bit overwrites with i, last write = LSB position
                s_misc_result = 32'd32;
                for (int i = 31; i >= 0; i--) begin
                    if (s_op1_i[i]) s_misc_result[4:0] = {1'b0, 5'(i)};
                end
            end
            default: begin // CPOP
                // Accumulate set bits
                s_misc_result = 32'b0;
                for (int i = 0; i < 32; i++) s_misc_result[5:0] += {5'b0, s_op1_i[i]};
            end
        endcase
    end

endmodule