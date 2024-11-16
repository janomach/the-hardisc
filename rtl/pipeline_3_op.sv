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

module pipeline_3_op (
    input logic s_clk_i[PROT_3REP],                 //clock signal
    input logic s_resetn_i[PROT_3REP],              //reset signal

    input logic[4:0] s_stall_i[PROT_3REP],          //stall signals from upper stages
    input logic s_flush_i[PROT_3REP],               //flush signal from MA stage
    output logic s_stall_o[PROT_3REP],              //signalize stalling to the lower stages

    input rf_add s_mawb_rd_i[PROT_3REP],            //WB-stage destination register address
    input logic[31:0] s_mawb_val_i[PROT_3REP],      //WB-stage instruction result
    input ictrl s_mawb_ictrl_i[PROT_3REP],          //WB-stage instruction control indicator
    input rf_add s_exma_rd_i[PROT_3REP],            //MA-stage destination register address
    input logic[31:0] s_exma_val_i[PROT_3REP],      //MA-stage instruction result
    input ictrl s_exma_ictrl_i[PROT_3REP],          //MA-stage instruction control indicator
      
    input logic[31:0] s_idop_p1_i[PROT_2REP],       //value read from RS1 address of register file
    input logic[31:0] s_idop_p2_i[PROT_2REP],       //value read from RS2 address of register file
    input logic[20:0] s_idop_payload_i[PROT_2REP],  //instruction payload information
    input f_part s_idop_f_i[PROT_2REP],             //instruction function
    input rf_add s_idop_rs1_i[PROT_2REP],           //source register 1 address
    input rf_add s_idop_rs2_i[PROT_2REP],           //source register 2 address
    input rf_add s_idop_rd_i[PROT_2REP],            //destination register address
    input sctrl s_idop_sctrl_i[PROT_2REP],          //source control indicator
    input ictrl s_idop_ictrl_i[PROT_2REP],          //instruction control indicator
    input imiscon s_idop_imiscon_i[PROT_2REP],      //instruction misconduct indicator
    input logic s_idop_fixed_i[PROT_2REP],          //fix indicator

    output logic[31:0] s_opex_op1_o[PROT_2REP],     //prepared operand 1 for EX stage
    output logic[31:0] s_opex_op2_o[PROT_2REP],     //prepared operand 2 for EX stage
    output logic[20:0] s_opex_payload_o[PROT_2REP], //payload information for EX stage
    output ictrl s_opex_ictrl_o[PROT_2REP],         //instruction control indicator for EX stage
    output imiscon s_opex_imiscon_o[PROT_2REP],     //instruction misconduct indicator for EX stage
    output rf_add s_opex_rd_o[PROT_2REP],           //destination register address for EX stage
    output f_part s_opex_f_o[PROT_2REP],            //instruction function for EX stage
    output logic[3:0]s_opex_fwd_o[PROT_2REP]        //forwarding information for EX stage
);

    logic[31:0] s_wopex_op1[PROT_2REP], s_wopex_op2[PROT_2REP],s_ropex_op1[PROT_2REP], s_ropex_op2[PROT_2REP], s_operand1[PROT_2REP], s_operand2[PROT_2REP];
    logic[20:0] s_wopex_payload[PROT_2REP], s_ropex_payload[PROT_2REP];
    rf_add s_wopex_rd[PROT_2REP], s_ropex_rd[PROT_2REP];
    f_part s_wopex_f[PROT_2REP], s_ropex_f[PROT_2REP];
    ictrl s_wopex_ictrl[PROT_2REP], s_ropex_ictrl[PROT_2REP];
    imiscon s_wopex_imiscon[PROT_2REP], s_ropex_imiscon[PROT_2REP]; 
    logic[3:0] s_wopex_fwd[PROT_2REP], s_ropex_fwd[PROT_2REP], s_forward[PROT_2REP];
    logic s_opex_we_aux[PROT_2REP], s_opex_we_esn[PROT_2REP], s_opex_we_fwd[PROT_2REP];

    logic s_bubble[PROT_2REP];
    logic s_stall_op[PROT_2REP], s_flush_op[PROT_2REP];
    logic s_clk_prw[PROT_2REP], s_resetn_prw[PROT_2REP];

    assign s_opex_ictrl_o   = s_ropex_ictrl;
    assign s_opex_rd_o      = s_ropex_rd;
    assign s_opex_f_o       = s_ropex_f;
    assign s_opex_payload_o = s_ropex_payload;
    assign s_opex_op1_o     = s_ropex_op1;
    assign s_opex_op2_o     = s_ropex_op2;
    assign s_opex_fwd_o     = s_ropex_fwd;
    assign s_opex_imiscon_o = s_ropex_imiscon;

    //Computation operand 1
    seu_ff_we #(.LABEL({"OPEX_OP1"}),.N(PROT_2REP))m_opex_op1 (.s_c_i(s_clk_prw),.s_we_i(s_opex_we_fwd),.s_d_i(s_wopex_op1),.s_q_o(s_ropex_op1));
    //Computation operand 2
    seu_ff_we #(.LABEL({"OPEX_OP2"}),.N(PROT_2REP))m_opex_op2 (.s_c_i(s_clk_prw),.s_we_i(s_opex_we_fwd),.s_d_i(s_wopex_op2),.s_q_o(s_ropex_op2));
    //Destination register address
    seu_ff_we #(.LABEL({"OPEX_RD"}),.W($size(rf_add)),.N(PROT_2REP)) m_opex_rd (.s_c_i(s_clk_prw),.s_we_i(s_opex_we_aux),.s_d_i(s_wopex_rd),.s_q_o(s_ropex_rd));
    //Instruction payload information
    seu_ff_we #(.LABEL({"OPEX_PYLD"}),.W(21),.N(PROT_2REP)) m_opex_payload (.s_c_i(s_clk_prw),.s_we_i(s_opex_we_aux),.s_d_i(s_wopex_payload),.s_q_o(s_ropex_payload));
    //Instruction function information
    seu_ff_we #(.LABEL({"OPEX_F"}),.W($size(f_part)),.N(PROT_2REP)) m_opex_f (.s_c_i(s_clk_prw),.s_we_i(s_opex_we_aux),.s_d_i(s_wopex_f),.s_q_o(s_ropex_f));
    //Instruction control indicator
    seu_ff_we_rst #(.LABEL({"OPEX_ICTRL"}),.W($size(ictrl)),.N(PROT_2REP)) m_opex_ictrl (.s_c_i(s_clk_prw),.s_we_i(s_opex_we_esn),.s_r_i(s_resetn_prw),.s_d_i(s_wopex_ictrl),.s_q_o(s_ropex_ictrl));
    //Instruction misconduct indicator
    seu_ff_we_rst #(.LABEL({"OPEX_IMISCON"}),.W($size(imiscon)),.N(PROT_2REP)) m_opex_imiscon (.s_c_i(s_clk_prw),.s_we_i(s_opex_we_esn),.s_r_i(s_resetn_prw),.s_d_i(s_wopex_imiscon),.s_q_o(s_ropex_imiscon));
    //Forwarding information
    seu_ff_we #(.LABEL({"OPEX_FWD"}),.W(4),.N(PROT_2REP)) m_opex_fwd (.s_c_i(s_clk_prw),.s_we_i(s_opex_we_fwd),.s_d_i(s_wopex_fwd),.s_q_o(s_ropex_fwd));

    logic s_id_misconduct[PROT_2REP], s_op_empty[PROT_2REP];

    genvar i;
    generate
        //----------------------//
        for (i = 0;i<PROT_3REP ;i++ ) begin : op_replicator_0
            //If a bubble is signalized by the Preparer, stall lower stages and insert NOP to the EX stage
            assign s_stall_o[i]     = s_bubble[i%2];
        end

        for (i = 0;i<PROT_2REP ;i++ ) begin : op_replicator_1
            assign s_clk_prw[i]     = s_clk_i[i];
            assign s_resetn_prw[i]  = s_resetn_i[i];

            assign s_stall_op[i]    = (|s_stall_i[i][PIPE_MA:PIPE_EX]);
            //Ignore the bubble request, if a stall is signalized from the upper stages
            assign s_flush_op[i]    = s_flush_i[i] | (s_bubble[i] & ~s_stall_op[i]);

            //The ID stage requests restart of the instruction
            assign s_id_misconduct[i]   = (s_idop_imiscon_i[i] != IMISCON_FREE);
            assign s_op_empty[i]        = (s_idop_imiscon_i[i] == IMISCON_FREE) & (s_idop_ictrl_i[i] == 7'b0);
            assign s_opex_we_fwd[i]     = s_opex_we_aux[i] || ((s_ropex_fwd[i][3:2] != 2'b0) && s_stall_op[i]);
            //Write-enable signals for auxiliary OPEX registers
            assign s_opex_we_aux[i]     = !(s_flush_op[i] || s_stall_op[i] || s_op_empty[i]);
            //Write-enable signals for essential OPEX registers
            assign s_opex_we_esn[i]     = s_flush_op[i] || !s_stall_op[i];

            //Prepare operands for the EX stage
            preparer m_preparer
            (
                .s_mawb_rd_i(s_mawb_rd_i[i]),
                .s_mawb_val_i(s_mawb_val_i[i]),
                .s_mawb_ictrl_i(s_mawb_ictrl_i[i]),
                .s_exma_rd_i(s_exma_rd_i[i]),
                .s_exma_val_i(s_exma_val_i[i]),
                .s_exma_ictrl_i(s_exma_ictrl_i[i]),
                .s_opex_rd_i(s_ropex_rd[i]),
                .s_opex_ictrl_i(s_ropex_ictrl[i]),

                .s_idop_p1_i(s_idop_p1_i[i]),
                .s_idop_p2_i(s_idop_p2_i[i]),
                .s_idop_payload_i(s_idop_payload_i[i]),
                .s_idop_f_i(s_idop_f_i[i]),
                .s_idop_rs1_i(s_idop_rs1_i[i]),
                .s_idop_rs2_i(s_idop_rs2_i[i]),
                .s_idop_ictrl_i(s_idop_ictrl_i[i]),
                .s_idop_sctrl_i(s_idop_sctrl_i[i]),
                .s_idop_fixed_i(s_idop_fixed_i[i]),

                .s_operand1_o(s_operand1[i]),
                .s_operand2_o(s_operand2[i]),
                .s_fwd_o(s_forward[i]),
                .s_bubble_o(s_bubble[i])
            );

            //Update values for OPEX registers
            always_comb begin : pipe_3_writer
                s_wopex_rd[i]       = s_idop_rd_i[i]; 
                s_wopex_f[i]        = s_idop_f_i[i];  
                s_wopex_ictrl[i]    = s_idop_ictrl_i[i];
                s_wopex_payload[i]  = s_idop_payload_i[i];
                s_wopex_ictrl[i]    = 
`ifdef PROT_INTF
                                        (s_id_misconduct[i]) ? s_idop_ictrl_i[i] :
`endif
                                        s_idop_ictrl_i[i];
                s_wopex_imiscon[i]  = 
`ifdef PROT_INTF                                          
                                        (s_id_misconduct[i]) ? s_idop_imiscon_i[i] :
`endif                                      
                                        s_idop_imiscon_i[i];
                if(s_flush_op[i] || s_op_empty[i])begin 
                    s_wopex_ictrl[i]    = 7'b0;
                    s_wopex_imiscon[i]  = IMISCON_FREE; 
                end
            end

            //Update values for OPEX registers
            always_comb begin : pipe_3_writer_fwd
                s_wopex_op1[i]      = s_operand1[i];
                s_wopex_op2[i]      = s_operand2[i];
                s_wopex_fwd[i]      = s_forward[i];
                if(s_stall_op[i])begin
                    //Forward data from the WB stage to the operand registers if the the MA stage signalizes a stall
                    s_wopex_op1[i]      = (s_ropex_fwd[i][2]) ? s_mawb_val_i[i] : s_ropex_op1[i];
                    s_wopex_op2[i]      = (s_ropex_fwd[i][3]) ? s_mawb_val_i[i] : s_ropex_op2[i];
                    s_wopex_fwd[i]      = {2'b0,s_ropex_fwd[i][1:0]};
                end
            end
        end     
    endgenerate
endmodule
