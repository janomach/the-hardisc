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
    input logic s_clk_i[CTRL_REPS],                 //clock signal
    input logic s_resetn_i[CTRL_REPS],              //reset signal

    input logic[4:0] s_stall_i[CTRL_REPS],          //stall signals from upper stages
    input logic s_flush_i[CTRL_REPS],               //flush signal from MA stage
    output logic s_stall_o[CTRL_REPS],              //signalize stalling to the lower stages

    input rf_add s_mawb_rd_i[MAWB_REPS],            //WB-stage destination register address
    input logic[31:0] s_mawb_val_i[MAWB_REPS],      //WB-stage instruction result
    input ictrl s_mawb_ictrl_i[MAWB_REPS],          //WB-stage instruction control indicator
    input rf_add s_exma_rd_i[EXMA_REPS],            //MA-stage destination register address
    input logic[31:0] s_exma_val_i[EXMA_REPS],      //MA-stage instruction result
    input ictrl s_exma_ictrl_i[EXMA_REPS],          //MA-stage instruction control indicator

`ifdef PROTECTED
    input logic[1:0] s_rf_uce_i[IDOP_REPS],         //uncorrectable error in the register-file
    input logic[1:0] s_rf_ce_i[IDOP_REPS],          //correctable error in the register-file
`endif
      
    input logic[31:0] s_idop_p1_i,                  //value read from RS1 address of register file
    input logic[31:0] s_idop_p2_i,                  //value read from RS2 address of register file
    input logic[20:0] s_idop_payload_i[IDOP_REPS],  //instruction payload information
    input f_part s_idop_f_i[IDOP_REPS],             //instruction function
    input rf_add s_idop_rs1_i[IDOP_REPS],           //source register 1 address
    input rf_add s_idop_rs2_i[IDOP_REPS],           //source register 2 address
    input rf_add s_idop_rd_i[IDOP_REPS],            //destination register address
    input sctrl s_idop_sctrl_i[IDOP_REPS],          //source control indicator
    input ictrl s_idop_ictrl_i[IDOP_REPS],          //instruction control indicator
    input imiscon s_idop_imiscon_i[IDOP_REPS],      //instruction misconduct indicator

    output logic[31:0] s_opex_op1_o[OPEX_REPS],     //prepared operand 1 for EX stage
    output logic[31:0] s_opex_op2_o[OPEX_REPS],     //prepared operand 2 for EX stage
    output logic[20:0] s_opex_payload_o[OPEX_REPS], //payload information for EX stage
    output ictrl s_opex_ictrl_o[OPEX_REPS],         //instruction control indicator for EX stage
    output imiscon s_opex_imiscon_o[OPEX_REPS],     //instruction misconduct indicator for EX stage
    output rf_add s_opex_rd_o[OPEX_REPS],           //destination register address for EX stage
    output f_part s_opex_f_o[OPEX_REPS],            //instruction function for EX stage
    output logic[3:0]s_opex_fwd_o[OPEX_REPS]        //forwarding information for EX stage
);

    logic[31:0] s_wopex_op1[OPEX_REPS], s_wopex_op2[OPEX_REPS],s_ropex_op1[OPEX_REPS], s_ropex_op2[OPEX_REPS], s_operand1[OPEX_REPS], s_operand2[OPEX_REPS];
    logic[20:0] s_wopex_payload[OPEX_REPS], s_ropex_payload[OPEX_REPS];
    rf_add s_wopex_rd[OPEX_REPS], s_ropex_rd[OPEX_REPS];
    f_part s_wopex_f[OPEX_REPS], s_ropex_f[OPEX_REPS];
    ictrl s_wopex_ictrl[OPEX_REPS], s_ropex_ictrl[OPEX_REPS];
    imiscon s_wopex_imiscon[OPEX_REPS], s_ropex_imiscon[OPEX_REPS]; 
    logic[3:0] s_wopex_fwd[OPEX_REPS], s_ropex_fwd[OPEX_REPS], s_forward[OPEX_REPS];

    logic s_bubble[OPEX_REPS];
    logic s_stall_op[CTRL_REPS], s_flush_op[CTRL_REPS];
    logic s_clk_prw[OPEX_REPS], s_resetn_prw[OPEX_REPS];

    assign s_opex_ictrl_o   = s_ropex_ictrl;
    assign s_opex_rd_o      = s_ropex_rd;
    assign s_opex_f_o       = s_ropex_f;
    assign s_opex_payload_o = s_ropex_payload;
    assign s_opex_op1_o     = s_ropex_op1;
    assign s_opex_op2_o     = s_ropex_op2;
    assign s_opex_fwd_o     = s_ropex_fwd;
    assign s_opex_imiscon_o = s_ropex_imiscon;

    //Computation operand 1
    seu_regs #(.LABEL({"OPEX_OP1"}),.N(OPEX_REPS))m_opex_op1 (.s_c_i(s_clk_prw),.s_d_i(s_wopex_op1),.s_d_o(s_ropex_op1));
    //Computation operand 2
    seu_regs #(.LABEL({"OPEX_OP2"}),.N(OPEX_REPS))m_opex_op2 (.s_c_i(s_clk_prw),.s_d_i(s_wopex_op2),.s_d_o(s_ropex_op2));
    //Destination register address
    seu_regs #(.LABEL({"OPEX_RD"}),.W($size(rf_add)),.N(OPEX_REPS)) m_opex_rd (.s_c_i(s_clk_prw),.s_d_i(s_wopex_rd),.s_d_o(s_ropex_rd));
    //Instruction payload information
    seu_regs #(.LABEL({"OPEX_PYLD"}),.W(21),.N(OPEX_REPS)) m_opex_payload (.s_c_i(s_clk_prw),.s_d_i(s_wopex_payload),.s_d_o(s_ropex_payload));
    //Instruction function information
    seu_regs #(.LABEL({"OPEX_F"}),.W($size(f_part)),.N(OPEX_REPS)) m_opex_f (.s_c_i(s_clk_prw),.s_d_i(s_wopex_f),.s_d_o(s_ropex_f));
    //Instruction control indicator
    seu_regs #(.LABEL({"OPEX_ICTRL"}),.W($size(ictrl)),.N(OPEX_REPS)) m_opex_ictrl (.s_c_i(s_clk_prw),.s_d_i(s_wopex_ictrl),.s_d_o(s_ropex_ictrl));
    //Instruction misconduct indicator
    seu_regs #(.LABEL({"OPEX_IMISCON"}),.W($size(imiscon)),.N(OPEX_REPS)) m_opex_imiscon (.s_c_i(s_clk_prw),.s_d_i(s_wopex_imiscon),.s_d_o(s_ropex_imiscon));
    //Forwarding information
    seu_regs #(.LABEL({"OPEX_FWD"}),.W(4),.N(OPEX_REPS)) m_opex_fwd (.s_c_i(s_clk_prw),.s_d_i(s_wopex_fwd),.s_d_o(s_ropex_fwd));

    logic s_id_misconduct[OPEX_REPS];
`ifdef PROTECTED
    logic s_op_misconduct[OPEX_REPS], s_uce[OPEX_REPS], s_ce[OPEX_REPS];
`endif

    genvar i;
    generate
        //----------------------//
        for (i = 0;i<CTRL_REPS ;i++ ) begin : op_replicator_0
            assign s_stall_op[i]    = (|s_stall_i[i][PIPE_MA:PIPE_EX]);
            //If a bubble is signalized by the Preparer, stall lower stages and insert NOP to the EX stage
            assign s_stall_o[i]     = s_bubble[i%2];
            //Ignore the bubble request, if a stall is signalized from the upper stages
            assign s_flush_op[i]    = s_flush_i[i] | (s_bubble[i%2] & ~s_stall_op[i]);
        end

        for (i = 0;i<OPEX_REPS ;i++ ) begin : op_replicator_1
            assign s_clk_prw[i]     = s_clk_i[i];
            assign s_resetn_prw[i]  = s_resetn_i[i];

            //The ID stage requests restart of the instruction
            assign s_id_misconduct[i]   = (s_idop_imiscon_i[i] != IMISCON_FREE)
`ifdef EDAC_INTERFACE
                                         & (s_idop_imiscon_i[i] != IMISCON_FCER)
`endif            
                                        ;
`ifdef PROTECTED
            //Correctable error or differences between read-address registers lead to restart of the instruction
            assign s_op_misconduct[i]   = (s_ce[i] | (s_idop_rs1_i[0] != s_idop_rs1_i[1]) | (s_idop_rs2_i[0] != s_idop_rs2_i[1])); 
`endif
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
                .s_opex_f_i(s_ropex_f[i]),

                .s_idop_p1_i(s_idop_p1_i),
                .s_idop_p2_i(s_idop_p2_i),
                .s_idop_payload_i(s_idop_payload_i[i]),
                .s_idop_f_i(s_idop_f_i[i]),
                .s_idop_rs1_i(s_idop_rs1_i[i]),
                .s_idop_rs2_i(s_idop_rs2_i[i]),
                .s_idop_ictrl_i(s_idop_ictrl_i[i]),
                .s_idop_sctrl_i(s_idop_sctrl_i[i]),
`ifdef PROTECTED 
                .s_rf_uce_i(s_rf_uce_i[i]),
                .s_rf_ce_i(s_rf_ce_i[i]),
                .s_uce_o(s_uce[i]),
                .s_ce_o(s_ce[i]),
`endif
                .s_operand1_o(s_operand1[i]),
                .s_operand2_o(s_operand2[i]),
                .s_fwd_o(s_forward[i]),
                .s_bubble_o(s_bubble[i])
            );

            //Update values for OPEX registers
            always_comb begin : pipe_3_writer
                if(~s_resetn_i[i] | s_flush_op[i])begin
                    s_wopex_rd[i]       = 5'b0; 
                    s_wopex_f[i]        = 4'b0;  
                    s_wopex_ictrl[i]    = 7'b0;
                    s_wopex_payload[i]  = 21'b0;
                    s_wopex_op1[i]      = 32'b0;
                    s_wopex_op2[i]      = 32'b0;
                    s_wopex_fwd[i]      = 4'b0;
                    s_wopex_imiscon[i]  = IMISCON_FREE; 
                end else if(s_stall_op[i])begin
                    s_wopex_rd[i]       = s_ropex_rd[i]; 
                    s_wopex_f[i]        = s_ropex_f[i];  
                    s_wopex_ictrl[i]    = s_ropex_ictrl[i];
                    s_wopex_payload[i]  = s_ropex_payload[i];
                    //Forward data from the WB stage to the operand registers if the the MA stage signalizes a stall
                    s_wopex_op1[i]      = (s_ropex_fwd[i][2]) ? s_mawb_val_i[i] : s_ropex_op1[i];
                    s_wopex_op2[i]      = (s_ropex_fwd[i][3]) ? s_mawb_val_i[i] : s_ropex_op2[i];
                    s_wopex_fwd[i]      = {2'b0,s_ropex_fwd[i][1:0]};
                    s_wopex_imiscon[i]  = s_ropex_imiscon[i];
                end else begin
                    s_wopex_rd[i]       = s_idop_rd_i[i]; 
                    s_wopex_f[i]        = s_idop_f_i[i];  
                    s_wopex_ictrl[i]    = s_idop_ictrl_i[i];
                    s_wopex_payload[i]  = s_idop_payload_i[i];
                    s_wopex_op1[i]      = s_operand1[i];
                    s_wopex_op2[i]      = s_operand2[i];
                    s_wopex_fwd[i]      = s_forward[i];
                    s_wopex_ictrl[i]    = 
`ifdef PROTECTED
                                          (s_id_misconduct[i]) ? s_idop_ictrl_i[i] : 
                                          (s_op_misconduct[i] | s_uce[i]) ? 7'd0 : 
`endif
                                          s_idop_ictrl_i[i];
                    s_wopex_imiscon[i]  = 
`ifdef PROTECTED                                          
                                          (s_id_misconduct[i]) ? s_idop_imiscon_i[i] : 
                                          (s_op_misconduct[i]) ? IMISCON_DSCR : 
                                          (s_uce[i]) ? IMISCON_RUCE : 
`endif                                          
                                          s_idop_imiscon_i[i];
                end
            end
        end     
    endgenerate
endmodule
