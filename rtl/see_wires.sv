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

module see_wires #(
    parameter W=32,
    parameter GROUP=1,
    parameter LABEL = "GENERAL"
)(
    input logic s_c_i,
    input logic[W-1:0] s_d_i,
    output logic[W-1:0] s_d_o
);

`ifdef SEE_TESTING
    logic[W-1:0] s_upset[1];
    see_insert #(.W(W),.N(1),.LABEL(LABEL),.GROUP(GROUP)) see (.s_clk_i(s_c_i),.s_upset_o(s_upset));
`endif

    assign s_d_o = s_d_i
`ifdef SEE_TESTING            
            ^ s_upset[0]
`endif            
            ;

endmodule
