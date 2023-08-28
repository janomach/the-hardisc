# Hardisc - hardened RISC-V IP core
The Hardisc is a 32-bit **RISC-V** IP core for application in harsh environments, where phenomenons like random bit-flips caused by the **Single-Event-Effects** (SEE) are a concern. 
It contains an in-order 6-stage pipeline with AMBA 3 AHB-Lite instruction/data bus interfaces.
Apart from the base 32-bit integer instruction set (I), the Hardisc also implements standard extensions of compressed instructions (C) and multiply and divide (M) instructions. 
An actual designator of the implemented instruction set is **RV32IMC**. 
The standard RISC-V privilege modes and settings are controlled via instructions from the **Zicsr** extension. 
Only the Machine mode is supported currently. The Hardisc is desribed in SystemVerilog.

![Image](doc/unprotected_pipeline.png)

Most of the processors used in SEE-intense environments are protected by replicating the whole cores, leverage lockstep technique, or require specialized fabrication technologies. 
These approaches limit the system frequency or require multiplies of system area or power consumption compared to an unprotected system with the same functionality. 
The Hardisc **integrates protection in the architecture of the pipeline**, providing faster fault detection and recovery. 
The **protection is separable** from the rest of the pipeline and it is possible to enable/disable it before simulation/synthesis. 
Check the configuration section below.

**For a detailed explanation of the pipeline, information on random bit flips due to SEE, and a survey of currently available protection approaches, check our research paper below. Please consider citing the document in your publications.**

* [In-Pipeline Processor Protection against Soft Errors](https://www.mdpi.com/2287290)

## Fault insertion

The RTL description supports fault the insertion into all flip-flops of the core to simulate bit-flips. 
Some wires were also selected to be prone to SEE, including all clocks and reset trees. 
The faults are inserted randomly in each bit of flip-flop or at the wire; the probability is configurable by options. A fault insertion condition is evaluated for each bit every clock cycle. 
Specific groups of flip-flops and wires are grouped so we can choose groups where fault insertion is enabled.

## Configuration and options
The Hardisc is configurable through options present in *settings.sv* file. 
These are pre-compile-time options. 
Some of the simulation parameters are command-line arguments and can be set post-compilation.

### Pre-Compile time
The Hardisc design is configurable through options present in *settings.sv* file. 

Some options enable functionalities when they are defined:
* **SIMULATION** - enables functionalities present only in the simulation (not-synthesizable)
* **PROTECTED** - enables pipeline protection
* **SEE_TESTING** - enables SEE insertion logic

Other available options:
| Option            | Default  | Description |
| :---------------- | :------: | :---------: |
| FIFO_SIZE         |    4     | Number of entries in Instruction Fetch Buffer  |
| BHT_SIZE          |   64     | Number of entries in Predictor's BHB     |
| BTB_SIZE          |   16     | Number of entries in Predictor's BTB       |
| JTB_SIZE          |    8     | Number of entries in Predictor's JTB       |
| SHARED            |   20     | Number of address bits not saved in Predictor's xTBs       |
| BOP_SIZE          |    3     | Number of entries in Buffer of Predictions |
| RAS_SIZE          |    2     | Number of entries in Return Address Stack  |

### Post-compile time

The simulation options configurable from the command line:

* **BOOTADD** - booting address in hexadecimal numbering system
* **CLKPERIOD** - duration of system clock period in picoseconds
* **TIMEOUT** - simulation time in number of clock-cycles
* **LOGGING** - controls logging verbosity (0-3)
* **LFILE** - file for dumping spike-like trace
* **LAT** - disables (0) or enables (other than 0) memory latencies
* **BIN** - binary to execute
* **SEE_PROB** - probability of SEE insertion
* **SEE_GROUP** - individual bits enables fault insertion in different groups, bit 0 enables each group

## Usage
This repository comes with Makefile, containing commands to set up, compile, and simulate a project in the free edition of ModelSim.
It contains an example testbench, memory, and interconnect IPs for simulation.
The folder */example* contains programs and their binaries that the Hardisc can directly execute in simulation.
If you want to change the source tests, you need a RISC-V toolchain. 
When the toolchain is prepared, you can use the *compileTest* command in the Makefile to compile the selected tests.

Set up and compile the Hardisc project:
```bash
make hardiscSetup
make hardiscCompile
```
Simulate the *hello_world* example with memory latencies:
```bash
make hardiscSim BINARY=example/hello_world/test.bin LAT=1
```
Simulate the *matrix* example with SEE insertion in all groups and logging verbosity 2:
```bash
make hardiscSim BINARY=example/matrix/test.bin LOGGING=2 SEE_PROB=10
```
Compile the *matrix* example test:
```bash
make compileTest TEST_DIR=example/matrix
```

## Notes and limitations
* The architecture of the unprotected pipeline has been developed to integrate protection in the future, so some design approaches were selected with this bias.
* The RTL code style is purposefully selected to allow fault insertion (e.g., flip-flops in the *seu_regs* module).
* No special power optimizations are present.
* The protection of bus interfaces is yet to be integrated.
* The Hardisc is still in development.

## Contributing
We highly appreciate your intention to improve the Hardisc. The contribution guidelines will be announced soon.

## License
Unless otherwise noted, everything in this repository is covered by the Apache License, Version 2.0 (see LICENSE for full text).




