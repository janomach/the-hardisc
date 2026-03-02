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

module ahb_timer#(
    parameter IFP = 0
)
(
    input logic s_clk_i,
    input logic s_resetn_i,
    
    //AHB3-Lite
    input logic[31:0] s_haddr_i,
    input logic[31:0] s_hwdata_i,
    input logic[2:0] s_hburst_i,
    input logic s_hmastlock_i,
    input logic[3:0] s_hprot_i,
    input logic[2:0] s_hsize_i,
    input logic[1:0] s_htrans_i,
    input logic s_hwrite_i,
    input logic s_hsel_i,

    input logic[5:0] s_hparity_i,
    input logic[6:0] s_hwchecksum_i,
    output logic[6:0] s_hrchecksum_o,
    
    output logic[31:0] s_hrdata_o,
    output logic s_hready_o,
    output logic s_hresp_o,

    output logic s_timeout_o
);
    /* Simple ACLINT MTIMER with AMBA 3 AHB-Lite interface 
       Specification: https://github.com/riscv/riscv-aclint
       Current version implements a single 8-byte MTIME register and a single 8-byte MTIMECMP register. */
    localparam MEM_SIZE = 32'd16;
    localparam MSB = $clog2(MEM_SIZE) - 32'h1;

    logic[31:0] s_read_data, s_dp_address;
    logic[63:0] s_mtime, r_mtimecmp0;
    logic[7:0] r_mtime[8];
    logic s_we, s_wea[4];
    logic s_ap_detected, s_dp_accepted, s_dp_write;
    logic[1:0] s_dp_size;

    //Timeout
    assign s_timeout_o  = {r_mtime[7],r_mtime[6],r_mtime[5],r_mtime[4],r_mtime[3],r_mtime[2],r_mtime[1],r_mtime[0]} >= r_mtimecmp0;

    //Response
    assign s_hrdata_o   = s_read_data;

    //Select which bytes to overwrite
    assign s_we     = s_dp_accepted & s_dp_write;

    assign s_wea[0] = s_we & (s_dp_address[1:0] == 2'd0);
    assign s_wea[1] = s_we & (((s_dp_address[1:0] == 2'd0) & (s_dp_size != 2'd0)) || (s_dp_address[1:0] == 2'd1));
    assign s_wea[2] = s_we & (((s_dp_address[1:0] == 2'd0) & (s_dp_size == 2'd2)) || (s_dp_address[1:0] == 2'd2));
    assign s_wea[3] = s_we & (((s_dp_address[1:0] == 2'd0) & (s_dp_size == 2'd2)) || ((s_dp_address[1:0] == 2'd2) & (s_dp_size == 2'd1)) || (s_dp_address[1:0] == 2'd3));

    assign s_mtime  = {r_mtime[7],r_mtime[6],r_mtime[5],r_mtime[4],r_mtime[3],r_mtime[2],r_mtime[1],r_mtime[0]} + 64'd1;

    generate
        for (genvar i = 0; i < 4; i = i+1) begin: byte_write
            always @(posedge s_clk_i or negedge s_resetn_i) begin
                //mtime                   
                if(~s_resetn_i)
                    r_mtime[i] <= 8'b0;
                else if(s_wea[i] & (s_dp_address[MSB:2] == 2'd0))
                    r_mtime[i] <= s_hwdata_i[(i+1)*8-1:i*8];
                else
                    r_mtime[i] <= s_mtime[(i+1)*8-1:i*8];
                if(~s_resetn_i)
                    r_mtime[i+4] <= 8'b0;
                else if(s_wea[i] & (s_dp_address[MSB:2] == 2'd1))
                    r_mtime[i+4] <= s_hwdata_i[(i+1)*8-1:i*8];
                else
                    r_mtime[i+4] <= s_mtime[(i+1)*8-1 +32:i*8 +32];
            end
            always @(posedge s_clk_i) begin
                //mtimecmp0
                if(s_wea[i] & (s_dp_address[MSB:2] == 2'd2))
                    r_mtimecmp0[(i+1)*8-1:i*8] <= s_hwdata_i[(i+1)*8-1:i*8];
                if(s_wea[i] & (s_dp_address[MSB:2] == 2'd3))
                    r_mtimecmp0[(i+1)*8-1 +32:i*8 +32] <= s_hwdata_i[(i+1)*8-1:i*8];
            end
        end
        if (IFP == 1) begin
            assign s_hrchecksum_o = edac_checksum(s_read_data);    
        end else begin
            assign s_hrchecksum_o = 7'b0;
        end
    endgenerate

    //Data are read combinationally in the data phase
    always_comb begin : timer_read
        case (s_dp_address[MSB:2])
            2'd0: s_read_data = {r_mtime[3],r_mtime[2],r_mtime[1],r_mtime[0]};
            2'd1: s_read_data = {r_mtime[7],r_mtime[6],r_mtime[5],r_mtime[4]};
            2'd2: s_read_data = r_mtimecmp0[31:0];
            default: s_read_data = r_mtimecmp0[63:32];
        endcase
    end

    ahb_controller_m #(.IFP(IFP)) ahb_ctrl
    (
        .s_clk_i(s_clk_i),
        .s_resetn_i(s_resetn_i),
        
        // AHB3-Lite
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

        // API
        .s_ap_error_i(1'b0),
        .s_dp_delay_i(1'b0),

        .s_ap_detected_o(s_ap_detected),
        .s_dp_accepted_o(s_dp_accepted),
        .s_dp_address_o(s_dp_address),
        .s_dp_write_o(s_dp_write),
        .s_dp_size_o(s_dp_size)
    );

endmodule
