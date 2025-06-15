## Design Verification 

This folder contains basic assembly tests that were generated using the [RISCV-DV](https://github.com/chipsalliance/riscv-dv).
The attached Makefile can be used check whether the Hardisc executes the tests in the same way as the RISC-V Spike simulator.

In order to prepare the flow, follow the steps:

1. Clone [RISCV-DV](https://github.com/chipsalliance/riscv-dv), checkout commit `7e54b678ab7499040336255550cdbd99ae887431`, and [install](https://github.com/chipsalliance/riscv-dv?tab=readme-ov-file#install-riscv-dv) it
2. Configure the correct path to the cloned repository in the makefile (`RISCV_DV_DIR`)
3. Run the makefile target `prepareRISCVDV`
4. Change the `BOOTADD` in the testbench to `32'h80000000` and recompile the RTL

Once it is prepared, you can use the makefile targets:

1. `spikeSimPregen` - generates binaries from the pre-generated tests and runs them on the Spike simulator
2. `hardiscSimPregen` - run the generated binaries on the Hardisc
3. `spikeTrace` - generate CSV trace files from the Spike runs
4. `hardiscTrace` - generate CSV trace files from the hardisc runs
5. `compareTrace` - compare the Spike's and the Hardisc's trace files 
