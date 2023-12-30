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
    input logic s_clk_i[PROT_3REP],                 //clock signal
    input logic s_resetn_i[PROT_3REP],              //reset signal
    input logic[31:0] s_boot_add_i,                 //boot address

    input logic s_stall_i[PROT_3REP],               //stall of MA stage
    input logic s_flush_i[PROT_3REP],               //flush of MA stage

    input logic s_int_meip_i,                       //external interrupt
    input logic s_int_mtip_i,                       //timer interrupt
    input logic s_int_msip_i,                       //software interrupt
    input logic s_int_uce_i,                        //uncorrectable error in register-file
    input logic s_int_lcer_i[PROT_3REP],            //correctable error on load interface
    input logic s_nmi_luce_i[PROT_3REP],            //uncorrectable error on load interface
`ifdef PROTECTED
    output logic[1:0] s_acm_settings_o,             //acm settings
`endif
    input logic s_hresp_i[PROT_3REP],               //registered hresp signal
    input imiscon s_imiscon_i[PROT_3REP],           //instruction misconduct indicator
    input logic s_rstpp_i[PROT_3REP],               //pipeline reset
    input logic[31:0] s_newrst_point_i[PROT_3REP],  //new reset-point address
    input logic s_interrupted_i[PROT_3REP],         //interrupt approval

    input ictrl s_ictrl_i[PROT_3REP],               //instruction control indicator
    input f_part s_function_i[PROT_3REP],           //instruction function
    input logic[11:0] s_payload_i[PROT_3REP],       //instruction payload information
    input logic[31:0] s_val_i[PROT_3REP],           //result from EX stage
    output logic[31:0] s_csr_r_o[PROT_3REP],        //value read from requested CSR
    output logic[31:0] s_exc_trap_o[PROT_3REP],     //exception trap-handler address
    output logic[31:0] s_int_trap_o[PROT_3REP],     //interrupt trap-handler address
    output logic[31:0] s_rst_point_o[PROT_3REP],    //reset-point address
    output logic[31:0] s_mepc_o[PROT_3REP],         //address saved in MEPC CSR
    output logic s_treturn_o[PROT_3REP],            //return from trap-handler
    output logic s_int_pending_o[PROT_3REP],        //pending interrupt
    output logic s_exception_o[PROT_3REP],          //exception
    output logic s_ibus_rst_en_o[PROT_3REP],        //enables the repetition of transfer that resulted in a instruction bus error
    output logic s_dbus_rst_en_o[PROT_3REP],        //enables the repetition of transfer that resulted in a data bus error
    output logic s_pred_disable_o,                  //disable any predictions
    output logic s_hrdmax_rst_o                     //max consecutive pipeline restarts reached
);

    logic[31:0]s_rmcsr[PROT_3REP][0:MAX_MCSR];
    logic[31:0]s_wmcsr[PROT_3REP][0:MAX_MCSR];
    logic[31:0] s_csr_r_val[PROT_3REP], s_exc_trap[PROT_3REP], s_int_trap[PROT_3REP];
    logic s_int_pending[PROT_3REP], s_exception[PROT_3REP], s_mret[PROT_3REP];
    logic[14:0]s_wmie[PROT_3REP], s_rmie[PROT_3REP], s_wmip[PROT_3REP], s_rmip[PROT_3REP],s_mie[PROT_3REP], s_mip[PROT_3REP];
    logic[31:0]s_wmstatus[PROT_3REP],s_wmscratch[PROT_3REP],s_wminstret[PROT_3REP],s_wminstreth[PROT_3REP],s_wmcycle[PROT_3REP],s_wmcycleh[PROT_3REP],
                s_wmtvec[PROT_3REP],s_wmepc[PROT_3REP],s_wmcause[PROT_3REP],s_wmtval[PROT_3REP],s_wmhrdctrl0[PROT_3REP], s_wrstpoint[PROT_3REP];
    logic[31:0]s_rmstatus[PROT_3REP],s_rmscratch[PROT_3REP],s_rminstret[PROT_3REP],s_rminstreth[PROT_3REP],s_rmcycle[PROT_3REP],s_rmcycleh[PROT_3REP],
                s_rmtvec[PROT_3REP],s_rmepc[PROT_3REP],s_rmcause[PROT_3REP],s_rmtval[PROT_3REP],s_rmhrdctrl0[PROT_3REP], s_rrstpoint[PROT_3REP], 
                s_mstatus[PROT_3REP],s_mscratch[PROT_3REP],s_minstret[PROT_3REP],s_minstreth[PROT_3REP],s_mcycle[PROT_3REP],s_mcycleh[PROT_3REP],
                s_mtvec[PROT_3REP],s_mepc[PROT_3REP],s_mcause[PROT_3REP],s_mtval[PROT_3REP],s_mhrdctrl0[PROT_3REP], s_rstpoint[PROT_3REP];
    logic s_clk_prw[PROT_3REP], s_resetn_prw[PROT_3REP];
`ifdef PROTECTED_WITH_IFP
    logic[31:0]s_wmaddrerr[PROT_3REP],s_rmaddrerr[PROT_3REP], s_maddrerr[PROT_3REP];
`endif

    //CSR registers
    seu_regs #(.LABEL("CSR_MSTATUS"),.N(PROT_3REP))m_mstatus (.s_c_i(s_clk_prw),.s_d_i(s_wmstatus),.s_d_o(s_rmstatus));
    seu_regs #(.LABEL("CSR_MINSTRET"),.N(PROT_3REP))m_minstret (.s_c_i(s_clk_prw),.s_d_i(s_wminstret),.s_d_o(s_rminstret));
    seu_regs #(.LABEL("CSR_MINSTRETH"),.N(PROT_3REP))m_minstreth (.s_c_i(s_clk_prw),.s_d_i(s_wminstreth),.s_d_o(s_rminstreth));
    seu_regs #(.LABEL("CSR_MCYCLE"),.N(PROT_3REP))m_mcycle (.s_c_i(s_clk_prw),.s_d_i(s_wmcycle),.s_d_o(s_rmcycle));
    seu_regs #(.LABEL("CSR_MCYCLEH"),.N(PROT_3REP))m_mcycleh (.s_c_i(s_clk_prw),.s_d_i(s_wmcycleh),.s_d_o(s_rmcycleh));
    seu_regs #(.LABEL("CSR_MSCRATCH"),.N(PROT_3REP))m_mscratch (.s_c_i(s_clk_prw),.s_d_i(s_wmscratch),.s_d_o(s_rmscratch));
    seu_regs #(.LABEL("CSR_MTVEC"),.N(PROT_3REP))m_mtvec (.s_c_i(s_clk_prw),.s_d_i(s_wmtvec),.s_d_o(s_rmtvec));
    seu_regs #(.LABEL("CSR_MEPC"),.N(PROT_3REP))m_mepc (.s_c_i(s_clk_prw),.s_d_i(s_wmepc),.s_d_o(s_rmepc));
    seu_regs #(.LABEL("CSR_MCAUSE"),.N(PROT_3REP))m_mcause (.s_c_i(s_clk_prw),.s_d_i(s_wmcause),.s_d_o(s_rmcause));
    seu_regs #(.LABEL("CSR_MTVAL"),.N(PROT_3REP))m_mtval (.s_c_i(s_clk_prw),.s_d_i(s_wmtval),.s_d_o(s_rmtval));
    seu_regs #(.LABEL("CSR_MHRDCTRL0"),.N(PROT_3REP))m_mhrdctrl0 (.s_c_i(s_clk_prw),.s_d_i(s_wmhrdctrl0),.s_d_o(s_rmhrdctrl0));
    seu_regs #(.LABEL("CSR_MIE"),.W(15),.N(PROT_3REP)) m_mie (.s_c_i(s_clk_prw),.s_d_i(s_wmie),.s_d_o(s_rmie));
    seu_regs #(.LABEL("CSR_MIP"),.W(15),.N(PROT_3REP)) m_mip (.s_c_i(s_clk_prw),.s_d_i(s_wmip),.s_d_o(s_rmip));
`ifdef PROTECTED_WITH_IFP
    seu_regs #(.LABEL("CSR_MADDRERR"),.N(PROT_3REP))m_maddrerr (.s_c_i(s_clk_prw),.s_d_i(s_wmaddrerr),.s_d_o(s_rmaddrerr));
`endif
    seu_regs #(.LABEL("RSTPOINT"),.N(PROT_3REP)) m_rstpoint (.s_c_i(s_clk_prw),.s_d_i(s_wrstpoint),.s_d_o(s_rrstpoint));

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
    tmr_comb #(.W(15)) m_tmr_mie (.s_d_i(s_rmie),.s_d_o(s_mie));
    tmr_comb #(.W(15)) m_tmr_mip (.s_d_i(s_rmip),.s_d_o(s_mip));
`ifdef PROTECTED_WITH_IFP
    tmr_comb m_tmr_maddrerr (.s_d_i(s_rmaddrerr),.s_d_o(s_maddrerr));
`endif
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
    assign s_exception_o    = s_exception;
    assign s_csr_r_o        = s_csr_r_val;  
    assign s_treturn_o      = s_mret;
    assign s_mepc_o         = s_mepc;
    assign s_exc_trap_o     = s_exc_trap;
    assign s_int_trap_o     = s_int_trap;  
    assign s_rst_point_o    = s_rstpoint;

    genvar i;
    generate
        for (i = 0; i<PROT_3REP ;i++ ) begin : csr_replicator
            assign s_clk_prw[i]    = s_clk_i[i];
            assign s_resetn_prw[i] = s_resetn_i[i];

            assign s_rmcsr[i][MCSR_STATUS]  = s_mstatus[i];
            assign s_rmcsr[i][MCSR_INSTRET] = s_minstret[i];
            assign s_rmcsr[i][MCSR_INSTRETH]= s_minstreth[i];
            assign s_rmcsr[i][MCSR_CYCLE]   = s_mcycle[i];
            assign s_rmcsr[i][MCSR_CYCLEH]  = s_mcycleh[i];
            assign s_rmcsr[i][MCSR_SCRATCH] = s_mscratch[i];
            assign s_rmcsr[i][MCSR_IE]      = {17'h0,s_mie[i]};
            assign s_rmcsr[i][MCSR_TVEC]    = s_mtvec[i];
            assign s_rmcsr[i][MCSR_EPC]     = s_mepc[i];
            assign s_rmcsr[i][MCSR_CAUSE]   = s_mcause[i];
            assign s_rmcsr[i][MCSR_TVAL]    = s_mtval[i]; 
            assign s_rmcsr[i][MCSR_IP]      = {17'h0,s_mip[i]}; 
            assign s_rmcsr[i][MCSR_HRDCTRL0]= s_mhrdctrl0[i]; 
            assign s_rmcsr[i][MCSR_HARTID]  = 32'b0;
            assign s_rmcsr[i][MCSR_ISA]     = 32'h40001104; // 32bit - IMC

`ifdef PROTECTED_WITH_IFP
            assign s_rmcsr[i][MCSR_ADDRERR] = s_maddrerr[i];
            assign s_wmaddrerr[i]           = s_wmcsr[i][MCSR_ADDRERR];
`endif
            assign s_wmstatus[i]            = s_wmcsr[i][MCSR_STATUS];
            assign s_wminstret[i]           = s_wmcsr[i][MCSR_INSTRET];
            assign s_wminstreth[i]          = s_wmcsr[i][MCSR_INSTRETH];
            assign s_wmcycle[i]             = s_wmcsr[i][MCSR_CYCLE];
            assign s_wmcycleh[i]            = s_wmcsr[i][MCSR_CYCLEH];
            assign s_wmscratch[i]           = s_wmcsr[i][MCSR_SCRATCH];
            assign s_wmie[i]                = s_wmcsr[i][MCSR_IE][14:0];
            assign s_wmtvec[i]              = s_wmcsr[i][MCSR_TVEC];
            assign s_wmepc[i]               = s_wmcsr[i][MCSR_EPC];
            assign s_wmcause[i]             = s_wmcsr[i][MCSR_CAUSE];
            assign s_wmtval[i]              = s_wmcsr[i][MCSR_TVAL]; 
            assign s_wmip[i]                = s_wmcsr[i][MCSR_IP][14:0]; 
            assign s_wmhrdctrl0[i]          = s_wmcsr[i][MCSR_HRDCTRL0];

            assign s_ibus_rst_en_o[i]       = s_mhrdctrl0[i][7] & ~s_mhrdctrl0[i][21];
            assign s_dbus_rst_en_o[i]       = s_mhrdctrl0[i][7] & ~s_mhrdctrl0[i][22];

            csr_executor m_csr_executor(
                .s_resetn_i(s_resetn_i[i]),
                .s_boot_add_i(s_boot_add_i),
                .s_stall_i(s_stall_i[i]),
                .s_flush_i(s_flush_i[i]),
                .s_int_meip_i(s_int_meip_i),
                .s_int_mtip_i(s_int_mtip_i),
                .s_int_msip_i(s_int_msip_i),
                .s_int_uce_i(s_int_uce_i),
                .s_int_lcer_i(s_int_lcer_i[i]),
                .s_nmi_luce_i(s_nmi_luce_i[i]),
                .s_hresp_i(s_hresp_i[i]),
                .s_imiscon_i(s_imiscon_i[i]),
                .s_rstpp_i(s_rstpp_i[i]),
                .s_interrupted_i(s_interrupted_i[i]),
                .s_newrst_point_i(s_newrst_point_i[i]),
                .s_ictrl_i(s_ictrl_i[i]),
                .s_function_i(s_function_i[i]),
                .s_payload_i(s_payload_i[i]),
                .s_mcsr_i(s_rmcsr[i]),
                .s_val_i(s_val_i[i]),
                .s_rstpoint_i(s_rstpoint[i]),
                .s_rstpoint_o(s_wrstpoint[i]),
                .s_int_trap_o(s_int_trap[i]),
                .s_exc_trap_o(s_exc_trap[i]),
                .s_int_pending_o(s_int_pending[i]),
                .s_exception_o(s_exception[i]),
                .s_mret_o(s_mret[i]),
                .s_csr_r_val_o(s_csr_r_val[i]),
                .s_mcsr_o(s_wmcsr[i])
            );           
        end       
    endgenerate
endmodule
