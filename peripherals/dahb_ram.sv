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
    parameter GROUP = 1,
    parameter MPROB = 1,
    parameter IFP = 0,
    parameter MEM_INIT = 0,
    parameter MEM_FILE = "SPECIFY",
    parameter LABEL = "MEMORY"
)
(
    input logic s_clk_i,
    input logic s_resetn_i,
    
    //AHB3-Lite
    input logic[31:0] s_haddr_i[2],
    input logic[31:0] s_hwdata_i[2],
    input logic[2:0] s_hburst_i[2],
    input logic s_hmastlock_i[2],
    input logic[3:0] s_hprot_i[2],
    input logic[2:0] s_hsize_i[2],
    input logic[1:0] s_htrans_i[2],
    input logic s_hwrite_i[2],
    input logic s_hsel_i[2],
    
    input logic[5:0] s_hparity_i[2],
    input logic[6:0] s_hwchecksum_i[2],
    output logic[6:0] s_hrchecksum_o[2],

    output logic[31:0] s_hrdata_o[2],
    output logic s_hready_o[2],
    output logic s_hresp_o[2]
);
    /* Control module that provides access from two AHB masters to a single dual-port RAM */
    logic[31:0] r_address[2];
    logic[2:0] r_size[2];
    logic[1:0] r_trans[2];
    logic r_write[2];
    logic r_selected;
    logic[5:0] r_parity[2];
    logic s_wrong_comb[2], s_rwrong_comb[2], s_transfer[2], s_rtransfer[2];

    logic[31:0] s_haddr;
    logic[31:0] s_hwdata;
    logic[2:0]s_hsize;
    logic[1:0]s_htrans;
    logic s_hwrite;
    logic s_hsel;

    logic[31:0] s_hrdata;
    logic s_hready;
    logic s_hresp;
    logic[6:0] s_hwchecksum, s_hrchecksum;
    logic[5:0] s_hparity;

    generate
        if(IFP == 1)begin
            assign s_wrong_comb[0]  = (^s_htrans_i[0]) ^ s_hparity_i[0][5];
            assign s_wrong_comb[1]  = (^s_htrans_i[1]) ^ s_hparity_i[1][5];
            assign s_rwrong_comb[0] = (^r_trans[0]) ^ r_parity[0][5];
            assign s_rwrong_comb[1] = (^r_trans[1]) ^ r_parity[1][5];
        end else begin
            assign s_wrong_comb[0]  = 1'b0;
            assign s_wrong_comb[1]  = 1'b0;
            assign s_rwrong_comb[0] = 1'b0;
            assign s_rwrong_comb[1] = 1'b0;
        end
    endgenerate

    assign s_transfer[0]    = s_wrong_comb[0] | (s_htrans_i[0] == 2'd2);
    assign s_transfer[1]    = s_wrong_comb[1] | (s_htrans_i[1] == 2'd2);
    assign s_rtransfer[0]   = s_rwrong_comb[0] | (r_trans[0] == 2'd2);
    assign s_rtransfer[1]   = s_rwrong_comb[1] | (r_trans[1] == 2'd2);

    //Control which master has granted access to the RAM; the Master 0 is prioritized
    always_comb begin
        if((~s_rtransfer[0] & ~s_rtransfer[1]) | (s_rtransfer[0] != s_rtransfer[1]))begin
            s_hparity   = (s_hsel_i[0] & s_transfer[0]) ? s_hparity_i[0] : s_hparity_i[1];
            s_haddr     = (s_hsel_i[0] & s_transfer[0]) ? s_haddr_i[0] : s_haddr_i[1];
            s_hsize     = (s_hsel_i[0] & s_transfer[0]) ? s_hsize_i[0] : s_hsize_i[1];
            s_htrans    = (s_hsel_i[0] & s_transfer[0]) ? s_htrans_i[0] : s_htrans_i[1];
            s_hwrite    = (s_hsel_i[0] & s_transfer[0]) ? s_hwrite_i[0] : s_hwrite_i[1];
            s_hsel      = (s_hsel_i[0] & s_transfer[0]) | (s_hsel_i[1] & s_transfer[1]);
        end else begin
            s_hparity   = r_selected ? r_parity[0] : r_parity[1];
            s_haddr     = r_selected ? r_address[0] : r_address[1];
            s_hsize     = r_selected ? r_size[0] : r_size[1];
            s_hwrite    = r_selected ? r_write[0] : r_write[1];
            s_htrans    = r_selected ? r_trans[0] : r_trans[1];
            s_hsel      = 1'b1;
        end
        s_hwdata        = r_selected ? s_hwdata_i[1] : s_hwdata_i[0];
        s_hwchecksum    = r_selected ? s_hwchecksum_i[1] : s_hwchecksum_i[0];
    end

    //Response for Master 0
    assign s_hrdata_o[0] = s_hrdata;
    assign s_hready_o[0] = s_rtransfer[0] ? ((r_selected == 1'd1) ? 1'b0 : s_hready) : 1'b1;
    assign s_hresp_o[0]  = s_rtransfer[0] ? ((r_selected == 1'd1) ? 1'b0 : s_hresp) : 1'b0;
    assign s_hrchecksum_o[0] = s_hrchecksum;

    //Response for Master 1
    assign s_hrdata_o[1] = s_hrdata;
    assign s_hready_o[1] = s_rtransfer[1] ? ((r_selected == 1'd0) ? 1'b0 : s_hready) : 1'b1;
    assign s_hresp_o[1]  = s_rtransfer[1] ? ((r_selected == 1'd0) ? 1'b0 : s_hresp) : 1'b0;
    assign s_hrchecksum_o[1] = s_hrchecksum;

    //Dual-port RAM
    ahb_ram #(.MEM_SIZE(MEM_SIZE),.SIMULATION(SIMULATION),.MEM_INIT(MEM_INIT),.MEM_FILE(MEM_FILE),.ENABLE_LOG(ENABLE_LOG),.LABEL(LABEL),.IFP(IFP),.GROUP(GROUP),.MPROB(MPROB)) ahb_dmem
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

        .s_hparity_i(s_hparity),
        .s_hwchecksum_i(s_hwchecksum),
        .s_hrchecksum_o(s_hrchecksum),
        
        .s_hrdata_o(s_hrdata),
        .s_hready_o(s_hready),
        .s_hresp_o(s_hresp)
    );   

    //Save the transfer information from Master 0
    always_ff @(posedge s_clk_i or negedge s_resetn_i) begin
        if(~s_resetn_i)begin
            r_parity[0]     <= 6'b0;
            r_trans[0]      <= 2'd0;
            r_write[0]      <= 1'd0;
            r_address[0]    <= 32'b0;
            r_size[0]       <= 3'd0;
        end else if(~s_hready_o[0])begin
            r_parity[0]     <= r_parity[0];
            r_trans[0]      <= r_trans[0];
            r_write[0]      <= r_write[0];
            r_address[0]    <= r_address[0];
            r_size[0]       <= r_size[0];
        end else if(s_hsel_i[0] & s_transfer[0])begin
            r_parity[0]     <= s_hparity_i[0];
            r_trans[0]      <= s_htrans_i[0];
            r_write[0]      <= s_hwrite_i[0];
            r_address[0]    <= s_haddr_i[0];
            r_size[0]       <= s_hsize_i[0][1:0];
        end else begin
            r_parity[0]     <= 6'b0;
            r_trans[0]      <= 2'd0;
            r_write[0]      <= 1'd0;
            r_address[0]    <= 32'b0;
            r_size[0]       <= 3'd0;
        end
    end

    //Save the transfer information from Master 1
    always_ff @(posedge s_clk_i or negedge s_resetn_i) begin
        if(~s_resetn_i)begin
            r_parity[1]     <= 6'b0;
            r_trans[1]      <= 2'd0;
            r_write[1]      <= 1'd0;
            r_address[1]    <= 32'b0;
            r_size[1]       <= 3'd0;
        end else if(~s_hready_o[1])begin
            r_parity[1]     <= r_parity[1];
            r_trans[1]      <= r_trans[1];
            r_write[1]      <= r_write[1];
            r_address[1]    <= r_address[1];
            r_size[1]       <= r_size[1];
        end else if(s_hsel_i[1] & s_transfer[1])begin
            r_parity[1]     <= s_hparity_i[1];
            r_trans[1]      <= s_htrans_i[1];
            r_write[1]      <= s_hwrite_i[1];
            r_address[1]    <= s_haddr_i[1];
            r_size[1]       <= s_hsize_i[1][1:0];
        end else begin
            r_parity[1]     <= 6'b0;
            r_trans[1]      <= 2'd0;
            r_write[1]      <= 1'd0;
            r_address[1]    <= 32'b0;
            r_size[1]       <= 3'd0;
        end
    end

    //Save information, which master requested the last transfer
    always @ (posedge s_clk_i or negedge s_resetn_i) begin
        if(~s_resetn_i) begin
            r_selected  <= 1'd0;
        end else if(~s_hready)begin
            r_selected  <= r_selected;
        end else if(s_rtransfer[0] & (r_selected == 1'd1)) begin
            r_selected  <= 1'd0;
        end else if(s_rtransfer[1] & (r_selected == 1'd0)) begin
            r_selected  <= 1'd1;
        end else if(s_transfer[0] & s_hsel_i[0]) begin
            r_selected  <= 1'd0;
        end else if(s_transfer[1] & s_hsel_i[1]) begin
            r_selected  <= 1'd1;
        end else begin
            r_selected  <= r_selected;
        end
    end
endmodule
