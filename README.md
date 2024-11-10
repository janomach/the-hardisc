# Hardisc - hardened RISC-V IP core
The Hardisc is a 32-bit **RISC-V** IP core for application in harsh environments, where phenomenons like random bit-flips caused by the **soft errors** are a concern. 
It contains an in-order 6-stage pipeline with AMBA 3 AHB-Lite instruction/data bus interfaces. 
The protection is based on a selective replication of resources in the pipeline with a focus on high operational frequency and low area and power consumption.

**The development of the Hardisc is part of the research effort to provide reliable and efficient CPUs for automotive and space applications. Please consider citing the following research papers in your publications.**

* [In-Pipeline Processor Protection against Soft Errors - Article](https://www.mdpi.com/2287290)
* [On-Chip Bus Protection against Soft Errors - Review](https://www.mdpi.com/2566434)
* [Integrating Data Protection at Interface of RISC-V Processor Core](https://doi.org/10.1109/PACET60398.2024.10497010)
* [Interface Protection Against Transient Faults](https://doi.org/10.1109/DDECS60919.2024.10508928)
* [Lockstep Vs Microarchitecture: A Comparison](https://doi.org/10.1109/SOCC62300.2024.10737833)
* [Influence of Structural Units on Vulnerability of Systems with Distinct Protection Approaches](https://doi.org/10.1109/DSD64264.2024.00019)

## Documentation
Refer to the [Wiki](https://github.com/janomach/the-hardisc/wiki) pages for a detailed explanation of the architecture, examples, and more.

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




