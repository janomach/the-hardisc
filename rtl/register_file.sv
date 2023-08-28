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

module register_file
(
	input logic s_clk_i,             //clock signal

    input logic[31:0] s_wb_val_i,    //write value
    input rf_add s_wb_add_i,         //write address
    input logic s_wb_we_i,           //write request

    input rf_add s_r_p1_add_i,       //read port 1 address
    input rf_add s_r_p2_add_i,       //read port 2 address

    output logic[31:0] s_p1_val_o,   //value read through port 1
    output logic[31:0] s_p2_val_o    //value read through port 2
);

`ifdef SEE_TESTING
    int j;
    logic[31:0] s_upset[32];
    see_insert #(.W(32),.N(32),.GROUP(3),.LABEL("RF")) see (.s_clk_i(s_clk_i),.s_upset_o(s_upset));
`endif

    logic[31:0] r_register_file[0:31] = '{default:0};

    assign s_write         = s_wb_we_i;
    assign s_w_address     = s_wb_add_i;
    assign s_w_value       = s_wb_val_i;

    assign s_p1_val_o      = r_register_file[s_r_p1_add_i];
    assign s_p2_val_o      = r_register_file[s_r_p2_add_i];

    always_ff @( posedge s_clk_i ) begin : rf_writer
        if(s_wb_we_i)begin
            r_register_file[s_wb_add_i] <= s_wb_val_i
`ifdef SEE_TESTING            
            ^ s_upset[s_wb_add_i]
`endif 
            ;
        end
`ifdef SEE_TESTING  
        for (j=1;j<32;j++) begin
            if(!(s_wb_we_i & (s_wb_add_i == j)))
                r_register_file[j] <= r_register_file[j] ^ s_upset[j];
        end
`endif
    end

endmodule
