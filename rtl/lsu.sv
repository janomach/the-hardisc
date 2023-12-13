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

module lsu (
    input logic s_clk_i[CTRL_REPS],     //clock signal
    input logic s_resetn_i[CTRL_REPS],  //reset signal
    input logic s_flush_i[CTRL_REPS],   //flush signal      

    input logic[6:0] s_hrdcheck_i,      //AHB bus - incoming checksum
    input logic[31:0] s_hrdata_i,       //AHB bus - incomming read data
    input logic s_hready_i[CTRL_REPS],  //AHB bus - finish of transfer
    input logic s_hresp_i[CTRL_REPS],   //AHB bus - error response

    output logic[31:0] s_haddr_o,       //AHB bus - request address
    output logic[31:0] s_hwdata_o,      //AHB bus - request data to write
    output logic[6:0] s_hwdcheck_o,     //AHB bus - request data checksum                   
    output logic[2:0]s_hsize_o,         //AHB bus - size of the transfer                     
    output logic[1:0]s_htrans_o,        //AHB bus - transfer type indicator
    output logic s_hwrite_o,            //AHB bus - write indicator
    output logic[5:0] s_hparity_o,      //AHB bus - outgoing parity

    //Address phase
    input f_part s_opex_f_i[OPEX_REPS],         //instruction function from EX stage
    input logic s_ap_approve_i[EXMA_REPS],      //address phase approval  
    input logic[31:0] s_ap_address_i[EXMA_REPS],//address phase address 
    input logic[31:0] s_wdata_i[EXMA_REPS],     //data to write
    output logic s_ap_busy_o[EXMA_REPS],        //busy indicator - cannot start new address phase   

    //Data phase
    input f_part s_exma_f_i[EXMA_REPS],         //instruction function from MA stage
    input logic[31:0] s_dp_address_i[EXMA_REPS],//data phase address  
    output logic s_dp_ready_o[EXMA_REPS],       //data phase stall signal
    output logic s_dp_hresp_o[EXMA_REPS],       //data phase bus error
    output logic[31:0] s_dp_data_o,             //data phase read data

    //Fix data
    input logic[31:0] s_read_data_i[MAWB_REPS],     //data read by previous transfer
    output logic[31:0] s_fixed_data_o[MAWB_REPS],   //fixed data
    output logic[2:0] s_einfo_o[MAWB_REPS]          //data error info
);
    logic s_ap_active[EXMA_REPS], s_whresp[MAWB_REPS], s_rhresp[MAWB_REPS];
    logic[31:0] s_wwdata[EXMA_REPS], s_rwdata[EXMA_REPS];
`ifdef PROTECTED_WITH_IFP
    logic[31:0] s_haddr[INTF_REPS];
    logic[5:0] s_hparity[INTF_REPS];
    logic[2:0] s_hsize[INTF_REPS];
    logic[1:0] s_htrans[INTF_REPS];
    logic s_hwrite[INTF_REPS];
    logic rmw_activate[EXMA_REPS], s_ce[MAWB_REPS], s_uce[MAWB_REPS];
    logic[31:0] s_data_merged[EXMA_REPS], s_data_fixed[EXMA_REPS], s_wdata[1];
    logic[6:0] s_achecksum[MAWB_REPS], s_wlsyndrome[MAWB_REPS], s_rlsyndrome[MAWB_REPS], s_checksum[MAWB_REPS], s_wchecksum[1];
    logic[1:0] s_wfsm[EXMA_REPS], s_rfsm[EXMA_REPS];
`endif

    //Data for write
    seu_regs #(.LABEL("WDATA"),.N(EXMA_REPS))m_wdata (.s_c_i(s_clk_i),.s_d_i(s_wwdata),.s_d_o(s_rwdata));
    //Bus-transfer error
    seu_regs #(.LABEL("HRESP"),.W(1),.N(EXMA_REPS))m_hresp (.s_c_i(s_clk_i),.s_d_i(s_whresp),.s_d_o(s_rhresp));
`ifdef PROTECTED_WITH_IFP
    //Finite state machine for the Read-Modify-Write sequence
    seu_regs #(.LABEL("FSM"),.W(2),.N(EXMA_REPS))m_fsm (.s_c_i(s_clk_i),.s_d_i(s_wfsm),.s_d_o(s_rfsm));
    //Syndrome of the loaded value
    seu_regs #(.LABEL("LSYNDROME"),.N(EXMA_REPS),.W(7))m_lsyndrome(.s_c_i(s_clk_i),.s_d_i(s_wlsyndrome),.s_d_o(s_rlsyndrome));
    //Majority voting prevents save of corrupted data
    tmr_comb #(.OUT_REPS(1)) m_tmr_sval (.s_d_i(s_rwdata),.s_d_o(s_wdata));
    //Majority voting prevents save of corrupted checksum 
    tmr_comb #(.OUT_REPS(1),.W(7)) m_tmr_schecksum (.s_d_i(s_checksum),.s_d_o(s_wchecksum));
    
    //Data bus interface signals
    /*  At the beggining of the RMW sequence is always a load from from aligned address, 
        the original transfer is performed in the write phase */
    //AHB Control signals are determined by pipeline 0
    assign s_hsize_o        = s_hsize[0];
    assign s_hwrite_o       = s_hwrite[0]; 
    assign s_haddr_o        = s_haddr[0];
    assign s_htrans_o       = s_htrans[0];
    assign s_hwdcheck_o     = s_wchecksum[0];
    assign s_hwdata_o       = s_wdata[0];

    //Parity protection signal is determined by pipeline 1
    assign s_hparity_o[3:0] = {^s_haddr[INTF_REPS-1][31:24], ^s_haddr[INTF_REPS-1][23:16], ^s_haddr[INTF_REPS-1][15:8], ^s_haddr[INTF_REPS-1][7:0]};
    assign s_hparity_o[4]   = (^s_hsize[INTF_REPS-1]) ^ s_hwrite[INTF_REPS-1];    //hsize, hwrite, hprot, hburst, hmastlock
    assign s_hparity_o[5]   = (^s_htrans[INTF_REPS-1]);                           //htrans
`else
    assign s_hsize_o        = {1'b0,s_opex_f_i[0][1:0]};
    assign s_hwrite_o       = s_opex_f_i[0][3];
    assign s_haddr_o        = s_ap_address_i[0];
    assign s_htrans_o       = {s_ap_active[0],1'b0};
    assign s_hwdcheck_o     = 7'b0;
    assign s_hwdata_o       = s_rwdata[0];
    assign s_hparity_o      = 6'b0;
`endif

    //Output data for MA stage
    assign s_dp_ready_o     = s_hready_i;
    assign s_dp_data_o      = s_hrdata_i;
    assign s_dp_hresp_o     = s_rhresp;

    genvar i;
    generate
`ifdef PROTECTED_WITH_IFP 
        for (i = 0; i<INTF_REPS ;i++ ) begin : interface_replicator
            assign s_hsize[i]        = (rmw_activate[i]) ? 3'b010 : (s_rfsm[i] == LSU_RMW_WRITE) ? {1'b0,s_exma_f_i[i][1:0]} : {1'b0,s_opex_f_i[i][1:0]};
            assign s_hwrite[i]       = (rmw_activate[i]) ? 1'b0 : (s_rfsm[i] == LSU_RMW_WRITE) ? 1'b1 : s_opex_f_i[i][3]; 
            assign s_haddr[i][1:0]   = (rmw_activate[i]) ? 2'b00 : (s_rfsm[i] == LSU_RMW_WRITE) ? s_dp_address_i[i][1:0] : s_ap_address_i[i][1:0];
            assign s_haddr[i][31:2]  = (s_rfsm[i] == LSU_RMW_WRITE) ? s_dp_address_i[i][31:2] : s_ap_address_i[i][31:2];
            assign s_htrans[i]       = (s_rfsm[i] == LSU_RMW_WRITE) ? 2'b10 : {s_ap_active[i],1'b0};
        end
`endif
        for (i = 0; i<EXMA_REPS ;i++ ) begin : lsu_replicator
            //LSU activation
            assign s_ap_active[i]   = s_ap_approve_i[i] & ~s_flush_i[i];

            //Save bus responses
            always_comb begin : hresp_writer
                if(~s_resetn_i[i])begin
                    s_whresp[i] = 1'b0;
                end else begin
                    s_whresp[i] = s_hresp_i[i] & ~s_hready_i[i];
                end
            end
            
            always_comb begin : lsu_wdata
`ifdef PROTECTED_WITH_IFP
                if(~s_hready_i[i] | (s_rfsm[i] == LSU_RMW_READ)) begin
                    //The read-phase of RMW sequence prevents update of the wdata
                    s_wwdata[i] = s_rwdata[i];
                end else if(s_rfsm[i] == LSU_RMW_WRITE) begin
                    //Save merged data, that will be send in the following cycle
                    s_wwdata[i] = s_data_merged[i];
`else
                if(~s_hready_i[i]) begin
                    s_wwdata[i] = s_rwdata[i];
`endif
                end else begin
                    s_wwdata[i] = s_wdata_i[i];
                    //Align data according to the target address 
                    if(s_ap_address_i[i][1:0] == 2'b01)begin
                        s_wwdata[i][15:8] = s_wdata_i[i][7:0];
                    end else if(s_ap_address_i[i][1:0] == 2'b10)begin
                        s_wwdata[i][31:16] = s_wdata_i[i][15:0];
                    end else if(s_ap_address_i[i][1:0] == 2'b11)begin
                        s_wwdata[i][31:24] = s_wdata_i[i][7:0];
                    end
                end
            end
`ifdef PROTECTED_WITH_IFP
            //The RMW sequence begins if a non-word-wide store operation is requested
            assign rmw_activate[i]  = (s_rfsm[i] == LSU_RMW_IDLE) & s_opex_f_i[i%2][3] & (s_opex_f_i[i%2][1:0] != 2'b10);
            
            always_comb begin : lsu_control
                if(~s_resetn_i[i])begin
                    s_wfsm[i]   = LSU_RMW_IDLE;
                end else if(~s_hready_i[i]) begin
                    s_wfsm[i]   = s_rfsm[i];
                end else if(rmw_activate[i] & s_ap_active[i]) begin
                    s_wfsm[i]   = LSU_RMW_READ;
                end else if(s_rfsm[i] == LSU_RMW_READ) begin
                    s_wfsm[i]   = LSU_RMW_WRITE;
                end else begin
                    s_wfsm[i]   = LSU_RMW_IDLE;
                end
            end

            //Create checksum for data to be stored
            secded_encode m_wdata_encode (.s_data_i(s_rwdata[i]),.s_checksum_o(s_checksum[i]));

            //Calculate syndrome directly from the incoming data and checksum
            secded_encode m_encode   (.s_data_i(s_hrdata_i),.s_checksum_o(s_achecksum[i]));
            //Save syndrome for the analysis in the next clock cycle
            always_comb begin : lsu_checksum
                if(~s_resetn_i[i] | ~s_hready_i[i])begin
                    s_wlsyndrome[i]  = 7'b0;
                end else begin
                    s_wlsyndrome[i]  = s_achecksum[i] ^ s_hrdcheck_i;
                end
            end
            
            //Analyze read data
            secded_analyze m_analyze (.s_syndrome_i(s_rlsyndrome[i]),.s_ce_o(s_ce[i]),.s_uce_o(s_uce[i]));
            //Decode the read data - correct errors
            secded_decode m_decode   (.s_data_i(s_read_data_i[i]),.s_syndrome_i(s_rlsyndrome[i]),.s_data_o(s_data_fixed[i]));

            //During RMW sequence the read data are merged with the data to be stored, so the checksum can be computed
            assign s_data_merged[i][7:0]   = (s_dp_address_i[i][1:0] == 2'b00) ? s_rwdata[i][7:0] : s_data_fixed[i][7:0];
            assign s_data_merged[i][15:8]  = ((s_dp_address_i[i][1:0] == 2'b01) | (!s_dp_address_i[i][1] & s_exma_f_i[i][0])) ? s_rwdata[i][15:8] : s_data_fixed[i][15:8];
            assign s_data_merged[i][23:16] = (s_dp_address_i[i][1:0] == 2'b10) ? s_rwdata[i][23:16] : s_data_fixed[i][23:16];
            assign s_data_merged[i][31:24] = ((s_dp_address_i[i][1:0] == 2'b11) | (s_dp_address_i[i][1] & s_exma_f_i[i][0])) ? s_rwdata[i][31:24] : s_data_fixed[i][31:24];

            //Provides fixed data and information about detected errors into the MA stage
            assign s_fixed_data_o[i]= s_data_fixed[i];
            assign s_einfo_o[i]     = {s_uce[i], s_ce[i], s_rlsyndrome[i] != 7'b0};
            //The LSU cannot accept a new transfer during RMW sequence
            assign s_ap_busy_o[i]   = s_rfsm[i] != LSU_RMW_IDLE;
`else
            assign s_fixed_data_o[i]= 32'b0;
            assign s_einfo_o[i]     = 3'b0;
            assign s_ap_busy_o[i]   = 1'b0;
`endif
        end
    endgenerate
endmodule