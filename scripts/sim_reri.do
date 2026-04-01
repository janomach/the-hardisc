# ─────────────────────────────────────────────────────────────────────────────
# sim_reri.do — compile and run the RERI error-bank testbench
#
# Usage (ModelSim / Questa):
#   do scripts/sim_reri.do
#
# Run from the repo root:  the-hardisc/
# All paths are relative to that working directory.
# ─────────────────────────────────────────────────────────────────────────────

# ── 1. Create / map work library ────────────────────────────────────────────
if {[file exists work]} { vdel -lib work -all }
vlib work
vmap work work

# ── 2. Compile RTL sources needed by the testbench ──────────────────────────
# edac package (SECDED functions)
vlog -sv -work work rtl/edac.sv

# ecc_monitor: needs settings.sv on include path
vlog -sv -work work +incdir+rtl rtl/ecc_monitor.sv

# reri_error_bank and its AHB controller dependency
vlog -sv -work work peripherals/ahb_controller.sv
vlog -sv -work work peripherals/reri_error_bank.sv

# Testbench
vlog -sv -work work ver/tb_reri.sv

# ── 3. Simulate ─────────────────────────────────────────────────────────────
vsim -t 1ns -lib work tb_reri

# ── 4. Waveforms (optional — comment out for pure batch mode) ───────────────
add wave -divider "Clock / Reset"
add wave -noupdate        /tb_reri/clk
add wave -noupdate        /tb_reri/rst_n

add wave -divider "ecc_monitor inputs"
add wave -noupdate        /tb_reri/fetch_ce
add wave -noupdate        /tb_reri/lsu_ce
add wave -noupdate        /tb_reri/lsu_uce
add wave -noupdate        /tb_reri/pipe_uce
add wave -noupdate -radix hex /tb_reri/fetch_addr
add wave -noupdate -radix hex /tb_reri/lsu_addr

add wave -divider "RERI fault bus"
add wave -noupdate        /tb_reri/fault_valid
add wave -noupdate        /tb_reri/fault_ce_bus
add wave -noupdate        /tb_reri/fault_ued_bus
add wave -noupdate        /tb_reri/fault_uec_bus
add wave -noupdate -radix hex /tb_reri/fault_ec_bus
add wave -noupdate        /tb_reri/fault_pri_bus
add wave -noupdate -radix hex /tb_reri/fault_addr_bus

add wave -divider "AHB-Lite to reri_error_bank"
add wave -noupdate -radix hex /tb_reri/haddr
add wave -noupdate        /tb_reri/htrans
add wave -noupdate        /tb_reri/hwrite
add wave -noupdate -radix hex /tb_reri/hwdata
add wave -noupdate -radix hex /tb_reri/hrdata
add wave -noupdate        /tb_reri/hreadyout

add wave -divider "RAS outputs"
add wave -noupdate -color Cyan   /tb_reri/ras_lo
add wave -noupdate -color Orange /tb_reri/ras_hi
add wave -noupdate -color Red    /tb_reri/ras_plat

add wave -divider "Internal record storage"
add wave -noupdate /tb_reri/dut_bank/r_valid
add wave -noupdate /tb_reri/dut_bank/r_rdip
add wave -noupdate /tb_reri/dut_bank/r_ce
add wave -noupdate /tb_reri/dut_bank/r_ued
add wave -noupdate /tb_reri/dut_bank/r_uec
add wave -noupdate -radix hex /tb_reri/dut_bank/r_ec
add wave -noupdate /tb_reri/dut_bank/r_pri

add wave -divider "Control register fields"
add wave -noupdate /tb_reri/dut_bank/r_else
add wave -noupdate /tb_reri/dut_bank/r_cece
add wave -noupdate /tb_reri/dut_bank/r_ces
add wave -noupdate /tb_reri/dut_bank/r_ueds
add wave -noupdate /tb_reri/dut_bank/r_uecs
add wave -noupdate -radix hex /tb_reri/dut_bank/r_eid
add wave -noupdate -radix hex /tb_reri/dut_bank/r_ecount

add wave -divider "Valid summary"
add wave -noupdate -radix hex /tb_reri/dut_bank/s_valid_summary64

# ── 5. Run ──────────────────────────────────────────────────────────────────
run -all
wave zoom full
