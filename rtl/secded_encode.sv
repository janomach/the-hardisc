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

import edac::*;

module secded_encode (
    input logic[31:0] s_data_i,     //data
    output logic[6:0] s_checksum_o  //checksum
);
    /* Encoder for Hsiao's Single-Error-Correction-Double-Error-Detection code */
    assign s_checksum_o = edac_checksum(s_data_i);
endmodule
