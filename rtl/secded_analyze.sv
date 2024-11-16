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

module secded_analyze (
    input logic[6:0]s_syndrome_i,   //syndrome
    output logic s_error_o,         //error exists
    output logic s_ce_o             //error is correctable
);
    /* Analyzer for Hsiao's Single-Error-Correction-Double-Error-Detection code */
    logic[6:0]s_checksum;
    logic s_error, s_odd_syn;
    logic[20:0]s_5odd;
    logic s_not3bitodd;
    
    assign s_error_o    = s_error;
    assign s_ce_o       = s_odd_syn & ~s_not3bitodd;

    assign s_error      = |s_syndrome_i;
    assign s_odd_syn    = ^s_syndrome_i;
    assign s_not3bitodd = (|s_5odd) | (&s_syndrome_i);

    assign s_5odd[0]    = s_syndrome_i[0] & s_syndrome_i[1] & s_syndrome_i[2] & s_syndrome_i[3] & s_syndrome_i[4];
    assign s_5odd[1]    = s_syndrome_i[0] & s_syndrome_i[1] & s_syndrome_i[2] & s_syndrome_i[3] & s_syndrome_i[5];
    assign s_5odd[2]    = s_syndrome_i[0] & s_syndrome_i[1] & s_syndrome_i[2] & s_syndrome_i[3] & s_syndrome_i[6];
    assign s_5odd[3]    = s_syndrome_i[0] & s_syndrome_i[1] & s_syndrome_i[2] & s_syndrome_i[4] & s_syndrome_i[5];
    assign s_5odd[4]    = s_syndrome_i[0] & s_syndrome_i[1] & s_syndrome_i[2] & s_syndrome_i[4] & s_syndrome_i[6];
    assign s_5odd[5]    = s_syndrome_i[0] & s_syndrome_i[1] & s_syndrome_i[2] & s_syndrome_i[5] & s_syndrome_i[6];
    assign s_5odd[6]    = s_syndrome_i[0] & s_syndrome_i[1] & s_syndrome_i[3] & s_syndrome_i[4] & s_syndrome_i[5];
    assign s_5odd[7]    = s_syndrome_i[0] & s_syndrome_i[1] & s_syndrome_i[3] & s_syndrome_i[4] & s_syndrome_i[6];
    assign s_5odd[8]    = s_syndrome_i[0] & s_syndrome_i[1] & s_syndrome_i[3] & s_syndrome_i[5] & s_syndrome_i[6];
    assign s_5odd[9]    = s_syndrome_i[0] & s_syndrome_i[1] & s_syndrome_i[4] & s_syndrome_i[5] & s_syndrome_i[6];
    assign s_5odd[10]   = s_syndrome_i[0] & s_syndrome_i[2] & s_syndrome_i[3] & s_syndrome_i[4] & s_syndrome_i[5];
    assign s_5odd[11]   = s_syndrome_i[0] & s_syndrome_i[2] & s_syndrome_i[3] & s_syndrome_i[4] & s_syndrome_i[6];
    assign s_5odd[12]   = s_syndrome_i[0] & s_syndrome_i[2] & s_syndrome_i[3] & s_syndrome_i[5] & s_syndrome_i[6];
    assign s_5odd[13]   = s_syndrome_i[0] & s_syndrome_i[2] & s_syndrome_i[4] & s_syndrome_i[5] & s_syndrome_i[6];
    assign s_5odd[14]   = s_syndrome_i[0] & s_syndrome_i[3] & s_syndrome_i[4] & s_syndrome_i[5] & s_syndrome_i[6];
    assign s_5odd[15]   = s_syndrome_i[1] & s_syndrome_i[2] & s_syndrome_i[3] & s_syndrome_i[4] & s_syndrome_i[5];
    assign s_5odd[16]   = s_syndrome_i[1] & s_syndrome_i[2] & s_syndrome_i[3] & s_syndrome_i[4] & s_syndrome_i[6];
    assign s_5odd[17]   = s_syndrome_i[1] & s_syndrome_i[2] & s_syndrome_i[3] & s_syndrome_i[5] & s_syndrome_i[6];
    assign s_5odd[18]   = s_syndrome_i[1] & s_syndrome_i[2] & s_syndrome_i[4] & s_syndrome_i[5] & s_syndrome_i[6];
    assign s_5odd[19]   = s_syndrome_i[1] & s_syndrome_i[3] & s_syndrome_i[4] & s_syndrome_i[5] & s_syndrome_i[6];
    assign s_5odd[20]   = s_syndrome_i[2] & s_syndrome_i[3] & s_syndrome_i[4] & s_syndrome_i[5] & s_syndrome_i[6];
    
endmodule
