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

`include "../rtl/settings.sv"
import p_hardisc::*;
`ifdef SEE_TESTING
import seed_instance::*;
`endif

module see_insert #(
    parameter W = 32,
    parameter N = 3,
    parameter MPROB = 1,
    parameter GROUP = 0,
    parameter ELOG = "E",
    parameter LABEL = "SEE_INSERT"
)(
    input logic s_clk_i,
    output logic[W-1:0] s_upset_o[N]
);
    localparam[31:0] GROUP_MASK = (32'b1 << GROUP);
    logic[31:0] r_seed_value[N], r_randomval[N], see_prob, see_group;
    logic[W-1:0] r_force[N];
    logic[31:0] s_filtered[N];
    int logging;

    initial begin
        see_prob = 0;
        see_group = 0;
        logging = 0;
        if($value$plusargs ("SEE_PROB=%d", see_prob));
        if($value$plusargs ("SEE_GROUP=%d", see_group));
        if($value$plusargs ("LOGGING=%d", logging));
        see_prob = see_prob * MPROB;
    end

    assign s_upset_o    = r_force;

    generate
        for (genvar i = 0;i < N; i++) begin : iterate_i
            initial begin
                seed_instance::srandom($sformatf("%m"));
                r_seed_value[i]     = $urandom;
                r_randomval[i]      = $urandom(r_seed_value[i]);
                r_force[i]          = 0;
                $write("SE%s initial seed in %s[%02d] = %d\n",ELOG,LABEL,i,r_seed_value[i]);
            end

            assign s_filtered[i]    = (r_randomval[i] % `SEE_MAX);

            always_ff @( posedge s_clk_i ) begin
                if((see_prob != 0) & ((GROUP_MASK & see_group) != 0))begin
                    r_randomval[i] <= $urandom(r_seed_value[i]+r_randomval[i]);
                    for(int j = 0; j < W; j++)begin : iterate_j
                        r_force[i][j] <= (s_filtered[i] >= (see_prob * j)) & (s_filtered[i] < (see_prob * (j+1)));
                        if(r_force[i][j] & (logging > 2))begin
                            if(N == 1)
                                $write("SE%s in %s[%02d]\n",ELOG,LABEL,j);
                            else
                                $write("SE%s in %s[%02d][%02d]\n",ELOG,LABEL,i,j);
                        end
                    end
                end
            end            
        end

        if(N == 3)begin
            always_ff @( posedge s_clk_i )begin
                if((r_force[0] & r_force[1]) | (r_force[0] & r_force[2]) | (r_force[2] & r_force[1]))begin
                    $write("MB%s in the same bits of %s, execution not reliable!\n",ELOG,LABEL);
                    $finish;
                end
            end
        end
    endgenerate
endmodule