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
    input logic[6:0] s_checksum_i,  //checksum
    output logic[31:0]s_data_o,     //corrected data
    output logic s_ce_o,            //correctable error
    output logic s_uce_o            //uncorrectable error
);
    logic[6:0]s_checksum, s_syndrome;
    logic s_error, s_odd_syn;
    logic[31:0]s_locator;
    logic[20:0]s_5odd;
    logic s_not3bitodd;

    secded_encode encode_m
    (
        .s_data_i(s_data_i),
        .s_checksum_o(s_checksum)
    );
    
    assign s_syndrome   = s_checksum_i ^ s_checksum;
    assign s_error      = |s_syndrome;
    assign s_odd_syn    = ^s_syndrome;
    assign s_not3bitodd = (|s_5odd) | (&s_syndrome);
    assign s_ce_o       = s_odd_syn & ~s_not3bitodd & s_error;
    assign s_uce_o      = (~s_odd_syn || s_not3bitodd) & s_error;

    assign s_data_o     = s_locator[31:0] ^ s_data_i;

    assign s_locator[0]  = s_syndrome[0] & s_syndrome[5] & s_syndrome[6];
    assign s_locator[1]  = s_syndrome[0] & s_syndrome[4] & s_syndrome[6];
    assign s_locator[2]  = s_syndrome[0] & s_syndrome[4] & s_syndrome[3];
    assign s_locator[3]  = s_syndrome[0] & s_syndrome[2] & s_syndrome[6];
    assign s_locator[4]  = s_syndrome[0] & s_syndrome[1] & s_syndrome[6];
    assign s_locator[5]  = s_syndrome[0] & s_syndrome[4] & s_syndrome[5];
    assign s_locator[6]  = s_syndrome[0] & s_syndrome[3] & s_syndrome[5];
    assign s_locator[7]  = s_syndrome[0] & s_syndrome[1] & s_syndrome[4];
    assign s_locator[8]  = s_syndrome[1] & s_syndrome[5] & s_syndrome[6];
    assign s_locator[9]  = s_syndrome[1] & s_syndrome[4] & s_syndrome[6];
    assign s_locator[10] = s_syndrome[1] & s_syndrome[3] & s_syndrome[6];
    assign s_locator[11] = s_syndrome[1] & s_syndrome[2] & s_syndrome[6];
    assign s_locator[12] = s_syndrome[1] & s_syndrome[4] & s_syndrome[5];
    assign s_locator[13] = s_syndrome[1] & s_syndrome[3] & s_syndrome[5];
    assign s_locator[14] = s_syndrome[1] & s_syndrome[0] & s_syndrome[5];
    assign s_locator[15] = s_syndrome[1] & s_syndrome[3] & s_syndrome[4];
    assign s_locator[16] = s_syndrome[2] & s_syndrome[3] & s_syndrome[5];
    assign s_locator[17] = s_syndrome[2] & s_syndrome[6] & s_syndrome[5];
    assign s_locator[18] = s_syndrome[2] & s_syndrome[1] & s_syndrome[5];
    assign s_locator[19] = s_syndrome[2] & s_syndrome[0] & s_syndrome[5];
    assign s_locator[20] = s_syndrome[2] & s_syndrome[4] & s_syndrome[5];
    assign s_locator[21] = s_syndrome[2] & s_syndrome[1] & s_syndrome[4];
    assign s_locator[22] = s_syndrome[2] & s_syndrome[0] & s_syndrome[4];
    assign s_locator[23] = s_syndrome[2] & s_syndrome[4] & s_syndrome[6];
    assign s_locator[24] = s_syndrome[3] & s_syndrome[0] & s_syndrome[1];
    assign s_locator[25] = s_syndrome[3] & s_syndrome[4] & s_syndrome[6];
    assign s_locator[26] = s_syndrome[3] & s_syndrome[2] & s_syndrome[4];
    assign s_locator[27] = s_syndrome[3] & s_syndrome[2] & s_syndrome[6];
    assign s_locator[28] = s_syndrome[3] & s_syndrome[4] & s_syndrome[5];
    assign s_locator[29] = s_syndrome[3] & s_syndrome[1] & s_syndrome[2];
    assign s_locator[30] = s_syndrome[3] & s_syndrome[0] & s_syndrome[2];
    assign s_locator[31] = s_syndrome[3] & s_syndrome[0] & s_syndrome[6];

    assign s_5odd[0]     = s_syndrome[0] & s_syndrome[1] & s_syndrome[2] & s_syndrome[3] & s_syndrome[4];
    assign s_5odd[1]     = s_syndrome[0] & s_syndrome[1] & s_syndrome[2] & s_syndrome[3] & s_syndrome[5];
    assign s_5odd[2]     = s_syndrome[0] & s_syndrome[1] & s_syndrome[2] & s_syndrome[3] & s_syndrome[6];
    assign s_5odd[3]     = s_syndrome[0] & s_syndrome[1] & s_syndrome[2] & s_syndrome[4] & s_syndrome[5];
    assign s_5odd[4]     = s_syndrome[0] & s_syndrome[1] & s_syndrome[2] & s_syndrome[4] & s_syndrome[6];
    assign s_5odd[5]     = s_syndrome[0] & s_syndrome[1] & s_syndrome[2] & s_syndrome[5] & s_syndrome[6];
    assign s_5odd[6]     = s_syndrome[0] & s_syndrome[1] & s_syndrome[3] & s_syndrome[4] & s_syndrome[5];
    assign s_5odd[7]     = s_syndrome[0] & s_syndrome[1] & s_syndrome[3] & s_syndrome[4] & s_syndrome[6];
    assign s_5odd[8]     = s_syndrome[0] & s_syndrome[1] & s_syndrome[3] & s_syndrome[5] & s_syndrome[6];
    assign s_5odd[9]     = s_syndrome[0] & s_syndrome[1] & s_syndrome[4] & s_syndrome[5] & s_syndrome[6];
    assign s_5odd[10]    = s_syndrome[0] & s_syndrome[2] & s_syndrome[3] & s_syndrome[4] & s_syndrome[5];
    assign s_5odd[11]    = s_syndrome[0] & s_syndrome[2] & s_syndrome[3] & s_syndrome[4] & s_syndrome[6];
    assign s_5odd[12]    = s_syndrome[0] & s_syndrome[2] & s_syndrome[3] & s_syndrome[5] & s_syndrome[6];
    assign s_5odd[13]    = s_syndrome[0] & s_syndrome[2] & s_syndrome[4] & s_syndrome[5] & s_syndrome[6];
    assign s_5odd[14]    = s_syndrome[0] & s_syndrome[3] & s_syndrome[4] & s_syndrome[5] & s_syndrome[6];
    assign s_5odd[15]    = s_syndrome[1] & s_syndrome[2] & s_syndrome[3] & s_syndrome[4] & s_syndrome[5];
    assign s_5odd[16]    = s_syndrome[1] & s_syndrome[2] & s_syndrome[3] & s_syndrome[4] & s_syndrome[6];
    assign s_5odd[17]    = s_syndrome[1] & s_syndrome[2] & s_syndrome[3] & s_syndrome[5] & s_syndrome[6];
    assign s_5odd[18]    = s_syndrome[1] & s_syndrome[2] & s_syndrome[4] & s_syndrome[5] & s_syndrome[6];
    assign s_5odd[19]    = s_syndrome[1] & s_syndrome[3] & s_syndrome[4] & s_syndrome[5] & s_syndrome[6];
    assign s_5odd[20]    = s_syndrome[2] & s_syndrome[3] & s_syndrome[4] & s_syndrome[5] & s_syndrome[6];
    
endmodule
