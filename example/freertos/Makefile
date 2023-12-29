XLEN    = 32
CROSS   = riscv32-unknown-elf-
CC      = $(CROSS)gcc
CPP     = $(CROSS)cpp
OBJCOPY = $(CROSS)objcopy
OBJDUMP = $(CROSS)objdump
ARCH    = $(CROSS)ar
BASE_ADDRESS ?= 0x10000000
MARCH   = rv32imc
MABI    = ilp32
STACK_SIZE = 300

BUILD_DIR       = build
RTOS_DIR	    = ../../../FreeRTOS
RTOS_SOURCE_DIR = $(abspath $(RTOS_DIR)/FreeRTOS/Source)
DEMO_SOURCE_DIR = $(abspath $(RTOS_DIR)/FreeRTOS/Demo/Common/Minimal)

CPPFLAGS = \
	-D__riscv_float_abi_soft \
	-I . -I $(DEMO_SOURCE_DIR)/../include \
	-I $(RTOS_SOURCE_DIR)/include \
	-I $(RTOS_SOURCE_DIR)/portable/GCC/RISC-V \
	-I $(RTOS_SOURCE_DIR)/portable/GCC/RISC-V/chip_specific_extensions/RV32I_CLINT_no_extensions
CFLAGS  = -O2 -march=$(MARCH) -mabi=$(MABI) -mcmodel=medany \
	-Wall \
	-fmessage-length=0 \
	-ffunction-sections \
	-fdata-sections 
LDFLAGS = -nostartfiles \
	-march=$(MARCH) -mabi=$(MABI) -mcmodel=medany \
	-Xlinker --gc-sections \
	-Xlinker --defsym=__stack_size=$(STACK_SIZE)

SRCS = main.c main_blinky.c syscalls.c\
	$(DEMO_SOURCE_DIR)/EventGroupsDemo.c \
	$(DEMO_SOURCE_DIR)/TaskNotify.c \
	$(DEMO_SOURCE_DIR)/TimerDemo.c \
	$(DEMO_SOURCE_DIR)/blocktim.c \
	$(DEMO_SOURCE_DIR)/dynamic.c \
	$(DEMO_SOURCE_DIR)/recmutex.c \
	$(RTOS_SOURCE_DIR)/event_groups.c \
	$(RTOS_SOURCE_DIR)/list.c \
	$(RTOS_SOURCE_DIR)/queue.c \
	$(RTOS_SOURCE_DIR)/stream_buffer.c \
	$(RTOS_SOURCE_DIR)/tasks.c \
	$(RTOS_SOURCE_DIR)/timers.c \
	$(RTOS_SOURCE_DIR)/portable/MemMang/heap_4.c \
	$(RTOS_SOURCE_DIR)/portable/GCC/RISC-V/port.c

ASMS = crt0.S vectors.S \
	$(RTOS_SOURCE_DIR)/portable/GCC/RISC-V/portASM.S

OBJS = $(SRCS:%.c=$(BUILD_DIR)/%.o) $(ASMS:%.S=$(BUILD_DIR)/%.o)

all: clean build disassembly binary

build: $(OBJS)
	$(CC) $(LDFLAGS) $(OBJS) -T link.ld -o $(BUILD_DIR)/RTOSDemo.axf -Xlinker -Map=$(BUILD_DIR)/output.map
	
disassembly: 
	$(OBJDUMP) --disassemble $(BUILD_DIR)/RTOSDemo.axf > $(BUILD_DIR)/RTOSDemo.txt

binary: 
	$(OBJCOPY) -O binary $(BUILD_DIR)/RTOSDemo.axf $(BUILD_DIR)/RTOSDemo.bin

$(BUILD_DIR)/%.o: %.c Makefile
	@mkdir -p $(@D)
	$(CC) $(CPPFLAGS) $(CFLAGS) -MMD -MP -c $< -o $@

$(BUILD_DIR)/%.o: %.S Makefile
	@mkdir -p $(@D)
	$(CC) $(CPPFLAGS) $(CFLAGS) -MMD -MP -c $< -o $@

clean:
	rm -rf $(BUILD_DIR)	
