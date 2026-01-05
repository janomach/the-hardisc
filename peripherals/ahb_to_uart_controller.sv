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

import edac::*;

module ahb_to_uart_controller#(
    parameter PERIOD = 10,
    parameter IFP = 0,
    parameter SIMULATION = 0
)
(
    input s_clk_i,
    input s_resetn_i,
    
    //AHB3-Lite
    input [31:0] s_haddr_i,
    input [31:0] s_hwdata_i,
    input s_hready_i,
    input [2:0]s_hburst_i,
    input s_hmastlock_i,
    input [3:0]s_hprot_i,
    input [2:0]s_hsize_i,
    input [1:0]s_htrans_i,
    input s_hwrite_i,
    input s_hsel_i,

    input logic[5:0] s_hparity_i,
    input logic[6:0] s_hwchecksum_i,
    output logic[6:0] s_hrchecksum_o,
    
    output [31:0] s_hrdata_o,
    output s_hready_o,
    output s_hresp_o,

    output s_data_ready_o,

    //UART
    input s_rxd_i,
    output s_txd_o
);
    //Control
    logic r_write, r_uart_active, r_hresp, r_trans, r_add;
    logic r_uart_state, r_uart_accepted;

    logic[5:0] s_parity;
    logic s_wrong_comb, s_parity_error, s_transfer;

generate
    if(IFP == 1)begin
        for (genvar p=0;p<4;p++) begin
            assign s_parity[p]  = s_haddr_i[0 + p] ^ s_haddr_i[4 + p] ^ s_haddr_i[8 + p] ^ s_haddr_i[12 + p] ^
                                s_haddr_i[16 + p] ^ s_haddr_i[20 + p] ^ s_haddr_i[24 + p] ^ s_haddr_i[28 + p];            
        end
        assign s_parity[4]  = (^s_hsize_i) ^ (^s_hburst_i) ^ (^s_hprot_i) ^ s_hwrite_i ^ s_hmastlock_i; //hsize, hwrite, hprot, hburst, hmastlock
        assign s_parity[5]  = (^s_htrans_i); //htrans
        
        assign s_parity_error   = s_parity != s_hparity_i;
        assign s_wrong_comb     = (^s_htrans_i) ^ s_hparity_i[5];
    end else begin
        assign s_parity_error   = 1'b0;
        assign s_wrong_comb     = 1'b0;
    end
endgenerate

    assign s_transfer   = s_wrong_comb | (s_htrans_i == 2'd2);

    //UART
    logic s_uart_start, s_uart_busy, s_uart_data_rdy;
    logic[7:0] s_data, s_rec_data, r_uart_data;

    assign s_hrdata_o = {24'b0, r_add ? {7'b0,r_uart_state} : r_uart_data};
    assign s_hready_o = !(r_hresp & r_trans) & !(r_write & ~r_add);
    assign s_hresp_o  = r_hresp;

    assign s_data_ready_o = r_uart_state;

    assign s_hrchecksum_o = edac_checksum(s_hrdata_o);

    assign s_uart_start   = r_write & ~r_hresp & r_trans & ~r_add;
    assign s_data         = s_hwdata_i[7:0];

    always @ (posedge s_clk_i or negedge s_resetn_i) begin
        if(~s_resetn_i)begin
            r_write         <= 1'd0;
            r_hresp         <= (~s_resetn_i) ? 1'b0 : (r_hresp & r_trans);
            r_trans         <= 1'd0;
            r_add           <= 1'd0;
        end else if(r_write & ~r_add) begin
            r_hresp         <= r_hresp;
            r_write         <= (s_uart_busy | r_trans) ? r_write : 1'd0;
            r_trans         <= 1'd0;
            r_add           <= r_add;
        end else if(s_hsel_i & s_transfer)begin
            r_write         <= !s_parity_error & s_hwrite_i; 
            r_hresp         <= s_parity_error;
            r_trans         <= 1'd1;
            r_add           <= s_haddr_i[2];
        end else begin
            r_hresp         <= 1'd0;
            r_write         <= 1'd0;
            r_trans         <= 1'd0;
            r_add           <= 1'd0;
        end
    end

    always_ff @(posedge s_clk_i or negedge s_resetn_i) begin
        if(~s_resetn_i)begin
            r_uart_data     <= 8'd65;
            r_uart_accepted <= 1'b0;
        end else if(s_uart_data_rdy & ~r_uart_accepted)begin
            r_uart_data     <= s_rec_data;
            r_uart_accepted <= 1'd1;
        end else if(s_uart_data_rdy & r_uart_accepted)begin
            r_uart_data     <= r_uart_data;
            r_uart_accepted <= 1'b1;
        end else begin
            r_uart_data     <= r_uart_data;
            r_uart_accepted <= 1'b0;
        end
        if(~s_resetn_i)begin
            r_uart_state    <= 1'd0;
        end else if(r_write & ~r_hresp & r_trans & r_add) begin
            r_uart_state    <= s_hwdata_i[0];
        end else begin
            r_uart_state    <= r_uart_accepted ? r_uart_state : s_uart_data_rdy;
        end

    end


    uart_controller#(.PERIOD(PERIOD)) uart
    (
        .s_clk_i(s_clk_i),
        .s_resetn_i(s_resetn_i),
        .s_rxd_i(s_rxd_i),
        .s_request_i(s_uart_start),
        .s_txd_o(s_txd_o),
        .s_data_i(s_data),
        .s_data_o(s_rec_data),
        .s_data_ready_o(s_uart_data_rdy),
        .s_busy_o(s_uart_busy)
    );
endmodule
