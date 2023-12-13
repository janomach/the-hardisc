`ifndef SETTINGS
`define SETTINGS

`define SIMULATION
//`define SEE_TESTING
//`define PROTECTED
//`define IFP
//`define FAST_MULTIPLY

//Interface protection is supported only in PROTECTED core
`ifdef PROTECTED
`ifdef IFP
`define PROTECTED_WITH_IFP
`endif
`endif

`define SEE_MAX 1000000

`define OPTION_FIFO_SIZE    4
`define OPTION_BHT_SIZE     64
`define OPTION_BTB_SIZE     16
`define OPTION_JTB_SIZE     8
`define OPTION_SHARED       20
`define OPTION_BOP_SIZE     3
`define OPTION_RAS_SIZE     2

`endif
