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

module seu_regs #(
    parameter W=32,
    parameter N=3,
    parameter NC=N,
    parameter GROUP=1,
    parameter LABEL = "GENERAL"
)(
    input logic s_c_i[NC],
    input logic[W-1:0] s_d_i[N],
    output logic[W-1:0] s_d_o[N]
);

logic[W-1:0] r_data[N] /* cadence preserve_sequential */;
logic[W-1:0] s_wdata[N];
`ifdef SEE_TESTING
logic[W-1:0] s_upset[N];
see_insert #(.W(W),.N(N),.LABEL(LABEL),.GROUP(GROUP)) see (.s_clk_i(s_c_i[0]),.s_upset_o(s_upset));
`endif

genvar i;
generate
    for ( i= 0;i<N ;i++ ) begin : reg_replicator
        assign s_d_o[i] = r_data[i];
        assign s_wdata[i] = s_d_i[i]
`ifdef SEE_TESTING            
            ^ s_upset[i]
`endif            
            ;
        if(NC == 1)
            always_ff @( posedge s_c_i[0] ) r_data[i]  <= s_wdata[i];
        else
            always_ff @( posedge s_c_i[i] ) r_data[i]  <= s_wdata[i]; 
    end
endgenerate

endmodule

module seu_regs_file #(
    parameter W=32,
    parameter N=32,
    parameter GROUP=1,
    parameter RP=1,
    parameter ADDW = $clog2(N),
    parameter LABEL = "GENERAL"
)(
    input logic s_clk_i,
    input logic s_we_i,
    input logic[ADDW-1:0] s_wadd_i,
    input logic[W-1:0] s_val_i,
    input logic[ADDW-1:0] s_radd_i[RP],
    output logic[W-1:0] s_val_o[RP]
);
`ifdef SEE_TESTING
    int j;
    logic[W-1:0] s_upset[N];
    see_insert #(.W(W),.N(N),.GROUP(GROUP),.LABEL("RF")) see (.s_clk_i(s_clk_i),.s_upset_o(s_upset));
`endif

    logic[W-1:0] r_register_file[0:N-1];

`ifdef SIMULATION
    int init_var;
    initial begin
        for (init_var = 0 ;init_var<N ;init_var++ ) begin
            r_register_file[init_var] = 0; 
        end
    end
`endif

    genvar i;
    generate
        for (i = 0;i<RP;i++ ) begin
            assign s_val_o[i]   = r_register_file[s_radd_i[i]];
        end
    endgenerate

    always_ff @( posedge s_clk_i ) begin : rf_writer
        if(s_we_i)begin
            r_register_file[s_wadd_i] <= s_val_i
`ifdef SEE_TESTING            
            ^ s_upset[s_wadd_i]
`endif 
            ;
        end
`ifdef SEE_TESTING  
        for (j=1;j<32;j++) begin
            if(!(s_we_i & (s_wadd_i == j)))
                r_register_file[j] <= r_register_file[j] ^ s_upset[j];
        end
`endif
    end

endmodule
