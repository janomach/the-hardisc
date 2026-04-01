@echo off
rem -------------------------------------------------------------------------
rem sim_reri.bat  --  compile and run the RERI testbench with Icarus Verilog
rem
rem Run from the the-hardisc\ directory:
rem   scripts\sim_reri.bat
rem
rem Requires: iverilog and vvp on PATH (download from https://bleyer.org/icarus/)
rem -------------------------------------------------------------------------

setlocal

set SRC=peripherals/p_reri.sv rtl/edac.sv ver/ecc_monitor.sv peripherals/ahb_controller.sv peripherals/reri_error_bank.sv ver/tb_reri.sv

echo Compiling...
iverilog -g2012 -I rtl -o sim_reri.vvp %SRC%
if errorlevel 1 (
    echo Compilation FAILED
    exit /b 1
)

echo Running simulation...
vvp sim_reri.vvp

del /q sim_reri.vvp 2>nul
endlocal
