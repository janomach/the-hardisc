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

module tmr_comb #(
    parameter W=32,
    parameter OUT_REPS=3
)(
    input logic[W-1:0] s_d_i[3],
    output logic[W-1:0] s_d_o[OUT_REPS]
);
    logic[W-1:0] s_out_and[3];  
    assign s_out_and[0] = s_d_i[0] & s_d_i[1];
    assign s_out_and[1] = s_d_i[0] & s_d_i[2];
    assign s_out_and[2] = s_d_i[1] & s_d_i[2];

    generate
        for (genvar i = 0;i<OUT_REPS ;i++ ) begin
            assign s_d_o[i]  = s_out_and[0] | s_out_and[1] | s_out_and[2];
        end
    endgenerate
endmodule
