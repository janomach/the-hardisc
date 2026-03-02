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

module ahb_controller_m #(
    parameter IFP = 0
)
(
    input logic s_clk_i,
    input logic s_resetn_i,
    
    // AHB3-Lite
    input logic[31:0] s_haddr_i,
    input logic[2:0] s_hburst_i,
    input logic s_hmastlock_i,
    input logic[3:0] s_hprot_i,
    input logic[2:0] s_hsize_i,
    input logic[1:0] s_htrans_i,
    input logic s_hwrite_i,
    input logic s_hsel_i,

    input logic[5:0] s_hparity_i,
    
    output logic s_hready_o,
    output logic s_hresp_o,

    // API
    input logic s_ap_error_i,
    input logic s_dp_delay_i,

    output logic s_ap_detected_o, 
    output logic s_dp_accepted_o,
    output logic[31:0] s_dp_address_o,
    output logic s_dp_write_o,
    output logic [1:0] s_dp_size_o
);
    logic[31:0] r_address;
    logic[1:0] r_size;
    logic r_write, r_trans, r_hresp;
    logic s_ap_error, s_dp_delayed, s_dp_accepted;
    logic s_wrong_comb, s_transfer;

    assign s_ap_detected_o = s_transfer;
    assign s_dp_accepted_o = s_dp_accepted;

    assign s_dp_address_o = r_address;
    assign s_dp_write_o = r_write;
    assign s_dp_size_o  = r_size;

    assign s_hready_o   = s_dp_delayed ? 1'b0 : !(r_hresp & r_trans);
    assign s_hresp_o    = r_hresp;

    generate
        if(IFP == 1)begin
            logic[5:0] s_parity;

            for (genvar p=0;p<4;p++) begin
                assign s_parity[p]  = s_haddr_i[0 + p] ^ s_haddr_i[4 + p] ^ s_haddr_i[8 + p] ^ s_haddr_i[12 + p] ^
                                    s_haddr_i[16 + p] ^ s_haddr_i[20 + p] ^ s_haddr_i[24 + p] ^ s_haddr_i[28 + p];            
            end

            assign s_parity[4]  = (^s_hsize_i) ^ (^s_hburst_i) ^ (^s_hprot_i) ^ s_hwrite_i ^ s_hmastlock_i; //hsize, hwrite, hprot, hburst, hmastlock
            assign s_parity[5]  = (^s_htrans_i); //htrans

            assign s_ap_error   = s_ap_error_i || (s_parity != s_hparity_i);
            assign s_wrong_comb = (^s_htrans_i) ^ s_hparity_i[5];
        end else begin
            assign s_ap_error   = s_ap_error_i;
            assign s_wrong_comb = 1'b0;
        end
    endgenerate

    assign s_transfer   = s_hsel_i & (s_wrong_comb | (s_htrans_i == 2'd2));

    assign s_dp_accepted = r_trans & !r_hresp;
    assign s_dp_delayed  = s_dp_delay_i & s_dp_accepted;

    //Save transfer information
    always_ff @(posedge s_clk_i or negedge s_resetn_i) begin : transfer_control
        if(~s_resetn_i)begin
            r_trans <= 1'd0;
            r_write <= 1'd0;
            r_size <= 2'd2;
        end else if(!s_dp_delayed) begin
            if(s_transfer) begin
                r_trans <= 1'd1;
                r_write <= !s_ap_error & s_hwrite_i;
                r_address <= s_haddr_i;
                r_size <= s_hsize_i[1:0];
            end else begin
                r_trans <= 1'd0;
                r_write <= 1'd0;
                r_size <= 2'd2;
            end
        end
    end

    always_ff @(posedge s_clk_i or negedge s_resetn_i) begin : hresp_control
        if(~s_resetn_i)begin
            r_hresp <= 1'b0;
        end else if(r_hresp & r_trans)begin
            r_hresp <= 1'b1;
        end else if(s_transfer & !s_dp_delayed)begin
            r_hresp <= s_ap_error;
        end
    end
endmodule
