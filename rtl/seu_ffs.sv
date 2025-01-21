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

module seu_ff_rst #(
    parameter W=32,
    parameter N=3,
    parameter GROUP=0,
    parameter [W-1:0] RSTVAL= '0,
    parameter LABEL = "GENERAL"
)(
    input logic s_c_i[N],
    input logic s_r_i[N],
    input logic[W-1:0] s_d_i[N],
    output logic[W-1:0] s_q_o[N]
);
    logic[W-1:0] r_data[N] /* cadence preserve_sequential */;
`ifdef SEE_TESTING
    logic[W-1:0] s_upset[N];
    see_insert #(.W(W),.N(N),.LABEL(LABEL),.ELOG("U"),.GROUP(GROUP)) see (.s_clk_i(s_c_i[0]),.s_upset_o(s_upset));
`endif

    assign s_q_o    = r_data;

    genvar i;
    generate
        for ( i= 0;i<N ;i++ ) begin : reg_replicator
            always_ff @( posedge s_c_i[i] or negedge s_r_i[i] ) begin
                if(s_r_i[i] == 1'b0)begin
                    r_data[i]  <= RSTVAL;
                end else begin
`ifdef SEE_TESTING 
                    r_data[i]  <= s_d_i[i] ^ s_upset[i];
`else
                    r_data[i]  <= s_d_i[i];
`endif
                end
            end
        end
    endgenerate
endmodule

module seu_ff_rsts #(
    parameter W=32,
    parameter N=3,
    parameter GROUP=0,
    parameter LABEL = "GENERAL"
)(
    input logic s_c_i[N],
    input logic s_r_i[N],
    input logic[W-1:0] s_rs_i,
    input logic[W-1:0] s_d_i[N],
    output logic[W-1:0] s_q_o[N]
);
    logic[W-1:0] r_data[N] /* cadence preserve_sequential */;
`ifdef SEE_TESTING
    logic[W-1:0] s_upset[N];
    see_insert #(.W(W),.N(N),.LABEL(LABEL),.ELOG("U"),.GROUP(GROUP)) see (.s_clk_i(s_c_i[0]),.s_upset_o(s_upset));
`endif

    assign s_q_o    = r_data;

    genvar i;
    generate
        for ( i= 0;i<N ;i++ ) begin : reg_replicator
            always_ff @( posedge s_c_i[i] or negedge s_r_i[i] ) begin
                if(s_r_i[i] == 1'b0)begin
                    r_data[i]  <= s_rs_i;
                end else begin
`ifdef SEE_TESTING 
                    r_data[i]  <= s_d_i[i] ^ s_upset[i];
`else
                    r_data[i]  <= s_d_i[i];
`endif
                end
            end
        end
    endgenerate
endmodule

module seu_ff #(
    parameter W=32,
    parameter N=3,
    parameter GROUP=0,
    parameter LABEL = "GENERAL"
)(
    input logic s_c_i[N],
    input logic[W-1:0] s_d_i[N],
    output logic[W-1:0] s_q_o[N]
);
    logic[W-1:0] r_data[N] /* cadence preserve_sequential */ = '{default:0};
`ifdef SEE_TESTING
    logic[W-1:0] s_upset[N];
    see_insert #(.W(W),.N(N),.LABEL(LABEL),.ELOG("U"),.GROUP(GROUP)) see (.s_clk_i(s_c_i[0]),.s_upset_o(s_upset));
`endif

    assign s_q_o    = r_data;

    genvar i;
    generate
        for ( i= 0;i<N ;i++ ) begin : reg_replicator
            always_ff @( posedge s_c_i[i] ) begin
`ifdef SEE_TESTING 
                r_data[i]  <= s_d_i[i] ^ s_upset[i];
`else
                r_data[i]  <= s_d_i[i];
`endif
            end
        end
    endgenerate
endmodule

module seu_ff_we #(
    parameter W=32,
    parameter N=3,
    parameter GROUP=0,
    parameter LABEL = "GENERAL"
)(
    input logic s_c_i[N],
    input logic s_we_i[N],
    input logic[W-1:0] s_d_i[N],
    output logic[W-1:0] s_q_o[N]
);
    logic[W-1:0] r_data[N] /* cadence preserve_sequential */ = '{default:0};
`ifdef SEE_TESTING
    logic[W-1:0] s_upset[N];
    see_insert #(.W(W),.N(N),.LABEL(LABEL),.ELOG("U"),.GROUP(GROUP)) see (.s_clk_i(s_c_i[0]),.s_upset_o(s_upset));
`endif

    assign s_q_o    = r_data;

    genvar i;
    generate
        for ( i= 0;i<N ;i++ ) begin : reg_replicator
            always_ff @( posedge s_c_i[i]) begin
                if(s_we_i[i] == 1'b1) begin
`ifndef SEE_TESTING
                    r_data[i]  <= s_d_i[i];
`else 
                    r_data[i]  <= s_d_i[i] ^ s_upset[i];
                end else begin
                    r_data[i]  <= r_data[i] ^ s_upset[i];
`endif
                end
            end
        end
    endgenerate
endmodule

module seu_ff_we_rst #(
    parameter W=32,
    parameter N=3,
    parameter GROUP=0,
    parameter [W-1:0] RSTVAL= '0,
    parameter LABEL = "GENERAL"
)(
    input logic s_c_i[N],
    input logic s_r_i[N],
    input logic s_we_i[N],
    input logic[W-1:0] s_d_i[N],
    output logic[W-1:0] s_q_o[N]
);
    logic[W-1:0] r_data[N] /* cadence preserve_sequential */;
`ifdef SEE_TESTING
    logic[W-1:0] s_upset[N];
    see_insert #(.W(W),.N(N),.LABEL(LABEL),.ELOG("U"),.GROUP(GROUP)) see (.s_clk_i(s_c_i[0]),.s_upset_o(s_upset));
`endif

    assign s_q_o    = r_data;

    genvar i;
    generate
        for ( i= 0;i<N ;i++ ) begin : reg_replicator
            always_ff @( posedge s_c_i[i] or negedge s_r_i[i] ) begin
                if(s_r_i[i] == 1'b0)begin
                    r_data[i]  <= RSTVAL;
                end else if(s_we_i[i] == 1'b1) begin
`ifndef SEE_TESTING
                    r_data[i]  <= s_d_i[i];
`else 
                    r_data[i]  <= s_d_i[i] ^ s_upset[i];
                end else begin
                    r_data[i]  <= r_data[i] ^ s_upset[i];
`endif
                end
            end
        end
    endgenerate
endmodule

module seu_ff_array_we #(
    parameter W=32,
    parameter N=3,
    parameter GROUP=0,
    parameter LABEL = "GENERAL"
)(
    input logic s_c_i[1],
    input logic s_we_i[N],
    input logic[W-1:0] s_d_i[N],
    output logic[W-1:0] s_q_o[N]
);
    logic [W-1:0] s_q[N][1];

    genvar i;
    generate
        for ( i= 0;i<N ;i++ ) begin : reg_replicator
            seu_ff_we #(.W(W),.N(1),.GROUP(GROUP),.LABEL({LABEL,"[",$sformatf("%d",i),"]"})) row (.s_c_i(s_c_i),.s_we_i({s_we_i[i]}),.s_d_i({s_d_i[i]}),.s_q_o(s_q[i]));
            assign s_q_o[i] = s_q[i][0];
        end
    endgenerate
endmodule

module seu_ff_file #(
    parameter W=32,
    parameter N=32,
    parameter GROUP=1,
    parameter RP=1,
    parameter ADDW = $clog2(N),
    parameter LABEL = "GENERAL"
)(
    input logic s_c_i,
    input logic s_we_i,
    input logic[ADDW-1:0] s_wa_i,
    input logic[W-1:0] s_d_i,
    input logic[ADDW-1:0] s_ra_i[RP],
    output logic[W-1:0] s_q_o[RP]
);
    logic s_we[N];
    logic [W-1:0] s_q[N][1];

    genvar i;
    generate
        for ( i= 0;i<N ;i++ ) begin : ff_replicator
            assign s_we[i] = (s_wa_i == i) && s_we_i;
            seu_ff_we #(.W(W),.N(1),.GROUP(GROUP),.LABEL({LABEL,"[",$sformatf("%d",i),"]"})) row (.s_c_i({s_c_i}),.s_we_i({s_we[i]}),.s_d_i({s_d_i}),.s_q_o(s_q[i]));
        end
        for ( i= 0;i<RP ;i++ ) begin : read_ports
            assign s_q_o[i] = s_q[s_ra_i[i]][0];
        end
    endgenerate

endmodule

module seu_ff_file_rst #(
    parameter W=32,
    parameter N=32,
    parameter GROUP=1,
    parameter RP=1,
    parameter ADDW = $clog2(N),
    parameter [W-1:0] RSTVAL= '0,
    parameter LABEL = "GENERAL"
)(
    input logic s_c_i,
    input logic s_r_i,
    input logic s_we_i,
    input logic[ADDW-1:0] s_wa_i,
    input logic[W-1:0] s_d_i,
    input logic[ADDW-1:0] s_ra_i[RP],
    output logic[W-1:0] s_q_o[RP]
);
    logic s_we[N];
    logic [W-1:0] s_q[N][1];

    genvar i;
    generate
        for ( i= 0;i<N ;i++ ) begin : ff_replicator
            assign s_we[i] = (s_wa_i == i) && s_we_i;
            seu_ff_we_rst #(.W(W),.N(1),.RSTVAL(RSTVAL),.GROUP(GROUP),.LABEL({LABEL,"[",$sformatf("%d",i),"]"})) row (.s_c_i({s_c_i}),.s_r_i({s_r_i}),.s_we_i({s_we[i]}),.s_d_i({s_d_i}),.s_q_o(s_q[i]));
        end
        for ( i= 0;i<RP ;i++ ) begin : read_ports
            assign s_q_o[i] = s_q[s_ra_i[i]][0];
        end
    endgenerate

endmodule
