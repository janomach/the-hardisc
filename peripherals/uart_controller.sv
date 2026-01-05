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

module uart_controller#(
    parameter PERIOD = 10400
)
(
    input s_clk_i,
    input s_resetn_i,
    input s_rxd_i,
    input s_request_i,
    input [7:0] s_data_i,
    output s_txd_o,
    output [7:0] s_data_o,
    output s_data_ready_o,
    output s_busy_o
);
localparam HALF_PERIOD = PERIOD / 2;

reg[1:0] r_tx_state, r_rx_state;
reg[2:0] r_tx_count, r_rx_count;
reg[7:0] r_tx_data, r_rx_data;
reg[13:0] r_tx_timer, r_rx_timer;

assign s_txd_o          = ((r_tx_state == 2'd0) | (r_tx_state == 2'd3)) ? 1'b1 : (r_tx_state == 2'd1) ? 1'b0 : r_tx_data[r_tx_count];
assign s_data_ready_o   = r_rx_state == 2'd3;
assign s_data_o         = r_rx_data;
assign s_busy_o         = (r_rx_state != 2'd0) | (r_tx_state != 2'd0);
                                    
always @ (posedge s_clk_i or negedge s_resetn_i) begin
    if(s_resetn_i == 1'b0)begin
        r_tx_state <= 2'd0;
        r_tx_count <= 3'd0;
        r_tx_timer <= 14'd0;
        r_tx_data <= 8'd0;
    end else begin
        if(s_request_i & (r_tx_state == 2'd0))begin
            r_tx_state <= 2'd1;
            r_tx_count <= 3'd0;
            r_tx_timer <= 14'd0;
            r_tx_data <= s_data_i;
        end else if((r_tx_timer > PERIOD)) begin
            if(r_tx_state == 2'd1)begin
                r_tx_state <= 2'd2;
                r_tx_count <= 3'd0;
            end else if(r_tx_state == 2'd2)begin
                r_tx_state <= (r_tx_count == 3'd7) ? 2'd3 : r_tx_state;
                r_tx_count <= r_tx_count + 3'd1;
            end else begin
                r_tx_state <= 2'd0;
                r_tx_count <= 3'd0;
            end  
            r_tx_timer <= 14'd0;  
            r_tx_data <= r_tx_data;       
        end else begin
            r_tx_state <= r_tx_state;
            r_tx_count <= r_tx_count;
            r_tx_timer <= r_tx_timer + 14'd1;
            r_tx_data <= r_tx_data; 
        end
    end    
end

always @ (posedge s_clk_i or negedge s_resetn_i) begin
    if(~s_resetn_i)begin
        r_rx_state <= 2'd0;
        r_rx_count <= 3'd0;
        r_rx_timer <= 14'd0;
        r_rx_data <= 8'd64;
    end else begin
        if((s_rxd_i == 1'b0) & (r_rx_state == 2'd0))begin
            r_rx_state <= 2'd1;
            r_rx_count <= 3'd0;
            r_rx_timer <= HALF_PERIOD[13:0];
            r_rx_data <= 8'd0;
        end else if((r_rx_state != 2'd0) & (r_rx_timer > PERIOD[13:0])) begin
            if(r_rx_state == 2'd1)begin
                r_rx_state <= 2'd2;
                r_rx_count <= 3'd0;
                r_rx_data <= 8'd0;
            end else if(r_rx_state == 2'd2)begin
                r_rx_state <= (r_rx_count == 3'd7) ? 2'd3 : r_rx_state;
                r_rx_count <= r_rx_count + 3'd1;
                r_rx_data <= r_rx_data | (s_rxd_i << r_rx_count);
            end else begin
                r_rx_state <= 2'd0;
                r_rx_count <= 3'd0;
                r_rx_data <= r_rx_data;
            end  
            r_rx_timer <= 14'd0;         
        end else begin
            r_rx_state <= r_rx_state;
            r_rx_count <= r_rx_count;
            r_rx_timer <= r_rx_timer + {13'd0, r_rx_state != 2'd0};
            r_rx_data <= r_rx_data; 
        end
    end    
end                   

endmodule
