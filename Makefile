#
#  Copyright 2023 Ján Mach
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#

HARDISC_DIR         := $(shell bash -c 'pwd')
HARDISC_SIM         := $(HARDISC_DIR)/sim
RANDOM              := $(shell bash -c 'echo $$RANDOM')
SV_SEED             := ${RANDOM}
SEE_PROB            := 10
SEE_GROUP           := 1
LAT                 := 0
LOGGING             := 0
HOW                 := gui
BOOT_ADD            := 10000000
SIM_TIMEOUT         := 900000000
TIME_STAMP          :=`date +%H%M%S`
TEST_DIR            := ${HARDISC_DIR}/example/hello_world
BINARY              := "${HARDISC_DIR}/example/hello_world/test.bin"
LD_SCRIPT           := ${HARDISC_DIR}/example/custom/link.ld
SYSCALLS            := ${HARDISC_DIR}/example/custom/syscalls.c
STARTUP             := ${HARDISC_DIR}/example/custom/crt0.S
VECTORS             := ${HARDISC_DIR}/example/custom/vectors.S
CFLAGS              := -static -O3 -mcmodel=medany -march=rv32imc -mabi=ilp32 -nostdlib
RISCV               := /opt/riscv

hardiscSetup:
	vsim -c -do "project new $(HARDISC_SIM) the-hardisc; project addfolder rtl; project addfolder ver; project addfolder peripherals; exit"
	@for f in $(shell ls ${HARDISC_DIR}/rtl | grep \.sv$); do vsim -c -do "project open $(HARDISC_SIM)/the-hardisc.mpf; project addfile $(HARDISC_DIR)/rtl/$${f} SystemVerilog rtl; exit"; done
	@for f in $(shell ls ${HARDISC_DIR}/ver | grep \.sv$); do vsim -c -do "project open $(HARDISC_SIM)/the-hardisc.mpf; project addfile $(HARDISC_DIR)/ver/$${f} SystemVerilog ver; exit"; done
	@for f in $(shell ls ${HARDISC_DIR}/peripherals | grep \.sv$); do vsim -c -do "project open $(HARDISC_SIM)/the-hardisc.mpf; project addfile $(HARDISC_DIR)/peripherals/$${f} SystemVerilog peripherals; exit"; done

hardiscCompile:
	vsim -c -do "project open $(HARDISC_SIM)/the-hardisc.mpf; project calculateorder; project compileall; exit"
	
hardiscSim:
	vsim -${HOW} ${HARDISC_SIM}/work.tb_mh_wrapper +BOOTADD=${BOOT_ADD} +TIMEOUT=${SIM_TIMEOUT} +BIN=${BINARY} +LOGGING=${LOGGING} +SEE_PROB=${SEE_PROB} +SEE_GROUP=${SEE_GROUP} +LAT=${LAT} -sv_seed ${SV_SEED} +LFILE=$(HARDISC_DIR)/hardisc_${TIME_STAMP}.log -do "do ${HARDISC_DIR}/scripts/basic_waves_mh.do; run 100ms"

compileTest:
	riscv32-unknown-elf-gcc -o ${TEST_DIR}/test.o ${TEST_DIR}/test.c ${SYSCALLS} -T ${LD_SCRIPT} ${VECTORS} ${STARTUP} ${CFLAGS} -I ${RISCV}/include -L ${RISCV}/lib -lc -lm -lgcc
	riscv32-unknown-elf-objcopy -O binary ${TEST_DIR}/test.o ${TEST_DIR}/test.bin
	riscv32-unknown-elf-objdump --disassemble ${TEST_DIR}/test.o > ${TEST_DIR}/test.txt
