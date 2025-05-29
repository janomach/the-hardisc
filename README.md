# Hardisc - hardened RISC-V IP core
The Hardisc is a 32-bit [RISC-V](https://en.wikipedia.org/wiki/RISC-V) IP core for use in safety/mission-critical environments, where random hardware faults, like bit flips caused by [soft errors](https://en.wikipedia.org/wiki/Soft_error), are a concern. 
The core contains an in-order 6-stage pipeline with AMBA 3 AHB-Lite instruction/data bus interfaces.

The Hardisc's protection is based on a selective replication of resources inside the execution pipeline, complemented by ECCs and bus-interface protection.
It provides **fault-tolerance** with minimal area and power consumtion overhead when compared to industry-standard Dual-Core Lockstep (DCLS) systems.

> [!TIP] 
> More information about the protection, as well as results from the fault-injection experiments and physical synthesis, can be found in the open-access research article: [Lockstep Replacement: Fault-Tolerant Design](https://doi.org/10.1109/ACCESS.2025.3573684)

![Hardisc](https://github.com/janomach/the-hardisc/raw/main/doc/hardisc_pcb.jpg)

## Verification
The Hardisc was tested with the [riscv-dv](https://github.com/chipsalliance/riscv-dv) random instruction generator, and the log files were compared with the RISC-V [Spike](https://github.com/riscv-software-src/riscv-isa-sim) golden model.
The verification environment and scripts will be added to the repository soon. 

## Contributing
We highly appreciate your intention to improve the Hardisc.
If you want to contribute, create your branch to commit your changes and open a [Pull Request](https://github.com/janomach/the-hardisc/pulls).
If you have questions about the architecture or want to discuss improvements, please create a new thread in the [Discussions](https://github.com/janomach/the-hardisc/discussions) tab.

### Issues and bugs
If you find any bug or a hole in the protection (also considered a bug), please create a new [Issue report](https://github.com/janomach/the-hardisc/issues).

## License
Unless otherwise noted, everything in this repository is covered by the Apache License, Version 2.0 (see [LICENSE](https://github.com/janomach/the-hardisc/blob/main/LICENSE) for full text).




