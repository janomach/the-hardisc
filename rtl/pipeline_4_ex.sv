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

module pipeline_4_ex (
    input logic s_clk_i[CTRL_REPS],                 //clock signal
    input logic s_resetn_i[CTRL_REPS],              //reset signal

    input logic[4:0] s_stall_i[CTRL_REPS],          //stall signal from MA stage
    input logic s_flush_i[CTRL_REPS],               //flush signal from MA stage
    output logic s_stall_o[CTRL_REPS],              //signalize stalling to the lower stages

    input logic[31:0] s_mawb_val_i[MAWB_REPS],      //WB-stage instruction result
    input logic[31:0] s_rstpoint_i[MAWB_REPS],      //Reset-point value

    input logic[31:0] s_opex_op1_i[OPEX_REPS],      //computation operand 1
    input logic[31:0] s_opex_op2_i[OPEX_REPS],      //computation operand 2
    input logic[20:0] s_opex_payload_i[OPEX_REPS],  //instruction payload information
    input ictrl s_opex_ictrl_i[OPEX_REPS],          //instruction control indicator
    input rf_add s_opex_rd_i[OPEX_REPS],            //destination register address
    input f_part s_opex_f_i[OPEX_REPS],             //instruction function
    input logic[3:0]s_opex_fwd_i[OPEX_REPS],        //forwarding information

    output logic[31:0] s_haddr_o,                   //AHB bus - request address
    output logic[31:0] s_hwdata_o,                  //AHB bus - request data to write
    output logic[2:0]s_hburst_o,                    //AHB bus - burst type indicator  
    output logic s_hmastlock_o,                     //AHB bus - locked sequence indicator                     
    output logic[3:0]s_hprot_o,                     //AHB bus - protection control signals
    output logic[2:0]s_hsize_o,                     //AHB bus - size of the transfer                     
    output logic[1:0]s_htrans_o,                    //AHB bus - transfer type indicator
    output logic s_hwrite_o,                        //AHB bus - write indicator

    output ictrl s_exma_ictrl_o[EXMA_REPS],         //instruction control indicator for MA stage
    output f_part s_exma_f_o[EXMA_REPS],            //instruction function for MA stage
    output rf_add s_exma_rd_o[EXMA_REPS],           //destination register address for MA stage
    output logic[31:0] s_exma_val_o[EXMA_REPS],     //result from EX stage for MA stage
    output logic[31:0] s_exma_payload_o[EXMA_REPS]  //payload information for MA stage
);

    logic[31:0] s_wexma_val[EXMA_REPS], s_wexma_payload[EXMA_REPS],s_rexma_val[EXMA_REPS], s_rexma_payload[EXMA_REPS],
            s_exma_val[EXMA_REPS], s_exma_payload[EXMA_REPS], s_result[EX_REPS], s_operand1[EXMA_REPS],s_operand2[EXMA_REPS]; 
    logic[1:0] s_pc_incr[EX_REPS];
    logic s_ma_taken[EX_REPS], s_ma_jump[EX_REPS];
    rf_add s_wexma_rd[EXMA_REPS], s_rexma_rd[EXMA_REPS], s_exma_rd[EXMA_REPS];
    f_part s_wexma_f[EXMA_REPS], s_rexma_f[EXMA_REPS], s_exma_f[EXMA_REPS];
    ictrl s_wexma_ictrl[EXMA_REPS], s_rexma_ictrl[EXMA_REPS], s_exma_ictrl[EXMA_REPS];
    logic s_stall_ex[CTRL_REPS], s_flush_ex[CTRL_REPS],s_lsu[EXMA_REPS], s_lsu_misa[EXMA_REPS],s_lsu_trans[EXMA_REPS], 
          s_ex_fin[EX_REPS], s_bubble[EXMA_REPS];
`ifdef PROTECTED
    logic s_opex_neq[EX_REPS], s_rstpipe[EXMA_REPS];
`endif

    assign s_exma_rd_o      = s_exma_rd;
    assign s_exma_f_o       = s_exma_f;
    assign s_exma_val_o     = s_exma_val;
    assign s_exma_payload_o = s_exma_payload;
    assign s_exma_ictrl_o   = s_exma_ictrl;

    //Bus-Transfer address or payload for the MA stage
    seu_regs #(.LABEL("EXMA_PYLD"),.N(EXMA_REPS))m_exma_payload (.s_c_i(s_clk_i),.s_d_i(s_wexma_payload),.s_d_o(s_rexma_payload));
    //Destination register address
    seu_regs #(.LABEL("EXMA_RD"),.W($size(rf_add)),.N(EXMA_REPS)) m_exma_rd (.s_c_i(s_clk_i),.s_d_i(s_wexma_rd),.s_d_o(s_rexma_rd));
    //Instruction function information
    seu_regs #(.LABEL("EXMA_F"),.W($size(f_part)),.N(EXMA_REPS)) m_exma_f (.s_c_i(s_clk_i),.s_d_i(s_wexma_f),.s_d_o(s_rexma_f));
    //Instruction control indicator
    seu_regs #(.LABEL("EXMA_ICTRL"),.W($size(ictrl)),.N(EXMA_REPS)) m_exma_ictrl (.s_c_i(s_clk_i),.s_d_i(s_wexma_ictrl),.s_d_o(s_rexma_ictrl));
    //Result value from the EX stage
    seu_regs #(.LABEL("EXMA_VAL"),.N(EXMA_REPS))m_exma_val (.s_c_i(s_clk_i),.s_d_i(s_wexma_val),.s_d_o(s_rexma_val));

`ifdef PROTECTED
    //Triple-Modular-Redundancy
    tmr_comb #(.W(32)) m_tmr_exma_payload (.s_d_i(s_rexma_payload),.s_d_o(s_exma_payload));
    tmr_comb #(.W(32)) m_tmr_exma_val (.s_d_i(s_rexma_val),.s_d_o(s_exma_val));
    tmr_comb #(.W($size(rf_add))) m_tmr_exma_rd (.s_d_i(s_rexma_rd),.s_d_o(s_exma_rd));
    tmr_comb #(.W($size(f_part))) m_tmr_exma_f (.s_d_i(s_rexma_f),.s_d_o(s_exma_f));
    tmr_comb #(.W($size(ictrl))) m_tmr_exma_ictrl (.s_d_i(s_rexma_ictrl),.s_d_o(s_exma_ictrl));
    tmr_comb #(.W(1)) m_lsu_transfer (.s_d_i(s_lsu),.s_d_o(s_lsu_trans));
`else
    assign s_exma_payload   = s_rexma_payload;
    assign s_exma_val       = s_rexma_val;
    assign s_exma_rd        = s_rexma_rd;
    assign s_exma_f         = s_rexma_f;
    assign s_exma_ictrl     = s_rexma_ictrl;
    assign s_lsu_trans      = s_lsu; 
`endif

    //Data bus interface signals
    assign s_haddr_o        = s_operand1[0]; 
    assign s_hsize_o        = {1'b0,s_opex_f_i[0][1:0]}; 
    assign s_hwrite_o       = s_opex_f_i[0][3];
    assign s_hwdata_o       = (s_exma_payload[0][1:0] == 2'b00) ? s_exma_val[0]:
                              (s_exma_payload[0][1:0] == 2'b01) ? {s_exma_val[0][23:0],8'b0}:
                              (s_exma_payload[0][1:0] == 2'b10) ? {s_exma_val[0][15:0],16'b0}: {s_exma_val[0][7:0],24'b0};
    assign s_htrans_o       = {s_lsu_trans[0],1'b0};
    assign s_hburst_o       = 3'b0;
    assign s_hmastlock_o    = 1'b0;
    assign s_hprot_o        = 4'b0;

    genvar i;
    generate
        for (i = 0; i<EX_REPS ;i++ ) begin : ex_replicator_2
`ifdef PROTECTED
            //OPEX registers replicas comparision
            assign s_opex_neq[i]  = (s_opex_op1_i[0] != s_opex_op1_i[1]) | (s_opex_op2_i[0] != s_opex_op2_i[1]) | 
                                    (s_opex_rd_i[0] != s_opex_rd_i[1]) | (s_opex_payload_i[0] != s_opex_payload_i[1]) | 
                                    (s_opex_f_i[0] != s_opex_f_i[1]) | (s_opex_ictrl_i[0] != s_opex_ictrl_i[1]) | 
                                    (s_opex_fwd_i[0] != s_opex_fwd_i[1]);
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

        for (i = 0; i<EXMA_REPS;i++ ) begin : ex_replicator
            assign s_stall_ex[i]= s_stall_i[i][PIPE_MA];
            //If a bubble is signalized by the Executor, stall lower stages and insert NOP to the MA stage
            assign s_stall_o[i] = s_bubble[i];
            //Ignore the bubble request, if a stall is signalized from the upper stages
            assign s_flush_ex[i]= s_flush_i[i] | (s_bubble[i] & ~s_stall_ex[i]);
            //Bubble can happen only from MDU
            assign s_bubble[i]  = s_opex_ictrl_i[i%2][ICTRL_UNIT_MDU] & ~s_ex_fin[0] 
`ifdef PROTECTED
                                    //Disable a bubble if at least one replica signalizes a finish
                                    & ~s_ex_fin[1]
`endif
                                    ;
`ifdef PROTECTED
            //Reset the instruction if discrepancy exists between the OPEX registers
            assign s_rstpipe[i] = s_opex_neq[0] | s_opex_neq[1];
`endif                             
            //Forward data from the upper stages registers to the instruction operands in EX stage
            assign s_operand1[i]= (s_opex_fwd_i[i%2][0]) ? s_exma_val[i] : (s_opex_fwd_i[i%2][2]) ? s_mawb_val_i[i] : s_opex_op1_i[i%2];
            assign s_operand2[i]= (s_opex_fwd_i[i%2][1]) ? s_exma_val[i] : (s_opex_fwd_i[i%2][3]) ? s_mawb_val_i[i] : s_opex_op2_i[i%2];

            //Misalignment detection for the Load and Store instructions
            assign s_lsu_misa[i]= ((|s_operand1[i%2][1:0] & s_opex_f_i[i%2][1]) | (s_operand1[i%2][0] & s_opex_f_i[i%2][0]));
            //Data bus transfer activation
            assign s_lsu[i]     = s_opex_ictrl_i[i%2][ICTRL_UNIT_LSU] & ~s_lsu_misa[i] & ~s_flush_i[i] 
`ifdef PROTECTED            
                                & ~s_rstpipe[i]
`endif
                                ;
            always_comb begin : pipe_4_writer
                if(~s_resetn_i[i] | s_flush_ex[i])begin
                    s_wexma_val[i]      = 32'b0;
                    s_wexma_payload[i]  = 32'b0;
                    s_wexma_ictrl[i]    = 8'b0; 
                    s_wexma_rd[i]       = 5'b0;  
                    s_wexma_f[i]        = 4'b0;
                end else if(s_stall_ex[i])begin
                    s_wexma_val[i]      = s_exma_val[i];
                    s_wexma_payload[i]  = s_exma_payload[i];
                    s_wexma_rd[i]       = s_exma_rd[i];
                    s_wexma_f[i]        = s_exma_f[i];
                    s_wexma_ictrl[i]    = s_exma_ictrl[i];
                end else begin
                    s_wexma_rd[i]       = s_opex_rd_i[i%2];
                    s_wexma_f[i]        = s_opex_f_i[i%2];
                    s_wexma_ictrl[i]    = 
`ifdef PROTECTED
                                          s_rstpipe[i] ? ICTRL_RST_VAL : 
`endif
                                          s_opex_ictrl_i[i%2];
                    //Select EX stage result
                    s_wexma_val[i]      = (s_opex_ictrl_i[i%2][ICTRL_UNIT_ALU] | 
                                           s_opex_ictrl_i[i%2][ICTRL_UNIT_BRU] | 
                                           s_opex_ictrl_i[i%2][ICTRL_UNIT_MDU]) ? s_result[i%2] : s_operand2[i];
                    //Save bus-transfer address or payload for the MA stage
                    s_wexma_payload[i]  = s_opex_ictrl_i[i%2][ICTRL_UNIT_LSU] ? s_operand1[i%2] : {11'b0,s_opex_payload_i[i%2]};
                end
            end         
        end
    endgenerate  
endmodule
