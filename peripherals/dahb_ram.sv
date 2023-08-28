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

module dahb_ram#(
    parameter MEM_SIZE = 32'h00001000,
    parameter SIMULATION = 0,
    parameter ENABLE_LOG = 1,
    parameter LABEL = "MEMORY"
)
(
    input s_clk_i,
    input s_resetn_i,
    
    //AHB3-Lite
    input [$clog2(MEM_SIZE)-1:0] s_haddr_i[2],
    input [31:0] s_hwdata_i[2],
    input [2:0]s_hburst_i[2],
    input s_hmastlock_i[2],
    input [3:0]s_hprot_i[2],
    input [2:0]s_hsize_i[2],
    input [1:0]s_htrans_i[2],
    input s_hwrite_i[2],
    input s_hsel_i[2],
    
    output [31:0] s_hrdata_o[2],
    output s_hready_o[2],
    output s_hresp_o[2]
);
    localparam MSB = $clog2(MEM_SIZE) - 32'h1;

    logic[MSB:0] r_address[2];
    logic[1:0] r_size[2];
    logic r_write[2], r_trans[2];
    logic r_selected;

    logic[MSB:0] s_haddr;
    logic[31:0] s_hwdata;
    logic[2:0]s_hsize;
    logic[1:0]s_htrans;
    logic s_hwrite;
    logic s_hsel;

    logic[31:0] s_hrdata;
    logic s_hready;
    logic s_hresp;

    always_comb begin
        if((~r_trans[0] & ~r_trans[1]) | (r_trans[0] != r_trans[1]))begin
            s_haddr     = (s_hsel_i[0] & (s_htrans_i[0] == 2'd2)) ? s_haddr_i[0] : s_haddr_i[1];
            s_hsize     = (s_hsel_i[0] & (s_htrans_i[0] == 2'd2)) ? s_hsize_i[0] : s_hsize_i[1];
            s_htrans    = (s_hsel_i[0] & (s_htrans_i[0] == 2'd2)) ? s_htrans_i[0] : s_htrans_i[1];
            s_hwrite    = (s_hsel_i[0] & (s_htrans_i[0] == 2'd2)) ? s_hwrite_i[0] : s_hwrite_i[1];
            s_hsel      = (s_hsel_i[0] & (s_htrans_i[0] == 2'd2)) | (s_hsel_i[1] & (s_htrans_i[1] == 2'd2));
        end else begin
            s_haddr     = r_selected ? r_address[0] : r_address[1];
            s_hsize     = r_selected ? {1'b0,r_size[0]} : {1'b0,r_size[1]};
            s_hwrite    = r_selected ? r_write[0] : r_write[1];
            s_htrans    = 2'd2;
            s_hsel      = 1'b1;
        end
        s_hwdata    = r_selected ? s_hwdata_i[1] : s_hwdata_i[0];
    end

    assign s_hrdata_o[0] = s_hrdata;
    assign s_hready_o[0] = r_trans[0] ? ((r_selected == 1'd1) ? 1'b0 : s_hready) : 1'b1;
    assign s_hresp_o[0]  = r_trans[0] ? ((r_selected == 1'd1) ? 1'b0 : s_hresp) : 1'b0;

    assign s_hrdata_o[1] = s_hrdata;
    assign s_hready_o[1] = r_trans[1] ? ((r_selected == 1'd0) ? 1'b0 : s_hready) : 1'b1;
    assign s_hresp_o[1]  = r_trans[1] ? ((r_selected == 1'd0) ? 1'b0 : s_hresp) : 1'b0;

    ahb_ram #(.MEM_SIZE(MEM_SIZE),.SIMULATION(SIMULATION),.ENABLE_LOG(ENABLE_LOG),.LABEL(LABEL)) ahb_dmem
    (
        .s_clk_i(s_clk_i),
        .s_resetn_i(s_resetn_i),
        
        //AHB3-Lite
        .s_haddr_i(s_haddr),
        .s_hwdata_i(s_hwdata),
        .s_hburst_i(3'b0),
        .s_hmastlock_i(1'b0),
        .s_hprot_i(4'b0),
        .s_hsize_i(s_hsize),
        .s_htrans_i(s_htrans),
        .s_hwrite_i(s_hwrite),
        .s_hsel_i(s_hsel),
        
        .s_hrdata_o(s_hrdata),
        .s_hready_o(s_hready),
        .s_hresp_o(s_hresp)
    );

    always_ff @(posedge s_clk_i) begin
        if(~s_resetn_i)begin
            r_trans[0]      <= 1'd0;
            r_write[0]      <= 1'd0;
            r_address[0]    <= {1'b0,{MSB{1'b0}}};
            r_size[0]       <= 2'd0;
        end else if(~s_hready_o[0])begin
            r_trans[0]      <= r_trans[0];
            r_write[0]      <= r_write[0];
            r_address[0]    <= r_address[0];
            r_size[0]       <= r_size[0];
        end else if(s_hsel_i[0] & (s_htrans_i[0] == 2'd2))begin
            r_trans[0]      <= 1'd1;
            r_write[0]      <= s_hwrite_i[0];
            r_address[0]    <= s_haddr_i[0];
            r_size[0]       <= s_hsize_i[0][1:0];
        end else begin
            r_trans[0]      <= 1'd0;
            r_write[0]      <= 1'd0;
            r_address[0]    <= {1'b0,{MSB{1'b0}}};
            r_size[0]       <= 2'd0;
        end
    end

    always_ff @(posedge s_clk_i) begin
        if(~s_resetn_i)begin
            r_trans[1]      <= 1'd0;
            r_write[1]      <= 1'd0;
            r_address[1]    <= {1'b0,{MSB{1'b0}}};
            r_size[1]       <= 2'd0;
        end else if(~s_hready_o[1])begin
            r_trans[1]      <= r_trans[1];
            r_write[1]      <= r_write[1];
            r_address[1]    <= r_address[1];
            r_size[1]       <= r_size[1];
        end else if(s_hsel_i[1] & (s_htrans_i[1] == 2'd2))begin
            r_trans[1]      <= 1'd1;
            r_write[1]      <= s_hwrite_i[1];
            r_address[1]    <= s_haddr_i[1];
            r_size[1]       <= s_hsize_i[1][1:0];
        end else begin
            r_trans[1]      <= 1'd0;
            r_write[1]      <= 1'd0;
            r_address[1]    <= {1'b0,{MSB{1'b0}}};
            r_size[1]       <= 2'd0;
        end
    end

    always @ (posedge(s_clk_i)) begin
        if(~s_resetn_i) begin
            r_selected  <= 1'd0;
        end else if(~s_hready)begin
            r_selected  <= r_selected;
        end else if(r_trans[0] & (r_selected == 1'd1)) begin
            r_selected  <= 1'd0;
        end else if(r_trans[1] & (r_selected == 1'd0)) begin
            r_selected  <= 1'd1;
        end else if((s_htrans_i[0] == 2'd2) & s_hsel_i[0]) begin
            r_selected  <= 1'd0;
        end else if((s_htrans_i[1] == 2'd2) & s_hsel_i[1]) begin
            r_selected  <= 1'd1;
        end else begin
            r_selected  <= r_selected;
        end
    end
endmodule
