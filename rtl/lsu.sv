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
    input logic s_clk_i[PROT_3REP],     //clock signal
    input logic s_resetn_i[PROT_3REP],  //reset signal
    input logic s_flush_i[PROT_3REP],   //flush signal      

    input logic[6:0] s_hrdcheck_i,      //AHB bus - incoming checksum
    input logic[31:0] s_hrdata_i,       //AHB bus - incomming read data
    input logic s_hready_i[PROT_3REP],  //AHB bus - finish of transfer
    input logic s_hresp_i[PROT_3REP],   //AHB bus - error response

    output logic[31:0] s_haddr_o,       //AHB bus - request address
    output logic[31:0] s_hwdata_o,      //AHB bus - request data to write
    output logic[6:0] s_hwdcheck_o,     //AHB bus - request data checksum                   
    output logic[2:0]s_hsize_o,         //AHB bus - size of the transfer                     
    output logic[1:0]s_htrans_o,        //AHB bus - transfer type indicator
    output logic s_hwrite_o,            //AHB bus - write indicator
    output logic[5:0] s_hparity_o,      //AHB bus - outgoing parity

    //Address phase
    input f_part s_opex_f_i[PROT_2REP],         //instruction function from EX stage
    input logic s_ap_approve_i[PROT_3REP],      //address phase approval  
    input logic s_idempotent_i[PROT_3REP],      //idempotent access
    input logic[31:0] s_ap_address_i[PROT_2REP],//address phase address 
    input logic[31:0] s_wdata_i[PROT_3REP],     //data to write
    output logic s_ap_busy_o[PROT_3REP],        //busy indicator - cannot start new address phase   

    //Data phase
    input f_part s_exma_f_i[PROT_3REP],         //instruction function from MA stage
    input logic[31:0] s_dp_address_i[PROT_3REP],//data phase address  
    output logic s_dp_ready_o[PROT_3REP],       //data phase stall signal
    output logic s_dp_hresp_o[PROT_3REP],       //data phase bus error
    output logic s_dp_save_o[PROT_3REP],        //data phase save data
    output logic[31:0] s_dp_data_o,             //data phase read data

    //Fix data
    input logic[31:0] s_read_data_i[PROT_3REP],     //data read by previous transfer
    output logic[31:0] s_fixed_data_o[PROT_3REP],   //fixed data
    output logic[1:0] s_einfo_o[PROT_3REP]          //data error info
);
    logic s_ap_active[PROT_3REP], s_whresp[PROT_3REP], s_rhresp[PROT_3REP], s_data_we[PROT_3REP];
    logic[31:0] s_wwdata[PROT_3REP], s_rwdata[PROT_3REP];
    logic[2:0] s_hsize[PROT_2REP], s_size[PROT_3REP];
    logic[1:0] s_htrans[PROT_2REP], s_trans[PROT_3REP];
    logic[31:0] s_haddr[PROT_2REP], s_addr[PROT_3REP];
    logic s_hwrite[PROT_2REP], s_write[PROT_3REP];
`ifdef PROT_INTF
    logic s_error[PROT_3REP], s_rchecksynd[PROT_3REP], s_wchecksynd[PROT_3REP], s_syndrome_we[PROT_3REP]; 
    logic s_rmw_activate[PROT_3REP], s_ce[PROT_3REP];
    logic[31:0] s_data_merged[PROT_3REP], s_data_fixed[PROT_3REP], s_wdata[1];
    logic[6:0] s_achecksum[PROT_3REP], s_wlsyndrome[PROT_3REP], s_rlsyndrome[PROT_3REP], s_checksum[PROT_3REP], s_wchecksum[1];
    logic[1:0] s_wfsm[PROT_3REP], s_rfsm[PROT_3REP];
`endif

    //Data for write
    seu_ff_we_rst #(.LABEL("WDATA"),.N(PROT_3REP))m_wdata (.s_c_i(s_clk_i),.s_r_i(s_resetn_i),.s_we_i(s_data_we),.s_d_i(s_wwdata),.s_q_o(s_rwdata));
    //Bus-transfer error
    seu_ff_rst #(.LABEL("HRESP"),.W(1),.N(PROT_3REP))m_hresp (.s_c_i(s_clk_i),.s_r_i(s_resetn_i),.s_d_i(s_whresp),.s_q_o(s_rhresp));
`ifdef PROT_INTF
    //Finite state machine for the Read-Modify-Write sequence
    seu_ff_rst #(.LABEL("FSM"),.W(2),.N(PROT_3REP))m_fsm (.s_c_i(s_clk_i),.s_r_i(s_resetn_i),.s_d_i(s_wfsm),.s_q_o(s_rfsm));
    //Indicator to check the syndrome of loaded data
    seu_ff_rst #(.LABEL("CHECKSYND"),.W(1),.N(PROT_3REP))m_checksynd (.s_c_i(s_clk_i),.s_r_i(s_resetn_i),.s_d_i(s_wchecksynd),.s_q_o(s_rchecksynd));
    //Syndrome of the loaded value
    seu_ff_we_rst #(.LABEL("LSYNDROME"),.N(PROT_3REP),.W(7))m_lsyndrome(.s_c_i(s_clk_i),.s_r_i(s_resetn_i),.s_we_i(s_syndrome_we),.s_d_i(s_wlsyndrome),.s_q_o(s_rlsyndrome)); 

    //Parity protection signal is determined by pipeline 1
    logic[31:0] s_aux_addr;
    assign s_aux_addr = s_haddr[PROT_2REP-1];
    genvar p;
    generate
        for (p=0;p<4;p++) begin
            assign s_hparity_o[p]   = s_aux_addr[0 + p] ^ s_aux_addr[4 + p] ^ s_aux_addr[8 + p] ^ s_aux_addr[12 + p] ^
                                      s_aux_addr[16 + p] ^ s_aux_addr[20 + p] ^ s_aux_addr[24 + p] ^ s_aux_addr[28 + p];            
        end
    endgenerate
    assign s_hparity_o[4]   = (^s_hsize[PROT_2REP-1]) ^ s_hwrite[PROT_2REP-1];    //hsize, hwrite, hprot, hburst, hmastlock
    assign s_hparity_o[5]   = (^s_htrans[PROT_2REP-1]);                           //htrans
    assign s_hwdcheck_o     = s_wchecksum[0];
    assign s_hwdata_o       = s_wdata[0];
`else
    assign s_hparity_o      = 6'b0;
    assign s_hwdcheck_o     = 7'b0;
    assign s_hwdata_o       = s_rwdata[0];
`endif

    //Data bus interface signals - AHB Control signals are determined by pipeline 0
    assign s_hsize_o        = s_hsize[0];
    assign s_hwrite_o       = s_hwrite[0]; 
    assign s_haddr_o        = s_haddr[0];
    assign s_htrans_o       = s_htrans[0];

    //Output data for MA stage
    assign s_dp_ready_o     = s_hready_i;
    assign s_dp_data_o      = s_hrdata_i;
    assign s_dp_hresp_o     = s_rhresp;

`ifdef PROT_PIPE
    //Majority voting to select address-phase bus signals
    tmr_comb #(.W(1),.OUT_REPS(2)) m_tmr_hwrite (.s_d_i(s_write),.s_d_o(s_hwrite));
    tmr_comb #(.W(2),.OUT_REPS(2)) m_tmr_htrans (.s_d_i(s_trans),.s_d_o(s_htrans));
    tmr_comb #(.W(3),.OUT_REPS(2)) m_tmr_hsize (.s_d_i(s_size),.s_d_o(s_hsize));
    tmr_comb #(.W(32),.OUT_REPS(2)) m_tmr_haddr (.s_d_i(s_addr),.s_d_o(s_haddr));
    //Majority voting to select data-phase bus signals
    tmr_comb #(.OUT_REPS(1)) m_tmr_sval (.s_d_i(s_rwdata),.s_d_o(s_wdata));
    tmr_comb #(.OUT_REPS(1),.W(7)) m_tmr_schecksum (.s_d_i(s_checksum),.s_d_o(s_wchecksum));
`else
    assign s_hwrite[0]      = s_write[0];
    assign s_htrans[0]      = s_trans[0];
    assign s_hsize[0]       = s_size[0];
    assign s_haddr[0]       = s_addr[0];    
`ifdef PROT_INTF
    assign s_wdata[0]       = s_rwdata[0];
    assign s_wchecksum[0]   = s_checksum[0];
`endif
`endif

    genvar i;
    generate
        for (i = 0; i<PROT_3REP ;i++ ) begin : lsu_replicator
            always_comb begin : request_control
                s_size[i]  = {1'b0,s_opex_f_i[i%2][1:0]};
                s_write[i] = s_opex_f_i[i%2][3]; 
                s_addr[i]  = s_ap_address_i[i%2];
                s_trans[i] = {s_ap_active[i],1'b0};
`ifdef PROT_INTF
                if(s_rmw_activate[i])begin
                    //at the beggining of the RMW sequence is always a load from from aligned address 
                    s_size[i][1:0] = 2'b10;
                    s_write[i]     = 1'b0;
                    s_addr[i][1:0] = 2'b00;
                end else if(s_rfsm[i] == LSU_RMW_WRITE)begin
                    //the original transfer is performed in the write phase
                    s_size[i][1:0] = s_exma_f_i[i][1:0];
                    s_write[i]     = 1'b1;
                    s_addr[i]      = s_dp_address_i[i];
                    s_trans[i]     = 2'b10;
                end else if(!s_opex_f_i[i%2][3])begin
                    //narrower read requests are transformed to reading the whole word so the core can check the checksum
                    s_size[i][1:0] = 2'b10;
                    s_addr[i][1:0] = 2'b00;
                end
`endif
            end
            //Save data that will be send through the bus
            always_comb begin : lsu_wdata
                s_wwdata[i] = s_wdata_i[i];
                //Align data according to the target address 
                if(s_ap_address_i[i%2][1:0] == 2'b01)begin
                    s_wwdata[i][15:8] = s_wdata_i[i][7:0];
                end else if(s_ap_address_i[i%2][1:0] == 2'b10)begin
                    s_wwdata[i][31:16] = s_wdata_i[i][15:0];
                end else if(s_ap_address_i[i%2][1:0] == 2'b11)begin
                    s_wwdata[i][31:24] = s_wdata_i[i][7:0];
                end
`ifdef PROT_INTF
                if(s_rfsm[i] == LSU_RMW_WRITE) begin
                    //Save merged data, that will be send in the following cycle
                    s_wwdata[i] = s_data_merged[i];
                end
`endif
            end

            //LSU activation
            assign s_ap_active[i]   = s_ap_approve_i[i] & ~s_flush_i[i];
`ifndef PROT_INTF
            //Save bus responses
            assign s_whresp[i]      = ~s_hready_i[i] & s_hresp_i[i];        
            assign s_data_we[i]     = s_hready_i[i] & s_ap_active[i] & s_opex_f_i[i%2][3];
            assign s_fixed_data_o[i]= 32'b0;
            assign s_einfo_o[i]     = 2'b0;
            assign s_ap_busy_o[i]   = 1'b0;
            assign s_dp_save_o[i]   = !s_exma_f_i[i][3];
`else
            //Save bus responses - ignored if it happens without an intended bus request
            assign s_whresp[i]      = ~s_hready_i[i] & s_hresp_i[i] & (s_rfsm[i] != LSU_RMW_WRITE);
            assign s_data_we[i]     = s_hready_i[i] & ((s_ap_active[i] & s_opex_f_i[i%2][3]) | (s_rfsm[i] == LSU_RMW_WRITE));

            //The RMW sequence begins if a non-word-wide store operation is requested
            assign s_rmw_activate[i]= (s_rfsm[i] == LSU_RMW_IDLE) & s_opex_f_i[i%2][3] & (s_opex_f_i[i%2][1:0] != 2'b10) & s_idempotent_i[i];
            
            //The RMW sequence finite stat emachine control
            always_comb begin : rmw_control
                if(~s_hready_i[i]) begin
                    s_wfsm[i]   = s_rfsm[i];
                end else if(s_rmw_activate[i] & s_ap_active[i]) begin
                    s_wfsm[i]   = LSU_RMW_READ;
                end else if(!s_rhresp[i] & (s_rfsm[i] == LSU_RMW_READ)) begin
                    s_wfsm[i]   = LSU_RMW_WRITE;
                end else begin
                    s_wfsm[i]   = LSU_RMW_IDLE;
                end
            end

            //Data syndrome analysis control
            always_comb begin : checksynd_control
                if(s_hready_i[i] && (s_htrans[i%2] != 2'b0) && !s_hwrite[i%2]) begin
                    //check syndrome after each load transfer
                    s_wchecksynd[i] = 1'b1;
                end else if(s_hready_i[i] && (s_rfsm[i] == LSU_RMW_IDLE)) begin
                    s_wchecksynd[i] = 1'b0;
                end else begin
                    //preserve the syndrome checking until the RMW finishes
                    s_wchecksynd[i] = s_rchecksynd[i];
                end
            end

            //Create checksum for data to be stored
            secded_encode m_wdata_encode (.s_data_i(s_rwdata[i]),.s_checksum_o(s_checksum[i]));

            //Calculate syndrome directly from the incoming data and checksum
            secded_encode m_encode   (.s_data_i(s_hrdata_i),.s_checksum_o(s_achecksum[i]));
           
            assign s_syndrome_we[i] = (s_hready_i[i] && (((s_rfsm[i] == LSU_RMW_IDLE) && !s_exma_f_i[i][3]) || (s_rfsm[i] == LSU_RMW_READ))) ||
                                      (!s_rchecksynd[i] && (s_rlsyndrome[i] != 7'b0));

            /* Save syndrome for the analysis in the next clock cycle. EDAC errors detected during the RMW sequence 
               do not affect the sequence but are preserved to be reported once the RMW finishes. */
            always_comb begin : lsu_checksum
                if(!s_rchecksynd[i] && (s_rlsyndrome[i] != 7'b0))begin
                    //clear syndrome
                    s_wlsyndrome[i]  = 7'b0;
                end else begin
                    //save syndrome in the data phase of a load transfer
                    s_wlsyndrome[i]  = s_achecksum[i] ^ s_hrdcheck_i;
                end
            end
            
            //Analyze read data
            secded_analyze m_analyze (.s_syndrome_i(s_rlsyndrome[i]),.s_error_o(s_error[i]),.s_ce_o(s_ce[i]));
            //Decode the read data - correct errors
            secded_decode m_decode   (.s_data_i(s_read_data_i[i]),.s_syndrome_i(s_rlsyndrome[i]),.s_data_o(s_data_fixed[i]));

            //During RMW sequence the read data are merged with the data to be stored, so the checksum can be computed
            assign s_data_merged[i][7:0]   = (s_dp_address_i[i][1:0] == 2'b00) ? s_rwdata[i][7:0] : s_data_fixed[i][7:0];
            assign s_data_merged[i][15:8]  = ((s_dp_address_i[i][1:0] == 2'b01) | (!s_dp_address_i[i][1] & s_exma_f_i[i][0])) ? s_rwdata[i][15:8] : s_data_fixed[i][15:8];
            assign s_data_merged[i][23:16] = (s_dp_address_i[i][1:0] == 2'b10) ? s_rwdata[i][23:16] : s_data_fixed[i][23:16];
            assign s_data_merged[i][31:24] = ((s_dp_address_i[i][1:0] == 2'b11) | (s_dp_address_i[i][1] & s_exma_f_i[i][0])) ? s_rwdata[i][31:24] : s_data_fixed[i][31:24];

            //Provides fixed data and information about detected errors into the MA stage
            assign s_fixed_data_o[i]= s_data_fixed[i];
            assign s_einfo_o[i]     = {s_ce[i], s_error[i]};
            //The LSU cannot accept a new transfer during RMW sequence
            assign s_ap_busy_o[i]   = (s_rfsm[i] != LSU_RMW_IDLE) && !s_rhresp[i];
            //Signalize when the data from the bus should be saved
            assign s_dp_save_o[i]   = ((s_rfsm[i] == LSU_RMW_IDLE) && !s_exma_f_i[i][3]) || (s_rfsm[i] == LSU_RMW_READ);
`endif
        end
    endgenerate
endmodule