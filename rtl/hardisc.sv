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

module hardisc #(
    parameter PMA_REGIONS = 3,
    parameter pma_cfg_t PMA_CFG[PMA_REGIONS-1:0] = PMA_DEFAULT
)(
    input logic s_clk_i[PROT_3REP],         //clock signal
    input logic s_resetn_i[PROT_3REP],      //reset signal

    input logic s_int_meip_i,               //external interrupt
    input logic s_int_mtip_i,               //timer interrupt
    input logic[31:0] s_boot_add_i,         //boot address
    
    input logic[31:0] s_i_hrdata_i,         //AHB instruction bus - incomming read data
    input logic s_i_hready_i[PROT_3REP],    //AHB instruction bus - finish of transfer
    input logic s_i_hresp_i[PROT_3REP],     //AHB instruction bus - error response
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
    input logic s_d_hready_i[PROT_3REP],    //AHB data bus - finish of transfer
    input logic s_d_hresp_i[PROT_3REP],     //AHB data bus - error response
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

    output logic s_unrec_err_o[PROT_2REP]   //unrecoverable error
);

    logic[4:0] s_stall[PROT_3REP];
    logic s_flush[PROT_3REP], s_hold[PROT_3REP];
    logic[3:0] s_opex_fwd[PROT_2REP];
    logic[20:0] s_opex_payload[PROT_2REP];
    logic[31:0]s_feid_instr[PROT_2REP];
    logic[4:0] s_feid_info[PROT_2REP];
    logic[19:0] s_exma_offset;
    logic[11:0] s_exma_payload[PROT_3REP];
    logic[31:0] s_exma_val[PROT_3REP], s_mawb_val[PROT_3REP], s_idop_p1[PROT_2REP], s_idop_p2[PROT_2REP], s_opex_op1[PROT_2REP], s_opex_op2[PROT_2REP], 
                s_toc_addr[PROT_3REP], s_rf_val[PROT_3REP], s_lsu_wdata[PROT_3REP], s_read_data[PROT_3REP], s_lsu_fixed_data[PROT_3REP];
    logic[20:0] s_idop_payload[PROT_2REP];
    logic[1:0] s_feid_pred[PROT_2REP];
    logic s_idop_fixed[PROT_2REP];
    f_part s_idop_f[PROT_2REP], s_opex_f[PROT_2REP], s_exma_f[PROT_3REP];
    rf_add s_idop_rs1[PROT_2REP], s_idop_rs2[PROT_2REP], s_idop_rd[PROT_2REP], s_opex_rd[PROT_2REP], s_exma_rd[PROT_3REP], s_mawb_rd[PROT_3REP];
    ictrl s_idop_ictrl[PROT_2REP], s_exma_ictrl[PROT_3REP], s_mawb_ictrl[PROT_3REP], s_opex_ictrl[PROT_2REP];
    imiscon s_idop_imiscon[PROT_2REP], s_opex_imiscon[PROT_2REP], s_exma_imiscon[PROT_3REP];
    sctrl s_idop_sctrl[PROT_2REP];
    logic s_stall_ma[PROT_3REP],s_stall_ex[PROT_3REP],s_stall_op[PROT_3REP],s_stall_id[PROT_3REP],
            s_pred_bpu, s_pred_jpu, s_pred_btrue, s_pred_btbu, s_pred_clean, s_lsu_busy[PROT_3REP], s_lsu_approve[PROT_3REP], s_lsu_idempotent[PROT_3REP];
    logic[31:0] s_pc[PROT_3REP], s_mhrdctrl0[PROT_3REP], s_lsu_ap_address, s_lsu_dp_data;
    logic[30:0] s_bop_tadd[PROT_2REP];
    logic s_bop_pred[PROT_2REP], s_bop_pop, s_lsu_ap_approve, s_lsu_dp_ready[PROT_3REP], s_lsu_dp_hresp[PROT_3REP], s_lsu_dp_save[PROT_3REP];
    logic[1:0] s_lsu_einfo[PROT_3REP];

`ifdef PROT_PIPE
    assign s_unrec_err_o[0]   = s_mhrdctrl0[0][2];
    assign s_unrec_err_o[1]   = s_mhrdctrl0[1][2];
`else                        
    assign s_unrec_err_o[0]   = 1'b0;                   
`endif
    
    //AHB instruction bus - hardwired signals
    assign s_i_hwchecksum_o = 7'b0;
    assign s_i_hwdata_o     = 32'b0;
    assign s_i_hburst_o     = 3'b0;
    assign s_i_hmastlock_o  = 1'b0;
    assign s_i_hprot_o      = 4'b0;
    assign s_i_hsize_o      = 3'b010;
    assign s_i_hwrite_o     = 1'b0;

    //AHB data bus - hardwired signals
    assign s_d_hburst_o     = 3'b0;
    assign s_d_hmastlock_o  = 1'b0;
    assign s_d_hprot_o      = 4'b0;

    genvar i;
    generate
        for (i = 0; i<PROT_3REP ;i++ ) begin : integration_replicator
            assign s_stall[i] = {s_stall_ma[i],s_stall_ex[i],s_stall_op[i],s_stall_id[i],1'b0};          
        end  
    endgenerate

    pipeline_1_fe #(.PMA_REGIONS(PMA_REGIONS),.PMA_CFG(PMA_CFG)) m_pipe_1_fe
    (
        .s_clk_i(s_clk_i),
        .s_resetn_i(s_resetn_i),

        .s_stall_i(s_stall), 
        .s_flush_i(s_flush),

        .s_mhrdctrl0_i(s_mhrdctrl0),

        .s_bop_pop_i(s_bop_pop),
        .s_bop_pred_o(s_bop_pred),
        .s_bop_tadd_o(s_bop_tadd),

        .s_pred_base_i(s_pc[0]),
        .s_pred_offset_i(s_exma_offset),
        .s_pred_rvc_i(s_exma_ictrl[0][ICTRL_RVC]),
        .s_pred_clean_i(s_pred_clean),
        .s_pred_btbu_i(s_pred_btbu),
        .s_pred_btrue_i(s_pred_btrue),
        .s_pred_bpu_i(s_pred_bpu),
        .s_pred_jpu_i(s_pred_jpu),
        .s_toc_add_i(s_toc_addr),

        .s_hrdcheck_i(s_i_hrchecksum_i),
        .s_hrdata_i(s_i_hrdata_i),
        .s_hready_i(s_i_hready_i),
        .s_hresp_i(s_i_hresp_i),
        .s_haddr_o(s_i_haddr_o),
        .s_htrans_o(s_i_htrans_o),
        .s_hparity_o(s_i_hparity_o),

        .s_feid_info_o(s_feid_info),
        .s_feid_instr_o(s_feid_instr),
        .s_feid_pred_o(s_feid_pred)
    );
    pipeline_2_id m_pipe_2_id
    (
        .s_clk_i(s_clk_i),
        .s_resetn_i(s_resetn_i),

        .s_stall_i(s_stall),
        .s_flush_i(s_flush),
        .s_stall_o(s_stall_id),
        .s_mhrdctrl0_i(s_mhrdctrl0),
        .s_feid_info_i(s_feid_info),
        .s_feid_instr_i(s_feid_instr),
        .s_feid_pred_i(s_feid_pred),

        .s_idop_payload_o(s_idop_payload),
        .s_idop_f_o(s_idop_f),
        .s_idop_rd_o(s_idop_rd),
        .s_idop_rs1_o(s_idop_rs1),
        .s_idop_rs2_o(s_idop_rs2),
        .s_idop_sctrl_o(s_idop_sctrl),
        .s_idop_ictrl_o(s_idop_ictrl),
        .s_idop_imiscon_o(s_idop_imiscon),
        .s_idop_fixed_o(s_idop_fixed)
    );
    pipeline_3_op m_pipe_3_op
    (
        .s_clk_i(s_clk_i),
        .s_resetn_i(s_resetn_i),

        .s_stall_i(s_stall),
        .s_flush_i(s_flush),
        .s_stall_o(s_stall_op),

        .s_mawb_rd_i(s_mawb_rd),
        .s_mawb_val_i(s_mawb_val),
        .s_mawb_ictrl_i(s_mawb_ictrl),
        .s_exma_rd_i(s_exma_rd),
        .s_exma_val_i(s_exma_val),
        .s_exma_ictrl_i(s_exma_ictrl),

        .s_idop_p1_i(s_idop_p1),
        .s_idop_p2_i(s_idop_p2),
        .s_idop_payload_i(s_idop_payload),
        .s_idop_f_i(s_idop_f),
        .s_idop_rs1_i(s_idop_rs1),
        .s_idop_rs2_i(s_idop_rs2),
        .s_idop_rd_i(s_idop_rd),
        .s_idop_ictrl_i(s_idop_ictrl),
        .s_idop_sctrl_i(s_idop_sctrl),
        .s_idop_imiscon_i(s_idop_imiscon),
        .s_idop_fixed_i(s_idop_fixed),

        .s_opex_op1_o(s_opex_op1),
        .s_opex_op2_o(s_opex_op2),
        .s_opex_f_o(s_opex_f),
        .s_opex_ictrl_o(s_opex_ictrl),
        .s_opex_imiscon_o(s_opex_imiscon),
        .s_opex_rd_o(s_opex_rd),
        .s_opex_fwd_o(s_opex_fwd),
        .s_opex_payload_o(s_opex_payload)
    );
    pipeline_4_ex #(.PMA_REGIONS(PMA_REGIONS),.PMA_CFG(PMA_CFG)) m_pipe_4_ex
    (
        .s_clk_i(s_clk_i),
        .s_resetn_i(s_resetn_i),

        .s_d_hready_i(s_d_hready_i),
        .s_stall_i(s_stall),
        .s_flush_i(s_flush),
        .s_hold_i(s_hold),
        .s_stall_o(s_stall_ex),

        .s_mawb_val_i(s_mawb_val),

        .s_opex_op1_i(s_opex_op1),
        .s_opex_op2_i(s_opex_op2),
        .s_opex_payload_i(s_opex_payload),
        .s_opex_f_i(s_opex_f),
        .s_opex_rd_i(s_opex_rd),
        .s_opex_ictrl_i(s_opex_ictrl),
        .s_opex_imiscon_i(s_opex_imiscon),
        .s_opex_fwd_i(s_opex_fwd),
        .s_pc_i(s_pc),

        .s_lsu_approve_o(s_lsu_approve),
        .s_lsu_idempotent_o(s_lsu_idempotent),
        .s_lsu_wdata_o(s_lsu_wdata),

        .s_exma_f_o(s_exma_f),
        .s_exma_ictrl_o(s_exma_ictrl),
        .s_exma_imiscon_o(s_exma_imiscon),
        .s_exma_rd_o(s_exma_rd),
        .s_exma_val_o(s_exma_val),
        .s_exma_payload_o(s_exma_payload),
        .s_exma_offset_o(s_exma_offset)
    );

    lsu m_lsu
    (
        .s_clk_i(s_clk_i),
        .s_resetn_i(s_resetn_i),
        .s_flush_i(s_flush),     

        .s_hrdcheck_i(s_d_hrchecksum_i),
        .s_hrdata_i(s_d_hrdata_i),
        .s_hready_i(s_d_hready_i),
        .s_hresp_i(s_d_hresp_i),

        .s_haddr_o(s_d_haddr_o),
        .s_hwdata_o(s_d_hwdata_o),
        .s_hwdcheck_o(s_d_hwchecksum_o),
        .s_hsize_o(s_d_hsize_o),
        .s_htrans_o(s_d_htrans_o),
        .s_hwrite_o(s_d_hwrite_o),
        .s_hparity_o(s_d_hparity_o),

        .s_opex_f_i(s_opex_f),
        .s_ap_approve_i(s_lsu_approve),
        .s_idempotent_i(s_lsu_idempotent),
        .s_ap_address_i(s_opex_op1),
        .s_wdata_i(s_lsu_wdata),
        .s_ap_busy_o(s_lsu_busy),

        .s_exma_f_i(s_exma_f),
        .s_dp_address_i(s_exma_val),
        .s_dp_ready_o(s_lsu_dp_ready),
        .s_dp_hresp_o(s_lsu_dp_hresp),
        .s_dp_save_o(s_lsu_dp_save),
        .s_dp_data_o(s_lsu_dp_data),

        .s_read_data_i(s_read_data),
        .s_fixed_data_o(s_lsu_fixed_data),
        .s_einfo_o(s_lsu_einfo)
    );

    pipeline_5_ma m_pipe_5_ma
    (
        .s_clk_i(s_clk_i),
        .s_resetn_i(s_resetn_i),
        .s_boot_add_i(s_boot_add_i),

        .s_int_meip_i(s_int_meip_i),
        .s_int_mtip_i(s_int_mtip_i),
        .s_int_fcer_i(s_int_fcer),

        .s_lsu_ready_i(s_lsu_dp_ready),
        .s_lsu_hresp_i(s_lsu_dp_hresp),
        .s_lsu_data_i(s_lsu_dp_data),
        .s_lsu_save_i(s_lsu_dp_save),
        .s_lsu_einfo_i(s_lsu_einfo),
        .s_lsu_fixed_data_i(s_lsu_fixed_data),
        .s_lsu_busy_i(s_lsu_busy),

        .s_stall_o(s_stall_ma),
        .s_flush_o(s_flush),
        .s_hold_o(s_hold),

        .s_exma_f_i(s_exma_f),
        .s_exma_ictrl_i(s_exma_ictrl),
        .s_exma_imiscon_i(s_exma_imiscon),
        .s_exma_rd_i(s_exma_rd),
        .s_exma_val_i(s_exma_val),
        .s_exma_payload_i(s_exma_payload),
        .s_bop_tadd_i(s_bop_tadd),
        .s_bop_pred_i(s_bop_pred),
        .s_bop_pop_o(s_bop_pop),

        .s_ma_pred_clean_o(s_pred_clean),
        .s_ma_pred_btbu_o(s_pred_btbu),
        .s_ma_pred_btrue_o(s_pred_btrue),
        .s_ma_pred_bpu_o(s_pred_bpu),
        .s_ma_pred_jpu_o(s_pred_jpu),
        .s_ma_toc_addr_o(s_toc_addr),
        .s_mawb_ictrl_o(s_mawb_ictrl),
        .s_mawb_rd_o(s_mawb_rd),
        .s_mawb_val_o(s_mawb_val),
        .s_rf_val_o(s_rf_val),
        .s_read_data_o(s_read_data),

        .s_pc_o(s_pc),
        .s_mhrdctrl0_o(s_mhrdctrl0)
    );

    rf_controller m_rfc
    (
        .s_clk_i(s_clk_i),
        .s_resetn_i(s_resetn_i),

        .s_mawb_val_i(s_rf_val),
        .s_mawb_add_i(s_mawb_rd),
        .s_mawb_ictrl_i(s_mawb_ictrl),

        .s_r_p1_add_i(s_idop_rs1),
        .s_r_p2_add_i(s_idop_rs2),

        .s_mhrdctrl0_i(s_mhrdctrl0),

        .s_p1_val_o(s_idop_p1),
        .s_p2_val_o(s_idop_p2)
    );

`ifdef PROT_INTF
    assign s_int_fcer   = (s_idop_fixed[0] & ((s_opex_ictrl[0] == 7'b0) & (s_exma_ictrl[0] == 7'b0))) 
`ifdef PROT_PIPE
                         | s_idop_fixed[1] & ((s_opex_ictrl[1] == 7'b0) & (s_exma_ictrl[1] == 7'b0))
`endif                         
                         ;
`else
    assign s_int_fcer   = 1'b0;
`endif

endmodule
