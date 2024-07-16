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

module ahb_interconnect #(
    parameter SLAVES=1
)
(
    input logic s_clk_i,
    input logic s_resetn_i,
    
    //AHB3-Lite
    input logic[31:0] s_mhaddr_i,
    input logic[1:0] s_mhtrans_i,

    input logic[31:0] s_sbase_i[SLAVES],
    input logic[31:0] s_smask_i[SLAVES],

    input logic[31:0] s_shrdata_i[SLAVES],
    input logic s_shready_i[SLAVES],
    input logic s_shresp_i[SLAVES],
    output logic s_hsel_o[SLAVES],

    input logic[6:0] s_shrchecksum_i[SLAVES],
    output logic[6:0] s_shrchecksum_o,
    
    output logic[31:0] s_shrdata_o,
    output logic  s_shready_o,
    output logic s_shresp_o
);
    /* Simplified implementation of AMBA 3 AHB-Lite interconnect */
    localparam SELMSB = (SLAVES < 32'd2) ? 32'd0 : ($clog2(SLAVES)-1);
    logic[SELMSB:0] r_selected, s_selected[SLAVES];
    logic[SLAVES-1:0]s_slave_range;
    logic r_active, s_stall;

    //Select appropriate signals for the master
    assign s_shrchecksum_o  = s_shrchecksum_i[r_selected];
    assign s_shrdata_o  = s_shrdata_i[r_selected];
    assign s_shready_o  = s_shready_i[r_selected];
    assign s_shresp_o   = s_shresp_i[r_selected];

    //Detection of delayed response
    assign s_stall = r_active & ~s_shready_i[r_selected];
    
    //Select a new slave for the transfer
    genvar i;
    generate
        for(i = 0; i<SLAVES;i++)begin : gen1
            assign s_slave_range[i] = (s_mhaddr_i & s_smask_i[i]) == s_sbase_i[i];
            assign s_hsel_o[i] = (s_selected[0] == i[SELMSB:0]) & ~s_stall;
        end

        if(SLAVES > 1)begin
            for(i = 0; i<SLAVES-1;i++)begin
                assign s_selected[i] = (~(|s_slave_range[SLAVES-1 : i+1]) | s_slave_range[i]) ? i[SELMSB:0] : s_selected[i+1];
            end
            assign s_selected[SLAVES-1] = (s_slave_range[SLAVES-1]) ? (SLAVES-1) : (0);
        end else begin
            assign s_selected[0] = {(SELMSB+1){1'b0}};
        end

    endgenerate

    always_ff @( posedge s_clk_i or negedge s_resetn_i) begin : selected
        if(~s_resetn_i)begin
            r_selected  <= {(SELMSB+1){1'b0}};
            r_active    <= 1'd0;
        end else if(s_stall) begin
            r_selected  <= r_selected;
            r_active    <= r_active;
        end else begin
            r_selected  <= (s_mhtrans_i == 2'd2) ? s_selected[0] : '0;
            r_active    <= (s_mhtrans_i == 2'd2);
        end
    end

endmodule
