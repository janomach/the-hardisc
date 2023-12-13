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
    parameter N=1,
    parameter GROUP=0,
    parameter MPROB=1,
    parameter LABEL = "GENERAL"
)(
    input logic s_c_i,
    input logic[W-1:0] s_d_i[N],
    output logic[W-1:0] s_d_o[N]
);

`ifdef SEE_TESTING
    logic[W-1:0] s_upset[N];
    see_insert #(.W(W),.N(N),.LABEL(LABEL),.GROUP(GROUP),.MPROB(MPROB)) see (.s_clk_i(s_c_i),.s_upset_o(s_upset));
`endif

    genvar i;
    generate
        for (i = 0;i < N; i++) begin : iterate_i
            assign s_d_o[i] = s_d_i[i]
`ifdef SEE_TESTING            
                    ^ s_upset[i]
`endif            
                    ;
        end
    endgenerate

endmodule
