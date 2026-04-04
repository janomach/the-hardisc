# The Hardisc on Arty A7 FPGA board

This guide shows how to set-up a Vivado project (tested on v2025.1) of the Hardisc demostration platform on [Arty A7](https://digilent.com/reference/programmable-logic/arty-a7/start) FPGA development kit.

The plaform comes with a [bootloader](#bootloader) in the ROM enabling execution of any binary, but may also be used without it for convenient [out-of-the-box](#out-of-the-box-testing) testing. 
It also contains an UART peripheral for serial communication via the devkit's FTDI chip. 
The default configuration is:

* 576000 baud rate
* 1 stop bit
* No parity bit

The platform uses the SW0 slider as a reset input and the SW1 slider as an UART selector.
Before you upload the bitstream, set both sliders to the low state (position closer to the edge of the board).

![Arty A7](https://digilent.com/reference/_media/reference/programmable-logic/arty/arty-2.png)

## Project set-up

1. Open Vivado from this directory 
2. Run the [TCL script](https://github.com/janomach/the-hardisc/tree/main/fpga/project_setup.tcl) in Vivado
    * This step will also generate and open a SEM project that can be closed
3. Check RTL [configuration](https://github.com/janomach/the-hardisc/wiki/Configuration) before a synthesis

More information can be found [here](https://digilent.com/reference/programmable-logic/guides/getting-started-with-vivado).

## Out-of-the-box testing
The FPGA bitstream can be generated from the provided Vivado project without any modifications.
Once you program the bitstream, you can move the SW0 to high state, enabling execution of the pre-compiled [matrix](https://github.com/janomach/the-hardisc/tree/main/example/matrix/test.c) program.

![Matrix Demo](https://github.com/janomach/the-hardisc/raw/main/doc/matrix.gif)

## Bootloader
To download the executable binary file directly to the RAM without a need to re-generate the bitstream, you can use a bootloader.
It resides in ROM and [is part](#memory-file) of the generated bitstream.
The original source code is [here](https://github.com/janomach/the-hardisc/tree/main/example/bootloader/bootloader.S).

The bootloader is used when the `USE_BOOTLOADER` define is specified for the [platform](https://github.com/janomach/the-hardisc/tree/main/fpga/src/platform_artyA7.sv).
When you perform a reset, you can send new binary via the UART.
Once the binary is received (LD10 stops blinking), a 10 second timer is fired
Once the timer overflows, the bootloader redirects execution to RAM.
You can check from which memory location the Hardisc executes the code.
LD4 refers to bootloader's ROM whereas LD5 refers to RAM. 

### Bitstream in flash
Storing bitstream (with bootloader) into the devkit's flash is a very convenient way to avoid programming the bitstream after each power-up.
The process is described [here](https://digilent.com/reference/learn/programmable-logic/tutorials/arty-programming-guide/start?srsltid=AfmBOoqli3H-yjq7-HWXyhip4-huyRvsZdZZhBtCiFKms9ME7MrWwYPX#programming_the_arty_using_quad_spi).

## Memory file
If you want to modify the bootloader or initialize RAM (without bootloader) with different executable binary, you need to generate `.mem` file.
For this purpose, you can leverage [bin2hex](https://github.com/sifive/elf2hex) utility.

Example:

```bash
bin2hex --bit-width 32 test.bin matrix.mem
```

## Fault Injection
It is possible to test the dependability (to some extend) of the Hardisc with the [SEM peripheral](https://github.com/janomach/the-hardisc/tree/main/peripherals/ahb_sem.sv) that can be instructed to inject and correct configuration memory errors.
With the bootloader enabled, you can send the binary of the [fault-injector test](https://github.com/janomach/the-hardisc/tree/main/example/fault_injector/test.c) to the device.
For this purpose, you can leverage a [prepared script](https://github.com/janomach/the-hardisc/tree/main/scripts/send_to_serial.sh) that will also randomize (it is necessary for the fault injection) the rest of the RAM:

```bash
./scripts/send_to_serial.sh 20000 /dev/ttyUSB1 ./example/fault_injector/test.bin
```

> [!IMPORTANT]
> The FPGA platform (except Hardisc) is not protected against faults (yet). 
> It is therefore possible that a fault will cause the system to fail in an unexpected manner.
