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

module hardisc
(
    input logic s_clk_i[CTRL_REPS],         //clock signal
    input logic s_resetn_i[CTRL_REPS],      //reset signal

    input logic s_int_meip_i,               //external interrupt
    input logic s_int_mtip_i,               //timer interrupt
    input logic[31:0] s_boot_add_i,         //boot address
    
    input logic[31:0] s_i_hrdata_i,         //AHB instruction bus - incomming read data
    input logic s_i_hready_i,               //AHB instruction bus - finish of transfer
    input logic s_i_hresp_i,                //AHB instruction bus - error response
    output logic[31:0] s_i_haddr_o,         //AHB instruction bus - request address
    output logic[31:0] s_i_hwdata_o,        //AHB instruction bus - request data to write
    output logic[2:0]s_i_hburst_o,          //AHB instruction bus - burst type indicator
    output logic s_i_hmastlock_o,           //AHB instruction bus - locked sequence indicator
    output logic[3:0]s_i_hprot_o,           //AHB instruction bus - protection control signals
    output logic[2:0]s_i_hsize_o,           //AHB instruction bus - size of the transfer
    output logic[1:0]s_i_htrans_o,          //AHB instruction bus - transfer type indicator
    output logic s_i_hwrite_o,              //AHB instruction bus - write indicator

    input logic[6:0] s_i_hrchecksum_i,      //AHB instruction bus - incoming checksum (custom)
    output logic[6:0] s_i_hwchecksum_o,     //AHB instruction bus - outcoming checksum (custom)
    input logic[6:0] s_d_hrchecksum_i,      //AHB data bus - incoming checksum (custom)    
    output logic[6:0] s_d_hwchecksum_o,     //AHB data bus - outcoming checksum (custom)

    input logic[31:0] s_d_hrdata_i,         //AHB data bus - incomming read data
    input logic s_d_hready_i,               //AHB data bus - finish of transfer
    input logic s_d_hresp_i,                //AHB data bus - error response
    output logic[31:0] s_d_haddr_o,         //AHB data bus - request address
    output logic[31:0] s_d_hwdata_o,        //AHB data bus - request data to write
    output logic[2:0]s_d_hburst_o,          //AHB data bus - burst type indicator
    output logic s_d_hmastlock_o,           //AHB data bus - locked sequence indicator 
    output logic[3:0]s_d_hprot_o,           //AHB data bus - protection control signals
    output logic[2:0]s_d_hsize_o,           //AHB data bus - size of the transfer 
    output logic[1:0]s_d_htrans_o,          //AHB data bus - transfer type indicator
    output logic s_d_hwrite_o,              //AHB data bus - write indicator

    output logic s_hrdmax_rst_o             //max consecutive pipeline restarts reached
);

    logic[4:0] s_stall[CTRL_REPS];
    logic s_flush[CTRL_REPS], s_hold[CTRL_REPS];
    logic[3:0] s_opex_fwd[OPEX_REPS];
    logic[20:0] s_opex_payload[OPEX_REPS];
    logic[31:0]s_feid_instr[FEID_REPS];
    logic[4:0] s_feid_info[FEID_REPS];
    logic s_pred_disable, s_hrdmax_rst;
    logic[19:0] s_exma_offset;
    logic[11:0] s_exma_payload[EXMA_REPS];
    logic[31:0] s_exma_val[EXMA_REPS], s_mawb_val[MAWB_REPS], s_idop_p1, s_idop_p2, s_opex_op1[OPEX_REPS], s_opex_op2[OPEX_REPS], 
                s_toc_addr[EXMA_REPS], s_rf_val[MAWB_REPS], s_lsu_address, s_lsu_wdata[EXMA_REPS], s_read_data[MAWB_REPS], s_lsu_fixed_data[MAWB_REPS];
    logic[20:0] s_idop_payload[IDOP_REPS];
    logic[1:0] s_feid_pred[FEID_REPS];
    f_part s_idop_f[IDOP_REPS], s_opex_f[OPEX_REPS], s_exma_f[EXMA_REPS];
    rf_add s_idop_rs1[IDOP_REPS], s_idop_rs2[IDOP_REPS], s_idop_rd[IDOP_REPS], s_opex_rd[OPEX_REPS], s_exma_rd[EXMA_REPS], s_mawb_rd[MAWB_REPS];
    ictrl s_idop_ictrl[IDOP_REPS], s_exma_ictrl[EXMA_REPS], s_mawb_ictrl[MAWB_REPS], s_opex_ictrl[OPEX_REPS];
    imiscon s_idop_imiscon[IDOP_REPS], s_opex_imiscon[OPEX_REPS], s_exma_imiscon[EXMA_REPS];
    sctrl s_idop_sctrl[IDOP_REPS];
    logic s_stall_ma[CTRL_REPS],s_stall_ex[CTRL_REPS],s_stall_op[CTRL_REPS],s_stall_id[CTRL_REPS],
            s_pred_bpu, s_pred_jpu, s_pred_btrue, s_pred_btbu, s_pred_clean, s_lsu_busy[EXMA_REPS], s_lsu_approve[EXMA_REPS];
    logic[31:0] s_rst_point[EXMA_REPS], s_lsu_ap_address, s_lsu_dp_data;
    logic[30:0] s_bop_tadd;
    logic s_bop_pred, s_bop_pop, s_int_uce, s_lsu_ap_approve, s_lsu_dp_ready, s_lsu_dp_hresp[EXMA_REPS];
    logic[2:0] s_lsu_einfo[MAWB_REPS];
`ifdef PROTECTED
    logic[1:0] s_rf_uce[IDOP_REPS],s_rf_ce[IDOP_REPS], s_acm_settings;
    logic s_exma_neq[EXMA_REPS];
`endif

    assign s_hrdmax_rst_o   = s_hrdmax_rst;
    
    assign s_i_hwchecksum_o = 7'b0;

    genvar i;
    generate
        for (i = 0; i<CTRL_REPS ;i++ ) begin : integration_replicator
            assign s_stall[i] = {s_stall_ma[i],s_stall_ex[i],s_stall_op[i],s_stall_id[i],1'b0};          
        end  
    endgenerate

    pipeline_1_fe m_pipe_1_fe
    (
        .s_clk_i(s_clk_i),
        .s_resetn_i(s_resetn_i),

        .s_stall_i(s_stall), 
        .s_flush_i(s_flush),

        .s_bop_pop_i(s_bop_pop),
        .s_bop_pred_o(s_bop_pred),
        .s_bop_tadd_o(s_bop_tadd),

        .s_pred_base_i(s_rst_point[0]),
        .s_pred_offset_i(s_exma_offset),
        .s_pred_rvc_i(s_exma_ictrl[0][ICTRL_RVC]),
        .s_pred_clean_i(s_pred_clean),
        .s_pred_btbu_i(s_pred_btbu),
        .s_pred_btrue_i(s_pred_btrue),
        .s_pred_bpu_i(s_pred_bpu),
        .s_pred_jpu_i(s_pred_jpu),
        .s_pred_disable_i(s_pred_disable),
        .s_toc_add_i(s_toc_addr),

        .s_hrdcheck_i(s_i_hrchecksum_i),
        .s_hrdata_i(s_i_hrdata_i),
        .s_hready_i(s_i_hready_i),
        .s_hresp_i(s_i_hresp_i),
        .s_haddr_o(s_i_haddr_o),
        .s_hwdata_o(s_i_hwdata_o),
        .s_hburst_o(s_i_hburst_o),
        .s_hmastlock_o(s_i_hmastlock_o),
        .s_hprot_o(s_i_hprot_o),
        .s_hsize_o(s_i_hsize_o),
        .s_htrans_o(s_i_htrans_o),
        .s_hwrite_o(s_i_hwrite_o),

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
`ifdef PROTECTED
        .s_acm_settings_i(s_acm_settings),
`endif
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
        .s_idop_imiscon_o(s_idop_imiscon)
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

`ifdef PROTECTED
        .s_rf_uce_i(s_rf_uce),
        .s_rf_ce_i(s_rf_ce),
`endif
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

        .s_opex_op1_o(s_opex_op1),
        .s_opex_op2_o(s_opex_op2),
        .s_opex_f_o(s_opex_f),
        .s_opex_ictrl_o(s_opex_ictrl),
        .s_opex_imiscon_o(s_opex_imiscon),
        .s_opex_rd_o(s_opex_rd),
        .s_opex_fwd_o(s_opex_fwd),
        .s_opex_payload_o(s_opex_payload)
    );
    pipeline_4_ex m_pipe_4_ex
    (
        .s_clk_i(s_clk_i),
        .s_resetn_i(s_resetn_i),

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
        .s_rstpoint_i(s_rst_point),

        .s_lsu_approve_o(s_lsu_approve),
        .s_lsu_address_o(s_lsu_address),
        .s_lsu_wdata_o(s_lsu_wdata),

`ifdef PROTECTED
        .s_exma_neq_o(s_exma_neq),
`endif
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
        .s_hburst_o(s_d_hburst_o),
        .s_hmastlock_o(s_d_hmastlock_o),
        .s_hprot_o(s_d_hprot_o),
        .s_hsize_o(s_d_hsize_o),
        .s_htrans_o(s_d_htrans_o),
        .s_hwrite_o(s_d_hwrite_o),

        .s_opex_f_i(s_opex_f),
        .s_ap_approve_i(s_lsu_approve),
        .s_ap_address_i(s_lsu_address),
        .s_wdata_i(s_lsu_wdata),
        .s_ap_busy_o(s_lsu_busy),

        .s_exma_f_i(s_exma_f),
        .s_dp_address_i(s_exma_val),
        .s_dp_ready_o(s_lsu_dp_ready),
        .s_dp_hresp_o(s_lsu_dp_hresp),
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
        .s_int_uce_i(s_int_uce),

        .s_lsu_ready_i(s_lsu_dp_ready),
        .s_lsu_hresp_i(s_lsu_dp_hresp),
        .s_lsu_data_i(s_lsu_dp_data),
        .s_lsu_einfo_i(s_lsu_einfo),
        .s_lsu_fixed_data_i(s_lsu_fixed_data),
        .s_lsu_busy_i(s_lsu_busy),

`ifdef PROTECTED
        .s_acm_settings_o(s_acm_settings),
        .s_exma_neq_i(s_exma_neq),
`endif

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

        .s_rst_point_o(s_rst_point),
        .s_pred_disable_o(s_pred_disable),
        .s_hrdmax_rst_o(s_hrdmax_rst)
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

`ifdef PROTECTED
        .s_exma_add_i(s_exma_rd),
        .s_exma_ictrl_i(s_exma_ictrl),
        .s_opex_add_i(s_opex_rd),
        .s_opex_ictrl_i(s_opex_ictrl),
        .s_uce_o(s_rf_uce),
        .s_ce_o(s_rf_ce),
`endif
        .s_p1_val_o(s_idop_p1),
        .s_p2_val_o(s_idop_p2)
    );

`ifdef PROTECTED
    assign s_int_uce = s_rf_uce[0] != 2'b0;
`else
    assign s_int_uce = 1'b0;
`endif

endmodule
