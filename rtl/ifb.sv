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

module ifb #(
    parameter SIZE = 2,
    parameter LABEL = "IFB"
)(
    input logic s_clk_i,                        //clock signal
    input logic s_resetn_i,                     //reset signal
    input logic s_flush_i,                      //flush signal
    input logic s_push_i,                       //push data into the buffer
    input logic s_pop_i,                        //pop data out of the buffer
    input logic[1:0] s_ras_pred_i,              //RAS prediction update
    input logic[IFB_WIDTH-1:0] s_data_i,        //data to be pushed           

    output logic[IFB_WIDTH-1:0] s_data_o,       //data to be poped out
    output logic[IFB_WIDTH-1:0] s_last_entry_o, //last pushed entry
    output logic[SIZE-1:0] s_occupied_o         //occupancy of each entry

);
    /*  Instruction Fetch Buffer
        If the pipeline is stalled, the instructions are prefetched into the FIFO IFB. The current 
        implementation of IFB is purpusefully designed for a short I2R paths. The data are pushed
        always into the same registers (buffer index 0). If entry 0 is occupied already all entries 
        are shifted, so the incoming data can be savd into entry 0. 
        The IFB is specially designed to allow RAS prediction in a core, based on the last pushed data 
        saved in entry 0. This means that it also outputs the last pushed data and can update prediction 
        information in those data, if the RAS signalizes TOC. */
   
    logic[IFB_WIDTH-1:0] s_wbuffer[SIZE];
    logic[IFB_WIDTH-1:0] s_rbuffer[SIZE], s_ubuffer[SIZE];
    logic[SIZE-1:0] s_woccupied[1];
    logic[SIZE-1:0] s_roccupied[1];

    //Buffer to hold data
    seu_regs #(.LABEL(LABEL),.W(IFB_WIDTH),.N(SIZE),.NC(1)) m_seu_buffer(.s_c_i({s_clk_i}),.s_d_i(s_wbuffer),.s_d_o(s_rbuffer));
    //Entries occupancy information
    seu_regs #(.LABEL(LABEL + "OCPD"),.W(SIZE),.N(1),.NC(1)) m_seu_occupied(.s_c_i({s_clk_i}),.s_d_i(s_woccupied),.s_d_o(s_roccupied));

    //If RAS signalizes TOC, update the prediction inforamtion
    assign s_ubuffer[0][35:34]  = (s_ras_pred_i != 2'b0) ? s_ras_pred_i : s_rbuffer[0][35:34];
    assign s_ubuffer[0][33:0]   = s_rbuffer[0][33:0];
    assign s_ubuffer[1]         = s_rbuffer[1];
    assign s_ubuffer[2]         = s_rbuffer[2];
    assign s_ubuffer[3]         = s_rbuffer[3];

    //Output the last entry
    assign s_last_entry_o   = s_rbuffer[0];
    //Output occupancy information
    assign s_occupied_o     = s_roccupied[0];
    //Select the earliest pushed data to the FIFO output
    assign s_data_o         = s_roccupied[0][SIZE-1] ? s_ubuffer[SIZE-1] :
                              s_roccupied[0][SIZE-2] ? s_ubuffer[SIZE-2] :
                              s_roccupied[0][SIZE-3] ? s_ubuffer[SIZE-3] : s_ubuffer[SIZE-4];

    //Control structure for movement of data between entries of the FIFO
    always_comb begin
        if(~s_resetn_i)begin
            s_wbuffer[0] = {IFB_WIDTH{1'b0}};
        end else if(s_push_i)begin
            s_wbuffer[0] = s_data_i;
        end else begin
            s_wbuffer[0] = s_ubuffer[0]; 
        end
        if(~s_resetn_i | s_flush_i)begin
            s_woccupied[0][0] = 1'b0;
        end else if(s_push_i)begin
            s_woccupied[0][0] = 1'b1;
        end else if(s_pop_i)begin
            s_woccupied[0][0] = s_roccupied[0][1];
        end else begin
            s_woccupied[0][0] = s_roccupied[0][0];
        end
    end

    genvar i;
    generate
        for(i=1;i<SIZE-1;i++)begin : buffer_controler
            always_comb begin
                if(s_push_i)begin
                    s_wbuffer[i] = s_ubuffer[i-1];
                end else begin
                    s_wbuffer[i] = s_ubuffer[i]; 
                end
                if(~s_resetn_i | s_flush_i)begin
                    s_woccupied[0][i] = 1'b0;
                end else if(s_push_i & ~s_pop_i)begin
                    s_woccupied[0][i] = s_roccupied[0][i-1];
                end else if(~s_push_i & s_pop_i)begin
                    s_woccupied[0][i] = s_roccupied[0][i+1];
                end else begin
                    s_woccupied[0][i] = s_roccupied[0][i];
                end
            end
        end
    endgenerate

    always_comb begin
        if(s_push_i)begin
            s_wbuffer[SIZE-1] = s_ubuffer[SIZE-2];
        end else begin
            s_wbuffer[SIZE-1] = s_ubuffer[SIZE-1]; 
        end
        if(~s_resetn_i | s_flush_i)begin
            s_woccupied[0][SIZE-1] = 1'b0;
        end else if(s_push_i & ~s_pop_i)begin
            s_woccupied[0][SIZE-1] = s_roccupied[0][SIZE-2];
        end else if(~s_push_i & s_pop_i)begin
            s_woccupied[0][SIZE-1] = 1'b0;
        end else begin
            s_woccupied[0][SIZE-1] = s_roccupied[0][SIZE-1];
        end
    end
endmodule