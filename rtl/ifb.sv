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
    input logic[6:0] s_checksum_i,              //data checksum           

    output logic s_valid_o,                     //valid data at the output
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
    logic[IFB_WIDTH-1:0] s_buffer0;
    logic s_pop, s_buffer_we[SIZE];
`ifdef PROT_INTF
    logic[31:0] s_corrected_data;
    logic[6:0] s_wchecksum[1], s_rchecksum[1], s_achecksum, s_syndrome;
    logic s_ce, s_error, s_fetch_check;

    //Data checksum
    seu_ff_we #(.LABEL({LABEL,"_CHECKSUM"}),.W(7),.N(1)) m_seu_checksum(.s_c_i({s_clk_i}),.s_we_i({s_push_i}),.s_d_i(s_wchecksum),.s_q_o(s_rchecksum));
`endif
    //Buffer to hold data
    seu_ff_array_we #(.LABEL(LABEL),.W(IFB_WIDTH),.N(SIZE)) m_seu_buffer(.s_c_i({s_clk_i}),.s_we_i(s_buffer_we),.s_d_i(s_wbuffer),.s_q_o(s_rbuffer));
    //Entries occupancy information
    seu_ff_rst #(.LABEL({LABEL,"_OCPD"}),.W(SIZE),.N(1)) m_seu_occupied(.s_c_i({s_clk_i}),.s_r_i({s_resetn_i}),.s_d_i(s_woccupied),.s_q_o(s_roccupied));

    //Output the last entry
    assign s_last_entry_o   = s_rbuffer[0];
    //Output occupancy information
    assign s_occupied_o     = s_roccupied[0];
    //Select the earliest pushed data to the FIFO output
    assign s_data_o         = s_roccupied[0][SIZE-1] ? s_ubuffer[SIZE-1] :
                              s_roccupied[0][SIZE-2] ? s_ubuffer[SIZE-2] :
                              s_roccupied[0][SIZE-3] ? s_ubuffer[SIZE-3] : s_buffer0;

`ifdef PROT_INTF
    //Check the fetched data for any errors
    secded_encode m_encode  (.s_data_i(s_rbuffer[0][31:0]),.s_checksum_o(s_achecksum));
    secded_analyze m_analyze(.s_syndrome_i(s_syndrome),.s_error_o(s_error),.s_ce_o(s_ce));
    secded_decode m_decode  (.s_data_i(s_rbuffer[0][31:0]),.s_syndrome_i(s_syndrome),.s_data_o(s_corrected_data));
    assign s_syndrome       = s_achecksum ^ s_rchecksum[0];

    //Check only once and only if the fetch was succesful
    assign s_fetch_check    = s_rbuffer[0][35:33] == FETCH_VALID;
    //Delay poping if the IFB has only a single entry that has an error; if the error is corretable, it will be corrected
    assign s_valid_o        = s_roccupied[0][0] & (~s_fetch_check | s_roccupied[0][1] | ~s_error);
    //Corrected data; the decoder does not change data that are not faulty
    assign s_ubuffer[0][31:0]   = s_corrected_data;
    assign s_ubuffer[0][32:32]  = s_rbuffer[0][32:32];

    always_comb begin : fetch_check
        s_ubuffer[0][35:33] = s_rbuffer[0][35:33];
        if(s_roccupied[0][0] & s_fetch_check & s_error)begin
            if(s_ce) //Save information that the data contains a correctable error
                s_ubuffer[0][35:33] = FETCH_INCER;
            else  //Save information that the data contains an uncorrectable error
                s_ubuffer[0][35:33] = FETCH_INUCE;
        end
    end
`else
    assign s_valid_o            = s_roccupied[0][0];
    assign s_ubuffer[0][35:0]   = s_rbuffer[0][35:0];
`endif
    //Pop can happen only if data are prepared
    assign s_pop        = s_pop_i & s_valid_o;

    //If RAS signalizes TOC, update the prediction inforamtion
    assign s_buffer0[37:36] = (s_ras_pred_i != 2'b0) ? s_ras_pred_i : s_rbuffer[0][37:36];
    assign s_buffer0[35:0]  = s_rbuffer[0][35:0];

    assign s_ubuffer[0][37:36]  = s_buffer0[37:36];
    assign s_ubuffer[1]         = s_rbuffer[1];
    assign s_ubuffer[2]         = s_rbuffer[2];
    assign s_ubuffer[3]         = s_rbuffer[3];

    assign s_buffer_we[0]   = 1'b1;
    //Control structure for movement of data between entries of the FIFO
    always_comb begin
        if(s_push_i)begin
            s_wbuffer[0] = s_data_i;
        end else begin
            s_wbuffer[0] = s_ubuffer[0]; 
        end
        if(s_flush_i)begin
            s_woccupied[0][0] = 1'b0;
        end else if(s_push_i)begin
            s_woccupied[0][0] = 1'b1;
        end else if(s_pop)begin
            s_woccupied[0][0] = s_roccupied[0][1];
        end else begin
            s_woccupied[0][0] = s_roccupied[0][0];
        end
`ifdef PROT_INTF
        if(s_push_i)begin
            s_wchecksum[0] = s_checksum_i;
        end else begin
            s_wchecksum[0] = s_rchecksum[0]; 
        end
`endif
    end

    genvar i;
    generate
        for(i=1;i<SIZE-1;i++)begin : buffer_controler
            assign s_buffer_we[i]   = s_push_i & s_roccupied[0][i-1];
            always_comb begin
                s_wbuffer[i] = s_ubuffer[i-1];
                if(s_flush_i)begin
                    s_woccupied[0][i] = 1'b0;
                end else if(s_push_i & ~s_pop)begin
                    s_woccupied[0][i] = s_roccupied[0][i-1];
                end else if(~s_push_i & s_pop)begin
                    s_woccupied[0][i] = s_roccupied[0][i+1];
                end else begin
                    s_woccupied[0][i] = s_roccupied[0][i];
                end
            end
        end
    endgenerate

    assign s_buffer_we[SIZE-1]   = s_push_i & s_roccupied[0][SIZE-2];
    always_comb begin
        s_wbuffer[SIZE-1] = s_ubuffer[SIZE-2];
        if(s_flush_i)begin
            s_woccupied[0][SIZE-1] = 1'b0;
        end else if(s_push_i & ~s_pop)begin
            s_woccupied[0][SIZE-1] = s_roccupied[0][SIZE-2];
        end else if(~s_push_i & s_pop)begin
            s_woccupied[0][SIZE-1] = 1'b0;
        end else begin
            s_woccupied[0][SIZE-1] = s_roccupied[0][SIZE-1];
        end
    end
endmodule