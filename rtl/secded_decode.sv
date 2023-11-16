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

module secded_decode (
    input logic[31:0]s_data_i,      //data
    input logic[6:0] s_syndrome_i,  //syndrome
    output logic[31:0]s_data_o      //corrected data
);
    /* Decoder for Hsiao's Single-Error-Correction-Double-Error-Detection code */
    logic[31:0]s_locator;

    assign s_data_o      = s_locator[31:0] ^ s_data_i;

    assign s_locator[0]  = s_syndrome_i[0] & s_syndrome_i[5] & s_syndrome_i[6];
    assign s_locator[1]  = s_syndrome_i[0] & s_syndrome_i[4] & s_syndrome_i[6];
    assign s_locator[2]  = s_syndrome_i[0] & s_syndrome_i[4] & s_syndrome_i[3];
    assign s_locator[3]  = s_syndrome_i[0] & s_syndrome_i[2] & s_syndrome_i[6];
    assign s_locator[4]  = s_syndrome_i[0] & s_syndrome_i[1] & s_syndrome_i[6];
    assign s_locator[5]  = s_syndrome_i[0] & s_syndrome_i[4] & s_syndrome_i[5];
    assign s_locator[6]  = s_syndrome_i[0] & s_syndrome_i[3] & s_syndrome_i[5];
    assign s_locator[7]  = s_syndrome_i[0] & s_syndrome_i[1] & s_syndrome_i[4];
    assign s_locator[8]  = s_syndrome_i[1] & s_syndrome_i[5] & s_syndrome_i[6];
    assign s_locator[9]  = s_syndrome_i[1] & s_syndrome_i[4] & s_syndrome_i[6];
    assign s_locator[10] = s_syndrome_i[1] & s_syndrome_i[3] & s_syndrome_i[6];
    assign s_locator[11] = s_syndrome_i[1] & s_syndrome_i[2] & s_syndrome_i[6];
    assign s_locator[12] = s_syndrome_i[1] & s_syndrome_i[4] & s_syndrome_i[5];
    assign s_locator[13] = s_syndrome_i[1] & s_syndrome_i[3] & s_syndrome_i[5];
    assign s_locator[14] = s_syndrome_i[1] & s_syndrome_i[0] & s_syndrome_i[5];
    assign s_locator[15] = s_syndrome_i[1] & s_syndrome_i[3] & s_syndrome_i[4];
    assign s_locator[16] = s_syndrome_i[2] & s_syndrome_i[3] & s_syndrome_i[5];
    assign s_locator[17] = s_syndrome_i[2] & s_syndrome_i[6] & s_syndrome_i[5];
    assign s_locator[18] = s_syndrome_i[2] & s_syndrome_i[1] & s_syndrome_i[5];
    assign s_locator[19] = s_syndrome_i[2] & s_syndrome_i[0] & s_syndrome_i[5];
    assign s_locator[20] = s_syndrome_i[2] & s_syndrome_i[4] & s_syndrome_i[5];
    assign s_locator[21] = s_syndrome_i[2] & s_syndrome_i[1] & s_syndrome_i[4];
    assign s_locator[22] = s_syndrome_i[2] & s_syndrome_i[0] & s_syndrome_i[4];
    assign s_locator[23] = s_syndrome_i[2] & s_syndrome_i[4] & s_syndrome_i[6];
    assign s_locator[24] = s_syndrome_i[3] & s_syndrome_i[0] & s_syndrome_i[1];
    assign s_locator[25] = s_syndrome_i[3] & s_syndrome_i[4] & s_syndrome_i[6];
    assign s_locator[26] = s_syndrome_i[3] & s_syndrome_i[2] & s_syndrome_i[4];
    assign s_locator[27] = s_syndrome_i[3] & s_syndrome_i[2] & s_syndrome_i[6];
    assign s_locator[28] = s_syndrome_i[3] & s_syndrome_i[4] & s_syndrome_i[5];
    assign s_locator[29] = s_syndrome_i[3] & s_syndrome_i[1] & s_syndrome_i[2];
    assign s_locator[30] = s_syndrome_i[3] & s_syndrome_i[0] & s_syndrome_i[2];
    assign s_locator[31] = s_syndrome_i[3] & s_syndrome_i[0] & s_syndrome_i[6];
    
endmodule
