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

module fast_adder #(
    parameter ADDONLY = 1,
    parameter WIDTH = 32
)(
    input logic[WIDTH-1:0] s_base_val_i,
    input logic[(WIDTH/2)-1:0] s_add_val_i,
    output logic[WIDTH-1:0] s_val_o
);
    localparam H_WIDTH = WIDTH/2;
    localparam H_MSB = H_WIDTH - 1;
    localparam MSB = WIDTH-1;
    logic[H_WIDTH:0] s_low_adder;
    logic[H_MSB:0] s_high_adder;
    logic[H_MSB:0] s_upper_part;
    assign s_low_adder  = {1'b0,s_base_val_i[H_MSB:0]} + {1'b0,s_add_val_i};
    assign s_val_o      = {s_upper_part,s_low_adder[H_MSB:0]};

    generate
        if(ADDONLY)begin
            assign s_high_adder = s_base_val_i[MSB:H_WIDTH] + {{(H_WIDTH-1){1'b0}},1'b1};
            assign s_upper_part = s_low_adder[H_WIDTH] ? s_high_adder : s_base_val_i[MSB:H_WIDTH];
        end else begin
            assign s_high_adder = s_base_val_i[MSB:H_WIDTH] + ((s_add_val_i[H_MSB]) ? {H_WIDTH{1'b1}} : {{(H_WIDTH-1){1'b0}},1'b1});
            assign s_upper_part = (s_add_val_i[H_MSB]) ? ( s_low_adder[H_WIDTH] ? s_base_val_i[MSB:H_WIDTH] : s_high_adder) : 
                                                      ( s_low_adder[H_WIDTH] ? s_high_adder : s_base_val_i[MSB:H_WIDTH]);
        end
    endgenerate

endmodule

module fast_adder_2 #(
    parameter WIDTH = 32,
    parameter ADDW = 16
)(
    input logic[WIDTH-1:0] s_base_val_i,
    input logic[ADDW-1:0] s_add_val_i,
    output logic[WIDTH-1:0] s_val_o
);
    logic[ADDW:0] s_low_adder;
    logic[WIDTH-ADDW-1:0] s_high_adder, s_upper_part;

    assign s_low_adder  = {1'b0,s_base_val_i[ADDW-1:0]} + {1'b0,s_add_val_i};
    assign s_val_o      = {s_upper_part,s_low_adder[ADDW-1:0]};

    assign s_high_adder = s_base_val_i[WIDTH-1:ADDW] + ((s_add_val_i[ADDW-1]) ? {(WIDTH-ADDW){1'b1}} : {{(WIDTH-ADDW-1){1'b0}},1'b1});
    assign s_upper_part = (s_add_val_i[ADDW-1]) ? ( s_low_adder[ADDW] ? s_base_val_i[WIDTH-1:ADDW] : s_high_adder) : 
                                                      ( s_low_adder[ADDW] ? s_high_adder : s_base_val_i[WIDTH-1:ADDW]);

endmodule

//paralelize increment of the input value by one
module fast_increment (
    input logic[31:0] s_base_val_i,
    output logic[31:0] s_val_o
);
    logic[4:0] s_adder[8];
    logic[15:0] s_p[2];

    assign s_adder[0] = {1'b0,s_base_val_i[3:0]} + 5'b1;
    assign s_adder[1] = {1'b0,s_base_val_i[7:4]} + 5'b1;
    assign s_adder[2] = {1'b0,s_base_val_i[11:8]} + 5'b1;
    assign s_adder[3] = {1'b0,s_base_val_i[15:12]} + 5'b1;
    assign s_adder[4] = {1'b0,s_base_val_i[19:16]} + 5'b1;
    assign s_adder[5] = {1'b0,s_base_val_i[23:20]} + 5'b1;
    assign s_adder[6] = {1'b0,s_base_val_i[27:24]} + 5'b1;
    assign s_adder[7] = {1'b0,s_base_val_i[31:28]} + 5'b1;

    assign s_p[0][3:0]      = (s_adder[0][3:0]);
    assign s_p[0][7:4]      = (s_adder[0][4]) ? s_adder[1][3:0] : s_base_val_i[7:4];
    assign s_p[0][11:8]     = (s_adder[0][4] & s_adder[1][4]) ? s_adder[2][3:0] : s_base_val_i[11:8];
    assign s_p[0][15:12]    = (s_adder[0][4] & s_adder[1][4] & s_adder[2][4]) ? s_adder[3][3:0] : s_base_val_i[15:12];

    assign s_p[1][3:0]      = (s_adder[4][3:0]);
    assign s_p[1][7:4]      = (s_adder[4][4]) ? s_adder[5][3:0] : s_base_val_i[23:20];
    assign s_p[1][11:8]     = (s_adder[4][4] & s_adder[5][4]) ? s_adder[6][3:0] : s_base_val_i[27:24];
    assign s_p[1][15:12]    = (s_adder[4][4] & s_adder[5][4] & s_adder[6][4]) ? s_adder[7][3:0] : s_base_val_i[31:28];

    assign s_val_o[15:0]    = s_p[0];
    assign s_val_o[31:16]    = (s_adder[0][4] & s_adder[1][4] & s_adder[2][4] & s_adder[3][4]) ? s_p[1] : s_base_val_i[31:16];

endmodule
