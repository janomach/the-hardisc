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

module system_hardisc #(
    parameter PMA_REGIONS = 3,
    parameter pma_cfg_t PMA_CFG[PMA_REGIONS-1:0] = PMA_DEFAULT
)(
    input logic s_clk_i[3],                 //clock signal
    input logic s_resetn_i[3],              //reset signal

    input logic s_int_meip_i,               //external interrupt
    input logic s_int_mtip_i,               //timer interrupt
    input logic[31:0] s_boot_add_i,         //boot address
    
    input logic[31:0] s_i_hrdata_i,         //AHB instruction bus - incomming read data
    input logic s_i_hready_i[3],            //AHB instruction bus - finish of transfer
    input logic s_i_hresp_i[3],             //AHB instruction bus - error response
    output logic[31:0] s_i_haddr_o,         //AHB instruction bus - request address
    output logic[31:0] s_i_hwdata_o,        //AHB instruction bus - request data to write
    output logic[2:0]s_i_hburst_o,          //AHB instruction bus - burst type indicator
    output logic s_i_hmastlock_o,           //AHB instruction bus - locked sequence indicator
    output logic[3:0]s_i_hprot_o,           //AHB instruction bus - protection control signals
    output logic[2:0]s_i_hsize_o,           //AHB instruction bus - size of the transfer
    output logic[1:0]s_i_htrans_o,          //AHB instruction bus - transfer type indicator
    output logic s_i_hwrite_o,              //AHB instruction bus - write indicator

    //custom AHB protection
    input logic[6:0] s_i_hrchecksum_i,      //AHB instruction bus - incoming checksum
    output logic[6:0] s_i_hwchecksum_o,     //AHB instruction bus - outgoing checksum
    output logic[5:0] s_i_hparity_o,        //AHB instruction bus - outgoing parity

    input logic[31:0] s_d_hrdata_i,         //AHB data bus - incomming read data
    input logic s_d_hready_i[3],            //AHB data bus - finish of transfer
    input logic s_d_hresp_i[3],             //AHB data bus - error response
    output logic[31:0] s_d_haddr_o,         //AHB data bus - request address
    output logic[31:0] s_d_hwdata_o,        //AHB data bus - request data to write
    output logic[2:0]s_d_hburst_o,          //AHB data bus - burst type indicator
    output logic s_d_hmastlock_o,           //AHB data bus - locked sequence indicator 
    output logic[3:0]s_d_hprot_o,           //AHB data bus - protection control signals
    output logic[2:0]s_d_hsize_o,           //AHB data bus - size of the transfer 
    output logic[1:0]s_d_htrans_o,          //AHB data bus - transfer type indicator
    output logic s_d_hwrite_o,              //AHB data bus - write indicator

    //custom AHB protection
    input logic[6:0] s_d_hrchecksum_i,      //AHB data bus - incoming checksum   
    output logic[6:0] s_d_hwchecksum_o,     //AHB data bus - outgoing checksum
    output logic[5:0] s_d_hparity_o,        //AHB data bus - outgoing parity

    output logic s_unrec_err_o[2]           //unrecoverable error
);

genvar i;
generate
    for (i = 0; i < 1;i++ ) begin : rep
        hardisc #(.PMA_REGIONS(PMA_REGIONS),.PMA_CFG(PMA_CFG)) core
        (
            .s_clk_i(s_clk_i),
            .s_resetn_i(s_resetn_i),
            .s_int_meip_i(s_int_meip_i),
            .s_int_mtip_i(s_int_mtip_i),
            .s_boot_add_i(s_boot_add_i),
            
            .s_i_hrdata_i(s_i_hrdata_i),
            .s_i_hready_i(s_i_hready_i),
            .s_i_hresp_i(s_i_hresp_i),
            .s_i_haddr_o(s_i_haddr_o),
            .s_i_hwdata_o(s_i_hwdata_o),
            .s_i_hburst_o(s_i_hburst_o),
            .s_i_hmastlock_o(s_i_hmastlock_o),
            .s_i_hprot_o(s_i_hprot_o),
            .s_i_hsize_o(s_i_hsize_o),
            .s_i_htrans_o(s_i_htrans_o),
            .s_i_hwrite_o(s_i_hwrite_o),

            .s_i_hrchecksum_i(s_i_hrchecksum_i),
            .s_i_hwchecksum_o(s_i_hwchecksum_o),
            .s_i_hparity_o(s_i_hparity_o),

            .s_d_hrdata_i(s_d_hrdata_i),
            .s_d_hready_i(s_d_hready_i),
            .s_d_hresp_i(s_d_hresp_i),
            .s_d_haddr_o(s_d_haddr_o),
            .s_d_hwdata_o(s_d_hwdata_o),
            .s_d_hburst_o(s_d_hburst_o),
            .s_d_hmastlock_o(s_d_hmastlock_o),
            .s_d_hprot_o(s_d_hprot_o),
            .s_d_hsize_o(s_d_hsize_o),
            .s_d_htrans_o(s_d_htrans_o),
            .s_d_hwrite_o(s_d_hwrite_o),

            .s_d_hrchecksum_i(s_d_hrchecksum_i),
            .s_d_hwchecksum_o(s_d_hwchecksum_o),
            .s_d_hparity_o(s_d_hparity_o),

            .s_unrec_err_o(s_unrec_err_o)
        );        
    end
endgenerate


endmodule