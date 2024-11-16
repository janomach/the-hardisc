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

module preparer (
    input rf_add s_mawb_rd_i,           //WB-stage destination register address
    input logic[31:0] s_mawb_val_i,     //WB-stage instruction result
    input ictrl s_mawb_ictrl_i,         //WB stage instruction control indicator
    input rf_add s_exma_rd_i,           //MA-stage destination register address
    input logic[31:0] s_exma_val_i,     //MA-stage instruction result
    input ictrl s_exma_ictrl_i,         //MA-stage instruction control indicator
    input rf_add s_opex_rd_i,           //EX-stage destination register address
    input ictrl s_opex_ictrl_i,         //EX-stage instruction control indicator

    input logic[31:0] s_idop_p1_i,      //value read from RS1 address of register file
    input logic[31:0] s_idop_p2_i,      //value read from RS2 address of register file
    input logic[20:0] s_idop_payload_i, //instruction payload information
    input f_part s_idop_f_i,            //instruction function
    input rf_add s_idop_rs1_i,          //source register 1 address
    input rf_add s_idop_rs2_i,          //source register 2 address
    input sctrl s_idop_sctrl_i,         //source control indicator
    input ictrl s_idop_ictrl_i,         //instruction control indicator
    input logic s_idop_fixed_i,         //fix indicator

    output logic[31:0] s_operand1_o,    //prepared operand 1
    output logic[31:0] s_operand2_o,    //prepared operand 2
    output logic[3:0]s_fwd_o,           //forwarding information
    output logic s_bubble_o             //bubble request indicator
);

    logic[20:0] s_tau_val;
    logic[3:0]  s_forward;
    rf_add s_rs1, s_rs2;
    logic[31:0] s_operand1_fw, s_operand2_fw, s_operand1, s_operand2, s_address, s_p1_val, s_p2_val, s_pc;
    logic s_rs1_cmpr_exma, s_rs2_cmpr_exma, s_rs1_cmpr_mawb, s_rs2_cmpr_mawb,
            s_rs1_need_exma, s_rs2_need_exma, s_rs1_need_mawb, s_rs2_need_mawb,
            s_rs1_cmpr_opex, s_rs2_cmpr_opex, s_rs1_need_opex, s_rs2_need_opex,
            s_lsu_hazard, s_data_hazard, s_bubble, s_fix_hazard, s_pc_hazard, s_no_res_in_ex, s_result_in_ma, s_uce, s_ce;

    assign s_bubble_o   = s_bubble;
    assign s_operand1_o = s_operand1;  
    assign s_operand2_o = s_operand2;    
    assign s_tadd_o     = s_tau_val;
    assign s_fwd_o      = s_forward;

    //Auxiliary signals
    assign s_rs1            = (s_idop_sctrl_i[SCTRL_ZERO1]) ? 5'b0 : s_idop_rs1_i;
    assign s_rs2            = (s_idop_sctrl_i[SCTRL_ZERO2]) ? 5'b0 : s_idop_rs2_i;
    assign s_rs1_cmpr_opex  = (s_opex_rd_i == s_rs1);
    assign s_rs2_cmpr_opex  = (s_opex_rd_i == s_rs2);
    assign s_rs1_cmpr_exma  = (s_exma_rd_i == s_rs1);
    assign s_rs2_cmpr_exma  = (s_exma_rd_i == s_rs2);
    assign s_rs1_cmpr_mawb  = (s_mawb_rd_i == s_rs1);
    assign s_rs2_cmpr_mawb  = (s_mawb_rd_i == s_rs2);
    assign s_no_res_in_ex   = s_opex_ictrl_i[ICTRL_UNIT_LSU] | s_opex_ictrl_i[ICTRL_UNIT_BRU] | s_opex_ictrl_i[ICTRL_UNIT_CSR];
    assign s_result_in_ma   = s_exma_ictrl_i[ICTRL_UNIT_LSU] | s_exma_ictrl_i[ICTRL_UNIT_BRU] | s_exma_ictrl_i[ICTRL_UNIT_CSR];

    //Register read-after-write conditions between OP and upper stages
    assign s_rs1_need_opex  = (s_rs1_cmpr_opex & s_idop_sctrl_i[SCTRL_RFRP1] & s_opex_ictrl_i[ICTRL_REG_DEST]);
    assign s_rs2_need_opex  = (s_rs2_cmpr_opex & s_idop_sctrl_i[SCTRL_RFRP2] & s_opex_ictrl_i[ICTRL_REG_DEST]);
    assign s_rs1_need_exma  = (s_rs1_cmpr_exma & s_idop_sctrl_i[SCTRL_RFRP1] & s_exma_ictrl_i[ICTRL_REG_DEST]);
    assign s_rs2_need_exma  = (s_rs2_cmpr_exma & s_idop_sctrl_i[SCTRL_RFRP2] & s_exma_ictrl_i[ICTRL_REG_DEST]);
    assign s_rs1_need_mawb  = (s_rs1_cmpr_mawb & s_idop_sctrl_i[SCTRL_RFRP1] & s_mawb_ictrl_i[ICTRL_REG_DEST]);
    assign s_rs2_need_mawb  = (s_rs2_cmpr_mawb & s_idop_sctrl_i[SCTRL_RFRP2] & s_mawb_ictrl_i[ICTRL_REG_DEST]);

    //LSU bus-address hazard, the address must be computed in the OP stage
    assign s_lsu_hazard     = (s_rs1_need_opex | (s_rs1_need_exma & s_result_in_ma)) & s_idop_ictrl_i[ICTRL_UNIT_LSU];
    //Data hazard, forwardable result is produced in the MA stage
    assign s_data_hazard    = (s_rs1_need_opex | s_rs2_need_opex) & s_no_res_in_ex;                           
    //Fix hazard - prevent propagation until EX and MA stages are empty
    assign s_fix_hazard     = s_idop_fixed_i & ((s_opex_ictrl_i != 7'b0) | (s_exma_ictrl_i != 7'b0));
    //Each fulfilled hazard condition leads to bubble (NOP) in the EX stage
    assign s_bubble         = s_lsu_hazard | s_data_hazard | s_fix_hazard;

    //Forwarding logic from upper pipeline registers
    assign s_operand1_fw    = (~s_rs1_need_exma & ~s_rs1_need_mawb & ~s_idop_sctrl_i[SCTRL_ZERO1]) ? s_idop_p1_i :
                              (s_rs1_need_exma) ? s_exma_val_i : ((s_rs1_need_mawb) ? s_mawb_val_i :  32'b0);
    assign s_operand2_fw    = (~s_rs2_need_mawb & ~s_idop_sctrl_i[SCTRL_ZERO2]) ? s_idop_p2_i :
                              (s_rs2_need_mawb) ? s_mawb_val_i : 32'b0;

    //Forward result from the MA stage to the first operand in the EX stage
    assign s_forward[0]     = s_rs1_need_opex;
    //Forward result from the MA stage to the second operand in the EX stage
    assign s_forward[1]     = s_rs2_need_opex;
    //Forward result from the WB stage to the first operand in the EX stage, disable for load-store operations
    assign s_forward[2]     = s_rs1_need_exma & ~s_idop_ictrl_i[ICTRL_UNIT_LSU];
    //Forward result from the WB stage to the second operand in the EX stage
    assign s_forward[3]     = s_rs2_need_exma;

    //Computation of data-bus transfer address 
    fast_adder #(.ADDONLY(0)) m_lsu_address(.s_base_val_i(s_operand1_fw),.s_add_val_i(s_idop_payload_i[15:0]),.s_val_o(s_address)); 

    //Selection of operand 1 for the EX stage
    always_comb begin : operand_1
        if(s_idop_ictrl_i[ICTRL_UNIT_LSU])begin
            //Load-Store instruction address
            s_operand1 = s_address;
        end else if(s_idop_ictrl_i[ICTRL_UNIT_CSR] & s_idop_f_i[2])begin
            //CSR immediate instruction
            s_operand1 = {27'b0, s_idop_payload_i[15:11]};
        end else begin
            //Branches, standard/immediate integer instructions with RS1, JALR, M-ext, LUI (value 32'b0)
            s_operand1 = s_operand1_fw;
        end
    end

    //Selection of operand 2 for the EX stage
    always_comb begin : operand_2
        if(s_idop_sctrl_i[SCTRL_RFRP2])begin
            //Standard integer, Store, and Branch instructions, M-ext
            s_operand2 = s_operand2_fw;
        end else begin
            if(s_idop_sctrl_i[SCTRL_RFRP1])
                //Immediate integer instructions, JALR
                s_operand2 = {{12{s_idop_payload_i[19]}},s_idop_payload_i[19:0]};
            else
                //LUI instruction
                s_operand2 = {s_idop_payload_i[19:0],12'b0};
        end
    end

endmodule
