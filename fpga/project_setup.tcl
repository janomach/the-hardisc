# project settings
create_project "hardisc-demo" -force -dir "./fpga-project"
set design_name "platform_arty"
set_property board_part digilentinc.com:arty-a7-35:part0:1.1 [current_project]

# set reference directories for source files
add_files "./../rtl"
add_files "./../peripherals"

# read fpga platform source
read_verilog -sv "./src/platform_artyA7.sv"

# read memory-init files
read_mem "./src/bootloader.mem"
read_mem "./src/matrix.mem"

# read constraints
read_xdc "./src/Arty-A7-35-Master.xdc"

set_property top platform_artyA7 [current_fileset]

# add clocking wizard
create_ip -vlnv xilinx.com:ip:clk_wiz:6.0 -module_name clk_wiz_0
set_property -dict [list \
  CONFIG.CLKOUT1_JITTER {226.435} \
  CONFIG.CLKOUT1_PHASE_ERROR {236.795} \
  CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {75.000} \
  CONFIG.MMCM_CLKFBOUT_MULT_F {40.125} \
  CONFIG.MMCM_CLKOUT0_DIVIDE_F {13.375} \
  CONFIG.MMCM_DIVCLK_DIVIDE {4} \
  CONFIG.RESET_PORT {resetn} \
  CONFIG.RESET_TYPE {ACTIVE_LOW} \
] [get_ips clk_wiz_0]

# enable generation of binary file 
set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]