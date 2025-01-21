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

    input logic s_stall_i[PROT_3REP],               //stall of MA stage
    input logic s_flush_i[PROT_3REP],               //flush of MA stage

    input logic s_int_meip_i,                       //external interrupt
    input logic s_int_mtip_i,                       //timer interrupt
    input logic s_int_msip_i,                       //software interrupt
    input logic s_int_lcer_i[PROT_3REP],            //correctable error on load interface
    input logic s_int_fcer_i,                       //fetch correctable error
    input logic s_nmi_luce_i[PROT_3REP],            //uncorrectable error on load interface

    input logic s_hresp_i[PROT_3REP],               //registered hresp signal
    input imiscon s_imiscon_i[PROT_3REP],           //instruction misconduct indicator
    input logic s_rstpp_i[PROT_3REP],               //pipeline reset
    input logic s_interrupted_i[PROT_3REP],         //interrupt approval

    input ictrl s_ictrl_i[PROT_3REP],               //instruction control indicator
    input f_part s_function_i[PROT_3REP],           //instruction function
    input logic[11:0] s_payload_i[PROT_3REP],       //instruction payload information
    input logic[31:0] s_val_i[PROT_3REP],           //result from EX stage
    input logic[31:0] s_pc_i[PROT_3REP],            //program counter address
    output logic[31:0] s_csr_r_o[PROT_3REP],        //value read from requested CSR
    output logic[31:0] s_exc_trap_o[PROT_3REP],     //exception trap-handler address
    output logic[31:0] s_int_trap_o[PROT_3REP],     //interrupt trap-handler address
    output logic[31:0] s_mepc_o[PROT_3REP],         //address saved in MEPC CSR
    output logic s_treturn_o[PROT_3REP],            //return from trap-handler
    output logic s_int_pending_o[PROT_3REP],        //pending interrupt
    output logic s_exception_o[PROT_3REP],          //exception
    output logic s_ibus_rst_en_o[PROT_3REP],        //enables the repetition of transfer that resulted in a instruction bus error
    output logic s_dbus_rst_en_o[PROT_3REP],        //enables the repetition of transfer that resulted in a data bus error
    output logic s_initialize_o[PROT_3REP],         //core has been reseted, jump to the program counter
    output logic[31:0] s_mhrdctrl0_o[PROT_3REP]     //settings
);
    logic[31:0] s_mcsr_r_val[PROT_3REP], s_read_val[PROT_3REP], s_csr_w_val[PROT_3REP], s_int_vectored[PROT_3REP], s_exc_trap[PROT_3REP], s_int_trap[PROT_3REP];
    logic s_machine_csr[PROT_3REP], s_write_machine[PROT_3REP], s_csr_op[PROT_3REP], s_csr_fun[PROT_3REP], s_uadd_00[PROT_3REP], s_uadd_01[PROT_3REP], s_uadd_10[PROT_3REP], s_mret[PROT_3REP], s_exc_active[PROT_3REP], s_int_exc[PROT_3REP], 
          s_mtval_zero[PROT_3REP], s_interrupt[PROT_3REP], s_int_pending[PROT_3REP], s_commit[PROT_3REP], s_exception[PROT_3REP], s_execute[PROT_3REP], s_max_reached[PROT_3REP], s_transfer_misaligned[PROT_3REP], 
          s_pma_violation[PROT_3REP], s_csr_refresh[PROT_3REP], s_livelock[PROT_3REP], s_livelock_int[PROT_3REP], s_pc_uce[PROT_3REP];
    logic[63:0] s_mcycle_counter[PROT_3REP], s_minstret_counter[PROT_3REP];
    logic[4:0] s_int_code[PROT_3REP], s_csr_add[PROT_3REP], s_exc_code[PROT_3REP];
    logic[1:0] s_nmi[PROT_3REP];
    exception s_exceptions[PROT_3REP];

    logic[7:0] s_wmstatus[PROT_3REP], s_rmstatus[PROT_3REP], s_mstatus[PROT_3REP];
    logic[14:0]s_wmie[PROT_3REP], s_rmie[PROT_3REP], s_wmip[PROT_3REP], s_rmip[PROT_3REP],s_mie[PROT_3REP], s_mip[PROT_3REP];
    logic[31:0]s_wmscratch[PROT_3REP],s_wminstret[PROT_3REP],s_wminstreth[PROT_3REP],s_wmcycle[PROT_3REP],s_wmcycleh[PROT_3REP],
                s_wmtvec[PROT_3REP],s_wmepc[PROT_3REP],s_wmcause[PROT_3REP],s_wmtval[PROT_3REP],s_wmhrdctrl0[PROT_3REP],
                s_rmscratch[PROT_3REP],s_rminstret[PROT_3REP],s_rminstreth[PROT_3REP],s_rmcycle[PROT_3REP],s_rmcycleh[PROT_3REP],
                s_rmtvec[PROT_3REP],s_rmepc[PROT_3REP],s_rmcause[PROT_3REP],s_rmtval[PROT_3REP],s_rmhrdctrl0[PROT_3REP], 
                s_mscratch[PROT_3REP],s_minstret[PROT_3REP],s_minstreth[PROT_3REP],s_mcycle[PROT_3REP],s_mcycleh[PROT_3REP],
                s_mtvec[PROT_3REP],s_mepc[PROT_3REP],s_mcause[PROT_3REP],s_mtval[PROT_3REP],s_mhrdctrl0[PROT_3REP];
    logic s_mstatus_we[PROT_3REP], s_minstret_we[PROT_3REP], s_minstreth_we[PROT_3REP], s_mcycle_we[PROT_3REP], s_mcycleh_we[PROT_3REP],
          s_mscratch_we[PROT_3REP], s_mtvec_we[PROT_3REP], s_mepc_we[PROT_3REP], s_mcause_we[PROT_3REP], s_mtval_we[PROT_3REP], s_mie_we[PROT_3REP], s_mip_we[PROT_3REP], s_mhrdctrl0_we[PROT_3REP];
`ifdef PROT_INTF
    logic s_mcsr_addr_free[PROT_3REP], s_maddrerr_we[PROT_3REP];
    logic[31:0]s_wmaddrerr[PROT_3REP],s_rmaddrerr[PROT_3REP], s_maddrerr[PROT_3REP];
`endif

    //CSR registers
    seu_ff_we_rst #(.LABEL("CSR_MSTATUS"),.W(8),.N(PROT_3REP)) m_mstatus (.s_c_i(s_clk_i),.s_r_i(s_resetn_i),.s_we_i(s_mstatus_we),.s_d_i(s_wmstatus),.s_q_o(s_rmstatus));
    seu_ff_we_rst #(.LABEL("CSR_MINSTRET"),.N(PROT_3REP)) m_minstret (.s_c_i(s_clk_i),.s_r_i(s_resetn_i),.s_we_i(s_minstret_we),.s_d_i(s_wminstret),.s_q_o(s_rminstret));
    seu_ff_we_rst #(.LABEL("CSR_MINSTRETH"),.N(PROT_3REP)) m_minstreth (.s_c_i(s_clk_i),.s_r_i(s_resetn_i),.s_we_i(s_minstreth_we),.s_d_i(s_wminstreth),.s_q_o(s_rminstreth));
    seu_ff_we_rst #(.LABEL("CSR_MCYCLE"),.N(PROT_3REP)) m_mcycle (.s_c_i(s_clk_i),.s_r_i(s_resetn_i),.s_we_i(s_mcycle_we),.s_d_i(s_wmcycle),.s_q_o(s_rmcycle));
    seu_ff_we_rst #(.LABEL("CSR_MCYCLEH"),.N(PROT_3REP)) m_mcycleh (.s_c_i(s_clk_i),.s_r_i(s_resetn_i),.s_we_i(s_mcycleh_we),.s_d_i(s_wmcycleh),.s_q_o(s_rmcycleh));
    seu_ff_we_rst #(.LABEL("CSR_MSCRATCH"),.N(PROT_3REP)) m_mscratch (.s_c_i(s_clk_i),.s_r_i(s_resetn_i),.s_we_i(s_mscratch_we),.s_d_i(s_wmscratch),.s_q_o(s_rmscratch));
    seu_ff_we_rst #(.LABEL("CSR_MTVEC"),.N(PROT_3REP)) m_mtvec (.s_c_i(s_clk_i),.s_r_i(s_resetn_i),.s_we_i(s_mtvec_we),.s_d_i(s_wmtvec),.s_q_o(s_rmtvec));
    seu_ff_we_rst #(.LABEL("CSR_MEPC"),.N(PROT_3REP)) m_mepc (.s_c_i(s_clk_i),.s_r_i(s_resetn_i),.s_we_i(s_mepc_we),.s_d_i(s_wmepc),.s_q_o(s_rmepc));
    seu_ff_we_rst #(.LABEL("CSR_MCAUSE"),.N(PROT_3REP)) m_mcause (.s_c_i(s_clk_i),.s_r_i(s_resetn_i),.s_we_i(s_mcause_we),.s_d_i(s_wmcause),.s_q_o(s_rmcause));
    seu_ff_we_rst #(.LABEL("CSR_MTVAL"),.N(PROT_3REP)) m_mtval (.s_c_i(s_clk_i),.s_r_i(s_resetn_i),.s_we_i(s_mtval_we),.s_d_i(s_wmtval),.s_q_o(s_rmtval));
    seu_ff_we_rst #(.LABEL("CSR_MIE"),.W(15),.N(PROT_3REP)) m_mie (.s_c_i(s_clk_i),.s_r_i(s_resetn_i),.s_we_i(s_mie_we),.s_d_i(s_wmie),.s_q_o(s_rmie));
    seu_ff_we_rst #(.LABEL("CSR_MIP"),.W(15),.N(PROT_3REP)) m_mip (.s_c_i(s_clk_i),.s_r_i(s_resetn_i),.s_we_i(s_mip_we),.s_d_i(s_wmip),.s_q_o(s_rmip));
    seu_ff_we_rst #(.LABEL("CSR_MHRDCTRL0"),.N(PROT_3REP),.RSTVAL(32'h14A2)) m_mhrdctrl0 (.s_c_i(s_clk_i),.s_r_i(s_resetn_i),.s_we_i(s_mhrdctrl0_we),.s_d_i(s_wmhrdctrl0),.s_q_o(s_rmhrdctrl0));
`ifdef PROT_INTF
    seu_ff_we_rst #(.LABEL("CSR_MADDRERR"),.N(PROT_3REP)) m_maddrerr (.s_c_i(s_clk_i),.s_r_i(s_resetn_i),.s_we_i(s_maddrerr_we),.s_d_i(s_wmaddrerr),.s_q_o(s_rmaddrerr));
`endif
`ifdef PROT_PIPE
    //Triple-Modular-Redundancy
    tmr_comb #(.W(8))m_tmr_mstatus (.s_d_i(s_rmstatus),.s_d_o(s_mstatus));
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
    tmr_comb #(.W(15)) m_tmr_mie (.s_d_i(s_rmie),.s_d_o(s_mie));
    tmr_comb #(.W(15)) m_tmr_mip (.s_d_i(s_rmip),.s_d_o(s_mip));
    tmr_comb m_tmr_maddrerr (.s_d_i(s_rmaddrerr),.s_d_o(s_maddrerr));
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
    assign s_mie        = s_rmie;
    assign s_mip        = s_rmip;
`ifdef PROT_INTF
    assign s_maddrerr   = s_rmaddrerr;
`endif
`endif

    assign s_mhrdctrl0_o    = s_mhrdctrl0;
    assign s_int_pending_o  = s_int_pending; 
    assign s_exception_o    = s_exception;
    assign s_csr_r_o        = s_read_val;  
    assign s_treturn_o      = s_mret;
    assign s_mepc_o         = s_mepc;
    assign s_exc_trap_o     = s_exc_trap;
    assign s_int_trap_o     = s_int_trap;  

    genvar i;
    generate
        for (i = 0; i<PROT_3REP ;i++ ) begin : csr_replicator
            assign s_initialize_o[i]    = !s_mhrdctrl0[i][31];
            assign s_ibus_rst_en_o[i]   = s_mhrdctrl0[i][7] & ~s_mhrdctrl0[i][21];
            assign s_dbus_rst_en_o[i]   = s_mhrdctrl0[i][7] & ~s_mhrdctrl0[i][22];            

            //Gathering exception information
            assign s_pma_violation[i]              = s_imiscon_i[i] == IMISCON_PMAV;    
            assign s_transfer_misaligned[i]        = ((|s_val_i[i][1:0] & s_function_i[i][1]) | (s_val_i[i][0] & s_function_i[i][0]));
            assign s_exceptions[i][EXC_LSADD_MISS] = s_ictrl_i[i][ICTRL_UNIT_LSU] & s_transfer_misaligned[i];
            assign s_exceptions[i][EXC_ECALL_M]    = s_ictrl_i[i][ICTRL_UNIT_CSR] & s_csr_fun[i] & (s_payload_i[i][10:9] == CSR_FUN_ECALL);
            assign s_exceptions[i][EXC_EBREAK_M]   = s_ictrl_i[i][ICTRL_UNIT_CSR] & s_csr_fun[i] & (s_payload_i[i][10:9] == CSR_FUN_EBREAK);
            assign s_exceptions[i][EXC_LSACCESS]   = s_ictrl_i[i][ICTRL_UNIT_LSU] & (s_hresp_i[i] | s_pma_violation[i]);
            assign s_exceptions[i][EXC_IACCESS]    = (s_imiscon_i[i] == IMISCON_FERR) | (s_pma_violation[i] & ~s_ictrl_i[i][ICTRL_UNIT_LSU]);
            assign s_exceptions[i][EXC_ILLEGALI]   = s_imiscon_i[i] == IMISCON_ILLE;
            assign s_exception[i]                  = |s_exceptions[i];

            //Prioritization of exceptions and assignment of exception codes
            assign s_exc_code[i]   = (s_exceptions[i][EXC_IACCESS]) ? EXC_IACCES_VAL :
                                     (s_exceptions[i][EXC_ILLEGALI]) ? EXC_ILLEGALI_VAL :
                                     (s_exceptions[i][EXC_ECALL_M]) ? EXC_ECALL_M_VAL :
                                     (s_exceptions[i][EXC_EBREAK_M]) ? EXC_EBREAK_M_VAL :
                                     (s_exceptions[i][EXC_LSADD_MISS]) ? (s_function_i[i][3] ? EXC_SADD_MISS_VAL : EXC_LADD_MISS_VAL) :
                                     /*s_exceptions[EXC_LSACCESS]->*/ (s_function_i[i][3] ? EXC_SACCESS_VAL : EXC_LACCESS_VAL);

            //CSR instruction processing
            assign s_csr_add[i]        = s_payload_i[i][4:0];
            assign s_machine_csr[i]    = s_payload_i[i][6:5] == 2'b11;
            assign s_uadd_00[i]        = s_payload_i[i][8:7] == 2'b00;
            assign s_uadd_01[i]        = s_payload_i[i][8:7] == 2'b01;
            assign s_uadd_10[i]        = s_payload_i[i][8:7] == 2'b10;
            assign s_csr_fun[i]        = (s_function_i[i][2:0] == 3'b0) & s_ictrl_i[i][ICTRL_UNIT_CSR];
            assign s_csr_op[i]         = |s_function_i[i][1:0] & s_ictrl_i[i][ICTRL_UNIT_CSR] & ~s_flush_i[i];
            assign s_write_machine[i]  = s_csr_op[i] & s_machine_csr[i];
            assign s_mret[i]           = s_uadd_00[i] & s_machine_csr[i] & s_csr_fun[i] & (s_payload_i[i][10:9] == CSR_FUN_RET) & ~s_flush_i[i];
            assign s_execute[i]        = ((s_ictrl_i[i] != 7'b0) | s_exceptions[i][EXC_IACCESS] | s_exceptions[i][EXC_ILLEGALI]) & ~s_rstpp_i[i];
            assign s_commit[i]         = (s_ictrl_i[i] != 7'b0) & ~s_stall_i[i] & ~s_flush_i[i];

            //Interrupt and exception evaluation
`ifdef PROT_INTF
            assign s_nmi[i][0]         = s_nmi_luce_i[i];
            assign s_nmi[i][1]         = (s_imiscon_i[i] == IMISCON_FUCE);
`else
            assign s_nmi[i][0]         = 1'b0; //Load UCE cannot happen
            assign s_nmi[i][1]         = 1'b0; //Fetch UCE cannot happen
`endif

            assign s_interrupt[i]      = |(s_mie[i] & s_mip[i]) & s_mstatus[i][3];
            assign s_exc_active[i]     = s_exception[i] & s_execute[i] & ~s_interrupted_i[i];
            assign s_int_exc[i]        = s_interrupted_i[i] | (s_exception[i] & s_execute[i]);
            assign s_int_pending[i]    = s_interrupt[i] | (|s_nmi[i]);
            assign s_mtval_zero[i]     = (s_exc_code[i] != EXC_MISALIGI_VAL) & (s_exc_code[i] != EXC_LADD_MISS_VAL) & (s_exc_code[i] != EXC_SADD_MISS_VAL) & s_exc_active[i];
            assign s_int_code[i]       = (s_nmi[i][0]) ? INT_LUCE_VAL : 
                                         (s_nmi[i][1]) ? INT_FUCE_VAL :
                                         (s_mie[i][11] & s_mip[i][11]) ? INT_MEI_VAL : 
                                         (s_mie[i][3]  & s_mip[i][3])  ? INT_MSI_VAL : 
                                         (s_mie[i][7]  & s_mip[i][7])  ? INT_MTI_VAL : 
                                         (s_mie[i][14] & s_mip[i][14]) ? INT_LCER_VAL : 
                                         (s_mie[i][13] & s_mip[i][13]) ? INT_FCER_VAL : INT_UCE_VAL;
            assign s_exc_trap[i]       = {s_mtvec[i][31:2],2'b0};
            assign s_int_trap[i]       = (s_mtvec[i][0]) ? s_int_vectored[i] : s_exc_trap[i];

            fast_adder m_int_vector(.s_base_val_i(s_exc_trap[i]),.s_add_val_i({9'b0,s_int_code[i],2'b0} ),.s_val_o(s_int_vectored[i]));

            //Machine counters
            fast_adder #(.WIDTH(64)) m_mcycle_cntr(.s_base_val_i({s_mcycleh[i],s_mcycle[i]}),.s_add_val_i(32'd1),.s_val_o(s_mcycle_counter[i]));
            fast_adder #(.WIDTH(64)) m_mistret_cntr(.s_base_val_i({s_minstreth[i],s_minstret[i]}),.s_add_val_i(32'd1),.s_val_o(s_minstret_counter[i]));

            //Read of CSR registers
            always_comb begin : machine_csr_read_value
                case (s_csr_add[i])
                    MCSR_STATUS:     s_mcsr_r_val[i] = {24'b11000,s_rmstatus[i]};
                    MCSR_IE:         s_mcsr_r_val[i] = {17'b0,s_rmie[i]};
                    MCSR_TVEC:       s_mcsr_r_val[i] = s_rmtvec[i];
                    MCSR_EPC:        s_mcsr_r_val[i] = s_rmepc[i];
                    MCSR_CAUSE:      s_mcsr_r_val[i] = s_rmcause[i];
                    MCSR_TVAL:       s_mcsr_r_val[i] = s_rmtval[i];
                    MCSR_IP:         s_mcsr_r_val[i] = {17'b0,s_rmip[i]};
                    MCSR_CYCLE:      s_mcsr_r_val[i] = s_rmcycle[i];
                    MCSR_CYCLEH:     s_mcsr_r_val[i] = s_rmcycleh[i];
                    MCSR_INSTRET:    s_mcsr_r_val[i] = s_rminstret[i];
                    MCSR_INSTRETH:   s_mcsr_r_val[i] = s_rminstreth[i];
                    MCSR_SCRATCH:    s_mcsr_r_val[i] = s_rmscratch[i];
                    MCSR_HARTID:     s_mcsr_r_val[i] = 32'b0;
                    MCSR_HRDCTRL0:   s_mcsr_r_val[i] = s_rmhrdctrl0[i];
                    MCSR_ISA:        s_mcsr_r_val[i] = 32'h40001104; // 32bit - IMC
`ifdef PROT_INTF
                    MCSR_ADDRERR:    s_mcsr_r_val[i] = s_rmaddrerr[i];
`endif
                    default:         s_mcsr_r_val[i] = 32'b0;
                endcase   
            end   

            //Only M-mode is present
            assign s_read_val[i]  = s_mcsr_r_val[i];

            //Select new value for selected CSR register
            always_comb begin : csr_modify_value
                case (s_function_i[i][1:0])
                    CSR_RW:     s_csr_w_val[i] = s_val_i[i];
                    CSR_RS:     s_csr_w_val[i] = s_val_i[i] | s_read_val[i];
                    CSR_RC:     s_csr_w_val[i] = ~s_val_i[i] & s_read_val[i];
                    default:    s_csr_w_val[i] = s_read_val[i];
                endcase
            end
                                                                     
        assign s_csr_refresh[i] = 
`ifdef PROT_PIPE
                                  (s_mhrdctrl0[i][13:12] == 2'b00) ? 1'b1 :               //every cycle
                                  (s_mhrdctrl0[i][13:12] == 2'b01) ? !(|s_mcycle[i][7:0]) :  //every 2^8 cycles
                                  (s_mhrdctrl0[i][13:12] == 2'b10) ? !(|s_mcycle[i][15:0]) : //every 2^16 cycles
`endif                                  
                                  1'b0; //never

            /*  Parallel update of individual CSR registers */

            assign s_mstatus_we[i] = s_write_machine[i] || s_int_exc[i] || s_mret[i] || s_csr_refresh[i];
            always_comb begin : mstatus_writer
                s_wmstatus[i][7]    = s_mstatus[i][7];
                s_wmstatus[i][6:4]  = 3'b0;
                s_wmstatus[i][3]    = s_mstatus[i][3];
                s_wmstatus[i][2:0]  = 3'b0;
                if(s_int_exc[i])begin
                    s_wmstatus[i][7]    = s_mstatus[i][3];
                    s_wmstatus[i][3]    = 1'b0;
                end else if(s_mret[i])begin
                    s_wmstatus[i][7]    = 1'b1;
                    s_wmstatus[i][3]    = s_mstatus[i][7];
                end else if (s_write_machine[i] & (s_csr_add[i] == MCSR_STATUS) & s_uadd_00[i]) begin
                    s_wmstatus[i][7]    = s_csr_w_val[i][7];   //MPIE
                    s_wmstatus[i][3]    = s_csr_w_val[i][3];   //MIE
                end
            end

            assign s_mscratch_we[i] = s_write_machine[i] || s_csr_refresh[i];
            always_comb begin : mscratch_writer
                s_wmscratch[i]  = s_mscratch[i];
                if (s_write_machine[i] & (s_csr_add[i] == MCSR_SCRATCH) & s_uadd_00[i]) begin
                    s_wmscratch[i]  = s_csr_w_val[i];
                end
            end

            assign s_mcycle_we[i] = 1'b1;
            always_comb begin : mcycle_writer
                s_wmcycle[i]    = s_mcycle_counter[i][31:0];
                if (s_write_machine[i] & (s_csr_add[i] == MCSR_CYCLE) & s_uadd_10[i]) begin
                    s_wmcycle[i]  = s_csr_w_val[i];
                end
            end

            assign s_mcycleh_we[i] = 1'b1;
            always_comb begin : mcycleh_writer
                s_wmcycleh[i]   = s_mcycle_counter[i][63:32];
                if (s_write_machine[i] & (s_csr_add[i] == MCSR_CYCLEH) & s_uadd_10[i]) begin
                    s_wmcycleh[i]   = s_csr_w_val[i];
                end
            end

            assign s_minstret_we[i] = s_write_machine[i] || s_commit[i] || s_csr_refresh[i];
            always_comb begin : minstret_writer
                s_wminstret[i]    = s_minstret[i];
                if (s_write_machine[i] & (s_csr_add[i] == MCSR_INSTRET) & s_uadd_10[i]) begin
                    s_wminstret[i]    = s_csr_w_val[i];
                end else if(s_commit[i]) begin
                    s_wminstret[i]    = s_minstret_counter[i][31:0];
                end
            end

            assign s_minstreth_we[i] = s_write_machine[i] || s_commit[i] || s_csr_refresh[i];
            always_comb begin : minstreth_writer
                s_wminstreth[i]    = s_minstreth[i];
                if (s_write_machine[i] & (s_csr_add[i] == MCSR_INSTRETH) & s_uadd_10[i]) begin
                    s_wminstreth[i]   = s_csr_w_val[i];
                end else if(s_commit[i]) begin
                    s_wminstreth[i]    = s_minstret_counter[i][63:32];
                end
            end

            assign s_mtvec_we[i] = s_write_machine[i] || s_csr_refresh[i];
            always_comb begin : mtvec_writer
                s_wmtvec[i] = s_mtvec[i];
                if (s_write_machine[i] & (s_csr_add[i] == MCSR_TVEC) & s_uadd_00[i]) begin
                    s_wmtvec[i][31:2]   = s_csr_w_val[i][31:2];
                    s_wmtvec[i][1]      = 1'b0;
                    s_wmtvec[i][0]      = s_csr_w_val[i][0];
                end
            end

            assign s_mepc_we[i] = s_write_machine[i] || s_int_exc[i] || s_csr_refresh[i];
            always_comb begin : mepc_writer
                s_wmepc[i]   = s_mepc[i];
                if(s_int_exc[i]) begin
                    s_wmepc[i]   = s_pc_i[i];
                end else if (s_write_machine[i] & (s_csr_add[i] == MCSR_EPC) & s_uadd_00[i]) begin
                    s_wmepc[i]   = s_csr_w_val[i];
                end
            end

            assign s_mcause_we[i] = s_write_machine[i] || s_int_exc[i] || s_csr_refresh[i];    
            always_comb begin : mcause_writer
                s_wmcause[i][31]    = s_mcause[i][31];
                s_wmcause[i][30:5]  = s_mcause[i][30:5];
                s_wmcause[i][4:0]   = s_mcause[i][4:0];
                if(s_int_exc[i]) begin
                    s_wmcause[i][31]    = s_interrupted_i[i];
                    s_wmcause[i][30:5]  = 26'b0;
                    s_wmcause[i][4:0]   = (s_interrupted_i[i]) ? s_int_code[i] : s_exc_code[i];
                end else if (s_write_machine[i] & (s_csr_add[i] == MCSR_CAUSE) & s_uadd_00[i]) begin
                    s_wmcause[i][31]    = s_csr_w_val[i][31];
                    s_wmcause[i][30:5]  = s_csr_w_val[i][30:5];
                    s_wmcause[i][4:0]   = s_csr_w_val[i][4:0];
                end
            end

            assign s_mtval_we[i] = s_write_machine[i] || s_exc_active[i] || s_csr_refresh[i]; 
            always_comb begin : mtval_writer
                s_wmtval[i] = s_mtval[i];
                if(s_exc_active[i]) begin
                    s_wmtval[i]   = s_val_i[i];
                end else if (s_write_machine[i] & (s_csr_add[i] == MCSR_TVAL) & s_uadd_00[i]) begin
                    s_wmtval[i]   = s_csr_w_val[i];
                end
            end  

            assign s_mip_we[i] = 1'b1;
            always_comb begin : mip_writer
`ifdef PROT_INTF
                s_wmip[i][14]     = (s_int_lcer_i[i] & s_mie[i][14]) | s_mip[i][14];
                s_wmip[i][13]     = (s_int_fcer_i & s_mie[i][13]) | s_mip[i][13];
`else
                s_wmip[i][14:13]  = 2'b0;
`endif
`ifdef PROT_PIPE
                s_wmip[i][12]     = s_livelock_int[i]  | s_mip[i][12];
`else
                s_wmip[i][12]     = 1'b0;
`endif
                if (s_write_machine[i] & (s_csr_add[i] == MCSR_IP) & s_uadd_00[i]) begin //not applicable without PROT_INTF or PROT_PIPE
                    s_wmip[i][14:12]  = s_csr_w_val[i][14:12];
                end
                s_wmip[i][11]     = s_int_meip_i;
                s_wmip[i][10:8]   = 3'b0;
                s_wmip[i][7]      = s_int_mtip_i;
                s_wmip[i][6:4]    = 3'b0;
                s_wmip[i][3]      = s_int_msip_i;
                s_wmip[i][2:0]    = 3'b0;
            end  

            assign s_mie_we[i] = s_write_machine[i] || s_csr_refresh[i];
            always_comb begin : mie_writer
                s_wmie[i][14:11]= s_mie[i][14:11];
                s_wmie[i][10:8] =  3'b0;
                s_wmie[i][7]    = s_mie[i][7];
                s_wmie[i][6:4]  =  3'b0;
                s_wmie[i][3]    = s_mie[i][3];
                s_wmie[i][2:0]  =  3'b0;
                if (s_write_machine[i] & (s_csr_add[i] == MCSR_IE) & s_uadd_00[i]) begin
                    s_wmie[i][14:11]= s_csr_w_val[i][14:11];
                    s_wmie[i][7]    = s_csr_w_val[i][7];
                    s_wmie[i][3]    = s_csr_w_val[i][3];
                end
            end

`ifdef PROT_PIPE
            // If all three replicas are distinct, signalize unrecoverable error
            assign s_pc_uce[i]      = (s_pc_i[i] != s_pc_i[(i+1)%3]) && (s_pc_i[i] != s_pc_i[(i+2)%3]);
            // Signalize reaching of maximum number of consecutive restarts
            assign s_max_reached[i] = s_mhrdctrl0[i][19:16] == s_mhrdctrl0[i][11:8];
            assign s_livelock[i]    = s_max_reached[i] && s_mhrdctrl0[i][20] && (s_mhrdctrl0[i][3] || ~s_mhrdctrl0[i][1]);
            assign s_livelock_int[i]= s_livelock[i] && s_mhrdctrl0[i][0] && !s_execute[i];
`else
            assign s_pc_uce[i]      = 1'b0;
            assign s_max_reached[i] = 1'b0;
            assign s_livelock[i]    = 1'b0;
            assign s_livelock_int[i]= 1'b0;
`endif      

            /*  HRDCTRL0
                31: core active (1) - not writtable
                30-23: reserved
                22: data bus error detected
                21: instruction bus error detected
                20: the restart counter is counting
                19-16: the restart counter - reserved
                15-14: reserved
                13-12: CSR refresh rate
                11-08: maximum number of consecutive restarts
                07: enable automatic pipeline restart after the first bus error
                06: enable error correction code in the register file
                05-04: acm settings
                     - bit 0 : proactive error search - read address increments whenever possible
                     - bit 1 : proactive checksum analysis - even if error is not detected in data 
                03: disable predictor
                02: unrecoverable system error - sticky
                01: after the max number of consecutive restarts, try to disable the predictor at first
                00: fire interrupt on livelock instead of signalization of unrecoverable error         
            */
            assign s_mhrdctrl0_we[i] = 1'b1;
            always_comb begin : mrhdctrl0_writer
                s_wmhrdctrl0[i][31]     = 1'b1;
                s_wmhrdctrl0[i][30:23]  = 8'b0;
                if (s_write_machine[i] & (s_csr_add[i] == MCSR_HRDCTRL0) & s_uadd_01[i]) begin
                    s_wmhrdctrl0[i][22]     = s_csr_w_val[i][22];
                    s_wmhrdctrl0[i][21]     = s_csr_w_val[i][21];                
                    s_wmhrdctrl0[i][20:16]  = s_csr_w_val[i][20:16];
                    s_wmhrdctrl0[i][15:14]  = 2'b0;                 //reserved
                    s_wmhrdctrl0[i][13:12]  = s_csr_w_val[i][13:12];
                    s_wmhrdctrl0[i][11:8]   = s_csr_w_val[i][11:8];
                    s_wmhrdctrl0[i][7]      = s_csr_w_val[i][7];
                    s_wmhrdctrl0[i][6]      = s_csr_w_val[i][6];
                    s_wmhrdctrl0[i][5:0]    = s_csr_w_val[i][5:0];
                end else begin
                    s_wmhrdctrl0[i][22:0]   = s_mhrdctrl0[i][22:0];
                    if(s_rstpp_i[i] & s_mhrdctrl0[i][7] & (s_exceptions[i][EXC_LSACCESS] | s_exceptions[i][EXC_IACCESS]))begin
                        //save bus-error indicator
                        s_wmhrdctrl0[i][22] = s_exceptions[i][EXC_LSACCESS];
                        s_wmhrdctrl0[i][21] = s_exceptions[i][EXC_IACCESS];
                    end else if(s_execute[i] & s_mhrdctrl0[i][7])begin
                        //clear bus-error indicator
                        s_wmhrdctrl0[i][22:21] = 2'b0;
                    end
                    if(s_execute[i])begin
                        //stop counting
                        s_wmhrdctrl0[i][20] = 1'b0;
                    end else if(s_rstpp_i[i])begin
                        //start/countinue counting
                        s_wmhrdctrl0[i][20] = 1'b1;
                    end
                    if(s_execute[i] | (s_mhrdctrl0[i][20] & s_mhrdctrl0[i][1] & ~s_mhrdctrl0[i][3] & s_max_reached[i]))begin
                        //reset counter on valid instruction, or at a try to disable the predictor
                        s_wmhrdctrl0[i][19:16] = 4'b0;
                    end else if(s_mhrdctrl0[i][20] & (s_mhrdctrl0[i][19:16] != s_mhrdctrl0[i][11:8]) & s_rstpp_i[i])begin
                        //continue counting until the maximum number of restarts is reached
                        s_wmhrdctrl0[i][19:16] = s_mhrdctrl0[i][19:16] + 4'b1;
                    end
                    if(s_mhrdctrl0[i][20] & s_mhrdctrl0[i][1] & s_max_reached[i])begin
                        //try to disable the predictor at first
                        s_wmhrdctrl0[i][3] = 1'b1;
                    end
                    if(!s_mhrdctrl0[i][2])begin
                        s_wmhrdctrl0[i][2] = s_pc_uce[i];
                        if(!s_execute[i] && s_livelock[i] && !s_mhrdctrl0[i][0])begin
                            //signalize lock-up / unrecoverable error
                            s_wmhrdctrl0[i][2] = 1'b1;
                        end
                    end
                    if(!s_execute[i] && s_livelock[i])begin
                        //automatic clear of the livelock interrupt enable
                        s_wmhrdctrl0[i][0] = 1'b1;
                    end
                end                
            end

`ifdef PROT_INTF            
            //CSR_ADDRERR is free to receive data if neither FCER nor LCER interrupt is pending
            assign s_mcsr_addr_free[i] = (~s_mie[i][13] | (s_mie[i][13] & ~s_mip[i][13])) & (~s_mie[i][14] | (s_mie[i][14] & ~s_mip[i][14]));

            //If both, FCER and LCER, interrupt sources are enabled, the FCER has higher priority
            assign s_maddrerr_we[i] = ((s_int_fcer_i & s_mie[i][13]) | (s_mie[i][14] & s_ictrl_i[i][ICTRL_UNIT_LSU])) || s_csr_refresh[i];
            always_comb begin
                s_wmaddrerr[i] = s_maddrerr[i];
                if(s_mcsr_addr_free[i] & s_int_fcer_i & s_mie[i][13])begin
                    //Save address of instruction with correctable error
                    s_wmaddrerr[i] = {s_pc_i[i][31:2],2'b0};
                end else if(s_mcsr_addr_free[i] & s_mie[i][14] & s_ictrl_i[i][ICTRL_UNIT_LSU])begin
                    //Save address of LSU transfer
                    s_wmaddrerr[i] = {s_val_i[i][31:2],2'b0};
                end
            end
`endif

        end       
    endgenerate
endmodule
