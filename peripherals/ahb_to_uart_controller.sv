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
    // AHB controller API
    logic s_ap_detected, s_dp_accepted, s_dp_write, s_dp_delay;
    logic[31:0] s_dp_address;
    logic[1:0] s_dp_size;

    // UART TX state machine: stalls the bus during UART transmission
    // IDLE -> PEND (address phase seen) -> BUSY (uart active) -> IDLE
    localparam logic[1:0] UART_IDLE = 2'b00;
    localparam logic[1:0] UART_PEND = 2'b01;
    localparam logic[1:0] UART_BUSY = 2'b10;
    logic[1:0] r_uart_tx;

    logic s_uart_start, s_uart_busy, s_uart_data_rdy;
    logic[7:0] s_rec_data, r_uart_data;
    logic r_uart_state, r_uart_accepted;

    // Start UART transmit when entering the data phase of a write to address[2]==0
    assign s_uart_start = (r_uart_tx == UART_PEND) & s_dp_accepted & s_dp_write & ~s_dp_address[2];
    // Stall bus while UART transmit is pending or in progress
    assign s_dp_delay   = (r_uart_tx != UART_IDLE) & s_dp_write & ~s_dp_address[2];

    always_ff @(posedge s_clk_i or negedge s_resetn_i) begin
        if(~s_resetn_i) begin
            r_uart_tx <= UART_IDLE;
        end else begin
            case(r_uart_tx)
                UART_IDLE:
                    if(s_ap_detected & s_hwrite_i & ~s_haddr_i[2])
                        r_uart_tx <= UART_PEND;
                UART_PEND:
                    if(s_uart_start)
                        r_uart_tx <= UART_BUSY;
                    else if(!s_dp_accepted)
                        r_uart_tx <= UART_IDLE;
                UART_BUSY:
                    if(~s_uart_busy)
                        r_uart_tx <= UART_IDLE;
                default: 
                    r_uart_tx <= UART_IDLE;
            endcase
        end
    end

    assign s_hrdata_o     = {24'b0, s_dp_address[2] ? {7'b0, r_uart_state} : r_uart_data};
    assign s_hrchecksum_o = edac_checksum(s_hrdata_o);
    assign s_data_ready_o = r_uart_state;

    always_ff @(posedge s_clk_i or negedge s_resetn_i) begin
        if(~s_resetn_i) begin
            r_uart_data     <= 8'd65;
            r_uart_accepted <= 1'b0;
        end else if(s_uart_data_rdy & ~r_uart_accepted) begin
            r_uart_data     <= s_rec_data;
            r_uart_accepted <= 1'd1;
        end else if(s_uart_data_rdy & r_uart_accepted) begin
            r_uart_data     <= r_uart_data;
            r_uart_accepted <= 1'b1;
        end else begin
            r_uart_data     <= r_uart_data;
            r_uart_accepted <= 1'b0;
        end
        if(~s_resetn_i)
            r_uart_state    <= 1'd0;
        else if(s_dp_accepted & s_dp_write & s_dp_address[2])
            r_uart_state    <= s_hwdata_i[0];
        else if(!r_uart_accepted)
            r_uart_state    <= s_uart_data_rdy;
    end

    ahb_controller_m #(.IFP(IFP)) ahb_ctrl
    (
        .s_clk_i(s_clk_i),
        .s_resetn_i(s_resetn_i),
        .s_haddr_i(s_haddr_i),
        .s_hburst_i(s_hburst_i),
        .s_hmastlock_i(s_hmastlock_i),
        .s_hprot_i(s_hprot_i),
        .s_hsize_i(s_hsize_i),
        .s_htrans_i(s_htrans_i),
        .s_hwrite_i(s_hwrite_i),
        .s_hsel_i(s_hsel_i),
        .s_hparity_i(s_hparity_i),
        .s_hready_o(s_hready_o),
        .s_hresp_o(s_hresp_o),
        .s_ap_error_i(1'b0),
        .s_dp_delay_i(s_dp_delay),
        .s_ap_detected_o(s_ap_detected),
        .s_dp_accepted_o(s_dp_accepted),
        .s_dp_address_o(s_dp_address),
        .s_dp_write_o(s_dp_write),
        .s_dp_size_o(s_dp_size)
    );

    uart_controller#(.PERIOD(PERIOD)) uart
    (
        .s_clk_i(s_clk_i),
        .s_resetn_i(s_resetn_i),
        .s_rxd_i(s_rxd_i),
        .s_request_i(s_uart_start),
        .s_txd_o(s_txd_o),
        .s_data_i(s_hwdata_i[7:0]),
        .s_data_o(s_rec_data),
        .s_data_ready_o(s_uart_data_rdy),
        .s_busy_o(s_uart_busy)
    );
endmodule
