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

module bop #(
    parameter SIZE = 2,
    parameter LABEL = "BOP"
)(
    input logic s_clk_i,                    //clock signal
    input logic s_resetn_i,                 //reset signal
    input logic s_flush_i,                  //flush signal
    input logic s_push_i,                   //push data into the buffer
    input logic s_pop_i,                    //pop data out of the buffer
    input logic[BOP_WIDTH-1:0] s_data_i,    //data to be pushed 
    
    output logic[BOP_WIDTH-1:0] s_data_o,   //data to be poped out
    output logic s_entry_ready_o,           //prediction is ready
    output logic s_full_o,                  //buffer is full
    output logic s_afull_o                  //buffer is almost full (1 entry is free)
);
    /*  Buffer of predictions
        The BOP hold predicted target addresses, so they do not propagate through the whole pipeline and IFB.
        It is a FIFO buffer made as a short pipeline. If the BOP was not present, the predicted address would
        propagate through FE1, each entry of IFB, IDOP, OPEX, and EXMA registers to the MA stage for evaluation.
        With the BOP, the predicted address is saved and waits in the buffer until the instruction pops it out.
        The BOP can be short, since it is expected that only a fraction of instructions performs TOC. */

    logic[BOP_WIDTH-1:0] s_wbuffer[SIZE];
    logic[BOP_WIDTH-1:0] s_rbuffer[SIZE];
    logic[SIZE-1:0] s_woccupied[1];
    logic[SIZE-1:0] s_roccupied[1];
    logic s_buffer_we[SIZE];

    //Buffer to hold data
    seu_ff_array_we #(.LABEL(LABEL),.W(BOP_WIDTH),.N(SIZE),.GROUP(SEEGR_PREDICTOR)) m_seu_regs(.s_c_i({s_clk_i}),.s_we_i(s_buffer_we),.s_d_i(s_wbuffer),.s_q_o(s_rbuffer));
    //Entries occupancy information
    seu_ff_rst #(.LABEL({LABEL,"_OCPD"}),.W(SIZE),.N(1),.GROUP(SEEGR_PREDICTOR)) m_seu_occupied(.s_c_i({s_clk_i}),.s_r_i({s_resetn_i}),.s_d_i(s_woccupied),.s_q_o(s_roccupied));

    assign s_data_o         = s_rbuffer[SIZE-1];
    assign s_full_o         = &s_roccupied[0];
    assign s_entry_ready_o  = s_roccupied[0][SIZE-1];

    generate
        if(SIZE == 2)begin
            assign s_afull_o    = (s_roccupied[0] == 2'b01) | (s_roccupied[0] == 2'b10);
        end else if(SIZE == 3)begin
            assign s_afull_o    = (s_roccupied[0] == 3'b011) | (s_roccupied[0] == 3'b101) | (s_roccupied[0] == 3'b110);
        end else begin
            //Change it for your need.
            assign s_afull_o    = 1'b1;
        end
    endgenerate

    //Control structure for movement of data between entries of the FIFO
    assign s_buffer_we[0] = s_push_i;
    always_comb begin
        if(s_push_i)begin
            s_wbuffer[0] = s_data_i;
        end else begin
            s_wbuffer[0] = s_rbuffer[0]; 
        end
        if(s_flush_i)begin
            s_woccupied[0][0] = 1'b0;
        end else if(s_push_i)begin
            s_woccupied[0][0] = 1'b1;
        end else if(s_pop_i | ~s_roccupied[0][1])begin
            s_woccupied[0][0] = 1'b0; 
        end else begin
            s_woccupied[0][0] = s_roccupied[0][0]; 
        end
    end

    generate
        for(genvar i=1;i<SIZE-1;i++)begin : buffer_controler
            assign s_buffer_we[i] = s_pop_i | (~s_roccupied[0][SIZE-1] | ~s_roccupied[0][i]);
            always_comb begin
                s_wbuffer[i] = s_rbuffer[i-1]; 
                if(s_flush_i)begin
                    s_woccupied[0][i] = 1'b0;
                end else if(s_pop_i | (~s_roccupied[0][SIZE-1] | ~s_roccupied[0][i]))begin
                    s_woccupied[0][i] = s_roccupied[0][i-1]; 
                end else begin
                    s_woccupied[0][i] = s_roccupied[0][i]; 
                end
            end
        end
    endgenerate

    assign s_buffer_we[SIZE-1] = s_pop_i | ~s_roccupied[0][SIZE-1];
    always_comb begin
        s_wbuffer[SIZE-1] = s_rbuffer[SIZE-2];
        if(s_flush_i)begin
            s_woccupied[0][SIZE-1] = 1'b0;
        end else if(s_pop_i | ~s_roccupied[0][SIZE-1])begin
            s_woccupied[0][SIZE-1] = s_roccupied[0][SIZE-2];
        end else begin
            s_woccupied[0][SIZE-1] = s_roccupied[0][SIZE-1]; 
        end
    end
endmodule
