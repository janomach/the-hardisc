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

module circular_buffer #(
    parameter SIZE = 4,
    parameter WIDTH = 32,
    parameter GROUP = 1,
    parameter LABEL = "CBUF"
)(
    input logic s_clk_i,                //clock signal
    input logic s_resetn_i,             //reset signal
    input logic s_flush_i,              //flush signal
    input logic s_push_i,               //push data into the buffer
    input logic s_pop_i,                //pop data out of the buffer
    input logic[WIDTH-1:0] s_data_i,    //data to be pushed

    output logic s_empty_o,             //empty signal
    output logic[WIDTH-1:0] s_data_o    //data to be poped out
);
    localparam PTRW = $clog2(SIZE);
    localparam bit[PTRW:0] CONE = (PTRW+1)'(1);
    localparam bit[PTRW-1:0] PONE = (PTRW)'(1);

    logic[WIDTH-1:0] s_data[1];
    logic[PTRW-1:0] s_wlast[1], s_rlast[1];
    logic[PTRW:0] s_wcount[1], s_rcount[1];
    logic[PTRW-1:0] s_wpos;
    logic s_empty;

    //Buffer to hold data
    seu_ff_file #(.LABEL(LABEL),.GROUP(GROUP),.W(WIDTH),.N(SIZE),.RP(1)) m_seu_cbuf 
    (
        .s_c_i(s_clk_i),
        .s_we_i(s_push_i),
        .s_wa_i(s_wpos),
        .s_d_i(s_data_i),
        .s_ra_i(s_rlast),
        .s_q_o(s_data)
    );

    //Count of entries in the buffer
    seu_ff_rst #(.LABEL({LABEL,"_COUNT"}),.GROUP(GROUP),.W(PTRW+1),.N(1)) m_seu_count(.s_c_i({s_clk_i}),.s_r_i({s_resetn_i}),.s_d_i(s_wcount),.s_q_o(s_rcount));
    //Pointer for last pushed data
    seu_ff_rst #(.LABEL({LABEL,"_LAST"}),.GROUP(GROUP),.W(PTRW),.N(1)) m_seu_last(.s_c_i({s_clk_i}),.s_r_i({s_resetn_i}),.s_d_i(s_wlast),.s_q_o(s_rlast));
    
    assign s_empty      = s_rcount[0] == '0;
    assign s_empty_o    = s_empty;
    assign s_data_o     = s_data[0];

    //Write buffer address
    assign s_wpos = (s_pop_i & s_push_i) ? s_rlast[0] : (s_rlast[0] + PONE);

    //Control struture
    always_comb begin : control
        if(s_flush_i)begin
            s_wlast[0] = '0;
            s_wcount[0] = '0;
        end else begin
            if(s_push_i & ~s_pop_i)begin
                s_wcount[0] = s_rcount[0][PTRW] ? s_rcount[0] : (s_rcount[0] + CONE);
                s_wlast[0] = s_rlast[0] + PONE;
            end else if(~s_push_i & s_pop_i & ~s_empty)begin
                s_wcount[0] = s_rcount[0] - CONE;
                s_wlast[0] = s_rlast[0] - PONE;
            end else begin
                s_wcount[0] = s_rcount[0];
                s_wlast[0] = s_rlast[0];
            end
        end
    end

endmodule