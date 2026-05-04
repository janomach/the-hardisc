# ─────────────────────────────────────────────────────────────────────────────
# sim_reri_reader.do — compile and run the reri_sim firmware on the full
#                      hardisc system with SEE injection enabled
#
# Usage (ModelSim / Questa):
#   do scripts/sim_reri_reader.do
#
# Run from the repo root: the-hardisc/
#
# Prerequisites:
#   Build the firmware first:
#     make -f example/reri_sim/Makefile
#   This produces example/reri_sim/test.bin
#
# What to expect in the transcript:
#   "RERI bank: inst_id=0x0001 n_records=3"
#   "valid_summary=0x..."
#   "  Record N: ec=0x.. pri=.. [CE/UED/UEC] addr=0x..."   (if SEEs hit)
#   "No valid error records."                               (if no SEEs hit)
#   "Done."
#   $finish triggered by firmware write to HALT_REG (0x80000004)
# ─────────────────────────────────────────────────────────────────────────────

# ── 1. Create / map work library ────────────────────────────────────────────
if {[file exists work]} { vdel -lib work -all }
vlib work
vmap work work

# ── 2. Compile packages ──────────────────────────────────────────────────────
# SEE_TESTING activates see_wires/see_insert injection at runtime via +SEE_PROB/+SEE_GROUP
set D "+define+SEE_TESTING"
vlog -sv -work work $D rtl/edac.sv
vlog -sv -work work $D +incdir+rtl rtl/p_hardisc.sv
vlog -sv -work work $D              peripherals/reri/p_reri.sv

# ── 3. Compile leaf RTL modules ──────────────────────────────────────────────
foreach f {
    rtl/acm.sv
    rtl/adder3op.sv
    rtl/aligner.sv
    rtl/alu.sv
    rtl/bmu.sv
    rtl/bop.sv
    rtl/branch_predictor.sv
    rtl/bru.sv
    rtl/c_decoder.sv
    rtl/circular_buffer.sv
    rtl/csru.sv
    rtl/decoder.sv
    rtl/executor.sv
    rtl/fast_modules.sv
    rtl/ifb.sv
    rtl/jump_predictor.sv
    rtl/lsu_decoder.sv
    rtl/lsu.sv
    rtl/muldiv.sv
    rtl/pma.sv
    rtl/predictor.sv
    rtl/preparer.sv
    rtl/ras.sv
    rtl/rf_controller.sv
    rtl/secded_analyze.sv
    rtl/secded_decode.sv
    rtl/secded_encode.sv
    rtl/see_wires.sv
    rtl/seu_ffs.sv
    rtl/tmr_comb.sv
} {
    vlog -sv -work work $D +incdir+rtl $f
}

# ── 4. Compile RERI modules ──────────────────────────────────────────────────
vlog -sv -work work $D +incdir+rtl ver/ecc_monitor.sv
vlog -sv -work work $D              peripherals/reri/reri_error_bank.sv

# ── 5. Compile pipeline stages ───────────────────────────────────────────────
vlog -sv -work work $D +incdir+rtl rtl/pipeline_1_fe.sv
vlog -sv -work work $D +incdir+rtl rtl/pipeline_2_id.sv
vlog -sv -work work $D +incdir+rtl rtl/pipeline_3_op.sv
vlog -sv -work work $D +incdir+rtl rtl/pipeline_4_ex.sv
vlog -sv -work work $D +incdir+rtl rtl/pipeline_5_ma.sv

# ── 6. Compile top-level RTL ─────────────────────────────────────────────────
vlog -sv -work work $D +incdir+rtl rtl/hardisc.sv
vlog -sv -work work $D +incdir+rtl rtl/system_core.sv
vlog -sv -work work $D +incdir+rtl rtl/system_hardisc.sv
vlog -sv -work work $D +incdir+rtl rtl/system_dcls.sv
vlog -sv -work work $D +incdir+rtl rtl/system_tcls.sv

# ── 7. Compile peripherals ───────────────────────────────────────────────────
foreach f {
    peripherals/ahb_interconnect.sv
    peripherals/ahb_ram.sv
    peripherals/ahb_timer.sv
    peripherals/dahb_ram.sv
    peripherals/debounce.sv
    peripherals/uart_controller.sv
    peripherals/ahb_to_uart_controller.sv
    peripherals/ahb_controller.sv
} {
    vlog -sv -work work $D $f
}

# ── 8. Compile testbench files ───────────────────────────────────────────────
vlog -sv -work work $D +incdir+rtl ver/seed_instance.sv
vlog -sv -work work $D +incdir+rtl ver/see_insert.sv
vlog -sv -work work $D +incdir+rtl ver/tracer.sv
vlog -sv -work work $D +incdir+rtl ver/tb_mh_wrapper.sv

# ── 9. Elaborate and simulate ────────────────────────────────────────────────
# BIN        — reri_sim firmware (build with: make -f example/reri_sim/Makefile)
# TIMEOUT    — large enough for firmware to boot, enable RERI, wait for SEEs, read back
# SEE_PROB=100 — inject single-event upsets on bus wires
# SEE_GROUP=32 — SEEGR_BUS_WIRE (bit 5 → mask=32); targets IHRDATA/DHRDATA see_wires
vsim -t 1ns -lib work tb_mh_wrapper \
    +BIN=example/reri_sim/test.bin \
    +TIMEOUT=100000 \
    +LOGGING=0 \
    +SEE_PROB=100 \
    +SEE_GROUP=32 \
    +LAT=0 \
    +ECALLHALT=0

# ── 10. Add waveforms ────────────────────────────────────────────────────────
add wave -divider "Clock / Reset"
add wave /tb_mh_wrapper/r_ver_clk
add wave /tb_mh_wrapper/r_ver_rstn

add wave -divider "RERI internal records"
add wave /tb_mh_wrapper/m_reri_error_bank/r_stat
add wave /tb_mh_wrapper/m_reri_error_bank/r_ctrl
add wave -radix hex /tb_mh_wrapper/m_reri_error_bank/r_addr_info

add wave -divider "RERI AHB slave (software reads)"
add wave -radix hex /tb_mh_wrapper/m_reri_error_bank/haddr
add wave            /tb_mh_wrapper/m_reri_error_bank/hsel
add wave            /tb_mh_wrapper/m_reri_error_bank/htrans
add wave            /tb_mh_wrapper/m_reri_error_bank/hwrite
add wave -radix hex /tb_mh_wrapper/m_reri_error_bank/hwdata
add wave -radix hex /tb_mh_wrapper/m_reri_error_bank/hrdata

add wave -divider "Hardisc fault outputs"
add wave /tb_mh_wrapper/dut/rep[0]/core/s_reri_o[0]
add wave /tb_mh_wrapper/dut/rep[0]/core/s_reri_o[1]
add wave /tb_mh_wrapper/dut/rep[0]/core/s_reri_o[2]
add wave /tb_mh_wrapper/dut/rep[0]/core/s_reri_o[3]

add wave -divider "RAS outputs"
add wave -color Cyan   /tb_mh_wrapper/s_ras_lo
add wave -color Orange /tb_mh_wrapper/s_ras_hi
add wave -color Red    /tb_mh_wrapper/s_ras_plat

# ── 11. Run ───────────────────────────────────────────────────────────────────
run -all
wave zoom full
