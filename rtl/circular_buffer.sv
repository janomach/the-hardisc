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
)
(
    input logic s_clk_i,                //clock signal
    input logic s_resetn_i,             //reset signal
    input logic s_push_i,               //push data into the buffer
    input logic s_pop_i,                //pop data out of the buffer
    input logic[WIDTH-1:0] s_data_i,    //data to be pushed

    output logic s_empty_o,             //empty signal
    output logic[WIDTH-1:0] s_data_o    //data to be poped out
);
    localparam PTRW = $clog2(SIZE);
    localparam bit[PTRW:0] CZERO = (PTRW+1)'(0);
    localparam bit[PTRW:0] CONE = (PTRW+1)'(1);
    localparam bit[PTRW-1:0] PZERO = (PTRW)'(0);
    localparam bit[PTRW-1:0] PONE = (PTRW)'(1);

    logic[WIDTH-1:0] s_wbuffer[SIZE], s_rbuffer[SIZE];
    logic[PTRW-1:0] s_wlast[1], s_rlast[1];
    logic[PTRW:0] s_wcount[1], s_rcount[1];

    //Buffer to hold data
    seu_regs #(.LABEL(LABEL),.GROUP(GROUP),.W(WIDTH),.N(SIZE),.NC(1)) m_seu_cbuf(.s_c_i({s_clk_i}),.s_d_i(s_wbuffer),.s_d_o(s_rbuffer));
    //Count of entries in the buffer
    seu_regs #(.LABEL(LABEL + "COUNT"),.GROUP(GROUP),.W(PTRW+1),.N(1),.NC(1)) m_seu_count(.s_c_i({s_clk_i}),.s_d_i(s_wcount),.s_d_o(s_rcount));
    //Pointer for last pushed data
    seu_regs #(.LABEL(LABEL + "LAST"),.GROUP(GROUP),.W(PTRW),.N(1),.NC(1)) m_seu_last(.s_c_i({s_clk_i}),.s_d_i(s_wlast),.s_d_o(s_rlast));

    logic[PTRW-1:0] s_wpos;
    logic s_empty;
    
    assign s_empty      = s_rcount[0] == CZERO;
    assign s_empty_o    = s_empty;
    assign s_data_o     = s_rbuffer[s_rlast[0]]; 

    //Control struture
    always_comb begin : control
        if(~s_resetn_i)begin
            s_wlast[0] = PZERO;
            s_wcount[0] = CZERO;
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

    //Write buffer structure
    assign s_wpos = (s_pop_i & s_push_i) ? s_rlast[0] : (s_rlast[0] + PONE);

    genvar i;
    generate
        for(i=0;i<SIZE;i++)begin
            assign s_wbuffer[i] = (s_push_i & (i[PTRW-1:0] == s_wpos)) ? s_data_i : s_rbuffer[i];
        end
    endgenerate

endmodule