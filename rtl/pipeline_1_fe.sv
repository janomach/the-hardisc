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

module pipeline_1_fe #(
    parameter PMA_REGIONS = 3,
    parameter pma_cfg_t PMA_CFG[PMA_REGIONS-1:0] = PMA_DEFAULT
)(
    input logic s_clk_i[PROT_3REP],                 //clock signal
    input logic s_resetn_i[PROT_3REP],              //reset signal

    input logic[4:0] s_stall_i[PROT_3REP],          //stall signals from upper stages
    input logic s_flush_i[PROT_3REP],               //flush signal from MA stage

    input logic[31:0] s_mhrdctrl0_i[PROT_3REP],     //settings

    input logic s_bop_pop_i,                        //pop of the oldest entry in the BOP
    output logic s_bop_pred_o[PROT_2REP],           //the prediction is prepared in the BOP
    output logic[30:0] s_bop_tadd_o[PROT_2REP],     //predicted target address saved in the BOP

    input logic s_pred_clean_i,                     //clean selected prediction information
    input logic s_pred_btbu_i,                      //update BTB of branch predictor
    input logic s_pred_btrue_i,                     //executed branch has fulfilled condition
    input logic s_pred_rvc_i,                       //executed instruction is RVC
    input logic s_pred_bpu_i,                       //update branch predictor
    input logic s_pred_jpu_i,                       //update jump predictor
    input logic[19:0] s_pred_offset_i,              //address offset for prediction
    input logic[31:0] s_pred_base_i,                //base address for prediction
    input logic[31:0] s_toc_add_i[PROT_3REP],       //address for transfer of control

    input logic[6:0] s_hrdcheck_i,                  //AHB bus - incoming checksum
    input logic[31:0] s_hrdata_i,                   //AHB bus - incomming read data
    input logic s_hready_i[PROT_3REP],              //AHB bus - finish of transfer
    input logic s_hresp_i[PROT_3REP],               //AHB bus - error response
    output logic[31:0] s_haddr_o,                   //AHB bus - request address
    output logic[1:0]s_htrans_o,                    //AHB bus - transfer type indicator
    output logic[5:0] s_hparity_o,                  //AHB bus - outgoing parity

    output logic[31:0] s_feid_instr_o[PROT_2REP],   //instruction to execute for ID stage
    output logic[4:0] s_feid_info_o[PROT_2REP],     //instruction payload information for ID stage
    output logic[1:0] s_feid_pred_o[PROT_2REP]      //instruction prediction information for ID stage
);
    /*  Fetch stage separation:
        The core uses AHB3-Lite protocol for bus transfers. Each transfer is composed of the address phase and the data phase.
        This means that also the fetch stage is separated into two phases: FE0 (address phase) and FE1 (data phase).
        A request is sent out by the core in the FE0 and in the phase FE1, the core awaits response.
        According to the protocol the core can initiate address phase of transfer B if it waits for the transfer A. */
    logic[30:0] s_wfe0_add[PROT_2REP], s_rfe0_add[PROT_2REP], s_wfe1_add[PROT_2REP], s_rfe1_add[PROT_2REP];
    logic s_wfe0_utd[PROT_2REP], s_rfe0_utd[PROT_2REP], s_wfe1_utd[PROT_2REP], s_rfe1_utd[PROT_2REP];
    logic[1:0] s_rfe1_inf[PROT_2REP], s_wfe1_inf[PROT_2REP];
    logic[IFB_WIDTH-1:0] s_ifb_wdata[PROT_2REP], s_ifb_rdata[PROT_2REP];
    logic s_clk_prw[PROT_2REP], s_resetn_prw[PROT_2REP], s_ifb_valid[PROT_2REP];

    //Fetch address saved in FE0
    seu_ff #(.LABEL("FE0_ADD"),.W(31),.N(PROT_2REP)) m_fe0_add (.s_c_i(s_clk_prw),.s_d_i(s_wfe0_add),.s_q_o(s_rfe0_add));
    //Address in FE0 is up-to-date, the fetched data will be needed
    seu_ff_rst #(.LABEL("FE0_UTD"),.W(1),.N(PROT_2REP)) m_fe0_utd (.s_c_i(s_clk_prw),.s_r_i(s_resetn_prw),.s_d_i(s_wfe0_utd),.s_q_o(s_rfe0_utd));
    //Fetch address saved in FE1
    seu_ff #(.LABEL("FE1_ADD"),.W(31),.N(PROT_2REP)) m_fe1_add (.s_c_i(s_clk_prw),.s_d_i(s_wfe1_add),.s_q_o(s_rfe1_add));
    //Address in FE1 is up-to-date, the fetched data will be needed
    seu_ff_rst #(.LABEL("FE1_UTD"),.W(1),.N(PROT_2REP)) m_fe1_utd (.s_c_i(s_clk_prw),.s_r_i(s_resetn_prw),.s_d_i(s_wfe1_utd),.s_q_o(s_rfe1_utd));
    /*  Additional information about FE1:
        2'b00: none
        2'b01: prediction of TOC from aligned part of the address
        2'b10: prediction of TOC from unaligned part of the address
        2'b11: contains an address that should be copied into the FE0 (if not-up-to-date), PMA violation (if up-to-date)*/
    seu_ff_rst #(.LABEL("FE1_INF"),.W(2),.N(PROT_2REP)) m_fe1_inf (.s_c_i(s_clk_prw),.s_r_i(s_resetn_prw),.s_d_i(s_wfe1_inf),.s_q_o(s_rfe1_inf));

    //Internal signals
    logic s_ifb_push[PROT_2REP], s_ifb_pop[PROT_2REP], s_flush_fe[PROT_2REP], s_toc_in_fe1[PROT_2REP],  s_ifb_available[PROT_2REP];
    logic[`OPTION_FIFO_SIZE-1:0] s_ifb_occupied[PROT_2REP];
    logic[IFB_WIDTH-1:0] s_ifb_last_entry[PROT_2REP];
    logic[31:0] s_f0_add_next[PROT_2REP];
    logic s_ras_toc_valid[PROT_2REP], s_ras_pred_free[PROT_2REP], s_pred_toc_valid[PROT_2REP], s_discrepancy[PROT_2REP];
    logic[1:0] s_ras_toc[PROT_2REP], s_pred_toc[PROT_2REP];
    logic s_pma_idempotent[PROT_2REP], s_pma_violation[PROT_2REP], s_wo_trreq_fe1[PROT_2REP];
    logic s_bop_push[PROT_2REP], s_bop_hazard[PROT_2REP], s_bop_full[PROT_2REP], s_bop_afull[PROT_2REP];
    logic[30:0] s_bop_wdata[PROT_2REP];
    
    //Instruction bus interface signals
    assign s_haddr_o    = {s_rfe0_add[0][30:1],2'b0};
    assign s_htrans_o   = (s_rfe0_utd[0] && !s_pma_violation[0]) ? 2'b10 : 2'b00;

`ifdef PROT_INTF
    logic[31:0] s_aux_addr;
    assign s_aux_addr = {s_rfe0_add[PROT_2REP-1][30:1],2'b0};
    genvar p;
    generate
        for (p=0;p<4;p++) begin
            assign s_hparity_o[p]   = s_aux_addr[0 + p] ^ s_aux_addr[4 + p] ^ s_aux_addr[8 + p] ^ s_aux_addr[12 + p] ^
                                      s_aux_addr[16 + p] ^ s_aux_addr[20 + p] ^ s_aux_addr[24 + p] ^ s_aux_addr[28 + p];            
        end
    endgenerate
    assign s_hparity_o[4]   = 1'b1;                             //hsize, hwrite, hprot, hburst, hmastlock
    assign s_hparity_o[5]   = (s_rfe0_utd[PROT_2REP-1] && !s_pma_violation[PROT_2REP-1]);  //htrans
`else
    assign s_hparity_o      = 6'b0;
`endif

    //Prediction of the next fetch address
    logic[1:0] s_pred_taken, s_ras_pop;
    logic[31:0] s_pred_tadd;
    logic s_ras_enable;
    logic[30:0] s_ras_pred_add;

    //Predictor for branches and jumps
    predictor m_predictor
    (
        .s_clk_i(s_clk_i[0]),
        .s_resetn_i(s_resetn_i[0]),
        .s_invalidate_i(s_pred_clean_i),
        .s_fetch_add_i(s_rfe0_add[0]),

        .s_instr_rvc_i(s_pred_rvc_i),
        .s_btb_update_i(s_pred_btbu_i),
        .s_offset_i(s_pred_offset_i),
        .s_base_add_i(s_pred_base_i),
        .s_branch_taken_i(s_pred_btrue_i),
        .s_branch_update_i(s_pred_bpu_i),
        .s_jump_update_i(s_pred_jpu_i),
        
        .s_pred_taken_o(s_pred_taken),
        .s_pred_add_o(s_pred_tadd)
    );

    //Enable RAS prediction only if BOP has free space and the Predictor did to predicted TOC
    assign s_ras_enable = ~s_bop_hazard[0] & s_ras_pred_free[0];

    //Return Address Stack
    ras m_ras
    (
        .s_clk_i(s_clk_i[0]),
        .s_resetn_i(s_resetn_i[0]),
        .s_flush_i(s_flush_fe[0]),
        .s_enable_i(s_ras_enable),
        .s_invalidate_i(s_pred_clean_i),
        .s_valid_i(s_ifb_push[0]),
        .s_ualign_i(s_ifb_last_entry[0][32]),
        .s_data_i(s_ifb_last_entry[0][31:0]),
        .s_fetch_addr_i(s_rfe1_add[0][30:1]),
        .s_poped_o(s_ras_pop),
        .s_pop_addr_o(s_ras_pred_add)
    );

    genvar i;
    generate
        for (i = 0; i < PROT_2REP ; i++) begin : fe_rep
            assign s_clk_prw[i]         = s_clk_i[i];
            assign s_resetn_prw[i]      = s_resetn_i[i];
            assign s_flush_fe[i]        = s_flush_i[i]; 

            //RAS barrier, active if BOP is full, prediction is not allowed, last entry of IFB is not valid, or predictor did prediction 
            assign s_ras_toc[i]         = (s_bop_hazard[i] | s_mhrdctrl0_i[i][3] | ~s_ras_pred_free[i] | ~s_ifb_occupied[i][0] | (s_ifb_occupied[i] == 4'b1111)) ? 2'b0 : s_ras_pop;
            assign s_ras_toc_valid[i]   = s_ras_toc[i] != 2'b0;
            assign s_ras_pred_free[i]   = s_ifb_last_entry[i][37:36] == 2'b0;

            //Predictor barrier, active if BOP is full or prediction is not allowed
            assign s_pred_toc[i]        = (s_bop_hazard[i] | s_mhrdctrl0_i[i][3] | ~s_pred_taken[1]) ? 2'b0 : s_pred_taken[0] ? 2'b01 : 2'b10;
            assign s_pred_toc_valid[i]  = s_pred_toc[i] != 2'b0;

`ifdef PROT_PIPE
            assign s_discrepancy[i]     = s_rfe1_add[0] != s_rfe1_add[1];
`else
            assign s_discrepancy[i]     = 1'b0;
`endif

            //Update and control of the IFB
            assign s_ifb_pop[i]         = ~(s_stall_i[i][PIPE_ID]);
            assign s_ifb_push[i]        = s_hready_i[i] & s_rfe1_utd[i] & ~s_ras_toc_valid[i];
            assign s_ifb_wdata[i][31:0] = s_hrdata_i;
            assign s_ifb_wdata[i][32]   = s_rfe1_add[i][0];
            assign s_ifb_wdata[i][35:33]= s_discrepancy[i] ? FETCH_DSCR : s_wo_trreq_fe1[i] ? FETCH_PMAVN : s_hresp_i[i] ? FETCH_BSERR : FETCH_VALID;
            assign s_ifb_wdata[i][37:36]= s_wo_trreq_fe1[i] ? 2'b0 : s_rfe1_inf[i];
            //Output of the IFB
            assign s_feid_info_o[i]     = {s_ifb_rdata[i][35:32], ~s_ifb_valid[i]};
            assign s_feid_instr_o[i]    = s_ifb_rdata[i][31:0];
            assign s_feid_pred_o[i]     = s_ifb_rdata[i][37:36];

            ifb #(.LABEL("FE_FIFO"),.SIZE(`OPTION_FIFO_SIZE)) m_ifb
            (
                .s_clk_i(s_clk_i[i]),
                .s_resetn_i(s_resetn_i[i]),
                .s_flush_i(s_flush_fe[i]),
                .s_push_i(s_ifb_push[i]),
                .s_pop_i(s_ifb_pop[i]),
                .s_ras_pred_i(s_ras_toc[i]),
                .s_data_i(s_ifb_wdata[i]),
                .s_checksum_i(s_hrdcheck_i),
                .s_data_o(s_ifb_rdata[i]),
                .s_valid_o(s_ifb_valid[i]),
                .s_occupied_o(s_ifb_occupied[i]),
                .s_last_entry_o(s_ifb_last_entry[i])
            );

            //Update and control of the BOP
            assign s_bop_push[i]     = (s_ifb_push[i] & (s_rfe1_inf[i] != 2'b0)) | s_ras_toc_valid[i];
            assign s_bop_wdata[i]    = s_ras_toc_valid[i] ? s_ras_pred_add : s_rfe0_add[i];
            assign s_bop_hazard[i]   = ~s_bop_pop_i & (s_bop_full[i] | (s_bop_afull[i] & (s_rfe1_inf[i] != 2'b0)));

            bop #(.LABEL("FE_BOP"),.SIZE(`OPTION_BOP_SIZE)) m_bop
            (
                .s_clk_i(s_clk_i[i]),
                .s_resetn_i(s_resetn_i[i]),
                .s_flush_i(s_flush_fe[i]),
                .s_push_i(s_bop_push[i]),
                .s_pop_i(s_bop_pop_i),
                .s_data_i(s_bop_wdata[i]),
                .s_data_o(s_bop_tadd_o[i]),
                .s_full_o(s_bop_full[i]),
                .s_afull_o(s_bop_afull[i]),
                .s_entry_ready_o(s_bop_pred_o[i])
            );

            /*  It is allowed to start fetch only if it is sure that there will be free space in time of data arrival.
                The free space is ensured if: a) Both FE0 and FE1 are empty, and IFB has 1 free entry
                                              b) Either FE0 or FE1 is empty, and IFB has 2 free entries
                                              c) IFB has 3 free entries */
            assign s_ifb_available[i]   = (~s_ifb_occupied[i][`OPTION_FIFO_SIZE-1] & (~s_rfe1_utd[i] & ~s_rfe0_utd[i])) | 
                                          (~s_ifb_occupied[i][`OPTION_FIFO_SIZE-2] & (~s_rfe1_utd[i] | ~s_rfe0_utd[i])) |
                                           ~s_ifb_occupied[i][`OPTION_FIFO_SIZE-3];
            //TOC address is saved in FE1
            assign s_toc_in_fe1[i]      = (~s_rfe1_utd[i] & (s_rfe1_inf[i] == 2'b11));
            //FE1 contains up-to-date data, but without transfer request
            assign s_wo_trreq_fe1[i]    = (s_rfe1_utd[i] & (s_rfe1_inf[i] == 2'b11));

            pma #(.FETCH(1),.PMA_REGIONS(PMA_REGIONS),.PMA_CFG(PMA_CFG)) m_pma 
            (
                .s_address_i({s_rfe0_add[i][30:1],2'b0}),
                .s_write_i(1'b0),
                .s_idempotent_o(s_pma_idempotent[i]),
                .s_violation_o(s_pma_violation[i])
            );                             

            always_comb begin : fe1_update
                if((s_flush_fe[i] | s_ras_toc_valid[i]) & ~s_hready_i[i] & s_rfe0_utd[i])begin
                /*  The core cannot change an address of the following request, if the hready signal 
                    from bus interface is held at 0 after leading request. This means the FE0 cannot
                    be updated, so the TOC information are saved in the FE1. */
                    if(s_flush_fe[i])begin
                        s_wfe1_add[i]   = s_toc_add_i[i][31:1];
                    end else begin
                        s_wfe1_add[i]   = s_ras_pred_add;
                    end
                    s_wfe1_utd[i]   = 1'b0;
                    s_wfe1_inf[i]   = 2'b11;
                end else begin
                    if(s_flush_fe[i] | s_ras_toc_valid[i] | (s_hready_i[i] & s_toc_in_fe1[i]))begin
                        //FE1 can be flushed
                        s_wfe1_add[i]   = 31'b0;
                        s_wfe1_utd[i]   = 1'b0;
                        s_wfe1_inf[i]   = 2'b0;
                    end else if(~s_hready_i[i])begin
                        //FE1 must be preserved
                        s_wfe1_add[i]   = s_rfe1_add[i];
                        s_wfe1_utd[i]   = s_rfe1_utd[i];
                        s_wfe1_inf[i]   = s_rfe1_inf[i];
                    end else begin
                        //FE1 is updated with data from FE0 and the Predictor
                        s_wfe1_add[i]   = s_rfe0_add[i];
                        s_wfe1_utd[i]   = s_rfe0_utd[i];
                        s_wfe1_inf[i]   = (s_pma_violation[i] & s_rfe0_utd[i]) ? 2'b11 : s_pred_toc[i];
                    end
                end
            end
            
            always_comb begin : fe0_update
                if(~s_hready_i[i] & s_rfe0_utd[i])begin
                /*  The core cannot change an address of the following request, if the hready signal 
                    from bus interface is held at 0 after leading request. */
                    s_wfe0_add[i] = s_rfe0_add[i];
                    s_wfe0_utd[i] = 1'b1;  
                end else begin
                    if(s_flush_fe[i] | s_toc_in_fe1[i] | s_ras_toc_valid[i])begin
                        if(s_flush_fe[i])begin
                            //TOC signalized from MA stage
                            s_wfe0_add[i] = s_toc_add_i[i][31:1];
                            s_wfe0_utd[i] = 1'b1;
                        end else if(s_toc_in_fe1[i])begin
                            //TOC saved in the FE1
                            s_wfe0_add[i] = s_rfe1_add[i];
                            s_wfe0_utd[i] = 1'b1;
                        end else begin
                            //TOC signalized by RAS
                            s_wfe0_add[i] = s_ras_pred_add;
                            s_wfe0_utd[i] = ~s_ifb_occupied[i][`OPTION_FIFO_SIZE-1];
                        end
                    end else if(s_rfe0_utd[i])begin
                        if(s_pred_toc_valid[i])begin
                            //TOC signalized by Predictor
                            s_wfe0_add[i] = s_pred_tadd[31:1];
                        end else begin
                            //Fetch address incrementation
                            s_wfe0_add[i] = {s_f0_add_next[i][29:0],1'b0};
                        end
                        //FE0 will be valid only if IFB has free space
                        s_wfe0_utd[i] = s_ifb_available[i];
                    end else begin
                    /*  Preserve data until IFB has free space; this path is active 
                        only if IFB had no free space in previous clock cycles */
                        s_wfe0_add[i] = s_rfe0_add[i];
                        s_wfe0_utd[i] = s_ifb_available[i];
                    end
                end
            end

            fast_increment m_f0_adder(.s_base_val_i({2'b0,s_rfe0_add[i][30:1]}),.s_val_o(s_f0_add_next[i])); 
        end
    endgenerate

endmodule
