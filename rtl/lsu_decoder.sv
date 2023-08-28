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

import p_hardisc::*;

module lsu_decoder (
    input logic[1:0] s_alignment_i,     //bus-transfer address alignment
    input logic[31:0] s_lsu_data_i,     //received data from the bus
    input logic s_unsigned_i,           //instruction treats the data unsigned
    input logic s_lword_i,              //instruction loads 32-bit
    input logic s_lhalf_i,              //instruction loads 16-bit
    output logic[31:0] s_data_o         //decoded data
);
    logic[31:0] s_data;
    logic[7:0]s_b_extend;
    logic[15:0]s_hw_extend;

    assign s_data[7:0]    = (s_alignment_i == 2'b00) ? s_lsu_data_i[7:0] : 
                            (s_alignment_i == 2'b01) ? s_lsu_data_i[15:8] : 
                            (s_alignment_i == 2'b10) ? s_lsu_data_i[23:16] : 
                                                       s_lsu_data_i[31:24];

    assign s_data[15:8]   = (s_alignment_i == 2'b00) ? s_lsu_data_i[15:8] : 
                            (s_alignment_i == 2'b01) ? s_lsu_data_i[23:16] : 
                            (s_alignment_i == 2'b10) ? s_lsu_data_i[31:24] : 8'b0;

    assign s_data[23:16]  = (s_alignment_i == 2'b00) ? s_lsu_data_i[23:16] : 
                            (s_alignment_i == 2'b01) ? s_lsu_data_i[31:24] : 8'b0;

    assign s_data[31:24]  = (s_alignment_i == 2'b00) ? s_lsu_data_i[31:24] : 8'b0;

    assign s_b_extend       = (s_unsigned_i) ? 8'b0: {8{s_data[7]}};
    assign s_hw_extend      = (s_unsigned_i) ? 16'b0: {16{s_data[15]}};
    assign s_data_o[7:0]    = s_data[7:0];
    assign s_data_o[15:8]   = (s_lword_i | s_lhalf_i) ? s_data[15:8] : s_b_extend;
    assign s_data_o[31:16]  = (s_lword_i) ? s_data[31:16] : 
                              (s_lhalf_i) ? s_hw_extend : {s_b_extend,s_b_extend};

endmodule
