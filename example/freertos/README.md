## Prerequisites to build FreeRTOS demo

1. GCC compiler for RISC-V, you can get one by cloning and building the [RISC-V toolchain](https://github.com/riscv-collab/riscv-gnu-toolchain)
2. [FreeRTOS](https://github.com/FreeRTOS/FreeRTOS) repository - tested at [this](https://github.com/FreeRTOS/FreeRTOS/tree/85ed21bcfb38d4e3b82eaf6d0ab57aa21f094599) commit
3. The kernel submodule `FreeRTOS/Source` of the FreeRTOS repository
4. Setting the `RTOS_DIR` variable in the Makefile to the path of the cloned FreeRTOS repository
5. The demo can be built by running `make`