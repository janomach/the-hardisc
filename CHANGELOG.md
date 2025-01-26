# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.7.0] - 2025-01-26

### Added
 - Possibility to control the availability of ECC in the register file 
 - Possibility to fire interrupt on any unrecoverable error
 - BOP protection - duplication inside the FE stage
 - Fetch Address Comparison - improved protection
 - LSU Address-Phase TMR - improved protection
 - Removed TMR from EXMA and MAWB registers - not necessary anymore
 - Fault Injection Groups and Targets
 - Full-Feature DCLS with stages for temporal redundancy and timing relaxation 

### Changed
 - Reset Point register renamed to Program Counter and moved out of CSRU
 - Port s_hrdmax_rst_o renamed to s_unrec_error_o and duplicated

### Fixed
 - Correction of trace discrepancies

### Removed
 - Possibility to directly fire interrupt on UCE in register file
 - TCLS system

## [1.6.0] - 2024-11-17

### Added
 - New ACM settings related to the RF protection change

### Changed
 - Register File Protection - removal of Single-Point Failures
 - Interface-parity computation has been changed in order to improve protection against MBUs
 - Update of the Static Fault Injection submodule

## [1.5.0] - 2024-07-16

### Added
 - Support for the Static Fault Injection 
 - Support for protected interface (by option PROT_INTF) in a configuration without protected pipeline
 - Examples of lockstepped systems (triple and double) based on the unproted version of the core
 - Tracer supports B-extension instructions 

### Changed
 - Option PROTECTED was renamed to PROT_PIPE (protected pipeline)
 - Maximum number of consecutive restarts in the mhrdctrl0 CSR were set to 4
 - Default size of branch/jump predictors

## [1.4.1] - 2024-05-03

### Fixed
 - Early termination of one MDU could be undetected
 - Predictor and RAS could cause overwriting of IFB

## [1.4.0] - 2024-02-24

### Added
 - Differend types of SEU flip-flops and register files
 - Power optimization - most of the flip-flops have write-enable signals, which improves automatic infer of CG 
 - Power optimization - pipeline registers are updated only if necessary, reducing switching activity
 - Power optimization - configurable refresh/synchronization of individual CSR replicas by the mhrdctrl0
 - Area optimization - custom logical shifters inside the MDU

### Changed
 - Reset type changed from synchronous to asynchronous
 - The reset input has no direct connection to the output signals
 - If the aligner signalizes NOP, the tracer prints nothing instead of "no operation"
 - The CSR executor module was removed, and the CSR-control logic was moved to CSRU
 - File fast_adder.sv is renamed to fast_modules.sv
 - File seu_regs.sv is renamed to seu_ffs.sv

### Fixed
 - Testbench tracing of MDU instruction in the last stage of the core

## [1.3.3] - 2024-02-07

### Changed
 - AHB RAM returns 'x in bytes that were not requested (in a sub-word read request)
 - PMA regions and sizes are aligned to 1KB by default

### Fixed
 - If protection is enabled, sub-word bus read transfers are replaced by word bus read transfers

## [1.3.2] - 2024-02-04

### Changed
 - Address for load-store instructions must always be computed in the OP stage (frequency optimization)
 - Simplification of control logic inside the Preparer

## [1.3.1] - 2024-01-27

### Added
 - Reporting of EDAC errors detected during the RMW sequence

### Fixed
 - Memory error AHB violation
 - Masking uncorrectable errors
 - Bus error does not terminate the RMW sequence

## [1.3.0] - 2024-01-08

### Added
 - Integration of Physical Memory Attribute (PMA) modules

### Changed
 - Propagation of correctable errors at fetch interface from ID to MA stage
 - IMISCON and FETCH error definitions rearranged
 - IMISCON_PRED was removed and merged with IMISCON_DSCR

### Removed
 - Possibility to configure protected core without interface protection
 - Checking of the FETCH address discrepancy since it is not needed anymore (after integration of bus protection)
 - Boot address as a post-compilation option

### Fixed
 - ACM reliability issue

## [1.2.2] - 2024-01-05

### Added
 - The see_insert module enables parametrization of the logging message on SEE insertion

### Changed
 - The deprecated logic of the checksum registers file inside the ACM is replaced by an instance of seu_regs_file module
 - The probability of faults in the signals for clock and reset is set to zero by default

### Fixed
 - Concatenation of labels inside the BOP, IFB, and circular buffer modules
 - Tracing of the FE1 address by the Tracer

## [1.2.1] - 2023-12-30

### Added
 - Peripheral module of ACLINT MTIMER with AMBA 3 AHB-Lite interface
 - MTIMER integrated into the testbench and connected to the core's timer interrupt port _s_int_mtip_i_
 - FreeRTOS demo application with prebuilt binary
 - Figures for the newly launched [Wiki](https://github.com/janomach/the-hardisc/wiki) documentation

### Changed
 - Replication parameters _xxxx_REPS_ defined in the **p_hardisc** package were reduced into two parameters (_PROT_3REP_ for three replicas, _PROT_2REP_ for two replicas)

## [1.2.0] - 2023-12-13

### Added
 - Parity protection for instruction bus interface and data bus interface
 - Configurable option in the hrdctrl0 CSR for automatic restart (only one try) of an instruction that perceived bus error
 - Specification of GROUPS in see_insert modules

### Changed
 - Option EDAC_INTERFACE renamed to IFP (interface protection)
 - Signals connected to the output port of see_wires modules have an "_see" sufix
 - Unused interface signal bundles are moved out of the LSU and the FE stage to the top module
 - The data bus checksum is prepared in each replicated stage within the LSU and connected to the bus via TMR to increase dependability
 - Even if the MA stage does not contain LSU instruction and the data bus is not ready, the pipeline is stalled
 - Simplification of hazard detection logic in the Preparer
 - The see_wires module accepts unpacked arrays at the input/output
 - Bit 0 in the SEE_GROUP option does not enable SEE in all groups
 - The address signal in AHB memories is set to 32-bits

### Removed
 - Support for EDAC interface in NOT PROTECTED core
 - TMR from the MAWB data at the output of the MA stage since it is no longer needed thanks to data bus parity protection (the TMR for data in the ACM remains)
 - General hazards if the EX stage or MA stage contains CSR instruction

### Fixed
 - Propagation of fetch information through the Aligner if it contains the first half of a 32-bit instruction
 - Discrepancy of the IMISCON registers between OP and EX stages is not checked

## [1.1.0] - 2023-11-16

### Added
 - Configurable EDAC protection of incoming and outgoing data for the instruction bus and data bus.
 - Automatic correction of fetched data from the instruction bus inside the **IFB** module.
 - Automatic correction of loaded data from the data bus inside the **LSU** module.
 - A software-transparent Read-Modify-Write mechanism is integrated into the **LSU**, allowing a store of sub-word data in the EDAC-protected memory.
 - Maskable (non-maskable) interrupts for correctable (uncorrectable) errors at EDAC-protected interfaces.
 - The new **s_hold_o** signal is routed from the MA stage into the EX stage to signal that the instruction should be terminated. This solution is necessary for faster interrupt handling and when the EDAC-protected interface is enabled.
 - An assembly file with a Vector table is provided. It also contains an example interrupt handler for correcting the correctable errors in memories with the help of the newly introduced **maddrerr** CSR register.
 - The peripheral AHB memories and the interconnect are extended to provide/receive EDAC checksum.
 - The **ahb_ram** module can generate (emulate) single-event upsets in its memory structure.
 - The testbench is modified to enable simulations with EDAC-protected memories. At the beginning of the simulation, the memories are automatically loaded with appropriate checksums generated from the provided executable binary. 

### Changed
 - EDAC-related modules (**secded_encode** and **secded_decode**) are broken into several modules (**secded_encode**, **secded_analyze**, and **secded_decode**) and an **EDAC** package for better usability.
 - Fetched unaligned data are not shifted to the right by 16 bits before being pushed into the **IFB**.
 - The **IFB** entries are extended by 2 bits, simplifying the propagation of error information and providing space for future functionalities.
 - The **IFB** provides a separate port that signalizes valid data at the output
 - The **Aligner** is updated for compatibility with changes in the FE stage
 - A new pipeline register, **xxxx_IMISCON**, is introduced to propagate misconduct information through the pipeline. This means the information is not propagated via the **xxxx_ICTRL register**, simplifying and clarifying the pipeline.
 - Errors from the **Aligner** are handled in the Decoder, not in the ID stage module
 - Improved propagation of CSR instruction information from the Decoder module
 - The immediate value for CSR instruction propagates from the OP to the EX stage via **OPEX_OP1**, not **OPEX_OP2**. This change simplifies the pipeline.
 - The data bus transfer address propagates from the EX to the MA stage via **EXMA_VAL**, not **EXMA_PAYLOAD**. This allows for reducing the width of the **EXMA_PAYLOAD** register to 12 bits only.
 - The branch offset for an update of the predictor is stored in a new 20-bit register **EXMA_OFFST**, which does not need to be replicated in the protected version of the core.
 - The data bus transfer logic is moved from the EX stage module to the new **LSU** module. The EX stage only approves the initiation of a transfer.
 - The data sent to the data bus are preserved in a new register within the **LSU**. Their alignment is performed during the address phase of the transfer instead of the data phase, as it has been done so far.
 - The data bus exception logic is moved from the MA stage into the **LSU** module.
 - An alignment of the loaded data in the **lsu_decoder** is refined.
 - The evaluation of exceptions and selection of the exception code is moved from the MA stage module into the **csr_executor** module.
 - A new one-bit register **EXMA_TSTRD** is introduced to ensure that the new **s_hold_o** signal from the MA stage does not terminate instruction, which already initiated a data bus transfer.

### Fixed
- The **trace** module incorrectly disassemblies RVI instructions that store values in memory

## [1.0.0] - 2023-09-03

### Added
- Initial public version

[1.7.0]: https://github.com/janomach/the-hardisc/releases/tag/v1.7.0
[1.6.0]: https://github.com/janomach/the-hardisc/releases/tag/v1.6.0
[1.5.0]: https://github.com/janomach/the-hardisc/releases/tag/v1.5.0
[1.4.1]: https://github.com/janomach/the-hardisc/releases/tag/v1.4.1
[1.4.0]: https://github.com/janomach/the-hardisc/releases/tag/v1.4.0
[1.3.3]: https://github.com/janomach/the-hardisc/releases/tag/v1.3.3
[1.3.2]: https://github.com/janomach/the-hardisc/releases/tag/v1.3.2
[1.3.1]: https://github.com/janomach/the-hardisc/releases/tag/v1.3.1
[1.3.0]: https://github.com/janomach/the-hardisc/releases/tag/v1.3.0
[1.2.2]: https://github.com/janomach/the-hardisc/releases/tag/v1.2.2
[1.2.1]: https://github.com/janomach/the-hardisc/releases/tag/v1.2.1
[1.2.0]: https://github.com/janomach/the-hardisc/releases/tag/v1.2.0
[1.1.0]: https://github.com/janomach/the-hardisc/releases/tag/v1.1.0
[1.0.0]: https://github.com/janomach/the-hardisc/releases/tag/v1.0.0
