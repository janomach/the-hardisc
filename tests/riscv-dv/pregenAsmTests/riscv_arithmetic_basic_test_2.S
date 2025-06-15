.include "user_define.h"
.globl _start
.section .text
_start:           
                  .include "user_init.s"
                  csrr x5, 0xf14
                  li x6, 0
                  beq x5, x6, 0f

0: la x29, h0_start
jalr x0, x29, 0
h0_start:
                  li x13, 0x40001104
                  csrw 0x301, x13
kernel_sp:        
                  la x4, kernel_stack_end

trap_vec_init:    
                  la x13, mtvec_handler
                  ori x13, x13, 0
                  csrw 0x305, x13 # MTVEC

mepc_setup:       
                  la x13, init
                  csrw 0x341, x13

custom_csr_setup: 
                  nop

init_machine_mode:
                  li x13, 0x1800
                  csrw 0x300, x13 # MSTATUS
                  li x13, 0x0
                  csrw 0x304, x13 # MIE
                  mret
init:             
                  li x0, 0x80000000
                  li x1, 0x9
                  li x2, 0xf1b2fa34
                  li x3, 0xf9d37f0a
                  li x5, 0xf87e605f
                  li x6, 0x0
                  li x7, 0x80000000
                  li x8, 0x80000000
                  li x10, 0xaea3f606
                  li x11, 0x80000000
                  li x12, 0x0
                  li x13, 0x80000000
                  li x14, 0xf3b273a0
                  li x15, 0x1
                  li x16, 0xfb0dd7e0
                  li x17, 0x80000000
                  li x18, 0x93ec2e45
                  li x19, 0x0
                  li x20, 0x8
                  li x21, 0xfd51ce64
                  li x22, 0x0
                  li x23, 0x0
                  li x24, 0xf87c106b
                  li x25, 0x0
                  li x26, 0xaeca6b29
                  li x27, 0x450db119
                  li x28, 0x27fd4547
                  li x29, 0x0
                  li x30, 0xd
                  li x31, 0x0
                  la x9, user_stack_end
main:             li           s10, 0x80000000 #start riscv_int_numeric_corner_stream_5
                  li           s7, 0x80000000
                  li           s2, 0xffffffff
                  li           s6, 0xffffffff
                  li           t2, 0xef08b467
                  li           s5, 0x258baf93
                  li           t5, 0x80000000
                  li           a5, 0xffffffff
                  li           t3, 0x41ecaf43
                  li           s4, 0x80000000
                  rem          s2, s7, s5
                  lui          s2, 776755
                  add          a5, a5, s4
                  lui          s2, 776755
                  nop
                  remu         t2, s2, t2
                  lui          s2, 776755
                  addi         t5, s7, -1592
                  auipc        s6, 195699
                  mulhu        a5, s2, s10
                  div          s6, s4, s7
                  rem          s2, s7, s5
                  remu         t2, s2, t2
                  mulhsu       s10, s6, t2
                  addi         t5, s7, -1592
                  nop
                  nop
                  nop
                  add          a5, a5, s4
                  nop
                  nop #end riscv_int_numeric_corner_stream_5
                  li           t1, 0x7bb3e7d7 #start riscv_int_numeric_corner_stream_29
                  li           a0, 0x0
                  li           s7, 0x80000000
                  li           a3, 0x80000000
                  li           s5, 0x80000000
                  li           s4, 0x80000000
                  li           a5, 0x0
                  li           t5, 0x80000000
                  li           ra, 0x0
                  li           t0, 0x80000000
                  sub          a0, t5, s5
                  mulhu        t0, t1, s5
                  mul          t5, t5, a0
                  auipc        a5, 195699
                  rem          t1, s4, a3
                  lui          t1, 776755
                  mulhsu       s5, a5, ra
                  mulh         ra, a3, a0
                  add          t0, t0, a0
                  nop
                  mulhu        t0, t1, s5
                  divu         t0, t0, a3
                  nop
                  mulhsu       s5, a5, ra
                  auipc        a5, 195699
                  remu         ra, t1, ra
                  rem          t1, s4, a3
                  mulh         ra, a3, a0
                  add          t0, t0, a0
                  add          t0, t0, a0
                  mulhsu       s5, a5, ra
                  auipc        a5, 195699
                  lui          t1, 776755
                  rem          t1, s4, a3
                  nop
                  lui          t1, 776755
                  mul          t5, t5, a0 #end riscv_int_numeric_corner_stream_29
                  li           a7, 0x74e52615 #start riscv_int_numeric_corner_stream_15
                  li           a0, 0x0
                  li           s4, 0x39c56836
                  li           t3, 0xffffffff
                  li           a5, 0x80000000
                  li           s2, 0x0
                  li           t1, 0x0
                  li           s0, 0xffffffff
                  li           t0, 0x80000000
                  li           s5, 0x0
                  mulhu        t1, s0, s4
                  mulh         t0, a5, a0
                  sub          a0, t3, s4
                  div          a7, a0, s2
                  mulh         t0, a5, a0
                  sub          a0, t3, s4
                  mulhu        t1, s0, s4
                  mulh         t0, a5, a0
                  sub          a0, t3, s4
                  add          t1, t1, a0
                  sub          a0, t3, s4
                  mul          t3, t3, a0
                  lui          s0, 776755
                  mulhsu       s4, a7, t0
                  div          a7, a0, s2
                  lui          s0, 776755
                  sub          a0, t3, s4
                  lui          s0, 776755
                  auipc        a7, 195699
                  divu         t1, t1, a5
                  rem          s0, s2, a5
                  auipc        a7, 195699
                  add          t1, t1, a0
                  addi         t3, s2, -1592
                  addi         t3, s2, -1592
                  add          t1, t1, a0
                  mulh         t0, a5, a0
                  addi         t3, s2, -1592
                  addi         t3, s2, -1592 #end riscv_int_numeric_corner_stream_15
                  li           a4, 0xffffffff #start riscv_int_numeric_corner_stream_37
                  li           s0, 0xffffffff
                  li           a1, 0xaa9af4ed
                  li           s7, 0x80000000
                  li           s8, 0xf1ecb571
                  li           a7, 0x0
                  li           a5, 0x37c37d8c
                  li           t1, 0xffffffff
                  li           s11, 0xffffffff
                  li           a0, 0xffffffff
                  auipc        a5, 195699
                  mulhu        s0, a0, s7
                  lui          a0, 776755
                  sub          a1, s11, s7
                  addi         s11, a7, -1592
                  mul          s11, s11, a1
                  nop
                  mulhsu       s7, a5, t1
                  mul          s11, s11, a1
                  sub          a1, s11, s7
                  mulhu        s0, a0, s7
                  sub          a1, s11, s7
                  mulhu        s0, a0, s7
                  remu         t1, a0, t1
                  add          s0, s0, a1 #end riscv_int_numeric_corner_stream_37
                  li           s6, 0x2775349c #start riscv_int_numeric_corner_stream_35
                  li           s4, 0x80000000
                  li           s11, 0x3923d084
                  li           sp, 0x488824e0
                  li           ra, 0x0
                  li           a2, 0x0
                  li           s9, 0xd156e142
                  li           a5, 0x80000000
                  li           t5, 0x0
                  li           a4, 0xffffffff
                  auipc        s4, 195699
                  lui          a2, 776755
                  mulhu        sp, a2, s9
                  mulh         ra, a5, a4
                  lui          a2, 776755
                  rem          a2, s6, a5
                  addi         t5, s6, -1592
                  divu         sp, sp, a5
                  remu         ra, a2, ra
                  div          s4, a4, s6
                  rem          a2, s6, a5
                  add          sp, sp, a4
                  auipc        s4, 195699
                  auipc        s4, 195699
                  div          s4, a4, s6
                  mul          t5, t5, a4 #end riscv_int_numeric_corner_stream_35
                  li           a5, 0x0 #start riscv_int_numeric_corner_stream_2
                  li           s4, 0x0
                  li           s11, 0x80000000
                  li           t6, 0xffffffff
                  li           s2, 0x0
                  li           a1, 0xffffffff
                  li           sp, 0xffffffff
                  li           t2, 0x80000000
                  li           s10, 0xffffffff
                  li           a0, 0xffffffff
                  rem          a0, s4, a5
                  nop
                  sub          a1, t6, s10
                  mul          t6, t6, a1
                  lui          a0, 776755
                  mul          t6, t6, a1
                  mulhu        t2, a0, s10
                  remu         sp, a0, sp
                  add          t2, t2, a1
                  mul          t6, t6, a1
                  div          s2, a1, s4
                  auipc        s2, 195699
                  rem          a0, s4, a5
                  auipc        s2, 195699
                  remu         sp, a0, sp
                  divu         t2, t2, a5
                  addi         t6, s4, -1592
                  mulhsu       s10, s2, sp
                  sub          a1, t6, s10
                  remu         sp, a0, sp
                  auipc        s2, 195699
                  rem          a0, s4, a5
                  addi         t6, s4, -1592
                  addi         t6, s4, -1592
                  rem          a0, s4, a5
                  divu         t2, t2, a5 #end riscv_int_numeric_corner_stream_2
                  li           t5, 0xffffffff #start riscv_int_numeric_corner_stream_33
                  li           s9, 0xbd58d26b
                  li           a3, 0x865acd4d
                  li           t0, 0xffffffff
                  li           t3, 0xffffffff
                  li           s3, 0x80000000
                  li           t1, 0x0
                  li           s4, 0xffffffff
                  li           a6, 0x0
                  li           ra, 0x0
                  mulh         ra, a6, a3
                  div          s3, a3, s4
                  rem          t1, s4, a6
                  mulhu        t0, t1, s9
                  mul          t5, t5, a3
                  addi         t5, s4, -1592
                  divu         t0, t0, a6
                  rem          t1, s4, a6
                  add          t0, t0, a3
                  add          t0, t0, a3
                  auipc        s3, 195699
                  nop
                  auipc        s3, 195699
                  add          t0, t0, a3
                  lui          t1, 776755
                  mulhsu       s9, s3, ra
                  auipc        s3, 195699
                  sub          a3, t5, s9
                  addi         t5, s4, -1592
                  mulhu        t0, t1, s9
                  div          s3, a3, s4
                  mul          t5, t5, a3
                  div          s3, a3, s4 #end riscv_int_numeric_corner_stream_33
                  li           gp, 0x7813520f #start riscv_int_numeric_corner_stream_0
                  li           a3, 0x80000000
                  li           s9, 0x80000000
                  li           t0, 0xbd5d87a9
                  li           s2, 0xb75dcc99
                  li           a6, 0xffffffff
                  li           s5, 0xe8d05fd2
                  li           a4, 0xedda4152
                  li           s3, 0x0
                  li           t1, 0x80000000
                  auipc        a6, 195699
                  lui          t1, 776755
                  auipc        a6, 195699
                  mulhsu       s3, a6, gp
                  mulhsu       s3, a6, gp
                  lui          t1, 776755
                  sub          a3, s9, s3
                  divu         t0, t0, a4
                  lui          t1, 776755
                  mulhu        t0, t1, s3
                  divu         t0, t0, a4
                  lui          t1, 776755
                  addi         s9, s2, -1592
                  mulhu        t0, t1, s3
                  mulh         gp, a4, a3
                  lui          t1, 776755
                  mulh         gp, a4, a3
                  mul          s9, s9, a3
                  auipc        a6, 195699
                  auipc        a6, 195699
                  div          a6, a3, s2
                  auipc        a6, 195699
                  sub          a3, s9, s3
                  auipc        a6, 195699
                  sub          a3, s9, s3
                  mulhu        t0, t1, s3 #end riscv_int_numeric_corner_stream_0
                  li           a3, 0x0 #start riscv_int_numeric_corner_stream_10
                  li           s2, 0x4ed98442
                  li           t6, 0x80000000
                  li           s8, 0x0
                  li           s0, 0xffffffff
                  li           t5, 0xffffffff
                  li           t1, 0x80000000
                  li           t0, 0xffffffff
                  li           s6, 0xc714d8de
                  li           s3, 0x342d341e
                  mulh         t0, s2, a3
                  div          s3, a3, s6
                  lui          s0, 776755
                  auipc        s3, 195699
                  mul          t6, t6, a3
                  remu         t0, s0, t0
                  addi         t6, s6, -1592
                  remu         t0, s0, t0
                  auipc        s3, 195699
                  addi         t6, s6, -1592
                  remu         t0, s0, t0
                  div          s3, a3, s6
                  remu         t0, s0, t0
                  mulhsu       s8, s3, t0
                  mulh         t0, s2, a3
                  mulh         t0, s2, a3
                  addi         t6, s6, -1592
                  addi         t6, s6, -1592
                  mul          t6, t6, a3
                  divu         t1, t1, s2
                  sub          a3, t6, s8
                  mulh         t0, s2, a3 #end riscv_int_numeric_corner_stream_10
                  li           ra, 0x0 #start riscv_int_numeric_corner_stream_23
                  li           a6, 0x80000000
                  li           s10, 0x0
                  li           s4, 0x0
                  li           a5, 0x9bc2ae47
                  li           s5, 0xffffffff
                  li           s11, 0x0
                  li           s2, 0x0
                  li           a3, 0xffffffff
                  li           a0, 0x0
                  rem          a3, s4, a6
                  sub          a5, s11, s5
                  mulhsu       s5, s2, ra
                  lui          a3, 776755
                  mulhsu       s5, s2, ra
                  mul          s11, s11, a5
                  rem          a3, s4, a6
                  rem          a3, s4, a6
                  rem          a3, s4, a6
                  remu         ra, a3, ra
                  add          a0, a0, a5
                  auipc        s2, 195699
                  add          a0, a0, a5
                  divu         a0, a0, a6
                  rem          a3, s4, a6
                  lui          a3, 776755
                  mul          s11, s11, a5 #end riscv_int_numeric_corner_stream_23
                  li           t6, 0xffffffff #start riscv_int_numeric_corner_stream_32
                  li           gp, 0x0
                  li           s10, 0x0
                  li           a4, 0xffffffff
                  li           a3, 0x38562293
                  li           s8, 0xffffffff
                  li           s3, 0xffffffff
                  li           s0, 0x80000000
                  li           a5, 0xa669b514
                  li           t5, 0xffffffff
                  mulhu        s0, a3, s10
                  mulh         gp, a5, a4
                  mulhsu       s10, s3, gp
                  divu         s0, s0, a5
                  remu         gp, a3, gp
                  addi         t6, s8, -1592
                  lui          a3, 776755
                  mulhsu       s10, s3, gp
                  add          s0, s0, a4
                  nop
                  lui          a3, 776755
                  sub          a4, t6, s10
                  mulhsu       s10, s3, gp
                  lui          a3, 776755
                  rem          a3, s8, a5
                  lui          a3, 776755
                  sub          a4, t6, s10
                  addi         t6, s8, -1592
                  div          s3, a4, s8
                  rem          a3, s8, a5 #end riscv_int_numeric_corner_stream_32
                  li           t3, 0xffffffff #start riscv_int_numeric_corner_stream_4
                  li           s5, 0xffffffff
                  li           t2, 0xfd94f5fa
                  li           t6, 0x80000000
                  li           gp, 0xc3c27f6b
                  li           a0, 0x80000000
                  li           s8, 0x80000000
                  li           ra, 0x0
                  li           a4, 0xffffffff
                  li           t0, 0x209b138e
                  remu         ra, t0, ra
                  nop
                  lui          t0, 776755
                  div          a4, t2, s5
                  divu         gp, gp, a0
                  mulhu        gp, t0, s8
                  mulh         ra, a0, t2
                  mul          t6, t6, t2
                  lui          t0, 776755
                  lui          t0, 776755
                  divu         gp, gp, a0
                  rem          t0, s5, a0
                  remu         ra, t0, ra
                  lui          t0, 776755
                  add          gp, gp, t2
                  rem          t0, s5, a0
                  lui          t0, 776755
                  mul          t6, t6, t2
                  mulhsu       s8, a4, ra
                  addi         t6, s5, -1592
                  mulhu        gp, t0, s8 #end riscv_int_numeric_corner_stream_4
                  li           s7, 0x0 #start riscv_int_numeric_corner_stream_3
                  li           s4, 0x0
                  li           a2, 0x2456a233
                  li           t0, 0x0
                  li           a5, 0x0
                  li           s2, 0xffffffff
                  li           s10, 0xffffffff
                  li           t6, 0x80000000
                  li           s6, 0x80000000
                  li           a1, 0x9ee1f22a
                  mulh         t0, s2, a5
                  mulhsu       s7, s4, t0
                  mulhu        a1, a2, s7
                  nop
                  mulhu        a1, a2, s7
                  addi         t6, s6, -1592
                  mulh         t0, s2, a5
                  mulhsu       s7, s4, t0
                  divu         a1, a1, s2
                  add          a1, a1, a5
                  addi         t6, s6, -1592
                  rem          a2, s6, s2
                  remu         t0, a2, t0
                  remu         t0, a2, t0
                  mulhu        a1, a2, s7
                  nop
                  auipc        s4, 195699
                  mulhsu       s7, s4, t0
                  div          s4, a5, s6
                  mulh         t0, s2, a5
                  divu         a1, a1, s2
                  mulhu        a1, a2, s7
                  divu         a1, a1, s2 #end riscv_int_numeric_corner_stream_3
                  li           s4, 0xffffffff #start riscv_int_numeric_corner_stream_17
                  li           a7, 0xaa3c9c97
                  li           a6, 0x2beef512
                  li           s5, 0x85554391
                  li           a1, 0xffffffff
                  li           t0, 0xab209077
                  li           s9, 0x0
                  li           t3, 0x0
                  li           t5, 0xffffffff
                  li           s7, 0xffffffff
                  mulh         t0, s4, a7
                  mulh         t0, s4, a7
                  div          s5, a7, s7
                  mulhsu       s9, s5, t0
                  sub          a7, t5, s9
                  mulhu        a1, a6, s9
                  mulhsu       s9, s5, t0
                  mulh         t0, s4, a7
                  sub          a7, t5, s9
                  mul          t5, t5, a7
                  sub          a7, t5, s9
                  auipc        s5, 195699
                  addi         t5, s7, -1592
                  mulhu        a1, a6, s9
                  auipc        s5, 195699
                  mulhsu       s9, s5, t0
                  sub          a7, t5, s9
                  add          a1, a1, a7
                  mulhsu       s9, s5, t0
                  div          s5, a7, s7
                  div          s5, a7, s7
                  divu         a1, a1, s4
                  remu         t0, a6, t0
                  add          a1, a1, a7
                  auipc        s5, 195699
                  divu         a1, a1, s4
                  mulh         t0, s4, a7 #end riscv_int_numeric_corner_stream_17
                  li           a0, 0x80000000 #start riscv_int_numeric_corner_stream_34
                  li           s6, 0x764f3468
                  li           s8, 0x0
                  li           sp, 0x0
                  li           ra, 0x0
                  li           s5, 0xffffffff
                  li           t1, 0xf779f22f
                  li           a7, 0x0
                  li           t0, 0x0
                  li           a5, 0x0
                  lui          t0, 776755
                  sub          t1, s8, s5
                  sub          t1, s8, s5
                  mulhu        sp, t0, s5
                  nop
                  remu         ra, t0, ra
                  sub          t1, s8, s5
                  sub          t1, s8, s5
                  sub          t1, s8, s5
                  mul          s8, s8, t1
                  mul          s8, s8, t1
                  add          sp, sp, t1
                  divu         sp, sp, a0
                  lui          t0, 776755
                  mulhu        sp, t0, s5
                  addi         s8, a7, -1592 #end riscv_int_numeric_corner_stream_34
                  li           t1, 0x67c1492c #start riscv_int_numeric_corner_stream_16
                  li           t3, 0x80000000
                  li           t0, 0x80000000
                  li           s5, 0xd9baa56d
                  li           a3, 0xffffffff
                  li           ra, 0x7ea83247
                  li           a7, 0x23ca692d
                  li           a1, 0x0
                  li           t6, 0x0
                  li           s11, 0xe6be3f10
                  mulhsu       s11, a7, ra
                  nop
                  divu         t0, t0, a3
                  auipc        a7, 195699
                  addi         t6, s5, -1592
                  mul          t6, t6, a1
                  mulh         ra, a3, a1
                  add          t0, t0, a1
                  rem          t1, s5, a3
                  rem          t1, s5, a3
                  lui          t1, 776755
                  nop
                  mulh         ra, a3, a1
                  divu         t0, t0, a3
                  remu         ra, t1, ra
                  divu         t0, t0, a3
                  mulhu        t0, t1, s11
                  addi         t6, s5, -1592
                  rem          t1, s5, a3
                  sub          a1, t6, s11
                  addi         t6, s5, -1592
                  mulh         ra, a3, a1
                  mul          t6, t6, a1
                  div          a7, a1, s5
                  mul          t6, t6, a1
                  remu         ra, t1, ra
                  mulh         ra, a3, a1
                  mulh         ra, a3, a1
                  addi         t6, s5, -1592
                  auipc        a7, 195699 #end riscv_int_numeric_corner_stream_16
                  li           s4, 0x80000000 #start riscv_int_numeric_corner_stream_31
                  li           ra, 0x0
                  li           a7, 0x4c26197
                  li           sp, 0x80000000
                  li           t1, 0xa0b2b62a
                  li           t6, 0x0
                  li           a3, 0x87aedb7f
                  li           t5, 0x0
                  li           a2, 0xffffffff
                  li           s9, 0xf04fd4c1
                  mulhsu       s9, a7, ra
                  auipc        a7, 195699
                  divu         sp, sp, a3
                  auipc        a7, 195699
                  addi         t6, s4, -1592
                  remu         ra, t1, ra
                  add          sp, sp, a2
                  addi         t6, s4, -1592
                  addi         t6, s4, -1592
                  addi         t6, s4, -1592
                  mulhsu       s9, a7, ra
                  rem          t1, s4, a3
                  add          sp, sp, a2
                  mulhsu       s9, a7, ra
                  div          a7, a2, s4
                  mulhsu       s9, a7, ra
                  addi         t6, s4, -1592
                  mulhu        sp, t1, s9
                  mulh         ra, a3, a2
                  divu         sp, sp, a3 #end riscv_int_numeric_corner_stream_31
                  li           a1, 0xffffffff #start riscv_int_numeric_corner_stream_20
                  li           s8, 0x0
                  li           s0, 0xffffffff
                  li           a0, 0xbd5b3a51
                  li           a7, 0xc6fc3d2e
                  li           a4, 0x80000000
                  li           s6, 0x0
                  li           s2, 0xc1755af9
                  li           s4, 0x80000000
                  li           a5, 0x80000000
                  mul          s8, s8, a4
                  divu         a0, a0, a5
                  sub          a4, s8, s4
                  mulhu        a0, a1, s4
                  sub          a4, s8, s4
                  remu         s0, a1, s0
                  nop
                  remu         s0, a1, s0
                  lui          a1, 776755
                  mulhu        a0, a1, s4
                  add          a0, a0, a4
                  remu         s0, a1, s0
                  mulhsu       s4, a7, s0
                  addi         s8, s2, -1592
                  mulhu        a0, a1, s4
                  mulhsu       s4, a7, s0
                  nop
                  mulh         s0, a5, a4 #end riscv_int_numeric_corner_stream_20
                  li           s2, 0x0 #start riscv_int_numeric_corner_stream_38
                  li           s11, 0xc0c942ba
                  li           s7, 0xe9e6666b
                  li           s8, 0x0
                  li           s6, 0x80000000
                  li           gp, 0x2cb8115c
                  li           a2, 0x80000000
                  li           a6, 0xffffffff
                  li           sp, 0xffffffff
                  li           a1, 0x862ca206
                  div          s2, a2, s6
                  addi         s11, s6, -1592
                  mulhu        gp, a1, s7
                  sub          a2, s11, s7
                  div          s2, a2, s6
                  lui          a1, 776755
                  add          gp, gp, a2
                  divu         gp, gp, a6
                  lui          a1, 776755
                  auipc        s2, 195699
                  div          s2, a2, s6
                  div          s2, a2, s6
                  mulhsu       s7, s2, sp
                  div          s2, a2, s6
                  rem          a1, s6, a6
                  auipc        s2, 195699
                  remu         sp, a1, sp
                  nop
                  mul          s11, s11, a2
                  mulh         sp, a6, a2
                  mulhsu       s7, s2, sp #end riscv_int_numeric_corner_stream_38
                  li           t6, 0xffffffff #start riscv_int_numeric_corner_stream_14
                  li           t2, 0x80000000
                  li           a5, 0x63c3a2c
                  li           a1, 0x37fb90d5
                  li           t1, 0x2fb18380
                  li           a4, 0xb7712e2e
                  li           s0, 0x0
                  li           a3, 0x0
                  li           t0, 0xffffffff
                  li           a2, 0x80000000
                  add          t1, t1, s0
                  div          a2, s0, a3
                  rem          t2, a3, a1
                  mulhu        t1, t2, a4
                  addi         t6, a3, -1592
                  nop
                  mulh         t0, a1, s0
                  lui          t2, 776755
                  nop
                  addi         t6, a3, -1592
                  divu         t1, t1, a1
                  div          a2, s0, a3
                  auipc        a2, 195699
                  mulh         t0, a1, s0
                  mul          t6, t6, s0 #end riscv_int_numeric_corner_stream_14
                  li           t0, 0xffffffff #start riscv_int_numeric_corner_stream_8
                  li           s5, 0xffffffff
                  li           a2, 0x80000000
                  li           ra, 0x0
                  li           a5, 0xffffffff
                  li           a1, 0x80000000
                  li           s11, 0x0
                  li           s10, 0xffffffff
                  li           a3, 0xe28a4467
                  li           s0, 0xffffffff
                  sub          a1, s11, s5
                  rem          s0, a5, a2
                  div          a3, a1, a5
                  div          a3, a1, a5
                  divu         t0, t0, a2
                  mulhsu       s5, a3, ra
                  mul          s11, s11, a1
                  addi         s11, a5, -1592
                  divu         t0, t0, a2
                  add          t0, t0, a1
                  mulhsu       s5, a3, ra
                  rem          s0, a5, a2
                  divu         t0, t0, a2
                  rem          s0, a5, a2
                  mulh         ra, a2, a1
                  mul          s11, s11, a1
                  rem          s0, a5, a2
                  lui          s0, 776755
                  sub          a1, s11, s5 #end riscv_int_numeric_corner_stream_8
                  li           a2, 0xffffffff #start riscv_int_numeric_corner_stream_11
                  li           a3, 0x3e9489ef
                  li           s10, 0xffffffff
                  li           s4, 0xffffffff
                  li           a5, 0x80000000
                  li           s3, 0x0
                  li           s2, 0x0
                  li           s9, 0x0
                  li           t1, 0x1e04d573
                  li           gp, 0x21df931e
                  mulh         gp, a5, a3
                  mul          s10, s10, a3
                  rem          a2, s3, a5
                  nop
                  remu         gp, a2, gp
                  mul          s10, s10, a3
                  auipc        s2, 195699
                  add          t1, t1, a3
                  mul          s10, s10, a3
                  mulh         gp, a5, a3
                  sub          a3, s10, s4
                  divu         t1, t1, a5
                  mulhu        t1, a2, s4
                  add          t1, t1, a3
                  auipc        s2, 195699
                  nop
                  mulh         gp, a5, a3
                  sub          a3, s10, s4
                  div          s2, a3, s3
                  auipc        s2, 195699
                  add          t1, t1, a3 #end riscv_int_numeric_corner_stream_11
                  addi         a1, t1, -1592
                  remu         zero, s2, zero
                  add          s3, s11, s3
                  sra          sp, a2, sp
                  c.xor        a3, a5
                  c.or         a5, a4
                  c.nop
                  c.nop
                  slt          t2, a1, s5
                  c.mv         a2, a2
                  c.slli       s4, 24
                  lui          sp, 776755
                  divu         t5, a7, tp
                  auipc        t1, 195699
                  sltu         s9, a4, a0
                  xori         a3, s4, 1809
                  c.addi16sp   sp, -16
                  mulhsu       s0, a1, t4
                  slli         sp, t3, 13
                  c.addi       a2, -1
                  lui          sp, 776755
                  slti         a0, a4, -1207
                  ori          a6, t5, 1716
                  c.mv         a2, a2
                  c.add        sp, s8
                  c.sub        a5, a1
                  lui          sp, 776755
                  sltu         s9, a4, a0
                  addi         a1, t1, -1592
                  nop
                  sra          sp, a2, sp
                  c.addi4spn   a5, sp, 464
                  c.addi       a2, -1
                  slti         a0, a4, -1207
                  sra          sp, a2, sp
                  xor          s11, s5, a1
                  c.nop
                  slti         a0, a4, -1207
                  ori          a6, t5, 1716
                  mulhu        s3, s2, s7
                  c.srai       a4, 2
                  srai         gp, ra, 29
                  srli         s0, s11, 8
                  andi         t6, a4, 389
                  c.and        a5, a4
                  divu         t5, a7, tp
                  slt          t2, a1, s5
                  c.or         a5, a4
                  mul          a1, s1, t5
                  ori          a6, t5, 1716
                  c.srai       a4, 2
                  addi         a1, t1, -1592
                  srl          s5, s7, sp
                  and          s7, a5, a7
                  c.add        sp, s8
                  mulh         zero, a3, gp
                  c.andi       a4, 28
                  c.srli       a2, 1
                  slt          t2, a1, s5
                  c.addi4spn   a5, sp, 464
                  c.slli       s4, 24
                  c.xor        a3, a5
                  ori          a6, t5, 1716
                  lui          sp, 776755
                  c.srai       a4, 2
                  add          s3, s11, s3
                  ori          a6, t5, 1716
                  mulh         zero, a3, gp
                  andi         t6, a4, 389
                  andi         t6, a4, 389
                  c.addi4spn   a5, sp, 464
                  c.add        sp, s8
                  mulhu        s3, s2, s7
                  or           a2, a7, sp
                  and          s7, a5, a7
                  c.mv         a2, a2
                  srai         gp, ra, 29
                  c.add        sp, s8
                  xor          s11, s5, a1
                  sra          sp, a2, sp
                  c.li         a0, 14
                  rem          sp, t6, tp
                  c.srai       a4, 2
                  mul          a1, s1, t5
                  c.srai       a4, 2
                  c.srli       a2, 1
                  c.srai       a4, 2
                  div          t1, s3, a1
                  remu         zero, s2, zero
                  c.addi       a2, -1
                  c.slli       s4, 24
                  c.or         a5, a4
                  c.sub        a5, a1
                  slli         sp, t3, 13
                  addi         a1, t1, -1592
                  c.xor        a3, a5
                  c.li         a0, 14
                  c.srai       a4, 2
                  add          s3, s11, s3
                  mulhsu       s0, a1, t4
                  andi         t6, a4, 389
                  slt          t2, a1, s5
                  c.slli       s4, 24
                  sltiu        t6, s10, -519
                  andi         t6, a4, 389
                  add          s3, s11, s3
                  sltu         s9, a4, a0
                  c.and        a5, a4
                  slt          t2, a1, s5
                  divu         t5, a7, tp
                  add          s3, s11, s3
                  sll          t2, s7, s3
                  c.nop
                  sra          sp, a2, sp
                  mulhu        s3, s2, s7
                  c.srai       a4, 2
                  c.slli       s4, 24
                  sltiu        t6, s10, -519
                  sll          t2, s7, s3
                  sltiu        t6, s10, -519
                  mulh         zero, a3, gp
                  sll          t2, s7, s3
                  andi         t6, a4, 389
                  c.andi       a4, 28
                  srl          s5, s7, sp
                  rem          sp, t6, tp
                  slt          t2, a1, s5
                  c.srai       a4, 2
                  addi         a1, t1, -1592
                  c.sub        a5, a1
                  ori          a6, t5, 1716
                  slti         a0, a4, -1207
                  and          s7, a5, a7
                  slli         sp, t3, 13
                  sra          sp, a2, sp
                  sltu         s9, a4, a0
                  c.andi       a4, 28
                  c.srli       a2, 1
                  slti         a0, a4, -1207
                  c.mv         a2, a2
                  sub          gp, s1, t2
                  c.slli       s4, 24
                  c.add        sp, s8
                  c.mv         a2, a2
                  sll          t2, s7, s3
                  sltu         s9, a4, a0
                  slli         sp, t3, 13
                  slt          t2, a1, s5
                  andi         t6, a4, 389
                  remu         zero, s2, zero
                  mulhu        s3, s2, s7
                  add          s3, s11, s3
                  divu         t5, a7, tp
                  slt          t2, a1, s5
                  mulhu        s3, s2, s7
                  mulhsu       s0, a1, t4
                  c.mv         a2, a2
                  slli         sp, t3, 13
                  c.addi16sp   sp, -16
                  mulhu        s3, s2, s7
                  c.nop
                  mul          a1, s1, t5
                  mulhsu       s0, a1, t4
                  sltu         s9, a4, a0
                  remu         zero, s2, zero
                  rem          sp, t6, tp
                  slli         sp, t3, 13
                  c.addi16sp   sp, -16
                  c.srli       a2, 1
                  c.or         a5, a4
                  c.srai       a4, 2
                  xori         a3, s4, 1809
                  c.addi16sp   sp, -16
                  nop
                  div          t1, s3, a1
                  c.mv         a2, a2
                  c.addi       a2, -1
                  nop
                  remu         zero, s2, zero
                  remu         zero, s2, zero
                  c.addi       a2, -1
                  or           a2, a7, sp
                  slli         sp, t3, 13
                  and          s7, a5, a7
                  c.slli       s4, 24
                  mulhu        s3, s2, s7
                  xor          s11, s5, a1
                  xori         a3, s4, 1809
                  sltu         s9, a4, a0
                  c.srai       a4, 2
                  srli         s0, s11, 8
                  sll          t2, s7, s3
                  nop
                  sltu         s9, a4, a0
                  c.nop
                  remu         zero, s2, zero
                  srl          s5, s7, sp
                  and          s7, a5, a7
                  c.xor        a3, a5
                  divu         t5, a7, tp
                  addi         a1, t1, -1592
                  divu         t5, a7, tp
                  divu         t5, a7, tp
                  div          t1, s3, a1
                  c.addi16sp   sp, -16
                  c.lui        s9, 19
                  sltu         s9, a4, a0
                  slti         a0, a4, -1207
                  sll          t2, s7, s3
                  c.or         a5, a4
                  slli         sp, t3, 13
                  c.and        a5, a4
                  rem          sp, t6, tp
                  slt          t2, a1, s5
                  c.slli       s4, 24
                  c.sub        a5, a1
                  slti         a0, a4, -1207
                  c.or         a5, a4
                  c.srli       a2, 1
                  sll          t2, s7, s3
                  c.and        a5, a4
                  c.nop
                  ori          a6, t5, 1716
                  c.sub        a5, a1
                  sra          sp, a2, sp
                  c.or         a5, a4
                  c.sub        a5, a1
                  c.andi       a4, 28
                  mulhsu       s0, a1, t4
                  c.nop
                  slt          t2, a1, s5
                  c.srli       a2, 1
                  mulhsu       s0, a1, t4
                  srl          s5, s7, sp
                  c.li         a0, 14
                  nop
                  mulhsu       s0, a1, t4
                  div          t1, s3, a1
                  sltiu        t6, s10, -519
                  c.addi16sp   sp, -16
                  c.mv         a2, a2
                  c.andi       a4, 28
                  add          s3, s11, s3
                  c.xor        a3, a5
                  slli         sp, t3, 13
                  xor          s11, s5, a1
                  sltiu        t6, s10, -519
                  c.nop
                  c.addi       a2, -1
                  xori         a3, s4, 1809
                  sltu         s9, a4, a0
                  sltiu        t6, s10, -519
                  ori          a6, t5, 1716
                  srli         s0, s11, 8
                  sll          t2, s7, s3
                  auipc        t1, 195699
                  sltiu        t6, s10, -519
                  slti         a0, a4, -1207
                  sltiu        t6, s10, -519
                  c.mv         a2, a2
                  div          t1, s3, a1
                  addi         a1, t1, -1592
                  and          s7, a5, a7
                  lui          sp, 776755
                  c.or         a5, a4
                  ori          a6, t5, 1716
                  xori         a3, s4, 1809
                  rem          sp, t6, tp
                  sll          t2, s7, s3
                  mulh         zero, a3, gp
                  sra          sp, a2, sp
                  slli         sp, t3, 13
                  mulhsu       s0, a1, t4
                  mulhsu       s0, a1, t4
                  c.mv         a2, a2
                  c.mv         a2, a2
                  mulhu        s3, s2, s7
                  mulhu        s3, s2, s7
                  auipc        t1, 195699
                  slli         sp, t3, 13
                  and          s7, a5, a7
                  and          s7, a5, a7
                  mul          a1, s1, t5
                  c.xor        a3, a5
                  c.and        a5, a4
                  c.slli       s4, 24
                  srl          s5, s7, sp
                  c.or         a5, a4
                  andi         t6, a4, 389
                  c.slli       s4, 24
                  c.sub        a5, a1
                  div          t1, s3, a1
                  nop
                  mulh         zero, a3, gp
                  c.srli       a2, 1
                  add          s3, s11, s3
                  andi         t6, a4, 389
                  rem          sp, t6, tp
                  c.srli       a2, 1
                  addi         a1, t1, -1592
                  slti         a0, a4, -1207
                  remu         zero, s2, zero
                  sub          gp, s1, t2
                  mulhsu       s0, a1, t4
                  c.and        a5, a4
                  nop
                  c.mv         a2, a2
                  lui          sp, 776755
                  ori          a6, t5, 1716
                  mulhu        s3, s2, s7
                  or           a2, a7, sp
                  slt          t2, a1, s5
                  nop
                  andi         t6, a4, 389
                  slli         sp, t3, 13
                  nop
                  c.or         a5, a4
                  c.andi       a4, 28
                  slt          t2, a1, s5
                  or           a2, a7, sp
                  c.add        sp, s8
                  divu         t5, a7, tp
                  c.addi16sp   sp, -16
                  c.slli       s4, 24
                  andi         t6, a4, 389
                  auipc        t1, 195699
                  c.addi       a2, -1
                  auipc        t1, 195699
                  c.addi       a2, -1
                  c.sub        a5, a1
                  srli         s0, s11, 8
                  c.addi       a2, -1
                  c.srli       a2, 1
                  c.srli       a2, 1
                  c.xor        a3, a5
                  lui          sp, 776755
                  c.xor        a3, a5
                  addi         a1, t1, -1592
                  c.srli       a2, 1
                  slli         sp, t3, 13
                  mulh         zero, a3, gp
                  srl          s5, s7, sp
                  srli         s0, s11, 8
                  and          s7, a5, a7
                  c.mv         a2, a2
                  c.addi4spn   a5, sp, 464
                  c.lui        s9, 19
                  slti         a0, a4, -1207
                  sltiu        t6, s10, -519
                  c.srli       a2, 1
                  mulh         zero, a3, gp
                  add          s3, s11, s3
                  div          t1, s3, a1
                  divu         t5, a7, tp
                  mulhu        s3, s2, s7
                  lui          sp, 776755
                  auipc        t1, 195699
                  ori          a6, t5, 1716
                  c.lui        s9, 19
                  slti         a0, a4, -1207
                  c.nop
                  nop
                  mulhu        s3, s2, s7
                  c.and        a5, a4
                  div          t1, s3, a1
                  ori          a6, t5, 1716
                  mul          a1, s1, t5
                  c.addi4spn   a5, sp, 464
                  slli         sp, t3, 13
                  slli         sp, t3, 13
                  mulhu        s3, s2, s7
                  c.addi16sp   sp, -16
                  sub          gp, s1, t2
                  xori         a3, s4, 1809
                  srai         gp, ra, 29
                  div          t1, s3, a1
                  c.addi       a2, -1
                  c.xor        a3, a5
                  mulhsu       s0, a1, t4
                  mulh         zero, a3, gp
                  c.srai       a4, 2
                  remu         zero, s2, zero
                  mulhu        s3, s2, s7
                  c.slli       s4, 24
                  c.addi       a2, -1
                  addi         a1, t1, -1592
                  srli         s0, s11, 8
                  c.or         a5, a4
                  slli         sp, t3, 13
                  c.addi16sp   sp, -16
                  sltu         s9, a4, a0
                  sltiu        t6, s10, -519
                  add          s3, s11, s3
                  div          t1, s3, a1
                  c.or         a5, a4
                  c.slli       s4, 24
                  c.add        sp, s8
                  and          s7, a5, a7
                  c.sub        a5, a1
                  slli         sp, t3, 13
                  add          s3, s11, s3
                  srai         gp, ra, 29
                  mul          a1, s1, t5
                  c.slli       s4, 24
                  sll          t2, s7, s3
                  c.and        a5, a4
                  c.addi4spn   a5, sp, 464
                  xori         a3, s4, 1809
                  srl          s5, s7, sp
                  divu         t5, a7, tp
                  c.or         a5, a4
                  mulhsu       s0, a1, t4
                  xor          s11, s5, a1
                  mul          a1, s1, t5
                  nop
                  c.addi       a2, -1
                  c.add        sp, s8
                  srai         gp, ra, 29
                  c.andi       a4, 28
                  c.li         a0, 14
                  c.srli       a2, 1
                  srli         s0, s11, 8
                  and          s7, a5, a7
                  rem          sp, t6, tp
                  c.addi       a2, -1
                  and          s7, a5, a7
                  c.nop
                  remu         zero, s2, zero
                  sll          t2, s7, s3
                  c.li         a0, 14
                  remu         zero, s2, zero
                  c.srai       a4, 2
                  mulhsu       s0, a1, t4
                  c.srai       a4, 2
                  c.add        sp, s8
                  c.srli       a2, 1
                  c.mv         a2, a2
                  nop
                  c.and        a5, a4
                  andi         t6, a4, 389
                  c.addi       a2, -1
                  lui          sp, 776755
                  andi         t6, a4, 389
                  srai         gp, ra, 29
                  or           a2, a7, sp
                  mulh         zero, a3, gp
                  c.sub        a5, a1
                  mulhu        s3, s2, s7
                  sll          t2, s7, s3
                  sub          gp, s1, t2
                  slli         sp, t3, 13
                  c.add        sp, s8
                  sra          sp, a2, sp
                  nop
                  nop
                  sltiu        t6, s10, -519
                  mul          a1, s1, t5
                  srl          s5, s7, sp
                  c.sub        a5, a1
                  lui          sp, 776755
                  div          t1, s3, a1
                  c.andi       a4, 28
                  c.slli       s4, 24
                  srl          s5, s7, sp
                  c.lui        s9, 19
                  sltiu        t6, s10, -519
                  c.addi       a2, -1
                  srli         s0, s11, 8
                  sll          t2, s7, s3
                  c.and        a5, a4
                  and          s7, a5, a7
                  xor          s11, s5, a1
                  and          s7, a5, a7
                  addi         a1, t1, -1592
                  slt          t2, a1, s5
                  mulh         zero, a3, gp
                  add          s3, s11, s3
                  remu         zero, s2, zero
                  c.addi16sp   sp, -16
                  c.lui        s9, 19
                  c.addi       a2, -1
                  c.add        sp, s8
                  c.srai       a4, 2
                  divu         t5, a7, tp
                  c.srai       a4, 2
                  c.sub        a5, a1
                  add          s3, s11, s3
                  lui          sp, 776755
                  mulhu        s3, s2, s7
                  c.mv         a2, a2
                  sltiu        t6, s10, -519
                  c.li         a0, 14
                  c.add        sp, s8
                  c.nop
                  sub          gp, s1, t2
                  c.slli       s4, 24
                  sra          sp, a2, sp
                  mulhsu       s0, a1, t4
                  c.andi       a4, 28
                  and          s7, a5, a7
                  c.nop
                  c.xor        a3, a5
                  c.addi16sp   sp, -16
                  slt          t2, a1, s5
                  add          s3, s11, s3
                  srl          s5, s7, sp
                  slt          t2, a1, s5
                  sltu         s9, a4, a0
                  c.srli       a2, 1
                  c.addi       a2, -1
                  andi         t6, a4, 389
                  srl          s5, s7, sp
                  sltiu        t6, s10, -519
                  auipc        t1, 195699
                  auipc        t1, 195699
                  c.addi16sp   sp, -16
                  mul          a1, s1, t5
                  ori          a6, t5, 1716
                  mulh         zero, a3, gp
                  lui          sp, 776755
                  auipc        t1, 195699
                  addi         a1, t1, -1592
                  c.nop
                  div          t1, s3, a1
                  add          s3, s11, s3
                  sltiu        t6, s10, -519
                  slt          t2, a1, s5
                  div          t1, s3, a1
                  c.sub        a5, a1
                  remu         zero, s2, zero
                  c.sub        a5, a1
                  auipc        t1, 195699
                  sltu         s9, a4, a0
                  c.lui        s9, 19
                  slti         a0, a4, -1207
                  c.addi16sp   sp, -16
                  sltiu        t6, s10, -519
                  sll          t2, s7, s3
                  c.addi16sp   sp, -16
                  remu         zero, s2, zero
                  mulh         zero, a3, gp
                  sltu         s9, a4, a0
                  c.mv         a2, a2
                  and          s7, a5, a7
                  c.andi       a4, 28
                  slti         a0, a4, -1207
                  xori         a3, s4, 1809
                  srl          s5, s7, sp
                  mul          a1, s1, t5
                  sub          gp, s1, t2
                  divu         t5, a7, tp
                  srai         gp, ra, 29
                  andi         t6, a4, 389
                  srl          s5, s7, sp
                  srli         s0, s11, 8
                  c.and        a5, a4
                  xor          s11, s5, a1
                  c.xor        a3, a5
                  sra          sp, a2, sp
                  srai         gp, ra, 29
                  c.li         a0, 14
                  andi         t6, a4, 389
                  c.addi16sp   sp, -16
                  c.addi4spn   a5, sp, 464
                  mul          a1, s1, t5
                  or           a2, a7, sp
                  sll          t2, s7, s3
                  add          s3, s11, s3
                  c.or         a5, a4
                  lui          sp, 776755
                  addi         a1, t1, -1592
                  andi         t6, a4, 389
                  ori          a6, t5, 1716
                  c.andi       a4, 28
                  slli         sp, t3, 13
                  andi         t6, a4, 389
                  slli         sp, t3, 13
                  c.addi       a2, -1
                  srl          s5, s7, sp
                  sra          sp, a2, sp
                  c.andi       a4, 28
                  andi         t6, a4, 389
                  srai         gp, ra, 29
                  sra          sp, a2, sp
                  slli         sp, t3, 13
                  div          t1, s3, a1
                  c.mv         a2, a2
                  sll          t2, s7, s3
                  ori          a6, t5, 1716
                  mulhu        s3, s2, s7
                  c.andi       a4, 28
                  c.li         a0, 14
                  c.addi       a2, -1
                  lui          sp, 776755
                  mulhu        s3, s2, s7
                  c.addi       a2, -1
                  addi         a1, t1, -1592
                  srli         s0, s11, 8
                  c.or         a5, a4
                  xori         a3, s4, 1809
                  c.sub        a5, a1
                  and          s7, a5, a7
                  sltu         s9, a4, a0
                  c.addi16sp   sp, -16
                  sra          sp, a2, sp
                  divu         t5, a7, tp
                  lui          sp, 776755
                  sltu         s9, a4, a0
                  c.add        sp, s8
                  c.addi4spn   a5, sp, 464
                  c.xor        a3, a5
                  srli         s0, s11, 8
                  slti         a0, a4, -1207
                  lui          sp, 776755
                  c.mv         a2, a2
                  slli         sp, t3, 13
                  andi         t6, a4, 389
                  mul          a1, s1, t5
                  c.addi16sp   sp, -16
                  rem          sp, t6, tp
                  c.lui        s9, 19
                  add          s3, s11, s3
                  sra          sp, a2, sp
                  mul          a1, s1, t5
                  remu         zero, s2, zero
                  srai         gp, ra, 29
                  slti         a0, a4, -1207
                  slli         sp, t3, 13
                  div          t1, s3, a1
                  slli         sp, t3, 13
                  c.and        a5, a4
                  xor          s11, s5, a1
                  srl          s5, s7, sp
                  andi         t6, a4, 389
                  c.slli       s4, 24
                  divu         t5, a7, tp
                  lui          sp, 776755
                  c.sub        a5, a1
                  sll          t2, s7, s3
                  sra          sp, a2, sp
                  c.srai       a4, 2
                  divu         t5, a7, tp
                  lui          sp, 776755
                  mulh         zero, a3, gp
                  xori         a3, s4, 1809
                  sll          t2, s7, s3
                  c.xor        a3, a5
                  mulhsu       s0, a1, t4
                  divu         t5, a7, tp
                  c.srai       a4, 2
                  mulhsu       s0, a1, t4
                  c.lui        s9, 19
                  add          s3, s11, s3
                  or           a2, a7, sp
                  srl          s5, s7, sp
                  c.nop
                  sltu         s9, a4, a0
                  sub          gp, s1, t2
                  remu         zero, s2, zero
                  lui          sp, 776755
                  lui          sp, 776755
                  nop
                  c.mv         a2, a2
                  rem          sp, t6, tp
                  sltiu        t6, s10, -519
                  c.nop
                  c.and        a5, a4
                  mul          a1, s1, t5
                  c.and        a5, a4
                  addi         a1, t1, -1592
                  sra          sp, a2, sp
                  rem          sp, t6, tp
                  xor          s11, s5, a1
                  addi         a1, t1, -1592
                  c.add        sp, s8
                  c.and        a5, a4
                  slt          t2, a1, s5
                  add          s3, s11, s3
                  c.xor        a3, a5
                  sra          sp, a2, sp
                  slti         a0, a4, -1207
                  srli         s0, s11, 8
                  c.xor        a3, a5
                  slt          t2, a1, s5
                  c.xor        a3, a5
                  c.srli       a2, 1
                  c.or         a5, a4
                  c.slli       s4, 24
                  addi         a1, t1, -1592
                  c.li         a0, 14
                  c.nop
                  slti         a0, a4, -1207
                  c.and        a5, a4
                  sltiu        t6, s10, -519
                  mul          a1, s1, t5
                  sll          t2, s7, s3
                  and          s7, a5, a7
                  c.andi       a4, 28
                  srli         s0, s11, 8
                  auipc        t1, 195699
                  add          s3, s11, s3
                  c.addi16sp   sp, -16
                  add          s3, s11, s3
                  c.addi       a2, -1
                  mul          a1, s1, t5
                  sltu         s9, a4, a0
                  mulhu        s3, s2, s7
                  sll          t2, s7, s3
                  mulh         zero, a3, gp
                  slt          t2, a1, s5
                  c.xor        a3, a5
                  c.srai       a4, 2
                  mulh         zero, a3, gp
                  addi         a1, t1, -1592
                  xori         a3, s4, 1809
                  xori         a3, s4, 1809
                  addi         a1, t1, -1592
                  slt          t2, a1, s5
                  mulh         zero, a3, gp
                  or           a2, a7, sp
                  remu         zero, s2, zero
                  c.addi16sp   sp, -16
                  c.sub        a5, a1
                  mulh         zero, a3, gp
                  c.nop
                  c.nop
                  c.sub        a5, a1
                  c.addi16sp   sp, -16
                  sra          sp, a2, sp
                  add          s3, s11, s3
                  c.andi       a4, 28
                  c.or         a5, a4
                  mulhu        s3, s2, s7
                  and          s7, a5, a7
                  srl          s5, s7, sp
                  c.addi       a2, -1
                  c.slli       s4, 24
                  sll          t2, s7, s3
                  xor          s11, s5, a1
                  c.li         a0, 14
                  c.srli       a2, 1
                  sub          gp, s1, t2
                  slli         sp, t3, 13
                  mulhsu       s0, a1, t4
                  add          s3, s11, s3
                  slli         sp, t3, 13
                  andi         t6, a4, 389
                  c.nop
                  add          s3, s11, s3
                  divu         t5, a7, tp
                  andi         t6, a4, 389
                  or           a2, a7, sp
                  remu         zero, s2, zero
                  sub          gp, s1, t2
                  nop
                  c.nop
                  slt          t2, a1, s5
                  remu         zero, s2, zero
                  slti         a0, a4, -1207
                  c.add        sp, s8
                  ori          a6, t5, 1716
                  c.addi       a2, -1
                  c.addi       a2, -1
                  remu         zero, s2, zero
                  c.srai       a4, 2
                  c.li         a0, 14
                  mulh         zero, a3, gp
                  c.or         a5, a4
                  slli         sp, t3, 13
                  or           a2, a7, sp
                  sll          t2, s7, s3
                  c.srai       a4, 2
                  auipc        t1, 195699
                  xor          s11, s5, a1
                  c.and        a5, a4
                  and          s7, a5, a7
                  nop
                  sltu         s9, a4, a0
                  sltiu        t6, s10, -519
                  mulhu        s3, s2, s7
                  add          s3, s11, s3
                  sltiu        t6, s10, -519
                  nop
                  addi         a1, t1, -1592
                  mul          a1, s1, t5
                  c.add        sp, s8
                  mulhu        s3, s2, s7
                  lui          sp, 776755
                  xor          s11, s5, a1
                  slt          t2, a1, s5
                  srai         gp, ra, 29
                  sra          sp, a2, sp
                  divu         t5, a7, tp
                  sra          sp, a2, sp
                  xori         a3, s4, 1809
                  and          s7, a5, a7
                  c.srai       a4, 2
                  c.nop
                  sub          gp, s1, t2
                  c.nop
                  divu         t5, a7, tp
                  sltiu        t6, s10, -519
                  sub          gp, s1, t2
                  slli         sp, t3, 13
                  auipc        t1, 195699
                  xor          s11, s5, a1
                  srai         gp, ra, 29
                  sll          t2, s7, s3
                  and          s7, a5, a7
                  mulh         zero, a3, gp
                  mulhu        s3, s2, s7
                  srai         gp, ra, 29
                  sra          sp, a2, sp
                  or           a2, a7, sp
                  c.andi       a4, 28
                  c.addi16sp   sp, -16
                  c.addi       a2, -1
                  c.addi4spn   a5, sp, 464
                  sra          sp, a2, sp
                  andi         t6, a4, 389
                  srli         s0, s11, 8
                  nop
                  and          s7, a5, a7
                  divu         t5, a7, tp
                  nop
                  c.addi       a2, -1
                  sltiu        t6, s10, -519
                  div          t1, s3, a1
                  remu         zero, s2, zero
                  ori          a6, t5, 1716
                  auipc        t1, 195699
                  slli         sp, t3, 13
                  mul          a1, s1, t5
                  divu         t5, a7, tp
                  sub          gp, s1, t2
                  addi         a1, t1, -1592
                  c.mv         a2, a2
                  slli         sp, t3, 13
                  c.mv         a2, a2
                  divu         t5, a7, tp
                  remu         zero, s2, zero
                  c.or         a5, a4
                  c.slli       s4, 24
                  xor          s11, s5, a1
                  xor          s11, s5, a1
                  nop
                  xor          s11, s5, a1
                  c.add        sp, s8
                  mulhsu       s0, a1, t4
                  lui          sp, 776755
                  div          t1, s3, a1
                  srli         s0, s11, 8
                  div          t1, s3, a1
                  xor          s11, s5, a1
                  add          s3, s11, s3
                  lui          sp, 776755
                  sltiu        t6, s10, -519
                  mulh         zero, a3, gp
                  addi         a1, t1, -1592
                  sra          sp, a2, sp
                  c.addi4spn   a5, sp, 464
                  c.add        sp, s8
                  lui          sp, 776755
                  div          t1, s3, a1
                  or           a2, a7, sp
                  c.mv         a2, a2
                  sltu         s9, a4, a0
                  sra          sp, a2, sp
                  lui          sp, 776755
                  slt          t2, a1, s5
                  c.sub        a5, a1
                  slli         sp, t3, 13
                  srl          s5, s7, sp
                  and          s7, a5, a7
                  auipc        t1, 195699
                  addi         a1, t1, -1592
                  div          t1, s3, a1
                  c.lui        s9, 19
                  c.mv         a2, a2
                  c.addi       a2, -1
                  c.nop
                  and          s7, a5, a7
                  sltu         s9, a4, a0
                  c.slli       s4, 24
                  mulhsu       s0, a1, t4
                  c.srai       a4, 2
                  c.li         a0, 14
                  c.or         a5, a4
                  sra          sp, a2, sp
                  slli         sp, t3, 13
                  c.addi       a2, -1
                  c.or         a5, a4
                  c.mv         a2, a2
                  srai         gp, ra, 29
                  sltiu        t6, s10, -519
                  c.sub        a5, a1
                  slli         sp, t3, 13
                  c.andi       a4, 28
                  sra          sp, a2, sp
                  c.sub        a5, a1
                  divu         t5, a7, tp
                  divu         t5, a7, tp
                  slli         sp, t3, 13
                  slli         sp, t3, 13
                  c.lui        s9, 19
                  c.addi       a2, -1
                  c.or         a5, a4
                  sltiu        t6, s10, -519
                  c.andi       a4, 28
                  ori          a6, t5, 1716
                  sll          t2, s7, s3
                  c.srai       a4, 2
                  c.addi       a2, -1
                  sll          t2, s7, s3
                  auipc        t1, 195699
                  srl          s5, s7, sp
                  c.addi       a2, -1
                  slt          t2, a1, s5
                  c.mv         a2, a2
                  rem          sp, t6, tp
                  mul          a1, s1, t5
                  c.andi       a4, 28
                  ori          a6, t5, 1716
                  c.sub        a5, a1
                  slli         sp, t3, 13
                  c.or         a5, a4
                  div          t1, s3, a1
                  srl          s5, s7, sp
                  andi         t6, a4, 389
                  remu         zero, s2, zero
                  mul          a1, s1, t5
                  or           a2, a7, sp
                  sll          t2, s7, s3
                  xori         a3, s4, 1809
                  srl          s5, s7, sp
                  c.addi4spn   a5, sp, 464
                  srl          s5, s7, sp
                  c.xor        a3, a5
                  slt          t2, a1, s5
                  c.andi       a4, 28
                  c.addi4spn   a5, sp, 464
                  andi         t6, a4, 389
                  c.addi4spn   a5, sp, 464
                  sltiu        t6, s10, -519
                  c.li         a0, 14
                  srai         gp, ra, 29
                  slti         a0, a4, -1207
                  nop
                  auipc        t1, 195699
                  c.andi       a4, 28
                  nop
                  mulhu        s3, s2, s7
                  mul          a1, s1, t5
                  sub          gp, s1, t2
                  c.xor        a3, a5
                  c.and        a5, a4
                  c.addi       a2, -1
                  c.addi4spn   a5, sp, 464
                  srli         s0, s11, 8
                  sltiu        t6, s10, -519
                  addi         a1, t1, -1592
                  c.li         a0, 14
                  c.and        a5, a4
                  c.addi       a2, -1
                  c.addi4spn   a5, sp, 464
                  slli         sp, t3, 13
                  rem          sp, t6, tp
                  sll          t2, s7, s3
                  auipc        t1, 195699
                  ori          a6, t5, 1716
                  c.addi4spn   a5, sp, 464
                  mulh         zero, a3, gp
                  c.and        a5, a4
                  srli         s0, s11, 8
                  mul          a1, s1, t5
                  rem          sp, t6, tp
                  sltiu        t6, s10, -519
                  and          s7, a5, a7
                  c.nop
                  c.lui        s9, 19
                  c.sub        a5, a1
                  c.addi       a2, -1
                  div          t1, s3, a1
                  c.addi       a2, -1
                  srli         s0, s11, 8
                  c.andi       a4, 28
                  divu         t5, a7, tp
                  c.xor        a3, a5
                  c.srli       a2, 1
                  srl          s5, s7, sp
                  sltu         s9, a4, a0
                  c.or         a5, a4
                  addi         a1, t1, -1592
                  c.slli       s4, 24
                  slt          t2, a1, s5
                  c.slli       s4, 24
                  srl          s5, s7, sp
                  c.sub        a5, a1
                  srli         s0, s11, 8
                  slli         sp, t3, 13
                  sltu         s9, a4, a0
                  c.mv         a2, a2
                  sltu         s9, a4, a0
                  c.srai       a4, 2
                  c.nop
                  c.slli       s4, 24
                  sub          gp, s1, t2
                  rem          sp, t6, tp
                  addi         a1, t1, -1592
                  c.or         a5, a4
                  slti         a0, a4, -1207
                  c.li         a0, 14
                  remu         zero, s2, zero
                  srli         s0, s11, 8
                  andi         t6, a4, 389
                  c.srai       a4, 2
                  ori          a6, t5, 1716
                  nop
                  srai         gp, ra, 29
                  xor          s11, s5, a1
                  c.sub        a5, a1
                  mulhu        s3, s2, s7
                  xor          s11, s5, a1
                  slli         sp, t3, 13
                  c.addi16sp   sp, -16
                  sub          gp, s1, t2
                  xori         a3, s4, 1809
                  slli         sp, t3, 13
                  srl          s5, s7, sp
                  c.addi16sp   sp, -16
                  addi         a1, t1, -1592
                  sltu         s9, a4, a0
                  sltiu        t6, s10, -519
                  divu         t5, a7, tp
                  slli         sp, t3, 13
                  ori          a6, t5, 1716
                  mulhsu       s0, a1, t4
                  xor          s11, s5, a1
                  sltiu        t6, s10, -519
                  sra          sp, a2, sp
                  slli         sp, t3, 13
                  xor          s11, s5, a1
                  mulhsu       s0, a1, t4
                  c.sub        a5, a1
                  c.and        a5, a4
                  div          t1, s3, a1
                  rem          sp, t6, tp
                  xori         a3, s4, 1809
                  c.or         a5, a4
                  rem          sp, t6, tp
                  sll          t2, s7, s3
                  c.addi4spn   a5, sp, 464
                  sub          gp, s1, t2
                  div          t1, s3, a1
                  xori         a3, s4, 1809
                  srai         gp, ra, 29
                  add          s3, s11, s3
                  slt          t2, a1, s5
                  c.and        a5, a4
                  add          s3, s11, s3
                  slt          t2, a1, s5
                  slli         sp, t3, 13
                  slli         sp, t3, 13
                  c.and        a5, a4
                  lui          sp, 776755
                  c.sub        a5, a1
                  div          t1, s3, a1
                  rem          sp, t6, tp
                  c.or         a5, a4
                  c.nop
                  or           a2, a7, sp
                  c.srli       a2, 1
                  c.nop
                  c.sub        a5, a1
                  sub          gp, s1, t2
                  c.addi16sp   sp, -16
                  c.lui        s9, 19
                  c.andi       a4, 28
                  slt          t2, a1, s5
                  c.addi4spn   a5, sp, 464
                  sltiu        t6, s10, -519
                  divu         t5, a7, tp
                  sltu         s9, a4, a0
                  mulh         zero, a3, gp
                  srai         gp, ra, 29
                  c.mv         a2, a2
                  c.xor        a3, a5
                  c.lui        s9, 19
                  mulhsu       s0, a1, t4
                  mulh         zero, a3, gp
                  c.addi       a2, -1
                  sltu         s9, a4, a0
                  nop
                  xor          s11, s5, a1
                  lui          sp, 776755
                  nop
                  srli         s0, s11, 8
                  rem          sp, t6, tp
                  divu         t5, a7, tp
                  or           a2, a7, sp
                  c.srli       a2, 1
                  andi         t6, a4, 389
                  sra          sp, a2, sp
                  c.lui        s9, 19
                  lui          sp, 776755
                  c.lui        s9, 19
                  c.addi16sp   sp, -16
                  c.srli       a2, 1
                  c.addi4spn   a5, sp, 464
                  nop
                  c.addi16sp   sp, -16
                  xori         a3, s4, 1809
                  c.addi4spn   a5, sp, 464
                  sltiu        t6, s10, -519
                  div          t1, s3, a1
                  mulhsu       s0, a1, t4
                  ori          a6, t5, 1716
                  add          s3, s11, s3
                  c.nop
                  slti         a0, a4, -1207
                  xori         a3, s4, 1809
                  c.add        sp, s8
                  rem          sp, t6, tp
                  remu         zero, s2, zero
                  c.and        a5, a4
                  xori         a3, s4, 1809
                  auipc        t1, 195699
                  c.addi       a2, -1
                  srl          s5, s7, sp
                  slt          t2, a1, s5
                  c.nop
                  lui          sp, 776755
                  remu         zero, s2, zero
                  mulhu        s3, s2, s7
                  mulhsu       s0, a1, t4
                  andi         t6, a4, 389
                  c.or         a5, a4
                  c.and        a5, a4
                  c.srai       a4, 2
                  divu         t5, a7, tp
                  c.and        a5, a4
                  rem          sp, t6, tp
                  c.addi16sp   sp, -16
                  li           a0, 0xffffffff #start riscv_int_numeric_corner_stream_24
                  li           t6, 0x0
                  li           s8, 0x80000000
                  li           s6, 0x0
                  li           t2, 0x80000000
                  li           s3, 0x80000000
                  li           t5, 0x0
                  li           a6, 0x80000000
                  li           t0, 0x0
                  li           a2, 0x0
                  auipc        s3, 195699
                  addi         t6, s6, -1592
                  auipc        s3, 195699
                  lui          a0, 776755
                  add          t2, t2, a2
                  div          s3, a2, s6
                  lui          a0, 776755
                  divu         t2, t2, a6
                  remu         t0, a0, t0
                  auipc        s3, 195699
                  mulh         t0, a6, a2
                  div          s3, a2, s6
                  rem          a0, s6, a6
                  div          s3, a2, s6
                  sub          a2, t6, s8
                  mulhsu       s8, s3, t0
                  rem          a0, s6, a6
                  mulhu        t2, a0, s8
                  sub          a2, t6, s8 #end riscv_int_numeric_corner_stream_24
                  c.addi4spn   a5, sp, 464
                  c.addi       a2, -1
                  c.mv         a2, a2
                  c.li         a0, 14
                  c.lui        s9, 19
                  lui          sp, 776755
                  c.nop
                  ori          a6, t5, 1716
                  c.slli       s4, 24
                  c.lui        s9, 19
                  rem          sp, t6, tp
                  rem          sp, t6, tp
                  andi         t6, a4, 389
                  mul          a1, s1, t5
                  c.srli       a2, 1
                  xor          s11, s5, a1
                  auipc        t1, 195699
                  lui          sp, 776755
                  add          s3, s11, s3
                  c.xor        a3, a5
                  or           a2, a7, sp
                  auipc        t1, 195699
                  nop
                  srli         s0, s11, 8
                  rem          sp, t6, tp
                  mulh         zero, a3, gp
                  sltu         s9, a4, a0
                  sltu         s9, a4, a0
                  andi         t6, a4, 389
                  remu         zero, s2, zero
                  c.nop
                  c.nop
                  c.mv         a2, a2
                  and          s7, a5, a7
                  slli         sp, t3, 13
                  c.srai       a4, 2
                  mul          a1, s1, t5
                  and          s7, a5, a7
                  xori         a3, s4, 1809
                  c.srli       a2, 1
                  rem          sp, t6, tp
                  slti         a0, a4, -1207
                  c.addi       a2, -1
                  xori         a3, s4, 1809
                  xori         a3, s4, 1809
                  slti         a0, a4, -1207
                  srli         s0, s11, 8
                  c.addi       a2, -1
                  c.sub        a5, a1
                  c.li         a0, 14
                  slt          t2, a1, s5
                  srl          s5, s7, sp
                  sll          t2, s7, s3
                  srl          s5, s7, sp
                  divu         t5, a7, tp
                  c.slli       s4, 24
                  c.sub        a5, a1
                  xori         a3, s4, 1809
                  sltiu        t6, s10, -519
                  sltiu        t6, s10, -519
                  lui          sp, 776755
                  c.lui        s9, 19
                  add          s3, s11, s3
                  xor          s11, s5, a1
                  sltu         s9, a4, a0
                  c.andi       a4, 28
                  slti         a0, a4, -1207
                  addi         a1, t1, -1592
                  c.srli       a2, 1
                  c.lui        s9, 19
                  c.srai       a4, 2
                  xor          s11, s5, a1
                  addi         a1, t1, -1592
                  slti         a0, a4, -1207
                  or           a2, a7, sp
                  and          s7, a5, a7
                  c.sub        a5, a1
                  c.add        sp, s8
                  slt          t2, a1, s5
                  srl          s5, s7, sp
                  addi         a1, t1, -1592
                  slli         sp, t3, 13
                  mulhu        s3, s2, s7
                  slli         sp, t3, 13
                  mul          a1, s1, t5
                  c.srli       a2, 1
                  c.mv         a2, a2
                  remu         zero, s2, zero
                  c.srli       a2, 1
                  c.li         a0, 14
                  c.nop
                  xor          s11, s5, a1
                  sub          gp, s1, t2
                  c.mv         a2, a2
                  c.addi       a2, -1
                  srl          s5, s7, sp
                  add          s3, s11, s3
                  auipc        t1, 195699
                  c.addi4spn   a5, sp, 464
                  slti         a0, a4, -1207
                  mul          a1, s1, t5
                  and          s7, a5, a7
                  nop
                  mul          a1, s1, t5
                  c.srli       a2, 1
                  xori         a3, s4, 1809
                  slli         sp, t3, 13
                  c.mv         a2, a2
                  sltu         s9, a4, a0
                  sltu         s9, a4, a0
                  addi         a1, t1, -1592
                  c.srli       a2, 1
                  c.slli       s4, 24
                  c.or         a5, a4
                  c.or         a5, a4
                  sll          t2, s7, s3
                  remu         zero, s2, zero
                  sll          t2, s7, s3
                  srl          s5, s7, sp
                  mulh         zero, a3, gp
                  ori          a6, t5, 1716
                  c.nop
                  mulhsu       s0, a1, t4
                  srai         gp, ra, 29
                  c.add        sp, s8
                  c.slli       s4, 24
                  c.addi16sp   sp, -16
                  divu         t5, a7, tp
                  mul          a1, s1, t5
                  c.li         a0, 14
                  auipc        t1, 195699
                  div          t1, s3, a1
                  c.xor        a3, a5
                  c.mv         a2, a2
                  slli         sp, t3, 13
                  mulh         zero, a3, gp
                  slti         a0, a4, -1207
                  c.lui        s9, 19
                  mul          a1, s1, t5
                  divu         t5, a7, tp
                  slti         a0, a4, -1207
                  srli         s0, s11, 8
                  c.srai       a4, 2
                  add          s3, s11, s3
                  srl          s5, s7, sp
                  addi         a1, t1, -1592
                  srai         gp, ra, 29
                  c.and        a5, a4
                  c.addi4spn   a5, sp, 464
                  remu         zero, s2, zero
                  and          s7, a5, a7
                  c.addi4spn   a5, sp, 464
                  slti         a0, a4, -1207
                  srl          s5, s7, sp
                  srai         gp, ra, 29
                  lui          sp, 776755
                  mul          a1, s1, t5
                  auipc        t1, 195699
                  mul          a1, s1, t5
                  srai         gp, ra, 29
                  c.srai       a4, 2
                  xor          s11, s5, a1
                  auipc        t1, 195699
                  c.mv         a2, a2
                  mulh         zero, a3, gp
                  div          t1, s3, a1
                  lui          sp, 776755
                  c.sub        a5, a1
                  mulhsu       s0, a1, t4
                  sll          t2, s7, s3
                  or           a2, a7, sp
                  ori          a6, t5, 1716
                  srl          s5, s7, sp
                  rem          sp, t6, tp
                  or           a2, a7, sp
                  lui          sp, 776755
                  srli         s0, s11, 8
                  c.addi16sp   sp, -16
                  c.slli       s4, 24
                  c.srli       a2, 1
                  divu         t5, a7, tp
                  c.srli       a2, 1
                  sltiu        t6, s10, -519
                  nop
                  sub          gp, s1, t2
                  mulhu        s3, s2, s7
                  mul          a1, s1, t5
                  andi         t6, a4, 389
                  c.add        sp, s8
                  slti         a0, a4, -1207
                  srai         gp, ra, 29
                  c.or         a5, a4
                  c.srli       a2, 1
                  nop
                  sltiu        t6, s10, -519
                  c.mv         a2, a2
                  mul          a1, s1, t5
                  and          s7, a5, a7
                  c.add        sp, s8
                  c.slli       s4, 24
                  srli         s0, s11, 8
                  xori         a3, s4, 1809
                  mulhsu       s0, a1, t4
                  c.xor        a3, a5
                  slt          t2, a1, s5
                  c.srai       a4, 2
                  mulhsu       s0, a1, t4
                  sltiu        t6, s10, -519
                  srl          s5, s7, sp
                  sub          gp, s1, t2
                  sll          t2, s7, s3
                  auipc        t1, 195699
                  ori          a6, t5, 1716
                  andi         t6, a4, 389
                  sltu         s9, a4, a0
                  c.srli       a2, 1
                  c.xor        a3, a5
                  xori         a3, s4, 1809
                  c.mv         a2, a2
                  sra          sp, a2, sp
                  c.nop
                  sub          gp, s1, t2
                  c.addi       a2, -1
                  mul          a1, s1, t5
                  mulh         zero, a3, gp
                  srli         s0, s11, 8
                  sltu         s9, a4, a0
                  c.slli       s4, 24
                  c.xor        a3, a5
                  c.add        sp, s8
                  add          s3, s11, s3
                  mulhsu       s0, a1, t4
                  c.addi16sp   sp, -16
                  c.addi4spn   a5, sp, 464
                  c.xor        a3, a5
                  xori         a3, s4, 1809
                  c.sub        a5, a1
                  xor          s11, s5, a1
                  c.add        sp, s8
                  sra          sp, a2, sp
                  slt          t2, a1, s5
                  mulh         zero, a3, gp
                  xor          s11, s5, a1
                  c.xor        a3, a5
                  c.and        a5, a4
                  srli         s0, s11, 8
                  c.nop
                  rem          sp, t6, tp
                  mulhsu       s0, a1, t4
                  c.addi16sp   sp, -16
                  ori          a6, t5, 1716
                  or           a2, a7, sp
                  c.lui        s9, 19
                  srl          s5, s7, sp
                  rem          sp, t6, tp
                  andi         t6, a4, 389
                  add          s3, s11, s3
                  slt          t2, a1, s5
                  sub          gp, s1, t2
                  c.andi       a4, 28
                  mulhu        s3, s2, s7
                  srai         gp, ra, 29
                  xor          s11, s5, a1
                  c.sub        a5, a1
                  auipc        t1, 195699
                  andi         t6, a4, 389
                  slli         sp, t3, 13
                  c.andi       a4, 28
                  remu         zero, s2, zero
                  c.addi4spn   a5, sp, 464
                  div          t1, s3, a1
                  or           a2, a7, sp
                  or           a2, a7, sp
                  or           a2, a7, sp
                  or           a2, a7, sp
                  c.andi       a4, 28
                  xor          s11, s5, a1
                  andi         t6, a4, 389
                  slt          t2, a1, s5
                  div          t1, s3, a1
                  xori         a3, s4, 1809
                  or           a2, a7, sp
                  c.slli       s4, 24
                  mul          a1, s1, t5
                  c.andi       a4, 28
                  lui          sp, 776755
                  c.slli       s4, 24
                  slt          t2, a1, s5
                  xor          s11, s5, a1
                  c.and        a5, a4
                  rem          sp, t6, tp
                  sub          gp, s1, t2
                  lui          sp, 776755
                  div          t1, s3, a1
                  c.nop
                  c.srai       a4, 2
                  sltiu        t6, s10, -519
                  ori          a6, t5, 1716
                  nop
                  c.and        a5, a4
                  mul          a1, s1, t5
                  c.lui        s9, 19
                  c.addi4spn   a5, sp, 464
                  divu         t5, a7, tp
                  c.mv         a2, a2
                  c.slli       s4, 24
                  c.slli       s4, 24
                  sltu         s9, a4, a0
                  divu         t5, a7, tp
                  c.addi16sp   sp, -16
                  slt          t2, a1, s5
                  sll          t2, s7, s3
                  c.nop
                  sra          sp, a2, sp
                  nop
                  or           a2, a7, sp
                  add          s3, s11, s3
                  div          t1, s3, a1
                  c.li         a0, 14
                  rem          sp, t6, tp
                  c.mv         a2, a2
                  sra          sp, a2, sp
                  c.xor        a3, a5
                  sltiu        t6, s10, -519
                  addi         a1, t1, -1592
                  c.mv         a2, a2
                  div          t1, s3, a1
                  mulh         zero, a3, gp
                  xori         a3, s4, 1809
                  ori          a6, t5, 1716
                  slli         sp, t3, 13
                  ori          a6, t5, 1716
                  c.mv         a2, a2
                  c.addi       a2, -1
                  c.and        a5, a4
                  lui          sp, 776755
                  sub          gp, s1, t2
                  rem          sp, t6, tp
                  c.li         a0, 14
                  add          s3, s11, s3
                  sra          sp, a2, sp
                  auipc        t1, 195699
                  mul          a1, s1, t5
                  sltu         s9, a4, a0
                  c.srai       a4, 2
                  sltiu        t6, s10, -519
                  mulh         zero, a3, gp
                  mul          a1, s1, t5
                  c.slli       s4, 24
                  c.addi16sp   sp, -16
                  div          t1, s3, a1
                  srli         s0, s11, 8
                  c.srli       a2, 1
                  or           a2, a7, sp
                  c.mv         a2, a2
                  remu         zero, s2, zero
                  and          s7, a5, a7
                  addi         a1, t1, -1592
                  c.srli       a2, 1
                  srl          s5, s7, sp
                  xori         a3, s4, 1809
                  auipc        t1, 195699
                  mulh         zero, a3, gp
                  c.addi16sp   sp, -16
                  c.add        sp, s8
                  sub          gp, s1, t2
                  slli         sp, t3, 13
                  c.srai       a4, 2
                  c.srli       a2, 1
                  lui          sp, 776755
                  lui          sp, 776755
                  c.addi16sp   sp, -16
                  auipc        t1, 195699
                  c.add        sp, s8
                  addi         a1, t1, -1592
                  sltiu        t6, s10, -519
                  srli         s0, s11, 8
                  nop
                  ori          a6, t5, 1716
                  c.lui        s9, 19
                  mul          a1, s1, t5
                  c.addi       a2, -1
                  divu         t5, a7, tp
                  c.li         a0, 14
                  mulh         zero, a3, gp
                  or           a2, a7, sp
                  mul          a1, s1, t5
                  sub          gp, s1, t2
                  c.andi       a4, 28
                  sltu         s9, a4, a0
                  srli         s0, s11, 8
                  xori         a3, s4, 1809
                  remu         zero, s2, zero
                  slti         a0, a4, -1207
                  c.or         a5, a4
                  c.addi4spn   a5, sp, 464
                  auipc        t1, 195699
                  ori          a6, t5, 1716
                  c.add        sp, s8
                  srl          s5, s7, sp
                  andi         t6, a4, 389
                  slti         a0, a4, -1207
                  div          t1, s3, a1
                  sra          sp, a2, sp
                  add          s3, s11, s3
                  slt          t2, a1, s5
                  slti         a0, a4, -1207
                  rem          sp, t6, tp
                  xor          s11, s5, a1
                  c.lui        s9, 19
                  c.addi4spn   a5, sp, 464
                  c.or         a5, a4
                  c.srai       a4, 2
                  c.srli       a2, 1
                  c.andi       a4, 28
                  slli         sp, t3, 13
                  c.addi16sp   sp, -16
                  c.add        sp, s8
                  mulhu        s3, s2, s7
                  c.addi16sp   sp, -16
                  andi         t6, a4, 389
                  c.li         a0, 14
                  c.xor        a3, a5
                  c.nop
                  srli         s0, s11, 8
                  mulhsu       s0, a1, t4
                  sltiu        t6, s10, -519
                  mulhsu       s0, a1, t4
                  srai         gp, ra, 29
                  c.xor        a3, a5
                  xori         a3, s4, 1809
                  sra          sp, a2, sp
                  div          t1, s3, a1
                  ori          a6, t5, 1716
                  c.srai       a4, 2
                  sltu         s9, a4, a0
                  c.srai       a4, 2
                  c.srli       a2, 1
                  mul          a1, s1, t5
                  srai         gp, ra, 29
                  andi         t6, a4, 389
                  addi         a1, t1, -1592
                  nop
                  c.xor        a3, a5
                  lui          sp, 776755
                  slli         sp, t3, 13
                  c.xor        a3, a5
                  c.sub        a5, a1
                  andi         t6, a4, 389
                  mulhu        s3, s2, s7
                  mulh         zero, a3, gp
                  divu         t5, a7, tp
                  srli         s0, s11, 8
                  mulhu        s3, s2, s7
                  slli         sp, t3, 13
                  c.srli       a2, 1
                  mul          a1, s1, t5
                  sra          sp, a2, sp
                  c.li         a0, 14
                  c.slli       s4, 24
                  sltu         s9, a4, a0
                  rem          sp, t6, tp
                  c.addi4spn   a5, sp, 464
                  sltu         s9, a4, a0
                  c.and        a5, a4
                  c.addi       a2, -1
                  c.sub        a5, a1
                  c.sub        a5, a1
                  c.addi       a2, -1
                  or           a2, a7, sp
                  rem          sp, t6, tp
                  addi         a1, t1, -1592
                  c.slli       s4, 24
                  ori          a6, t5, 1716
                  c.lui        s9, 19
                  sltu         s9, a4, a0
                  add          s3, s11, s3
                  c.mv         a2, a2
                  c.add        sp, s8
                  sltiu        t6, s10, -519
                  c.lui        s9, 19
                  lui          sp, 776755
                  sll          t2, s7, s3
                  srl          s5, s7, sp
                  srli         s0, s11, 8
                  srli         s0, s11, 8
                  nop
                  add          s3, s11, s3
                  c.andi       a4, 28
                  c.nop
                  auipc        t1, 195699
                  mulhsu       s0, a1, t4
                  c.mv         a2, a2
                  ori          a6, t5, 1716
                  c.add        sp, s8
                  c.lui        s9, 19
                  div          t1, s3, a1
                  remu         zero, s2, zero
                  divu         t5, a7, tp
                  c.nop
                  srli         s0, s11, 8
                  c.nop
                  add          s3, s11, s3
                  auipc        t1, 195699
                  lui          sp, 776755
                  srl          s5, s7, sp
                  c.lui        s9, 19
                  c.addi16sp   sp, -16
                  remu         zero, s2, zero
                  sltiu        t6, s10, -519
                  c.or         a5, a4
                  c.slli       s4, 24
                  mulh         zero, a3, gp
                  slli         sp, t3, 13
                  remu         zero, s2, zero
                  andi         t6, a4, 389
                  or           a2, a7, sp
                  c.addi16sp   sp, -16
                  c.addi       a2, -1
                  c.add        sp, s8
                  slli         sp, t3, 13
                  slli         sp, t3, 13
                  or           a2, a7, sp
                  slti         a0, a4, -1207
                  c.addi16sp   sp, -16
                  sltiu        t6, s10, -519
                  sll          t2, s7, s3
                  remu         zero, s2, zero
                  mulh         zero, a3, gp
                  c.sub        a5, a1
                  remu         zero, s2, zero
                  divu         t5, a7, tp
                  c.addi4spn   a5, sp, 464
                  c.andi       a4, 28
                  mulhu        s3, s2, s7
                  add          s3, s11, s3
                  ori          a6, t5, 1716
                  c.xor        a3, a5
                  add          s3, s11, s3
                  sltiu        t6, s10, -519
                  xori         a3, s4, 1809
                  c.lui        s9, 19
                  c.andi       a4, 28
                  c.li         a0, 14
                  c.sub        a5, a1
                  c.xor        a3, a5
                  c.addi16sp   sp, -16
                  slli         sp, t3, 13
                  xor          s11, s5, a1
                  sltiu        t6, s10, -519
                  c.srli       a2, 1
                  sltu         s9, a4, a0
                  c.addi4spn   a5, sp, 464
                  div          t1, s3, a1
                  xori         a3, s4, 1809
                  mul          a1, s1, t5
                  sub          gp, s1, t2
                  xor          s11, s5, a1
                  auipc        t1, 195699
                  addi         a1, t1, -1592
                  add          s3, s11, s3
                  nop
                  auipc        t1, 195699
                  lui          sp, 776755
                  add          s3, s11, s3
                  or           a2, a7, sp
                  sra          sp, a2, sp
                  c.xor        a3, a5
                  c.andi       a4, 28
                  c.addi16sp   sp, -16
                  xor          s11, s5, a1
                  c.nop
                  mulhsu       s0, a1, t4
                  xori         a3, s4, 1809
                  add          s3, s11, s3
                  and          s7, a5, a7
                  c.and        a5, a4
                  sltiu        t6, s10, -519
                  xor          s11, s5, a1
                  slt          t2, a1, s5
                  mulhsu       s0, a1, t4
                  c.mv         a2, a2
                  srai         gp, ra, 29
                  sra          sp, a2, sp
                  c.or         a5, a4
                  xori         a3, s4, 1809
                  srl          s5, s7, sp
                  c.mv         a2, a2
                  xori         a3, s4, 1809
                  sll          t2, s7, s3
                  mul          a1, s1, t5
                  c.lui        s9, 19
                  sub          gp, s1, t2
                  xori         a3, s4, 1809
                  sub          gp, s1, t2
                  xor          s11, s5, a1
                  div          t1, s3, a1
                  c.slli       s4, 24
                  srl          s5, s7, sp
                  c.lui        s9, 19
                  c.addi       a2, -1
                  c.lui        s9, 19
                  xor          s11, s5, a1
                  mulh         zero, a3, gp
                  mul          a1, s1, t5
                  c.slli       s4, 24
                  ori          a6, t5, 1716
                  c.lui        s9, 19
                  c.srai       a4, 2
                  or           a2, a7, sp
                  slli         sp, t3, 13
                  c.mv         a2, a2
                  divu         t5, a7, tp
                  srli         s0, s11, 8
                  sra          sp, a2, sp
                  c.nop
                  or           a2, a7, sp
                  c.li         a0, 14
                  remu         zero, s2, zero
                  sub          gp, s1, t2
                  add          s3, s11, s3
                  slli         sp, t3, 13
                  c.andi       a4, 28
                  mulhsu       s0, a1, t4
                  c.srli       a2, 1
                  c.xor        a3, a5
                  divu         t5, a7, tp
                  c.li         a0, 14
                  c.add        sp, s8
                  c.li         a0, 14
                  srl          s5, s7, sp
                  c.slli       s4, 24
                  ori          a6, t5, 1716
                  srl          s5, s7, sp
                  sub          gp, s1, t2
                  c.srli       a2, 1
                  c.or         a5, a4
                  slti         a0, a4, -1207
                  sub          gp, s1, t2
                  c.or         a5, a4
                  c.li         a0, 14
                  andi         t6, a4, 389
                  or           a2, a7, sp
                  c.addi       a2, -1
                  ori          a6, t5, 1716
                  xori         a3, s4, 1809
                  c.nop
                  sub          gp, s1, t2
                  or           a2, a7, sp
                  xori         a3, s4, 1809
                  mulhu        s3, s2, s7
                  addi         a1, t1, -1592
                  add          s3, s11, s3
                  c.andi       a4, 28
                  c.andi       a4, 28
                  slti         a0, a4, -1207
                  c.addi       a2, -1
                  ori          a6, t5, 1716
                  and          s7, a5, a7
                  srl          s5, s7, sp
                  auipc        t1, 195699
                  c.addi4spn   a5, sp, 464
                  xor          s11, s5, a1
                  slt          t2, a1, s5
                  c.and        a5, a4
                  sltiu        t6, s10, -519
                  c.and        a5, a4
                  srai         gp, ra, 29
                  c.addi16sp   sp, -16
                  mulh         zero, a3, gp
                  andi         t6, a4, 389
                  srl          s5, s7, sp
                  c.addi       a2, -1
                  c.addi       a2, -1
                  sub          gp, s1, t2
                  ori          a6, t5, 1716
                  c.addi       a2, -1
                  c.lui        s9, 19
                  srai         gp, ra, 29
                  c.andi       a4, 28
                  c.andi       a4, 28
                  c.sub        a5, a1
                  sltu         s9, a4, a0
                  auipc        t1, 195699
                  lui          sp, 776755
                  sltu         s9, a4, a0
                  c.srli       a2, 1
                  sll          t2, s7, s3
                  mulh         zero, a3, gp
                  c.addi4spn   a5, sp, 464
                  lui          sp, 776755
                  slti         a0, a4, -1207
                  mulh         zero, a3, gp
                  c.slli       s4, 24
                  divu         t5, a7, tp
                  c.srli       a2, 1
                  c.slli       s4, 24
                  slti         a0, a4, -1207
                  mulhsu       s0, a1, t4
                  rem          sp, t6, tp
                  or           a2, a7, sp
                  addi         a1, t1, -1592
                  sltu         s9, a4, a0
                  sltu         s9, a4, a0
                  c.mv         a2, a2
                  div          t1, s3, a1
                  sltu         s9, a4, a0
                  slti         a0, a4, -1207
                  addi         a1, t1, -1592
                  auipc        t1, 195699
                  mulh         zero, a3, gp
                  c.addi       a2, -1
                  add          s3, s11, s3
                  c.nop
                  c.slli       s4, 24
                  sra          sp, a2, sp
                  mulhu        s3, s2, s7
                  and          s7, a5, a7
                  c.and        a5, a4
                  sra          sp, a2, sp
                  auipc        t1, 195699
                  ori          a6, t5, 1716
                  lui          sp, 776755
                  add          s3, s11, s3
                  c.sub        a5, a1
                  andi         t6, a4, 389
                  c.srai       a4, 2
                  remu         zero, s2, zero
                  c.lui        s9, 19
                  srai         gp, ra, 29
                  sltu         s9, a4, a0
                  c.srli       a2, 1
                  slli         sp, t3, 13
                  srai         gp, ra, 29
                  divu         t5, a7, tp
                  slti         a0, a4, -1207
                  c.or         a5, a4
                  andi         t6, a4, 389
                  c.addi16sp   sp, -16
                  mulhu        s3, s2, s7
                  sltu         s9, a4, a0
                  slti         a0, a4, -1207
                  add          s3, s11, s3
                  c.addi4spn   a5, sp, 464
                  c.srai       a4, 2
                  slli         sp, t3, 13
                  nop
                  slli         sp, t3, 13
                  xori         a3, s4, 1809
                  xor          s11, s5, a1
                  c.sub        a5, a1
                  addi         a1, t1, -1592
                  add          s3, s11, s3
                  andi         t6, a4, 389
                  sll          t2, s7, s3
                  or           a2, a7, sp
                  c.xor        a3, a5
                  remu         zero, s2, zero
                  c.addi4spn   a5, sp, 464
                  sll          t2, s7, s3
                  sll          t2, s7, s3
                  c.and        a5, a4
                  c.slli       s4, 24
                  ori          a6, t5, 1716
                  and          s7, a5, a7
                  mulh         zero, a3, gp
                  c.slli       s4, 24
                  and          s7, a5, a7
                  nop
                  sltu         s9, a4, a0
                  mulh         zero, a3, gp
                  xor          s11, s5, a1
                  xor          s11, s5, a1
                  c.mv         a2, a2
                  and          s7, a5, a7
                  divu         t5, a7, tp
                  mul          a1, s1, t5
                  xori         a3, s4, 1809
                  add          s3, s11, s3
                  addi         a1, t1, -1592
                  sltu         s9, a4, a0
                  c.srai       a4, 2
                  sra          sp, a2, sp
                  c.srli       a2, 1
                  remu         zero, s2, zero
                  slli         sp, t3, 13
                  srl          s5, s7, sp
                  andi         t6, a4, 389
                  srl          s5, s7, sp
                  c.addi4spn   a5, sp, 464
                  addi         a1, t1, -1592
                  c.andi       a4, 28
                  c.srli       a2, 1
                  slt          t2, a1, s5
                  c.or         a5, a4
                  xor          s11, s5, a1
                  c.xor        a3, a5
                  srl          s5, s7, sp
                  c.mv         a2, a2
                  mulhsu       s0, a1, t4
                  rem          sp, t6, tp
                  divu         t5, a7, tp
                  c.xor        a3, a5
                  slli         sp, t3, 13
                  remu         zero, s2, zero
                  srli         s0, s11, 8
                  mulhu        s3, s2, s7
                  c.addi16sp   sp, -16
                  srli         s0, s11, 8
                  remu         zero, s2, zero
                  slli         sp, t3, 13
                  c.nop
                  ori          a6, t5, 1716
                  and          s7, a5, a7
                  c.sub        a5, a1
                  c.srai       a4, 2
                  auipc        t1, 195699
                  c.li         a0, 14
                  c.srli       a2, 1
                  addi         a1, t1, -1592
                  c.xor        a3, a5
                  c.slli       s4, 24
                  slli         sp, t3, 13
                  divu         t5, a7, tp
                  c.or         a5, a4
                  auipc        t1, 195699
                  sll          t2, s7, s3
                  sltiu        t6, s10, -519
                  srai         gp, ra, 29
                  and          s7, a5, a7
                  ori          a6, t5, 1716
                  xori         a3, s4, 1809
                  sra          sp, a2, sp
                  c.li         a0, 14
                  ori          a6, t5, 1716
                  slli         sp, t3, 13
                  and          s7, a5, a7
                  sra          sp, a2, sp
                  mulhu        s3, s2, s7
                  c.addi16sp   sp, -16
                  c.li         a0, 14
                  xor          s11, s5, a1
                  and          s7, a5, a7
                  add          s3, s11, s3
                  slti         a0, a4, -1207
                  c.andi       a4, 28
                  c.srai       a4, 2
                  srli         s0, s11, 8
                  c.andi       a4, 28
                  xori         a3, s4, 1809
                  add          s3, s11, s3
                  lui          sp, 776755
                  auipc        t1, 195699
                  remu         zero, s2, zero
                  nop
                  c.srai       a4, 2
                  and          s7, a5, a7
                  div          t1, s3, a1
                  srai         gp, ra, 29
                  c.sub        a5, a1
                  divu         t5, a7, tp
                  c.and        a5, a4
                  mulhsu       s0, a1, t4
                  div          t1, s3, a1
                  and          s7, a5, a7
                  slt          t2, a1, s5
                  sra          sp, a2, sp
                  c.or         a5, a4
                  addi         a1, t1, -1592
                  addi         a1, t1, -1592
                  lui          sp, 776755
                  sub          gp, s1, t2
                  c.add        sp, s8
                  xori         a3, s4, 1809
                  and          s7, a5, a7
                  mul          a1, s1, t5
                  xori         a3, s4, 1809
                  c.srai       a4, 2
                  c.nop
                  li           a5, 0x0 #start riscv_int_numeric_corner_stream_1
                  li           ra, 0x80000000
                  li           a2, 0xffffffff
                  li           gp, 0x32f8263c
                  li           sp, 0xd6327097
                  li           s9, 0xc85a2ddc
                  li           t2, 0xffffffff
                  li           t6, 0x80000000
                  li           s5, 0x80000000
                  li           s7, 0xe7344615
                  add          sp, sp, t2
                  divu         sp, sp, a2
                  div          a5, t2, s5
                  nop
                  lui          gp, 776755
                  mul          t6, t6, t2
                  divu         sp, sp, a2
                  mulhu        sp, gp, s7
                  rem          gp, s5, a2
                  addi         t6, s5, -1592
                  sub          t2, t6, s7
                  lui          gp, 776755
                  sub          t2, t6, s7
                  sub          t2, t6, s7
                  rem          gp, s5, a2
                  lui          gp, 776755
                  mulhu        sp, gp, s7
                  auipc        a5, 195699
                  add          sp, sp, t2
                  divu         sp, sp, a2
                  mulhu        sp, gp, s7
                  addi         t6, s5, -1592
                  mulhsu       s7, a5, ra
                  auipc        a5, 195699
                  rem          gp, s5, a2 #end riscv_int_numeric_corner_stream_1
                  c.nop
                  srli         s0, s11, 8
                  lui          sp, 776755
                  c.li         a0, 14
                  c.and        a5, a4
                  c.xor        a3, a5
                  or           a2, a7, sp
                  c.and        a5, a4
                  srli         s0, s11, 8
                  c.lui        s9, 19
                  mulhsu       s0, a1, t4
                  mulhu        s3, s2, s7
                  remu         zero, s2, zero
                  c.mv         a2, a2
                  mulhsu       s0, a1, t4
                  mulhsu       s0, a1, t4
                  rem          sp, t6, tp
                  addi         a1, t1, -1592
                  c.addi4spn   a5, sp, 464
                  andi         t6, a4, 389
                  c.xor        a3, a5
                  mulhsu       s0, a1, t4
                  sltu         s9, a4, a0
                  andi         t6, a4, 389
                  c.or         a5, a4
                  sltu         s9, a4, a0
                  sra          sp, a2, sp
                  mulhsu       s0, a1, t4
                  c.srli       a2, 1
                  c.addi16sp   sp, -16
                  c.addi4spn   a5, sp, 464
                  auipc        t1, 195699
                  add          s3, s11, s3
                  c.and        a5, a4
                  div          t1, s3, a1
                  srai         gp, ra, 29
                  mulh         zero, a3, gp
                  c.srai       a4, 2
                  c.addi4spn   a5, sp, 464
                  addi         a1, t1, -1592
                  c.lui        s9, 19
                  slt          t2, a1, s5
                  c.or         a5, a4
                  divu         t5, a7, tp
                  sltu         s9, a4, a0
                  sll          t2, s7, s3
                  c.xor        a3, a5
                  sltu         s9, a4, a0
                  srl          s5, s7, sp
                  mulh         zero, a3, gp
                  c.lui        s9, 19
                  c.add        sp, s8
                  slt          t2, a1, s5
                  c.addi4spn   a5, sp, 464
                  c.or         a5, a4
                  c.nop
                  c.nop
                  c.andi       a4, 28
                  mulhsu       s0, a1, t4
                  ori          a6, t5, 1716
                  mul          a1, s1, t5
                  c.srli       a2, 1
                  sub          gp, s1, t2
                  mulhu        s3, s2, s7
                  or           a2, a7, sp
                  sub          gp, s1, t2
                  mulh         zero, a3, gp
                  xor          s11, s5, a1
                  c.sub        a5, a1
                  and          s7, a5, a7
                  rem          sp, t6, tp
                  c.li         a0, 14
                  add          s3, s11, s3
                  add          s3, s11, s3
                  mulh         zero, a3, gp
                  c.add        sp, s8
                  ori          a6, t5, 1716
                  c.nop
                  andi         t6, a4, 389
                  c.xor        a3, a5
                  add          s3, s11, s3
                  srli         s0, s11, 8
                  rem          sp, t6, tp
                  c.xor        a3, a5
                  c.lui        s9, 19
                  c.addi       a2, -1
                  srl          s5, s7, sp
                  andi         t6, a4, 389
                  sll          t2, s7, s3
                  xori         a3, s4, 1809
                  srai         gp, ra, 29
                  xor          s11, s5, a1
                  c.srli       a2, 1
                  add          s3, s11, s3
                  c.xor        a3, a5
                  slt          t2, a1, s5
                  mulhu        s3, s2, s7
                  xor          s11, s5, a1
                  sub          gp, s1, t2
                  c.li         a0, 14
                  c.srli       a2, 1
                  c.add        sp, s8
                  c.andi       a4, 28
                  div          t1, s3, a1
                  sltiu        t6, s10, -519
                  and          s7, a5, a7
                  c.addi4spn   a5, sp, 464
                  remu         zero, s2, zero
                  srli         s0, s11, 8
                  add          s3, s11, s3
                  c.slli       s4, 24
                  andi         t6, a4, 389
                  c.or         a5, a4
                  auipc        t1, 195699
                  c.srli       a2, 1
                  lui          sp, 776755
                  sra          sp, a2, sp
                  c.mv         a2, a2
                  slt          t2, a1, s5
                  c.and        a5, a4
                  c.addi       a2, -1
                  c.srai       a4, 2
                  sub          gp, s1, t2
                  c.addi4spn   a5, sp, 464
                  add          s3, s11, s3
                  xori         a3, s4, 1809
                  xori         a3, s4, 1809
                  slti         a0, a4, -1207
                  slt          t2, a1, s5
                  c.mv         a2, a2
                  c.andi       a4, 28
                  sra          sp, a2, sp
                  sub          gp, s1, t2
                  addi         a1, t1, -1592
                  c.lui        s9, 19
                  addi         a1, t1, -1592
                  auipc        t1, 195699
                  slti         a0, a4, -1207
                  div          t1, s3, a1
                  addi         a1, t1, -1592
                  c.srai       a4, 2
                  sll          t2, s7, s3
                  c.or         a5, a4
                  nop
                  slli         sp, t3, 13
                  c.slli       s4, 24
                  mul          a1, s1, t5
                  c.addi4spn   a5, sp, 464
                  addi         a1, t1, -1592
                  c.andi       a4, 28
                  sltiu        t6, s10, -519
                  c.or         a5, a4
                  xori         a3, s4, 1809
                  sub          gp, s1, t2
                  slli         sp, t3, 13
                  c.addi4spn   a5, sp, 464
                  c.and        a5, a4
                  sra          sp, a2, sp
                  andi         t6, a4, 389
                  c.add        sp, s8
                  add          s3, s11, s3
                  addi         a1, t1, -1592
                  ori          a6, t5, 1716
                  c.add        sp, s8
                  c.addi4spn   a5, sp, 464
                  c.srli       a2, 1
                  addi         a1, t1, -1592
                  c.add        sp, s8
                  nop
                  nop
                  srli         s0, s11, 8
                  mulhsu       s0, a1, t4
                  slti         a0, a4, -1207
                  slt          t2, a1, s5
                  c.srli       a2, 1
                  add          s3, s11, s3
                  remu         zero, s2, zero
                  c.addi16sp   sp, -16
                  c.mv         a2, a2
                  sra          sp, a2, sp
                  c.lui        s9, 19
                  lui          sp, 776755
                  mulh         zero, a3, gp
                  c.li         a0, 14
                  sub          gp, s1, t2
                  slli         sp, t3, 13
                  add          s3, s11, s3
                  sltu         s9, a4, a0
                  sltu         s9, a4, a0
                  c.nop
                  c.andi       a4, 28
                  slli         sp, t3, 13
                  slli         sp, t3, 13
                  c.sub        a5, a1
                  mulh         zero, a3, gp
                  divu         t5, a7, tp
                  auipc        t1, 195699
                  rem          sp, t6, tp
                  auipc        t1, 195699
                  srl          s5, s7, sp
                  sub          gp, s1, t2
                  c.or         a5, a4
                  c.add        sp, s8
                  sltu         s9, a4, a0
                  mulh         zero, a3, gp
                  mulhu        s3, s2, s7
                  c.nop
                  c.andi       a4, 28
                  mulhu        s3, s2, s7
                  c.addi       a2, -1
                  div          t1, s3, a1
                  add          s3, s11, s3
                  srai         gp, ra, 29
                  srai         gp, ra, 29
                  andi         t6, a4, 389
                  c.and        a5, a4
                  add          s3, s11, s3
                  srai         gp, ra, 29
                  c.srai       a4, 2
                  sltu         s9, a4, a0
                  slt          t2, a1, s5
                  add          s3, s11, s3
                  xori         a3, s4, 1809
                  lui          sp, 776755
                  sll          t2, s7, s3
                  addi         a1, t1, -1592
                  nop
                  auipc        t1, 195699
                  remu         zero, s2, zero
                  c.xor        a3, a5
                  nop
                  div          t1, s3, a1
                  divu         t5, a7, tp
                  srai         gp, ra, 29
                  c.xor        a3, a5
                  addi         a1, t1, -1592
                  slt          t2, a1, s5
                  srai         gp, ra, 29
                  divu         t5, a7, tp
                  sltu         s9, a4, a0
                  mulh         zero, a3, gp
                  slli         sp, t3, 13
                  xori         a3, s4, 1809
                  sltiu        t6, s10, -519
                  sra          sp, a2, sp
                  add          s3, s11, s3
                  c.srai       a4, 2
                  c.sub        a5, a1
                  xor          s11, s5, a1
                  c.mv         a2, a2
                  c.and        a5, a4
                  and          s7, a5, a7
                  c.addi       a2, -1
                  c.slli       s4, 24
                  addi         a1, t1, -1592
                  add          s3, s11, s3
                  srl          s5, s7, sp
                  c.xor        a3, a5
                  slti         a0, a4, -1207
                  rem          sp, t6, tp
                  rem          sp, t6, tp
                  ori          a6, t5, 1716
                  c.addi4spn   a5, sp, 464
                  auipc        t1, 195699
                  c.xor        a3, a5
                  slli         sp, t3, 13
                  c.lui        s9, 19
                  sra          sp, a2, sp
                  rem          sp, t6, tp
                  c.mv         a2, a2
                  auipc        t1, 195699
                  c.addi16sp   sp, -16
                  mulhu        s3, s2, s7
                  c.addi4spn   a5, sp, 464
                  c.mv         a2, a2
                  andi         t6, a4, 389
                  sra          sp, a2, sp
                  c.mv         a2, a2
                  remu         zero, s2, zero
                  or           a2, a7, sp
                  add          s3, s11, s3
                  rem          sp, t6, tp
                  div          t1, s3, a1
                  c.sub        a5, a1
                  div          t1, s3, a1
                  mulhu        s3, s2, s7
                  mulhsu       s0, a1, t4
                  addi         a1, t1, -1592
                  or           a2, a7, sp
                  div          t1, s3, a1
                  c.add        sp, s8
                  add          s3, s11, s3
                  c.li         a0, 14
                  c.andi       a4, 28
                  c.nop
                  c.addi4spn   a5, sp, 464
                  andi         t6, a4, 389
                  andi         t6, a4, 389
                  and          s7, a5, a7
                  addi         a1, t1, -1592
                  c.or         a5, a4
                  c.andi       a4, 28
                  add          s3, s11, s3
                  and          s7, a5, a7
                  ori          a6, t5, 1716
                  srli         s0, s11, 8
                  or           a2, a7, sp
                  srai         gp, ra, 29
                  andi         t6, a4, 389
                  nop
                  andi         t6, a4, 389
                  divu         t5, a7, tp
                  c.addi4spn   a5, sp, 464
                  xori         a3, s4, 1809
                  remu         zero, s2, zero
                  andi         t6, a4, 389
                  xori         a3, s4, 1809
                  rem          sp, t6, tp
                  sltu         s9, a4, a0
                  slli         sp, t3, 13
                  slt          t2, a1, s5
                  div          t1, s3, a1
                  ori          a6, t5, 1716
                  c.srli       a2, 1
                  lui          sp, 776755
                  c.addi16sp   sp, -16
                  srli         s0, s11, 8
                  addi         a1, t1, -1592
                  c.nop
                  c.srai       a4, 2
                  ori          a6, t5, 1716
                  div          t1, s3, a1
                  xori         a3, s4, 1809
                  slt          t2, a1, s5
                  xori         a3, s4, 1809
                  c.or         a5, a4
                  c.xor        a3, a5
                  c.lui        s9, 19
                  slli         sp, t3, 13
                  divu         t5, a7, tp
                  c.slli       s4, 24
                  divu         t5, a7, tp
                  c.addi16sp   sp, -16
                  div          t1, s3, a1
                  c.lui        s9, 19
                  sra          sp, a2, sp
                  xori         a3, s4, 1809
                  mulh         zero, a3, gp
                  c.add        sp, s8
                  c.li         a0, 14
                  nop
                  mulhu        s3, s2, s7
                  c.srli       a2, 1
                  and          s7, a5, a7
                  div          t1, s3, a1
                  xori         a3, s4, 1809
                  srl          s5, s7, sp
                  c.srli       a2, 1
                  xor          s11, s5, a1
                  and          s7, a5, a7
                  sll          t2, s7, s3
                  c.lui        s9, 19
                  c.addi4spn   a5, sp, 464
                  sub          gp, s1, t2
                  ori          a6, t5, 1716
                  xor          s11, s5, a1
                  xor          s11, s5, a1
                  lui          sp, 776755
                  ori          a6, t5, 1716
                  ori          a6, t5, 1716
                  c.srli       a2, 1
                  c.lui        s9, 19
                  ori          a6, t5, 1716
                  or           a2, a7, sp
                  xori         a3, s4, 1809
                  xor          s11, s5, a1
                  auipc        t1, 195699
                  c.or         a5, a4
                  c.and        a5, a4
                  c.mv         a2, a2
                  c.srli       a2, 1
                  slli         sp, t3, 13
                  sltiu        t6, s10, -519
                  srai         gp, ra, 29
                  remu         zero, s2, zero
                  c.lui        s9, 19
                  c.or         a5, a4
                  ori          a6, t5, 1716
                  div          t1, s3, a1
                  and          s7, a5, a7
                  divu         t5, a7, tp
                  add          s3, s11, s3
                  xori         a3, s4, 1809
                  srli         s0, s11, 8
                  nop
                  auipc        t1, 195699
                  mul          a1, s1, t5
                  mulhsu       s0, a1, t4
                  c.or         a5, a4
                  sub          gp, s1, t2
                  sltu         s9, a4, a0
                  and          s7, a5, a7
                  c.and        a5, a4
                  div          t1, s3, a1
                  or           a2, a7, sp
                  sra          sp, a2, sp
                  srl          s5, s7, sp
                  mulhsu       s0, a1, t4
                  add          s3, s11, s3
                  ori          a6, t5, 1716
                  c.and        a5, a4
                  c.addi       a2, -1
                  c.and        a5, a4
                  srai         gp, ra, 29
                  or           a2, a7, sp
                  c.li         a0, 14
                  c.slli       s4, 24
                  c.lui        s9, 19
                  xor          s11, s5, a1
                  lui          sp, 776755
                  sub          gp, s1, t2
                  c.nop
                  c.srai       a4, 2
                  mulhsu       s0, a1, t4
                  c.sub        a5, a1
                  c.addi4spn   a5, sp, 464
                  div          t1, s3, a1
                  c.andi       a4, 28
                  mulh         zero, a3, gp
                  sra          sp, a2, sp
                  addi         a1, t1, -1592
                  sra          sp, a2, sp
                  c.slli       s4, 24
                  srli         s0, s11, 8
                  or           a2, a7, sp
                  c.lui        s9, 19
                  div          t1, s3, a1
                  c.addi       a2, -1
                  xori         a3, s4, 1809
                  sra          sp, a2, sp
                  ori          a6, t5, 1716
                  c.lui        s9, 19
                  c.addi       a2, -1
                  rem          sp, t6, tp
                  addi         a1, t1, -1592
                  c.addi       a2, -1
                  srl          s5, s7, sp
                  mulh         zero, a3, gp
                  xor          s11, s5, a1
                  c.and        a5, a4
                  slli         sp, t3, 13
                  c.addi16sp   sp, -16
                  or           a2, a7, sp
                  mul          a1, s1, t5
                  lui          sp, 776755
                  c.andi       a4, 28
                  c.or         a5, a4
                  c.nop
                  c.srai       a4, 2
                  c.nop
                  addi         a1, t1, -1592
                  andi         t6, a4, 389
                  sltiu        t6, s10, -519
                  c.sub        a5, a1
                  xor          s11, s5, a1
                  mulhsu       s0, a1, t4
                  divu         t5, a7, tp
                  sra          sp, a2, sp
                  c.xor        a3, a5
                  and          s7, a5, a7
                  c.mv         a2, a2
                  srai         gp, ra, 29
                  nop
                  c.srai       a4, 2
                  c.addi4spn   a5, sp, 464
                  c.srli       a2, 1
                  sltu         s9, a4, a0
                  slti         a0, a4, -1207
                  c.sub        a5, a1
                  c.xor        a3, a5
                  lui          sp, 776755
                  sra          sp, a2, sp
                  c.addi4spn   a5, sp, 464
                  c.addi4spn   a5, sp, 464
                  mulhsu       s0, a1, t4
                  add          s3, s11, s3
                  c.mv         a2, a2
                  mulh         zero, a3, gp
                  nop
                  andi         t6, a4, 389
                  c.li         a0, 14
                  nop
                  c.lui        s9, 19
                  mulhu        s3, s2, s7
                  add          s3, s11, s3
                  mulhu        s3, s2, s7
                  c.nop
                  xor          s11, s5, a1
                  nop
                  c.addi16sp   sp, -16
                  add          s3, s11, s3
                  c.add        sp, s8
                  or           a2, a7, sp
                  c.nop
                  mulhsu       s0, a1, t4
                  sra          sp, a2, sp
                  xor          s11, s5, a1
                  slti         a0, a4, -1207
                  mulhsu       s0, a1, t4
                  c.and        a5, a4
                  slt          t2, a1, s5
                  sra          sp, a2, sp
                  and          s7, a5, a7
                  srai         gp, ra, 29
                  srai         gp, ra, 29
                  divu         t5, a7, tp
                  c.srai       a4, 2
                  srai         gp, ra, 29
                  srli         s0, s11, 8
                  andi         t6, a4, 389
                  srl          s5, s7, sp
                  c.addi16sp   sp, -16
                  auipc        t1, 195699
                  c.srli       a2, 1
                  c.nop
                  mulhsu       s0, a1, t4
                  c.mv         a2, a2
                  c.sub        a5, a1
                  rem          sp, t6, tp
                  c.add        sp, s8
                  auipc        t1, 195699
                  c.sub        a5, a1
                  nop
                  mulh         zero, a3, gp
                  rem          sp, t6, tp
                  srli         s0, s11, 8
                  auipc        t1, 195699
                  andi         t6, a4, 389
                  auipc        t1, 195699
                  div          t1, s3, a1
                  add          s3, s11, s3
                  c.xor        a3, a5
                  slli         sp, t3, 13
                  sltiu        t6, s10, -519
                  lui          sp, 776755
                  mulhsu       s0, a1, t4
                  c.sub        a5, a1
                  mulh         zero, a3, gp
                  c.slli       s4, 24
                  sub          gp, s1, t2
                  slli         sp, t3, 13
                  slti         a0, a4, -1207
                  add          s3, s11, s3
                  slti         a0, a4, -1207
                  srli         s0, s11, 8
                  srl          s5, s7, sp
                  div          t1, s3, a1
                  andi         t6, a4, 389
                  c.nop
                  sra          sp, a2, sp
                  remu         zero, s2, zero
                  srai         gp, ra, 29
                  add          s3, s11, s3
                  sltu         s9, a4, a0
                  c.mv         a2, a2
                  c.nop
                  sra          sp, a2, sp
                  mulhu        s3, s2, s7
                  srai         gp, ra, 29
                  c.or         a5, a4
                  mulh         zero, a3, gp
                  c.addi       a2, -1
                  addi         a1, t1, -1592
                  c.slli       s4, 24
                  mulhsu       s0, a1, t4
                  addi         a1, t1, -1592
                  c.addi       a2, -1
                  ori          a6, t5, 1716
                  sll          t2, s7, s3
                  addi         a1, t1, -1592
                  srli         s0, s11, 8
                  c.sub        a5, a1
                  c.sub        a5, a1
                  c.nop
                  c.andi       a4, 28
                  mul          a1, s1, t5
                  divu         t5, a7, tp
                  slt          t2, a1, s5
                  c.andi       a4, 28
                  c.lui        s9, 19
                  c.sub        a5, a1
                  c.and        a5, a4
                  slli         sp, t3, 13
                  divu         t5, a7, tp
                  mulhu        s3, s2, s7
                  c.srai       a4, 2
                  srai         gp, ra, 29
                  slli         sp, t3, 13
                  div          t1, s3, a1
                  mulhsu       s0, a1, t4
                  xori         a3, s4, 1809
                  slti         a0, a4, -1207
                  slli         sp, t3, 13
                  rem          sp, t6, tp
                  mul          a1, s1, t5
                  sra          sp, a2, sp
                  ori          a6, t5, 1716
                  mulhsu       s0, a1, t4
                  nop
                  divu         t5, a7, tp
                  mulh         zero, a3, gp
                  mul          a1, s1, t5
                  c.addi4spn   a5, sp, 464
                  slli         sp, t3, 13
                  addi         a1, t1, -1592
                  xor          s11, s5, a1
                  slti         a0, a4, -1207
                  slti         a0, a4, -1207
                  auipc        t1, 195699
                  c.li         a0, 14
                  remu         zero, s2, zero
                  div          t1, s3, a1
                  div          t1, s3, a1
                  div          t1, s3, a1
                  lui          sp, 776755
                  remu         zero, s2, zero
                  and          s7, a5, a7
                  rem          sp, t6, tp
                  xor          s11, s5, a1
                  remu         zero, s2, zero
                  c.srai       a4, 2
                  slli         sp, t3, 13
                  c.addi4spn   a5, sp, 464
                  xori         a3, s4, 1809
                  c.add        sp, s8
                  c.andi       a4, 28
                  c.xor        a3, a5
                  nop
                  and          s7, a5, a7
                  rem          sp, t6, tp
                  srli         s0, s11, 8
                  slli         sp, t3, 13
                  sra          sp, a2, sp
                  c.andi       a4, 28
                  sub          gp, s1, t2
                  slt          t2, a1, s5
                  c.srai       a4, 2
                  srl          s5, s7, sp
                  or           a2, a7, sp
                  srai         gp, ra, 29
                  mul          a1, s1, t5
                  div          t1, s3, a1
                  mulh         zero, a3, gp
                  remu         zero, s2, zero
                  c.slli       s4, 24
                  c.addi4spn   a5, sp, 464
                  ori          a6, t5, 1716
                  c.sub        a5, a1
                  mulh         zero, a3, gp
                  div          t1, s3, a1
                  c.li         a0, 14
                  mul          a1, s1, t5
                  srl          s5, s7, sp
                  sub          gp, s1, t2
                  c.nop
                  c.nop
                  mul          a1, s1, t5
                  add          s3, s11, s3
                  c.nop
                  div          t1, s3, a1
                  slti         a0, a4, -1207
                  c.addi4spn   a5, sp, 464
                  slli         sp, t3, 13
                  c.slli       s4, 24
                  slti         a0, a4, -1207
                  and          s7, a5, a7
                  srl          s5, s7, sp
                  div          t1, s3, a1
                  lui          sp, 776755
                  mulh         zero, a3, gp
                  add          s3, s11, s3
                  sub          gp, s1, t2
                  c.addi4spn   a5, sp, 464
                  c.or         a5, a4
                  c.slli       s4, 24
                  slli         sp, t3, 13
                  c.xor        a3, a5
                  sltiu        t6, s10, -519
                  c.addi       a2, -1
                  mulh         zero, a3, gp
                  c.and        a5, a4
                  c.mv         a2, a2
                  ori          a6, t5, 1716
                  c.add        sp, s8
                  addi         a1, t1, -1592
                  mulhsu       s0, a1, t4
                  c.addi16sp   sp, -16
                  mulhu        s3, s2, s7
                  srl          s5, s7, sp
                  or           a2, a7, sp
                  xor          s11, s5, a1
                  rem          sp, t6, tp
                  c.sub        a5, a1
                  add          s3, s11, s3
                  mul          a1, s1, t5
                  mulh         zero, a3, gp
                  srai         gp, ra, 29
                  auipc        t1, 195699
                  c.li         a0, 14
                  divu         t5, a7, tp
                  c.lui        s9, 19
                  c.andi       a4, 28
                  andi         t6, a4, 389
                  and          s7, a5, a7
                  sltu         s9, a4, a0
                  mulh         zero, a3, gp
                  mul          a1, s1, t5
                  remu         zero, s2, zero
                  addi         a1, t1, -1592
                  rem          sp, t6, tp
                  xori         a3, s4, 1809
                  remu         zero, s2, zero
                  sub          gp, s1, t2
                  mul          a1, s1, t5
                  li           a3, 0xffffffff #start riscv_int_numeric_corner_stream_25
                  li           a5, 0x0
                  li           s0, 0x0
                  li           s8, 0x4dca1754
                  li           s7, 0xffffffff
                  li           s10, 0x0
                  li           s5, 0x80000000
                  li           a1, 0x0
                  li           s3, 0xffffffff
                  li           s2, 0x3cd311a9
                  add          a1, a1, a5
                  divu         a1, a1, s2
                  divu         a1, a1, s2
                  addi         s10, s5, -1592
                  mulhsu       s7, s3, s0
                  remu         s0, a3, s0
                  nop
                  mul          s10, s10, a5
                  nop
                  mulhsu       s7, s3, s0
                  divu         a1, a1, s2
                  mulh         s0, s2, a5
                  nop
                  addi         s10, s5, -1592
                  divu         a1, a1, s2
                  add          a1, a1, a5
                  mulhu        a1, a3, s7
                  rem          a3, s5, s2
                  mulh         s0, s2, a5
                  addi         s10, s5, -1592
                  add          a1, a1, a5
                  div          s3, a5, s5
                  div          s3, a5, s5
                  mulhu        a1, a3, s7
                  nop
                  mulh         s0, s2, a5
                  addi         s10, s5, -1592 #end riscv_int_numeric_corner_stream_25
                  add          s3, s11, s3
                  remu         zero, s2, zero
                  sra          sp, a2, sp
                  sltu         s9, a4, a0
                  c.addi16sp   sp, -16
                  lui          sp, 776755
                  and          s7, a5, a7
                  slti         a0, a4, -1207
                  slli         sp, t3, 13
                  andi         t6, a4, 389
                  auipc        t1, 195699
                  c.addi16sp   sp, -16
                  lui          sp, 776755
                  srai         gp, ra, 29
                  c.nop
                  srli         s0, s11, 8
                  mul          a1, s1, t5
                  slt          t2, a1, s5
                  xori         a3, s4, 1809
                  c.or         a5, a4
                  c.addi       a2, -1
                  mulh         zero, a3, gp
                  c.addi4spn   a5, sp, 464
                  c.andi       a4, 28
                  andi         t6, a4, 389
                  sltu         s9, a4, a0
                  sub          gp, s1, t2
                  c.add        sp, s8
                  sub          gp, s1, t2
                  andi         t6, a4, 389
                  auipc        t1, 195699
                  xori         a3, s4, 1809
                  slti         a0, a4, -1207
                  c.mv         a2, a2
                  mulhsu       s0, a1, t4
                  mulhu        s3, s2, s7
                  c.mv         a2, a2
                  c.lui        s9, 19
                  c.mv         a2, a2
                  addi         a1, t1, -1592
                  c.srai       a4, 2
                  slli         sp, t3, 13
                  c.xor        a3, a5
                  or           a2, a7, sp
                  c.srai       a4, 2
                  divu         t5, a7, tp
                  xori         a3, s4, 1809
                  sll          t2, s7, s3
                  c.slli       s4, 24
                  auipc        t1, 195699
                  add          s3, s11, s3
                  lui          sp, 776755
                  c.nop
                  srli         s0, s11, 8
                  sra          sp, a2, sp
                  c.nop
                  nop
                  c.or         a5, a4
                  lui          sp, 776755
                  srl          s5, s7, sp
                  sra          sp, a2, sp
                  srl          s5, s7, sp
                  slt          t2, a1, s5
                  srli         s0, s11, 8
                  slti         a0, a4, -1207
                  divu         t5, a7, tp
                  c.and        a5, a4
                  slli         sp, t3, 13
                  c.addi4spn   a5, sp, 464
                  and          s7, a5, a7
                  slt          t2, a1, s5
                  c.and        a5, a4
                  ori          a6, t5, 1716
                  slli         sp, t3, 13
                  sltiu        t6, s10, -519
                  c.lui        s9, 19
                  lui          sp, 776755
                  c.lui        s9, 19
                  c.srli       a2, 1
                  c.lui        s9, 19
                  add          s3, s11, s3
                  mulhu        s3, s2, s7
                  divu         t5, a7, tp
                  c.addi       a2, -1
                  slti         a0, a4, -1207
                  lui          sp, 776755
                  c.srai       a4, 2
                  c.add        sp, s8
                  addi         a1, t1, -1592
                  c.addi       a2, -1
                  andi         t6, a4, 389
                  c.add        sp, s8
                  srl          s5, s7, sp
                  c.slli       s4, 24
                  slt          t2, a1, s5
                  sltiu        t6, s10, -519
                  ori          a6, t5, 1716
                  lui          sp, 776755
                  mulhu        s3, s2, s7
                  nop
                  c.srli       a2, 1
                  rem          sp, t6, tp
                  add          s3, s11, s3
                  c.srli       a2, 1
                  or           a2, a7, sp
                  mulh         zero, a3, gp
                  c.and        a5, a4
                  c.srai       a4, 2
                  c.addi16sp   sp, -16
                  xori         a3, s4, 1809
                  c.addi4spn   a5, sp, 464
                  ori          a6, t5, 1716
                  c.xor        a3, a5
                  addi         a1, t1, -1592
                  addi         a1, t1, -1592
                  sll          t2, s7, s3
                  c.nop
                  lui          sp, 776755
                  lui          sp, 776755
                  remu         zero, s2, zero
                  slt          t2, a1, s5
                  c.sub        a5, a1
                  and          s7, a5, a7
                  remu         zero, s2, zero
                  c.mv         a2, a2
                  srai         gp, ra, 29
                  andi         t6, a4, 389
                  c.addi16sp   sp, -16
                  remu         zero, s2, zero
                  mul          a1, s1, t5
                  sltu         s9, a4, a0
                  lui          sp, 776755
                  sra          sp, a2, sp
                  and          s7, a5, a7
                  c.and        a5, a4
                  remu         zero, s2, zero
                  lui          sp, 776755
                  c.xor        a3, a5
                  c.nop
                  xor          s11, s5, a1
                  or           a2, a7, sp
                  sll          t2, s7, s3
                  li           t2, 0xffffffff #start riscv_int_numeric_corner_stream_30
                  li           s6, 0x26fd53b8
                  li           a0, 0x0
                  li           s0, 0x80000000
                  li           gp, 0xffffffff
                  li           t6, 0x80000000
                  li           s8, 0xad1db3b0
                  li           s9, 0xd18fe34d
                  li           s10, 0x24012973
                  li           a1, 0x52f6170b
                  rem          s0, s8, a1
                  lui          s0, 776755
                  mulhsu       s9, s6, gp
                  mul          t6, t6, a0
                  div          s6, a0, s8
                  nop
                  auipc        s6, 195699
                  add          t2, t2, a0
                  nop
                  auipc        s6, 195699
                  div          s6, a0, s8
                  sub          a0, t6, s9
                  auipc        s6, 195699
                  rem          s0, s8, a1
                  add          t2, t2, a0
                  lui          s0, 776755
                  rem          s0, s8, a1
                  divu         t2, t2, a1
                  auipc        s6, 195699
                  mulhsu       s9, s6, gp
                  mulh         gp, a1, a0
                  div          s6, a0, s8
                  divu         t2, t2, a1
                  mulhsu       s9, s6, gp
                  mulhsu       s9, s6, gp
                  auipc        s6, 195699
                  mul          t6, t6, a0
                  mul          t6, t6, a0
                  add          t2, t2, a0 #end riscv_int_numeric_corner_stream_30
                  mulhu        s3, s2, s7
                  xor          s11, s5, a1
                  nop
                  sltu         s9, a4, a0
                  c.xor        a3, a5
                  srai         gp, ra, 29
                  addi         a1, t1, -1592
                  addi         a1, t1, -1592
                  and          s7, a5, a7
                  c.srli       a2, 1
                  c.and        a5, a4
                  c.srli       a2, 1
                  c.li         a0, 14
                  c.srai       a4, 2
                  sub          gp, s1, t2
                  xori         a3, s4, 1809
                  c.nop
                  slti         a0, a4, -1207
                  addi         a1, t1, -1592
                  sra          sp, a2, sp
                  srai         gp, ra, 29
                  c.slli       s4, 24
                  c.or         a5, a4
                  and          s7, a5, a7
                  nop
                  c.or         a5, a4
                  c.li         a0, 14
                  c.lui        s9, 19
                  c.and        a5, a4
                  sra          sp, a2, sp
                  c.addi4spn   a5, sp, 464
                  sub          gp, s1, t2
                  mul          a1, s1, t5
                  rem          sp, t6, tp
                  mulh         zero, a3, gp
                  c.srai       a4, 2
                  c.or         a5, a4
                  slti         a0, a4, -1207
                  c.srai       a4, 2
                  andi         t6, a4, 389
                  c.nop
                  srli         s0, s11, 8
                  sll          t2, s7, s3
                  xori         a3, s4, 1809
                  slti         a0, a4, -1207
                  srl          s5, s7, sp
                  div          t1, s3, a1
                  c.add        sp, s8
                  slti         a0, a4, -1207
                  xor          s11, s5, a1
                  c.andi       a4, 28
                  lui          sp, 776755
                  c.add        sp, s8
                  divu         t5, a7, tp
                  mul          a1, s1, t5
                  rem          sp, t6, tp
                  slli         sp, t3, 13
                  andi         t6, a4, 389
                  c.li         a0, 14
                  c.addi4spn   a5, sp, 464
                  srli         s0, s11, 8
                  c.or         a5, a4
                  addi         a1, t1, -1592
                  srl          s5, s7, sp
                  xor          s11, s5, a1
                  slt          t2, a1, s5
                  mulhu        s3, s2, s7
                  addi         a1, t1, -1592
                  nop
                  sltiu        t6, s10, -519
                  srli         s0, s11, 8
                  slli         sp, t3, 13
                  c.add        sp, s8
                  c.srli       a2, 1
                  c.and        a5, a4
                  xor          s11, s5, a1
                  xor          s11, s5, a1
                  sltiu        t6, s10, -519
                  c.lui        s9, 19
                  xori         a3, s4, 1809
                  c.addi4spn   a5, sp, 464
                  mul          a1, s1, t5
                  sub          gp, s1, t2
                  nop
                  sll          t2, s7, s3
                  c.nop
                  c.addi       a2, -1
                  auipc        t1, 195699
                  auipc        t1, 195699
                  auipc        t1, 195699
                  sll          t2, s7, s3
                  srl          s5, s7, sp
                  mulh         zero, a3, gp
                  slt          t2, a1, s5
                  mul          a1, s1, t5
                  and          s7, a5, a7
                  or           a2, a7, sp
                  addi         a1, t1, -1592
                  auipc        t1, 195699
                  c.srai       a4, 2
                  divu         t5, a7, tp
                  srai         gp, ra, 29
                  mulh         zero, a3, gp
                  div          t1, s3, a1
                  xori         a3, s4, 1809
                  div          t1, s3, a1
                  c.srli       a2, 1
                  mulhsu       s0, a1, t4
                  c.lui        s9, 19
                  slti         a0, a4, -1207
                  or           a2, a7, sp
                  c.or         a5, a4
                  c.slli       s4, 24
                  c.addi16sp   sp, -16
                  c.addi4spn   a5, sp, 464
                  srli         s0, s11, 8
                  srl          s5, s7, sp
                  auipc        t1, 195699
                  nop
                  c.addi       a2, -1
                  xori         a3, s4, 1809
                  srli         s0, s11, 8
                  add          s3, s11, s3
                  c.srai       a4, 2
                  sra          sp, a2, sp
                  xori         a3, s4, 1809
                  srl          s5, s7, sp
                  rem          sp, t6, tp
                  c.xor        a3, a5
                  slli         sp, t3, 13
                  divu         t5, a7, tp
                  or           a2, a7, sp
                  c.sub        a5, a1
                  xor          s11, s5, a1
                  sltu         s9, a4, a0
                  c.mv         a2, a2
                  c.srli       a2, 1
                  div          t1, s3, a1
                  sub          gp, s1, t2
                  ori          a6, t5, 1716
                  mul          a1, s1, t5
                  divu         t5, a7, tp
                  c.add        sp, s8
                  sltu         s9, a4, a0
                  div          t1, s3, a1
                  c.slli       s4, 24
                  div          t1, s3, a1
                  c.xor        a3, a5
                  srli         s0, s11, 8
                  c.mv         a2, a2
                  remu         zero, s2, zero
                  remu         zero, s2, zero
                  addi         a1, t1, -1592
                  c.lui        s9, 19
                  c.sub        a5, a1
                  lui          sp, 776755
                  c.srli       a2, 1
                  slli         sp, t3, 13
                  c.lui        s9, 19
                  c.addi4spn   a5, sp, 464
                  c.and        a5, a4
                  or           a2, a7, sp
                  c.li         a0, 14
                  ori          a6, t5, 1716
                  sub          gp, s1, t2
                  xor          s11, s5, a1
                  addi         a1, t1, -1592
                  mulhsu       s0, a1, t4
                  c.xor        a3, a5
                  c.sub        a5, a1
                  lui          sp, 776755
                  mulhu        s3, s2, s7
                  c.add        sp, s8
                  c.or         a5, a4
                  lui          sp, 776755
                  slli         sp, t3, 13
                  slt          t2, a1, s5
                  c.mv         a2, a2
                  c.andi       a4, 28
                  c.and        a5, a4
                  ori          a6, t5, 1716
                  slt          t2, a1, s5
                  c.andi       a4, 28
                  c.andi       a4, 28
                  andi         t6, a4, 389
                  sub          gp, s1, t2
                  c.addi4spn   a5, sp, 464
                  div          t1, s3, a1
                  mulhsu       s0, a1, t4
                  c.addi       a2, -1
                  slt          t2, a1, s5
                  c.nop
                  mulh         zero, a3, gp
                  auipc        t1, 195699
                  srli         s0, s11, 8
                  sub          gp, s1, t2
                  c.srai       a4, 2
                  mulhsu       s0, a1, t4
                  ori          a6, t5, 1716
                  srli         s0, s11, 8
                  sltu         s9, a4, a0
                  mul          a1, s1, t5
                  c.xor        a3, a5
                  c.or         a5, a4
                  srl          s5, s7, sp
                  mulh         zero, a3, gp
                  srl          s5, s7, sp
                  c.and        a5, a4
                  sltu         s9, a4, a0
                  sll          t2, s7, s3
                  c.andi       a4, 28
                  auipc        t1, 195699
                  xori         a3, s4, 1809
                  mulhsu       s0, a1, t4
                  sltiu        t6, s10, -519
                  add          s3, s11, s3
                  or           a2, a7, sp
                  srli         s0, s11, 8
                  slli         sp, t3, 13
                  c.slli       s4, 24
                  sub          gp, s1, t2
                  andi         t6, a4, 389
                  lui          sp, 776755
                  add          s3, s11, s3
                  c.and        a5, a4
                  srl          s5, s7, sp
                  lui          sp, 776755
                  mulh         zero, a3, gp
                  c.addi4spn   a5, sp, 464
                  sltu         s9, a4, a0
                  c.srai       a4, 2
                  slli         sp, t3, 13
                  c.nop
                  c.srai       a4, 2
                  slt          t2, a1, s5
                  add          s3, s11, s3
                  c.xor        a3, a5
                  c.addi16sp   sp, -16
                  c.mv         a2, a2
                  lui          sp, 776755
                  c.slli       s4, 24
                  c.or         a5, a4
                  sra          sp, a2, sp
                  c.xor        a3, a5
                  or           a2, a7, sp
                  remu         zero, s2, zero
                  c.andi       a4, 28
                  mulhu        s3, s2, s7
                  c.nop
                  andi         t6, a4, 389
                  sltiu        t6, s10, -519
                  ori          a6, t5, 1716
                  andi         t6, a4, 389
                  add          s3, s11, s3
                  andi         t6, a4, 389
                  srai         gp, ra, 29
                  sra          sp, a2, sp
                  c.addi       a2, -1
                  rem          sp, t6, tp
                  c.nop
                  c.xor        a3, a5
                  and          s7, a5, a7
                  c.srli       a2, 1
                  ori          a6, t5, 1716
                  add          s3, s11, s3
                  mulhsu       s0, a1, t4
                  c.li         a0, 14
                  div          t1, s3, a1
                  c.slli       s4, 24
                  lui          sp, 776755
                  nop
                  add          s3, s11, s3
                  mul          a1, s1, t5
                  rem          sp, t6, tp
                  or           a2, a7, sp
                  li           s9, 0xf7d655b2 #start riscv_int_numeric_corner_stream_28
                  li           s11, 0x0
                  li           s2, 0x2d02bc9c
                  li           s8, 0xc491251c
                  li           a5, 0x0
                  li           s4, 0xffffffff
                  li           s10, 0x0
                  li           a0, 0x6a0d51b3
                  li           s7, 0x80000000
                  li           a1, 0xffffffff
                  sub          s2, s11, s9
                  rem          a5, s8, s4
                  mulh         a0, s4, s2
                  add          a1, a1, s2
                  mulhsu       s9, s7, a0
                  mulh         a0, s4, s2
                  remu         a0, a5, a0
                  lui          a5, 776755
                  div          s7, s2, s8
                  mul          s11, s11, s2
                  mulhu        a1, a5, s9
                  mulhsu       s9, s7, a0
                  add          a1, a1, s2
                  mulhsu       s9, s7, a0
                  mulhu        a1, a5, s9
                  mulhsu       s9, s7, a0
                  divu         a1, a1, s4
                  mulh         a0, s4, s2
                  add          a1, a1, s2
                  remu         a0, a5, a0
                  lui          a5, 776755 #end riscv_int_numeric_corner_stream_28
                  c.lui        s9, 19
                  mulh         zero, a3, gp
                  rem          sp, t6, tp
                  c.srli       a2, 1
                  addi         a1, t1, -1592
                  nop
                  c.or         a5, a4
                  c.or         a5, a4
                  c.andi       a4, 28
                  sra          sp, a2, sp
                  xor          s11, s5, a1
                  c.add        sp, s8
                  rem          sp, t6, tp
                  c.slli       s4, 24
                  c.add        sp, s8
                  c.lui        s9, 19
                  slli         sp, t3, 13
                  sltiu        t6, s10, -519
                  mulhsu       s0, a1, t4
                  andi         t6, a4, 389
                  mul          a1, s1, t5
                  mulh         zero, a3, gp
                  srai         gp, ra, 29
                  c.nop
                  c.mv         a2, a2
                  nop
                  c.mv         a2, a2
                  and          s7, a5, a7
                  c.srli       a2, 1
                  c.li         a0, 14
                  mulhsu       s0, a1, t4
                  addi         a1, t1, -1592
                  sltiu        t6, s10, -519
                  remu         zero, s2, zero
                  c.xor        a3, a5
                  c.and        a5, a4
                  sltiu        t6, s10, -519
                  or           a2, a7, sp
                  div          t1, s3, a1
                  slt          t2, a1, s5
                  sub          gp, s1, t2
                  slt          t2, a1, s5
                  remu         zero, s2, zero
                  slt          t2, a1, s5
                  and          s7, a5, a7
                  c.lui        s9, 19
                  xori         a3, s4, 1809
                  c.addi4spn   a5, sp, 464
                  c.add        sp, s8
                  mul          a1, s1, t5
                  sltiu        t6, s10, -519
                  mulh         zero, a3, gp
                  div          t1, s3, a1
                  xori         a3, s4, 1809
                  and          s7, a5, a7
                  c.li         a0, 14
                  nop
                  c.and        a5, a4
                  mulh         zero, a3, gp
                  c.sub        a5, a1
                  srl          s5, s7, sp
                  c.addi4spn   a5, sp, 464
                  c.sub        a5, a1
                  sll          t2, s7, s3
                  sltu         s9, a4, a0
                  c.and        a5, a4
                  srai         gp, ra, 29
                  auipc        t1, 195699
                  add          s3, s11, s3
                  c.lui        s9, 19
                  sra          sp, a2, sp
                  lui          sp, 776755
                  c.or         a5, a4
                  xor          s11, s5, a1
                  and          s7, a5, a7
                  sltiu        t6, s10, -519
                  rem          sp, t6, tp
                  c.srai       a4, 2
                  c.slli       s4, 24
                  divu         t5, a7, tp
                  remu         zero, s2, zero
                  and          s7, a5, a7
                  andi         t6, a4, 389
                  c.addi4spn   a5, sp, 464
                  mul          a1, s1, t5
                  srli         s0, s11, 8
                  add          s3, s11, s3
                  and          s7, a5, a7
                  c.mv         a2, a2
                  srl          s5, s7, sp
                  mulhsu       s0, a1, t4
                  mulhu        s3, s2, s7
                  divu         t5, a7, tp
                  ori          a6, t5, 1716
                  c.andi       a4, 28
                  slt          t2, a1, s5
                  auipc        t1, 195699
                  sra          sp, a2, sp
                  sra          sp, a2, sp
                  divu         t5, a7, tp
                  divu         t5, a7, tp
                  c.slli       s4, 24
                  xori         a3, s4, 1809
                  xori         a3, s4, 1809
                  sll          t2, s7, s3
                  and          s7, a5, a7
                  sltu         s9, a4, a0
                  slt          t2, a1, s5
                  c.addi16sp   sp, -16
                  c.sub        a5, a1
                  and          s7, a5, a7
                  c.addi       a2, -1
                  c.addi4spn   a5, sp, 464
                  divu         t5, a7, tp
                  c.srai       a4, 2
                  addi         a1, t1, -1592
                  slti         a0, a4, -1207
                  addi         a1, t1, -1592
                  c.slli       s4, 24
                  slti         a0, a4, -1207
                  rem          sp, t6, tp
                  c.or         a5, a4
                  slt          t2, a1, s5
                  add          s3, s11, s3
                  auipc        t1, 195699
                  mulhsu       s0, a1, t4
                  c.sub        a5, a1
                  mul          a1, s1, t5
                  xori         a3, s4, 1809
                  lui          sp, 776755
                  rem          sp, t6, tp
                  sub          gp, s1, t2
                  addi         a1, t1, -1592
                  rem          sp, t6, tp
                  c.andi       a4, 28
                  xor          s11, s5, a1
                  add          s3, s11, s3
                  c.xor        a3, a5
                  addi         a1, t1, -1592
                  c.mv         a2, a2
                  slti         a0, a4, -1207
                  c.add        sp, s8
                  c.nop
                  xor          s11, s5, a1
                  mulhsu       s0, a1, t4
                  mul          a1, s1, t5
                  nop
                  lui          sp, 776755
                  c.add        sp, s8
                  c.srli       a2, 1
                  sra          sp, a2, sp
                  ori          a6, t5, 1716
                  c.addi4spn   a5, sp, 464
                  mul          a1, s1, t5
                  c.nop
                  div          t1, s3, a1
                  c.slli       s4, 24
                  ori          a6, t5, 1716
                  addi         a1, t1, -1592
                  srli         s0, s11, 8
                  lui          sp, 776755
                  divu         t5, a7, tp
                  slti         a0, a4, -1207
                  or           a2, a7, sp
                  c.sub        a5, a1
                  srl          s5, s7, sp
                  c.slli       s4, 24
                  c.addi       a2, -1
                  xori         a3, s4, 1809
                  sub          gp, s1, t2
                  xor          s11, s5, a1
                  mulhu        s3, s2, s7
                  add          s3, s11, s3
                  c.add        sp, s8
                  c.or         a5, a4
                  c.and        a5, a4
                  div          t1, s3, a1
                  c.srai       a4, 2
                  sltiu        t6, s10, -519
                  srl          s5, s7, sp
                  c.or         a5, a4
                  srli         s0, s11, 8
                  srli         s0, s11, 8
                  sltiu        t6, s10, -519
                  mulh         zero, a3, gp
                  lui          sp, 776755
                  c.or         a5, a4
                  nop
                  sra          sp, a2, sp
                  ori          a6, t5, 1716
                  mulh         zero, a3, gp
                  mulh         zero, a3, gp
                  rem          sp, t6, tp
                  nop
                  add          s3, s11, s3
                  c.mv         a2, a2
                  andi         t6, a4, 389
                  remu         zero, s2, zero
                  sll          t2, s7, s3
                  c.addi       a2, -1
                  mulhsu       s0, a1, t4
                  add          s3, s11, s3
                  li           t1, 0x80000000 #start riscv_int_numeric_corner_stream_9
                  li           t6, 0x0
                  li           t0, 0xa3939748
                  li           s2, 0xa9e9c363
                  li           s3, 0x0
                  li           ra, 0xffffffff
                  li           a7, 0x2003ba8f
                  li           s4, 0x0
                  li           s6, 0x80000000
                  li           a5, 0x0
                  mul          t6, t6, a5
                  add          t0, t0, a5
                  sub          a5, t6, s4
                  auipc        s2, 195699
                  mulhu        t0, t1, s4
                  mulhsu       s4, s2, ra
                  mulhsu       s4, s2, ra
                  rem          t1, s3, a7
                  remu         ra, t1, ra
                  mulh         ra, a7, a5
                  mulhu        t0, t1, s4
                  sub          a5, t6, s4
                  sub          a5, t6, s4
                  mulhsu       s4, s2, ra
                  mulh         ra, a7, a5
                  auipc        s2, 195699
                  remu         ra, t1, ra
                  add          t0, t0, a5
                  divu         t0, t0, a7
                  nop
                  sub          a5, t6, s4
                  auipc        s2, 195699
                  div          s2, a5, s3
                  mulh         ra, a7, a5
                  nop #end riscv_int_numeric_corner_stream_9
                  ori          a6, t5, 1716
                  c.xor        a3, a5
                  divu         t5, a7, tp
                  mulhsu       s0, a1, t4
                  slli         sp, t3, 13
                  auipc        t1, 195699
                  auipc        t1, 195699
                  rem          sp, t6, tp
                  srli         s0, s11, 8
                  c.xor        a3, a5
                  mulhu        s3, s2, s7
                  remu         zero, s2, zero
                  c.and        a5, a4
                  rem          sp, t6, tp
                  c.sub        a5, a1
                  srli         s0, s11, 8
                  c.addi       a2, -1
                  div          t1, s3, a1
                  addi         a1, t1, -1592
                  add          s3, s11, s3
                  mulh         zero, a3, gp
                  sll          t2, s7, s3
                  c.nop
                  srli         s0, s11, 8
                  srl          s5, s7, sp
                  remu         zero, s2, zero
                  mulhsu       s0, a1, t4
                  srl          s5, s7, sp
                  sra          sp, a2, sp
                  srai         gp, ra, 29
                  sltu         s9, a4, a0
                  mulhu        s3, s2, s7
                  sltu         s9, a4, a0
                  mulhu        s3, s2, s7
                  xori         a3, s4, 1809
                  mul          a1, s1, t5
                  c.sub        a5, a1
                  xori         a3, s4, 1809
                  c.addi16sp   sp, -16
                  mul          a1, s1, t5
                  mulhsu       s0, a1, t4
                  c.add        sp, s8
                  mulhu        s3, s2, s7
                  slt          t2, a1, s5
                  c.slli       s4, 24
                  xori         a3, s4, 1809
                  or           a2, a7, sp
                  c.srai       a4, 2
                  andi         t6, a4, 389
                  mul          a1, s1, t5
                  sra          sp, a2, sp
                  lui          sp, 776755
                  div          t1, s3, a1
                  slli         sp, t3, 13
                  rem          sp, t6, tp
                  mulhu        s3, s2, s7
                  srl          s5, s7, sp
                  c.srli       a2, 1
                  sltiu        t6, s10, -519
                  c.addi16sp   sp, -16
                  add          s3, s11, s3
                  ori          a6, t5, 1716
                  c.addi       a2, -1
                  c.addi       a2, -1
                  srli         s0, s11, 8
                  slli         sp, t3, 13
                  andi         t6, a4, 389
                  srai         gp, ra, 29
                  or           a2, a7, sp
                  div          t1, s3, a1
                  c.add        sp, s8
                  add          s3, s11, s3
                  mulhsu       s0, a1, t4
                  divu         t5, a7, tp
                  c.addi16sp   sp, -16
                  andi         t6, a4, 389
                  c.li         a0, 14
                  mulh         zero, a3, gp
                  mulhsu       s0, a1, t4
                  srai         gp, ra, 29
                  c.mv         a2, a2
                  sll          t2, s7, s3
                  c.or         a5, a4
                  remu         zero, s2, zero
                  c.nop
                  nop
                  c.nop
                  xori         a3, s4, 1809
                  c.andi       a4, 28
                  srl          s5, s7, sp
                  andi         t6, a4, 389
                  andi         t6, a4, 389
                  c.nop
                  c.or         a5, a4
                  sltiu        t6, s10, -519
                  c.or         a5, a4
                  xor          s11, s5, a1
                  lui          sp, 776755
                  sra          sp, a2, sp
                  slli         sp, t3, 13
                  sra          sp, a2, sp
                  sltu         s9, a4, a0
                  remu         zero, s2, zero
                  c.add        sp, s8
                  nop
                  sltu         s9, a4, a0
                  sltu         s9, a4, a0
                  or           a2, a7, sp
                  nop
                  mulh         zero, a3, gp
                  c.addi       a2, -1
                  xor          s11, s5, a1
                  c.addi16sp   sp, -16
                  srai         gp, ra, 29
                  sltu         s9, a4, a0
                  c.addi       a2, -1
                  c.addi16sp   sp, -16
                  c.mv         a2, a2
                  c.sub        a5, a1
                  nop
                  c.srli       a2, 1
                  srli         s0, s11, 8
                  c.andi       a4, 28
                  c.addi16sp   sp, -16
                  c.xor        a3, a5
                  c.slli       s4, 24
                  c.lui        s9, 19
                  sll          t2, s7, s3
                  nop
                  slt          t2, a1, s5
                  addi         a1, t1, -1592
                  add          s3, s11, s3
                  c.xor        a3, a5
                  c.mv         a2, a2
                  div          t1, s3, a1
                  sltu         s9, a4, a0
                  lui          sp, 776755
                  sltu         s9, a4, a0
                  c.xor        a3, a5
                  slt          t2, a1, s5
                  c.slli       s4, 24
                  xor          s11, s5, a1
                  c.slli       s4, 24
                  c.mv         a2, a2
                  mul          a1, s1, t5
                  c.and        a5, a4
                  mul          a1, s1, t5
                  c.nop
                  sltiu        t6, s10, -519
                  c.sub        a5, a1
                  c.srai       a4, 2
                  c.sub        a5, a1
                  mulhsu       s0, a1, t4
                  mul          a1, s1, t5
                  mulhu        s3, s2, s7
                  mulh         zero, a3, gp
                  c.addi       a2, -1
                  sra          sp, a2, sp
                  c.nop
                  ori          a6, t5, 1716
                  c.and        a5, a4
                  c.srli       a2, 1
                  xori         a3, s4, 1809
                  remu         zero, s2, zero
                  mulhsu       s0, a1, t4
                  div          t1, s3, a1
                  srai         gp, ra, 29
                  c.srli       a2, 1
                  slli         sp, t3, 13
                  c.srli       a2, 1
                  c.and        a5, a4
                  srl          s5, s7, sp
                  c.sub        a5, a1
                  mulhsu       s0, a1, t4
                  mul          a1, s1, t5
                  c.add        sp, s8
                  mul          a1, s1, t5
                  srai         gp, ra, 29
                  auipc        t1, 195699
                  c.xor        a3, a5
                  slt          t2, a1, s5
                  and          s7, a5, a7
                  rem          sp, t6, tp
                  sll          t2, s7, s3
                  c.or         a5, a4
                  auipc        t1, 195699
                  slli         sp, t3, 13
                  xori         a3, s4, 1809
                  auipc        t1, 195699
                  c.srai       a4, 2
                  sll          t2, s7, s3
                  or           a2, a7, sp
                  c.addi16sp   sp, -16
                  slt          t2, a1, s5
                  c.andi       a4, 28
                  ori          a6, t5, 1716
                  c.addi       a2, -1
                  ori          a6, t5, 1716
                  c.nop
                  sll          t2, s7, s3
                  slt          t2, a1, s5
                  c.addi4spn   a5, sp, 464
                  c.srai       a4, 2
                  div          t1, s3, a1
                  mulh         zero, a3, gp
                  c.sub        a5, a1
                  div          t1, s3, a1
                  srl          s5, s7, sp
                  auipc        t1, 195699
                  srai         gp, ra, 29
                  slli         sp, t3, 13
                  c.li         a0, 14
                  c.add        sp, s8
                  slti         a0, a4, -1207
                  c.srai       a4, 2
                  srai         gp, ra, 29
                  div          t1, s3, a1
                  c.srai       a4, 2
                  c.srai       a4, 2
                  xori         a3, s4, 1809
                  mulh         zero, a3, gp
                  c.sub        a5, a1
                  xori         a3, s4, 1809
                  mul          a1, s1, t5
                  c.lui        s9, 19
                  c.nop
                  c.lui        s9, 19
                  xor          s11, s5, a1
                  c.li         a0, 14
                  srl          s5, s7, sp
                  c.or         a5, a4
                  c.addi16sp   sp, -16
                  c.nop
                  sra          sp, a2, sp
                  xori         a3, s4, 1809
                  c.srai       a4, 2
                  srl          s5, s7, sp
                  div          t1, s3, a1
                  c.sub        a5, a1
                  mulhu        s3, s2, s7
                  c.srli       a2, 1
                  c.xor        a3, a5
                  div          t1, s3, a1
                  c.addi16sp   sp, -16
                  c.xor        a3, a5
                  srai         gp, ra, 29
                  slti         a0, a4, -1207
                  mulhsu       s0, a1, t4
                  c.addi16sp   sp, -16
                  slli         sp, t3, 13
                  slt          t2, a1, s5
                  andi         t6, a4, 389
                  auipc        t1, 195699
                  mulh         zero, a3, gp
                  mulhsu       s0, a1, t4
                  andi         t6, a4, 389
                  remu         zero, s2, zero
                  andi         t6, a4, 389
                  ori          a6, t5, 1716
                  c.and        a5, a4
                  remu         zero, s2, zero
                  divu         t5, a7, tp
                  c.and        a5, a4
                  srl          s5, s7, sp
                  c.mv         a2, a2
                  ori          a6, t5, 1716
                  mul          a1, s1, t5
                  mul          a1, s1, t5
                  auipc        t1, 195699
                  sltiu        t6, s10, -519
                  mulh         zero, a3, gp
                  c.slli       s4, 24
                  c.nop
                  xor          s11, s5, a1
                  mulh         zero, a3, gp
                  sra          sp, a2, sp
                  c.slli       s4, 24
                  mulh         zero, a3, gp
                  slt          t2, a1, s5
                  srl          s5, s7, sp
                  c.addi16sp   sp, -16
                  c.addi16sp   sp, -16
                  sll          t2, s7, s3
                  c.mv         a2, a2
                  c.srli       a2, 1
                  c.srai       a4, 2
                  c.andi       a4, 28
                  addi         a1, t1, -1592
                  andi         t6, a4, 389
                  auipc        t1, 195699
                  slt          t2, a1, s5
                  c.li         a0, 14
                  nop
                  xor          s11, s5, a1
                  slti         a0, a4, -1207
                  mul          a1, s1, t5
                  add          s3, s11, s3
                  sltiu        t6, s10, -519
                  mulh         zero, a3, gp
                  mulh         zero, a3, gp
                  andi         t6, a4, 389
                  auipc        t1, 195699
                  slti         a0, a4, -1207
                  add          s3, s11, s3
                  auipc        t1, 195699
                  sltiu        t6, s10, -519
                  c.sub        a5, a1
                  c.add        sp, s8
                  slt          t2, a1, s5
                  sltu         s9, a4, a0
                  c.or         a5, a4
                  c.mv         a2, a2
                  or           a2, a7, sp
                  sltu         s9, a4, a0
                  c.andi       a4, 28
                  c.mv         a2, a2
                  mulhu        s3, s2, s7
                  c.lui        s9, 19
                  mulhsu       s0, a1, t4
                  srai         gp, ra, 29
                  c.slli       s4, 24
                  c.addi4spn   a5, sp, 464
                  sll          t2, s7, s3
                  mul          a1, s1, t5
                  slt          t2, a1, s5
                  srli         s0, s11, 8
                  or           a2, a7, sp
                  ori          a6, t5, 1716
                  c.xor        a3, a5
                  ori          a6, t5, 1716
                  c.nop
                  c.andi       a4, 28
                  slt          t2, a1, s5
                  c.and        a5, a4
                  add          s3, s11, s3
                  c.addi4spn   a5, sp, 464
                  slli         sp, t3, 13
                  mulhsu       s0, a1, t4
                  srl          s5, s7, sp
                  sra          sp, a2, sp
                  sll          t2, s7, s3
                  srl          s5, s7, sp
                  c.srli       a2, 1
                  mulhsu       s0, a1, t4
                  mul          a1, s1, t5
                  c.srai       a4, 2
                  sltu         s9, a4, a0
                  c.addi4spn   a5, sp, 464
                  srli         s0, s11, 8
                  c.xor        a3, a5
                  div          t1, s3, a1
                  div          t1, s3, a1
                  andi         t6, a4, 389
                  c.srai       a4, 2
                  div          t1, s3, a1
                  sra          sp, a2, sp
                  c.sub        a5, a1
                  rem          sp, t6, tp
                  mulhsu       s0, a1, t4
                  or           a2, a7, sp
                  c.li         a0, 14
                  c.xor        a3, a5
                  addi         a1, t1, -1592
                  mul          a1, s1, t5
                  slli         sp, t3, 13
                  addi         a1, t1, -1592
                  rem          sp, t6, tp
                  slli         sp, t3, 13
                  sltiu        t6, s10, -519
                  remu         zero, s2, zero
                  sltu         s9, a4, a0
                  c.lui        s9, 19
                  xori         a3, s4, 1809
                  c.or         a5, a4
                  c.srai       a4, 2
                  sra          sp, a2, sp
                  c.or         a5, a4
                  c.and        a5, a4
                  c.srai       a4, 2
                  srai         gp, ra, 29
                  and          s7, a5, a7
                  xor          s11, s5, a1
                  c.or         a5, a4
                  mul          a1, s1, t5
                  xori         a3, s4, 1809
                  andi         t6, a4, 389
                  srli         s0, s11, 8
                  lui          sp, 776755
                  divu         t5, a7, tp
                  mul          a1, s1, t5
                  and          s7, a5, a7
                  c.or         a5, a4
                  add          s3, s11, s3
                  c.slli       s4, 24
                  c.addi16sp   sp, -16
                  nop
                  sltiu        t6, s10, -519
                  addi         a1, t1, -1592
                  slli         sp, t3, 13
                  and          s7, a5, a7
                  slti         a0, a4, -1207
                  sltu         s9, a4, a0
                  c.addi4spn   a5, sp, 464
                  or           a2, a7, sp
                  div          t1, s3, a1
                  sub          gp, s1, t2
                  ori          a6, t5, 1716
                  mul          a1, s1, t5
                  slti         a0, a4, -1207
                  div          t1, s3, a1
                  c.and        a5, a4
                  addi         a1, t1, -1592
                  nop
                  rem          sp, t6, tp
                  c.srai       a4, 2
                  c.or         a5, a4
                  c.and        a5, a4
                  lui          sp, 776755
                  add          s3, s11, s3
                  sra          sp, a2, sp
                  srl          s5, s7, sp
                  c.addi16sp   sp, -16
                  sub          gp, s1, t2
                  and          s7, a5, a7
                  c.addi4spn   a5, sp, 464
                  mul          a1, s1, t5
                  ori          a6, t5, 1716
                  xori         a3, s4, 1809
                  nop
                  c.li         a0, 14
                  slli         sp, t3, 13
                  sub          gp, s1, t2
                  c.slli       s4, 24
                  xori         a3, s4, 1809
                  slt          t2, a1, s5
                  c.mv         a2, a2
                  lui          sp, 776755
                  mul          a1, s1, t5
                  nop
                  c.mv         a2, a2
                  c.srli       a2, 1
                  c.andi       a4, 28
                  srl          s5, s7, sp
                  sll          t2, s7, s3
                  c.addi16sp   sp, -16
                  sltiu        t6, s10, -519
                  remu         zero, s2, zero
                  mulhu        s3, s2, s7
                  slli         sp, t3, 13
                  slli         sp, t3, 13
                  sltiu        t6, s10, -519
                  sltiu        t6, s10, -519
                  xor          s11, s5, a1
                  mulh         zero, a3, gp
                  c.or         a5, a4
                  sub          gp, s1, t2
                  c.lui        s9, 19
                  c.sub        a5, a1
                  mulhu        s3, s2, s7
                  nop
                  srl          s5, s7, sp
                  rem          sp, t6, tp
                  c.srli       a2, 1
                  andi         t6, a4, 389
                  c.srai       a4, 2
                  c.and        a5, a4
                  or           a2, a7, sp
                  or           a2, a7, sp
                  rem          sp, t6, tp
                  rem          sp, t6, tp
                  srl          s5, s7, sp
                  xor          s11, s5, a1
                  c.or         a5, a4
                  add          s3, s11, s3
                  c.add        sp, s8
                  lui          sp, 776755
                  nop
                  slti         a0, a4, -1207
                  sltiu        t6, s10, -519
                  c.and        a5, a4
                  c.li         a0, 14
                  c.addi4spn   a5, sp, 464
                  srl          s5, s7, sp
                  srai         gp, ra, 29
                  c.andi       a4, 28
                  addi         a1, t1, -1592
                  sltiu        t6, s10, -519
                  ori          a6, t5, 1716
                  mulh         zero, a3, gp
                  c.addi4spn   a5, sp, 464
                  sub          gp, s1, t2
                  sll          t2, s7, s3
                  c.nop
                  c.lui        s9, 19
                  addi         a1, t1, -1592
                  c.slli       s4, 24
                  slt          t2, a1, s5
                  sll          t2, s7, s3
                  c.mv         a2, a2
                  c.addi       a2, -1
                  addi         a1, t1, -1592
                  c.srli       a2, 1
                  sltu         s9, a4, a0
                  c.addi16sp   sp, -16
                  sltiu        t6, s10, -519
                  addi         a1, t1, -1592
                  c.sub        a5, a1
                  mulh         zero, a3, gp
                  sll          t2, s7, s3
                  divu         t5, a7, tp
                  sra          sp, a2, sp
                  slt          t2, a1, s5
                  srl          s5, s7, sp
                  andi         t6, a4, 389
                  c.addi       a2, -1
                  c.srai       a4, 2
                  and          s7, a5, a7
                  addi         a1, t1, -1592
                  ori          a6, t5, 1716
                  div          t1, s3, a1
                  auipc        t1, 195699
                  c.nop
                  add          s3, s11, s3
                  andi         t6, a4, 389
                  srl          s5, s7, sp
                  c.and        a5, a4
                  addi         a1, t1, -1592
                  c.addi4spn   a5, sp, 464
                  c.srli       a2, 1
                  mul          a1, s1, t5
                  sltu         s9, a4, a0
                  rem          sp, t6, tp
                  slli         sp, t3, 13
                  sltiu        t6, s10, -519
                  mulhu        s3, s2, s7
                  lui          sp, 776755
                  c.addi16sp   sp, -16
                  c.nop
                  sra          sp, a2, sp
                  auipc        t1, 195699
                  addi         a1, t1, -1592
                  c.slli       s4, 24
                  xor          s11, s5, a1
                  c.andi       a4, 28
                  sltiu        t6, s10, -519
                  c.andi       a4, 28
                  slli         sp, t3, 13
                  c.addi4spn   a5, sp, 464
                  c.nop
                  addi         a1, t1, -1592
                  add          s3, s11, s3
                  sltiu        t6, s10, -519
                  srai         gp, ra, 29
                  c.xor        a3, a5
                  sra          sp, a2, sp
                  srli         s0, s11, 8
                  sub          gp, s1, t2
                  nop
                  c.slli       s4, 24
                  c.li         a0, 14
                  add          s3, s11, s3
                  slt          t2, a1, s5
                  mulh         zero, a3, gp
                  c.andi       a4, 28
                  mulhsu       s0, a1, t4
                  divu         t5, a7, tp
                  mulhsu       s0, a1, t4
                  sll          t2, s7, s3
                  srl          s5, s7, sp
                  c.and        a5, a4
                  srai         gp, ra, 29
                  ori          a6, t5, 1716
                  slti         a0, a4, -1207
                  c.add        sp, s8
                  mulhu        s3, s2, s7
                  remu         zero, s2, zero
                  add          s3, s11, s3
                  c.srai       a4, 2
                  xori         a3, s4, 1809
                  c.xor        a3, a5
                  xor          s11, s5, a1
                  rem          sp, t6, tp
                  div          t1, s3, a1
                  c.sub        a5, a1
                  sltu         s9, a4, a0
                  sra          sp, a2, sp
                  c.lui        s9, 19
                  mulhsu       s0, a1, t4
                  rem          sp, t6, tp
                  and          s7, a5, a7
                  and          s7, a5, a7
                  srai         gp, ra, 29
                  srai         gp, ra, 29
                  xor          s11, s5, a1
                  and          s7, a5, a7
                  mulhsu       s0, a1, t4
                  addi         a1, t1, -1592
                  srli         s0, s11, 8
                  c.xor        a3, a5
                  or           a2, a7, sp
                  c.or         a5, a4
                  rem          sp, t6, tp
                  add          s3, s11, s3
                  divu         t5, a7, tp
                  slli         sp, t3, 13
                  andi         t6, a4, 389
                  sltu         s9, a4, a0
                  sltu         s9, a4, a0
                  sll          t2, s7, s3
                  sltu         s9, a4, a0
                  mulh         zero, a3, gp
                  c.slli       s4, 24
                  srl          s5, s7, sp
                  srl          s5, s7, sp
                  div          t1, s3, a1
                  c.xor        a3, a5
                  srl          s5, s7, sp
                  sltu         s9, a4, a0
                  mulhu        s3, s2, s7
                  divu         t5, a7, tp
                  add          s3, s11, s3
                  auipc        t1, 195699
                  srli         s0, s11, 8
                  c.and        a5, a4
                  lui          sp, 776755
                  sltu         s9, a4, a0
                  mulh         zero, a3, gp
                  mulhsu       s0, a1, t4
                  add          s3, s11, s3
                  sll          t2, s7, s3
                  and          s7, a5, a7
                  rem          sp, t6, tp
                  xor          s11, s5, a1
                  c.mv         a2, a2
                  c.or         a5, a4
                  sra          sp, a2, sp
                  addi         a1, t1, -1592
                  c.and        a5, a4
                  c.xor        a3, a5
                  c.addi       a2, -1
                  srli         s0, s11, 8
                  mulhu        s3, s2, s7
                  c.addi16sp   sp, -16
                  sll          t2, s7, s3
                  add          s3, s11, s3
                  div          t1, s3, a1
                  mulhu        s3, s2, s7
                  c.srli       a2, 1
                  slti         a0, a4, -1207
                  nop
                  c.add        sp, s8
                  c.xor        a3, a5
                  slt          t2, a1, s5
                  srl          s5, s7, sp
                  xor          s11, s5, a1
                  c.addi       a2, -1
                  divu         t5, a7, tp
                  sll          t2, s7, s3
                  c.lui        s9, 19
                  addi         a1, t1, -1592
                  div          t1, s3, a1
                  xor          s11, s5, a1
                  auipc        t1, 195699
                  sltu         s9, a4, a0
                  srai         gp, ra, 29
                  and          s7, a5, a7
                  rem          sp, t6, tp
                  c.addi4spn   a5, sp, 464
                  slt          t2, a1, s5
                  mulh         zero, a3, gp
                  sll          t2, s7, s3
                  mulh         zero, a3, gp
                  c.slli       s4, 24
                  c.mv         a2, a2
                  c.nop
                  mulhu        s3, s2, s7
                  c.or         a5, a4
                  rem          sp, t6, tp
                  addi         a1, t1, -1592
                  or           a2, a7, sp
                  mulh         zero, a3, gp
                  srli         s0, s11, 8
                  mul          a1, s1, t5
                  and          s7, a5, a7
                  slli         sp, t3, 13
                  c.mv         a2, a2
                  xor          s11, s5, a1
                  xori         a3, s4, 1809
                  nop
                  mul          a1, s1, t5
                  c.li         a0, 14
                  c.addi4spn   a5, sp, 464
                  sltu         s9, a4, a0
                  mulhu        s3, s2, s7
                  remu         zero, s2, zero
                  sra          sp, a2, sp
                  srli         s0, s11, 8
                  nop
                  xor          s11, s5, a1
                  mul          a1, s1, t5
                  c.li         a0, 14
                  mul          a1, s1, t5
                  srli         s0, s11, 8
                  xor          s11, s5, a1
                  slli         sp, t3, 13
                  c.or         a5, a4
                  remu         zero, s2, zero
                  c.srli       a2, 1
                  c.andi       a4, 28
                  c.addi16sp   sp, -16
                  remu         zero, s2, zero
                  c.andi       a4, 28
                  slt          t2, a1, s5
                  c.nop
                  mulhsu       s0, a1, t4
                  sub          gp, s1, t2
                  c.or         a5, a4
                  sub          gp, s1, t2
                  mulhu        s3, s2, s7
                  mulh         zero, a3, gp
                  slli         sp, t3, 13
                  srl          s5, s7, sp
                  mulhu        s3, s2, s7
                  sltiu        t6, s10, -519
                  c.or         a5, a4
                  c.slli       s4, 24
                  add          s3, s11, s3
                  c.slli       s4, 24
                  sra          sp, a2, sp
                  mul          a1, s1, t5
                  c.addi16sp   sp, -16
                  c.addi16sp   sp, -16
                  sra          sp, a2, sp
                  slti         a0, a4, -1207
                  and          s7, a5, a7
                  xori         a3, s4, 1809
                  lui          sp, 776755
                  sltiu        t6, s10, -519
                  ori          a6, t5, 1716
                  srai         gp, ra, 29
                  c.addi       a2, -1
                  srli         s0, s11, 8
                  div          t1, s3, a1
                  c.addi4spn   a5, sp, 464
                  c.srli       a2, 1
                  c.nop
                  slti         a0, a4, -1207
                  addi         a1, t1, -1592
                  andi         t6, a4, 389
                  sra          sp, a2, sp
                  sra          sp, a2, sp
                  c.srli       a2, 1
                  ori          a6, t5, 1716
                  and          s7, a5, a7
                  c.sub        a5, a1
                  and          s7, a5, a7
                  xori         a3, s4, 1809
                  slt          t2, a1, s5
                  srai         gp, ra, 29
                  sltiu        t6, s10, -519
                  li           s10, 0xffffffff #start riscv_int_numeric_corner_stream_36
                  li           a1, 0x80000000
                  li           s8, 0xffffffff
                  li           t0, 0x80000000
                  li           t3, 0x0
                  li           a7, 0x80000000
                  li           s3, 0x2f171496
                  li           sp, 0x0
                  li           s7, 0x80000000
                  li           ra, 0xffffffff
                  lui          t0, 776755
                  sub          a1, t3, s8
                  remu         ra, t0, ra
                  rem          t0, s7, a7
                  mulhsu       s8, s3, ra
                  div          s3, a1, s7
                  addi         t3, s7, -1592
                  nop
                  remu         ra, t0, ra
                  rem          t0, s7, a7
                  mulhu        sp, t0, s8
                  rem          t0, s7, a7
                  lui          t0, 776755
                  mul          t3, t3, a1
                  mulhu        sp, t0, s8
                  rem          t0, s7, a7 #end riscv_int_numeric_corner_stream_36
                  xor          s11, s5, a1
                  c.add        sp, s8
                  xori         a3, s4, 1809
                  slti         a0, a4, -1207
                  divu         t5, a7, tp
                  xor          s11, s5, a1
                  c.addi4spn   a5, sp, 464
                  mulh         zero, a3, gp
                  c.addi16sp   sp, -16
                  mulhu        s3, s2, s7
                  andi         t6, a4, 389
                  srli         s0, s11, 8
                  srl          s5, s7, sp
                  srl          s5, s7, sp
                  addi         a1, t1, -1592
                  c.addi       a2, -1
                  srai         gp, ra, 29
                  c.addi       a2, -1
                  mulhu        s3, s2, s7
                  srl          s5, s7, sp
                  c.and        a5, a4
                  c.add        sp, s8
                  c.and        a5, a4
                  or           a2, a7, sp
                  or           a2, a7, sp
                  xor          s11, s5, a1
                  c.addi       a2, -1
                  c.nop
                  xor          s11, s5, a1
                  c.or         a5, a4
                  nop
                  ori          a6, t5, 1716
                  c.andi       a4, 28
                  addi         a1, t1, -1592
                  xor          s11, s5, a1
                  sra          sp, a2, sp
                  c.srai       a4, 2
                  remu         zero, s2, zero
                  slti         a0, a4, -1207
                  srai         gp, ra, 29
                  auipc        t1, 195699
                  xori         a3, s4, 1809
                  srl          s5, s7, sp
                  mulhu        s3, s2, s7
                  c.sub        a5, a1
                  sltu         s9, a4, a0
                  li           s7, 0x0 #start riscv_int_numeric_corner_stream_39
                  li           a0, 0x80000000
                  li           s6, 0xffffffff
                  li           t2, 0x4a23c60b
                  li           a7, 0xffffffff
                  li           s9, 0x80000000
                  li           s3, 0xffffffff
                  li           s8, 0x0
                  li           s10, 0x80000000
                  li           s0, 0x0
                  addi         s10, s7, -1592
                  remu         t2, a0, t2
                  addi         s10, s7, -1592
                  mulhsu       s8, s6, t2
                  sub          a7, s10, s8
                  mulhu        s0, a0, s8
                  lui          a0, 776755
                  nop
                  lui          a0, 776755
                  auipc        s6, 195699
                  rem          a0, s7, s3
                  mulhu        s0, a0, s8
                  mulhu        s0, a0, s8
                  add          s0, s0, a7
                  divu         s0, s0, s3
                  lui          a0, 776755
                  sub          a7, s10, s8
                  mul          s10, s10, a7
                  sub          a7, s10, s8
                  auipc        s6, 195699
                  add          s0, s0, a7
                  lui          a0, 776755 #end riscv_int_numeric_corner_stream_39
                  ori          a6, t5, 1716
                  divu         t5, a7, tp
                  c.andi       a4, 28
                  sll          t2, s7, s3
                  mulhsu       s0, a1, t4
                  mul          a1, s1, t5
                  mulhsu       s0, a1, t4
                  c.add        sp, s8
                  or           a2, a7, sp
                  c.lui        s9, 19
                  slli         sp, t3, 13
                  c.addi16sp   sp, -16
                  rem          sp, t6, tp
                  srli         s0, s11, 8
                  c.addi       a2, -1
                  c.li         a0, 14
                  divu         t5, a7, tp
                  or           a2, a7, sp
                  add          s3, s11, s3
                  c.li         a0, 14
                  rem          sp, t6, tp
                  srli         s0, s11, 8
                  sltu         s9, a4, a0
                  xori         a3, s4, 1809
                  lui          sp, 776755
                  sra          sp, a2, sp
                  c.addi       a2, -1
                  or           a2, a7, sp
                  div          t1, s3, a1
                  lui          sp, 776755
                  c.srli       a2, 1
                  srai         gp, ra, 29
                  srli         s0, s11, 8
                  slti         a0, a4, -1207
                  c.and        a5, a4
                  mulhsu       s0, a1, t4
                  nop
                  sltiu        t6, s10, -519
                  c.and        a5, a4
                  c.li         a0, 14
                  c.xor        a3, a5
                  c.and        a5, a4
                  c.mv         a2, a2
                  srli         s0, s11, 8
                  c.addi       a2, -1
                  div          t1, s3, a1
                  xor          s11, s5, a1
                  c.add        sp, s8
                  add          s3, s11, s3
                  sra          sp, a2, sp
                  slti         a0, a4, -1207
                  add          s3, s11, s3
                  mulhsu       s0, a1, t4
                  or           a2, a7, sp
                  c.or         a5, a4
                  c.addi16sp   sp, -16
                  auipc        t1, 195699
                  srli         s0, s11, 8
                  and          s7, a5, a7
                  c.slli       s4, 24
                  slt          t2, a1, s5
                  xori         a3, s4, 1809
                  c.sub        a5, a1
                  c.srli       a2, 1
                  c.xor        a3, a5
                  srai         gp, ra, 29
                  sltiu        t6, s10, -519
                  c.srli       a2, 1
                  xor          s11, s5, a1
                  xori         a3, s4, 1809
                  auipc        t1, 195699
                  div          t1, s3, a1
                  ori          a6, t5, 1716
                  c.xor        a3, a5
                  or           a2, a7, sp
                  srai         gp, ra, 29
                  srai         gp, ra, 29
                  srai         gp, ra, 29
                  auipc        t1, 195699
                  divu         t5, a7, tp
                  c.li         a0, 14
                  mulhu        s3, s2, s7
                  ori          a6, t5, 1716
                  mulhu        s3, s2, s7
                  srl          s5, s7, sp
                  c.nop
                  xor          s11, s5, a1
                  andi         t6, a4, 389
                  addi         a1, t1, -1592
                  c.srai       a4, 2
                  and          s7, a5, a7
                  srai         gp, ra, 29
                  c.sub        a5, a1
                  mulhsu       s0, a1, t4
                  srl          s5, s7, sp
                  c.or         a5, a4
                  srl          s5, s7, sp
                  xori         a3, s4, 1809
                  c.add        sp, s8
                  add          s3, s11, s3
                  rem          sp, t6, tp
                  lui          sp, 776755
                  or           a2, a7, sp
                  c.add        sp, s8
                  mulh         zero, a3, gp
                  c.addi16sp   sp, -16
                  sub          gp, s1, t2
                  slt          t2, a1, s5
                  addi         a1, t1, -1592
                  remu         zero, s2, zero
                  srli         s0, s11, 8
                  addi         a1, t1, -1592
                  slti         a0, a4, -1207
                  c.and        a5, a4
                  srli         s0, s11, 8
                  mulhsu       s0, a1, t4
                  c.lui        s9, 19
                  c.lui        s9, 19
                  nop
                  c.srai       a4, 2
                  div          t1, s3, a1
                  srli         s0, s11, 8
                  c.srli       a2, 1
                  mulhu        s3, s2, s7
                  mulhsu       s0, a1, t4
                  c.li         a0, 14
                  and          s7, a5, a7
                  c.li         a0, 14
                  lui          sp, 776755
                  c.li         a0, 14
                  c.mv         a2, a2
                  add          s3, s11, s3
                  xori         a3, s4, 1809
                  c.xor        a3, a5
                  c.srli       a2, 1
                  c.addi16sp   sp, -16
                  add          s3, s11, s3
                  c.srli       a2, 1
                  divu         t5, a7, tp
                  rem          sp, t6, tp
                  mulh         zero, a3, gp
                  sll          t2, s7, s3
                  mulhsu       s0, a1, t4
                  srl          s5, s7, sp
                  c.nop
                  c.nop
                  c.mv         a2, a2
                  sltiu        t6, s10, -519
                  c.nop
                  c.andi       a4, 28
                  andi         t6, a4, 389
                  srai         gp, ra, 29
                  c.xor        a3, a5
                  c.slli       s4, 24
                  and          s7, a5, a7
                  c.xor        a3, a5
                  c.slli       s4, 24
                  c.srai       a4, 2
                  divu         t5, a7, tp
                  xori         a3, s4, 1809
                  lui          sp, 776755
                  c.lui        s9, 19
                  sub          gp, s1, t2
                  mulh         zero, a3, gp
                  sltu         s9, a4, a0
                  c.add        sp, s8
                  c.lui        s9, 19
                  c.srai       a4, 2
                  srai         gp, ra, 29
                  sub          gp, s1, t2
                  xor          s11, s5, a1
                  c.slli       s4, 24
                  c.andi       a4, 28
                  ori          a6, t5, 1716
                  c.and        a5, a4
                  lui          sp, 776755
                  mulhu        s3, s2, s7
                  c.addi       a2, -1
                  sltu         s9, a4, a0
                  srai         gp, ra, 29
                  c.and        a5, a4
                  c.addi4spn   a5, sp, 464
                  lui          sp, 776755
                  slti         a0, a4, -1207
                  slli         sp, t3, 13
                  sll          t2, s7, s3
                  xor          s11, s5, a1
                  addi         a1, t1, -1592
                  c.or         a5, a4
                  rem          sp, t6, tp
                  slt          t2, a1, s5
                  mulh         zero, a3, gp
                  lui          sp, 776755
                  srli         s0, s11, 8
                  c.lui        s9, 19
                  divu         t5, a7, tp
                  c.andi       a4, 28
                  srl          s5, s7, sp
                  c.addi       a2, -1
                  c.addi16sp   sp, -16
                  mulh         zero, a3, gp
                  xor          s11, s5, a1
                  c.sub        a5, a1
                  c.srli       a2, 1
                  addi         a1, t1, -1592
                  sra          sp, a2, sp
                  mulhu        s3, s2, s7
                  sltu         s9, a4, a0
                  c.xor        a3, a5
                  mul          a1, s1, t5
                  ori          a6, t5, 1716
                  c.mv         a2, a2
                  sra          sp, a2, sp
                  rem          sp, t6, tp
                  sll          t2, s7, s3
                  srli         s0, s11, 8
                  c.slli       s4, 24
                  slt          t2, a1, s5
                  auipc        t1, 195699
                  xor          s11, s5, a1
                  c.slli       s4, 24
                  sltu         s9, a4, a0
                  c.nop
                  c.or         a5, a4
                  mul          a1, s1, t5
                  mulh         zero, a3, gp
                  and          s7, a5, a7
                  slti         a0, a4, -1207
                  c.nop
                  and          s7, a5, a7
                  div          t1, s3, a1
                  add          s3, s11, s3
                  c.li         a0, 14
                  addi         a1, t1, -1592
                  c.slli       s4, 24
                  c.lui        s9, 19
                  nop
                  xori         a3, s4, 1809
                  sll          t2, s7, s3
                  c.addi       a2, -1
                  c.slli       s4, 24
                  sltu         s9, a4, a0
                  c.addi4spn   a5, sp, 464
                  slt          t2, a1, s5
                  or           a2, a7, sp
                  mulhu        s3, s2, s7
                  c.srai       a4, 2
                  mulhu        s3, s2, s7
                  c.li         a0, 14
                  c.srai       a4, 2
                  slli         sp, t3, 13
                  c.mv         a2, a2
                  c.addi       a2, -1
                  slt          t2, a1, s5
                  c.add        sp, s8
                  auipc        t1, 195699
                  divu         t5, a7, tp
                  sltu         s9, a4, a0
                  c.sub        a5, a1
                  add          s3, s11, s3
                  c.slli       s4, 24
                  remu         zero, s2, zero
                  ori          a6, t5, 1716
                  ori          a6, t5, 1716
                  nop
                  c.xor        a3, a5
                  sra          sp, a2, sp
                  or           a2, a7, sp
                  c.and        a5, a4
                  c.or         a5, a4
                  addi         a1, t1, -1592
                  add          s3, s11, s3
                  rem          sp, t6, tp
                  srl          s5, s7, sp
                  sll          t2, s7, s3
                  sltu         s9, a4, a0
                  c.andi       a4, 28
                  or           a2, a7, sp
                  mulhu        s3, s2, s7
                  c.and        a5, a4
                  sltu         s9, a4, a0
                  divu         t5, a7, tp
                  rem          sp, t6, tp
                  mulhu        s3, s2, s7
                  divu         t5, a7, tp
                  ori          a6, t5, 1716
                  c.or         a5, a4
                  auipc        t1, 195699
                  c.srli       a2, 1
                  mulhu        s3, s2, s7
                  addi         a1, t1, -1592
                  nop
                  lui          sp, 776755
                  c.andi       a4, 28
                  xori         a3, s4, 1809
                  c.li         a0, 14
                  xori         a3, s4, 1809
                  andi         t6, a4, 389
                  c.mv         a2, a2
                  c.slli       s4, 24
                  c.srai       a4, 2
                  sll          t2, s7, s3
                  c.andi       a4, 28
                  c.addi16sp   sp, -16
                  addi         a1, t1, -1592
                  ori          a6, t5, 1716
                  remu         zero, s2, zero
                  ori          a6, t5, 1716
                  nop
                  add          s3, s11, s3
                  sra          sp, a2, sp
                  and          s7, a5, a7
                  sub          gp, s1, t2
                  divu         t5, a7, tp
                  addi         a1, t1, -1592
                  divu         t5, a7, tp
                  slli         sp, t3, 13
                  auipc        t1, 195699
                  c.add        sp, s8
                  divu         t5, a7, tp
                  sra          sp, a2, sp
                  c.addi4spn   a5, sp, 464
                  xor          s11, s5, a1
                  xor          s11, s5, a1
                  c.srli       a2, 1
                  srli         s0, s11, 8
                  ori          a6, t5, 1716
                  c.srli       a2, 1
                  mulhu        s3, s2, s7
                  c.sub        a5, a1
                  srli         s0, s11, 8
                  and          s7, a5, a7
                  c.addi4spn   a5, sp, 464
                  mulhu        s3, s2, s7
                  c.andi       a4, 28
                  srl          s5, s7, sp
                  c.slli       s4, 24
                  slli         sp, t3, 13
                  sll          t2, s7, s3
                  sra          sp, a2, sp
                  mulh         zero, a3, gp
                  rem          sp, t6, tp
                  sltu         s9, a4, a0
                  sll          t2, s7, s3
                  srli         s0, s11, 8
                  or           a2, a7, sp
                  div          t1, s3, a1
                  slt          t2, a1, s5
                  c.add        sp, s8
                  sll          t2, s7, s3
                  divu         t5, a7, tp
                  and          s7, a5, a7
                  c.addi16sp   sp, -16
                  add          s3, s11, s3
                  c.and        a5, a4
                  c.sub        a5, a1
                  c.andi       a4, 28
                  divu         t5, a7, tp
                  srai         gp, ra, 29
                  c.and        a5, a4
                  c.xor        a3, a5
                  srai         gp, ra, 29
                  slli         sp, t3, 13
                  sll          t2, s7, s3
                  mulhu        s3, s2, s7
                  c.sub        a5, a1
                  c.xor        a3, a5
                  c.srai       a4, 2
                  srli         s0, s11, 8
                  andi         t6, a4, 389
                  c.nop
                  rem          sp, t6, tp
                  lui          sp, 776755
                  addi         a1, t1, -1592
                  add          s3, s11, s3
                  rem          sp, t6, tp
                  divu         t5, a7, tp
                  c.addi       a2, -1
                  c.lui        s9, 19
                  mulhsu       s0, a1, t4
                  sll          t2, s7, s3
                  addi         a1, t1, -1592
                  mul          a1, s1, t5
                  xor          s11, s5, a1
                  slti         a0, a4, -1207
                  mulhu        s3, s2, s7
                  rem          sp, t6, tp
                  remu         zero, s2, zero
                  c.xor        a3, a5
                  srai         gp, ra, 29
                  c.addi4spn   a5, sp, 464
                  and          s7, a5, a7
                  xor          s11, s5, a1
                  c.srli       a2, 1
                  c.nop
                  c.mv         a2, a2
                  auipc        t1, 195699
                  slli         sp, t3, 13
                  c.lui        s9, 19
                  remu         zero, s2, zero
                  auipc        t1, 195699
                  c.and        a5, a4
                  rem          sp, t6, tp
                  slt          t2, a1, s5
                  divu         t5, a7, tp
                  c.nop
                  sltiu        t6, s10, -519
                  mulhsu       s0, a1, t4
                  c.addi4spn   a5, sp, 464
                  c.slli       s4, 24
                  xor          s11, s5, a1
                  c.andi       a4, 28
                  xor          s11, s5, a1
                  c.add        sp, s8
                  c.lui        s9, 19
                  remu         zero, s2, zero
                  sub          gp, s1, t2
                  div          t1, s3, a1
                  addi         a1, t1, -1592
                  c.nop
                  add          s3, s11, s3
                  c.add        sp, s8
                  auipc        t1, 195699
                  c.xor        a3, a5
                  c.srai       a4, 2
                  c.addi       a2, -1
                  addi         a1, t1, -1592
                  sub          gp, s1, t2
                  divu         t5, a7, tp
                  lui          sp, 776755
                  rem          sp, t6, tp
                  c.add        sp, s8
                  div          t1, s3, a1
                  mulhsu       s0, a1, t4
                  nop
                  or           a2, a7, sp
                  xor          s11, s5, a1
                  c.srli       a2, 1
                  auipc        t1, 195699
                  c.add        sp, s8
                  sll          t2, s7, s3
                  mulhsu       s0, a1, t4
                  c.sub        a5, a1
                  ori          a6, t5, 1716
                  c.lui        s9, 19
                  sltu         s9, a4, a0
                  slli         sp, t3, 13
                  c.li         a0, 14
                  c.mv         a2, a2
                  mulhsu       s0, a1, t4
                  or           a2, a7, sp
                  rem          sp, t6, tp
                  mul          a1, s1, t5
                  c.xor        a3, a5
                  srai         gp, ra, 29
                  c.addi4spn   a5, sp, 464
                  c.slli       s4, 24
                  sll          t2, s7, s3
                  mulhsu       s0, a1, t4
                  add          s3, s11, s3
                  nop
                  sra          sp, a2, sp
                  slt          t2, a1, s5
                  c.addi       a2, -1
                  c.addi       a2, -1
                  c.andi       a4, 28
                  and          s7, a5, a7
                  c.and        a5, a4
                  c.srli       a2, 1
                  c.li         a0, 14
                  c.and        a5, a4
                  c.andi       a4, 28
                  c.slli       s4, 24
                  c.and        a5, a4
                  c.srai       a4, 2
                  slli         sp, t3, 13
                  auipc        t1, 195699
                  auipc        t1, 195699
                  srli         s0, s11, 8
                  c.slli       s4, 24
                  c.sub        a5, a1
                  c.add        sp, s8
                  mulh         zero, a3, gp
                  and          s7, a5, a7
                  xori         a3, s4, 1809
                  mul          a1, s1, t5
                  c.or         a5, a4
                  and          s7, a5, a7
                  and          s7, a5, a7
                  sltu         s9, a4, a0
                  c.lui        s9, 19
                  slli         sp, t3, 13
                  sra          sp, a2, sp
                  addi         a1, t1, -1592
                  c.srai       a4, 2
                  and          s7, a5, a7
                  div          t1, s3, a1
                  c.lui        s9, 19
                  c.li         a0, 14
                  andi         t6, a4, 389
                  mulh         zero, a3, gp
                  mulhsu       s0, a1, t4
                  slli         sp, t3, 13
                  slli         sp, t3, 13
                  c.and        a5, a4
                  addi         a1, t1, -1592
                  c.xor        a3, a5
                  mulhu        s3, s2, s7
                  srai         gp, ra, 29
                  andi         t6, a4, 389
                  xori         a3, s4, 1809
                  ori          a6, t5, 1716
                  remu         zero, s2, zero
                  srl          s5, s7, sp
                  slt          t2, a1, s5
                  xori         a3, s4, 1809
                  slli         sp, t3, 13
                  or           a2, a7, sp
                  rem          sp, t6, tp
                  c.lui        s9, 19
                  c.or         a5, a4
                  srl          s5, s7, sp
                  mulhu        s3, s2, s7
                  xori         a3, s4, 1809
                  srai         gp, ra, 29
                  xori         a3, s4, 1809
                  c.and        a5, a4
                  sll          t2, s7, s3
                  xor          s11, s5, a1
                  srai         gp, ra, 29
                  and          s7, a5, a7
                  xori         a3, s4, 1809
                  c.mv         a2, a2
                  c.slli       s4, 24
                  divu         t5, a7, tp
                  andi         t6, a4, 389
                  srl          s5, s7, sp
                  srli         s0, s11, 8
                  c.sub        a5, a1
                  c.addi       a2, -1
                  c.srai       a4, 2
                  sltiu        t6, s10, -519
                  mulhsu       s0, a1, t4
                  sra          sp, a2, sp
                  c.and        a5, a4
                  c.slli       s4, 24
                  c.and        a5, a4
                  c.srai       a4, 2
                  div          t1, s3, a1
                  sll          t2, s7, s3
                  srai         gp, ra, 29
                  srli         s0, s11, 8
                  sub          gp, s1, t2
                  c.addi       a2, -1
                  div          t1, s3, a1
                  slti         a0, a4, -1207
                  c.addi       a2, -1
                  xori         a3, s4, 1809
                  mulhsu       s0, a1, t4
                  lui          sp, 776755
                  divu         t5, a7, tp
                  c.mv         a2, a2
                  remu         zero, s2, zero
                  mulhsu       s0, a1, t4
                  rem          sp, t6, tp
                  c.add        sp, s8
                  c.add        sp, s8
                  div          t1, s3, a1
                  c.addi       a2, -1
                  slli         sp, t3, 13
                  slt          t2, a1, s5
                  or           a2, a7, sp
                  c.srli       a2, 1
                  c.addi4spn   a5, sp, 464
                  or           a2, a7, sp
                  lui          sp, 776755
                  c.srli       a2, 1
                  c.addi16sp   sp, -16
                  sra          sp, a2, sp
                  c.mv         a2, a2
                  xori         a3, s4, 1809
                  div          t1, s3, a1
                  ori          a6, t5, 1716
                  andi         t6, a4, 389
                  c.xor        a3, a5
                  srl          s5, s7, sp
                  c.slli       s4, 24
                  c.and        a5, a4
                  xor          s11, s5, a1
                  c.or         a5, a4
                  addi         a1, t1, -1592
                  sub          gp, s1, t2
                  or           a2, a7, sp
                  c.or         a5, a4
                  mulhsu       s0, a1, t4
                  srli         s0, s11, 8
                  ori          a6, t5, 1716
                  addi         a1, t1, -1592
                  c.add        sp, s8
                  or           a2, a7, sp
                  c.addi4spn   a5, sp, 464
                  ori          a6, t5, 1716
                  mul          a1, s1, t5
                  c.sub        a5, a1
                  c.and        a5, a4
                  and          s7, a5, a7
                  c.addi4spn   a5, sp, 464
                  slli         sp, t3, 13
                  c.sub        a5, a1
                  sra          sp, a2, sp
                  rem          sp, t6, tp
                  sll          t2, s7, s3
                  and          s7, a5, a7
                  mul          a1, s1, t5
                  add          s3, s11, s3
                  c.or         a5, a4
                  nop
                  andi         t6, a4, 389
                  ori          a6, t5, 1716
                  c.nop
                  c.mv         a2, a2
                  c.addi4spn   a5, sp, 464
                  srli         s0, s11, 8
                  c.mv         a2, a2
                  xor          s11, s5, a1
                  c.li         a0, 14
                  c.add        sp, s8
                  slli         sp, t3, 13
                  slt          t2, a1, s5
                  xor          s11, s5, a1
                  c.addi4spn   a5, sp, 464
                  and          s7, a5, a7
                  c.or         a5, a4
                  nop
                  c.xor        a3, a5
                  div          t1, s3, a1
                  c.addi4spn   a5, sp, 464
                  c.and        a5, a4
                  andi         t6, a4, 389
                  sll          t2, s7, s3
                  rem          sp, t6, tp
                  c.addi       a2, -1
                  srli         s0, s11, 8
                  slti         a0, a4, -1207
                  srai         gp, ra, 29
                  sub          gp, s1, t2
                  xor          s11, s5, a1
                  auipc        t1, 195699
                  sub          gp, s1, t2
                  mul          a1, s1, t5
                  sll          t2, s7, s3
                  c.xor        a3, a5
                  mul          a1, s1, t5
                  xori         a3, s4, 1809
                  add          s3, s11, s3
                  div          t1, s3, a1
                  xor          s11, s5, a1
                  c.srli       a2, 1
                  c.addi       a2, -1
                  c.addi16sp   sp, -16
                  sub          gp, s1, t2
                  mulh         zero, a3, gp
                  c.srai       a4, 2
                  remu         zero, s2, zero
                  c.mv         a2, a2
                  c.srai       a4, 2
                  c.nop
                  srai         gp, ra, 29
                  c.xor        a3, a5
                  c.add        sp, s8
                  c.andi       a4, 28
                  rem          sp, t6, tp
                  xori         a3, s4, 1809
                  c.nop
                  nop
                  and          s7, a5, a7
                  c.slli       s4, 24
                  or           a2, a7, sp
                  rem          sp, t6, tp
                  sltiu        t6, s10, -519
                  add          s3, s11, s3
                  slt          t2, a1, s5
                  c.andi       a4, 28
                  c.nop
                  xori         a3, s4, 1809
                  rem          sp, t6, tp
                  auipc        t1, 195699
                  c.lui        s9, 19
                  c.srai       a4, 2
                  divu         t5, a7, tp
                  c.andi       a4, 28
                  c.li         a0, 14
                  srai         gp, ra, 29
                  divu         t5, a7, tp
                  srli         s0, s11, 8
                  c.add        sp, s8
                  slt          t2, a1, s5
                  remu         zero, s2, zero
                  c.mv         a2, a2
                  c.sub        a5, a1
                  sub          gp, s1, t2
                  c.addi16sp   sp, -16
                  srli         s0, s11, 8
                  rem          sp, t6, tp
                  lui          sp, 776755
                  remu         zero, s2, zero
                  slli         sp, t3, 13
                  srai         gp, ra, 29
                  and          s7, a5, a7
                  srai         gp, ra, 29
                  c.sub        a5, a1
                  sltu         s9, a4, a0
                  c.andi       a4, 28
                  c.add        sp, s8
                  mul          a1, s1, t5
                  sll          t2, s7, s3
                  c.slli       s4, 24
                  c.srli       a2, 1
                  c.lui        s9, 19
                  c.xor        a3, a5
                  rem          sp, t6, tp
                  xor          s11, s5, a1
                  c.nop
                  c.nop
                  c.addi4spn   a5, sp, 464
                  sltu         s9, a4, a0
                  divu         t5, a7, tp
                  sltiu        t6, s10, -519
                  c.xor        a3, a5
                  mulh         zero, a3, gp
                  mulhsu       s0, a1, t4
                  srai         gp, ra, 29
                  sub          gp, s1, t2
                  ori          a6, t5, 1716
                  c.andi       a4, 28
                  or           a2, a7, sp
                  c.addi       a2, -1
                  or           a2, a7, sp
                  nop
                  c.or         a5, a4
                  sll          t2, s7, s3
                  slti         a0, a4, -1207
                  xor          s11, s5, a1
                  c.add        sp, s8
                  and          s7, a5, a7
                  sltiu        t6, s10, -519
                  c.addi       a2, -1
                  andi         t6, a4, 389
                  and          s7, a5, a7
                  mulhu        s3, s2, s7
                  remu         zero, s2, zero
                  srl          s5, s7, sp
                  mul          a1, s1, t5
                  sub          gp, s1, t2
                  sltiu        t6, s10, -519
                  srai         gp, ra, 29
                  and          s7, a5, a7
                  and          s7, a5, a7
                  sll          t2, s7, s3
                  c.addi       a2, -1
                  srli         s0, s11, 8
                  c.xor        a3, a5
                  c.nop
                  add          s3, s11, s3
                  sltiu        t6, s10, -519
                  add          s3, s11, s3
                  or           a2, a7, sp
                  auipc        t1, 195699
                  and          s7, a5, a7
                  sub          gp, s1, t2
                  c.srai       a4, 2
                  div          t1, s3, a1
                  c.sub        a5, a1
                  ori          a6, t5, 1716
                  slti         a0, a4, -1207
                  mulh         zero, a3, gp
                  c.srli       a2, 1
                  c.slli       s4, 24
                  mulhsu       s0, a1, t4
                  xori         a3, s4, 1809
                  c.add        sp, s8
                  mulhu        s3, s2, s7
                  sltiu        t6, s10, -519
                  slt          t2, a1, s5
                  srli         s0, s11, 8
                  lui          sp, 776755
                  andi         t6, a4, 389
                  c.srli       a2, 1
                  ori          a6, t5, 1716
                  div          t1, s3, a1
                  sra          sp, a2, sp
                  c.addi16sp   sp, -16
                  remu         zero, s2, zero
                  lui          sp, 776755
                  mulh         zero, a3, gp
                  sll          t2, s7, s3
                  c.mv         a2, a2
                  auipc        t1, 195699
                  c.xor        a3, a5
                  auipc        t1, 195699
                  c.addi16sp   sp, -16
                  c.mv         a2, a2
                  addi         a1, t1, -1592
                  auipc        t1, 195699
                  c.addi4spn   a5, sp, 464
                  and          s7, a5, a7
                  c.slli       s4, 24
                  mul          a1, s1, t5
                  c.li         a0, 14
                  c.sub        a5, a1
                  slli         sp, t3, 13
                  nop
                  mulhsu       s0, a1, t4
                  addi         a1, t1, -1592
                  mul          a1, s1, t5
                  xor          s11, s5, a1
                  c.and        a5, a4
                  mulhu        s3, s2, s7
                  slli         sp, t3, 13
                  add          s3, s11, s3
                  c.mv         a2, a2
                  c.add        sp, s8
                  c.xor        a3, a5
                  srli         s0, s11, 8
                  c.lui        s9, 19
                  c.mv         a2, a2
                  c.xor        a3, a5
                  c.and        a5, a4
                  divu         t5, a7, tp
                  slti         a0, a4, -1207
                  or           a2, a7, sp
                  c.and        a5, a4
                  c.xor        a3, a5
                  addi         a1, t1, -1592
                  srli         s0, s11, 8
                  sra          sp, a2, sp
                  remu         zero, s2, zero
                  c.srai       a4, 2
                  auipc        t1, 195699
                  slti         a0, a4, -1207
                  c.srli       a2, 1
                  srai         gp, ra, 29
                  c.andi       a4, 28
                  c.or         a5, a4
                  and          s7, a5, a7
                  ori          a6, t5, 1716
                  ori          a6, t5, 1716
                  andi         t6, a4, 389
                  c.srai       a4, 2
                  andi         t6, a4, 389
                  or           a2, a7, sp
                  c.srli       a2, 1
                  c.addi16sp   sp, -16
                  srai         gp, ra, 29
                  divu         t5, a7, tp
                  srl          s5, s7, sp
                  srli         s0, s11, 8
                  addi         a1, t1, -1592
                  xori         a3, s4, 1809
                  sltu         s9, a4, a0
                  nop
                  slti         a0, a4, -1207
                  addi         a1, t1, -1592
                  c.sub        a5, a1
                  andi         t6, a4, 389
                  andi         t6, a4, 389
                  slt          t2, a1, s5
                  c.srai       a4, 2
                  addi         a1, t1, -1592
                  c.srai       a4, 2
                  srai         gp, ra, 29
                  lui          sp, 776755
                  srli         s0, s11, 8
                  c.xor        a3, a5
                  divu         t5, a7, tp
                  auipc        t1, 195699
                  lui          sp, 776755
                  srl          s5, s7, sp
                  xori         a3, s4, 1809
                  slt          t2, a1, s5
                  c.li         a0, 14
                  slti         a0, a4, -1207
                  srai         gp, ra, 29
                  c.srai       a4, 2
                  sltu         s9, a4, a0
                  rem          sp, t6, tp
                  and          s7, a5, a7
                  srli         s0, s11, 8
                  c.andi       a4, 28
                  c.lui        s9, 19
                  mulh         zero, a3, gp
                  c.add        sp, s8
                  and          s7, a5, a7
                  nop
                  c.and        a5, a4
                  c.addi       a2, -1
                  sltu         s9, a4, a0
                  srai         gp, ra, 29
                  ori          a6, t5, 1716
                  lui          sp, 776755
                  mulhsu       s0, a1, t4
                  srl          s5, s7, sp
                  c.lui        s9, 19
                  sltiu        t6, s10, -519
                  add          s3, s11, s3
                  remu         zero, s2, zero
                  c.srli       a2, 1
                  or           a2, a7, sp
                  lui          sp, 776755
                  lui          sp, 776755
                  sll          t2, s7, s3
                  c.or         a5, a4
                  c.and        a5, a4
                  and          s7, a5, a7
                  mul          a1, s1, t5
                  lui          sp, 776755
                  sra          sp, a2, sp
                  sltiu        t6, s10, -519
                  c.andi       a4, 28
                  c.mv         a2, a2
                  c.slli       s4, 24
                  lui          sp, 776755
                  andi         t6, a4, 389
                  mulhsu       s0, a1, t4
                  c.xor        a3, a5
                  srai         gp, ra, 29
                  sltu         s9, a4, a0
                  c.or         a5, a4
                  nop
                  mulh         zero, a3, gp
                  c.addi16sp   sp, -16
                  add          s3, s11, s3
                  c.addi16sp   sp, -16
                  c.li         a0, 14
                  lui          sp, 776755
                  xor          s11, s5, a1
                  mulhsu       s0, a1, t4
                  mulh         zero, a3, gp
                  c.srai       a4, 2
                  mul          a1, s1, t5
                  c.slli       s4, 24
                  mulhu        s3, s2, s7
                  sltu         s9, a4, a0
                  c.xor        a3, a5
                  mul          a1, s1, t5
                  c.addi4spn   a5, sp, 464
                  addi         a1, t1, -1592
                  mul          a1, s1, t5
                  add          s3, s11, s3
                  mul          a1, s1, t5
                  srai         gp, ra, 29
                  add          s3, s11, s3
                  srli         s0, s11, 8
                  mulhu        s3, s2, s7
                  c.li         a0, 14
                  c.mv         a2, a2
                  c.sub        a5, a1
                  c.add        sp, s8
                  ori          a6, t5, 1716
                  c.sub        a5, a1
                  c.srli       a2, 1
                  sll          t2, s7, s3
                  c.slli       s4, 24
                  andi         t6, a4, 389
                  auipc        t1, 195699
                  divu         t5, a7, tp
                  divu         t5, a7, tp
                  c.addi16sp   sp, -16
                  c.mv         a2, a2
                  c.lui        s9, 19
                  c.srai       a4, 2
                  c.or         a5, a4
                  slli         sp, t3, 13
                  andi         t6, a4, 389
                  mulhu        s3, s2, s7
                  c.andi       a4, 28
                  mulhu        s3, s2, s7
                  slli         sp, t3, 13
                  sub          gp, s1, t2
                  mulh         zero, a3, gp
                  c.srai       a4, 2
                  srl          s5, s7, sp
                  mul          a1, s1, t5
                  c.addi       a2, -1
                  slt          t2, a1, s5
                  and          s7, a5, a7
                  srl          s5, s7, sp
                  divu         t5, a7, tp
                  sltiu        t6, s10, -519
                  add          s3, s11, s3
                  sltu         s9, a4, a0
                  remu         zero, s2, zero
                  add          s3, s11, s3
                  mulhu        s3, s2, s7
                  xori         a3, s4, 1809
                  nop
                  srl          s5, s7, sp
                  mul          a1, s1, t5
                  c.xor        a3, a5
                  c.lui        s9, 19
                  c.xor        a3, a5
                  div          t1, s3, a1
                  remu         zero, s2, zero
                  remu         zero, s2, zero
                  and          s7, a5, a7
                  sltu         s9, a4, a0
                  c.addi       a2, -1
                  c.srli       a2, 1
                  c.addi4spn   a5, sp, 464
                  c.mv         a2, a2
                  c.add        sp, s8
                  xor          s11, s5, a1
                  c.lui        s9, 19
                  c.and        a5, a4
                  xor          s11, s5, a1
                  c.nop
                  srai         gp, ra, 29
                  or           a2, a7, sp
                  ori          a6, t5, 1716
                  ori          a6, t5, 1716
                  c.slli       s4, 24
                  c.addi       a2, -1
                  xori         a3, s4, 1809
                  c.sub        a5, a1
                  sltiu        t6, s10, -519
                  nop
                  c.lui        s9, 19
                  rem          sp, t6, tp
                  auipc        t1, 195699
                  slt          t2, a1, s5
                  add          s3, s11, s3
                  c.nop
                  lui          sp, 776755
                  c.sub        a5, a1
                  c.nop
                  sra          sp, a2, sp
                  c.addi16sp   sp, -16
                  c.srli       a2, 1
                  c.mv         a2, a2
                  div          t1, s3, a1
                  c.nop
                  srli         s0, s11, 8
                  c.addi       a2, -1
                  and          s7, a5, a7
                  sub          gp, s1, t2
                  andi         t6, a4, 389
                  rem          sp, t6, tp
                  slt          t2, a1, s5
                  c.li         a0, 14
                  c.and        a5, a4
                  c.srli       a2, 1
                  nop
                  mulhsu       s0, a1, t4
                  c.andi       a4, 28
                  c.srli       a2, 1
                  auipc        t1, 195699
                  c.srai       a4, 2
                  c.li         a0, 14
                  srli         s0, s11, 8
                  c.lui        s9, 19
                  auipc        t1, 195699
                  c.add        sp, s8
                  add          s3, s11, s3
                  sub          gp, s1, t2
                  c.add        sp, s8
                  c.srai       a4, 2
                  divu         t5, a7, tp
                  c.sub        a5, a1
                  mulh         zero, a3, gp
                  c.addi       a2, -1
                  mulhsu       s0, a1, t4
                  srli         s0, s11, 8
                  srli         s0, s11, 8
                  sub          gp, s1, t2
                  srli         s0, s11, 8
                  c.or         a5, a4
                  c.li         a0, 14
                  sltiu        t6, s10, -519
                  c.add        sp, s8
                  c.li         a0, 14
                  c.slli       s4, 24
                  remu         zero, s2, zero
                  xori         a3, s4, 1809
                  c.nop
                  divu         t5, a7, tp
                  slti         a0, a4, -1207
                  lui          sp, 776755
                  auipc        t1, 195699
                  slti         a0, a4, -1207
                  xori         a3, s4, 1809
                  andi         t6, a4, 389
                  mulhu        s3, s2, s7
                  auipc        t1, 195699
                  c.mv         a2, a2
                  remu         zero, s2, zero
                  sra          sp, a2, sp
                  slli         sp, t3, 13
                  c.and        a5, a4
                  sub          gp, s1, t2
                  add          s3, s11, s3
                  xor          s11, s5, a1
                  or           a2, a7, sp
                  sll          t2, s7, s3
                  c.and        a5, a4
                  c.nop
                  c.lui        s9, 19
                  c.srai       a4, 2
                  xor          s11, s5, a1
                  andi         t6, a4, 389
                  sra          sp, a2, sp
                  c.slli       s4, 24
                  and          s7, a5, a7
                  sltu         s9, a4, a0
                  add          s3, s11, s3
                  xor          s11, s5, a1
                  slt          t2, a1, s5
                  mul          a1, s1, t5
                  andi         t6, a4, 389
                  and          s7, a5, a7
                  xori         a3, s4, 1809
                  srl          s5, s7, sp
                  c.srli       a2, 1
                  slli         sp, t3, 13
                  sltu         s9, a4, a0
                  c.mv         a2, a2
                  slt          t2, a1, s5
                  nop
                  lui          sp, 776755
                  slli         sp, t3, 13
                  rem          sp, t6, tp
                  or           a2, a7, sp
                  nop
                  nop
                  sra          sp, a2, sp
                  add          s3, s11, s3
                  li           t3, 0x80000000 #start riscv_int_numeric_corner_stream_7
                  li           s5, 0xbda4bd01
                  li           s8, 0x0
                  li           a4, 0x0
                  li           ra, 0x6ad45218
                  li           a0, 0xfa8af163
                  li           t6, 0xffffffff
                  li           s10, 0x0
                  li           a2, 0xffffffff
                  li           s9, 0xffffffff
                  auipc        s8, 195699
                  rem          a2, s9, s5
                  mul          t6, t6, a4
                  auipc        s8, 195699
                  add          a0, a0, a4
                  mul          t6, t6, a4
                  add          a0, a0, a4
                  mulhsu       s10, s8, ra
                  sub          a4, t6, s10
                  divu         a0, a0, s5
                  lui          a2, 776755
                  addi         t6, s9, -1592
                  addi         t6, s9, -1592
                  lui          a2, 776755
                  nop
                  mulhsu       s10, s8, ra
                  divu         a0, a0, s5
                  nop
                  auipc        s8, 195699 #end riscv_int_numeric_corner_stream_7
                  c.sub        a5, a1
                  sra          sp, a2, sp
                  c.sub        a5, a1
                  xor          s11, s5, a1
                  div          t1, s3, a1
                  divu         t5, a7, tp
                  sltu         s9, a4, a0
                  xori         a3, s4, 1809
                  c.nop
                  sltiu        t6, s10, -519
                  divu         t5, a7, tp
                  c.sub        a5, a1
                  c.add        sp, s8
                  c.addi       a2, -1
                  rem          sp, t6, tp
                  sltiu        t6, s10, -519
                  sltu         s9, a4, a0
                  c.mv         a2, a2
                  c.li         a0, 14
                  mulhu        s3, s2, s7
                  remu         zero, s2, zero
                  c.sub        a5, a1
                  lui          sp, 776755
                  c.li         a0, 14
                  or           a2, a7, sp
                  xor          s11, s5, a1
                  addi         a1, t1, -1592
                  c.or         a5, a4
                  remu         zero, s2, zero
                  mulh         zero, a3, gp
                  slli         sp, t3, 13
                  srl          s5, s7, sp
                  addi         a1, t1, -1592
                  c.addi4spn   a5, sp, 464
                  or           a2, a7, sp
                  c.and        a5, a4
                  c.srli       a2, 1
                  c.add        sp, s8
                  or           a2, a7, sp
                  addi         a1, t1, -1592
                  c.add        sp, s8
                  rem          sp, t6, tp
                  c.addi4spn   a5, sp, 464
                  add          s3, s11, s3
                  andi         t6, a4, 389
                  slli         sp, t3, 13
                  c.srli       a2, 1
                  nop
                  c.srli       a2, 1
                  c.addi4spn   a5, sp, 464
                  remu         zero, s2, zero
                  slli         sp, t3, 13
                  c.or         a5, a4
                  sra          sp, a2, sp
                  or           a2, a7, sp
                  c.srai       a4, 2
                  sra          sp, a2, sp
                  xor          s11, s5, a1
                  rem          sp, t6, tp
                  c.slli       s4, 24
                  c.srai       a4, 2
                  sltu         s9, a4, a0
                  srl          s5, s7, sp
                  addi         a1, t1, -1592
                  ori          a6, t5, 1716
                  c.nop
                  addi         a1, t1, -1592
                  sll          t2, s7, s3
                  c.nop
                  andi         t6, a4, 389
                  slt          t2, a1, s5
                  xori         a3, s4, 1809
                  and          s7, a5, a7
                  c.or         a5, a4
                  c.addi4spn   a5, sp, 464
                  c.li         a0, 14
                  mul          a1, s1, t5
                  slt          t2, a1, s5
                  mulh         zero, a3, gp
                  sll          t2, s7, s3
                  c.addi       a2, -1
                  mul          a1, s1, t5
                  addi         a1, t1, -1592
                  mul          a1, s1, t5
                  slt          t2, a1, s5
                  slli         sp, t3, 13
                  mul          a1, s1, t5
                  c.mv         a2, a2
                  sltu         s9, a4, a0
                  xor          s11, s5, a1
                  c.sub        a5, a1
                  nop
                  ori          a6, t5, 1716
                  c.add        sp, s8
                  c.addi4spn   a5, sp, 464
                  sub          gp, s1, t2
                  nop
                  divu         t5, a7, tp
                  c.and        a5, a4
                  slli         sp, t3, 13
                  addi         a1, t1, -1592
                  div          t1, s3, a1
                  c.mv         a2, a2
                  c.and        a5, a4
                  srli         s0, s11, 8
                  and          s7, a5, a7
                  slti         a0, a4, -1207
                  c.slli       s4, 24
                  sltu         s9, a4, a0
                  c.srli       a2, 1
                  remu         zero, s2, zero
                  c.slli       s4, 24
                  xor          s11, s5, a1
                  c.mv         a2, a2
                  rem          sp, t6, tp
                  slli         sp, t3, 13
                  c.nop
                  c.li         a0, 14
                  srli         s0, s11, 8
                  c.nop
                  addi         a1, t1, -1592
                  or           a2, a7, sp
                  sltiu        t6, s10, -519
                  c.srai       a4, 2
                  slli         sp, t3, 13
                  mul          a1, s1, t5
                  c.addi4spn   a5, sp, 464
                  sltiu        t6, s10, -519
                  lui          sp, 776755
                  auipc        t1, 195699
                  sltu         s9, a4, a0
                  addi         a1, t1, -1592
                  sra          sp, a2, sp
                  c.srai       a4, 2
                  c.nop
                  div          t1, s3, a1
                  c.li         a0, 14
                  ori          a6, t5, 1716
                  c.addi16sp   sp, -16
                  c.add        sp, s8
                  c.andi       a4, 28
                  remu         zero, s2, zero
                  lui          sp, 776755
                  srai         gp, ra, 29
                  rem          sp, t6, tp
                  sub          gp, s1, t2
                  and          s7, a5, a7
                  c.add        sp, s8
                  c.andi       a4, 28
                  c.andi       a4, 28
                  xori         a3, s4, 1809
                  slli         sp, t3, 13
                  divu         t5, a7, tp
                  addi         a1, t1, -1592
                  nop
                  addi         a1, t1, -1592
                  c.nop
                  mulh         zero, a3, gp
                  c.and        a5, a4
                  or           a2, a7, sp
                  srl          s5, s7, sp
                  or           a2, a7, sp
                  c.and        a5, a4
                  auipc        t1, 195699
                  sll          t2, s7, s3
                  lui          sp, 776755
                  divu         t5, a7, tp
                  c.andi       a4, 28
                  sub          gp, s1, t2
                  xori         a3, s4, 1809
                  or           a2, a7, sp
                  xori         a3, s4, 1809
                  c.mv         a2, a2
                  c.li         a0, 14
                  c.addi       a2, -1
                  c.srli       a2, 1
                  slt          t2, a1, s5
                  ori          a6, t5, 1716
                  slti         a0, a4, -1207
                  mulh         zero, a3, gp
                  auipc        t1, 195699
                  slli         sp, t3, 13
                  c.andi       a4, 28
                  srl          s5, s7, sp
                  c.andi       a4, 28
                  c.li         a0, 14
                  c.li         a0, 14
                  or           a2, a7, sp
                  c.slli       s4, 24
                  mulhsu       s0, a1, t4
                  or           a2, a7, sp
                  srl          s5, s7, sp
                  c.slli       s4, 24
                  add          s3, s11, s3
                  c.or         a5, a4
                  xor          s11, s5, a1
                  xor          s11, s5, a1
                  rem          sp, t6, tp
                  divu         t5, a7, tp
                  remu         zero, s2, zero
                  div          t1, s3, a1
                  nop
                  c.add        sp, s8
                  slt          t2, a1, s5
                  c.andi       a4, 28
                  mul          a1, s1, t5
                  srli         s0, s11, 8
                  c.addi16sp   sp, -16
                  divu         t5, a7, tp
                  xor          s11, s5, a1
                  c.li         a0, 14
                  slti         a0, a4, -1207
                  xori         a3, s4, 1809
                  c.or         a5, a4
                  remu         zero, s2, zero
                  mulhsu       s0, a1, t4
                  and          s7, a5, a7
                  sltu         s9, a4, a0
                  c.lui        s9, 19
                  c.li         a0, 14
                  rem          sp, t6, tp
                  srli         s0, s11, 8
                  or           a2, a7, sp
                  c.mv         a2, a2
                  andi         t6, a4, 389
                  div          t1, s3, a1
                  c.srli       a2, 1
                  sll          t2, s7, s3
                  nop
                  xori         a3, s4, 1809
                  sltiu        t6, s10, -519
                  c.and        a5, a4
                  c.li         a0, 14
                  c.srai       a4, 2
                  auipc        t1, 195699
                  srai         gp, ra, 29
                  lui          sp, 776755
                  remu         zero, s2, zero
                  divu         t5, a7, tp
                  divu         t5, a7, tp
                  c.mv         a2, a2
                  c.add        sp, s8
                  c.addi4spn   a5, sp, 464
                  lui          sp, 776755
                  slli         sp, t3, 13
                  sltiu        t6, s10, -519
                  c.srli       a2, 1
                  c.slli       s4, 24
                  srl          s5, s7, sp
                  c.srli       a2, 1
                  sub          gp, s1, t2
                  c.slli       s4, 24
                  c.lui        s9, 19
                  c.sub        a5, a1
                  srl          s5, s7, sp
                  c.addi       a2, -1
                  c.srai       a4, 2
                  ori          a6, t5, 1716
                  c.srai       a4, 2
                  ori          a6, t5, 1716
                  nop
                  sub          gp, s1, t2
                  c.srli       a2, 1
                  c.nop
                  addi         a1, t1, -1592
                  div          t1, s3, a1
                  or           a2, a7, sp
                  sltu         s9, a4, a0
                  c.and        a5, a4
                  srl          s5, s7, sp
                  srl          s5, s7, sp
                  slt          t2, a1, s5
                  sltiu        t6, s10, -519
                  slt          t2, a1, s5
                  c.addi       a2, -1
                  mulhsu       s0, a1, t4
                  xori         a3, s4, 1809
                  remu         zero, s2, zero
                  c.addi       a2, -1
                  add          s3, s11, s3
                  c.mv         a2, a2
                  li           t3, 0x6da12871 #start riscv_int_numeric_corner_stream_12
                  li           sp, 0x80000000
                  li           a2, 0xffffffff
                  li           s3, 0x0
                  li           t1, 0x80000000
                  li           a0, 0x9a883c9d
                  li           gp, 0x80000000
                  li           a1, 0xb3860f47
                  li           s8, 0x80000000
                  li           s2, 0xdcbd502e
                  lui          t1, 776755
                  mulhsu       s3, a2, sp
                  div          a2, a0, s2
                  nop
                  remu         sp, t1, sp
                  mul          t3, t3, a0
                  nop
                  rem          t1, s2, a1
                  divu         gp, gp, a1
                  mulh         sp, a1, a0
                  div          a2, a0, s2
                  addi         t3, s2, -1592
                  mulhsu       s3, a2, sp
                  addi         t3, s2, -1592
                  div          a2, a0, s2
                  auipc        a2, 195699
                  mulhsu       s3, a2, sp
                  mul          t3, t3, a0
                  auipc        a2, 195699
                  mulhsu       s3, a2, sp
                  auipc        a2, 195699
                  sub          a0, t3, s3
                  auipc        a2, 195699
                  add          gp, gp, a0
                  lui          t1, 776755
                  addi         t3, s2, -1592
                  add          gp, gp, a0
                  divu         gp, gp, a1
                  div          a2, a0, s2 #end riscv_int_numeric_corner_stream_12
                  xori         a3, s4, 1809
                  sltiu        t6, s10, -519
                  c.nop
                  srli         s0, s11, 8
                  c.addi16sp   sp, -16
                  mul          a1, s1, t5
                  c.nop
                  sra          sp, a2, sp
                  c.li         a0, 14
                  sra          sp, a2, sp
                  c.and        a5, a4
                  c.addi       a2, -1
                  c.li         a0, 14
                  mulhsu       s0, a1, t4
                  c.or         a5, a4
                  sltiu        t6, s10, -519
                  c.or         a5, a4
                  rem          sp, t6, tp
                  sub          gp, s1, t2
                  c.li         a0, 14
                  xor          s11, s5, a1
                  slt          t2, a1, s5
                  c.andi       a4, 28
                  c.addi       a2, -1
                  addi         a1, t1, -1592
                  c.addi4spn   a5, sp, 464
                  c.li         a0, 14
                  divu         t5, a7, tp
                  addi         a1, t1, -1592
                  c.nop
                  c.srai       a4, 2
                  c.li         a0, 14
                  ori          a6, t5, 1716
                  xor          s11, s5, a1
                  sltu         s9, a4, a0
                  mul          a1, s1, t5
                  auipc        t1, 195699
                  sub          gp, s1, t2
                  sltu         s9, a4, a0
                  c.and        a5, a4
                  mulhsu       s0, a1, t4
                  c.xor        a3, a5
                  c.addi16sp   sp, -16
                  c.nop
                  sltu         s9, a4, a0
                  slti         a0, a4, -1207
                  auipc        t1, 195699
                  andi         t6, a4, 389
                  auipc        t1, 195699
                  remu         zero, s2, zero
                  c.sub        a5, a1
                  mulh         zero, a3, gp
                  sub          gp, s1, t2
                  c.and        a5, a4
                  c.andi       a4, 28
                  c.and        a5, a4
                  andi         t6, a4, 389
                  rem          sp, t6, tp
                  slt          t2, a1, s5
                  c.sub        a5, a1
                  sltiu        t6, s10, -519
                  sltiu        t6, s10, -519
                  andi         t6, a4, 389
                  auipc        t1, 195699
                  c.xor        a3, a5
                  c.add        sp, s8
                  lui          sp, 776755
                  rem          sp, t6, tp
                  lui          sp, 776755
                  mulhu        s3, s2, s7
                  c.mv         a2, a2
                  c.add        sp, s8
                  xor          s11, s5, a1
                  sra          sp, a2, sp
                  lui          sp, 776755
                  c.addi16sp   sp, -16
                  slli         sp, t3, 13
                  lui          sp, 776755
                  c.addi       a2, -1
                  srli         s0, s11, 8
                  c.and        a5, a4
                  sltu         s9, a4, a0
                  c.or         a5, a4
                  c.addi       a2, -1
                  divu         t5, a7, tp
                  c.nop
                  divu         t5, a7, tp
                  mulh         zero, a3, gp
                  sltiu        t6, s10, -519
                  c.andi       a4, 28
                  c.or         a5, a4
                  slt          t2, a1, s5
                  sll          t2, s7, s3
                  lui          sp, 776755
                  divu         t5, a7, tp
                  addi         a1, t1, -1592
                  nop
                  c.xor        a3, a5
                  sltu         s9, a4, a0
                  c.xor        a3, a5
                  addi         a1, t1, -1592
                  rem          sp, t6, tp
                  c.andi       a4, 28
                  c.srli       a2, 1
                  sltu         s9, a4, a0
                  lui          sp, 776755
                  slt          t2, a1, s5
                  or           a2, a7, sp
                  c.addi4spn   a5, sp, 464
                  mul          a1, s1, t5
                  lui          sp, 776755
                  slt          t2, a1, s5
                  and          s7, a5, a7
                  sra          sp, a2, sp
                  remu         zero, s2, zero
                  rem          sp, t6, tp
                  addi         a1, t1, -1592
                  and          s7, a5, a7
                  sub          gp, s1, t2
                  c.and        a5, a4
                  c.lui        s9, 19
                  c.lui        s9, 19
                  remu         zero, s2, zero
                  divu         t5, a7, tp
                  or           a2, a7, sp
                  c.addi       a2, -1
                  andi         t6, a4, 389
                  srli         s0, s11, 8
                  mul          a1, s1, t5
                  c.lui        s9, 19
                  c.srli       a2, 1
                  slli         sp, t3, 13
                  c.mv         a2, a2
                  c.lui        s9, 19
                  addi         a1, t1, -1592
                  nop
                  c.srli       a2, 1
                  c.li         a0, 14
                  mul          a1, s1, t5
                  slti         a0, a4, -1207
                  divu         t5, a7, tp
                  sra          sp, a2, sp
                  mulh         zero, a3, gp
                  c.nop
                  mulhsu       s0, a1, t4
                  mul          a1, s1, t5
                  xor          s11, s5, a1
                  c.add        sp, s8
                  or           a2, a7, sp
                  slt          t2, a1, s5
                  auipc        t1, 195699
                  sra          sp, a2, sp
                  c.xor        a3, a5
                  lui          sp, 776755
                  c.andi       a4, 28
                  ori          a6, t5, 1716
                  andi         t6, a4, 389
                  c.sub        a5, a1
                  slli         sp, t3, 13
                  c.xor        a3, a5
                  slli         sp, t3, 13
                  slti         a0, a4, -1207
                  slli         sp, t3, 13
                  c.or         a5, a4
                  slli         sp, t3, 13
                  c.and        a5, a4
                  sll          t2, s7, s3
                  mul          a1, s1, t5
                  remu         zero, s2, zero
                  and          s7, a5, a7
                  mulhu        s3, s2, s7
                  c.mv         a2, a2
                  remu         zero, s2, zero
                  or           a2, a7, sp
                  c.xor        a3, a5
                  and          s7, a5, a7
                  c.andi       a4, 28
                  sltu         s9, a4, a0
                  lui          sp, 776755
                  sll          t2, s7, s3
                  sra          sp, a2, sp
                  c.add        sp, s8
                  xor          s11, s5, a1
                  c.srai       a4, 2
                  slti         a0, a4, -1207
                  c.nop
                  mulh         zero, a3, gp
                  c.add        sp, s8
                  c.addi4spn   a5, sp, 464
                  nop
                  mul          a1, s1, t5
                  c.mv         a2, a2
                  add          s3, s11, s3
                  c.andi       a4, 28
                  auipc        t1, 195699
                  xor          s11, s5, a1
                  c.addi16sp   sp, -16
                  sra          sp, a2, sp
                  slt          t2, a1, s5
                  c.sub        a5, a1
                  srai         gp, ra, 29
                  sub          gp, s1, t2
                  and          s7, a5, a7
                  sltu         s9, a4, a0
                  ori          a6, t5, 1716
                  c.addi       a2, -1
                  rem          sp, t6, tp
                  c.or         a5, a4
                  c.addi       a2, -1
                  c.sub        a5, a1
                  c.srai       a4, 2
                  mulhsu       s0, a1, t4
                  c.addi       a2, -1
                  lui          sp, 776755
                  mulhu        s3, s2, s7
                  sra          sp, a2, sp
                  c.addi       a2, -1
                  divu         t5, a7, tp
                  c.addi       a2, -1
                  c.andi       a4, 28
                  mul          a1, s1, t5
                  c.nop
                  c.sub        a5, a1
                  lui          sp, 776755
                  slt          t2, a1, s5
                  sub          gp, s1, t2
                  auipc        t1, 195699
                  slti         a0, a4, -1207
                  divu         t5, a7, tp
                  c.or         a5, a4
                  c.slli       s4, 24
                  auipc        t1, 195699
                  sub          gp, s1, t2
                  c.addi16sp   sp, -16
                  sub          gp, s1, t2
                  addi         a1, t1, -1592
                  slt          t2, a1, s5
                  sltu         s9, a4, a0
                  c.li         a0, 14
                  auipc        t1, 195699
                  c.xor        a3, a5
                  srl          s5, s7, sp
                  sltiu        t6, s10, -519
                  ori          a6, t5, 1716
                  or           a2, a7, sp
                  mulh         zero, a3, gp
                  div          t1, s3, a1
                  sltu         s9, a4, a0
                  srl          s5, s7, sp
                  c.addi       a2, -1
                  sltiu        t6, s10, -519
                  c.mv         a2, a2
                  c.andi       a4, 28
                  mulhu        s3, s2, s7
                  c.srli       a2, 1
                  c.mv         a2, a2
                  sll          t2, s7, s3
                  sltu         s9, a4, a0
                  sll          t2, s7, s3
                  slli         sp, t3, 13
                  remu         zero, s2, zero
                  sltiu        t6, s10, -519
                  slti         a0, a4, -1207
                  ori          a6, t5, 1716
                  sub          gp, s1, t2
                  div          t1, s3, a1
                  ori          a6, t5, 1716
                  mulhu        s3, s2, s7
                  srl          s5, s7, sp
                  sltiu        t6, s10, -519
                  c.or         a5, a4
                  c.lui        s9, 19
                  sra          sp, a2, sp
                  c.addi16sp   sp, -16
                  c.addi4spn   a5, sp, 464
                  srli         s0, s11, 8
                  c.addi4spn   a5, sp, 464
                  andi         t6, a4, 389
                  and          s7, a5, a7
                  mulhu        s3, s2, s7
                  rem          sp, t6, tp
                  ori          a6, t5, 1716
                  xori         a3, s4, 1809
                  rem          sp, t6, tp
                  c.or         a5, a4
                  auipc        t1, 195699
                  lui          sp, 776755
                  c.srai       a4, 2
                  divu         t5, a7, tp
                  c.addi16sp   sp, -16
                  slt          t2, a1, s5
                  srl          s5, s7, sp
                  mulhu        s3, s2, s7
                  auipc        t1, 195699
                  c.addi16sp   sp, -16
                  c.and        a5, a4
                  mulhsu       s0, a1, t4
                  remu         zero, s2, zero
                  srai         gp, ra, 29
                  nop
                  mulh         zero, a3, gp
                  c.slli       s4, 24
                  sltu         s9, a4, a0
                  c.xor        a3, a5
                  mul          a1, s1, t5
                  c.andi       a4, 28
                  addi         a1, t1, -1592
                  add          s3, s11, s3
                  lui          sp, 776755
                  or           a2, a7, sp
                  slti         a0, a4, -1207
                  sltiu        t6, s10, -519
                  slt          t2, a1, s5
                  c.addi4spn   a5, sp, 464
                  ori          a6, t5, 1716
                  c.addi4spn   a5, sp, 464
                  mulhu        s3, s2, s7
                  c.xor        a3, a5
                  mulhu        s3, s2, s7
                  divu         t5, a7, tp
                  slt          t2, a1, s5
                  c.sub        a5, a1
                  c.addi4spn   a5, sp, 464
                  div          t1, s3, a1
                  ori          a6, t5, 1716
                  addi         a1, t1, -1592
                  rem          sp, t6, tp
                  mul          a1, s1, t5
                  or           a2, a7, sp
                  sra          sp, a2, sp
                  c.nop
                  mulhu        s3, s2, s7
                  sll          t2, s7, s3
                  c.addi16sp   sp, -16
                  c.slli       s4, 24
                  c.srai       a4, 2
                  xori         a3, s4, 1809
                  sub          gp, s1, t2
                  mulhu        s3, s2, s7
                  mulhsu       s0, a1, t4
                  sltu         s9, a4, a0
                  addi         a1, t1, -1592
                  auipc        t1, 195699
                  c.andi       a4, 28
                  nop
                  srli         s0, s11, 8
                  addi         a1, t1, -1592
                  mulhu        s3, s2, s7
                  slli         sp, t3, 13
                  c.srai       a4, 2
                  slt          t2, a1, s5
                  lui          sp, 776755
                  c.or         a5, a4
                  slli         sp, t3, 13
                  mulhsu       s0, a1, t4
                  auipc        t1, 195699
                  add          s3, s11, s3
                  remu         zero, s2, zero
                  remu         zero, s2, zero
                  addi         a1, t1, -1592
                  addi         a1, t1, -1592
                  add          s3, s11, s3
                  sra          sp, a2, sp
                  sltu         s9, a4, a0
                  slli         sp, t3, 13
                  srl          s5, s7, sp
                  c.addi4spn   a5, sp, 464
                  c.add        sp, s8
                  nop
                  c.lui        s9, 19
                  andi         t6, a4, 389
                  nop
                  c.mv         a2, a2
                  c.lui        s9, 19
                  c.add        sp, s8
                  rem          sp, t6, tp
                  c.addi4spn   a5, sp, 464
                  sra          sp, a2, sp
                  c.add        sp, s8
                  rem          sp, t6, tp
                  c.srli       a2, 1
                  slt          t2, a1, s5
                  c.sub        a5, a1
                  c.xor        a3, a5
                  c.srli       a2, 1
                  c.sub        a5, a1
                  and          s7, a5, a7
                  c.add        sp, s8
                  sll          t2, s7, s3
                  mulh         zero, a3, gp
                  xor          s11, s5, a1
                  c.mv         a2, a2
                  c.srai       a4, 2
                  c.add        sp, s8
                  divu         t5, a7, tp
                  c.li         a0, 14
                  addi         a1, t1, -1592
                  lui          sp, 776755
                  c.nop
                  c.lui        s9, 19
                  srai         gp, ra, 29
                  addi         a1, t1, -1592
                  auipc        t1, 195699
                  rem          sp, t6, tp
                  c.srli       a2, 1
                  c.nop
                  addi         a1, t1, -1592
                  mul          a1, s1, t5
                  sll          t2, s7, s3
                  sra          sp, a2, sp
                  slti         a0, a4, -1207
                  c.addi4spn   a5, sp, 464
                  c.slli       s4, 24
                  addi         a1, t1, -1592
                  sll          t2, s7, s3
                  xori         a3, s4, 1809
                  addi         a1, t1, -1592
                  c.lui        s9, 19
                  rem          sp, t6, tp
                  addi         a1, t1, -1592
                  slti         a0, a4, -1207
                  srai         gp, ra, 29
                  c.srai       a4, 2
                  divu         t5, a7, tp
                  andi         t6, a4, 389
                  or           a2, a7, sp
                  xori         a3, s4, 1809
                  div          t1, s3, a1
                  ori          a6, t5, 1716
                  c.li         a0, 14
                  xor          s11, s5, a1
                  slli         sp, t3, 13
                  rem          sp, t6, tp
                  c.add        sp, s8
                  c.and        a5, a4
                  c.addi4spn   a5, sp, 464
                  slt          t2, a1, s5
                  c.nop
                  c.nop
                  mulh         zero, a3, gp
                  nop
                  srai         gp, ra, 29
                  slli         sp, t3, 13
                  c.sub        a5, a1
                  c.srai       a4, 2
                  c.srai       a4, 2
                  c.slli       s4, 24
                  c.lui        s9, 19
                  c.andi       a4, 28
                  xori         a3, s4, 1809
                  auipc        t1, 195699
                  lui          sp, 776755
                  c.addi4spn   a5, sp, 464
                  c.srli       a2, 1
                  addi         a1, t1, -1592
                  c.sub        a5, a1
                  sltiu        t6, s10, -519
                  remu         zero, s2, zero
                  c.sub        a5, a1
                  c.or         a5, a4
                  addi         a1, t1, -1592
                  c.or         a5, a4
                  srl          s5, s7, sp
                  sra          sp, a2, sp
                  div          t1, s3, a1
                  divu         t5, a7, tp
                  srai         gp, ra, 29
                  srl          s5, s7, sp
                  c.addi4spn   a5, sp, 464
                  sub          gp, s1, t2
                  c.xor        a3, a5
                  slti         a0, a4, -1207
                  add          s3, s11, s3
                  c.slli       s4, 24
                  mul          a1, s1, t5
                  slti         a0, a4, -1207
                  c.srai       a4, 2
                  c.addi       a2, -1
                  slli         sp, t3, 13
                  ori          a6, t5, 1716
                  c.slli       s4, 24
                  mulhsu       s0, a1, t4
                  div          t1, s3, a1
                  mulh         zero, a3, gp
                  divu         t5, a7, tp
                  srai         gp, ra, 29
                  sra          sp, a2, sp
                  slti         a0, a4, -1207
                  add          s3, s11, s3
                  c.slli       s4, 24
                  c.addi       a2, -1
                  add          s3, s11, s3
                  add          s3, s11, s3
                  c.srai       a4, 2
                  addi         a1, t1, -1592
                  c.andi       a4, 28
                  c.or         a5, a4
                  addi         a1, t1, -1592
                  c.addi       a2, -1
                  mulhsu       s0, a1, t4
                  xori         a3, s4, 1809
                  sltu         s9, a4, a0
                  mul          a1, s1, t5
                  srl          s5, s7, sp
                  c.srai       a4, 2
                  nop
                  sra          sp, a2, sp
                  c.or         a5, a4
                  remu         zero, s2, zero
                  sltiu        t6, s10, -519
                  sltu         s9, a4, a0
                  c.addi16sp   sp, -16
                  remu         zero, s2, zero
                  c.nop
                  c.srai       a4, 2
                  or           a2, a7, sp
                  addi         a1, t1, -1592
                  c.slli       s4, 24
                  sltu         s9, a4, a0
                  xori         a3, s4, 1809
                  xori         a3, s4, 1809
                  c.mv         a2, a2
                  sltiu        t6, s10, -519
                  rem          sp, t6, tp
                  c.sub        a5, a1
                  c.addi4spn   a5, sp, 464
                  c.sub        a5, a1
                  ori          a6, t5, 1716
                  c.andi       a4, 28
                  c.addi       a2, -1
                  xori         a3, s4, 1809
                  add          s3, s11, s3
                  mulhu        s3, s2, s7
                  mul          a1, s1, t5
                  mulhu        s3, s2, s7
                  c.srli       a2, 1
                  c.addi       a2, -1
                  divu         t5, a7, tp
                  lui          sp, 776755
                  c.nop
                  auipc        t1, 195699
                  xor          s11, s5, a1
                  slt          t2, a1, s5
                  c.srli       a2, 1
                  c.mv         a2, a2
                  andi         t6, a4, 389
                  slt          t2, a1, s5
                  c.andi       a4, 28
                  srl          s5, s7, sp
                  c.andi       a4, 28
                  rem          sp, t6, tp
                  ori          a6, t5, 1716
                  lui          sp, 776755
                  srli         s0, s11, 8
                  c.srli       a2, 1
                  div          t1, s3, a1
                  c.addi16sp   sp, -16
                  divu         t5, a7, tp
                  slli         sp, t3, 13
                  c.nop
                  div          t1, s3, a1
                  xor          s11, s5, a1
                  sltiu        t6, s10, -519
                  c.add        sp, s8
                  xor          s11, s5, a1
                  c.nop
                  c.lui        s9, 19
                  c.sub        a5, a1
                  c.li         a0, 14
                  c.and        a5, a4
                  auipc        t1, 195699
                  c.li         a0, 14
                  add          s3, s11, s3
                  slli         sp, t3, 13
                  c.slli       s4, 24
                  sub          gp, s1, t2
                  c.xor        a3, a5
                  addi         a1, t1, -1592
                  c.srli       a2, 1
                  sub          gp, s1, t2
                  sra          sp, a2, sp
                  ori          a6, t5, 1716
                  slli         sp, t3, 13
                  or           a2, a7, sp
                  or           a2, a7, sp
                  or           a2, a7, sp
                  c.mv         a2, a2
                  c.andi       a4, 28
                  xori         a3, s4, 1809
                  div          t1, s3, a1
                  sra          sp, a2, sp
                  divu         t5, a7, tp
                  ori          a6, t5, 1716
                  c.nop
                  sub          gp, s1, t2
                  mulh         zero, a3, gp
                  slli         sp, t3, 13
                  andi         t6, a4, 389
                  ori          a6, t5, 1716
                  sltu         s9, a4, a0
                  c.lui        s9, 19
                  sub          gp, s1, t2
                  mulh         zero, a3, gp
                  c.and        a5, a4
                  c.srai       a4, 2
                  addi         a1, t1, -1592
                  and          s7, a5, a7
                  slli         sp, t3, 13
                  nop
                  slli         sp, t3, 13
                  slti         a0, a4, -1207
                  auipc        t1, 195699
                  srl          s5, s7, sp
                  mulhsu       s0, a1, t4
                  c.addi16sp   sp, -16
                  c.xor        a3, a5
                  sub          gp, s1, t2
                  c.or         a5, a4
                  c.addi       a2, -1
                  c.srli       a2, 1
                  c.and        a5, a4
                  c.sub        a5, a1
                  c.add        sp, s8
                  c.xor        a3, a5
                  c.nop
                  sra          sp, a2, sp
                  sra          sp, a2, sp
                  sltiu        t6, s10, -519
                  addi         a1, t1, -1592
                  divu         t5, a7, tp
                  divu         t5, a7, tp
                  or           a2, a7, sp
                  slti         a0, a4, -1207
                  remu         zero, s2, zero
                  xori         a3, s4, 1809
                  c.lui        s9, 19
                  mulh         zero, a3, gp
                  c.li         a0, 14
                  xori         a3, s4, 1809
                  remu         zero, s2, zero
                  c.addi       a2, -1
                  c.mv         a2, a2
                  xor          s11, s5, a1
                  slti         a0, a4, -1207
                  sra          sp, a2, sp
                  srai         gp, ra, 29
                  sub          gp, s1, t2
                  xori         a3, s4, 1809
                  c.srli       a2, 1
                  or           a2, a7, sp
                  slt          t2, a1, s5
                  slt          t2, a1, s5
                  sub          gp, s1, t2
                  c.slli       s4, 24
                  add          s3, s11, s3
                  sltu         s9, a4, a0
                  c.slli       s4, 24
                  c.and        a5, a4
                  add          s3, s11, s3
                  or           a2, a7, sp
                  ori          a6, t5, 1716
                  and          s7, a5, a7
                  mulhu        s3, s2, s7
                  c.add        sp, s8
                  sra          sp, a2, sp
                  sub          gp, s1, t2
                  c.li         a0, 14
                  sltu         s9, a4, a0
                  sll          t2, s7, s3
                  srli         s0, s11, 8
                  c.sub        a5, a1
                  c.srai       a4, 2
                  xor          s11, s5, a1
                  mulhu        s3, s2, s7
                  mul          a1, s1, t5
                  mulhu        s3, s2, s7
                  andi         t6, a4, 389
                  c.slli       s4, 24
                  mulhu        s3, s2, s7
                  sub          gp, s1, t2
                  mulhu        s3, s2, s7
                  or           a2, a7, sp
                  mulhsu       s0, a1, t4
                  c.nop
                  c.slli       s4, 24
                  remu         zero, s2, zero
                  lui          sp, 776755
                  sltu         s9, a4, a0
                  c.lui        s9, 19
                  divu         t5, a7, tp
                  c.addi       a2, -1
                  sub          gp, s1, t2
                  mulhsu       s0, a1, t4
                  mulhu        s3, s2, s7
                  sltiu        t6, s10, -519
                  nop
                  mulhu        s3, s2, s7
                  c.srai       a4, 2
                  slt          t2, a1, s5
                  c.and        a5, a4
                  or           a2, a7, sp
                  c.slli       s4, 24
                  andi         t6, a4, 389
                  c.lui        s9, 19
                  ori          a6, t5, 1716
                  auipc        t1, 195699
                  c.or         a5, a4
                  c.or         a5, a4
                  c.add        sp, s8
                  c.li         a0, 14
                  c.srai       a4, 2
                  lui          sp, 776755
                  sltiu        t6, s10, -519
                  c.slli       s4, 24
                  c.addi       a2, -1
                  mul          a1, s1, t5
                  sltiu        t6, s10, -519
                  c.srli       a2, 1
                  addi         a1, t1, -1592
                  c.or         a5, a4
                  mulhsu       s0, a1, t4
                  add          s3, s11, s3
                  mulh         zero, a3, gp
                  c.or         a5, a4
                  rem          sp, t6, tp
                  c.nop
                  addi         a1, t1, -1592
                  c.addi       a2, -1
                  c.srai       a4, 2
                  or           a2, a7, sp
                  rem          sp, t6, tp
                  remu         zero, s2, zero
                  c.slli       s4, 24
                  c.sub        a5, a1
                  c.srai       a4, 2
                  andi         t6, a4, 389
                  c.li         a0, 14
                  ori          a6, t5, 1716
                  c.addi4spn   a5, sp, 464
                  c.li         a0, 14
                  c.srai       a4, 2
                  and          s7, a5, a7
                  add          s3, s11, s3
                  c.addi       a2, -1
                  sll          t2, s7, s3
                  c.srai       a4, 2
                  add          s3, s11, s3
                  divu         t5, a7, tp
                  c.andi       a4, 28
                  mulhsu       s0, a1, t4
                  remu         zero, s2, zero
                  sra          sp, a2, sp
                  mulhsu       s0, a1, t4
                  xori         a3, s4, 1809
                  slt          t2, a1, s5
                  c.sub        a5, a1
                  c.addi       a2, -1
                  c.lui        s9, 19
                  andi         t6, a4, 389
                  slti         a0, a4, -1207
                  slli         sp, t3, 13
                  sll          t2, s7, s3
                  c.sub        a5, a1
                  slli         sp, t3, 13
                  c.andi       a4, 28
                  c.add        sp, s8
                  divu         t5, a7, tp
                  add          s3, s11, s3
                  slli         sp, t3, 13
                  slli         sp, t3, 13
                  nop
                  c.srai       a4, 2
                  c.addi16sp   sp, -16
                  c.andi       a4, 28
                  c.andi       a4, 28
                  lui          sp, 776755
                  c.or         a5, a4
                  divu         t5, a7, tp
                  c.xor        a3, a5
                  c.andi       a4, 28
                  or           a2, a7, sp
                  xori         a3, s4, 1809
                  rem          sp, t6, tp
                  add          s3, s11, s3
                  ori          a6, t5, 1716
                  c.addi16sp   sp, -16
                  c.xor        a3, a5
                  mulhu        s3, s2, s7
                  slt          t2, a1, s5
                  add          s3, s11, s3
                  sltiu        t6, s10, -519
                  c.sub        a5, a1
                  slt          t2, a1, s5
                  c.addi16sp   sp, -16
                  slli         sp, t3, 13
                  sll          t2, s7, s3
                  sra          sp, a2, sp
                  slli         sp, t3, 13
                  mulhu        s3, s2, s7
                  or           a2, a7, sp
                  sltiu        t6, s10, -519
                  c.andi       a4, 28
                  slli         sp, t3, 13
                  c.li         a0, 14
                  c.or         a5, a4
                  c.addi16sp   sp, -16
                  div          t1, s3, a1
                  add          s3, s11, s3
                  c.addi16sp   sp, -16
                  or           a2, a7, sp
                  srl          s5, s7, sp
                  ori          a6, t5, 1716
                  c.xor        a3, a5
                  addi         a1, t1, -1592
                  sltiu        t6, s10, -519
                  sub          gp, s1, t2
                  c.add        sp, s8
                  c.lui        s9, 19
                  divu         t5, a7, tp
                  slli         sp, t3, 13
                  divu         t5, a7, tp
                  slt          t2, a1, s5
                  rem          sp, t6, tp
                  c.srli       a2, 1
                  xor          s11, s5, a1
                  xor          s11, s5, a1
                  sltu         s9, a4, a0
                  c.sub        a5, a1
                  divu         t5, a7, tp
                  slt          t2, a1, s5
                  c.lui        s9, 19
                  lui          sp, 776755
                  c.slli       s4, 24
                  div          t1, s3, a1
                  c.lui        s9, 19
                  srli         s0, s11, 8
                  sra          sp, a2, sp
                  c.slli       s4, 24
                  lui          sp, 776755
                  c.and        a5, a4
                  c.srai       a4, 2
                  sltu         s9, a4, a0
                  c.li         a0, 14
                  sltu         s9, a4, a0
                  auipc        t1, 195699
                  sra          sp, a2, sp
                  slli         sp, t3, 13
                  mulh         zero, a3, gp
                  c.mv         a2, a2
                  slli         sp, t3, 13
                  add          s3, s11, s3
                  nop
                  c.andi       a4, 28
                  srli         s0, s11, 8
                  c.addi4spn   a5, sp, 464
                  c.slli       s4, 24
                  remu         zero, s2, zero
                  mulhsu       s0, a1, t4
                  c.sub        a5, a1
                  add          s3, s11, s3
                  sll          t2, s7, s3
                  c.addi       a2, -1
                  lui          sp, 776755
                  c.slli       s4, 24
                  sub          gp, s1, t2
                  remu         zero, s2, zero
                  c.sub        a5, a1
                  c.andi       a4, 28
                  mulhu        s3, s2, s7
                  xor          s11, s5, a1
                  slti         a0, a4, -1207
                  c.or         a5, a4
                  c.add        sp, s8
                  c.lui        s9, 19
                  addi         a1, t1, -1592
                  div          t1, s3, a1
                  srai         gp, ra, 29
                  mulhsu       s0, a1, t4
                  slli         sp, t3, 13
                  mulhsu       s0, a1, t4
                  sub          gp, s1, t2
                  sltiu        t6, s10, -519
                  xor          s11, s5, a1
                  slli         sp, t3, 13
                  slli         sp, t3, 13
                  add          s3, s11, s3
                  c.mv         a2, a2
                  xor          s11, s5, a1
                  nop
                  c.addi4spn   a5, sp, 464
                  c.xor        a3, a5
                  nop
                  sltiu        t6, s10, -519
                  rem          sp, t6, tp
                  c.sub        a5, a1
                  mul          a1, s1, t5
                  slli         sp, t3, 13
                  c.slli       s4, 24
                  c.mv         a2, a2
                  mulhsu       s0, a1, t4
                  c.li         a0, 14
                  c.slli       s4, 24
                  c.andi       a4, 28
                  div          t1, s3, a1
                  sll          t2, s7, s3
                  c.mv         a2, a2
                  xor          s11, s5, a1
                  slti         a0, a4, -1207
                  andi         t6, a4, 389
                  remu         zero, s2, zero
                  c.srai       a4, 2
                  srl          s5, s7, sp
                  c.andi       a4, 28
                  sub          gp, s1, t2
                  auipc        t1, 195699
                  mulhu        s3, s2, s7
                  c.srai       a4, 2
                  or           a2, a7, sp
                  srli         s0, s11, 8
                  xor          s11, s5, a1
                  c.srai       a4, 2
                  or           a2, a7, sp
                  slli         sp, t3, 13
                  or           a2, a7, sp
                  c.and        a5, a4
                  c.addi4spn   a5, sp, 464
                  c.addi4spn   a5, sp, 464
                  add          s3, s11, s3
                  mul          a1, s1, t5
                  mulhsu       s0, a1, t4
                  mulhsu       s0, a1, t4
                  slti         a0, a4, -1207
                  srl          s5, s7, sp
                  slt          t2, a1, s5
                  c.addi4spn   a5, sp, 464
                  c.andi       a4, 28
                  xori         a3, s4, 1809
                  sltu         s9, a4, a0
                  c.srli       a2, 1
                  nop
                  c.sub        a5, a1
                  auipc        t1, 195699
                  c.nop
                  srli         s0, s11, 8
                  slt          t2, a1, s5
                  c.srli       a2, 1
                  c.add        sp, s8
                  sltu         s9, a4, a0
                  srl          s5, s7, sp
                  slti         a0, a4, -1207
                  c.sub        a5, a1
                  c.addi4spn   a5, sp, 464
                  addi         a1, t1, -1592
                  c.srli       a2, 1
                  xori         a3, s4, 1809
                  or           a2, a7, sp
                  c.addi       a2, -1
                  auipc        t1, 195699
                  add          s3, s11, s3
                  c.or         a5, a4
                  remu         zero, s2, zero
                  ori          a6, t5, 1716
                  c.srai       a4, 2
                  rem          sp, t6, tp
                  auipc        t1, 195699
                  xor          s11, s5, a1
                  lui          sp, 776755
                  andi         t6, a4, 389
                  c.mv         a2, a2
                  andi         t6, a4, 389
                  div          t1, s3, a1
                  slt          t2, a1, s5
                  c.xor        a3, a5
                  sra          sp, a2, sp
                  mul          a1, s1, t5
                  mulhsu       s0, a1, t4
                  c.or         a5, a4
                  c.lui        s9, 19
                  slt          t2, a1, s5
                  c.addi4spn   a5, sp, 464
                  xor          s11, s5, a1
                  c.srai       a4, 2
                  lui          sp, 776755
                  xor          s11, s5, a1
                  addi         a1, t1, -1592
                  xor          s11, s5, a1
                  sltiu        t6, s10, -519
                  c.add        sp, s8
                  c.or         a5, a4
                  xori         a3, s4, 1809
                  andi         t6, a4, 389
                  sra          sp, a2, sp
                  c.and        a5, a4
                  lui          sp, 776755
                  c.nop
                  c.li         a0, 14
                  slli         sp, t3, 13
                  auipc        t1, 195699
                  sub          gp, s1, t2
                  c.mv         a2, a2
                  srai         gp, ra, 29
                  c.addi16sp   sp, -16
                  remu         zero, s2, zero
                  slli         sp, t3, 13
                  rem          sp, t6, tp
                  sltiu        t6, s10, -519
                  c.or         a5, a4
                  c.srai       a4, 2
                  divu         t5, a7, tp
                  sra          sp, a2, sp
                  c.addi16sp   sp, -16
                  add          s3, s11, s3
                  sltiu        t6, s10, -519
                  mulh         zero, a3, gp
                  c.slli       s4, 24
                  sltiu        t6, s10, -519
                  or           a2, a7, sp
                  add          s3, s11, s3
                  sltiu        t6, s10, -519
                  c.addi4spn   a5, sp, 464
                  andi         t6, a4, 389
                  c.srli       a2, 1
                  nop
                  or           a2, a7, sp
                  sub          gp, s1, t2
                  auipc        t1, 195699
                  sub          gp, s1, t2
                  sltiu        t6, s10, -519
                  xori         a3, s4, 1809
                  srl          s5, s7, sp
                  c.nop
                  c.addi16sp   sp, -16
                  c.srli       a2, 1
                  c.addi16sp   sp, -16
                  srli         s0, s11, 8
                  mulhsu       s0, a1, t4
                  c.and        a5, a4
                  slt          t2, a1, s5
                  c.add        sp, s8
                  c.sub        a5, a1
                  and          s7, a5, a7
                  or           a2, a7, sp
                  c.li         a0, 14
                  sll          t2, s7, s3
                  mulhu        s3, s2, s7
                  addi         a1, t1, -1592
                  c.or         a5, a4
                  c.nop
                  ori          a6, t5, 1716
                  c.li         a0, 14
                  rem          sp, t6, tp
                  sra          sp, a2, sp
                  c.lui        s9, 19
                  remu         zero, s2, zero
                  auipc        t1, 195699
                  slti         a0, a4, -1207
                  c.mv         a2, a2
                  c.addi       a2, -1
                  mul          a1, s1, t5
                  nop
                  c.li         a0, 14
                  slti         a0, a4, -1207
                  andi         t6, a4, 389
                  c.nop
                  sltu         s9, a4, a0
                  andi         t6, a4, 389
                  slli         sp, t3, 13
                  c.xor        a3, a5
                  srai         gp, ra, 29
                  c.xor        a3, a5
                  sltu         s9, a4, a0
                  c.mv         a2, a2
                  c.addi4spn   a5, sp, 464
                  mulh         zero, a3, gp
                  c.srai       a4, 2
                  mulhu        s3, s2, s7
                  c.addi       a2, -1
                  rem          sp, t6, tp
                  srl          s5, s7, sp
                  srli         s0, s11, 8
                  c.addi4spn   a5, sp, 464
                  c.addi4spn   a5, sp, 464
                  sub          gp, s1, t2
                  divu         t5, a7, tp
                  divu         t5, a7, tp
                  c.andi       a4, 28
                  sra          sp, a2, sp
                  div          t1, s3, a1
                  divu         t5, a7, tp
                  c.addi       a2, -1
                  xori         a3, s4, 1809
                  mul          a1, s1, t5
                  sll          t2, s7, s3
                  xori         a3, s4, 1809
                  sub          gp, s1, t2
                  xor          s11, s5, a1
                  mulh         zero, a3, gp
                  add          s3, s11, s3
                  nop
                  and          s7, a5, a7
                  remu         zero, s2, zero
                  nop
                  and          s7, a5, a7
                  c.addi16sp   sp, -16
                  xori         a3, s4, 1809
                  c.addi       a2, -1
                  slli         sp, t3, 13
                  sltu         s9, a4, a0
                  xori         a3, s4, 1809
                  slti         a0, a4, -1207
                  remu         zero, s2, zero
                  lui          sp, 776755
                  c.sub        a5, a1
                  andi         t6, a4, 389
                  sra          sp, a2, sp
                  xor          s11, s5, a1
                  divu         t5, a7, tp
                  c.slli       s4, 24
                  mulhu        s3, s2, s7
                  c.addi       a2, -1
                  slli         sp, t3, 13
                  ori          a6, t5, 1716
                  c.lui        s9, 19
                  sub          gp, s1, t2
                  sra          sp, a2, sp
                  c.lui        s9, 19
                  c.nop
                  c.lui        s9, 19
                  c.mv         a2, a2
                  or           a2, a7, sp
                  c.and        a5, a4
                  srli         s0, s11, 8
                  lui          sp, 776755
                  divu         t5, a7, tp
                  remu         zero, s2, zero
                  c.and        a5, a4
                  c.addi4spn   a5, sp, 464
                  divu         t5, a7, tp
                  c.sub        a5, a1
                  mulhsu       s0, a1, t4
                  c.srai       a4, 2
                  sll          t2, s7, s3
                  sra          sp, a2, sp
                  c.sub        a5, a1
                  mul          a1, s1, t5
                  sub          gp, s1, t2
                  divu         t5, a7, tp
                  nop
                  sra          sp, a2, sp
                  add          s3, s11, s3
                  srai         gp, ra, 29
                  srl          s5, s7, sp
                  nop
                  sltu         s9, a4, a0
                  xori         a3, s4, 1809
                  c.andi       a4, 28
                  c.li         a0, 14
                  c.li         a0, 14
                  slli         sp, t3, 13
                  sll          t2, s7, s3
                  mulhu        s3, s2, s7
                  slt          t2, a1, s5
                  srl          s5, s7, sp
                  sub          gp, s1, t2
                  sll          t2, s7, s3
                  srli         s0, s11, 8
                  ori          a6, t5, 1716
                  sltiu        t6, s10, -519
                  c.nop
                  c.srai       a4, 2
                  slli         sp, t3, 13
                  c.nop
                  auipc        t1, 195699
                  c.lui        s9, 19
                  andi         t6, a4, 389
                  nop
                  div          t1, s3, a1
                  slti         a0, a4, -1207
                  c.or         a5, a4
                  slt          t2, a1, s5
                  ori          a6, t5, 1716
                  rem          sp, t6, tp
                  c.srai       a4, 2
                  c.or         a5, a4
                  c.srli       a2, 1
                  add          s3, s11, s3
                  rem          sp, t6, tp
                  xori         a3, s4, 1809
                  ori          a6, t5, 1716
                  srai         gp, ra, 29
                  slt          t2, a1, s5
                  or           a2, a7, sp
                  c.xor        a3, a5
                  c.addi4spn   a5, sp, 464
                  auipc        t1, 195699
                  c.addi       a2, -1
                  mul          a1, s1, t5
                  c.lui        s9, 19
                  srli         s0, s11, 8
                  sltu         s9, a4, a0
                  c.or         a5, a4
                  c.li         a0, 14
                  mul          a1, s1, t5
                  c.srai       a4, 2
                  or           a2, a7, sp
                  addi         a1, t1, -1592
                  c.addi4spn   a5, sp, 464
                  remu         zero, s2, zero
                  slt          t2, a1, s5
                  srli         s0, s11, 8
                  slli         sp, t3, 13
                  add          s3, s11, s3
                  srl          s5, s7, sp
                  c.xor        a3, a5
                  slti         a0, a4, -1207
                  sll          t2, s7, s3
                  c.srli       a2, 1
                  c.andi       a4, 28
                  xori         a3, s4, 1809
                  c.andi       a4, 28
                  addi         a1, t1, -1592
                  srai         gp, ra, 29
                  srl          s5, s7, sp
                  slt          t2, a1, s5
                  add          s3, s11, s3
                  lui          sp, 776755
                  nop
                  c.addi4spn   a5, sp, 464
                  mulhsu       s0, a1, t4
                  mulh         zero, a3, gp
                  c.srli       a2, 1
                  c.srai       a4, 2
                  c.xor        a3, a5
                  divu         t5, a7, tp
                  c.andi       a4, 28
                  andi         t6, a4, 389
                  srl          s5, s7, sp
                  and          s7, a5, a7
                  sltu         s9, a4, a0
                  c.srli       a2, 1
                  c.mv         a2, a2
                  c.addi4spn   a5, sp, 464
                  sll          t2, s7, s3
                  srl          s5, s7, sp
                  lui          sp, 776755
                  sra          sp, a2, sp
                  rem          sp, t6, tp
                  c.srli       a2, 1
                  sltu         s9, a4, a0
                  mulhu        s3, s2, s7
                  addi         a1, t1, -1592
                  c.addi16sp   sp, -16
                  c.or         a5, a4
                  c.xor        a3, a5
                  andi         t6, a4, 389
                  and          s7, a5, a7
                  srai         gp, ra, 29
                  c.srai       a4, 2
                  or           a2, a7, sp
                  slt          t2, a1, s5
                  slti         a0, a4, -1207
                  c.li         a0, 14
                  or           a2, a7, sp
                  slti         a0, a4, -1207
                  mul          a1, s1, t5
                  div          t1, s3, a1
                  sll          t2, s7, s3
                  c.or         a5, a4
                  and          s7, a5, a7
                  and          s7, a5, a7
                  divu         t5, a7, tp
                  sll          t2, s7, s3
                  remu         zero, s2, zero
                  c.slli       s4, 24
                  mulh         zero, a3, gp
                  c.andi       a4, 28
                  c.nop
                  mulh         zero, a3, gp
                  sltiu        t6, s10, -519
                  slt          t2, a1, s5
                  remu         zero, s2, zero
                  rem          sp, t6, tp
                  add          s3, s11, s3
                  ori          a6, t5, 1716
                  c.mv         a2, a2
                  nop
                  add          s3, s11, s3
                  add          s3, s11, s3
                  mul          a1, s1, t5
                  add          s3, s11, s3
                  add          s3, s11, s3
                  c.or         a5, a4
                  srai         gp, ra, 29
                  c.srai       a4, 2
                  auipc        t1, 195699
                  add          s3, s11, s3
                  c.andi       a4, 28
                  mulh         zero, a3, gp
                  c.add        sp, s8
                  slli         sp, t3, 13
                  c.and        a5, a4
                  c.slli       s4, 24
                  nop
                  auipc        t1, 195699
                  srli         s0, s11, 8
                  srl          s5, s7, sp
                  slti         a0, a4, -1207
                  mul          a1, s1, t5
                  andi         t6, a4, 389
                  slt          t2, a1, s5
                  srli         s0, s11, 8
                  c.srli       a2, 1
                  c.lui        s9, 19
                  c.lui        s9, 19
                  mulh         zero, a3, gp
                  sltiu        t6, s10, -519
                  c.xor        a3, a5
                  c.srai       a4, 2
                  slti         a0, a4, -1207
                  c.and        a5, a4
                  nop
                  lui          sp, 776755
                  xor          s11, s5, a1
                  c.andi       a4, 28
                  c.add        sp, s8
                  sll          t2, s7, s3
                  rem          sp, t6, tp
                  srai         gp, ra, 29
                  and          s7, a5, a7
                  c.slli       s4, 24
                  c.sub        a5, a1
                  slti         a0, a4, -1207
                  c.srai       a4, 2
                  c.xor        a3, a5
                  c.li         a0, 14
                  mulh         zero, a3, gp
                  add          s3, s11, s3
                  srl          s5, s7, sp
                  c.li         a0, 14
                  slli         sp, t3, 13
                  mulhsu       s0, a1, t4
                  or           a2, a7, sp
                  ori          a6, t5, 1716
                  slli         sp, t3, 13
                  c.srai       a4, 2
                  mulh         zero, a3, gp
                  sltu         s9, a4, a0
                  slli         sp, t3, 13
                  sltu         s9, a4, a0
                  sra          sp, a2, sp
                  nop
                  mulh         zero, a3, gp
                  c.mv         a2, a2
                  add          s3, s11, s3
                  rem          sp, t6, tp
                  div          t1, s3, a1
                  c.li         a0, 14
                  c.mv         a2, a2
                  div          t1, s3, a1
                  addi         a1, t1, -1592
                  andi         t6, a4, 389
                  c.srli       a2, 1
                  c.and        a5, a4
                  sll          t2, s7, s3
                  srai         gp, ra, 29
                  c.lui        s9, 19
                  nop
                  auipc        t1, 195699
                  c.lui        s9, 19
                  auipc        t1, 195699
                  mulhu        s3, s2, s7
                  sltu         s9, a4, a0
                  sub          gp, s1, t2
                  sll          t2, s7, s3
                  c.srli       a2, 1
                  c.li         a0, 14
                  sll          t2, s7, s3
                  c.andi       a4, 28
                  mulh         zero, a3, gp
                  slti         a0, a4, -1207
                  divu         t5, a7, tp
                  rem          sp, t6, tp
                  rem          sp, t6, tp
                  remu         zero, s2, zero
                  and          s7, a5, a7
                  div          t1, s3, a1
                  mulhsu       s0, a1, t4
                  c.and        a5, a4
                  xori         a3, s4, 1809
                  sra          sp, a2, sp
                  c.add        sp, s8
                  c.slli       s4, 24
                  xor          s11, s5, a1
                  xori         a3, s4, 1809
                  srli         s0, s11, 8
                  mul          a1, s1, t5
                  sub          gp, s1, t2
                  c.li         a0, 14
                  srai         gp, ra, 29
                  sub          gp, s1, t2
                  lui          sp, 776755
                  or           a2, a7, sp
                  c.srli       a2, 1
                  add          s3, s11, s3
                  div          t1, s3, a1
                  xor          s11, s5, a1
                  c.mv         a2, a2
                  c.or         a5, a4
                  c.or         a5, a4
                  xor          s11, s5, a1
                  xor          s11, s5, a1
                  andi         t6, a4, 389
                  slli         sp, t3, 13
                  and          s7, a5, a7
                  c.addi16sp   sp, -16
                  remu         zero, s2, zero
                  li           t5, 0x0 #start riscv_int_numeric_corner_stream_26
                  li           s4, 0x431448d0
                  li           t2, 0xffffffff
                  li           sp, 0xffffffff
                  li           a1, 0xe103dda2
                  li           t1, 0xffffffff
                  li           a7, 0x0
                  li           a6, 0xffffffff
                  li           a0, 0x1411c896
                  li           t3, 0x0
                  auipc        a6, 195699
                  rem          t2, a7, a1
                  auipc        a6, 195699
                  auipc        a6, 195699
                  sub          a0, t5, s4
                  auipc        a6, 195699
                  remu         sp, t2, sp
                  nop
                  addi         t5, a7, -1592
                  mulhu        t1, t2, s4
                  lui          t2, 776755
                  nop
                  addi         t5, a7, -1592
                  sub          a0, t5, s4
                  sub          a0, t5, s4
                  mulhsu       s4, a6, sp
                  remu         sp, t2, sp
                  sub          a0, t5, s4
                  sub          a0, t5, s4
                  mulhsu       s4, a6, sp
                  add          t1, t1, a0
                  lui          t2, 776755
                  rem          t2, a7, a1
                  rem          t2, a7, a1
                  remu         sp, t2, sp
                  mul          t5, t5, a0
                  divu         t1, t1, a1
                  remu         sp, t2, sp
                  mulhu        t1, t2, s4
                  rem          t2, a7, a1 #end riscv_int_numeric_corner_stream_26
                  mulhsu       s0, a1, t4
                  add          s3, s11, s3
                  slti         a0, a4, -1207
                  div          t1, s3, a1
                  remu         zero, s2, zero
                  xori         a3, s4, 1809
                  lui          sp, 776755
                  sll          t2, s7, s3
                  c.andi       a4, 28
                  c.addi16sp   sp, -16
                  c.sub        a5, a1
                  divu         t5, a7, tp
                  c.add        sp, s8
                  c.srai       a4, 2
                  sltiu        t6, s10, -519
                  mul          a1, s1, t5
                  c.andi       a4, 28
                  c.addi16sp   sp, -16
                  c.sub        a5, a1
                  addi         a1, t1, -1592
                  c.srli       a2, 1
                  rem          sp, t6, tp
                  c.lui        s9, 19
                  addi         a1, t1, -1592
                  c.xor        a3, a5
                  c.or         a5, a4
                  srl          s5, s7, sp
                  c.li         a0, 14
                  c.li         a0, 14
                  c.slli       s4, 24
                  c.xor        a3, a5
                  ori          a6, t5, 1716
                  lui          sp, 776755
                  c.and        a5, a4
                  sub          gp, s1, t2
                  c.add        sp, s8
                  c.xor        a3, a5
                  slt          t2, a1, s5
                  auipc        t1, 195699
                  sltu         s9, a4, a0
                  divu         t5, a7, tp
                  c.slli       s4, 24
                  remu         zero, s2, zero
                  c.or         a5, a4
                  c.sub        a5, a1
                  divu         t5, a7, tp
                  sub          gp, s1, t2
                  c.srai       a4, 2
                  andi         t6, a4, 389
                  mul          a1, s1, t5
                  mulhsu       s0, a1, t4
                  rem          sp, t6, tp
                  srai         gp, ra, 29
                  c.and        a5, a4
                  c.srai       a4, 2
                  srl          s5, s7, sp
                  andi         t6, a4, 389
                  sub          gp, s1, t2
                  c.addi       a2, -1
                  xori         a3, s4, 1809
                  c.nop
                  sra          sp, a2, sp
                  xori         a3, s4, 1809
                  lui          sp, 776755
                  and          s7, a5, a7
                  c.addi       a2, -1
                  add          s3, s11, s3
                  div          t1, s3, a1
                  srli         s0, s11, 8
                  c.addi       a2, -1
                  divu         t5, a7, tp
                  c.add        sp, s8
                  add          s3, s11, s3
                  c.srai       a4, 2
                  div          t1, s3, a1
                  mulhu        s3, s2, s7
                  c.addi16sp   sp, -16
                  and          s7, a5, a7
                  c.addi4spn   a5, sp, 464
                  or           a2, a7, sp
                  nop
                  sltiu        t6, s10, -519
                  or           a2, a7, sp
                  c.li         a0, 14
                  mulhsu       s0, a1, t4
                  xor          s11, s5, a1
                  mulh         zero, a3, gp
                  c.srai       a4, 2
                  ori          a6, t5, 1716
                  c.addi       a2, -1
                  c.addi4spn   a5, sp, 464
                  mul          a1, s1, t5
                  c.or         a5, a4
                  slli         sp, t3, 13
                  remu         zero, s2, zero
                  remu         zero, s2, zero
                  c.slli       s4, 24
                  srl          s5, s7, sp
                  c.srli       a2, 1
                  sra          sp, a2, sp
                  nop
                  c.sub        a5, a1
                  div          t1, s3, a1
                  rem          sp, t6, tp
                  ori          a6, t5, 1716
                  c.add        sp, s8
                  c.li         a0, 14
                  c.lui        s9, 19
                  slt          t2, a1, s5
                  addi         a1, t1, -1592
                  sltu         s9, a4, a0
                  mul          a1, s1, t5
                  div          t1, s3, a1
                  sll          t2, s7, s3
                  ori          a6, t5, 1716
                  and          s7, a5, a7
                  c.addi4spn   a5, sp, 464
                  c.and        a5, a4
                  div          t1, s3, a1
                  xor          s11, s5, a1
                  srl          s5, s7, sp
                  c.li         a0, 14
                  divu         t5, a7, tp
                  c.lui        s9, 19
                  mulh         zero, a3, gp
                  remu         zero, s2, zero
                  srl          s5, s7, sp
                  xor          s11, s5, a1
                  c.add        sp, s8
                  sltu         s9, a4, a0
                  sll          t2, s7, s3
                  mulhu        s3, s2, s7
                  slt          t2, a1, s5
                  sra          sp, a2, sp
                  slli         sp, t3, 13
                  mulhsu       s0, a1, t4
                  mulh         zero, a3, gp
                  slli         sp, t3, 13
                  c.li         a0, 14
                  srli         s0, s11, 8
                  sll          t2, s7, s3
                  divu         t5, a7, tp
                  sll          t2, s7, s3
                  or           a2, a7, sp
                  lui          sp, 776755
                  c.add        sp, s8
                  slti         a0, a4, -1207
                  xor          s11, s5, a1
                  c.or         a5, a4
                  sltu         s9, a4, a0
                  c.srli       a2, 1
                  nop
                  and          s7, a5, a7
                  srl          s5, s7, sp
                  c.xor        a3, a5
                  lui          sp, 776755
                  add          s3, s11, s3
                  sltiu        t6, s10, -519
                  c.srli       a2, 1
                  sra          sp, a2, sp
                  mulhu        s3, s2, s7
                  remu         zero, s2, zero
                  srli         s0, s11, 8
                  add          s3, s11, s3
                  c.addi16sp   sp, -16
                  slli         sp, t3, 13
                  srli         s0, s11, 8
                  div          t1, s3, a1
                  mulh         zero, a3, gp
                  sub          gp, s1, t2
                  sltu         s9, a4, a0
                  srai         gp, ra, 29
                  c.nop
                  srl          s5, s7, sp
                  sra          sp, a2, sp
                  divu         t5, a7, tp
                  c.srli       a2, 1
                  c.lui        s9, 19
                  c.nop
                  slti         a0, a4, -1207
                  li           sp, 0xffffffff #start riscv_int_numeric_corner_stream_27
                  li           gp, 0xffffffff
                  li           s11, 0x80000000
                  li           t1, 0xffffffff
                  li           s8, 0xffffffff
                  li           a2, 0xffffffff
                  li           s10, 0x98efdcc5
                  li           t5, 0x80000000
                  li           s9, 0x80000000
                  li           a0, 0x80000000
                  nop
                  div          s8, a0, s9
                  lui          t1, 776755
                  sub          a0, t5, s10
                  remu         sp, t1, sp
                  addi         t5, s9, -1592
                  lui          t1, 776755
                  mulh         sp, a2, a0
                  nop
                  nop
                  nop
                  nop
                  sub          a0, t5, s10
                  nop
                  mul          t5, t5, a0
                  mulh         sp, a2, a0
                  nop
                  sub          a0, t5, s10
                  remu         sp, t1, sp #end riscv_int_numeric_corner_stream_27
                  rem          sp, t6, tp
                  div          t1, s3, a1
                  c.sub        a5, a1
                  add          s3, s11, s3
                  c.sub        a5, a1
                  sltiu        t6, s10, -519
                  slt          t2, a1, s5
                  c.and        a5, a4
                  slt          t2, a1, s5
                  c.nop
                  c.sub        a5, a1
                  c.sub        a5, a1
                  nop
                  slli         sp, t3, 13
                  c.li         a0, 14
                  lui          sp, 776755
                  addi         a1, t1, -1592
                  c.srli       a2, 1
                  divu         t5, a7, tp
                  c.mv         a2, a2
                  slt          t2, a1, s5
                  remu         zero, s2, zero
                  c.srli       a2, 1
                  auipc        t1, 195699
                  lui          sp, 776755
                  ori          a6, t5, 1716
                  c.andi       a4, 28
                  sltu         s9, a4, a0
                  nop
                  c.and        a5, a4
                  lui          sp, 776755
                  auipc        t1, 195699
                  c.addi       a2, -1
                  ori          a6, t5, 1716
                  divu         t5, a7, tp
                  c.nop
                  c.sub        a5, a1
                  c.and        a5, a4
                  sltiu        t6, s10, -519
                  and          s7, a5, a7
                  c.lui        s9, 19
                  sll          t2, s7, s3
                  c.nop
                  or           a2, a7, sp
                  lui          sp, 776755
                  li           s2, 0xffffffff #start riscv_int_numeric_corner_stream_6
                  li           gp, 0x0
                  li           a2, 0xffffffff
                  li           a1, 0x0
                  li           t6, 0x80000000
                  li           t5, 0x128e5c5
                  li           sp, 0x6ee26960
                  li           s8, 0xffffffff
                  li           a3, 0xffffffff
                  li           s3, 0x0
                  add          gp, gp, a2
                  sub          a2, t6, s8
                  addi         t6, s3, -1592
                  div          s2, a2, s3
                  mulh         sp, a3, a2
                  add          gp, gp, a2
                  remu         sp, a1, sp
                  mulhu        gp, a1, s8
                  rem          a1, s3, a3
                  mul          t6, t6, a2
                  divu         gp, gp, a3
                  add          gp, gp, a2
                  remu         sp, a1, sp
                  addi         t6, s3, -1592
                  addi         t6, s3, -1592
                  auipc        s2, 195699
                  add          gp, gp, a2 #end riscv_int_numeric_corner_stream_6
                  sll          t2, s7, s3
                  c.sub        a5, a1
                  sltu         s9, a4, a0
                  or           a2, a7, sp
                  srai         gp, ra, 29
                  c.sub        a5, a1
                  mulh         zero, a3, gp
                  c.add        sp, s8
                  srai         gp, ra, 29
                  c.mv         a2, a2
                  c.xor        a3, a5
                  slli         sp, t3, 13
                  srai         gp, ra, 29
                  lui          sp, 776755
                  xor          s11, s5, a1
                  add          s3, s11, s3
                  c.or         a5, a4
                  c.lui        s9, 19
                  remu         zero, s2, zero
                  c.mv         a2, a2
                  sltu         s9, a4, a0
                  divu         t5, a7, tp
                  mulh         zero, a3, gp
                  auipc        t1, 195699
                  sub          gp, s1, t2
                  addi         a1, t1, -1592
                  c.add        sp, s8
                  c.addi4spn   a5, sp, 464
                  c.slli       s4, 24
                  remu         zero, s2, zero
                  c.li         a0, 14
                  c.addi4spn   a5, sp, 464
                  mulh         zero, a3, gp
                  lui          sp, 776755
                  c.sub        a5, a1
                  srli         s0, s11, 8
                  c.addi       a2, -1
                  c.sub        a5, a1
                  c.li         a0, 14
                  c.li         a0, 14
                  c.addi       a2, -1
                  sub          gp, s1, t2
                  auipc        t1, 195699
                  divu         t5, a7, tp
                  sub          gp, s1, t2
                  c.slli       s4, 24
                  c.li         a0, 14
                  ori          a6, t5, 1716
                  divu         t5, a7, tp
                  remu         zero, s2, zero
                  andi         t6, a4, 389
                  srl          s5, s7, sp
                  xori         a3, s4, 1809
                  c.addi4spn   a5, sp, 464
                  mulhu        s3, s2, s7
                  or           a2, a7, sp
                  mulhsu       s0, a1, t4
                  c.nop
                  srai         gp, ra, 29
                  andi         t6, a4, 389
                  sll          t2, s7, s3
                  c.addi       a2, -1
                  mulhsu       s0, a1, t4
                  xori         a3, s4, 1809
                  c.addi16sp   sp, -16
                  addi         a1, t1, -1592
                  add          s3, s11, s3
                  mul          a1, s1, t5
                  srai         gp, ra, 29
                  c.andi       a4, 28
                  add          s3, s11, s3
                  slt          t2, a1, s5
                  xori         a3, s4, 1809
                  srl          s5, s7, sp
                  c.nop
                  remu         zero, s2, zero
                  slli         sp, t3, 13
                  c.lui        s9, 19
                  mul          a1, s1, t5
                  c.xor        a3, a5
                  srai         gp, ra, 29
                  mul          a1, s1, t5
                  c.addi       a2, -1
                  c.xor        a3, a5
                  andi         t6, a4, 389
                  ori          a6, t5, 1716
                  mulhu        s3, s2, s7
                  mulhsu       s0, a1, t4
                  ori          a6, t5, 1716
                  mul          a1, s1, t5
                  nop
                  c.sub        a5, a1
                  andi         t6, a4, 389
                  c.add        sp, s8
                  c.and        a5, a4
                  mul          a1, s1, t5
                  mulhsu       s0, a1, t4
                  c.lui        s9, 19
                  c.andi       a4, 28
                  c.addi       a2, -1
                  c.li         a0, 14
                  slt          t2, a1, s5
                  c.add        sp, s8
                  mul          a1, s1, t5
                  mulh         zero, a3, gp
                  c.srli       a2, 1
                  andi         t6, a4, 389
                  mulhu        s3, s2, s7
                  divu         t5, a7, tp
                  c.addi4spn   a5, sp, 464
                  c.lui        s9, 19
                  nop
                  c.li         a0, 14
                  rem          sp, t6, tp
                  and          s7, a5, a7
                  nop
                  c.mv         a2, a2
                  srli         s0, s11, 8
                  mul          a1, s1, t5
                  srai         gp, ra, 29
                  rem          sp, t6, tp
                  srli         s0, s11, 8
                  add          s3, s11, s3
                  sltiu        t6, s10, -519
                  c.lui        s9, 19
                  c.srli       a2, 1
                  c.andi       a4, 28
                  div          t1, s3, a1
                  auipc        t1, 195699
                  mulhsu       s0, a1, t4
                  andi         t6, a4, 389
                  sll          t2, s7, s3
                  slti         a0, a4, -1207
                  c.slli       s4, 24
                  c.addi16sp   sp, -16
                  ori          a6, t5, 1716
                  lui          sp, 776755
                  nop
                  remu         zero, s2, zero
                  c.xor        a3, a5
                  addi         a1, t1, -1592
                  c.addi16sp   sp, -16
                  mulhu        s3, s2, s7
                  slli         sp, t3, 13
                  c.addi       a2, -1
                  mulhu        s3, s2, s7
                  c.sub        a5, a1
                  sltu         s9, a4, a0
                  mulh         zero, a3, gp
                  srli         s0, s11, 8
                  c.srli       a2, 1
                  sltiu        t6, s10, -519
                  c.andi       a4, 28
                  add          s3, s11, s3
                  lui          sp, 776755
                  sltu         s9, a4, a0
                  div          t1, s3, a1
                  mul          a1, s1, t5
                  slt          t2, a1, s5
                  c.lui        s9, 19
                  and          s7, a5, a7
                  nop
                  c.mv         a2, a2
                  rem          sp, t6, tp
                  c.srai       a4, 2
                  c.srai       a4, 2
                  remu         zero, s2, zero
                  xor          s11, s5, a1
                  slti         a0, a4, -1207
                  rem          sp, t6, tp
                  c.li         a0, 14
                  c.nop
                  sub          gp, s1, t2
                  auipc        t1, 195699
                  c.xor        a3, a5
                  c.nop
                  sra          sp, a2, sp
                  div          t1, s3, a1
                  sltu         s9, a4, a0
                  rem          sp, t6, tp
                  divu         t5, a7, tp
                  srl          s5, s7, sp
                  xor          s11, s5, a1
                  mulhu        s3, s2, s7
                  remu         zero, s2, zero
                  slt          t2, a1, s5
                  c.srli       a2, 1
                  xor          s11, s5, a1
                  mulhu        s3, s2, s7
                  nop
                  c.or         a5, a4
                  sra          sp, a2, sp
                  sub          gp, s1, t2
                  srli         s0, s11, 8
                  or           a2, a7, sp
                  c.nop
                  addi         a1, t1, -1592
                  c.slli       s4, 24
                  div          t1, s3, a1
                  c.addi16sp   sp, -16
                  c.addi16sp   sp, -16
                  c.li         a0, 14
                  sll          t2, s7, s3
                  c.and        a5, a4
                  c.nop
                  and          s7, a5, a7
                  mulhu        s3, s2, s7
                  c.sub        a5, a1
                  c.srli       a2, 1
                  c.addi16sp   sp, -16
                  srl          s5, s7, sp
                  mulhu        s3, s2, s7
                  and          s7, a5, a7
                  divu         t5, a7, tp
                  nop
                  slt          t2, a1, s5
                  c.srai       a4, 2
                  sltu         s9, a4, a0
                  c.addi16sp   sp, -16
                  slti         a0, a4, -1207
                  c.and        a5, a4
                  rem          sp, t6, tp
                  c.lui        s9, 19
                  srl          s5, s7, sp
                  mul          a1, s1, t5
                  andi         t6, a4, 389
                  c.srli       a2, 1
                  srli         s0, s11, 8
                  c.li         a0, 14
                  c.xor        a3, a5
                  srli         s0, s11, 8
                  addi         a1, t1, -1592
                  and          s7, a5, a7
                  c.addi16sp   sp, -16
                  andi         t6, a4, 389
                  slli         sp, t3, 13
                  c.li         a0, 14
                  mulh         zero, a3, gp
                  srl          s5, s7, sp
                  srl          s5, s7, sp
                  remu         zero, s2, zero
                  sub          gp, s1, t2
                  c.and        a5, a4
                  and          s7, a5, a7
                  c.nop
                  srli         s0, s11, 8
                  c.srli       a2, 1
                  sra          sp, a2, sp
                  xori         a3, s4, 1809
                  div          t1, s3, a1
                  c.add        sp, s8
                  auipc        t1, 195699
                  c.andi       a4, 28
                  c.lui        s9, 19
                  srl          s5, s7, sp
                  c.andi       a4, 28
                  c.li         a0, 14
                  c.lui        s9, 19
                  lui          sp, 776755
                  c.add        sp, s8
                  and          s7, a5, a7
                  c.or         a5, a4
                  divu         t5, a7, tp
                  mul          a1, s1, t5
                  c.or         a5, a4
                  auipc        t1, 195699
                  c.add        sp, s8
                  addi         a1, t1, -1592
                  c.xor        a3, a5
                  sltu         s9, a4, a0
                  sub          gp, s1, t2
                  mulhsu       s0, a1, t4
                  div          t1, s3, a1
                  lui          sp, 776755
                  lui          sp, 776755
                  c.slli       s4, 24
                  c.sub        a5, a1
                  c.and        a5, a4
                  xori         a3, s4, 1809
                  mulhsu       s0, a1, t4
                  sra          sp, a2, sp
                  div          t1, s3, a1
                  srl          s5, s7, sp
                  remu         zero, s2, zero
                  c.add        sp, s8
                  remu         zero, s2, zero
                  c.xor        a3, a5
                  c.mv         a2, a2
                  and          s7, a5, a7
                  c.nop
                  andi         t6, a4, 389
                  remu         zero, s2, zero
                  xor          s11, s5, a1
                  mul          a1, s1, t5
                  and          s7, a5, a7
                  sltiu        t6, s10, -519
                  c.andi       a4, 28
                  c.li         a0, 14
                  c.add        sp, s8
                  add          s3, s11, s3
                  c.add        sp, s8
                  sltiu        t6, s10, -519
                  andi         t6, a4, 389
                  c.addi4spn   a5, sp, 464
                  sll          t2, s7, s3
                  srli         s0, s11, 8
                  remu         zero, s2, zero
                  slli         sp, t3, 13
                  c.nop
                  sll          t2, s7, s3
                  c.sub        a5, a1
                  sltu         s9, a4, a0
                  sra          sp, a2, sp
                  divu         t5, a7, tp
                  nop
                  nop
                  sll          t2, s7, s3
                  andi         t6, a4, 389
                  c.or         a5, a4
                  and          s7, a5, a7
                  andi         t6, a4, 389
                  c.add        sp, s8
                  sub          gp, s1, t2
                  sltu         s9, a4, a0
                  slt          t2, a1, s5
                  c.addi       a2, -1
                  srl          s5, s7, sp
                  c.srai       a4, 2
                  c.and        a5, a4
                  div          t1, s3, a1
                  andi         t6, a4, 389
                  slti         a0, a4, -1207
                  sltiu        t6, s10, -519
                  srl          s5, s7, sp
                  sltu         s9, a4, a0
                  c.nop
                  c.add        sp, s8
                  c.add        sp, s8
                  c.mv         a2, a2
                  srai         gp, ra, 29
                  c.nop
                  sra          sp, a2, sp
                  auipc        t1, 195699
                  slli         sp, t3, 13
                  remu         zero, s2, zero
                  c.li         a0, 14
                  mulhsu       s0, a1, t4
                  mulhsu       s0, a1, t4
                  c.add        sp, s8
                  slti         a0, a4, -1207
                  c.sub        a5, a1
                  addi         a1, t1, -1592
                  xor          s11, s5, a1
                  div          t1, s3, a1
                  c.or         a5, a4
                  srai         gp, ra, 29
                  addi         a1, t1, -1592
                  c.xor        a3, a5
                  xori         a3, s4, 1809
                  or           a2, a7, sp
                  rem          sp, t6, tp
                  mulhu        s3, s2, s7
                  sll          t2, s7, s3
                  srai         gp, ra, 29
                  c.srai       a4, 2
                  auipc        t1, 195699
                  c.addi16sp   sp, -16
                  srli         s0, s11, 8
                  c.xor        a3, a5
                  div          t1, s3, a1
                  xor          s11, s5, a1
                  ori          a6, t5, 1716
                  c.xor        a3, a5
                  slli         sp, t3, 13
                  srai         gp, ra, 29
                  sltu         s9, a4, a0
                  mul          a1, s1, t5
                  and          s7, a5, a7
                  srl          s5, s7, sp
                  c.srai       a4, 2
                  slti         a0, a4, -1207
                  nop
                  xori         a3, s4, 1809
                  c.slli       s4, 24
                  c.and        a5, a4
                  c.and        a5, a4
                  srli         s0, s11, 8
                  auipc        t1, 195699
                  sll          t2, s7, s3
                  or           a2, a7, sp
                  srli         s0, s11, 8
                  and          s7, a5, a7
                  nop
                  and          s7, a5, a7
                  addi         a1, t1, -1592
                  sub          gp, s1, t2
                  c.mv         a2, a2
                  c.srai       a4, 2
                  sra          sp, a2, sp
                  c.srli       a2, 1
                  ori          a6, t5, 1716
                  divu         t5, a7, tp
                  xor          s11, s5, a1
                  addi         a1, t1, -1592
                  c.nop
                  div          t1, s3, a1
                  srli         s0, s11, 8
                  sub          gp, s1, t2
                  sltu         s9, a4, a0
                  sra          sp, a2, sp
                  c.addi4spn   a5, sp, 464
                  c.andi       a4, 28
                  remu         zero, s2, zero
                  mulh         zero, a3, gp
                  mulh         zero, a3, gp
                  c.xor        a3, a5
                  addi         a1, t1, -1592
                  c.addi4spn   a5, sp, 464
                  auipc        t1, 195699
                  andi         t6, a4, 389
                  srli         s0, s11, 8
                  slti         a0, a4, -1207
                  mulhu        s3, s2, s7
                  nop
                  sub          gp, s1, t2
                  and          s7, a5, a7
                  sra          sp, a2, sp
                  sub          gp, s1, t2
                  c.add        sp, s8
                  mulhu        s3, s2, s7
                  c.srli       a2, 1
                  lui          sp, 776755
                  xori         a3, s4, 1809
                  mulhsu       s0, a1, t4
                  c.and        a5, a4
                  lui          sp, 776755
                  lui          sp, 776755
                  slli         sp, t3, 13
                  lui          sp, 776755
                  srl          s5, s7, sp
                  remu         zero, s2, zero
                  srli         s0, s11, 8
                  c.slli       s4, 24
                  divu         t5, a7, tp
                  mulh         zero, a3, gp
                  srli         s0, s11, 8
                  addi         a1, t1, -1592
                  mul          a1, s1, t5
                  sltu         s9, a4, a0
                  auipc        t1, 195699
                  c.srai       a4, 2
                  mul          a1, s1, t5
                  c.addi16sp   sp, -16
                  addi         a1, t1, -1592
                  and          s7, a5, a7
                  srli         s0, s11, 8
                  c.and        a5, a4
                  mulh         zero, a3, gp
                  ori          a6, t5, 1716
                  and          s7, a5, a7
                  auipc        t1, 195699
                  add          s3, s11, s3
                  c.sub        a5, a1
                  sll          t2, s7, s3
                  remu         zero, s2, zero
                  divu         t5, a7, tp
                  mul          a1, s1, t5
                  add          s3, s11, s3
                  c.addi4spn   a5, sp, 464
                  xor          s11, s5, a1
                  add          s3, s11, s3
                  div          t1, s3, a1
                  c.or         a5, a4
                  mul          a1, s1, t5
                  c.srai       a4, 2
                  lui          sp, 776755
                  c.and        a5, a4
                  c.addi4spn   a5, sp, 464
                  c.andi       a4, 28
                  divu         t5, a7, tp
                  auipc        t1, 195699
                  nop
                  c.add        sp, s8
                  c.nop
                  sll          t2, s7, s3
                  c.li         a0, 14
                  andi         t6, a4, 389
                  xori         a3, s4, 1809
                  mulhu        s3, s2, s7
                  xor          s11, s5, a1
                  nop
                  nop
                  c.mv         a2, a2
                  lui          sp, 776755
                  nop
                  c.mv         a2, a2
                  mulhsu       s0, a1, t4
                  sltiu        t6, s10, -519
                  slli         sp, t3, 13
                  c.or         a5, a4
                  xori         a3, s4, 1809
                  remu         zero, s2, zero
                  andi         t6, a4, 389
                  c.addi       a2, -1
                  ori          a6, t5, 1716
                  nop
                  nop
                  c.srai       a4, 2
                  c.li         a0, 14
                  c.andi       a4, 28
                  mulh         zero, a3, gp
                  nop
                  sub          gp, s1, t2
                  xori         a3, s4, 1809
                  divu         t5, a7, tp
                  sll          t2, s7, s3
                  and          s7, a5, a7
                  div          t1, s3, a1
                  c.addi4spn   a5, sp, 464
                  c.srai       a4, 2
                  rem          sp, t6, tp
                  c.srai       a4, 2
                  lui          sp, 776755
                  remu         zero, s2, zero
                  sltiu        t6, s10, -519
                  sll          t2, s7, s3
                  xori         a3, s4, 1809
                  mul          a1, s1, t5
                  divu         t5, a7, tp
                  slti         a0, a4, -1207
                  rem          sp, t6, tp
                  remu         zero, s2, zero
                  srai         gp, ra, 29
                  slli         sp, t3, 13
                  c.or         a5, a4
                  xor          s11, s5, a1
                  c.addi       a2, -1
                  c.addi       a2, -1
                  sll          t2, s7, s3
                  mulhu        s3, s2, s7
                  c.srai       a4, 2
                  c.xor        a3, a5
                  mul          a1, s1, t5
                  srai         gp, ra, 29
                  c.add        sp, s8
                  andi         t6, a4, 389
                  lui          sp, 776755
                  nop
                  sub          gp, s1, t2
                  mulhu        s3, s2, s7
                  c.add        sp, s8
                  sltu         s9, a4, a0
                  sub          gp, s1, t2
                  c.srli       a2, 1
                  c.and        a5, a4
                  c.sub        a5, a1
                  add          s3, s11, s3
                  sltiu        t6, s10, -519
                  div          t1, s3, a1
                  c.srli       a2, 1
                  andi         t6, a4, 389
                  rem          sp, t6, tp
                  mulhu        s3, s2, s7
                  sra          sp, a2, sp
                  mul          a1, s1, t5
                  slti         a0, a4, -1207
                  remu         zero, s2, zero
                  sra          sp, a2, sp
                  lui          sp, 776755
                  srai         gp, ra, 29
                  xor          s11, s5, a1
                  c.xor        a3, a5
                  c.sub        a5, a1
                  c.and        a5, a4
                  c.srai       a4, 2
                  lui          sp, 776755
                  c.addi16sp   sp, -16
                  or           a2, a7, sp
                  c.and        a5, a4
                  c.lui        s9, 19
                  c.sub        a5, a1
                  c.addi       a2, -1
                  lui          sp, 776755
                  lui          sp, 776755
                  sra          sp, a2, sp
                  mulh         zero, a3, gp
                  and          s7, a5, a7
                  sra          sp, a2, sp
                  sltiu        t6, s10, -519
                  mulhsu       s0, a1, t4
                  divu         t5, a7, tp
                  c.lui        s9, 19
                  addi         a1, t1, -1592
                  c.addi       a2, -1
                  rem          sp, t6, tp
                  c.addi16sp   sp, -16
                  rem          sp, t6, tp
                  ori          a6, t5, 1716
                  remu         zero, s2, zero
                  c.addi4spn   a5, sp, 464
                  remu         zero, s2, zero
                  xor          s11, s5, a1
                  auipc        t1, 195699
                  sltiu        t6, s10, -519
                  mulhsu       s0, a1, t4
                  c.add        sp, s8
                  mul          a1, s1, t5
                  mul          a1, s1, t5
                  c.nop
                  andi         t6, a4, 389
                  c.lui        s9, 19
                  c.xor        a3, a5
                  remu         zero, s2, zero
                  or           a2, a7, sp
                  c.andi       a4, 28
                  c.slli       s4, 24
                  c.or         a5, a4
                  c.addi4spn   a5, sp, 464
                  andi         t6, a4, 389
                  c.and        a5, a4
                  c.nop
                  c.addi4spn   a5, sp, 464
                  srai         gp, ra, 29
                  div          t1, s3, a1
                  or           a2, a7, sp
                  c.addi4spn   a5, sp, 464
                  c.xor        a3, a5
                  addi         a1, t1, -1592
                  addi         a1, t1, -1592
                  c.srai       a4, 2
                  xor          s11, s5, a1
                  mul          a1, s1, t5
                  or           a2, a7, sp
                  sltiu        t6, s10, -519
                  c.addi16sp   sp, -16
                  sra          sp, a2, sp
                  c.add        sp, s8
                  remu         zero, s2, zero
                  sltiu        t6, s10, -519
                  auipc        t1, 195699
                  ori          a6, t5, 1716
                  sltu         s9, a4, a0
                  c.slli       s4, 24
                  c.add        sp, s8
                  and          s7, a5, a7
                  mulhsu       s0, a1, t4
                  c.andi       a4, 28
                  slt          t2, a1, s5
                  srl          s5, s7, sp
                  andi         t6, a4, 389
                  slli         sp, t3, 13
                  divu         t5, a7, tp
                  c.mv         a2, a2
                  mulhsu       s0, a1, t4
                  addi         a1, t1, -1592
                  sltu         s9, a4, a0
                  slli         sp, t3, 13
                  c.srli       a2, 1
                  c.mv         a2, a2
                  c.srai       a4, 2
                  sll          t2, s7, s3
                  sub          gp, s1, t2
                  c.slli       s4, 24
                  div          t1, s3, a1
                  xori         a3, s4, 1809
                  nop
                  sltiu        t6, s10, -519
                  add          s3, s11, s3
                  divu         t5, a7, tp
                  slli         sp, t3, 13
                  c.andi       a4, 28
                  c.addi       a2, -1
                  c.nop
                  slt          t2, a1, s5
                  addi         a1, t1, -1592
                  c.or         a5, a4
                  mulh         zero, a3, gp
                  c.or         a5, a4
                  c.xor        a3, a5
                  nop
                  auipc        t1, 195699
                  c.mv         a2, a2
                  xor          s11, s5, a1
                  mulhu        s3, s2, s7
                  slli         sp, t3, 13
                  mulh         zero, a3, gp
                  mulh         zero, a3, gp
                  c.lui        s9, 19
                  c.addi16sp   sp, -16
                  c.add        sp, s8
                  divu         t5, a7, tp
                  and          s7, a5, a7
                  auipc        t1, 195699
                  sub          gp, s1, t2
                  c.addi4spn   a5, sp, 464
                  c.lui        s9, 19
                  c.slli       s4, 24
                  andi         t6, a4, 389
                  sltu         s9, a4, a0
                  sra          sp, a2, sp
                  mulh         zero, a3, gp
                  xori         a3, s4, 1809
                  srl          s5, s7, sp
                  sltu         s9, a4, a0
                  sltiu        t6, s10, -519
                  addi         a1, t1, -1592
                  slti         a0, a4, -1207
                  c.and        a5, a4
                  c.xor        a3, a5
                  mul          a1, s1, t5
                  srl          s5, s7, sp
                  c.srai       a4, 2
                  div          t1, s3, a1
                  div          t1, s3, a1
                  remu         zero, s2, zero
                  xor          s11, s5, a1
                  sub          gp, s1, t2
                  c.add        sp, s8
                  c.srli       a2, 1
                  addi         a1, t1, -1592
                  andi         t6, a4, 389
                  c.li         a0, 14
                  srai         gp, ra, 29
                  xor          s11, s5, a1
                  c.addi16sp   sp, -16
                  sra          sp, a2, sp
                  mul          a1, s1, t5
                  xor          s11, s5, a1
                  and          s7, a5, a7
                  sll          t2, s7, s3
                  andi         t6, a4, 389
                  slt          t2, a1, s5
                  c.lui        s9, 19
                  mulh         zero, a3, gp
                  srl          s5, s7, sp
                  c.li         a0, 14
                  xori         a3, s4, 1809
                  c.and        a5, a4
                  c.add        sp, s8
                  xor          s11, s5, a1
                  srai         gp, ra, 29
                  rem          sp, t6, tp
                  c.addi       a2, -1
                  remu         zero, s2, zero
                  mulh         zero, a3, gp
                  rem          sp, t6, tp
                  c.mv         a2, a2
                  sltu         s9, a4, a0
                  divu         t5, a7, tp
                  sltu         s9, a4, a0
                  and          s7, a5, a7
                  srli         s0, s11, 8
                  sub          gp, s1, t2
                  c.andi       a4, 28
                  sra          sp, a2, sp
                  srl          s5, s7, sp
                  andi         t6, a4, 389
                  c.sub        a5, a1
                  slt          t2, a1, s5
                  mul          a1, s1, t5
                  rem          sp, t6, tp
                  andi         t6, a4, 389
                  c.sub        a5, a1
                  nop
                  addi         a1, t1, -1592
                  c.li         a0, 14
                  c.or         a5, a4
                  sltiu        t6, s10, -519
                  nop
                  srl          s5, s7, sp
                  c.addi4spn   a5, sp, 464
                  c.andi       a4, 28
                  srl          s5, s7, sp
                  slti         a0, a4, -1207
                  c.addi16sp   sp, -16
                  slt          t2, a1, s5
                  c.or         a5, a4
                  sltiu        t6, s10, -519
                  c.addi4spn   a5, sp, 464
                  rem          sp, t6, tp
                  c.add        sp, s8
                  xor          s11, s5, a1
                  sltu         s9, a4, a0
                  c.slli       s4, 24
                  and          s7, a5, a7
                  nop
                  c.add        sp, s8
                  ori          a6, t5, 1716
                  c.addi16sp   sp, -16
                  sub          gp, s1, t2
                  c.and        a5, a4
                  rem          sp, t6, tp
                  ori          a6, t5, 1716
                  c.nop
                  c.sub        a5, a1
                  auipc        t1, 195699
                  nop
                  and          s7, a5, a7
                  slli         sp, t3, 13
                  srai         gp, ra, 29
                  div          t1, s3, a1
                  c.slli       s4, 24
                  mul          a1, s1, t5
                  sub          gp, s1, t2
                  rem          sp, t6, tp
                  xori         a3, s4, 1809
                  slt          t2, a1, s5
                  remu         zero, s2, zero
                  c.srli       a2, 1
                  c.or         a5, a4
                  ori          a6, t5, 1716
                  c.sub        a5, a1
                  or           a2, a7, sp
                  c.sub        a5, a1
                  c.lui        s9, 19
                  c.addi       a2, -1
                  c.li         a0, 14
                  c.sub        a5, a1
                  c.nop
                  andi         t6, a4, 389
                  c.sub        a5, a1
                  sltiu        t6, s10, -519
                  c.addi4spn   a5, sp, 464
                  and          s7, a5, a7
                  divu         t5, a7, tp
                  srl          s5, s7, sp
                  c.or         a5, a4
                  sltiu        t6, s10, -519
                  c.xor        a3, a5
                  nop
                  and          s7, a5, a7
                  mulh         zero, a3, gp
                  c.and        a5, a4
                  sltu         s9, a4, a0
                  srai         gp, ra, 29
                  c.lui        s9, 19
                  remu         zero, s2, zero
                  remu         zero, s2, zero
                  c.or         a5, a4
                  and          s7, a5, a7
                  c.nop
                  c.addi4spn   a5, sp, 464
                  sub          gp, s1, t2
                  xor          s11, s5, a1
                  sra          sp, a2, sp
                  nop
                  or           a2, a7, sp
                  remu         zero, s2, zero
                  c.or         a5, a4
                  c.li         a0, 14
                  c.srli       a2, 1
                  sltiu        t6, s10, -519
                  div          t1, s3, a1
                  srli         s0, s11, 8
                  c.or         a5, a4
                  c.slli       s4, 24
                  mulhu        s3, s2, s7
                  xori         a3, s4, 1809
                  sltiu        t6, s10, -519
                  andi         t6, a4, 389
                  mulhsu       s0, a1, t4
                  c.and        a5, a4
                  c.and        a5, a4
                  nop
                  slli         sp, t3, 13
                  c.addi16sp   sp, -16
                  xor          s11, s5, a1
                  andi         t6, a4, 389
                  mulhu        s3, s2, s7
                  c.or         a5, a4
                  c.xor        a3, a5
                  c.lui        s9, 19
                  addi         a1, t1, -1592
                  srai         gp, ra, 29
                  sltu         s9, a4, a0
                  add          s3, s11, s3
                  ori          a6, t5, 1716
                  xor          s11, s5, a1
                  c.addi       a2, -1
                  slli         sp, t3, 13
                  c.lui        s9, 19
                  mulhsu       s0, a1, t4
                  mulhu        s3, s2, s7
                  and          s7, a5, a7
                  addi         a1, t1, -1592
                  c.li         a0, 14
                  xor          s11, s5, a1
                  sra          sp, a2, sp
                  sltu         s9, a4, a0
                  srai         gp, ra, 29
                  slli         sp, t3, 13
                  lui          sp, 776755
                  nop
                  slt          t2, a1, s5
                  div          t1, s3, a1
                  sub          gp, s1, t2
                  auipc        t1, 195699
                  sll          t2, s7, s3
                  c.sub        a5, a1
                  c.lui        s9, 19
                  c.or         a5, a4
                  sltu         s9, a4, a0
                  c.srli       a2, 1
                  xori         a3, s4, 1809
                  xori         a3, s4, 1809
                  c.addi       a2, -1
                  c.addi       a2, -1
                  srli         s0, s11, 8
                  c.lui        s9, 19
                  c.nop
                  or           a2, a7, sp
                  c.or         a5, a4
                  slt          t2, a1, s5
                  c.slli       s4, 24
                  mul          a1, s1, t5
                  srai         gp, ra, 29
                  nop
                  c.srli       a2, 1
                  srli         s0, s11, 8
                  mul          a1, s1, t5
                  c.slli       s4, 24
                  c.xor        a3, a5
                  slt          t2, a1, s5
                  or           a2, a7, sp
                  c.slli       s4, 24
                  add          s3, s11, s3
                  slli         sp, t3, 13
                  add          s3, s11, s3
                  xor          s11, s5, a1
                  c.sub        a5, a1
                  slti         a0, a4, -1207
                  c.xor        a3, a5
                  auipc        t1, 195699
                  c.addi4spn   a5, sp, 464
                  or           a2, a7, sp
                  srai         gp, ra, 29
                  srl          s5, s7, sp
                  c.lui        s9, 19
                  divu         t5, a7, tp
                  li           t2, 0x0 #start riscv_int_numeric_corner_stream_18
                  li           s10, 0x80000000
                  li           ra, 0x0
                  li           a5, 0x0
                  li           s5, 0x0
                  li           s4, 0xffffffff
                  li           a3, 0x0
                  li           s8, 0x0
                  li           s3, 0xc8db3854
                  li           s9, 0x80000000
                  mulhsu       s8, s4, ra
                  lui          a3, 776755
                  rem          a3, s5, s3
                  divu         t2, t2, s3
                  addi         s10, s5, -1592
                  add          t2, t2, a5
                  mulhsu       s8, s4, ra
                  remu         ra, a3, ra
                  rem          a3, s5, s3
                  mulh         ra, s3, a5
                  divu         t2, t2, s3
                  divu         t2, t2, s3
                  rem          a3, s5, s3
                  lui          a3, 776755
                  mulhu        t2, a3, s8 #end riscv_int_numeric_corner_stream_18
                  mulh         zero, a3, gp
                  nop
                  lui          sp, 776755
                  sub          gp, s1, t2
                  c.xor        a3, a5
                  remu         zero, s2, zero
                  mulh         zero, a3, gp
                  mul          a1, s1, t5
                  c.srli       a2, 1
                  srai         gp, ra, 29
                  slti         a0, a4, -1207
                  c.srli       a2, 1
                  slti         a0, a4, -1207
                  auipc        t1, 195699
                  c.li         a0, 14
                  div          t1, s3, a1
                  c.slli       s4, 24
                  xori         a3, s4, 1809
                  srl          s5, s7, sp
                  c.mv         a2, a2
                  srl          s5, s7, sp
                  divu         t5, a7, tp
                  c.or         a5, a4
                  and          s7, a5, a7
                  ori          a6, t5, 1716
                  c.xor        a3, a5
                  sltu         s9, a4, a0
                  div          t1, s3, a1
                  srli         s0, s11, 8
                  c.addi4spn   a5, sp, 464
                  mulhu        s3, s2, s7
                  remu         zero, s2, zero
                  c.addi4spn   a5, sp, 464
                  c.andi       a4, 28
                  mul          a1, s1, t5
                  add          s3, s11, s3
                  sub          gp, s1, t2
                  slti         a0, a4, -1207
                  c.and        a5, a4
                  c.nop
                  addi         a1, t1, -1592
                  slt          t2, a1, s5
                  slt          t2, a1, s5
                  c.srli       a2, 1
                  div          t1, s3, a1
                  divu         t5, a7, tp
                  c.andi       a4, 28
                  c.and        a5, a4
                  c.andi       a4, 28
                  c.xor        a3, a5
                  slt          t2, a1, s5
                  andi         t6, a4, 389
                  slt          t2, a1, s5
                  c.addi       a2, -1
                  c.addi16sp   sp, -16
                  mulh         zero, a3, gp
                  sub          gp, s1, t2
                  c.or         a5, a4
                  c.lui        s9, 19
                  c.addi       a2, -1
                  c.lui        s9, 19
                  c.li         a0, 14
                  nop
                  c.slli       s4, 24
                  div          t1, s3, a1
                  c.addi4spn   a5, sp, 464
                  rem          sp, t6, tp
                  and          s7, a5, a7
                  c.addi16sp   sp, -16
                  sll          t2, s7, s3
                  c.addi       a2, -1
                  mulhu        s3, s2, s7
                  c.add        sp, s8
                  c.addi4spn   a5, sp, 464
                  srai         gp, ra, 29
                  c.srli       a2, 1
                  sra          sp, a2, sp
                  slli         sp, t3, 13
                  c.andi       a4, 28
                  c.or         a5, a4
                  c.addi4spn   a5, sp, 464
                  srl          s5, s7, sp
                  auipc        t1, 195699
                  c.lui        s9, 19
                  andi         t6, a4, 389
                  xor          s11, s5, a1
                  or           a2, a7, sp
                  c.and        a5, a4
                  sra          sp, a2, sp
                  ori          a6, t5, 1716
                  nop
                  nop
                  div          t1, s3, a1
                  addi         a1, t1, -1592
                  sll          t2, s7, s3
                  c.lui        s9, 19
                  lui          sp, 776755
                  c.add        sp, s8
                  div          t1, s3, a1
                  c.li         a0, 14
                  c.andi       a4, 28
                  add          s3, s11, s3
                  sra          sp, a2, sp
                  c.add        sp, s8
                  sll          t2, s7, s3
                  divu         t5, a7, tp
                  srai         gp, ra, 29
                  c.sub        a5, a1
                  mulh         zero, a3, gp
                  c.srai       a4, 2
                  remu         zero, s2, zero
                  xor          s11, s5, a1
                  c.li         a0, 14
                  or           a2, a7, sp
                  divu         t5, a7, tp
                  slti         a0, a4, -1207
                  c.add        sp, s8
                  sltiu        t6, s10, -519
                  mulhu        s3, s2, s7
                  srli         s0, s11, 8
                  xor          s11, s5, a1
                  rem          sp, t6, tp
                  c.andi       a4, 28
                  c.andi       a4, 28
                  c.mv         a2, a2
                  andi         t6, a4, 389
                  sra          sp, a2, sp
                  xori         a3, s4, 1809
                  sltiu        t6, s10, -519
                  rem          sp, t6, tp
                  slti         a0, a4, -1207
                  xor          s11, s5, a1
                  mulhu        s3, s2, s7
                  sltu         s9, a4, a0
                  slli         sp, t3, 13
                  c.nop
                  c.srli       a2, 1
                  c.addi16sp   sp, -16
                  mul          a1, s1, t5
                  c.addi16sp   sp, -16
                  c.slli       s4, 24
                  slli         sp, t3, 13
                  c.and        a5, a4
                  mul          a1, s1, t5
                  c.lui        s9, 19
                  sltu         s9, a4, a0
                  sub          gp, s1, t2
                  srl          s5, s7, sp
                  sltu         s9, a4, a0
                  c.sub        a5, a1
                  slt          t2, a1, s5
                  divu         t5, a7, tp
                  c.addi16sp   sp, -16
                  c.nop
                  slti         a0, a4, -1207
                  sltiu        t6, s10, -519
                  or           a2, a7, sp
                  xor          s11, s5, a1
                  c.andi       a4, 28
                  sra          sp, a2, sp
                  or           a2, a7, sp
                  xori         a3, s4, 1809
                  c.srli       a2, 1
                  c.or         a5, a4
                  mulhsu       s0, a1, t4
                  addi         a1, t1, -1592
                  srl          s5, s7, sp
                  c.xor        a3, a5
                  sltiu        t6, s10, -519
                  remu         zero, s2, zero
                  xori         a3, s4, 1809
                  c.lui        s9, 19
                  srl          s5, s7, sp
                  slt          t2, a1, s5
                  c.li         a0, 14
                  srl          s5, s7, sp
                  div          t1, s3, a1
                  xori         a3, s4, 1809
                  slt          t2, a1, s5
                  c.and        a5, a4
                  andi         t6, a4, 389
                  xori         a3, s4, 1809
                  sra          sp, a2, sp
                  remu         zero, s2, zero
                  xor          s11, s5, a1
                  c.add        sp, s8
                  c.or         a5, a4
                  sra          sp, a2, sp
                  c.or         a5, a4
                  div          t1, s3, a1
                  mulhu        s3, s2, s7
                  c.slli       s4, 24
                  c.slli       s4, 24
                  srli         s0, s11, 8
                  c.and        a5, a4
                  ori          a6, t5, 1716
                  sltiu        t6, s10, -519
                  c.or         a5, a4
                  c.xor        a3, a5
                  srl          s5, s7, sp
                  div          t1, s3, a1
                  c.addi16sp   sp, -16
                  c.lui        s9, 19
                  c.li         a0, 14
                  and          s7, a5, a7
                  c.addi       a2, -1
                  sltu         s9, a4, a0
                  addi         a1, t1, -1592
                  sltu         s9, a4, a0
                  nop
                  c.addi16sp   sp, -16
                  c.andi       a4, 28
                  add          s3, s11, s3
                  c.mv         a2, a2
                  add          s3, s11, s3
                  c.and        a5, a4
                  mulhsu       s0, a1, t4
                  c.addi       a2, -1
                  c.xor        a3, a5
                  c.mv         a2, a2
                  addi         a1, t1, -1592
                  mulhu        s3, s2, s7
                  c.mv         a2, a2
                  c.addi       a2, -1
                  divu         t5, a7, tp
                  srai         gp, ra, 29
                  c.andi       a4, 28
                  or           a2, a7, sp
                  addi         a1, t1, -1592
                  c.andi       a4, 28
                  and          s7, a5, a7
                  mulhu        s3, s2, s7
                  divu         t5, a7, tp
                  c.and        a5, a4
                  mulhsu       s0, a1, t4
                  c.mv         a2, a2
                  mulhsu       s0, a1, t4
                  or           a2, a7, sp
                  sub          gp, s1, t2
                  mulhu        s3, s2, s7
                  c.mv         a2, a2
                  and          s7, a5, a7
                  sltu         s9, a4, a0
                  c.li         a0, 14
                  slti         a0, a4, -1207
                  sltiu        t6, s10, -519
                  c.nop
                  c.addi       a2, -1
                  c.li         a0, 14
                  c.srli       a2, 1
                  mulh         zero, a3, gp
                  c.addi16sp   sp, -16
                  c.nop
                  sltu         s9, a4, a0
                  c.li         a0, 14
                  c.li         a0, 14
                  sra          sp, a2, sp
                  div          t1, s3, a1
                  sub          gp, s1, t2
                  sub          gp, s1, t2
                  mulhsu       s0, a1, t4
                  c.xor        a3, a5
                  add          s3, s11, s3
                  xori         a3, s4, 1809
                  lui          sp, 776755
                  andi         t6, a4, 389
                  auipc        t1, 195699
                  mul          a1, s1, t5
                  sra          sp, a2, sp
                  c.slli       s4, 24
                  slti         a0, a4, -1207
                  andi         t6, a4, 389
                  c.li         a0, 14
                  nop
                  c.xor        a3, a5
                  or           a2, a7, sp
                  xor          s11, s5, a1
                  c.sub        a5, a1
                  sltiu        t6, s10, -519
                  sll          t2, s7, s3
                  or           a2, a7, sp
                  rem          sp, t6, tp
                  andi         t6, a4, 389
                  srl          s5, s7, sp
                  and          s7, a5, a7
                  slli         sp, t3, 13
                  sub          gp, s1, t2
                  sub          gp, s1, t2
                  mul          a1, s1, t5
                  sltu         s9, a4, a0
                  c.addi4spn   a5, sp, 464
                  andi         t6, a4, 389
                  mulhu        s3, s2, s7
                  auipc        t1, 195699
                  auipc        t1, 195699
                  c.lui        s9, 19
                  sltu         s9, a4, a0
                  mul          a1, s1, t5
                  andi         t6, a4, 389
                  div          t1, s3, a1
                  or           a2, a7, sp
                  c.srai       a4, 2
                  c.addi4spn   a5, sp, 464
                  nop
                  or           a2, a7, sp
                  c.srai       a4, 2
                  c.addi       a2, -1
                  or           a2, a7, sp
                  xor          s11, s5, a1
                  c.srai       a4, 2
                  mul          a1, s1, t5
                  xor          s11, s5, a1
                  sltu         s9, a4, a0
                  divu         t5, a7, tp
                  sub          gp, s1, t2
                  ori          a6, t5, 1716
                  add          s3, s11, s3
                  rem          sp, t6, tp
                  sltu         s9, a4, a0
                  srai         gp, ra, 29
                  sltiu        t6, s10, -519
                  xori         a3, s4, 1809
                  c.addi4spn   a5, sp, 464
                  div          t1, s3, a1
                  c.li         a0, 14
                  c.li         a0, 14
                  sltu         s9, a4, a0
                  c.xor        a3, a5
                  and          s7, a5, a7
                  xor          s11, s5, a1
                  c.sub        a5, a1
                  div          t1, s3, a1
                  mulhu        s3, s2, s7
                  nop
                  c.addi16sp   sp, -16
                  mulhsu       s0, a1, t4
                  mul          a1, s1, t5
                  nop
                  nop
                  mulh         zero, a3, gp
                  c.addi4spn   a5, sp, 464
                  xor          s11, s5, a1
                  c.addi16sp   sp, -16
                  nop
                  or           a2, a7, sp
                  c.mv         a2, a2
                  xor          s11, s5, a1
                  auipc        t1, 195699
                  xor          s11, s5, a1
                  c.addi4spn   a5, sp, 464
                  auipc        t1, 195699
                  srli         s0, s11, 8
                  add          s3, s11, s3
                  srai         gp, ra, 29
                  slti         a0, a4, -1207
                  srl          s5, s7, sp
                  or           a2, a7, sp
                  nop
                  xor          s11, s5, a1
                  sra          sp, a2, sp
                  c.addi16sp   sp, -16
                  ori          a6, t5, 1716
                  andi         t6, a4, 389
                  and          s7, a5, a7
                  c.nop
                  nop
                  nop
                  andi         t6, a4, 389
                  mul          a1, s1, t5
                  nop
                  or           a2, a7, sp
                  c.addi       a2, -1
                  xori         a3, s4, 1809
                  slti         a0, a4, -1207
                  c.addi4spn   a5, sp, 464
                  andi         t6, a4, 389
                  c.nop
                  c.andi       a4, 28
                  c.addi4spn   a5, sp, 464
                  and          s7, a5, a7
                  c.mv         a2, a2
                  c.srai       a4, 2
                  sll          t2, s7, s3
                  divu         t5, a7, tp
                  srli         s0, s11, 8
                  c.slli       s4, 24
                  andi         t6, a4, 389
                  c.srai       a4, 2
                  c.li         a0, 14
                  auipc        t1, 195699
                  rem          sp, t6, tp
                  mulh         zero, a3, gp
                  andi         t6, a4, 389
                  add          s3, s11, s3
                  c.and        a5, a4
                  c.slli       s4, 24
                  mul          a1, s1, t5
                  and          s7, a5, a7
                  c.srli       a2, 1
                  slli         sp, t3, 13
                  xori         a3, s4, 1809
                  c.or         a5, a4
                  mulh         zero, a3, gp
                  xori         a3, s4, 1809
                  c.sub        a5, a1
                  add          s3, s11, s3
                  c.nop
                  c.srli       a2, 1
                  c.slli       s4, 24
                  and          s7, a5, a7
                  c.slli       s4, 24
                  sra          sp, a2, sp
                  mul          a1, s1, t5
                  add          s3, s11, s3
                  xori         a3, s4, 1809
                  srli         s0, s11, 8
                  div          t1, s3, a1
                  slti         a0, a4, -1207
                  remu         zero, s2, zero
                  c.li         a0, 14
                  ori          a6, t5, 1716
                  srl          s5, s7, sp
                  srli         s0, s11, 8
                  c.addi4spn   a5, sp, 464
                  xori         a3, s4, 1809
                  c.nop
                  c.slli       s4, 24
                  c.add        sp, s8
                  c.mv         a2, a2
                  mulh         zero, a3, gp
                  rem          sp, t6, tp
                  mulhu        s3, s2, s7
                  c.xor        a3, a5
                  srl          s5, s7, sp
                  remu         zero, s2, zero
                  mulhu        s3, s2, s7
                  sltiu        t6, s10, -519
                  lui          sp, 776755
                  c.andi       a4, 28
                  slti         a0, a4, -1207
                  sll          t2, s7, s3
                  srai         gp, ra, 29
                  srl          s5, s7, sp
                  srai         gp, ra, 29
                  c.add        sp, s8
                  c.srai       a4, 2
                  c.li         a0, 14
                  lui          sp, 776755
                  c.srli       a2, 1
                  divu         t5, a7, tp
                  srl          s5, s7, sp
                  and          s7, a5, a7
                  c.nop
                  mul          a1, s1, t5
                  sra          sp, a2, sp
                  c.slli       s4, 24
                  c.addi       a2, -1
                  c.addi16sp   sp, -16
                  slt          t2, a1, s5
                  sll          t2, s7, s3
                  c.srai       a4, 2
                  c.or         a5, a4
                  sra          sp, a2, sp
                  andi         t6, a4, 389
                  c.srli       a2, 1
                  c.xor        a3, a5
                  srl          s5, s7, sp
                  c.addi16sp   sp, -16
                  lui          sp, 776755
                  mul          a1, s1, t5
                  auipc        t1, 195699
                  and          s7, a5, a7
                  mulhsu       s0, a1, t4
                  auipc        t1, 195699
                  c.add        sp, s8
                  sll          t2, s7, s3
                  sub          gp, s1, t2
                  remu         zero, s2, zero
                  c.li         a0, 14
                  srl          s5, s7, sp
                  srli         s0, s11, 8
                  nop
                  c.addi16sp   sp, -16
                  mul          a1, s1, t5
                  or           a2, a7, sp
                  c.mv         a2, a2
                  sltiu        t6, s10, -519
                  auipc        t1, 195699
                  div          t1, s3, a1
                  xori         a3, s4, 1809
                  div          t1, s3, a1
                  mulhu        s3, s2, s7
                  mulhsu       s0, a1, t4
                  andi         t6, a4, 389
                  sub          gp, s1, t2
                  c.andi       a4, 28
                  addi         a1, t1, -1592
                  mulhsu       s0, a1, t4
                  c.and        a5, a4
                  c.slli       s4, 24
                  c.mv         a2, a2
                  and          s7, a5, a7
                  slli         sp, t3, 13
                  sltiu        t6, s10, -519
                  sll          t2, s7, s3
                  c.nop
                  sll          t2, s7, s3
                  c.addi16sp   sp, -16
                  mulh         zero, a3, gp
                  c.srai       a4, 2
                  c.srai       a4, 2
                  slli         sp, t3, 13
                  c.li         a0, 14
                  ori          a6, t5, 1716
                  c.or         a5, a4
                  slli         sp, t3, 13
                  c.xor        a3, a5
                  c.andi       a4, 28
                  c.addi16sp   sp, -16
                  c.and        a5, a4
                  srl          s5, s7, sp
                  div          t1, s3, a1
                  add          s3, s11, s3
                  c.xor        a3, a5
                  div          t1, s3, a1
                  sub          gp, s1, t2
                  xori         a3, s4, 1809
                  c.add        sp, s8
                  xor          s11, s5, a1
                  mulhu        s3, s2, s7
                  sltu         s9, a4, a0
                  c.slli       s4, 24
                  c.slli       s4, 24
                  c.srai       a4, 2
                  sra          sp, a2, sp
                  c.nop
                  add          s3, s11, s3
                  lui          sp, 776755
                  c.slli       s4, 24
                  xor          s11, s5, a1
                  and          s7, a5, a7
                  mulhu        s3, s2, s7
                  c.or         a5, a4
                  c.add        sp, s8
                  xor          s11, s5, a1
                  and          s7, a5, a7
                  slt          t2, a1, s5
                  mulh         zero, a3, gp
                  c.andi       a4, 28
                  sll          t2, s7, s3
                  ori          a6, t5, 1716
                  slti         a0, a4, -1207
                  sltu         s9, a4, a0
                  div          t1, s3, a1
                  c.li         a0, 14
                  and          s7, a5, a7
                  srai         gp, ra, 29
                  slli         sp, t3, 13
                  xor          s11, s5, a1
                  or           a2, a7, sp
                  nop
                  c.srli       a2, 1
                  c.add        sp, s8
                  c.mv         a2, a2
                  addi         a1, t1, -1592
                  c.addi       a2, -1
                  sltu         s9, a4, a0
                  c.lui        s9, 19
                  mul          a1, s1, t5
                  remu         zero, s2, zero
                  c.addi4spn   a5, sp, 464
                  srl          s5, s7, sp
                  c.and        a5, a4
                  c.sub        a5, a1
                  addi         a1, t1, -1592
                  c.or         a5, a4
                  or           a2, a7, sp
                  c.srli       a2, 1
                  add          s3, s11, s3
                  and          s7, a5, a7
                  slli         sp, t3, 13
                  mulhsu       s0, a1, t4
                  sltiu        t6, s10, -519
                  remu         zero, s2, zero
                  slti         a0, a4, -1207
                  andi         t6, a4, 389
                  srli         s0, s11, 8
                  div          t1, s3, a1
                  c.xor        a3, a5
                  add          s3, s11, s3
                  rem          sp, t6, tp
                  sll          t2, s7, s3
                  xor          s11, s5, a1
                  c.mv         a2, a2
                  sltiu        t6, s10, -519
                  div          t1, s3, a1
                  sltu         s9, a4, a0
                  nop
                  c.mv         a2, a2
                  c.srai       a4, 2
                  slt          t2, a1, s5
                  c.srli       a2, 1
                  lui          sp, 776755
                  mulh         zero, a3, gp
                  auipc        t1, 195699
                  ori          a6, t5, 1716
                  srl          s5, s7, sp
                  c.addi       a2, -1
                  ori          a6, t5, 1716
                  c.slli       s4, 24
                  nop
                  c.addi       a2, -1
                  slli         sp, t3, 13
                  c.srai       a4, 2
                  c.add        sp, s8
                  mulhu        s3, s2, s7
                  rem          sp, t6, tp
                  c.li         a0, 14
                  c.srli       a2, 1
                  sll          t2, s7, s3
                  and          s7, a5, a7
                  c.li         a0, 14
                  c.sub        a5, a1
                  c.add        sp, s8
                  mul          a1, s1, t5
                  c.sub        a5, a1
                  rem          sp, t6, tp
                  c.andi       a4, 28
                  c.lui        s9, 19
                  srai         gp, ra, 29
                  c.sub        a5, a1
                  c.addi16sp   sp, -16
                  sra          sp, a2, sp
                  ori          a6, t5, 1716
                  xor          s11, s5, a1
                  c.nop
                  slt          t2, a1, s5
                  andi         t6, a4, 389
                  srl          s5, s7, sp
                  slli         sp, t3, 13
                  nop
                  c.addi4spn   a5, sp, 464
                  lui          sp, 776755
                  sra          sp, a2, sp
                  c.slli       s4, 24
                  c.addi       a2, -1
                  ori          a6, t5, 1716
                  c.lui        s9, 19
                  c.sub        a5, a1
                  remu         zero, s2, zero
                  c.and        a5, a4
                  c.li         a0, 14
                  mulh         zero, a3, gp
                  c.mv         a2, a2
                  mulh         zero, a3, gp
                  auipc        t1, 195699
                  div          t1, s3, a1
                  xor          s11, s5, a1
                  mulhu        s3, s2, s7
                  c.xor        a3, a5
                  srl          s5, s7, sp
                  slti         a0, a4, -1207
                  ori          a6, t5, 1716
                  c.addi4spn   a5, sp, 464
                  divu         t5, a7, tp
                  divu         t5, a7, tp
                  or           a2, a7, sp
                  rem          sp, t6, tp
                  c.sub        a5, a1
                  mul          a1, s1, t5
                  c.lui        s9, 19
                  xori         a3, s4, 1809
                  rem          sp, t6, tp
                  mulh         zero, a3, gp
                  and          s7, a5, a7
                  c.addi16sp   sp, -16
                  divu         t5, a7, tp
                  slli         sp, t3, 13
                  c.add        sp, s8
                  c.mv         a2, a2
                  c.and        a5, a4
                  slti         a0, a4, -1207
                  c.mv         a2, a2
                  remu         zero, s2, zero
                  add          s3, s11, s3
                  div          t1, s3, a1
                  slt          t2, a1, s5
                  auipc        t1, 195699
                  c.addi       a2, -1
                  or           a2, a7, sp
                  xori         a3, s4, 1809
                  rem          sp, t6, tp
                  c.addi       a2, -1
                  c.xor        a3, a5
                  mulhsu       s0, a1, t4
                  slti         a0, a4, -1207
                  mulh         zero, a3, gp
                  nop
                  c.srli       a2, 1
                  mulhu        s3, s2, s7
                  auipc        t1, 195699
                  ori          a6, t5, 1716
                  mulhu        s3, s2, s7
                  c.srli       a2, 1
                  auipc        t1, 195699
                  c.lui        s9, 19
                  srli         s0, s11, 8
                  c.li         a0, 14
                  divu         t5, a7, tp
                  divu         t5, a7, tp
                  c.slli       s4, 24
                  mulhu        s3, s2, s7
                  rem          sp, t6, tp
                  auipc        t1, 195699
                  slli         sp, t3, 13
                  div          t1, s3, a1
                  c.and        a5, a4
                  div          t1, s3, a1
                  slti         a0, a4, -1207
                  c.lui        s9, 19
                  c.srai       a4, 2
                  slt          t2, a1, s5
                  sub          gp, s1, t2
                  addi         a1, t1, -1592
                  srl          s5, s7, sp
                  c.lui        s9, 19
                  c.or         a5, a4
                  sra          sp, a2, sp
                  sra          sp, a2, sp
                  xor          s11, s5, a1
                  and          s7, a5, a7
                  xor          s11, s5, a1
                  div          t1, s3, a1
                  sltiu        t6, s10, -519
                  mulhsu       s0, a1, t4
                  andi         t6, a4, 389
                  c.srli       a2, 1
                  ori          a6, t5, 1716
                  c.addi16sp   sp, -16
                  mul          a1, s1, t5
                  c.addi4spn   a5, sp, 464
                  c.addi16sp   sp, -16
                  add          s3, s11, s3
                  xori         a3, s4, 1809
                  c.addi4spn   a5, sp, 464
                  sra          sp, a2, sp
                  c.or         a5, a4
                  mul          a1, s1, t5
                  c.addi       a2, -1
                  slti         a0, a4, -1207
                  c.srai       a4, 2
                  and          s7, a5, a7
                  mulh         zero, a3, gp
                  mulhsu       s0, a1, t4
                  srli         s0, s11, 8
                  c.sub        a5, a1
                  srl          s5, s7, sp
                  div          t1, s3, a1
                  c.andi       a4, 28
                  c.add        sp, s8
                  auipc        t1, 195699
                  slt          t2, a1, s5
                  c.srai       a4, 2
                  c.andi       a4, 28
                  andi         t6, a4, 389
                  slli         sp, t3, 13
                  nop
                  c.andi       a4, 28
                  c.addi16sp   sp, -16
                  c.addi16sp   sp, -16
                  srl          s5, s7, sp
                  and          s7, a5, a7
                  slli         sp, t3, 13
                  rem          sp, t6, tp
                  xori         a3, s4, 1809
                  c.srli       a2, 1
                  xori         a3, s4, 1809
                  mulh         zero, a3, gp
                  c.addi       a2, -1
                  slt          t2, a1, s5
                  c.add        sp, s8
                  add          s3, s11, s3
                  sub          gp, s1, t2
                  slti         a0, a4, -1207
                  sltiu        t6, s10, -519
                  divu         t5, a7, tp
                  c.add        sp, s8
                  c.andi       a4, 28
                  sltu         s9, a4, a0
                  c.srli       a2, 1
                  lui          sp, 776755
                  c.nop
                  sra          sp, a2, sp
                  ori          a6, t5, 1716
                  srli         s0, s11, 8
                  xor          s11, s5, a1
                  mul          a1, s1, t5
                  c.sub        a5, a1
                  c.slli       s4, 24
                  rem          sp, t6, tp
                  xori         a3, s4, 1809
                  xori         a3, s4, 1809
                  mulh         zero, a3, gp
                  srli         s0, s11, 8
                  sltu         s9, a4, a0
                  c.li         a0, 14
                  srl          s5, s7, sp
                  sra          sp, a2, sp
                  c.li         a0, 14
                  auipc        t1, 195699
                  divu         t5, a7, tp
                  c.li         a0, 14
                  c.xor        a3, a5
                  c.slli       s4, 24
                  sub          gp, s1, t2
                  sub          gp, s1, t2
                  mulhsu       s0, a1, t4
                  mulhu        s3, s2, s7
                  c.xor        a3, a5
                  andi         t6, a4, 389
                  c.or         a5, a4
                  div          t1, s3, a1
                  srli         s0, s11, 8
                  c.nop
                  c.nop
                  srl          s5, s7, sp
                  c.mv         a2, a2
                  srli         s0, s11, 8
                  auipc        t1, 195699
                  mul          a1, s1, t5
                  sltiu        t6, s10, -519
                  mulhu        s3, s2, s7
                  c.srli       a2, 1
                  addi         a1, t1, -1592
                  add          s3, s11, s3
                  c.nop
                  c.addi16sp   sp, -16
                  c.nop
                  div          t1, s3, a1
                  c.or         a5, a4
                  c.andi       a4, 28
                  c.or         a5, a4
                  c.addi4spn   a5, sp, 464
                  c.srli       a2, 1
                  xor          s11, s5, a1
                  c.addi4spn   a5, sp, 464
                  slt          t2, a1, s5
                  addi         a1, t1, -1592
                  sll          t2, s7, s3
                  auipc        t1, 195699
                  andi         t6, a4, 389
                  mulhu        s3, s2, s7
                  slti         a0, a4, -1207
                  c.lui        s9, 19
                  divu         t5, a7, tp
                  c.and        a5, a4
                  sub          gp, s1, t2
                  c.add        sp, s8
                  c.add        sp, s8
                  c.addi4spn   a5, sp, 464
                  c.addi16sp   sp, -16
                  divu         t5, a7, tp
                  ori          a6, t5, 1716
                  c.srli       a2, 1
                  srli         s0, s11, 8
                  add          s3, s11, s3
                  srli         s0, s11, 8
                  c.addi4spn   a5, sp, 464
                  c.lui        s9, 19
                  c.xor        a3, a5
                  sub          gp, s1, t2
                  ori          a6, t5, 1716
                  mulh         zero, a3, gp
                  c.nop
                  c.addi16sp   sp, -16
                  xori         a3, s4, 1809
                  and          s7, a5, a7
                  slli         sp, t3, 13
                  srl          s5, s7, sp
                  slt          t2, a1, s5
                  c.mv         a2, a2
                  xori         a3, s4, 1809
                  mulhsu       s0, a1, t4
                  rem          sp, t6, tp
                  slli         sp, t3, 13
                  xori         a3, s4, 1809
                  mul          a1, s1, t5
                  sll          t2, s7, s3
                  c.add        sp, s8
                  sub          gp, s1, t2
                  addi         a1, t1, -1592
                  div          t1, s3, a1
                  c.andi       a4, 28
                  c.nop
                  lui          sp, 776755
                  auipc        t1, 195699
                  c.and        a5, a4
                  mulhu        s3, s2, s7
                  div          t1, s3, a1
                  xori         a3, s4, 1809
                  remu         zero, s2, zero
                  c.addi4spn   a5, sp, 464
                  rem          sp, t6, tp
                  lui          sp, 776755
                  auipc        t1, 195699
                  srai         gp, ra, 29
                  c.srli       a2, 1
                  c.lui        s9, 19
                  xor          s11, s5, a1
                  rem          sp, t6, tp
                  sra          sp, a2, sp
                  mulhsu       s0, a1, t4
                  c.addi       a2, -1
                  slt          t2, a1, s5
                  c.li         a0, 14
                  ori          a6, t5, 1716
                  sub          gp, s1, t2
                  mul          a1, s1, t5
                  srai         gp, ra, 29
                  slli         sp, t3, 13
                  slti         a0, a4, -1207
                  slti         a0, a4, -1207
                  auipc        t1, 195699
                  c.addi16sp   sp, -16
                  srai         gp, ra, 29
                  c.lui        s9, 19
                  c.addi4spn   a5, sp, 464
                  srl          s5, s7, sp
                  c.li         a0, 14
                  c.addi16sp   sp, -16
                  auipc        t1, 195699
                  srli         s0, s11, 8
                  mul          a1, s1, t5
                  c.xor        a3, a5
                  remu         zero, s2, zero
                  remu         zero, s2, zero
                  or           a2, a7, sp
                  c.mv         a2, a2
                  auipc        t1, 195699
                  andi         t6, a4, 389
                  slt          t2, a1, s5
                  c.srai       a4, 2
                  ori          a6, t5, 1716
                  xori         a3, s4, 1809
                  ori          a6, t5, 1716
                  c.slli       s4, 24
                  c.lui        s9, 19
                  c.xor        a3, a5
                  ori          a6, t5, 1716
                  divu         t5, a7, tp
                  srli         s0, s11, 8
                  c.xor        a3, a5
                  slli         sp, t3, 13
                  c.slli       s4, 24
                  addi         a1, t1, -1592
                  mulh         zero, a3, gp
                  ori          a6, t5, 1716
                  srl          s5, s7, sp
                  mulhsu       s0, a1, t4
                  c.li         a0, 14
                  addi         a1, t1, -1592
                  c.addi       a2, -1
                  sll          t2, s7, s3
                  lui          sp, 776755
                  sra          sp, a2, sp
                  div          t1, s3, a1
                  c.addi16sp   sp, -16
                  c.or         a5, a4
                  mulh         zero, a3, gp
                  xor          s11, s5, a1
                  c.srai       a4, 2
                  nop
                  c.xor        a3, a5
                  c.add        sp, s8
                  c.sub        a5, a1
                  c.srli       a2, 1
                  sltu         s9, a4, a0
                  srli         s0, s11, 8
                  mulh         zero, a3, gp
                  or           a2, a7, sp
                  c.sub        a5, a1
                  c.srai       a4, 2
                  andi         t6, a4, 389
                  c.add        sp, s8
                  c.xor        a3, a5
                  sub          gp, s1, t2
                  mulhu        s3, s2, s7
                  c.and        a5, a4
                  auipc        t1, 195699
                  mul          a1, s1, t5
                  lui          sp, 776755
                  c.andi       a4, 28
                  divu         t5, a7, tp
                  mulhsu       s0, a1, t4
                  c.sub        a5, a1
                  lui          sp, 776755
                  srl          s5, s7, sp
                  c.xor        a3, a5
                  add          s3, s11, s3
                  c.lui        s9, 19
                  c.add        sp, s8
                  sra          sp, a2, sp
                  c.addi16sp   sp, -16
                  and          s7, a5, a7
                  c.li         a0, 14
                  sltu         s9, a4, a0
                  sltu         s9, a4, a0
                  c.mv         a2, a2
                  auipc        t1, 195699
                  slt          t2, a1, s5
                  c.addi4spn   a5, sp, 464
                  sltiu        t6, s10, -519
                  srl          s5, s7, sp
                  slt          t2, a1, s5
                  c.li         a0, 14
                  slt          t2, a1, s5
                  c.andi       a4, 28
                  sra          sp, a2, sp
                  c.and        a5, a4
                  divu         t5, a7, tp
                  c.addi4spn   a5, sp, 464
                  c.sub        a5, a1
                  sltiu        t6, s10, -519
                  slt          t2, a1, s5
                  mulhsu       s0, a1, t4
                  srai         gp, ra, 29
                  sltu         s9, a4, a0
                  nop
                  xor          s11, s5, a1
                  andi         t6, a4, 389
                  c.lui        s9, 19
                  c.addi       a2, -1
                  sltiu        t6, s10, -519
                  sltiu        t6, s10, -519
                  divu         t5, a7, tp
                  c.nop
                  mul          a1, s1, t5
                  slli         sp, t3, 13
                  div          t1, s3, a1
                  rem          sp, t6, tp
                  c.srli       a2, 1
                  c.andi       a4, 28
                  sltu         s9, a4, a0
                  mulhsu       s0, a1, t4
                  mul          a1, s1, t5
                  mul          a1, s1, t5
                  mulhu        s3, s2, s7
                  c.li         a0, 14
                  sra          sp, a2, sp
                  xori         a3, s4, 1809
                  andi         t6, a4, 389
                  c.add        sp, s8
                  slli         sp, t3, 13
                  c.andi       a4, 28
                  c.li         a0, 14
                  sub          gp, s1, t2
                  c.andi       a4, 28
                  c.slli       s4, 24
                  slti         a0, a4, -1207
                  sll          t2, s7, s3
                  c.slli       s4, 24
                  and          s7, a5, a7
                  c.srai       a4, 2
                  sll          t2, s7, s3
                  sltiu        t6, s10, -519
                  divu         t5, a7, tp
                  and          s7, a5, a7
                  remu         zero, s2, zero
                  c.addi16sp   sp, -16
                  mulh         zero, a3, gp
                  c.and        a5, a4
                  divu         t5, a7, tp
                  c.andi       a4, 28
                  c.add        sp, s8
                  sltiu        t6, s10, -519
                  srai         gp, ra, 29
                  xori         a3, s4, 1809
                  addi         a1, t1, -1592
                  and          s7, a5, a7
                  c.srli       a2, 1
                  andi         t6, a4, 389
                  add          s3, s11, s3
                  c.xor        a3, a5
                  c.addi4spn   a5, sp, 464
                  c.sub        a5, a1
                  c.lui        s9, 19
                  c.lui        s9, 19
                  slli         sp, t3, 13
                  c.lui        s9, 19
                  sltiu        t6, s10, -519
                  ori          a6, t5, 1716
                  sra          sp, a2, sp
                  c.mv         a2, a2
                  c.nop
                  remu         zero, s2, zero
                  c.addi16sp   sp, -16
                  mulhsu       s0, a1, t4
                  nop
                  or           a2, a7, sp
                  c.and        a5, a4
                  c.xor        a3, a5
                  c.or         a5, a4
                  c.add        sp, s8
                  sltu         s9, a4, a0
                  c.andi       a4, 28
                  c.lui        s9, 19
                  add          s3, s11, s3
                  mulh         zero, a3, gp
                  slli         sp, t3, 13
                  addi         a1, t1, -1592
                  sltiu        t6, s10, -519
                  sra          sp, a2, sp
                  srai         gp, ra, 29
                  c.and        a5, a4
                  sub          gp, s1, t2
                  c.sub        a5, a1
                  xor          s11, s5, a1
                  and          s7, a5, a7
                  c.lui        s9, 19
                  sltu         s9, a4, a0
                  c.xor        a3, a5
                  slli         sp, t3, 13
                  sltu         s9, a4, a0
                  c.and        a5, a4
                  add          s3, s11, s3
                  slt          t2, a1, s5
                  or           a2, a7, sp
                  c.nop
                  c.lui        s9, 19
                  xor          s11, s5, a1
                  andi         t6, a4, 389
                  sltiu        t6, s10, -519
                  sra          sp, a2, sp
                  c.addi16sp   sp, -16
                  c.and        a5, a4
                  mulhsu       s0, a1, t4
                  addi         a1, t1, -1592
                  nop
                  sltu         s9, a4, a0
                  c.add        sp, s8
                  divu         t5, a7, tp
                  slli         sp, t3, 13
                  c.mv         a2, a2
                  c.srli       a2, 1
                  slt          t2, a1, s5
                  c.lui        s9, 19
                  xor          s11, s5, a1
                  mul          a1, s1, t5
                  mul          a1, s1, t5
                  mul          a1, s1, t5
                  xori         a3, s4, 1809
                  ori          a6, t5, 1716
                  add          s3, s11, s3
                  c.lui        s9, 19
                  sub          gp, s1, t2
                  mulhu        s3, s2, s7
                  lui          sp, 776755
                  srl          s5, s7, sp
                  srli         s0, s11, 8
                  c.addi16sp   sp, -16
                  srl          s5, s7, sp
                  c.nop
                  slt          t2, a1, s5
                  slti         a0, a4, -1207
                  slt          t2, a1, s5
                  or           a2, a7, sp
                  ori          a6, t5, 1716
                  sltiu        t6, s10, -519
                  mulhsu       s0, a1, t4
                  c.addi       a2, -1
                  sub          gp, s1, t2
                  mul          a1, s1, t5
                  c.slli       s4, 24
                  c.addi4spn   a5, sp, 464
                  sltu         s9, a4, a0
                  c.slli       s4, 24
                  sra          sp, a2, sp
                  divu         t5, a7, tp
                  c.addi       a2, -1
                  remu         zero, s2, zero
                  srl          s5, s7, sp
                  sra          sp, a2, sp
                  srl          s5, s7, sp
                  rem          sp, t6, tp
                  mulh         zero, a3, gp
                  andi         t6, a4, 389
                  nop
                  slti         a0, a4, -1207
                  mulh         zero, a3, gp
                  or           a2, a7, sp
                  srl          s5, s7, sp
                  add          s3, s11, s3
                  c.srai       a4, 2
                  sltu         s9, a4, a0
                  xori         a3, s4, 1809
                  c.srai       a4, 2
                  c.addi       a2, -1
                  div          t1, s3, a1
                  add          s3, s11, s3
                  c.addi       a2, -1
                  sltiu        t6, s10, -519
                  and          s7, a5, a7
                  divu         t5, a7, tp
                  xori         a3, s4, 1809
                  c.addi       a2, -1
                  andi         t6, a4, 389
                  c.andi       a4, 28
                  or           a2, a7, sp
                  c.addi16sp   sp, -16
                  and          s7, a5, a7
                  nop
                  slt          t2, a1, s5
                  and          s7, a5, a7
                  mulhsu       s0, a1, t4
                  sra          sp, a2, sp
                  sub          gp, s1, t2
                  div          t1, s3, a1
                  nop
                  and          s7, a5, a7
                  c.slli       s4, 24
                  c.lui        s9, 19
                  remu         zero, s2, zero
                  c.or         a5, a4
                  c.mv         a2, a2
                  c.sub        a5, a1
                  sltu         s9, a4, a0
                  slti         a0, a4, -1207
                  srli         s0, s11, 8
                  auipc        t1, 195699
                  srai         gp, ra, 29
                  slli         sp, t3, 13
                  divu         t5, a7, tp
                  mulhsu       s0, a1, t4
                  c.add        sp, s8
                  rem          sp, t6, tp
                  c.mv         a2, a2
                  sub          gp, s1, t2
                  c.sub        a5, a1
                  mul          a1, s1, t5
                  c.sub        a5, a1
                  c.sub        a5, a1
                  mulhu        s3, s2, s7
                  slli         sp, t3, 13
                  c.li         a0, 14
                  c.slli       s4, 24
                  or           a2, a7, sp
                  mul          a1, s1, t5
                  c.li         a0, 14
                  c.xor        a3, a5
                  c.mv         a2, a2
                  c.or         a5, a4
                  c.or         a5, a4
                  andi         t6, a4, 389
                  slti         a0, a4, -1207
                  or           a2, a7, sp
                  sra          sp, a2, sp
                  c.srai       a4, 2
                  c.srli       a2, 1
                  slt          t2, a1, s5
                  xori         a3, s4, 1809
                  sltiu        t6, s10, -519
                  slti         a0, a4, -1207
                  and          s7, a5, a7
                  ori          a6, t5, 1716
                  div          t1, s3, a1
                  addi         a1, t1, -1592
                  c.lui        s9, 19
                  remu         zero, s2, zero
                  mulhu        s3, s2, s7
                  auipc        t1, 195699
                  mulhu        s3, s2, s7
                  c.andi       a4, 28
                  c.li         a0, 14
                  rem          sp, t6, tp
                  addi         a1, t1, -1592
                  slt          t2, a1, s5
                  slt          t2, a1, s5
                  c.lui        s9, 19
                  srai         gp, ra, 29
                  c.andi       a4, 28
                  lui          sp, 776755
                  c.xor        a3, a5
                  c.srai       a4, 2
                  c.mv         a2, a2
                  div          t1, s3, a1
                  c.addi4spn   a5, sp, 464
                  c.sub        a5, a1
                  divu         t5, a7, tp
                  c.mv         a2, a2
                  c.lui        s9, 19
                  li           s0, 0x80000000 #start riscv_int_numeric_corner_stream_21
                  li           a3, 0xffffffff
                  li           a7, 0x81e2474a
                  li           s7, 0xce43bc0
                  li           a5, 0x80000000
                  li           s10, 0x0
                  li           ra, 0x0
                  li           s4, 0x7972c2ae
                  li           a4, 0x80000000
                  li           s3, 0xffffffff
                  nop
                  mulhsu       s4, a7, ra
                  addi         s10, s3, -1592
                  mul          s10, s10, a4
                  mul          s10, s10, a4
                  lui          a3, 776755
                  auipc        a7, 195699
                  divu         s0, s0, a5
                  add          s0, s0, a4
                  rem          a3, s3, a5
                  mul          s10, s10, a4
                  add          s0, s0, a4
                  add          s0, s0, a4
                  mulh         ra, a5, a4
                  mulhsu       s4, a7, ra
                  nop
                  lui          a3, 776755
                  mulh         ra, a5, a4
                  remu         ra, a3, ra
                  rem          a3, s3, a5
                  div          a7, a4, s3 #end riscv_int_numeric_corner_stream_21
                  xor          s11, s5, a1
                  c.srai       a4, 2
                  c.add        sp, s8
                  c.mv         a2, a2
                  c.or         a5, a4
                  c.andi       a4, 28
                  mulhu        s3, s2, s7
                  addi         a1, t1, -1592
                  rem          sp, t6, tp
                  sra          sp, a2, sp
                  sub          gp, s1, t2
                  xori         a3, s4, 1809
                  or           a2, a7, sp
                  c.add        sp, s8
                  srli         s0, s11, 8
                  c.srai       a4, 2
                  rem          sp, t6, tp
                  slli         sp, t3, 13
                  c.nop
                  c.xor        a3, a5
                  sll          t2, s7, s3
                  addi         a1, t1, -1592
                  c.lui        s9, 19
                  c.andi       a4, 28
                  nop
                  mul          a1, s1, t5
                  xor          s11, s5, a1
                  ori          a6, t5, 1716
                  mulhu        s3, s2, s7
                  divu         t5, a7, tp
                  mulh         zero, a3, gp
                  c.srai       a4, 2
                  c.slli       s4, 24
                  xori         a3, s4, 1809
                  divu         t5, a7, tp
                  c.or         a5, a4
                  rem          sp, t6, tp
                  addi         a1, t1, -1592
                  c.andi       a4, 28
                  c.lui        s9, 19
                  c.sub        a5, a1
                  andi         t6, a4, 389
                  mulhu        s3, s2, s7
                  c.srli       a2, 1
                  c.addi4spn   a5, sp, 464
                  c.sub        a5, a1
                  mulhsu       s0, a1, t4
                  c.addi16sp   sp, -16
                  add          s3, s11, s3
                  srl          s5, s7, sp
                  andi         t6, a4, 389
                  c.nop
                  xori         a3, s4, 1809
                  slti         a0, a4, -1207
                  c.addi4spn   a5, sp, 464
                  div          t1, s3, a1
                  remu         zero, s2, zero
                  auipc        t1, 195699
                  c.addi       a2, -1
                  c.nop
                  andi         t6, a4, 389
                  c.and        a5, a4
                  slli         sp, t3, 13
                  slt          t2, a1, s5
                  c.sub        a5, a1
                  xori         a3, s4, 1809
                  slli         sp, t3, 13
                  c.or         a5, a4
                  remu         zero, s2, zero
                  c.sub        a5, a1
                  c.mv         a2, a2
                  auipc        t1, 195699
                  c.addi4spn   a5, sp, 464
                  xor          s11, s5, a1
                  c.xor        a3, a5
                  c.andi       a4, 28
                  mulh         zero, a3, gp
                  xori         a3, s4, 1809
                  xori         a3, s4, 1809
                  c.andi       a4, 28
                  c.slli       s4, 24
                  slti         a0, a4, -1207
                  auipc        t1, 195699
                  remu         zero, s2, zero
                  c.andi       a4, 28
                  slli         sp, t3, 13
                  ori          a6, t5, 1716
                  c.lui        s9, 19
                  mulh         zero, a3, gp
                  c.addi16sp   sp, -16
                  c.slli       s4, 24
                  lui          sp, 776755
                  mul          a1, s1, t5
                  slli         sp, t3, 13
                  mulhsu       s0, a1, t4
                  ori          a6, t5, 1716
                  c.srai       a4, 2
                  c.addi16sp   sp, -16
                  c.addi       a2, -1
                  slt          t2, a1, s5
                  mulh         zero, a3, gp
                  and          s7, a5, a7
                  c.and        a5, a4
                  c.mv         a2, a2
                  c.slli       s4, 24
                  c.addi16sp   sp, -16
                  addi         a1, t1, -1592
                  c.slli       s4, 24
                  remu         zero, s2, zero
                  c.addi       a2, -1
                  div          t1, s3, a1
                  andi         t6, a4, 389
                  slti         a0, a4, -1207
                  andi         t6, a4, 389
                  c.andi       a4, 28
                  c.add        sp, s8
                  c.sub        a5, a1
                  sltu         s9, a4, a0
                  addi         a1, t1, -1592
                  c.or         a5, a4
                  slti         a0, a4, -1207
                  sra          sp, a2, sp
                  and          s7, a5, a7
                  c.lui        s9, 19
                  c.andi       a4, 28
                  c.srli       a2, 1
                  c.and        a5, a4
                  rem          sp, t6, tp
                  sltu         s9, a4, a0
                  c.li         a0, 14
                  add          s3, s11, s3
                  c.slli       s4, 24
                  sll          t2, s7, s3
                  mulh         zero, a3, gp
                  xori         a3, s4, 1809
                  slti         a0, a4, -1207
                  c.addi4spn   a5, sp, 464
                  c.add        sp, s8
                  slli         sp, t3, 13
                  sltu         s9, a4, a0
                  nop
                  nop
                  slti         a0, a4, -1207
                  slt          t2, a1, s5
                  sltiu        t6, s10, -519
                  rem          sp, t6, tp
                  mul          a1, s1, t5
                  and          s7, a5, a7
                  c.addi       a2, -1
                  c.and        a5, a4
                  auipc        t1, 195699
                  c.nop
                  c.srli       a2, 1
                  sltiu        t6, s10, -519
                  srl          s5, s7, sp
                  c.addi       a2, -1
                  mulh         zero, a3, gp
                  c.mv         a2, a2
                  ori          a6, t5, 1716
                  lui          sp, 776755
                  c.nop
                  c.or         a5, a4
                  c.nop
                  and          s7, a5, a7
                  mulhsu       s0, a1, t4
                  auipc        t1, 195699
                  c.add        sp, s8
                  sub          gp, s1, t2
                  slt          t2, a1, s5
                  c.mv         a2, a2
                  mulhu        s3, s2, s7
                  c.andi       a4, 28
                  xori         a3, s4, 1809
                  c.srai       a4, 2
                  xori         a3, s4, 1809
                  c.srai       a4, 2
                  remu         zero, s2, zero
                  c.or         a5, a4
                  add          s3, s11, s3
                  c.srli       a2, 1
                  xori         a3, s4, 1809
                  andi         t6, a4, 389
                  c.or         a5, a4
                  c.or         a5, a4
                  sltu         s9, a4, a0
                  div          t1, s3, a1
                  slti         a0, a4, -1207
                  c.li         a0, 14
                  lui          sp, 776755
                  and          s7, a5, a7
                  c.and        a5, a4
                  divu         t5, a7, tp
                  add          s3, s11, s3
                  rem          sp, t6, tp
                  c.addi       a2, -1
                  c.addi4spn   a5, sp, 464
                  nop
                  sra          sp, a2, sp
                  sll          t2, s7, s3
                  xori         a3, s4, 1809
                  mulhu        s3, s2, s7
                  lui          sp, 776755
                  mulhsu       s0, a1, t4
                  c.mv         a2, a2
                  c.xor        a3, a5
                  srli         s0, s11, 8
                  nop
                  c.sub        a5, a1
                  c.lui        s9, 19
                  c.li         a0, 14
                  c.nop
                  slti         a0, a4, -1207
                  add          s3, s11, s3
                  c.and        a5, a4
                  c.add        sp, s8
                  auipc        t1, 195699
                  ori          a6, t5, 1716
                  c.nop
                  c.srai       a4, 2
                  slt          t2, a1, s5
                  srl          s5, s7, sp
                  srl          s5, s7, sp
                  c.lui        s9, 19
                  rem          sp, t6, tp
                  mulh         zero, a3, gp
                  mulhsu       s0, a1, t4
                  c.sub        a5, a1
                  sltiu        t6, s10, -519
                  mulhsu       s0, a1, t4
                  c.or         a5, a4
                  srl          s5, s7, sp
                  xor          s11, s5, a1
                  srai         gp, ra, 29
                  slti         a0, a4, -1207
                  c.slli       s4, 24
                  c.lui        s9, 19
                  c.slli       s4, 24
                  slt          t2, a1, s5
                  ori          a6, t5, 1716
                  mulhsu       s0, a1, t4
                  andi         t6, a4, 389
                  c.mv         a2, a2
                  c.srai       a4, 2
                  remu         zero, s2, zero
                  add          s3, s11, s3
                  c.xor        a3, a5
                  add          s3, s11, s3
                  andi         t6, a4, 389
                  c.addi4spn   a5, sp, 464
                  srl          s5, s7, sp
                  c.or         a5, a4
                  c.andi       a4, 28
                  rem          sp, t6, tp
                  slt          t2, a1, s5
                  ori          a6, t5, 1716
                  andi         t6, a4, 389
                  slti         a0, a4, -1207
                  slt          t2, a1, s5
                  and          s7, a5, a7
                  c.and        a5, a4
                  remu         zero, s2, zero
                  slt          t2, a1, s5
                  c.addi4spn   a5, sp, 464
                  srli         s0, s11, 8
                  srli         s0, s11, 8
                  mul          a1, s1, t5
                  sra          sp, a2, sp
                  nop
                  c.addi16sp   sp, -16
                  slti         a0, a4, -1207
                  srli         s0, s11, 8
                  sra          sp, a2, sp
                  or           a2, a7, sp
                  nop
                  c.xor        a3, a5
                  c.addi16sp   sp, -16
                  mulhsu       s0, a1, t4
                  auipc        t1, 195699
                  auipc        t1, 195699
                  mul          a1, s1, t5
                  sll          t2, s7, s3
                  c.addi16sp   sp, -16
                  srai         gp, ra, 29
                  mulhu        s3, s2, s7
                  sltiu        t6, s10, -519
                  sltu         s9, a4, a0
                  c.andi       a4, 28
                  srl          s5, s7, sp
                  sltu         s9, a4, a0
                  c.xor        a3, a5
                  add          s3, s11, s3
                  c.xor        a3, a5
                  c.nop
                  mulhsu       s0, a1, t4
                  c.mv         a2, a2
                  or           a2, a7, sp
                  c.xor        a3, a5
                  mul          a1, s1, t5
                  div          t1, s3, a1
                  divu         t5, a7, tp
                  sra          sp, a2, sp
                  c.addi4spn   a5, sp, 464
                  slli         sp, t3, 13
                  c.srli       a2, 1
                  sll          t2, s7, s3
                  slt          t2, a1, s5
                  mulhsu       s0, a1, t4
                  c.addi4spn   a5, sp, 464
                  auipc        t1, 195699
                  nop
                  sltu         s9, a4, a0
                  auipc        t1, 195699
                  c.slli       s4, 24
                  slti         a0, a4, -1207
                  srli         s0, s11, 8
                  mulhu        s3, s2, s7
                  srli         s0, s11, 8
                  c.andi       a4, 28
                  srl          s5, s7, sp
                  slti         a0, a4, -1207
                  sltu         s9, a4, a0
                  add          s3, s11, s3
                  sra          sp, a2, sp
                  mulh         zero, a3, gp
                  nop
                  sub          gp, s1, t2
                  c.slli       s4, 24
                  div          t1, s3, a1
                  and          s7, a5, a7
                  c.lui        s9, 19
                  c.li         a0, 14
                  c.lui        s9, 19
                  c.xor        a3, a5
                  c.li         a0, 14
                  xor          s11, s5, a1
                  remu         zero, s2, zero
                  nop
                  divu         t5, a7, tp
                  ori          a6, t5, 1716
                  c.andi       a4, 28
                  sub          gp, s1, t2
                  c.srai       a4, 2
                  c.add        sp, s8
                  c.and        a5, a4
                  div          t1, s3, a1
                  li           s3, 0x0 #start riscv_int_numeric_corner_stream_13
                  li           t2, 0x0
                  li           t1, 0x0
                  li           t3, 0x0
                  li           t6, 0xffffffff
                  li           s10, 0x0
                  li           s7, 0x0
                  li           a4, 0x0
                  li           t0, 0x80000000
                  li           a7, 0x80000000
                  nop
                  add          t1, t1, a4
                  addi         t6, s7, -1592
                  nop
                  lui          t2, 776755
                  addi         t6, s7, -1592
                  add          t1, t1, a4
                  mulhsu       s10, s3, t0
                  lui          t2, 776755
                  div          s3, a4, s7
                  mul          t6, t6, a4
                  addi         t6, s7, -1592
                  mulhsu       s10, s3, t0
                  divu         t1, t1, a7
                  addi         t6, s7, -1592
                  mulhsu       s10, s3, t0
                  auipc        s3, 195699 #end riscv_int_numeric_corner_stream_13
                  slti         a0, a4, -1207
                  mul          a1, s1, t5
                  add          s3, s11, s3
                  addi         a1, t1, -1592
                  c.nop
                  sltiu        t6, s10, -519
                  c.srli       a2, 1
                  c.nop
                  nop
                  c.srli       a2, 1
                  add          s3, s11, s3
                  c.addi16sp   sp, -16
                  nop
                  lui          sp, 776755
                  mulh         zero, a3, gp
                  slt          t2, a1, s5
                  c.xor        a3, a5
                  xori         a3, s4, 1809
                  c.xor        a3, a5
                  xori         a3, s4, 1809
                  sll          t2, s7, s3
                  and          s7, a5, a7
                  srl          s5, s7, sp
                  c.and        a5, a4
                  c.lui        s9, 19
                  sub          gp, s1, t2
                  slt          t2, a1, s5
                  srai         gp, ra, 29
                  slt          t2, a1, s5
                  slt          t2, a1, s5
                  c.andi       a4, 28
                  sra          sp, a2, sp
                  c.mv         a2, a2
                  c.or         a5, a4
                  c.and        a5, a4
                  c.addi16sp   sp, -16
                  sll          t2, s7, s3
                  add          s3, s11, s3
                  sltu         s9, a4, a0
                  c.mv         a2, a2
                  remu         zero, s2, zero
                  slt          t2, a1, s5
                  c.li         a0, 14
                  c.addi       a2, -1
                  c.and        a5, a4
                  srl          s5, s7, sp
                  c.addi4spn   a5, sp, 464
                  li           ra, 0xffffffff #start riscv_int_numeric_corner_stream_22
                  li           a5, 0xffffffff
                  li           t3, 0x5227f389
                  li           t2, 0xffffffff
                  li           s6, 0x80000000
                  li           s2, 0xffffffff
                  li           s0, 0x80000000
                  li           t0, 0x776d8e50
                  li           a6, 0x0
                  li           a7, 0x0
                  div          a6, s0, a7
                  remu         ra, t2, ra
                  add          t0, t0, s0
                  divu         t0, t0, a5
                  mulhu        t0, t2, s2
                  add          t0, t0, s0
                  add          t0, t0, s0
                  mulh         ra, a5, s0
                  mulhu        t0, t2, s2
                  mulhu        t0, t2, s2
                  divu         t0, t0, a5
                  mul          t3, t3, s0
                  mul          t3, t3, s0
                  nop
                  mulhsu       s2, a6, ra
                  div          a6, s0, a7
                  auipc        a6, 195699
                  mulhsu       s2, a6, ra
                  mulh         ra, a5, s0
                  mulh         ra, a5, s0
                  remu         ra, t2, ra
                  sub          s0, t3, s2
                  sub          s0, t3, s2
                  addi         t3, a7, -1592
                  mulhsu       s2, a6, ra
                  mulhu        t0, t2, s2
                  mulhu        t0, t2, s2
                  mul          t3, t3, s0 #end riscv_int_numeric_corner_stream_22
                  mul          a1, s1, t5
                  lui          sp, 776755
                  auipc        t1, 195699
                  c.add        sp, s8
                  sltiu        t6, s10, -519
                  nop
                  c.slli       s4, 24
                  c.addi4spn   a5, sp, 464
                  c.andi       a4, 28
                  srli         s0, s11, 8
                  srl          s5, s7, sp
                  c.xor        a3, a5
                  c.lui        s9, 19
                  auipc        t1, 195699
                  slli         sp, t3, 13
                  mulhu        s3, s2, s7
                  sltiu        t6, s10, -519
                  mulhsu       s0, a1, t4
                  c.or         a5, a4
                  srl          s5, s7, sp
                  c.li         a0, 14
                  mulh         zero, a3, gp
                  sub          gp, s1, t2
                  ori          a6, t5, 1716
                  li           t6, 0x0 #start riscv_int_numeric_corner_stream_19
                  li           s11, 0x80000000
                  li           t2, 0xffffffff
                  li           s8, 0xa15c7ca9
                  li           a6, 0x0
                  li           s4, 0x80000000
                  li           s10, 0x0
                  li           ra, 0xf0ea0a1a
                  li           a3, 0x4b92a85d
                  li           sp, 0xa3a59ea1
                  rem          t2, s8, a6
                  rem          t2, s8, a6
                  sub          a3, t6, s10
                  rem          t2, s8, a6
                  sub          a3, t6, s10
                  divu         sp, sp, a6
                  mul          t6, t6, a3
                  addi         t6, s8, -1592
                  mulhsu       s10, s4, ra
                  divu         sp, sp, a6
                  mulhsu       s10, s4, ra
                  add          sp, sp, a3
                  divu         sp, sp, a6
                  mulh         ra, a6, a3
                  mul          t6, t6, a3
                  mulhu        sp, t2, s10
                  divu         sp, sp, a6
                  mulhu        sp, t2, s10
                  mul          t6, t6, a3
                  mulhsu       s10, s4, ra
                  add          sp, sp, a3
                  mulhsu       s10, s4, ra
                  mul          t6, t6, a3
                  add          sp, sp, a3
                  remu         ra, t2, ra
                  lui          t2, 776755
                  nop
                  mulhu        sp, t2, s10
                  remu         ra, t2, ra #end riscv_int_numeric_corner_stream_19
                  slt          t2, a1, s5
                  c.mv         a2, a2
                  c.srai       a4, 2
                  slli         sp, t3, 13
                  sra          sp, a2, sp
                  mulhsu       s0, a1, t4
                  lui          sp, 776755
                  srli         s0, s11, 8
                  div          t1, s3, a1
                  xori         a3, s4, 1809
                  srl          s5, s7, sp
                  srli         s0, s11, 8
                  srl          s5, s7, sp
                  nop
                  c.or         a5, a4
                  srai         gp, ra, 29
                  c.or         a5, a4
                  remu         zero, s2, zero
                  slti         a0, a4, -1207
                  mulhu        s3, s2, s7
                  c.slli       s4, 24
                  mulh         zero, a3, gp
                  slti         a0, a4, -1207
                  add          s3, s11, s3
                  sub          gp, s1, t2
                  c.srai       a4, 2
                  sra          sp, a2, sp
                  c.xor        a3, a5
                  slt          t2, a1, s5
                  lui          sp, 776755
                  c.sub        a5, a1
                  c.slli       s4, 24
                  andi         t6, a4, 389
                  xor          s11, s5, a1
                  auipc        t1, 195699
                  or           a2, a7, sp
                  lui          sp, 776755
                  c.addi4spn   a5, sp, 464
                  xori         a3, s4, 1809
                  c.lui        s9, 19
                  c.sub        a5, a1
                  c.nop
                  xori         a3, s4, 1809
                  lui          sp, 776755
                  c.mv         a2, a2
                  xori         a3, s4, 1809
                  and          s7, a5, a7
                  rem          sp, t6, tp
                  ori          a6, t5, 1716
                  xori         a3, s4, 1809
                  mul          a1, s1, t5
                  c.lui        s9, 19
                  sra          sp, a2, sp
                  slti         a0, a4, -1207
                  srai         gp, ra, 29
                  or           a2, a7, sp
                  c.addi       a2, -1
                  c.mv         a2, a2
                  mulh         zero, a3, gp
                  ori          a6, t5, 1716
                  c.nop
                  c.addi       a2, -1
                  c.srai       a4, 2
                  mulhu        s3, s2, s7
                  mulhsu       s0, a1, t4
                  c.li         a0, 14
                  remu         zero, s2, zero
                  c.and        a5, a4
                  nop
                  srai         gp, ra, 29
                  divu         t5, a7, tp
                  mul          a1, s1, t5
                  c.mv         a2, a2
                  srli         s0, s11, 8
                  c.or         a5, a4
                  c.addi16sp   sp, -16
                  sub          gp, s1, t2
                  c.li         a0, 14
                  c.mv         a2, a2
                  c.nop
                  ori          a6, t5, 1716
                  slti         a0, a4, -1207
                  rem          sp, t6, tp
                  srl          s5, s7, sp
                  sltu         s9, a4, a0
                  sltiu        t6, s10, -519
                  nop
                  srli         s0, s11, 8
                  c.and        a5, a4
                  srl          s5, s7, sp
                  c.lui        s9, 19
                  c.xor        a3, a5
                  sltu         s9, a4, a0
                  xor          s11, s5, a1
                  c.andi       a4, 28
                  mulhsu       s0, a1, t4
                  slli         sp, t3, 13
                  ori          a6, t5, 1716
                  mulh         zero, a3, gp
                  c.mv         a2, a2
                  ori          a6, t5, 1716
                  div          t1, s3, a1
                  c.srai       a4, 2
                  rem          sp, t6, tp
                  lui          sp, 776755
                  c.xor        a3, a5
                  c.addi       a2, -1
                  sub          gp, s1, t2
                  c.xor        a3, a5
                  mulhsu       s0, a1, t4
                  mulhu        s3, s2, s7
                  sltiu        t6, s10, -519
                  auipc        t1, 195699
                  c.li         a0, 14
                  c.lui        s9, 19
                  addi         a1, t1, -1592
                  srl          s5, s7, sp
                  mulh         zero, a3, gp
                  srli         s0, s11, 8
                  c.srai       a4, 2
                  remu         zero, s2, zero
                  xori         a3, s4, 1809
                  rem          sp, t6, tp
                  addi         a1, t1, -1592
                  nop
                  c.add        sp, s8
                  nop
                  la x29, test_done
                  jalr x0, x29, 0
test_done:        
                  li gp, 1
                  ecall
write_tohost:     
                  sw gp, tohost, t5

_exit:            
                  j write_tohost

instr_end:        
                  nop

.section .data
.align 6; .global tohost; tohost: .dword 0;
.align 6; .global fromhost; fromhost: .dword 0;
.section .user_stack,"aw",@progbits;
.align 2
user_stack_start:
.rept 4999
.4byte 0x0
.endr
user_stack_end:
.4byte 0x0
.align 2
kernel_instr_start:
.text
.align           2
mtvec_handler:    
                  addi x4, x4, -4
                  sw  x9, (x4)
                  add x9, x4, zero
                  addi x9, x9, -128
                  sw  x1, 4(x9)
                  sw  x2, 8(x9)
                  sw  x3, 12(x9)
                  sw  x4, 16(x9)
                  sw  x5, 20(x9)
                  sw  x6, 24(x9)
                  sw  x7, 28(x9)
                  sw  x8, 32(x9)
                  sw  x9, 36(x9)
                  sw  x10, 40(x9)
                  sw  x11, 44(x9)
                  sw  x12, 48(x9)
                  sw  x13, 52(x9)
                  sw  x14, 56(x9)
                  sw  x15, 60(x9)
                  sw  x16, 64(x9)
                  sw  x17, 68(x9)
                  sw  x18, 72(x9)
                  sw  x19, 76(x9)
                  sw  x20, 80(x9)
                  sw  x21, 84(x9)
                  sw  x22, 88(x9)
                  sw  x23, 92(x9)
                  sw  x24, 96(x9)
                  sw  x25, 100(x9)
                  sw  x26, 104(x9)
                  sw  x27, 108(x9)
                  sw  x28, 112(x9)
                  sw  x29, 116(x9)
                  sw  x30, 120(x9)
                  sw  x31, 124(x9)
                  add x4, x9, zero
                  csrr x13, 0x300 # MSTATUS
                  csrr x13, 0x342 # MCAUSE
                  srli x13, x13, 31
                  bne x13, x0, mmode_intr_handler

mmode_exception_handler:
                  csrr x13, 0x341 # MEPC
                  csrr x13, 0x342 # MCAUSE
                  li x5, 0x3 # BREAKPOINT
                  beq x13, x5, ebreak_handler
                  li x5, 0x8 # ECALL_UMODE
                  beq x13, x5, ecall_handler
                  li x5, 0x9 # ECALL_SMODE
                  beq x13, x5, ecall_handler
                  li x5, 0xb # ECALL_MMODE
                  beq x13, x5, ecall_handler
                  li x5, 0x1
                  beq x13, x5, instr_fault_handler
                  li x5, 0x5
                  beq x13, x5, load_fault_handler
                  li x5, 0x7
                  beq x13, x5, store_fault_handler
                  li x5, 0xc
                  beq x13, x5, pt_fault_handler
                  li x5, 0xd
                  beq x13, x5, pt_fault_handler
                  li x5, 0xf
                  beq x13, x5, pt_fault_handler
                  li x5, 0x2 # ILLEGAL_INSTRUCTION
                  beq x13, x5, illegal_instr_handler
                  csrr x5, 0x343 # MTVAL
                  1: la x29, test_done
                  jalr x1, x29, 0

ecall_handler:    
                  la x13, _start
                  sw x0, 0(x13)
                  sw x1, 4(x13)
                  sw x2, 8(x13)
                  sw x3, 12(x13)
                  sw x4, 16(x13)
                  sw x5, 20(x13)
                  sw x6, 24(x13)
                  sw x7, 28(x13)
                  sw x8, 32(x13)
                  sw x9, 36(x13)
                  sw x10, 40(x13)
                  sw x11, 44(x13)
                  sw x12, 48(x13)
                  sw x13, 52(x13)
                  sw x14, 56(x13)
                  sw x15, 60(x13)
                  sw x16, 64(x13)
                  sw x17, 68(x13)
                  sw x18, 72(x13)
                  sw x19, 76(x13)
                  sw x20, 80(x13)
                  sw x21, 84(x13)
                  sw x22, 88(x13)
                  sw x23, 92(x13)
                  sw x24, 96(x13)
                  sw x25, 100(x13)
                  sw x26, 104(x13)
                  sw x27, 108(x13)
                  sw x28, 112(x13)
                  sw x29, 116(x13)
                  sw x30, 120(x13)
                  sw x31, 124(x13)
                  la x29, write_tohost
                  jalr x0, x29, 0

instr_fault_handler:
                  add x9, x4, zero
                  lw  x1, 4(x9)
                  lw  x2, 8(x9)
                  lw  x3, 12(x9)
                  lw  x4, 16(x9)
                  lw  x5, 20(x9)
                  lw  x6, 24(x9)
                  lw  x7, 28(x9)
                  lw  x8, 32(x9)
                  lw  x9, 36(x9)
                  lw  x10, 40(x9)
                  lw  x11, 44(x9)
                  lw  x12, 48(x9)
                  lw  x13, 52(x9)
                  lw  x14, 56(x9)
                  lw  x15, 60(x9)
                  lw  x16, 64(x9)
                  lw  x17, 68(x9)
                  lw  x18, 72(x9)
                  lw  x19, 76(x9)
                  lw  x20, 80(x9)
                  lw  x21, 84(x9)
                  lw  x22, 88(x9)
                  lw  x23, 92(x9)
                  lw  x24, 96(x9)
                  lw  x25, 100(x9)
                  lw  x26, 104(x9)
                  lw  x27, 108(x9)
                  lw  x28, 112(x9)
                  lw  x29, 116(x9)
                  lw  x30, 120(x9)
                  lw  x31, 124(x9)
                  addi x9, x9, 128
                  add x4, x9, zero
                  lw  x9, (x4)
                  addi x4, x4, 4
                  mret

load_fault_handler:
                  add x9, x4, zero
                  lw  x1, 4(x9)
                  lw  x2, 8(x9)
                  lw  x3, 12(x9)
                  lw  x4, 16(x9)
                  lw  x5, 20(x9)
                  lw  x6, 24(x9)
                  lw  x7, 28(x9)
                  lw  x8, 32(x9)
                  lw  x9, 36(x9)
                  lw  x10, 40(x9)
                  lw  x11, 44(x9)
                  lw  x12, 48(x9)
                  lw  x13, 52(x9)
                  lw  x14, 56(x9)
                  lw  x15, 60(x9)
                  lw  x16, 64(x9)
                  lw  x17, 68(x9)
                  lw  x18, 72(x9)
                  lw  x19, 76(x9)
                  lw  x20, 80(x9)
                  lw  x21, 84(x9)
                  lw  x22, 88(x9)
                  lw  x23, 92(x9)
                  lw  x24, 96(x9)
                  lw  x25, 100(x9)
                  lw  x26, 104(x9)
                  lw  x27, 108(x9)
                  lw  x28, 112(x9)
                  lw  x29, 116(x9)
                  lw  x30, 120(x9)
                  lw  x31, 124(x9)
                  addi x9, x9, 128
                  add x4, x9, zero
                  lw  x9, (x4)
                  addi x4, x4, 4
                  mret

store_fault_handler:
                  add x9, x4, zero
                  lw  x1, 4(x9)
                  lw  x2, 8(x9)
                  lw  x3, 12(x9)
                  lw  x4, 16(x9)
                  lw  x5, 20(x9)
                  lw  x6, 24(x9)
                  lw  x7, 28(x9)
                  lw  x8, 32(x9)
                  lw  x9, 36(x9)
                  lw  x10, 40(x9)
                  lw  x11, 44(x9)
                  lw  x12, 48(x9)
                  lw  x13, 52(x9)
                  lw  x14, 56(x9)
                  lw  x15, 60(x9)
                  lw  x16, 64(x9)
                  lw  x17, 68(x9)
                  lw  x18, 72(x9)
                  lw  x19, 76(x9)
                  lw  x20, 80(x9)
                  lw  x21, 84(x9)
                  lw  x22, 88(x9)
                  lw  x23, 92(x9)
                  lw  x24, 96(x9)
                  lw  x25, 100(x9)
                  lw  x26, 104(x9)
                  lw  x27, 108(x9)
                  lw  x28, 112(x9)
                  lw  x29, 116(x9)
                  lw  x30, 120(x9)
                  lw  x31, 124(x9)
                  addi x9, x9, 128
                  add x4, x9, zero
                  lw  x9, (x4)
                  addi x4, x4, 4
                  mret

ebreak_handler:   
                  csrr  x13, 0x341
                  addi  x13, x13, 4
                  csrw  0x341, x13
                  add x9, x4, zero
                  lw  x1, 4(x9)
                  lw  x2, 8(x9)
                  lw  x3, 12(x9)
                  lw  x4, 16(x9)
                  lw  x5, 20(x9)
                  lw  x6, 24(x9)
                  lw  x7, 28(x9)
                  lw  x8, 32(x9)
                  lw  x9, 36(x9)
                  lw  x10, 40(x9)
                  lw  x11, 44(x9)
                  lw  x12, 48(x9)
                  lw  x13, 52(x9)
                  lw  x14, 56(x9)
                  lw  x15, 60(x9)
                  lw  x16, 64(x9)
                  lw  x17, 68(x9)
                  lw  x18, 72(x9)
                  lw  x19, 76(x9)
                  lw  x20, 80(x9)
                  lw  x21, 84(x9)
                  lw  x22, 88(x9)
                  lw  x23, 92(x9)
                  lw  x24, 96(x9)
                  lw  x25, 100(x9)
                  lw  x26, 104(x9)
                  lw  x27, 108(x9)
                  lw  x28, 112(x9)
                  lw  x29, 116(x9)
                  lw  x30, 120(x9)
                  lw  x31, 124(x9)
                  addi x9, x9, 128
                  add x4, x9, zero
                  lw  x9, (x4)
                  addi x4, x4, 4
                  mret

illegal_instr_handler:
                  csrr  x13, 0x341
                  addi  x13, x13, 4
                  csrw  0x341, x13
                  add x9, x4, zero
                  lw  x1, 4(x9)
                  lw  x2, 8(x9)
                  lw  x3, 12(x9)
                  lw  x4, 16(x9)
                  lw  x5, 20(x9)
                  lw  x6, 24(x9)
                  lw  x7, 28(x9)
                  lw  x8, 32(x9)
                  lw  x9, 36(x9)
                  lw  x10, 40(x9)
                  lw  x11, 44(x9)
                  lw  x12, 48(x9)
                  lw  x13, 52(x9)
                  lw  x14, 56(x9)
                  lw  x15, 60(x9)
                  lw  x16, 64(x9)
                  lw  x17, 68(x9)
                  lw  x18, 72(x9)
                  lw  x19, 76(x9)
                  lw  x20, 80(x9)
                  lw  x21, 84(x9)
                  lw  x22, 88(x9)
                  lw  x23, 92(x9)
                  lw  x24, 96(x9)
                  lw  x25, 100(x9)
                  lw  x26, 104(x9)
                  lw  x27, 108(x9)
                  lw  x28, 112(x9)
                  lw  x29, 116(x9)
                  lw  x30, 120(x9)
                  lw  x31, 124(x9)
                  addi x9, x9, 128
                  add x4, x9, zero
                  lw  x9, (x4)
                  addi x4, x4, 4
                  mret

pt_fault_handler: 
                  nop

.align 2
mmode_intr_handler:
                  csrr  x13, 0x300 # MSTATUS;
                  csrr  x13, 0x304 # MIE;
                  csrr  x13, 0x344 # MIP;
                  csrrc x13, 0x344, x13 # MIP;
                  add x9, x4, zero
                  lw  x1, 4(x9)
                  lw  x2, 8(x9)
                  lw  x3, 12(x9)
                  lw  x4, 16(x9)
                  lw  x5, 20(x9)
                  lw  x6, 24(x9)
                  lw  x7, 28(x9)
                  lw  x8, 32(x9)
                  lw  x9, 36(x9)
                  lw  x10, 40(x9)
                  lw  x11, 44(x9)
                  lw  x12, 48(x9)
                  lw  x13, 52(x9)
                  lw  x14, 56(x9)
                  lw  x15, 60(x9)
                  lw  x16, 64(x9)
                  lw  x17, 68(x9)
                  lw  x18, 72(x9)
                  lw  x19, 76(x9)
                  lw  x20, 80(x9)
                  lw  x21, 84(x9)
                  lw  x22, 88(x9)
                  lw  x23, 92(x9)
                  lw  x24, 96(x9)
                  lw  x25, 100(x9)
                  lw  x26, 104(x9)
                  lw  x27, 108(x9)
                  lw  x28, 112(x9)
                  lw  x29, 116(x9)
                  lw  x30, 120(x9)
                  lw  x31, 124(x9)
                  addi x9, x9, 128
                  add x4, x9, zero
                  lw  x9, (x4)
                  addi x4, x4, 4
                  mret;

kernel_instr_end: nop
.section .kernel_stack,"aw",@progbits;
.align 2
kernel_stack_start:
.rept 3999
.4byte 0x0
.endr
kernel_stack_end:
.4byte 0x0
