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

module secded_encode (
    input logic[31:0] s_data_i,     //data
    output logic[6:0] s_checksum_o  //checksum
);
    logic[4:0] s_row[7];

    assign s_row[0][0] = s_data_i[0] ^ s_data_i[1] ^ s_data_i[2];
    assign s_row[0][1] = s_data_i[3] ^ s_data_i[4] ^ s_data_i[5];
    assign s_row[0][2] = s_data_i[6] ^ s_data_i[7] ^ s_data_i[14];
    assign s_row[0][3] = s_data_i[19] ^ s_data_i[22] ^ s_data_i[24];
    assign s_row[0][4] = s_data_i[30] ^ s_data_i[31];

    assign s_row[1][0] = s_data_i[4] ^ s_data_i[7] ^ s_data_i[8];
    assign s_row[1][1] = s_data_i[9] ^ s_data_i[10] ^ s_data_i[11];
    assign s_row[1][2] = s_data_i[12] ^ s_data_i[13] ^ s_data_i[14];
    assign s_row[1][3] = s_data_i[15] ^ s_data_i[18] ^ s_data_i[21];
    assign s_row[1][4] = s_data_i[24] ^ s_data_i[29];

    assign s_row[2][0] = s_data_i[3] ^ s_data_i[11] ^ s_data_i[16];
    assign s_row[2][1] = s_data_i[17] ^ s_data_i[18] ^ s_data_i[19];
    assign s_row[2][2] = s_data_i[20] ^ s_data_i[21] ^ s_data_i[22];
    assign s_row[2][3] = s_data_i[23] ^ s_data_i[26] ^ s_data_i[27];
    assign s_row[2][4] = s_data_i[29] ^ s_data_i[30];

    assign s_row[3][0] = s_data_i[2] ^ s_data_i[6] ^ s_data_i[10];
    assign s_row[3][1] = s_data_i[13] ^ s_data_i[15] ^ s_data_i[16];
    assign s_row[3][2] = s_data_i[24] ^ s_data_i[25] ^ s_data_i[26];
    assign s_row[3][3] = s_data_i[27] ^ s_data_i[28] ^ s_data_i[29];
    assign s_row[3][4] = s_data_i[30] ^ s_data_i[31];

    assign s_row[4][0] = s_data_i[1] ^ s_data_i[2] ^ s_data_i[5];
    assign s_row[4][1] = s_data_i[7] ^ s_data_i[9] ^ s_data_i[12];
    assign s_row[4][2] = s_data_i[15] ^ s_data_i[20] ^ s_data_i[21];
    assign s_row[4][3] = s_data_i[22] ^ s_data_i[23] ^ s_data_i[25];
    assign s_row[4][4] = s_data_i[26] ^ s_data_i[28];

    assign s_row[5][0] = s_data_i[0] ^ s_data_i[5] ^ s_data_i[6];
    assign s_row[5][1] = s_data_i[8] ^ s_data_i[12] ^ s_data_i[13];
    assign s_row[5][2] = s_data_i[14] ^ s_data_i[16] ^ s_data_i[17];
    assign s_row[5][3] = s_data_i[18] ^ s_data_i[19] ^ s_data_i[20];
    assign s_row[5][4] = s_data_i[28];

    assign s_row[6][0] = s_data_i[0] ^ s_data_i[1] ^ s_data_i[3];
    assign s_row[6][1] = s_data_i[4] ^ s_data_i[8] ^ s_data_i[9];
    assign s_row[6][2] = s_data_i[10] ^ s_data_i[11] ^ s_data_i[17];
    assign s_row[6][3] = s_data_i[23] ^ s_data_i[25] ^ s_data_i[27];
    assign s_row[6][4] = s_data_i[31];

    assign s_checksum_o[0] = ^s_row[0];
    assign s_checksum_o[1] = ^s_row[1];
    assign s_checksum_o[2] = ^s_row[2];
    assign s_checksum_o[3] = ^s_row[3];
    assign s_checksum_o[4] = ^s_row[4];
    assign s_checksum_o[5] = ^s_row[5];
    assign s_checksum_o[6] = ^s_row[6];
endmodule
