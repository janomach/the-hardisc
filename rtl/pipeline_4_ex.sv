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

module pipeline_4_ex #(
    parameter PMA_REGIONS = 1,
    parameter pma_cfg_t PMA_CFG[PMA_REGIONS-1:0] = '{default:PMA_DEFAULT}
) (
    input logic s_clk_i[PROT_3REP],                 //clock signal
    input logic s_resetn_i[PROT_3REP],              //reset signal

    input logic s_d_hready_i[PROT_3REP],            //stall from the data bus
    input logic[4:0] s_stall_i[PROT_3REP],          //stall signal from MA stage
    input logic s_flush_i[PROT_3REP],               //flush signal from MA stage
    input logic s_hold_i[PROT_3REP],                //hold signal from MA stage
    output logic s_stall_o[PROT_3REP],              //signalize stalling to the lower stages

    input logic[31:0] s_mawb_val_i[PROT_3REP],      //WB-stage instruction result
    input logic[31:0] s_rstpoint_i[PROT_3REP],      //Reset-point value

    input logic[31:0] s_opex_op1_i[PROT_2REP],      //computation operand 1
    input logic[31:0] s_opex_op2_i[PROT_2REP],      //computation operand 2
    input logic[20:0] s_opex_payload_i[PROT_2REP],  //instruction payload information
    input ictrl s_opex_ictrl_i[PROT_2REP],          //instruction control indicator
    input imiscon s_opex_imiscon_i[PROT_2REP],      //instruction misconduct indicator
    input rf_add s_opex_rd_i[PROT_2REP],            //destination register address
    input f_part s_opex_f_i[PROT_2REP],             //instruction function
    input logic[3:0]s_opex_fwd_i[PROT_2REP],        //forwarding information

    output logic[31:0] s_lsu_wdata_o[PROT_3REP],    //LSU write data
    output logic s_lsu_idempotent_o[PROT_3REP],     //LSU idempotent access
    output logic s_lsu_approve_o[PROT_3REP],        //LSU address phase approval

`ifdef PROTECTED
    output logic s_exma_neq_o[PROT_3REP],           //discrepancy in results          
`endif
    output ictrl s_exma_ictrl_o[PROT_3REP],         //instruction control indicator for MA stage
    output imiscon s_exma_imiscon_o[PROT_3REP],     //instruction misconduct indicator for MA stage
    output f_part s_exma_f_o[PROT_3REP],            //instruction function for MA stage
    output rf_add s_exma_rd_o[PROT_3REP],           //destination register address for MA stage
    output logic[31:0] s_exma_val_o[PROT_3REP],     //result from EX stage for MA stage
    output logic[11:0] s_exma_payload_o[PROT_3REP], //payload information for MA stage
    output logic[19:0] s_exma_offset_o              //offset for predictor
);
    logic[19:0] s_wexma_offset[1], s_rexma_offset[1];
    logic[11:0] s_wexma_payload[PROT_3REP], s_exma_payload[PROT_3REP], s_rexma_payload[PROT_3REP]; 
    logic[31:0] s_wexma_val[PROT_3REP], s_rexma_val[PROT_3REP], s_exma_val[PROT_3REP], s_result[PROT_2REP], 
                s_operand1[PROT_3REP],s_operand2[PROT_3REP]; 
    logic[1:0] s_pc_incr[PROT_2REP];
    logic s_ma_taken[PROT_2REP], s_ma_jump[PROT_2REP];
    rf_add s_wexma_rd[PROT_3REP], s_rexma_rd[PROT_3REP], s_exma_rd[PROT_3REP];
    f_part s_wexma_f[PROT_3REP], s_rexma_f[PROT_3REP], s_exma_f[PROT_3REP];
    ictrl s_wexma_ictrl[PROT_3REP], s_rexma_ictrl[PROT_3REP], s_exma_ictrl[PROT_3REP];
    imiscon s_wexma_imiscon[PROT_3REP], s_rexma_imiscon[PROT_3REP], s_exma_imiscon[PROT_3REP];
    logic s_wexma_tstrd[PROT_3REP], s_rexma_tstrd[PROT_3REP], s_exma_tstrd[PROT_3REP];
    logic s_stall_ex[PROT_3REP], s_flush_ex[PROT_3REP], s_prevent_ex[PROT_3REP], s_lsu[PROT_3REP], s_lsu_misa[PROT_3REP], 
          s_ex_fin[PROT_2REP], s_bubble[PROT_3REP], s_pma_violation[PROT_3REP], s_ex_empty[PROT_3REP];
    logic s_exma_we_aux[PROT_3REP], s_exma_we_esn[PROT_3REP];
`ifdef PROTECTED
    logic s_opex_esn_neq[PROT_2REP], s_opex_aux_neq[PROT_2REP], s_rstpipe[PROT_3REP];
`endif

    assign s_exma_rd_o      = s_exma_rd;
    assign s_exma_f_o       = s_exma_f;
    assign s_exma_val_o     = s_exma_val;
    assign s_exma_payload_o = s_exma_payload;
    assign s_exma_ictrl_o   = s_exma_ictrl;
    assign s_exma_imiscon_o = s_exma_imiscon;
    assign s_exma_offset_o  = s_rexma_offset[0];

    //Branch/Jump offset for the Predictor - replication is not required
    seu_ff_we #(.LABEL("EXMA_OFFST"),.W(20),.N(1))m_exma_offset (.s_c_i({s_clk_i[0]}),.s_we_i({s_exma_we_aux[0]}),.s_d_i(s_wexma_offset),.s_q_o(s_rexma_offset));
    //Bus-Transfer address or payload for the MA stage
    seu_ff_we #(.LABEL("EXMA_PYLD"),.W(12),.N(PROT_3REP))m_exma_payload (.s_c_i(s_clk_i),.s_we_i(s_exma_we_aux),.s_d_i(s_wexma_payload),.s_q_o(s_rexma_payload));
    //Destination register address
    seu_ff_we #(.LABEL("EXMA_RD"),.W($size(rf_add)),.N(PROT_3REP)) m_exma_rd (.s_c_i(s_clk_i),.s_we_i(s_exma_we_aux),.s_d_i(s_wexma_rd),.s_q_o(s_rexma_rd));
    //Instruction function information
    seu_ff_we #(.LABEL("EXMA_F"),.W($size(f_part)),.N(PROT_3REP)) m_exma_f (.s_c_i(s_clk_i),.s_we_i(s_exma_we_aux),.s_d_i(s_wexma_f),.s_q_o(s_rexma_f));
    //Instruction control indicator
    seu_ff_we_rst #(.LABEL("EXMA_ICTRL"),.W($size(ictrl)),.N(PROT_3REP)) m_exma_ictrl (.s_c_i(s_clk_i),.s_we_i(s_exma_we_esn),.s_r_i(s_resetn_i),.s_d_i(s_wexma_ictrl),.s_q_o(s_rexma_ictrl));
    //Instruction misconduct indicator
    seu_ff_we_rst #(.LABEL("EXMA_IMISCON"),.W($size(imiscon)),.N(PROT_3REP)) m_exma_imiscon (.s_c_i(s_clk_i),.s_we_i(s_exma_we_esn),.s_r_i(s_resetn_i),.s_d_i(s_wexma_imiscon),.s_q_o(s_rexma_imiscon));
    //Result value from the EX stage
    seu_ff_we #(.LABEL("EXMA_VAL"),.N(PROT_3REP))m_exma_val (.s_c_i(s_clk_i),.s_we_i(s_exma_we_aux),.s_d_i(s_wexma_val),.s_q_o(s_rexma_val));
    //Transfer started
    seu_ff_rst #(.LABEL("EXMA_TSTRD"),.N(PROT_3REP),.W(1))m_exma_tstrd (.s_c_i(s_clk_i),.s_r_i(s_resetn_i),.s_d_i(s_wexma_tstrd),.s_q_o(s_rexma_tstrd));    

`ifdef PROTECTED
    //Triple-Modular-Redundancy
    tmr_comb #(.W(12)) m_tmr_exma_payload (.s_d_i(s_rexma_payload),.s_d_o(s_exma_payload));
    tmr_comb #(.W(32)) m_tmr_exma_val (.s_d_i(s_rexma_val),.s_d_o(s_exma_val));
    tmr_comb #(.W($size(rf_add))) m_tmr_exma_rd (.s_d_i(s_rexma_rd),.s_d_o(s_exma_rd));
    tmr_comb #(.W($size(f_part))) m_tmr_exma_f (.s_d_i(s_rexma_f),.s_d_o(s_exma_f));
    tmr_comb #(.W($size(ictrl))) m_tmr_exma_ictrl (.s_d_i(s_rexma_ictrl),.s_d_o(s_exma_ictrl));
    tmr_comb #(.W($size(imiscon))) m_tmr_exma_imiscon (.s_d_i(s_rexma_imiscon),.s_d_o(s_exma_imiscon));
    tmr_comb #(.W(1)) m_tmr_exma_tstrd (.s_d_i(s_rexma_tstrd),.s_d_o(s_exma_tstrd));
`else
    assign s_exma_payload   = s_rexma_payload;
    assign s_exma_val       = s_rexma_val;
    assign s_exma_rd        = s_rexma_rd;
    assign s_exma_f         = s_rexma_f;
    assign s_exma_ictrl     = s_rexma_ictrl;
    assign s_exma_imiscon   = s_rexma_imiscon;
    assign s_exma_tstrd     = s_rexma_tstrd;
`endif

    //LSU control
    assign s_lsu_wdata_o    = s_operand2;
    //Save offset for predictor
    assign s_wexma_offset[0]= s_opex_payload_i[0][19:0];

    genvar i;
    generate
        for (i = 0; i<PROT_2REP ;i++ ) begin : ex_replicator_2
`ifdef PROTECTED
            //OPEX registers replicas comparision
            assign s_opex_aux_neq[i] = (s_opex_op1_i[0] != s_opex_op1_i[1]) | (s_opex_op2_i[0] != s_opex_op2_i[1]) | 
                                       (s_opex_rd_i[0] != s_opex_rd_i[1]) | (s_opex_payload_i[0] != s_opex_payload_i[1]) | 
                                       (s_opex_f_i[0] != s_opex_f_i[1]) | (s_opex_fwd_i[0] != s_opex_fwd_i[1]);
            assign s_opex_esn_neq[i] = (s_opex_ictrl_i[0] != s_opex_ictrl_i[1]) | (s_opex_imiscon_i[0] != s_opex_imiscon_i[1]);
`endif
            //Auxiliary signals for Executor. NOTE: they do not need TMR outputs
            assign s_ma_jump[i]     = (s_rexma_f[i] == ALU_SET1) || (s_rexma_f[i] == ALU_IPC);
            assign s_ma_taken[i]    = s_rexma_ictrl[i][ICTRL_UNIT_BRU] & ((~s_ma_jump[i] & s_rexma_val[i][0]) | s_ma_jump[i]);
            assign s_pc_incr[i]     = (s_rexma_ictrl[i] != 8'b0) ? (s_rexma_ictrl[i][ICTRL_RVC] ? 2'b01 : 2'b10) : 2'b00;

            executor m_executor
            (
                .s_clk_i(s_clk_i[i]),
                .s_resetn_i(s_resetn_i[i]),
                .s_flush_i(s_flush_i[i]),
                .s_stall_i(s_stall_ex[i]),
                .s_ictrl_i(s_opex_ictrl_i[i]),
                .s_operand1_i(s_operand1[i]),
                .s_operand2_i(s_operand2[i]),
                .s_payload_i(s_opex_payload_i[i]),
                .s_pc_incr_i(s_pc_incr[i]),
                .s_rstpoint_i(s_rstpoint_i[i][31:1]),
                .s_ma_tadd_i(s_rexma_val[i][31:1]),
                .s_ma_taken_i(s_ma_taken[i]),
                .s_function_i(s_opex_f_i[i]),
                .s_finished_o(s_ex_fin[i]),
                .s_result_o(s_result[i])
            );
        end

        for (i = 0; i<PROT_3REP;i++ ) begin : ex_replicator
            assign s_stall_ex[i]= s_stall_i[i][PIPE_MA];
            //If a bubble is signalized by the Executor, stall lower stages and insert NOP to the MA stage
            assign s_stall_o[i] = s_bubble[i];
            //Ignore the bubble request, if a stall is signalized from the upper stages
            assign s_flush_ex[i]= s_flush_i[i] | (s_bubble[i] & ~s_stall_ex[i]);
            //Prevent start of execution in Execute stage
            assign s_prevent_ex[i] = s_hold_i[i] & ~s_exma_tstrd[i];
            assign s_ex_empty[i]   = (s_opex_imiscon_i[i%2] == IMISCON_FREE) & (s_opex_ictrl_i[i%2] == 7'b0);
            //Write-enable signals for auxiliary EXMA registers
            assign s_exma_we_aux[i]= !(s_flush_ex[i] || s_stall_ex[i] || s_ex_empty[i]);
            //Write-enable signals for essential EXMA registers
            assign s_exma_we_esn[i]= s_flush_ex[i] || !s_stall_ex[i];
            //Bubble can happen only from MDU
            assign s_bubble[i]  = (s_opex_ictrl_i[i%2][ICTRL_UNIT_MDU] & ~s_ex_fin[0] 
`ifdef PROTECTED
                                    & ~s_ex_fin[1] //Disable a bubble if at least one replica signalizes a finish
`endif
                                  ) | (!s_d_hready_i[i] & s_opex_ictrl_i[i%2][ICTRL_UNIT_LSU]);
`ifdef PROTECTED
            //Reset the instruction if discrepancy exists between the OPEX registers
            assign s_rstpipe[i]    = s_opex_esn_neq[0] | s_opex_esn_neq[1] | (!s_ex_empty[i] & (s_opex_aux_neq[0] | s_opex_aux_neq[1]));
            //Only two executors are present in the EX stage, they results must be compared
            assign s_exma_neq_o[i] = (s_rexma_val[0] != s_rexma_val[1]);
`endif                             
            //Forward data from the upper stages registers to the instruction operands in EX stage
            assign s_operand1[i]= (s_opex_fwd_i[i%2][0]) ? s_exma_val[i] : (s_opex_fwd_i[i%2][2]) ? s_mawb_val_i[i] : s_opex_op1_i[i%2];
            assign s_operand2[i]= (s_opex_fwd_i[i%2][1]) ? s_exma_val[i] : (s_opex_fwd_i[i%2][3]) ? s_mawb_val_i[i] : s_opex_op2_i[i%2];

            pma #(.PMA_REGIONS(PMA_REGIONS),.PMA_CFG(PMA_CFG)) m_pma 
            (
                .s_address_i(s_opex_op1_i[i%2]),
                .s_write_i(s_opex_f_i[i%2][3]),
                .s_idempotent_o(s_lsu_idempotent_o[i]),
                .s_violation_o(s_pma_violation[i])
            );  

            //Misalignment detection for the Load and Store instructions
            assign s_lsu_misa[i]= ((|s_opex_op1_i[i%2][1:0] & s_opex_f_i[i%2][1]) | (s_opex_op1_i[i%2][0] & s_opex_f_i[i%2][0]));
            //Data bus transfer activation
            assign s_lsu[i]     = s_opex_ictrl_i[i%2][ICTRL_UNIT_LSU] & ~s_lsu_misa[i] & ~s_prevent_ex[i] & ~s_pma_violation[i]
`ifdef PROTECTED            
                                & ~s_rstpipe[i]
`endif
                                ;
            assign s_lsu_approve_o[i]  = s_lsu[i];
            
            always_comb begin : pipe_4_writer
                s_wexma_rd[i]       = s_opex_rd_i[i%2];
                s_wexma_f[i]        = s_opex_f_i[i%2];
                s_wexma_ictrl[i]    = s_opex_ictrl_i[i%2];
                //Select EX stage result
                s_wexma_val[i]      = (s_opex_ictrl_i[i%2][ICTRL_UNIT_ALU] | 
                                       s_opex_ictrl_i[i%2][ICTRL_UNIT_BRU] | 
                                       s_opex_ictrl_i[i%2][ICTRL_UNIT_MDU]) ? s_result[i%2] : s_operand1[i];
                //Payload for the MA stage
                s_wexma_payload[i]  = {s_opex_payload_i[i%2][20],s_opex_payload_i[i%2][10:0]};
                s_wexma_imiscon[i]  = 
`ifdef PROTECTED
                                        s_rstpipe[i] ? IMISCON_DSCR :                                          
`endif
                                        (s_pma_violation[i] & s_opex_ictrl_i[i%2][ICTRL_UNIT_LSU]) ? IMISCON_PMAV : s_opex_imiscon_i[i%2];
                if(s_flush_ex[i] || s_prevent_ex[i]  
`ifdef PROTECTED
                || (s_ex_empty[i] & ~s_rstpipe[i])
`else
                || s_ex_empty[i]
`endif
                )begin
                    s_wexma_ictrl[i]    = 7'b0; 
                    s_wexma_imiscon[i]  = IMISCON_FREE;
                end
            end

            //AHB3-Lite requirement: The HTRANS cannot change from NONSEQ to IDLE during delayed transfer
            assign s_wexma_tstrd[i] = s_lsu[i] && !s_d_hready_i[i] && !s_flush_i[i];       
        end
    endgenerate  
endmodule
