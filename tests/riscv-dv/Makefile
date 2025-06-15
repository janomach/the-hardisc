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

MAKEFILE_DIR        := $(shell bash -c 'pwd')
HARDISC_SIM         := $(MAKEFILE_DIR)/../../sim
RISCV_DV_DIR        := $(MAKEFILE_DIR)/../../../riscv-dv
WORK_DIR            := $(MAKEFILE_DIR)/work
RANDOM              := $(shell bash -c 'echo $$RANDOM')
SV_SEED             := ${RANDOM}
SEE_PROB            := 0
SEE_GROUP           := 0
LAT                 := 0
LOGGING             := 0
HOW                 := gui
TIMEOUT_VAL         := 6000000
TEST                := ""
	
prepareRISCVDV:
	cp $(RISCV_DV_DIR)/scripts/spike_log_to_trace_csv.py $(RISCV_DV_DIR)/scripts/hardisc_log_to_trace_csv.py
	sed -i 's/in_trampoline = True/in_trampoline = False/g' $(RISCV_DV_DIR)/scripts/hardisc_log_to_trace_csv.py
# Remove once the bug is fixed: https://github.com/chipsalliance/riscv-dv/issues/1015 
	sed -i 's/parse_iss_yaml(iss, iss_yaml, isa, setting_dir, debug_cmd)/parse_iss_yaml(iss, iss_yaml, isa, \"m\", setting_dir, debug_cmd)/g' $(RISCV_DV_DIR)/run.py
	sed -i 's/ --misaligned//' $(RISCV_DV_DIR)/yaml/iss.yaml

spikeSimPregen:
	run --iss spike --isa rv32imc --mabi ilp32 -o work -s iss_sim --asm_test pregenAsmTests
hardiscSimPregen:
	rm -r -f ${WORK_DIR}/hardisc_sim
	mkdir ${WORK_DIR}/hardisc_sim
	@for f in $(shell ls ${WORK_DIR}/directed_asm_test | grep \.bin$); do echo "Running ${WORK_DIR}/directed_asm_test/$${f}, sv_seed=${SV_SEED}"; vsim -c ${HARDISC_SIM}/work.tb_mh_wrapper -nostdout -do "run 7ms; exit" +BOOTADD=80000000 +TIMEOUT=${TIMEOUT_VAL} +LAT=${LAT} -sv_seed ${SV_SEED} +BIN="${WORK_DIR}/directed_asm_test/$${f}" +LFILE=${WORK_DIR}/hardisc_sim/$${f%.bin}.log; done
spikeTrace:
	@for f in $(shell ls ${WORK_DIR}/spike_sim | grep \.log$); do python $(RISCV_DV_DIR)/scripts/spike_log_to_trace_csv.py --log "${WORK_DIR}/spike_sim/$${f}" --csv ${WORK_DIR}/spike_sim/$${f%.log}.csv; done
hardiscTrace:
	@for f in $(shell ls ${WORK_DIR}/hardisc_sim | grep \.log$); do python $(RISCV_DV_DIR)/scripts/hardisc_log_to_trace_csv.py --log "${WORK_DIR}/hardisc_sim/$${f}" --csv ${WORK_DIR}/hardisc_sim/$${f%.log}.csv; done
compareTrace:
	@for f in $(shell ls ${WORK_DIR}/spike_sim | grep \.csv$); do python $(RISCV_DV_DIR)/scripts/instr_trace_compare.py --csv_file_1 "${WORK_DIR}/spike_sim/$${f}" --csv_file_2 "${WORK_DIR}/hardisc_sim/$${f}" --csv_name_1 spike --csv_name_2 hardiscv; done	
hardiscTest:
	vsim -${HOW} ${HARDISC_SIM}/work.tb_mh_wrapper -nostdout -do "run 7ms; exit" +BOOTADD=80000000 +TIMEOUT=${TIMEOUT_VAL} +LAT=${LAT} -sv_seed ${SV_SEED} +BIN="${WORK_DIR}/directed_asm_test/${TEST}.bin" +LFILE=${WORK_DIR}/hardisc_sim/${TEST}.log +LOGGING=2;

