#
# Makefile for reri_sim example
#
# Builds a bare-metal RISC-V binary that reads error records from the
# RERI error bank and halts the simulation.
#
# Usage (from the-hardisc/ root):
#   make -f example/reri_sim/Makefile
#
# Output:
#   example/reri_sim/test.bin  — raw binary, load with +BIN=example/reri_sim/test.bin
#   example/reri_sim/test.elf  — ELF (for disassembly / debugging)
#

HARDISC_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST)))../..)
CUSTOM      := $(HARDISC_DIR)/example/custom
OUT_DIR     := $(HARDISC_DIR)/example/reri_sim

RISCV       := /usr
CC          := $(RISCV)/bin/riscv64-unknown-elf-gcc
OBJCOPY     := $(RISCV)/bin/riscv64-unknown-elf-objcopy
OBJDUMP     := $(RISCV)/bin/riscv64-unknown-elf-objdump

CFLAGS := -static -O2 \
           -mcmodel=medany \
           -march=rv32imc \
           -mabi=ilp32 \
           -nostdlib \
           -ffreestanding

SRCS := $(OUT_DIR)/test.c \
        $(OUT_DIR)/stubs.c \
        $(CUSTOM)/crt0.S \
        $(CUSTOM)/vectors.S

LD_SCRIPT   := $(CUSTOM)/link.ld

ELF  := $(OUT_DIR)/test.elf
BIN  := $(OUT_DIR)/test.bin
DUMP := $(OUT_DIR)/test.txt

.PHONY: all clean disasm

all: $(BIN) disasm

$(ELF): $(SRCS) $(LD_SCRIPT)
	$(CC) $(CFLAGS) -T$(LD_SCRIPT) -o $@ $(SRCS) -lgcc

$(BIN): $(ELF)
	$(OBJCOPY) -O binary $< $@

disasm: $(ELF)
	$(OBJDUMP) -d -S $< > $(DUMP)

clean:
	rm -f $(ELF) $(BIN) $(DUMP)
