#define RAM_START 0x10000000
#define UART_READ 0x80000000
#define MAX_DELAY 0x30000000

.section .text.start
.global _start
.type _start, @function

_start:
    li a0, 1
	slli a0, a0, 11
	csrs mie, a0
    la a0, __interrupt
    csrw mtvec, a0
    li a0, UART_READ
    li a4, RAM_START
	csrsi mstatus, 8
    li a1, 0
_first_data_wait:
    beqz a1, _first_data_wait
    csrw mcycle, x0
    csrw mcycleh, x0
    li a6, MAX_DELAY
_loop:
    csrr a3, mcycle
    bltu a3, a6, _loop
_start_from_ram:
    csrci mstatus, 8
    csrw mtvec, x0
    csrw mie, x0
    li a0, RAM_START
    jalr x0, 0x0(a0) 

.section .vectors, "ax"
.option norvc
.align 4
_uart_receive:
    li a1, 1
_receiving:
    lbu a5, 0x0(a0)
    sb a5, 0x0(a4)
    addi a4, a4, 1
    sw x0, 0x4(a0)
    mret
