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

module adder3op #(
    parameter W=32
)(
    input logic[W-1:0] s_op_i[3],
    output logic[W:0] s_res_o
);
    logic[W-1:0] s_xor, s_and;

    //carry-save adder
    assign s_xor = s_op_i[0] ^ s_op_i[1] ^ s_op_i[2];
    assign s_and = (s_op_i[0] & s_op_i[1]) | (s_op_i[0] & s_op_i[2]) | (s_op_i[1] & s_op_i[2]);
    assign s_res_o = {1'b0, s_xor} + {s_and,1'b0}; 
endmodule
