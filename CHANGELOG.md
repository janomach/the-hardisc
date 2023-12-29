# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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

[1.2.0]: https://github.com/janomach/the-hardisc/releases/tag/v1.2.0
[1.1.0]: https://github.com/janomach/the-hardisc/releases/tag/v1.1.0
[1.0.0]: https://github.com/janomach/the-hardisc/releases/tag/v1.0.0