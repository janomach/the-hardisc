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

module csru (
    input logic s_clk_i[CTRL_REPS],                 //clock signal
    input logic s_resetn_i[CTRL_REPS],              //reset signal
    input logic[31:0] s_boot_add_i,                 //boot address

    input logic s_stall_i[CTRL_REPS],               //stall of MA stage
    input logic s_flush_i[CTRL_REPS],               //flush of MA stage

    input logic s_int_meip_i,                       //external interrupt
    input logic s_int_mtip_i,                       //timer interrupt
    input logic s_int_msip_i,                       //software interrupt
`ifdef PROTECTED
    input logic s_int_uce_i,                        //uncorrectable error in register-file
    output logic[1:0] s_acm_settings_o,             //acm settings
`endif

    input logic s_rstpp_i[EXMA_REPS],               //pipeline reset
    input logic[31:0] s_newrst_point_i[EXMA_REPS],  //new reset-point address
    input logic s_interrupted_i[EXMA_REPS],         //interrupt approval
    input logic s_exception_i[EXMA_REPS],           //exception condition
    input logic[4:0] s_exc_code_i[EXMA_REPS],       //code of exception condition

    input logic s_valid_instr_i[EXMA_REPS],         //valid instruction in MA stage
    input ictrl s_ictrl_i[EXMA_REPS],               //instruction control indicator
    input f_part s_function_i[EXMA_REPS],           //instruction function
    input logic[31:0] s_payload_i[EXMA_REPS],       //instruction payload information
    input logic[31:0] s_val_i[EXMA_REPS],           //result from EX stage
    output logic[31:0] s_csr_r_o[EXMA_REPS],        //value read from requested CSR
    output logic[31:0] s_exc_trap_o[EXMA_REPS],     //exception trap-handler address
    output logic[31:0] s_int_trap_o[EXMA_REPS],     //interrupt trap-handler address
    output logic[31:0] s_rst_point_o[EXMA_REPS],    //reset-point address
    output logic[31:0] s_mepc_o[EXMA_REPS],         //address saved in MEPC CSR
    output logic s_treturn_o[EXMA_REPS],            //return from trap-handler
    output logic s_int_pending_o[EXMA_REPS],        //pending interrupt
    output logic s_pred_disable_o,                  //disable any predictions
    output logic s_hrdmax_rst_o                     //max consecutive pipeline restarts reached
);

    logic[31:0]s_rmcsr[EXMA_REPS][0:MAX_MCSR];
    logic[31:0]s_wmcsr[EXMA_REPS][0:MAX_MCSR];
    logic[31:0] s_csr_r_val[EXMA_REPS], s_exc_trap[EXMA_REPS], s_int_trap[EXMA_REPS];
    logic s_int_pending[EXMA_REPS], s_mret[EXMA_REPS];
    logic[12:0]s_wmie[EXMA_REPS], s_rmie[EXMA_REPS], s_wmip[EXMA_REPS], s_rmip[EXMA_REPS],s_mie[EXMA_REPS], s_mip[EXMA_REPS];
    logic[31:0]s_wmstatus[EXMA_REPS],s_wmscratch[EXMA_REPS],s_wminstret[EXMA_REPS],s_wminstreth[EXMA_REPS],s_wmcycle[EXMA_REPS],s_wmcycleh[EXMA_REPS],
                s_wmtvec[EXMA_REPS],s_wmepc[EXMA_REPS],s_wmcause[EXMA_REPS],s_wmtval[EXMA_REPS],s_wmhrdctrl0[EXMA_REPS], s_wrstpoint[EXMA_REPS];
    logic[31:0]s_rmstatus[EXMA_REPS],s_rmscratch[EXMA_REPS],s_rminstret[EXMA_REPS],s_rminstreth[EXMA_REPS],s_rmcycle[EXMA_REPS],s_rmcycleh[EXMA_REPS],
                s_rmtvec[EXMA_REPS],s_rmepc[EXMA_REPS],s_rmcause[EXMA_REPS],s_rmtval[EXMA_REPS],s_rmhrdctrl0[EXMA_REPS], s_rrstpoint[EXMA_REPS], 
                s_mstatus[EXMA_REPS],s_mscratch[EXMA_REPS],s_minstret[EXMA_REPS],s_minstreth[EXMA_REPS],s_mcycle[EXMA_REPS],s_mcycleh[EXMA_REPS],
                s_mtvec[EXMA_REPS],s_mepc[EXMA_REPS],s_mcause[EXMA_REPS],s_mtval[EXMA_REPS],s_mhrdctrl0[EXMA_REPS], s_rstpoint[EXMA_REPS];
    logic s_clk_prw[EXMA_REPS], s_resetn_prw[EXMA_REPS];

    //CSR registers
    seu_regs #(.LABEL("CSR_MSTATUS"),.N(EXMA_REPS))m_mstatus (.s_c_i(s_clk_prw),.s_d_i(s_wmstatus),.s_d_o(s_rmstatus));
    seu_regs #(.LABEL("CSR_MINSTRET"),.N(EXMA_REPS))m_minstret (.s_c_i(s_clk_prw),.s_d_i(s_wminstret),.s_d_o(s_rminstret));
    seu_regs #(.LABEL("CSR_MINSTRETH"),.N(EXMA_REPS))m_minstreth (.s_c_i(s_clk_prw),.s_d_i(s_wminstreth),.s_d_o(s_rminstreth));
    seu_regs #(.LABEL("CSR_MCYCLE"),.N(EXMA_REPS))m_mcycle (.s_c_i(s_clk_prw),.s_d_i(s_wmcycle),.s_d_o(s_rmcycle));
    seu_regs #(.LABEL("CSR_MCYCLEH"),.N(EXMA_REPS))m_mcycleh (.s_c_i(s_clk_prw),.s_d_i(s_wmcycleh),.s_d_o(s_rmcycleh));
    seu_regs #(.LABEL("CSR_MSCRATCH"),.N(EXMA_REPS))m_mscratch (.s_c_i(s_clk_prw),.s_d_i(s_wmscratch),.s_d_o(s_rmscratch));
    seu_regs #(.LABEL("CSR_MTVEC"),.N(EXMA_REPS))m_mtvec (.s_c_i(s_clk_prw),.s_d_i(s_wmtvec),.s_d_o(s_rmtvec));
    seu_regs #(.LABEL("CSR_MEPC"),.N(EXMA_REPS))m_mepc (.s_c_i(s_clk_prw),.s_d_i(s_wmepc),.s_d_o(s_rmepc));
    seu_regs #(.LABEL("CSR_MCAUSE"),.N(EXMA_REPS))m_mcause (.s_c_i(s_clk_prw),.s_d_i(s_wmcause),.s_d_o(s_rmcause));
    seu_regs #(.LABEL("CSR_MTVAL"),.N(EXMA_REPS))m_mtval (.s_c_i(s_clk_prw),.s_d_i(s_wmtval),.s_d_o(s_rmtval));
    seu_regs #(.LABEL("CSR_MHRDCTRL0"),.N(EXMA_REPS))m_mhrdctrl0 (.s_c_i(s_clk_prw),.s_d_i(s_wmhrdctrl0),.s_d_o(s_rmhrdctrl0));
    seu_regs #(.LABEL("CSR_MIE"),.W(13),.N(EXMA_REPS)) m_mie (.s_c_i(s_clk_prw),.s_d_i(s_wmie),.s_d_o(s_rmie));
    seu_regs #(.LABEL("CSR_MIP"),.W(13),.N(EXMA_REPS)) m_mip (.s_c_i(s_clk_prw),.s_d_i(s_wmip),.s_d_o(s_rmip));
    seu_regs #(.LABEL("CSR_RSTPOINT"),.N(EXMA_REPS)) m_rstpoint (.s_c_i(s_clk_prw),.s_d_i(s_wrstpoint),.s_d_o(s_rrstpoint));

`ifdef PROTECTED
    //Triple-Modular-Redundancy
    tmr_comb m_tmr_mstatus (.s_d_i(s_rmstatus),.s_d_o(s_mstatus));
    tmr_comb m_tmr_minstret (.s_d_i(s_rminstret),.s_d_o(s_minstret));
    tmr_comb m_tmr_minstreth (.s_d_i(s_rminstreth),.s_d_o(s_minstreth));
    tmr_comb m_tmr_mcycle (.s_d_i(s_rmcycle),.s_d_o(s_mcycle));
    tmr_comb m_tmr_mcycleh (.s_d_i(s_rmcycleh),.s_d_o(s_mcycleh));
    tmr_comb m_tmr_mscratch (.s_d_i(s_rmscratch),.s_d_o(s_mscratch));
    tmr_comb m_tmr_mtvec (.s_d_i(s_rmtvec),.s_d_o(s_mtvec));
    tmr_comb m_tmr_mepc (.s_d_i(s_rmepc),.s_d_o(s_mepc));
    tmr_comb m_tmr_mcause (.s_d_i(s_rmcause),.s_d_o(s_mcause));
    tmr_comb m_tmr_mtval (.s_d_i(s_rmtval),.s_d_o(s_mtval));
    tmr_comb m_tmr_mhrdctrl0 (.s_d_i(s_rmhrdctrl0),.s_d_o(s_mhrdctrl0));
    tmr_comb m_tmr_rstpoint (.s_d_i(s_rrstpoint),.s_d_o(s_rstpoint));
    tmr_comb #(.W(13)) m_tmr_mie (.s_d_i(s_rmie),.s_d_o(s_mie));
    tmr_comb #(.W(13)) m_tmr_mip (.s_d_i(s_rmip),.s_d_o(s_mip));
`else
    assign s_mstatus    = s_rmstatus;
    assign s_minstret   = s_rminstret;
    assign s_minstreth  = s_rminstreth;
    assign s_mcycle     = s_rmcycle;
    assign s_mcycleh    = s_rmcycleh;
    assign s_mscratch   = s_rmscratch;
    assign s_mtvec      = s_rmtvec;
    assign s_mepc       = s_rmepc;
    assign s_mcause     = s_rmcause;
    assign s_mtval      = s_rmtval;
    assign s_mhrdctrl0  = s_rmhrdctrl0;
    assign s_rstpoint   = s_rrstpoint;
    assign s_mie        = s_rmie;
    assign s_mip        = s_rmip;
`endif

    assign s_pred_disable_o = s_mhrdctrl0[0][3];
    assign s_hrdmax_rst_o   = s_mhrdctrl0[0][2];
    assign s_acm_settings_o = s_mhrdctrl0[0][5:4];
    assign s_int_pending_o  = s_int_pending; 
    assign s_csr_r_o        = s_csr_r_val;  
    assign s_treturn_o      = s_mret;
    assign s_mepc_o         = s_mepc;
    assign s_exc_trap_o     = s_exc_trap;
    assign s_int_trap_o     = s_int_trap;  
    assign s_rst_point_o    = s_rstpoint;

    genvar i;
    generate
        for (i = 0; i<EXMA_REPS ;i++ ) begin : csr_replicator
            assign s_clk_prw[i]    = s_clk_i[i];
            assign s_resetn_prw[i] = s_resetn_i[i];

            assign s_rmcsr[i][MCSR_STATUS]  = s_mstatus[i];
            assign s_rmcsr[i][MCSR_INSTRET] = s_minstret[i];
            assign s_rmcsr[i][MCSR_INSTRETH]= s_minstreth[i];
            assign s_rmcsr[i][MCSR_CYCLE]   = s_mcycle[i];
            assign s_rmcsr[i][MCSR_CYCLEH]  = s_mcycleh[i];
            assign s_rmcsr[i][MCSR_SCRATCH] = s_mscratch[i];
            assign s_rmcsr[i][MCSR_IE]      = {19'h0,s_mie[i]};
            assign s_rmcsr[i][MCSR_TVEC]    = s_mtvec[i];
            assign s_rmcsr[i][MCSR_EPC]     = s_mepc[i];
            assign s_rmcsr[i][MCSR_CAUSE]   = s_mcause[i];
            assign s_rmcsr[i][MCSR_TVAL]    = s_mtval[i]; 
            assign s_rmcsr[i][MCSR_IP]      = {19'h0,s_mip[i]}; 
            assign s_rmcsr[i][MCSR_HRDCTRL0]= s_mhrdctrl0[i]; 
            assign s_rmcsr[i][MCSR_RSTPOINT]= s_rstpoint[i]; 
            assign s_rmcsr[i][MCSR_HARTID]  = 32'b0;
            assign s_rmcsr[i][MCSR_ISA]     = 32'h40001104; // 32bit - IMC

            assign s_wmstatus[i]            = s_wmcsr[i][MCSR_STATUS];
            assign s_wminstret[i]           = s_wmcsr[i][MCSR_INSTRET];
            assign s_wminstreth[i]          = s_wmcsr[i][MCSR_INSTRETH];
            assign s_wmcycle[i]             = s_wmcsr[i][MCSR_CYCLE];
            assign s_wmcycleh[i]            = s_wmcsr[i][MCSR_CYCLEH];
            assign s_wmscratch[i]           = s_wmcsr[i][MCSR_SCRATCH];
            assign s_wmie[i]                = s_wmcsr[i][MCSR_IE][12:0];
            assign s_wmtvec[i]              = s_wmcsr[i][MCSR_TVEC];
            assign s_wmepc[i]               = s_wmcsr[i][MCSR_EPC];
            assign s_wmcause[i]             = s_wmcsr[i][MCSR_CAUSE];
            assign s_wmtval[i]              = s_wmcsr[i][MCSR_TVAL]; 
            assign s_wmip[i]                = s_wmcsr[i][MCSR_IP][12:0]; 
            assign s_wmhrdctrl0[i]          = s_wmcsr[i][MCSR_HRDCTRL0]; 
            assign s_wrstpoint[i]           = s_wmcsr[i][MCSR_RSTPOINT];

            csr_executor m_csr_executor(
                .s_resetn_i(s_resetn_i[i]),
                .s_boot_add_i(s_boot_add_i),
                .s_stall_i(s_stall_i[i]),
                .s_flush_i(s_flush_i[i]),
                .s_int_meip_i(s_int_meip_i),
                .s_int_mtip_i(s_int_mtip_i),
                .s_int_msip_i(s_int_msip_i),
`ifdef PROTECTED
                .s_int_uce_i(s_int_uce_i),
`endif
                .s_rstpp_i(s_rstpp_i[i]),
                .s_interrupted_i(s_interrupted_i[i]),
                .s_exception_i(s_exception_i[i]),
                .s_exc_code_i(s_exc_code_i[i]),
                .s_newrst_point_i(s_newrst_point_i[i]),
                .s_valid_instr_i(s_valid_instr_i[i]),
                .s_ictrl_i(s_ictrl_i[i]),
                .s_function_i(s_function_i[i]),
                .s_payload_i(s_payload_i[i]),
                .s_mcsr_i(s_rmcsr[i]),
                .s_val_i(s_val_i[i]),
                .s_int_trap_o(s_int_trap[i]),
                .s_exc_trap_o(s_exc_trap[i]),
                .s_int_pending_o(s_int_pending[i]),
                .s_mret_o(s_mret[i]),
                .s_csr_r_val_o(s_csr_r_val[i]),
                .s_mcsr_o(s_wmcsr[i])
            );           
        end       
    endgenerate
endmodule
