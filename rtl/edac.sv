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

package edac;
    function logic[6:0] edac_checksum (input bit[31:0] s_data_i);
        /* Encoder function for Hsiao's Single-Error-Correction-Double-Error-Detection code */
        logic[4:0] s_row[7];

        s_row[0][0] = s_data_i[0] ^ s_data_i[1] ^ s_data_i[2];
        s_row[0][1] = s_data_i[3] ^ s_data_i[4] ^ s_data_i[5];
        s_row[0][2] = s_data_i[6] ^ s_data_i[7] ^ s_data_i[14];
        s_row[0][3] = s_data_i[19] ^ s_data_i[22] ^ s_data_i[24];
        s_row[0][4] = s_data_i[30] ^ s_data_i[31];

        s_row[1][0] = s_data_i[4] ^ s_data_i[7] ^ s_data_i[8];
        s_row[1][1] = s_data_i[9] ^ s_data_i[10] ^ s_data_i[11];
        s_row[1][2] = s_data_i[12] ^ s_data_i[13] ^ s_data_i[14];
        s_row[1][3] = s_data_i[15] ^ s_data_i[18] ^ s_data_i[21];
        s_row[1][4] = s_data_i[24] ^ s_data_i[29];

        s_row[2][0] = s_data_i[3] ^ s_data_i[11] ^ s_data_i[16];
        s_row[2][1] = s_data_i[17] ^ s_data_i[18] ^ s_data_i[19];
        s_row[2][2] = s_data_i[20] ^ s_data_i[21] ^ s_data_i[22];
        s_row[2][3] = s_data_i[23] ^ s_data_i[26] ^ s_data_i[27];
        s_row[2][4] = s_data_i[29] ^ s_data_i[30];

        s_row[3][0] = s_data_i[2] ^ s_data_i[6] ^ s_data_i[10];
        s_row[3][1] = s_data_i[13] ^ s_data_i[15] ^ s_data_i[16];
        s_row[3][2] = s_data_i[24] ^ s_data_i[25] ^ s_data_i[26];
        s_row[3][3] = s_data_i[27] ^ s_data_i[28] ^ s_data_i[29];
        s_row[3][4] = s_data_i[30] ^ s_data_i[31];

        s_row[4][0] = s_data_i[1] ^ s_data_i[2] ^ s_data_i[5];
        s_row[4][1] = s_data_i[7] ^ s_data_i[9] ^ s_data_i[12];
        s_row[4][2] = s_data_i[15] ^ s_data_i[20] ^ s_data_i[21];
        s_row[4][3] = s_data_i[22] ^ s_data_i[23] ^ s_data_i[25];
        s_row[4][4] = s_data_i[26] ^ s_data_i[28];

        s_row[5][0] = s_data_i[0] ^ s_data_i[5] ^ s_data_i[6];
        s_row[5][1] = s_data_i[8] ^ s_data_i[12] ^ s_data_i[13];
        s_row[5][2] = s_data_i[14] ^ s_data_i[16] ^ s_data_i[17];
        s_row[5][3] = s_data_i[18] ^ s_data_i[19] ^ s_data_i[20];
        s_row[5][4] = s_data_i[28];

        s_row[6][0] = s_data_i[0] ^ s_data_i[1] ^ s_data_i[3];
        s_row[6][1] = s_data_i[4] ^ s_data_i[8] ^ s_data_i[9];
        s_row[6][2] = s_data_i[10] ^ s_data_i[11] ^ s_data_i[17];
        s_row[6][3] = s_data_i[23] ^ s_data_i[25] ^ s_data_i[27];
        s_row[6][4] = s_data_i[31];

        edac_checksum[0] = ^s_row[0];
        edac_checksum[1] = ^s_row[1];
        edac_checksum[2] = ^s_row[2];
        edac_checksum[3] = ^s_row[3];
        edac_checksum[4] = ^s_row[4];
        edac_checksum[5] = ^s_row[5];
        edac_checksum[6] = ^s_row[6];
    endfunction
endpackage