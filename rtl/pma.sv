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

module pma #(
    parameter FETCH = 0,
    parameter PMA_ALIGN = 10,
    parameter PMA_REGIONS = 3,
    parameter pma_cfg_t PMA_CFG[PMA_REGIONS-1:0] = PMA_DEFAULT
)(
    input logic[31:0] s_address_i,  //transfer address
    input logic s_write_i,          //transfer is write
    output logic s_idempotent_o,    //memory is idempotent
    output logic s_violation_o      //attribute violation
);
    /*
        Physical Memory Attribute (PMA) module checks whether the intended bus transfer 
        violates the properties or capabilities of the targeted device.
    */
    logic[PMA_REGIONS-1:0] s_address_hit, s_idempotent, s_ex_violation, s_ro_violation;

    assign s_violation_o    = !(|s_address_hit) | (|s_ex_violation) | (|s_ro_violation);
    assign s_idempotent_o   = |(s_address_hit & s_idempotent);

    genvar i;
    generate
        for (i = 0; i < PMA_REGIONS; i++ ) begin            
            assign s_address_hit[i] = (s_address_i[31:PMA_ALIGN] & PMA_CFG[i].mask[31:PMA_ALIGN]) == PMA_CFG[i].base[31:PMA_ALIGN];
            assign s_idempotent[i]  = PMA_CFG[i].idempotent;
            if(FETCH) begin
                assign s_ex_violation[i]    = s_address_hit[i] & !PMA_CFG[i].executable;
                assign s_ro_violation[i]    = 1'b0;
            end else begin
                assign s_ex_violation[i]    = 1'b0;
                assign s_ro_violation[i]    = s_address_hit[i] & PMA_CFG[i].read_only & s_write_i;
            end
        end
    endgenerate

endmodule