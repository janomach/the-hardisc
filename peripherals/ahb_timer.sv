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

    logic[31:0] s_read_data, s_write_data;
    logic[MSB:0] r_address, r_paddress, s_ra;
    logic[1:0] r_size;
    logic r_write, r_trans, r_hresp;
    logic[63:0] s_mtime, r_mtimecmp0; 
    logic[7:0] r_mtime[8];
    logic[31:0] r_data, r_wtor_data;
    logic s_wea[4];
    logic s_we, r_wtor, s_cclock, s_parity_error;
    logic s_wrong_comb, s_transfer;

    logic[5:0] s_parity;

    generate
        if(IFP == 1)begin
            assign s_parity_error   = s_parity != s_hparity_i;
            assign s_wrong_comb     = (^s_htrans_i) ^ s_hparity_i[5];
        end else begin
            assign s_parity_error   = 1'b0;
            assign s_wrong_comb     = 1'b0;
        end
    endgenerate

    assign s_we     = r_write;
    assign s_ra     = s_haddr_i[$clog2(MEM_SIZE)-1:0];
    assign r_delay  = 2'b0;

    genvar p;
    generate
        for (p=0;p<4;p++) begin
            assign s_parity[p]  = s_haddr_i[0 + p] ^ s_haddr_i[4 + p] ^ s_haddr_i[8 + p] ^ s_haddr_i[12 + p] ^
                                  s_haddr_i[16 + p] ^ s_haddr_i[20 + p] ^ s_haddr_i[24 + p] ^ s_haddr_i[28 + p];            
        end
    endgenerate

    assign s_parity[4]  = (^s_hsize_i) ^ (^s_hburst_i) ^ (^s_hprot_i) ^ s_hwrite_i ^ s_hmastlock_i; //hsize, hwrite, hprot, hburst, hmastlock
    assign s_parity[5]  = (^s_htrans_i); //htrans

    assign s_transfer   = s_wrong_comb | (s_htrans_i == 2'd2);

    //Forward data if a write is followed by the read from the same address
    assign s_read_data          = (r_wtor & (r_address[MSB:2] == r_paddress[MSB:2])) ? r_wtor_data : r_data;
    assign s_write_data[7:0]    = s_wea[0] ? s_hwdata_i[7:0] : s_read_data[7:0];
    assign s_write_data[15:8]   = s_wea[1] ? s_hwdata_i[15:8] : s_read_data[15:8];
    assign s_write_data[23:16]  = s_wea[2] ? s_hwdata_i[23:16] : s_read_data[23:16];
    assign s_write_data[31:24]  = s_wea[3] ? s_hwdata_i[31:24] : s_read_data[31:24];

    //Timeout
    assign s_timeout_o  = {r_mtime[7],r_mtime[6],r_mtime[5],r_mtime[4],r_mtime[3],r_mtime[2],r_mtime[1],r_mtime[0]} >= r_mtimecmp0;

    //Response
    assign s_hrdata_o   = s_read_data;
    assign s_hready_o   = !(r_hresp & r_trans) & (r_delay == 2'b00);
    assign s_hresp_o    = r_hresp;

    //Select which bytes to overwrite
    assign s_wea[0] = s_we & (r_address[1:0] == 2'd0);
    assign s_wea[1] = s_we & (((r_address[1:0] == 2'd0) & (r_size != 2'd0)) || (r_address[1:0] == 2'd1));
    assign s_wea[2] = s_we & (((r_address[1:0] == 2'd0) & (r_size == 2'd2)) || (r_address[1:0] == 2'd2));
    assign s_wea[3] = s_we & (((r_address[1:0] == 2'd0) & (r_size == 2'd2)) || ((r_address[1:0] == 2'd2) & (r_size == 2'd1)) || (r_address[1:0] == 2'd3));

    assign s_mtime  = {r_mtime[7],r_mtime[6],r_mtime[5],r_mtime[4],r_mtime[3],r_mtime[2],r_mtime[1],r_mtime[0]} + 64'd1;

    generate
    genvar i;
        for (i = 0; i < 4; i = i+1) begin: byte_write
            always @(posedge s_clk_i or negedge s_resetn_i) begin
                //mtime                   
                if(~s_resetn_i)
                    r_mtime[i] <= 8'b0;
                else if(s_wea[i] & (r_address[MSB:2] == 2'd0))
                    r_mtime[i] <= s_hwdata_i[(i+1)*8-1:i*8];
                else
                    r_mtime[i] <= s_mtime[(i+1)*8-1:i*8];
                if(~s_resetn_i)
                    r_mtime[i+4] <= 8'b0;
                else if(s_wea[i] & (r_address[MSB:2] == 2'd1))
                    r_mtime[i+4] <= s_hwdata_i[(i+1)*8-1:i*8];
                else
                    r_mtime[i+4] <= s_mtime[(i+1)*8-1 +32:i*8 +32];
            end
            always @(posedge s_clk_i) begin
                //mtimecmp0
                if(s_wea[i] & (r_address[MSB:2] == 2'd2))
                    r_mtimecmp0[(i+1)*8-1:i*8] <= s_hwdata_i[(i+1)*8-1:i*8];
                if(s_wea[i] & (r_address[MSB:2] == 2'd3))
                    r_mtimecmp0[(i+1)*8-1 +32:i*8 +32] <= s_hwdata_i[(i+1)*8-1:i*8];
            end
        end
        if (IFP == 1) begin
            assign s_hrchecksum_o = edac_checksum(s_read_data);    
        end else begin
            assign s_hrchecksum_o = 7'b0;
        end
    endgenerate

    //Data are read in the address phase
    always_ff @(posedge s_clk_i) begin : memory_read
        case (s_ra[MSB:2])
            2'd0: r_data <= {r_mtime[3],r_mtime[2],r_mtime[1],r_mtime[0]}; 
            2'd1: r_data <= {r_mtime[7],r_mtime[6],r_mtime[5],r_mtime[4]}; 
            2'd2: r_data <= r_mtimecmp0[31:0]; 
            default: r_data <= r_mtimecmp0[63:32]; 
        endcase
    end

    //Save transfer information
    always_ff @(posedge s_clk_i or negedge s_resetn_i) begin : memory_control
        if(~s_resetn_i | (r_hresp & r_trans))begin
            r_trans <= 1'd0;
            r_write <= 1'd0;
            r_address <= {1'b0,{MSB{1'b0}}};
            r_paddress <= {1'b0,{MSB{1'b0}}};
            r_wtor_data <= 32'b0;
            r_size <= 2'd0;
            r_wtor <= 1'b0;
            r_hresp <= (~s_resetn_i) ? 1'b0 : (r_hresp & r_trans);
        end else if(s_hsel_i & s_transfer)begin
            r_trans <= 1'd1;
            r_write <= !s_parity_error & s_hwrite_i;
            r_address <= s_haddr_i[$clog2(MEM_SIZE)-1:0];
            r_paddress <= r_address;
            r_wtor_data <= s_write_data;
            r_size <= s_hsize_i[1:0];
            r_wtor <= !s_parity_error & s_we;
            r_hresp <= s_parity_error;
        end else begin
            r_trans <= 1'd0;
            r_write <= 1'd0;
            r_address <= r_address;
            r_paddress <= r_address;
            r_wtor_data <= r_wtor_data;
            r_size <= 2'd0;
            r_wtor <= 1'b0;
            r_hresp <= 1'b0;
        end
    end
endmodule
