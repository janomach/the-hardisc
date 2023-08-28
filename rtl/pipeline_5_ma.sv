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

module pipeline_5_ma (
    input logic s_clk_i[CTRL_REPS],                 //clock signal
    input logic s_resetn_i[CTRL_REPS],              //reset signal
    input logic[31:0] s_boot_add_i,                 //boot address

    input logic s_int_meip_i,                       //external interrupt
    input logic s_int_mtip_i,                       //timer interrupt
`ifdef PROTECTED
    input logic s_int_uce_i,                        //uncorrectable error in register-file
    output logic[1:0] s_acm_settings_o,             //acm settings
    input logic s_exma_neq_i[EXMA_REPS],            //discrepancy in result
`endif

    output logic s_stall_o[CTRL_REPS],              //stall signal from lower stages
    output logic s_flush_o[CTRL_REPS],              //flush signal from lower stages

    input logic[31:0] s_hrdata_i,                   //AHB bus - incomming read data
    input logic s_hready_i,                         //AHB bus - finish of transfer
    input logic s_hresp_i,                          //AHB bus - error response

    input ictrl s_exma_ictrl_i[EXMA_REPS],          //instruction control indicator
    input f_part s_exma_f_i[EXMA_REPS],             //instruction function
    input rf_add s_exma_rd_i[EXMA_REPS],            //destination register address
    input logic[31:0] s_exma_val_i[EXMA_REPS],      //result from EX stage
    input logic[31:0] s_exma_payload_i[EXMA_REPS],  //instruction payload information    

    input logic[30:0] s_bop_tadd_i,                 //predicted target address saved in the BOP
    input logic s_bop_pred_i,                       //the prediction is prepared in the BOP
    output logic s_bop_pop_o,                       //pop of the oldest entry in the BOP
    output logic s_ma_pred_clean_o,                 //clean selected prediction information
    output logic s_ma_pred_btbu_o,                  //update BTB of branch predictor
    output logic s_ma_pred_btrue_o,                 //executed branch has fulfilled condition
    output logic s_ma_pred_bpu_o,                   //update branch predictor
    output logic s_ma_pred_jpu_o,                   //update jump predictor

    output logic[31:0] s_ma_toc_addr_o[MAWB_REPS],  //address for transfer of control
    output ictrl s_mawb_ictrl_o[MAWB_REPS],         //instruction control indicator for WB stage
    output rf_add s_mawb_rd_o[MAWB_REPS],           //destination register address for WB stage
    output logic[31:0] s_mawb_val_o[MAWB_REPS],     //instruction result for WB stage
    
    output logic[31:0] s_rst_point_o[MAWB_REPS],    //reset-point address
    output logic s_pred_disable_o,                  //disable any predictions
    output logic s_hrdmax_rst_o                     //max consecutive pipeline restarts reached
);

    logic s_flush_ma[CTRL_REPS], s_stall_ma[CTRL_REPS], s_lsu_stall[MAWB_REPS];
    logic[31:0] s_write_val[MAWB_REPS], s_lsurdata[MAWB_REPS], s_int_trap[MAWB_REPS], s_exc_trap[MAWB_REPS], s_mepc[MAWB_REPS], 
                s_ma_toc_addr[MAWB_REPS], s_csr_val[MAWB_REPS], s_bru_add[MAWB_REPS], s_rst_point[MAWB_REPS], 
                s_newrst_point[MAWB_REPS], s_next_pc[MAWB_REPS];
    logic[2:0] s_pc_incr[MAWB_REPS];
    logic s_int_pending[MAWB_REPS], s_exception[MAWB_REPS], s_valid_instr[MAWB_REPS], s_tereturn[MAWB_REPS], s_ma_toc[MAWB_REPS];
    logic s_bru_toc[MAWB_REPS], s_rstpp[MAWB_REPS], s_prior_rstpp[MAWB_REPS], s_pred_bpu[MAWB_REPS], s_pred_jpu[MAWB_REPS], 
            s_ma_pred_btbu[MAWB_REPS], s_ma_pred_btrue[MAWB_REPS];
    logic s_interrupt[MAWB_REPS],s_interrupted[MAWB_REPS], s_itaken[MAWB_REPS], s_transfer_misaligned[MAWB_REPS];
    exception s_exceptions[MAWB_REPS];
    logic[4:0] s_exc_code[MAWB_REPS];
    logic s_wmawb_hresp[MAWB_REPS], s_rmawb_hresp[MAWB_REPS], s_mawb_hresp[MAWB_REPS];
    rf_add s_wmawb_rd[MAWB_REPS], s_rmawb_rd[MAWB_REPS], s_mawb_rd[MAWB_REPS]; 
    logic[31:0] s_wmawb_val[MAWB_REPS],s_rmawb_val[MAWB_REPS],s_mawb_val[MAWB_REPS], s_wb_val[MAWB_REPS];  
    ictrl s_wmawb_ictrl[MAWB_REPS], s_rmawb_ictrl[MAWB_REPS], s_mawb_ictrl[MAWB_REPS];
    logic s_clk_prw[MAWB_REPS], s_resetn_prw[MAWB_REPS];
    logic[2:0] s_wmawb_linfo[MAWB_REPS], s_rmawb_linfo[MAWB_REPS];
    logic[1:0] s_wmawb_alig[MAWB_REPS], s_rmawb_alig[MAWB_REPS];
`ifdef PROTECTED
    logic s_ex_discrepancy[MAWB_REPS];
`endif

    assign s_mawb_rd_o      = s_mawb_rd;
    assign s_mawb_val_o     = s_mawb_val;
    assign s_mawb_ictrl_o   = s_mawb_ictrl;

    //Result value from the MA stage
    seu_regs #(.LABEL("MAWB_VAL"),.N(MAWB_REPS))m_mawb_val (.s_c_i(s_clk_prw),.s_d_i(s_wmawb_val),.s_d_o(s_rmawb_val));
    //Destination register address
    seu_regs #(.LABEL("MAWB_RD"),.W($size(rf_add)),.N(MAWB_REPS)) m_mawb_rd (.s_c_i(s_clk_prw),.s_d_i(s_wmawb_rd),.s_d_o(s_rmawb_rd));
    //Instruction control indicator
    seu_regs #(.LABEL("MAWB_ICTRL"),.W($size(ictrl)),.N(MAWB_REPS)) m_mawb_ictrl (.s_c_i(s_clk_prw),.s_d_i(s_wmawb_ictrl),.s_d_o(s_rmawb_ictrl));
    //Bus-transfer error
    seu_regs #(.LABEL("MAWB_HRESP"),.W(1),.N(MAWB_REPS)) m_exma_hresp (.s_c_i(s_clk_prw),.s_d_i(s_wmawb_hresp),.s_d_o(s_rmawb_hresp));
    //Bus-transfer instruction information
    seu_regs #(.LABEL("MAWB_LINFO"),.W(3),.N(MAWB_REPS)) m_exma_linfo (.s_c_i(s_clk_prw),.s_d_i(s_wmawb_linfo),.s_d_o(s_rmawb_linfo));
    //Bus-transfer address alignment
    seu_regs #(.LABEL("MAWB_ALIG"),.W(2),.N(MAWB_REPS)) m_exma_alig (.s_c_i(s_clk_prw),.s_d_i(s_wmawb_alig),.s_d_o(s_rmawb_alig));

`ifdef PROTECTED
    //Triple-Modular-Redundancy
    tmr_comb #(.W(32)) m_tmr_mawb_val (.s_d_i(s_wb_val),.s_d_o(s_mawb_val));
    tmr_comb #(.W(1)) m_tmr_mawb_hresp (.s_d_i(s_rmawb_hresp),.s_d_o(s_mawb_hresp));
    tmr_comb #(.W($size(rf_add))) m_tmr_mawb_rd (.s_d_i(s_rmawb_rd),.s_d_o(s_mawb_rd));
    tmr_comb #(.W($size(ictrl))) m_tmr_mawb_ictrl (.s_d_i(s_rmawb_ictrl),.s_d_o(s_mawb_ictrl));
`else
    assign s_mawb_val       = s_wb_val;
    assign s_mawb_hresp     = s_rmawb_hresp;
    assign s_mawb_rd        = s_rmawb_rd;
    assign s_mawb_ictrl     = s_rmawb_ictrl;
`endif

    //Reset-point output for lower stages
    assign s_rst_point_o        = s_rst_point;
    //Signals for the Predictor and Transfer of Control
    assign s_ma_toc_addr_o      = s_ma_toc_addr;
    assign s_bop_pop_o          = s_exma_ictrl_i[0][ICTRL_UNIT_BRU] & s_exma_payload_i[0][20];
    assign s_ma_pred_clean_o    = s_exma_ictrl_i[0][6:0] == ICTRL_PRR_VAL;
    assign s_ma_pred_btbu_o     = s_ma_pred_btbu[0];
    assign s_ma_pred_btrue_o    = s_ma_pred_btrue[0];
    assign s_ma_pred_bpu_o      = s_pred_bpu[0] & ~s_exception[0] & ~s_rstpp[0];
    assign s_ma_pred_jpu_o      = s_pred_jpu[0] & ~s_exception[0] & ~s_rstpp[0];

    genvar i;
    generate
        for ( i = 0; i<MAWB_REPS ; i++ ) begin : ma_replicator
            assign s_clk_prw[i]     = s_clk_i[i];
            assign s_resetn_prw[i]  = s_resetn_i[i];
            //Gathering exception information     
            assign s_transfer_misaligned[i]         = ((|s_exma_payload_i[i][1:0] & s_exma_f_i[i][1]) | (s_exma_payload_i[i][0] & s_exma_f_i[i][0]));
            assign s_exceptions[i][EXC_LSADD_MISS]  = s_exma_ictrl_i[i][ICTRL_UNIT_LSU] & s_transfer_misaligned[i];
            assign s_exceptions[i][EXC_ECB_M]       = s_exma_ictrl_i[i][ICTRL_UNIT_CSR] & s_exma_f_i[i][3];
            assign s_exceptions[i][EXC_IACCESS]     = s_exma_ictrl_i[i][ICTRL_ILLEGAL]  & s_exma_f_i[i] == 4'b0;
            assign s_exceptions[i][EXC_LSACCESS]    = s_exma_ictrl_i[i][ICTRL_UNIT_LSU] & s_mawb_hresp[i];
            assign s_exceptions[i][EXC_ILLEGALI]    = s_exma_ictrl_i[i][ICTRL_ILLEGAL];
            assign s_exceptions[i][EXC_RF_UCE]      = s_exma_ictrl_i[i] == ICTRL_UCE_VAL;
            assign s_exception[i]                   = (|s_exceptions[i]);

            //Prioritization of exceptions and assignment of exception codes
            assign s_exc_code[i]    = (s_exceptions[i][EXC_IACCESS]) ? EXC_ILLEGALI_VAL :
                                      (s_exceptions[i][EXC_ILLEGALI]) ? EXC_ILLEGALI_VAL :
                                      (s_exceptions[i][EXC_RF_UCE]) ? EXC_RF_UCE_VAL :
                                      (s_exceptions[i][EXC_ECB_M]) ? (s_exma_payload_i[i][10] ? EXC_EBREAK_M_VAL : EXC_ECALL_M_VAL) :
                                      (s_exceptions[i][EXC_LSADD_MISS]) ? (s_exma_f_i[i][3] ? EXC_SADD_MISS_VAL : EXC_LADD_MISS_VAL) :
                                     /*s_exceptions[i][EXC_LSACCESS]->*/ (s_exma_f_i[i][3] ? EXC_SACCESS_VAL : EXC_LACCESS_VAL); 

`ifdef PROTECTED
            //Only two executors are present in the EX stage, if they were used, they results must be compared
            assign s_ex_discrepancy[i] =  s_exma_neq_i[i] & (
                                          s_exma_ictrl_i[i][ICTRL_UNIT_BRU] | 
                                          s_exma_ictrl_i[i][ICTRL_UNIT_ALU] | 
                                          s_exma_ictrl_i[i][ICTRL_UNIT_MDU]);
`endif
            //Reset pipeline condition prior to MA stage
            assign s_prior_rstpp[i] = (s_exma_ictrl_i[i][6:0] == ICTRL_PRR_VAL) | (s_exma_ictrl_i[i][7:0] == ICTRL_RST_VAL);
            //Gathering pipeline reset informations
            assign s_rstpp[i]       = ~s_resetn_i[i] | s_prior_rstpp[i] 
`ifdef PROTECTED
                                    | s_ex_discrepancy[i]
`endif
                                    ;
            assign s_valid_instr[i] = (s_exma_ictrl_i[i] != 8'b0) & ~s_rstpp[i];

            //Branch/Jump unit
            bru m_bru
            (
                .s_active_i(s_exma_ictrl_i[i][ICTRL_UNIT_BRU]),
                .s_exma_f_i(s_exma_f_i[i]),
                .s_predicted_i(s_exma_payload_i[i][20]),
                .s_exma_val_i(s_exma_val_i[i]),
                .s_bop_tadd_i(s_bop_tadd_i),
                .s_bop_pred_i(s_bop_pred_i),

                .s_toc_o(s_bru_toc[i]),
                .s_branch_true_o(s_ma_pred_btrue[i]),
                .s_bp_update_o(s_pred_bpu[i]),
                .s_btb_update_o(s_ma_pred_btbu[i]),
                .s_jp_update_o(s_pred_jpu[i]),
                .s_itaken_o(s_itaken[i]),
                .s_target_add_o(s_bru_add[i])
            );

            //An address of the following instruction in the memory
            assign s_pc_incr[i]         = s_exma_ictrl_i[i][ICTRL_RVC] ? 3'd2 : 3'd4;
            fast_adder m_next_pc(.s_base_val_i(s_rst_point[i]),.s_add_val_i({13'd0,s_pc_incr[i]}),.s_val_o(s_next_pc[i])); 

            //Selection of the new reset point
            assign s_newrst_point[i]    = (s_interrupt[i]) ? s_int_trap[i] : 
                                          (s_exception[i]) ? s_exc_trap[i] : 
                                          (s_tereturn[i]) ? s_mepc[i] : 
                                          (s_itaken[i]) ? s_bru_add[i] : s_next_pc[i];

            //Transfer of control
            assign s_ma_toc_addr[i]     = (s_rstpp[i]) ? s_rst_point[i] : s_newrst_point[i];
            assign s_ma_toc[i]          = (s_interrupt[i] | s_bru_toc[i] | s_exception[i] | s_tereturn[i] | s_rstpp[i]);

            //Interrupts - delay until LSU operation is finished
            assign s_interrupted[i] = s_interrupt[i] & ~s_rstpp[i];
            assign s_interrupt[i]   = s_int_pending[i] & ~s_exma_ictrl_i[i][ICTRL_UNIT_LSU];

            //Stall if a data-bus transfer is extended
            assign s_lsu_stall[i]   = (~s_hready_i & s_exma_ictrl_i[i][ICTRL_UNIT_LSU]);
            assign s_stall_ma[i]    = s_lsu_stall[i];
            //Invalidate MA instruction if reset, interrupt, or exception is detected
            assign s_flush_ma[i]    = s_rstpp[i] | s_interrupt[i] | s_exception[i];

            //Stall lower stages on extended data-bus transfer
            assign s_stall_o[i]     = s_lsu_stall[i];
            //Flush lower stages on each TOC
            assign s_flush_o[i]     = s_ma_toc[i];

            //Select result of the MA stage. NOTE: the REG_DEST bit in the instruction control must be active for register file write
            assign s_write_val[i]  = (s_exma_ictrl_i[i][ICTRL_UNIT_LSU]) ? s_hrdata_i : 
                                     (s_exma_ictrl_i[i][ICTRL_UNIT_BRU]) ? s_next_pc[i] :
                                     (s_exma_ictrl_i[i][ICTRL_UNIT_CSR]) ? s_csr_val[i] : s_exma_val_i[i];

            always_comb begin : pipe_5_writer
                if(s_flush_ma[i] | s_stall_ma[i])begin
                    s_wmawb_ictrl[i]= 8'b0;
                    s_wmawb_rd[i]   = 5'b0;
                    s_wmawb_val[i]  = 32'b0;
                    s_wmawb_linfo[i]= 3'b0;
                    s_wmawb_alig[i] = 2'b0;
                end else begin
                    s_wmawb_ictrl[i]= s_exma_ictrl_i[i];
                    s_wmawb_rd[i]   = s_exma_rd_i[i];
                    s_wmawb_val[i]  = s_write_val[i];
                    s_wmawb_linfo[i]= s_exma_f_i[i][2:0];
                    s_wmawb_alig[i] = s_exma_payload_i[i][1:0];
                end
            end

            //Save bus-error responses
            always_comb begin : pipe_5_writer_1
                if(s_flush_ma[i])begin
                    s_wmawb_hresp[i] = 1'b0;
                end begin
                    s_wmawb_hresp[i] = s_hresp_i;
                end
            end
        end

        /*  This section is part of WB stage  */
        for ( i = 0; i<MAWB_REPS ; i++ ) begin : wb_replicator
            //Data to be written into the register file
            assign s_wb_val[i]      = (s_rmawb_ictrl[i][ICTRL_UNIT_LSU]) ? s_lsurdata[i] : s_rmawb_val[i];

            //Decoding loaded data
            lsu_decoder m_lsu_decoder
            (
                .s_alignment_i(s_rmawb_alig[i]),
                .s_lsu_data_i(s_rmawb_val[i]),
                .s_unsigned_i(s_rmawb_linfo[i][2]),
                .s_lword_i(s_rmawb_linfo[i][1]),
                .s_lhalf_i(s_rmawb_linfo[i][0]),
                .s_data_o(s_lsurdata[i])
            );
        end
        /*  End of WB stage  */ 
            
    endgenerate   

    csru m_csru
    (
        .s_clk_i(s_clk_i),
        .s_resetn_i(s_resetn_i),
        .s_boot_add_i(s_boot_add_i),
        .s_stall_i(s_stall_ma),
        .s_flush_i(s_flush_ma),
        .s_int_meip_i(s_int_meip_i),
        .s_int_mtip_i(s_int_mtip_i),
        .s_int_msip_i(1'b0),
`ifdef PROTECTED
        .s_int_uce_i(s_int_uce_i),
        .s_acm_settings_o(s_acm_settings_o),
`endif
        .s_rstpp_i(s_rstpp),
        .s_interrupted_i(s_interrupted),
        .s_exception_i(s_exception),
        .s_exc_code_i(s_exc_code),
        .s_newrst_point_i(s_newrst_point),
        .s_ictrl_i(s_exma_ictrl_i),
        .s_function_i(s_exma_f_i),
        .s_payload_i(s_exma_payload_i),
        .s_val_i(s_exma_val_i),
        .s_valid_instr_i(s_valid_instr),
        .s_exc_trap_o(s_exc_trap), 
        .s_int_trap_o(s_int_trap), 
        .s_rst_point_o(s_rst_point),
        .s_csr_r_o(s_csr_val),
        .s_mepc_o(s_mepc),
        .s_treturn_o(s_tereturn),
        .s_int_pending_o(s_int_pending),
        .s_pred_disable_o(s_pred_disable_o),
        .s_hrdmax_rst_o(s_hrdmax_rst_o)
    );

endmodule
