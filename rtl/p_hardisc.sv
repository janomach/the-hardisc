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

package p_hardisc;
    parameter WORD_WIDTH    = 32;
    parameter RF_ADD_WIDTH  = 5;
    parameter OPC_WIDTH     = 5;
    parameter IFB_WIDTH     = 38;
    parameter BOP_WIDTH     = 31;

`ifdef PROTECTED
    parameter PROT_2REP     = 2;
    parameter PROT_3REP     = 3;
`else
    parameter PROT_2REP     = 1;
    parameter PROT_3REP     = 1;
`endif

	parameter[OPC_WIDTH-1:0]
                OPC_LOAD	= 5'b00000,
                OPC_FENCE	= 5'b00011,
                OPC_OP_IMM	= 5'b00100,
                OPC_AUIPC	= 5'b00101,
                OPC_STORE	= 5'b01000,
                OPC_OP		= 5'b01100,
                OPC_LUI 	= 5'b01101,
                OPC_BRANCH	= 5'b11000,
                OPC_JALR	= 5'b11001,
                OPC_JAL		= 5'b11011,
                OPC_SYSTEM  = 5'b11100;
    parameter[3:0]  
                ALU_ADD = 4'b0000,
                ALU_SLL = 4'b0001,
                ALU_SLT = 4'b0010,
                ALU_SLTU =4'b0011,
                ALU_XOR = 4'b0100,
                ALU_SRL = 4'b0101,
                ALU_OR  = 4'b0110,
                ALU_AND = 4'b0111,
                ALU_SUB = 4'b1000,
                ALU_NEQ = 4'b1001,
                ALU_EQ  = 4'b1010,
                ALU_SET1= 4'b1011,
                ALU_IPC = 4'b1100,
                ALU_SRA = 4'b1101,
                ALU_GE  = 4'b1110,
                ALU_GEU = 4'b1111;
    parameter[1:0]
                CSR_RW  = 2'b01,
                CSR_RS  = 2'b10,
                CSR_RC  = 2'b11;
    parameter [1:0]
                SCTRL_RFRP1= 2'd0,
                SCTRL_RFRP2= 2'd1,
                SCTRL_ZERO1= 2'd2,
                SCTRL_ZERO2= 2'd3;

    parameter [2:0]
                ICTRL_UNIT_ALU  = 3'd0,
                ICTRL_UNIT_BRU  = 3'd1,
                ICTRL_UNIT_LSU  = 3'd2,
                ICTRL_UNIT_CSR  = 3'd3,
                ICTRL_UNIT_MDU  = 3'd4,
                ICTRL_REG_DEST  = 3'd5,
                ICTRL_RVC       = 3'd6;
    parameter [6:0]
                ICTRL_PRR_VAL   = 7'h03;     
    parameter [7:0]
                ICTRL_RST_VAL   = 8'h0A,
                ICTRL_UCE_VAL   = 8'h0B;
    parameter [2:0]
                IMISCON_FREE    = 3'd0, //no misconduct
                IMISCON_FERR    = 3'd1, //fetch bus error
                IMISCON_PMAV    = 3'd2, //pma violation
                //reserved
                IMISCON_FUCE    = 3'd4, //fetch uncorrectable error
                IMISCON_ILLE    = 3'd5, //illegal instruction
                IMISCON_DSCR    = 3'd6, //discrepancy in pipeline
                IMISCON_RUCE    = 3'd7; //register uncorrectable error 
    parameter [2:0]
                FETCH_VALID     = 3'd0, //no fetch error
                FETCH_BSERR     = 3'd1, //fetch bus error
                FETCH_PMAVN     = 3'd2, //fetch address PMA violation
                //reserved
                FETCH_INUCE     = 3'd4, //fetch interface uncorrectable error
                //reserved
                //reserved
                FETCH_INCER     = 3'd7; //fetch interface correctable error
    parameter [1:0]
                //LEVEL_USER      = 2'b00,
                //LEVEL_SUVISOR   = 2'b01,
                LEVEL_MACHINE   = 2'b11; 

`ifdef PROTECTED_WITH_IFP
    parameter MAX_MCSR    = 15;
`else
    parameter MAX_MCSR    = 14;
`endif
    parameter [4:0]
                MCSR_STATUS      = 5'd00,
                MCSR_INSTRET     = 5'd01,
                MCSR_INSTRETH    = 5'd02,
                MCSR_CYCLE       = 5'd03,
                MCSR_CYCLEH      = 5'd04,
                MCSR_IE          = 5'd05,
                MCSR_TVEC        = 5'd06,
                MCSR_EPC         = 5'd07,
                MCSR_CAUSE       = 5'd08,
                MCSR_TVAL        = 5'd09,
                MCSR_IP          = 5'd10,
                MCSR_SCRATCH     = 5'd11,
                MCSR_HARTID      = 5'd12, 
                MCSR_ISA         = 5'd13,
                MCSR_HRDCTRL0    = 5'd14,
                MCSR_ADDRERR     = 5'd15;
    parameter [7:0]
                CSR_STATUS      = 8'h00,
                CSR_CYCLE       = 8'h00,
                CSR_ISA         = 8'h01,
                CSR_INSTRET     = 8'h02,
                CSR_IE          = 8'h04,
                CSR_TVEC        = 8'h05,
                //CSR_COUNTEREN   = 8'h06,
                CSR_HARTID      = 8'h14,
                CSR_SCRATCH     = 8'h40,
                CSR_EPC         = 8'h41,
                CSR_CAUSE       = 8'h42,
                CSR_TVAL        = 8'h43,
                CSR_IP          = 8'h44,
                CSR_CYCLEH      = 8'h80,
                CSR_INSTRETH    = 8'h82,
                CSR_HRDCTRL0    = 8'hC0,
                CSR_ADDRERR     = 8'hC0;
    parameter [11:0]
                //CSR_USTATUS     = {2'b00,LEVEL_USER,CSR_STATUS},
                //CSR_UIE         = {2'b00,LEVEL_USER,CSR_IE},
                //CSR_UTVEC       = {2'b00,LEVEL_USER,CSR_TVEC},
                //CSR_USCRATCH    = {2'b00,LEVEL_USER,CSR_SCRATCH},
                //CSR_UEPC        = {2'b00,LEVEL_USER,CSR_EPC},
                //CSR_UCAUSE      = {2'b00,LEVEL_USER,CSR_CAUSE},
                //CSR_UTVAL       = {2'b00,LEVEL_USER,CSR_TVAL},
                //CSR_UIP         = {2'b00,LEVEL_USER,CSR_IP},
                CSR_MSTATUS     = {2'b00,LEVEL_MACHINE,CSR_STATUS},
                CSR_MISA        = {2'b00,LEVEL_MACHINE,CSR_ISA},
                CSR_MIE         = {2'b00,LEVEL_MACHINE,CSR_IE},
                CSR_MTVEC       = {2'b00,LEVEL_MACHINE,CSR_TVEC},
                //CSR_MCOUNTEREN  = {2'b00,LEVEL_MACHINE,CSR_COUNTEREN},
                CSR_MSCRATCH    = {2'b00,LEVEL_MACHINE,CSR_SCRATCH},
                CSR_MEPC        = {2'b00,LEVEL_MACHINE,CSR_EPC},
                CSR_MCAUSE      = {2'b00,LEVEL_MACHINE,CSR_CAUSE},
                CSR_MTVAL       = {2'b00,LEVEL_MACHINE,CSR_TVAL},
                CSR_MIP         = {2'b00,LEVEL_MACHINE,CSR_IP},
                CSR_MHRDCTRL0   = {2'b01,LEVEL_MACHINE,CSR_HRDCTRL0},
                CSR_MCYCLE      = {2'b10,LEVEL_MACHINE,CSR_CYCLE},
                CSR_MCYCLEH     = {2'b10,LEVEL_MACHINE,CSR_CYCLEH},
                CSR_MINSTRET    = {2'b10,LEVEL_MACHINE,CSR_INSTRET},
                CSR_MINSTRETH   = {2'b10,LEVEL_MACHINE,CSR_INSTRETH},
                CSR_MHARTID     = {2'b11,LEVEL_MACHINE,CSR_HARTID},
                CSR_MADDRERR    = {2'b11,LEVEL_MACHINE,CSR_ADDRERR};
    parameter [1:0] 
                CSR_FUN_ECALL   = 2'b0,
                CSR_FUN_EBREAK  = 2'b01,
                CSR_FUN_RET     = 2'b10;
    parameter [2:0]
                EXC_ILLEGALI    = 3'd0,
                EXC_ECALL_M     = 3'd1,
                EXC_EBREAK_M    = 3'd2,
                EXC_LSADD_MISS  = 3'd3,
                EXC_IACCESS     = 3'd4,
                EXC_LSACCESS    = 3'd5;
    parameter [4:0]
                EXC_MISALIGI_VAL = 5'd0, 
                EXC_IACCES_VAL   = 5'd1,  
                EXC_ILLEGALI_VAL = 5'd2,
                EXC_EBREAK_M_VAL = 5'd3,
                EXC_LADD_MISS_VAL= 5'd4,
                EXC_LACCESS_VAL  = 5'd5,
                EXC_SADD_MISS_VAL= 5'd6,
                EXC_SACCESS_VAL  = 5'd7,
                EXC_ECALL_M_VAL  = 5'd11;
    parameter [4:0]  
                INT_MSI_VAL      = 5'd3,
                INT_MTI_VAL      = 5'd7,
                INT_MEI_VAL      = 5'd11,
                INT_UCE_VAL      = 5'd16,
                INT_FCER_VAL     = 5'd17,
                INT_LCER_VAL     = 5'd18,
                INT_FUCE_VAL     = 5'd19,
                INT_LUCE_VAL     = 5'd20,
                INT_RUCE_VAL     = 5'd21;
    parameter [2:0]
                PIPE_FE = 3'd0,
                PIPE_ID = 3'd1,
                PIPE_OP = 3'd2,
                PIPE_EX = 3'd3,
                PIPE_MA = 3'd4;
    parameter [1:0]
                LSU_RMW_IDLE    = 2'b00,
                LSU_RMW_READ    = 2'b01,
                LSU_RMW_WRITE   = 2'b10;
    parameter [5:0]
                SEEGR_CORE_REG  = 0,
                SEEGR_REG_FILE  = 1,
                SEEGR_PREDICTOR = 2,
                SEEGR_CORE_WIRE = 3,
                SEEGR_MEMORY    = 4,
                SEEGR_BUS_WIRE  = 5;

    typedef logic[5:0]exception; 
    typedef logic[OPC_WIDTH-1:0]opcode;
    typedef logic[RF_ADD_WIDTH-1:0]rf_add;
    typedef logic[7:0]ex_ctrl;
    typedef logic[3:0]f_part;
    typedef logic[3:0]operr;
    typedef logic[3:0]sctrl;
    typedef logic[6:0]ictrl;
    typedef logic[2:0]imiscon;
    typedef logic[1:0]rp_info;
    typedef logic[4:0]ld_info;

    // Physical Memory Attribute configuration
    typedef struct packed {
        logic[31:0] base;
        logic[31:0] mask;
        logic read_only;
        logic executable;
        logic idempotent;
    } pma_cfg_t;

    // Default attribution when PMA is configured
    parameter pma_cfg_t PMA_DEFAULT = '{base  : 32'b0, mask  : 32'b0, read_only  : 1'b0, executable: 1'b1, idempotent : 1'b1};

endpackage
