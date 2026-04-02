@echo off
rem -------------------------------------------------------------------------
rem sim_reri.bat  --  compile and run the RERI testbench with ModelSim
rem
rem Run from the the-hardisc\ directory:
rem   scripts\sim_reri.bat
rem -------------------------------------------------------------------------

setlocal

echo Compiling and simulating via ModelSim...
vsim -c -do "do scripts/sim_reri.do; quit -f"

if errorlevel 1 (
    echo Simulation FAILED
    exit /b 1
)
endlocal
