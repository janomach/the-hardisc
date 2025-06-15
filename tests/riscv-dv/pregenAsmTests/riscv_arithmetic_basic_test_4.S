.include "user_define.h"
.globl _start
.section .text
_start:           
                  .include "user_init.s"
                  csrr x5, 0xf14
                  li x6, 0
                  beq x5, x6, 0f

0: la x19, h0_start
jalr x0, x19, 0
h0_start:
                  li x9, 0x40001104
                  csrw 0x301, x9
kernel_sp:        
                  la x23, kernel_stack_end

trap_vec_init:    
                  la x9, mtvec_handler
                  ori x9, x9, 0
                  csrw 0x305, x9 # MTVEC

mepc_setup:       
                  la x9, init
                  csrw 0x341, x9

custom_csr_setup: 
                  nop

init_machine_mode:
                  li x9, 0x1800
                  csrw 0x300, x9 # MSTATUS
                  li x9, 0x0
                  csrw 0x304, x9 # MIE
                  mret
init:             
                  li x0, 0xf026d3f9
                  li x1, 0x0
                  li x2, 0x0
                  li x3, 0xf6aed279
                  li x4, 0xadea0b77
                  li x5, 0x80000000
                  li x7, 0x7
                  li x8, 0x867501e7
                  li x9, 0xb200fb9d
                  li x10, 0xc34239fe
                  li x11, 0x0
                  li x12, 0x0
                  li x13, 0xb8bc8ade
                  li x14, 0x749e0840
                  li x15, 0x2d304f38
                  li x16, 0x0
                  li x17, 0x80000000
                  li x18, 0x9
                  li x19, 0x4
                  li x20, 0xffec25e6
                  li x21, 0xfafdd71d
                  li x22, 0xfba10cfc
                  li x24, 0xfbbd4172
                  li x25, 0xfc005ede
                  li x26, 0xfc15cdbf
                  li x27, 0xf2e3561f
                  li x28, 0xe1f6f79
                  li x29, 0x80000000
                  li x30, 0xa4e8d937
                  li x31, 0x80000000
                  la x6, user_stack_end
main:             li           t6, 0xffffffff #start riscv_int_numeric_corner_stream_14
                  li           a7, 0x0
                  li           a1, 0x21239558
                  li           t0, 0x0
                  li           s0, 0xd5471b2f
                  li           a6, 0xffffffff
                  li           ra, 0xffffffff
                  li           s4, 0x80000000
                  li           a3, 0x0
                  li           s11, 0x80000000
                  lui          a7, 776121
                  lui          a7, 776121
                  mul          s0, a7, a7
                  lui          a7, 776121
                  divu         s4, s0, t6
                  mul          s0, a7, a7
                  lui          a7, 776121
                  div          s4, s4, s11
                  div          s4, s4, s11
                  rem          a3, ra, a7
                  mulhsu       ra, s11, s0
                  rem          a3, ra, a7
                  mulh         s11, t6, a1
                  mulh         s11, t6, a1
                  sub          s11, s4, a3
                  add          a3, s0, t0
                  nop
                  divu         s4, s0, t6 #end riscv_int_numeric_corner_stream_14
                  li           t5, 0x80000000 #start riscv_int_numeric_corner_stream_13
                  li           a5, 0x8057e99f
                  li           t3, 0x80000000
                  li           s9, 0xffffffff
                  li           s11, 0x80000000
                  li           tp, 0xa440a2e
                  li           s4, 0x69e2797a
                  li           s5, 0xffffffff
                  li           gp, 0x0
                  li           t4, 0x80000000
                  mulhsu       gp, t4, a5
                  add          s5, a5, tp
                  lui          s11, 776121
                  lui          s11, 776121
                  auipc        t4, 881820
                  auipc        t4, 881820
                  mulh         t4, t5, s4
                  divu         t3, a5, t5
                  divu         t3, a5, t5
                  mulh         t4, t5, s4
                  remu         s5, t4, a5
                  lui          s11, 776121
                  sub          t4, t3, s5
                  sub          t4, t3, s5
                  mul          a5, s11, s11
                  auipc        t4, 881820 #end riscv_int_numeric_corner_stream_13
                  li           a3, 0x0 #start riscv_int_numeric_corner_stream_9
                  li           s9, 0xffffffff
                  li           sp, 0x0
                  li           a4, 0x80000000
                  li           t3, 0x0
                  li           s8, 0x0
                  li           a5, 0x0
                  li           s6, 0x80000000
                  li           gp, 0xffffffff
                  li           t0, 0x90d05c5f
                  addi         a5, t0, 596
                  add          a4, t0, gp
                  addi         a5, t0, 596
                  add          a4, t0, gp
                  divu         s8, t0, t3
                  auipc        s9, 881820
                  auipc        s9, 881820
                  nop
                  nop
                  mul          t0, s6, s6
                  addi         a5, t0, 596
                  divu         s8, t0, t3
                  mulh         s9, t3, a3
                  mulhu        s6, a5, a3
                  div          s8, s8, s9
                  sub          s9, s8, a4
                  mulh         s9, t3, a3
                  mulhu        s6, a5, a3
                  mulhsu       sp, s9, t0
                  rem          a4, sp, s6
                  divu         s8, t0, t3
                  mulh         s9, t3, a3
                  mul          t0, s6, s6
                  add          a4, t0, gp
                  addi         a5, t0, 596
                  mul          t0, s6, s6
                  divu         s8, t0, t3
                  add          a4, t0, gp
                  mulhsu       sp, s9, t0 #end riscv_int_numeric_corner_stream_9
                  li           t0, 0x80000000 #start riscv_int_numeric_corner_stream_23
                  li           s5, 0xd46d76a7
                  li           s9, 0x80000000
                  li           t4, 0xffffffff
                  li           tp, 0x0
                  li           a0, 0x80000000
                  li           s8, 0xa46075b2
                  li           t2, 0xffffffff
                  li           a2, 0x0
                  li           a3, 0x0
                  divu         s8, t2, t4
                  divu         s8, t2, t4
                  auipc        s9, 881820
                  rem          a2, tp, s5
                  nop
                  add          a2, t2, t0
                  addi         a3, t2, 596
                  lui          s5, 776121
                  sub          s9, s8, a2
                  nop
                  mul          t2, s5, s5
                  nop
                  add          a2, t2, t0
                  mulh         s9, t4, a0
                  rem          a2, tp, s5
                  mul          t2, s5, s5
                  mulhu        s5, a3, a0 #end riscv_int_numeric_corner_stream_23
                  li           t0, 0x80000000 #start riscv_int_numeric_corner_stream_4
                  li           tp, 0xf4f5dc3d
                  li           a6, 0xffffffff
                  li           s1, 0x80000000
                  li           t6, 0x699585be
                  li           a0, 0x0
                  li           sp, 0x80000000
                  li           t5, 0xffffffff
                  li           s0, 0x4fb346ff
                  li           s5, 0x1db4c447
                  mulh         t5, t6, s0
                  mulhsu       sp, t5, t0
                  addi         a0, t0, 596
                  divu         s5, t0, t6
                  rem          s1, sp, a6
                  nop
                  mulhsu       sp, t5, t0
                  addi         a0, t0, 596
                  addi         a0, t0, 596
                  add          s1, t0, tp
                  mulh         t5, t6, s0
                  sub          t5, s5, s1
                  nop
                  mul          t0, a6, a6
                  mulh         t5, t6, s0
                  mulh         t5, t6, s0
                  auipc        t5, 881820
                  remu         s1, t5, t0
                  add          s1, t0, tp #end riscv_int_numeric_corner_stream_4
                  li           a0, 0x80000000 #start riscv_int_numeric_corner_stream_36
                  li           a4, 0x1a850d2c
                  li           a1, 0x4859fa47
                  li           a3, 0xffffffff
                  li           s8, 0xffffffff
                  li           s9, 0xffffffff
                  li           t5, 0xd4000672
                  li           a7, 0xd71f926
                  li           tp, 0xffffffff
                  li           s6, 0x4bbc9f16
                  mulhsu       tp, s9, a1
                  div          s8, s8, s9
                  div          s8, s8, s9
                  addi         a7, a1, 596
                  auipc        s9, 881820
                  mulh         s9, t5, a3
                  lui          s6, 776121
                  addi         a7, a1, 596
                  mul          a1, s6, s6
                  div          s8, s8, s9
                  nop
                  mulhu        s6, a7, a3
                  nop
                  divu         s8, a1, t5
                  mulhsu       tp, s9, a1
                  mulhsu       tp, s9, a1
                  nop
                  addi         a7, a1, 596
                  mul          a1, s6, s6
                  nop
                  lui          s6, 776121
                  mul          a1, s6, s6
                  mulhu        s6, a7, a3
                  add          a4, a1, a0
                  nop #end riscv_int_numeric_corner_stream_36
                  li           s2, 0x7d84b9cb #start riscv_int_numeric_corner_stream_15
                  li           t2, 0x6dc6daed
                  li           gp, 0x4195d52e
                  li           a7, 0x0
                  li           s11, 0x54d03fbe
                  li           s5, 0x628ff885
                  li           a2, 0x80000000
                  li           sp, 0x0
                  li           a3, 0x0
                  li           s9, 0xffffffff
                  nop
                  add          a3, t2, gp
                  mulhu        s2, a7, a2
                  lui          s2, 776121
                  divu         s5, t2, s11
                  add          a3, t2, gp
                  auipc        s9, 881820
                  mul          t2, s2, s2
                  remu         a3, s9, t2
                  sub          s9, s5, a3
                  divu         s5, t2, s11
                  remu         a3, s9, t2
                  lui          s2, 776121
                  divu         s5, t2, s11
                  mulh         s9, s11, a2
                  mul          t2, s2, s2
                  sub          s9, s5, a3
                  mul          t2, s2, s2
                  rem          a3, sp, s2
                  mul          t2, s2, s2
                  div          s5, s5, s9
                  remu         a3, s9, t2
                  rem          a3, sp, s2
                  rem          a3, sp, s2
                  divu         s5, t2, s11
                  sub          s9, s5, a3
                  auipc        s9, 881820
                  rem          a3, sp, s2 #end riscv_int_numeric_corner_stream_15
                  li           a1, 0x0 #start riscv_int_numeric_corner_stream_22
                  li           ra, 0x0
                  li           a5, 0xdbcf017
                  li           gp, 0x9c7bb8b0
                  li           a4, 0x8d6b8eda
                  li           t5, 0xffffffff
                  li           s2, 0x2c214a12
                  li           s5, 0x203ce52a
                  li           s10, 0xffffffff
                  li           s0, 0x0
                  rem          a4, ra, s2
                  remu         a4, s10, s0
                  lui          s2, 776121
                  rem          a4, ra, s2
                  add          a4, s0, gp
                  addi         a5, s0, 596
                  rem          a4, ra, s2
                  div          s5, s5, s10
                  sub          s10, s5, a4
                  sub          s10, s5, a4
                  mulhu        s2, a5, a1
                  addi         a5, s0, 596
                  addi         a5, s0, 596
                  mulhu        s2, a5, a1
                  sub          s10, s5, a4
                  divu         s5, s0, t5
                  div          s5, s5, s10
                  divu         s5, s0, t5
                  mul          s0, s2, s2
                  lui          s2, 776121
                  rem          a4, ra, s2
                  div          s5, s5, s10
                  lui          s2, 776121
                  mulhsu       ra, s10, s0
                  mulhu        s2, a5, a1
                  divu         s5, s0, t5
                  divu         s5, s0, t5 #end riscv_int_numeric_corner_stream_22
                  li           a2, 0x63768134 #start riscv_int_numeric_corner_stream_33
                  li           s1, 0xb72d2f1a
                  li           a1, 0xffffffff
                  li           gp, 0x80000000
                  li           sp, 0x3bf491bc
                  li           a0, 0x80000000
                  li           s9, 0xffffffff
                  li           s4, 0xe25a4be0
                  li           t0, 0xffffffff
                  li           s6, 0x0
                  add          a0, t0, gp
                  sub          s6, s4, a0
                  remu         a0, s6, t0
                  rem          a0, sp, a2
                  sub          s6, s4, a0
                  sub          s6, s4, a0
                  remu         a0, s6, t0
                  mul          t0, a2, a2
                  rem          a0, sp, a2
                  rem          a0, sp, a2
                  auipc        s6, 881820
                  mul          t0, a2, a2
                  lui          a2, 776121
                  addi         a1, t0, 596
                  mul          t0, a2, a2 #end riscv_int_numeric_corner_stream_33
                  li           s1, 0xffffffff #start riscv_int_numeric_corner_stream_6
                  li           s9, 0xffffffff
                  li           a5, 0x80000000
                  li           ra, 0x0
                  li           a3, 0xaff86962
                  li           s6, 0x80000000
                  li           s0, 0xffffffff
                  li           a4, 0x0
                  li           gp, 0x80000000
                  li           s8, 0x0
                  mul          s0, a5, a5
                  mulhu        a5, a4, s1
                  mulh         s8, s9, s1
                  auipc        s8, 881820
                  mulh         s8, s9, s1
                  lui          a5, 776121
                  mul          s0, a5, a5
                  mulhu        a5, a4, s1
                  divu         s6, s0, s9
                  remu         a3, s8, s0
                  remu         a3, s8, s0
                  auipc        s8, 881820
                  mulhsu       ra, s8, s0
                  add          a3, s0, gp
                  div          s6, s6, s8
                  sub          s8, s6, a3
                  mulhu        a5, a4, s1
                  mulhsu       ra, s8, s0 #end riscv_int_numeric_corner_stream_6
                  li           a1, 0x6febb246 #start riscv_int_numeric_corner_stream_30
                  li           s6, 0xffffffff
                  li           tp, 0x80000000
                  li           a0, 0x0
                  li           s4, 0xffffffff
                  li           s11, 0xf413300c
                  li           a2, 0xffffffff
                  li           t4, 0xffffffff
                  li           t5, 0x80000000
                  li           sp, 0xffffffff
                  nop
                  nop
                  addi         s4, a0, 596
                  lui          s6, 776121
                  div          s11, s11, t4
                  mulhu        s6, s4, a1
                  addi         s4, a0, 596
                  mul          a0, s6, s6
                  sub          t4, s11, a2
                  mulh         t4, t5, a1
                  mulhu        s6, s4, a1
                  mulhsu       sp, t4, a0
                  sub          t4, s11, a2
                  rem          a2, sp, s6
                  auipc        t4, 881820
                  addi         s4, a0, 596
                  div          s11, s11, t4
                  remu         a2, t4, a0
                  div          s11, s11, t4
                  add          a2, a0, tp
                  lui          s6, 776121
                  mulhu        s6, s4, a1
                  remu         a2, t4, a0 #end riscv_int_numeric_corner_stream_30
                  li           a3, 0x80000000 #start riscv_int_numeric_corner_stream_37
                  li           a0, 0x80000000
                  li           a2, 0x6ecb10b6
                  li           a4, 0x2d43dba7
                  li           a7, 0xffffffff
                  li           s11, 0xffffffff
                  li           sp, 0xffffffff
                  li           t0, 0x0
                  li           t3, 0xffffffff
                  li           a5, 0x0
                  mul          a0, a5, a5
                  lui          a5, 776121
                  div          a7, a7, s11
                  add          a3, a0, t0
                  mul          a0, a5, a5
                  lui          a5, 776121
                  mulh         s11, t3, a2
                  auipc        s11, 881820
                  divu         a7, a0, t3
                  nop
                  rem          a3, sp, a5
                  nop
                  divu         a7, a0, t3
                  add          a3, a0, t0
                  mul          a0, a5, a5
                  nop
                  addi         a4, a0, 596
                  nop
                  add          a3, a0, t0
                  remu         a3, s11, a0
                  mul          a0, a5, a5
                  auipc        s11, 881820
                  nop
                  addi         a4, a0, 596
                  divu         a7, a0, t3
                  div          a7, a7, s11
                  sub          s11, a7, a3 #end riscv_int_numeric_corner_stream_37
                  li           a7, 0x80000000 #start riscv_int_numeric_corner_stream_2
                  li           s8, 0x3d974754
                  li           t4, 0x0
                  li           t5, 0x80000000
                  li           a6, 0x165aea08
                  li           sp, 0x80000000
                  li           a2, 0xffffffff
                  li           t3, 0x70d4520b
                  li           s1, 0x7fe002db
                  li           s10, 0xffffffff
                  mulhsu       sp, t4, a2
                  divu         t3, a2, t5
                  mul          a2, s10, s10
                  auipc        t4, 881820
                  mulhu        s10, s8, a6
                  lui          s10, 776121
                  mul          a2, s10, s10
                  mulhu        s10, s8, a6
                  add          a7, a2, s1
                  rem          a7, sp, s10
                  div          t3, t3, t4
                  rem          a7, sp, s10
                  div          t3, t3, t4
                  lui          s10, 776121
                  nop
                  mulhsu       sp, t4, a2
                  auipc        t4, 881820
                  mulhsu       sp, t4, a2
                  divu         t3, a2, t5 #end riscv_int_numeric_corner_stream_2
                  li           a0, 0x80000000 #start riscv_int_numeric_corner_stream_8
                  li           a7, 0x80000000
                  li           s1, 0xffffffff
                  li           a5, 0xc9521980
                  li           t0, 0x0
                  li           gp, 0xffffffff
                  li           a1, 0xff27b8b
                  li           tp, 0xffffffff
                  li           t5, 0x5c7cb8ce
                  li           s11, 0xe893509d
                  rem          a0, gp, a5
                  add          a0, t0, tp
                  lui          a5, 776121
                  nop
                  remu         a0, s11, t0
                  mulhu        a5, a1, s1
                  rem          a0, gp, a5
                  div          a7, a7, s11
                  mul          t0, a5, a5
                  mulhu        a5, a1, s1
                  sub          s11, a7, a0
                  lui          a5, 776121
                  mulhu        a5, a1, s1
                  divu         a7, t0, t5
                  nop
                  div          a7, a7, s11
                  lui          a5, 776121
                  mul          t0, a5, a5
                  mulhsu       gp, s11, t0
                  sub          s11, a7, a0 #end riscv_int_numeric_corner_stream_8
                  sltu         s8, s9, s11
                  sub          s11, t4, a3
                  addi         s8, s2, 596
                  mulhu        t2, s5, t5
                  andi         t0, s11, 1760
                  rem          s6, a2, t4
                  mul          a1, s6, s6
                  add          s6, s2, s10
                  mulhu        t2, s5, t5
                  nop
                  c.li         a0, 21
                  sub          s11, t4, a3
                  srli         sp, s3, 10
                  slt          t4, s3, s11
                  c.mv         s8, a5
                  sltiu        a1, s4, 1988
                  slli         s4, a5, 26
                  c.and        s0, a3
                  c.li         a0, 21
                  c.xor        s0, a5
                  mul          a1, s6, s6
                  ori          s6, t3, 246
                  sltu         s8, s9, s11
                  c.addi16sp   sp, 400
                  c.lui        s8, 31
                  c.mv         s8, a5
                  div          s0, t2, a0
                  or           a4, s7, s8
                  andi         t0, s11, 1760
                  lui          t2, 776121
                  c.andi       a0, -1
                  div          s0, t2, a0
                  c.srai       a2, 4
                  rem          s6, a2, t4
                  rem          s6, a2, t4
                  c.and        s0, a3
                  c.or         a2, a5
                  slti         gp, tp, -1791
                  sltiu        a1, s4, 1988
                  div          s0, t2, a0
                  slli         s4, a5, 26
                  mul          a1, s6, s6
                  andi         t0, s11, 1760
                  sltu         s8, s9, s11
                  c.add        t2, s3
                  andi         t0, s11, 1760
                  c.addi4spn   s1, sp, 32
                  rem          s6, a2, t4
                  rem          s6, a2, t4
                  lui          t2, 776121
                  mulhsu       a7, s0, t4
                  c.addi4spn   s1, sp, 32
                  div          s0, t2, a0
                  sltiu        a1, s4, 1988
                  c.addi       t4, 20
                  c.nop
                  c.mv         s8, a5
                  sra          s8, a5, s8
                  c.slli       s11, 17
                  c.mv         s8, a5
                  divu         s10, sp, s1
                  c.srai       a2, 4
                  andi         t0, s11, 1760
                  c.srai       a2, 4
                  srai         t0, t0, 4
                  mulh         s11, s9, gp
                  or           a4, s7, s8
                  divu         s10, sp, s1
                  ori          s6, t3, 246
                  addi         s8, s2, 596
                  lui          t2, 776121
                  mulh         s11, s9, gp
                  sub          s11, t4, a3
                  ori          s6, t3, 246
                  lui          t2, 776121
                  c.srli       a0, 28
                  sltiu        a1, s4, 1988
                  c.addi16sp   sp, 400
                  and          t5, t0, a7
                  sub          s11, t4, a3
                  c.srli       a0, 28
                  xor          a4, s11, s7
                  xor          a4, s11, s7
                  srl          gp, a7, s6
                  div          s0, t2, a0
                  c.addi       t4, 20
                  c.addi16sp   sp, 400
                  sltu         s8, s9, s11
                  slti         gp, tp, -1791
                  xor          a4, s11, s7
                  c.add        t2, s3
                  sra          s8, a5, s8
                  or           a4, s7, s8
                  slti         gp, tp, -1791
                  c.addi       t4, 20
                  addi         s8, s2, 596
                  sltiu        a1, s4, 1988
                  c.addi4spn   s1, sp, 32
                  c.addi4spn   s1, sp, 32
                  and          t5, t0, a7
                  mul          a1, s6, s6
                  mul          a1, s6, s6
                  slt          t4, s3, s11
                  sll          s8, a6, a2
                  c.mv         s8, a5
                  addi         s8, s2, 596
                  c.nop
                  divu         s10, sp, s1
                  srai         t0, t0, 4
                  sll          s8, a6, a2
                  c.sub        a3, s1
                  c.and        s0, a3
                  srai         t0, t0, 4
                  div          s0, t2, a0
                  c.andi       a0, -1
                  xori         a3, s3, -1008
                  c.addi4spn   s1, sp, 32
                  c.addi4spn   s1, sp, 32
                  mulh         s11, s9, gp
                  c.addi       t4, 20
                  nop
                  c.andi       a0, -1
                  lui          t2, 776121
                  c.srai       a2, 4
                  c.addi4spn   s1, sp, 32
                  c.add        t2, s3
                  sll          s8, a6, a2
                  c.nop
                  rem          s6, a2, t4
                  or           a4, s7, s8
                  sltiu        a1, s4, 1988
                  c.srai       a2, 4
                  mul          a1, s6, s6
                  slt          t4, s3, s11
                  c.andi       a0, -1
                  sub          s11, t4, a3
                  ori          s6, t3, 246
                  sll          s8, a6, a2
                  ori          s6, t3, 246
                  mulh         s11, s9, gp
                  ori          s6, t3, 246
                  sltu         s8, s9, s11
                  mul          a1, s6, s6
                  c.andi       a0, -1
                  c.xor        s0, a5
                  nop
                  nop
                  c.and        s0, a3
                  slti         gp, tp, -1791
                  sltu         s8, s9, s11
                  xor          a4, s11, s7
                  c.xor        s0, a5
                  c.mv         s8, a5
                  c.li         a0, 21
                  srl          gp, a7, s6
                  xori         a3, s3, -1008
                  sltiu        a1, s4, 1988
                  c.sub        a3, s1
                  nop
                  c.mv         s8, a5
                  ori          s6, t3, 246
                  c.addi16sp   sp, 400
                  c.andi       a0, -1
                  add          s6, s2, s10
                  mul          a1, s6, s6
                  div          s0, t2, a0
                  c.li         a0, 21
                  c.nop
                  slt          t4, s3, s11
                  ori          s6, t3, 246
                  mul          a1, s6, s6
                  slt          t4, s3, s11
                  slt          t4, s3, s11
                  mul          a1, s6, s6
                  add          s6, s2, s10
                  c.addi16sp   sp, 400
                  andi         t0, s11, 1760
                  sll          s8, a6, a2
                  sll          s8, a6, a2
                  mulh         s11, s9, gp
                  mulhu        t2, s5, t5
                  srli         sp, s3, 10
                  mul          a1, s6, s6
                  mulhu        t2, s5, t5
                  nop
                  mulhu        t2, s5, t5
                  c.lui        s8, 31
                  addi         s8, s2, 596
                  andi         t0, s11, 1760
                  add          s6, s2, s10
                  addi         s8, s2, 596
                  slli         s4, a5, 26
                  c.addi4spn   s1, sp, 32
                  ori          s6, t3, 246
                  mulh         s11, s9, gp
                  c.xor        s0, a5
                  srli         sp, s3, 10
                  rem          s6, a2, t4
                  srl          gp, a7, s6
                  slti         gp, tp, -1791
                  rem          s6, a2, t4
                  c.mv         s8, a5
                  c.li         a0, 21
                  c.li         a0, 21
                  sll          s8, a6, a2
                  sub          s11, t4, a3
                  c.srai       a2, 4
                  add          s6, s2, s10
                  slti         gp, tp, -1791
                  xor          a4, s11, s7
                  xor          a4, s11, s7
                  divu         s10, sp, s1
                  c.add        t2, s3
                  mul          a1, s6, s6
                  c.srai       a2, 4
                  srl          gp, a7, s6
                  c.nop
                  mulhu        t2, s5, t5
                  c.li         a0, 21
                  c.srli       a0, 28
                  c.sub        a3, s1
                  c.and        s0, a3
                  c.or         a2, a5
                  c.li         a0, 21
                  c.addi4spn   s1, sp, 32
                  srli         sp, s3, 10
                  c.mv         s8, a5
                  c.addi       t4, 20
                  mulh         s11, s9, gp
                  rem          s6, a2, t4
                  sub          s11, t4, a3
                  c.or         a2, a5
                  srl          gp, a7, s6
                  mulh         s11, s9, gp
                  slli         s4, a5, 26
                  sltu         s8, s9, s11
                  li           a6, 0xa1ffaa1f #start riscv_int_numeric_corner_stream_3
                  li           t4, 0x0
                  li           t6, 0x80000000
                  li           t0, 0x80000000
                  li           t5, 0x0
                  li           sp, 0xffffffff
                  li           a0, 0x80000000
                  li           s9, 0xffffffff
                  li           s6, 0x80000000
                  li           t3, 0xffffffff
                  add          s6, a0, t0
                  lui          t3, 776121
                  nop
                  mulhsu       sp, t5, a0
                  mul          a0, t3, t3
                  div          t4, t4, t5
                  nop
                  sub          t5, t4, s6
                  auipc        t5, 881820
                  auipc        t5, 881820
                  rem          s6, sp, t3
                  rem          s6, sp, t3
                  remu         s6, t5, a0
                  addi         s9, a0, 596
                  add          s6, a0, t0
                  mulhu        t3, s9, a6
                  nop
                  addi         s9, a0, 596
                  mul          a0, t3, t3
                  mul          a0, t3, t3
                  div          t4, t4, t5
                  mulhsu       sp, t5, a0
                  remu         s6, t5, a0 #end riscv_int_numeric_corner_stream_3
                  c.slli       s11, 17
                  slti         gp, tp, -1791
                  c.srli       a0, 28
                  div          s0, t2, a0
                  c.addi4spn   s1, sp, 32
                  auipc        a4, 881820
                  c.addi16sp   sp, 400
                  srli         sp, s3, 10
                  nop
                  c.and        s0, a3
                  mul          a1, s6, s6
                  c.li         a0, 21
                  c.sub        a3, s1
                  lui          t2, 776121
                  c.addi16sp   sp, 400
                  c.li         a0, 21
                  sltiu        a1, s4, 1988
                  c.addi4spn   s1, sp, 32
                  sltiu        a1, s4, 1988
                  nop
                  lui          t2, 776121
                  and          t5, t0, a7
                  mul          a1, s6, s6
                  lui          t2, 776121
                  slti         gp, tp, -1791
                  slt          t4, s3, s11
                  and          t5, t0, a7
                  c.srli       a0, 28
                  div          s0, t2, a0
                  srai         t0, t0, 4
                  div          s0, t2, a0
                  auipc        a4, 881820
                  c.nop
                  srli         sp, s3, 10
                  srli         sp, s3, 10
                  divu         s10, sp, s1
                  c.addi16sp   sp, 400
                  c.add        t2, s3
                  sltu         s8, s9, s11
                  add          s6, s2, s10
                  and          t5, t0, a7
                  sll          s8, a6, a2
                  rem          s6, a2, t4
                  or           a4, s7, s8
                  nop
                  c.addi4spn   s1, sp, 32
                  divu         s10, sp, s1
                  c.xor        s0, a5
                  sub          s11, t4, a3
                  c.addi4spn   s1, sp, 32
                  slt          t4, s3, s11
                  andi         t0, s11, 1760
                  rem          s6, a2, t4
                  sltu         s8, s9, s11
                  andi         t0, s11, 1760
                  c.nop
                  addi         s8, s2, 596
                  c.xor        s0, a5
                  sll          s8, a6, a2
                  slti         gp, tp, -1791
                  c.addi       t4, 20
                  remu         s6, a4, s2
                  and          t5, t0, a7
                  slli         s4, a5, 26
                  srli         sp, s3, 10
                  sltu         s8, s9, s11
                  remu         s6, a4, s2
                  xori         a3, s3, -1008
                  c.lui        s8, 31
                  c.addi16sp   sp, 400
                  c.srai       a2, 4
                  c.srai       a2, 4
                  srai         t0, t0, 4
                  c.andi       a0, -1
                  c.or         a2, a5
                  slt          t4, s3, s11
                  auipc        a4, 881820
                  c.srai       a2, 4
                  c.li         a0, 21
                  ori          s6, t3, 246
                  c.slli       s11, 17
                  c.andi       a0, -1
                  sra          s8, a5, s8
                  ori          s6, t3, 246
                  srl          gp, a7, s6
                  c.mv         s8, a5
                  srl          gp, a7, s6
                  ori          s6, t3, 246
                  c.srli       a0, 28
                  c.mv         s8, a5
                  and          t5, t0, a7
                  c.srli       a0, 28
                  sll          s8, a6, a2
                  andi         t0, s11, 1760
                  auipc        a4, 881820
                  srli         sp, s3, 10
                  c.srli       a0, 28
                  c.lui        s8, 31
                  div          s0, t2, a0
                  div          s0, t2, a0
                  slli         s4, a5, 26
                  c.slli       s11, 17
                  sll          s8, a6, a2
                  ori          s6, t3, 246
                  srai         t0, t0, 4
                  lui          t2, 776121
                  div          s0, t2, a0
                  sub          s11, t4, a3
                  c.xor        s0, a5
                  ori          s6, t3, 246
                  c.lui        s8, 31
                  c.sub        a3, s1
                  nop
                  c.srai       a2, 4
                  c.addi4spn   s1, sp, 32
                  c.addi16sp   sp, 400
                  div          s0, t2, a0
                  c.addi16sp   sp, 400
                  sltu         s8, s9, s11
                  c.addi       t4, 20
                  c.addi       t4, 20
                  srl          gp, a7, s6
                  c.addi16sp   sp, 400
                  srli         sp, s3, 10
                  c.mv         s8, a5
                  slli         s4, a5, 26
                  srl          gp, a7, s6
                  c.addi       t4, 20
                  and          t5, t0, a7
                  mulhsu       a7, s0, t4
                  sll          s8, a6, a2
                  nop
                  c.andi       a0, -1
                  xor          a4, s11, s7
                  c.srai       a2, 4
                  srli         sp, s3, 10
                  nop
                  slti         gp, tp, -1791
                  or           a4, s7, s8
                  rem          s6, a2, t4
                  c.and        s0, a3
                  c.sub        a3, s1
                  lui          t2, 776121
                  mulhsu       a7, s0, t4
                  srli         sp, s3, 10
                  c.and        s0, a3
                  c.xor        s0, a5
                  srli         sp, s3, 10
                  c.and        s0, a3
                  auipc        a4, 881820
                  sll          s8, a6, a2
                  sra          s8, a5, s8
                  ori          s6, t3, 246
                  xori         a3, s3, -1008
                  c.addi4spn   s1, sp, 32
                  andi         t0, s11, 1760
                  sub          s11, t4, a3
                  rem          s6, a2, t4
                  c.nop
                  c.lui        s8, 31
                  sra          s8, a5, s8
                  andi         t0, s11, 1760
                  add          s6, s2, s10
                  c.nop
                  sltiu        a1, s4, 1988
                  xori         a3, s3, -1008
                  slti         gp, tp, -1791
                  lui          t2, 776121
                  c.nop
                  xor          a4, s11, s7
                  mulhu        t2, s5, t5
                  c.and        s0, a3
                  or           a4, s7, s8
                  or           a4, s7, s8
                  c.andi       a0, -1
                  mulhu        t2, s5, t5
                  auipc        a4, 881820
                  ori          s6, t3, 246
                  and          t5, t0, a7
                  c.add        t2, s3
                  mul          a1, s6, s6
                  nop
                  addi         s8, s2, 596
                  srli         sp, s3, 10
                  sll          s8, a6, a2
                  c.and        s0, a3
                  c.addi16sp   sp, 400
                  andi         t0, s11, 1760
                  xori         a3, s3, -1008
                  c.li         a0, 21
                  lui          t2, 776121
                  c.slli       s11, 17
                  remu         s6, a4, s2
                  nop
                  c.srli       a0, 28
                  c.sub        a3, s1
                  c.srli       a0, 28
                  c.andi       a0, -1
                  slt          t4, s3, s11
                  slli         s4, a5, 26
                  divu         s10, sp, s1
                  c.xor        s0, a5
                  srl          gp, a7, s6
                  mulhu        t2, s5, t5
                  mulhu        t2, s5, t5
                  slt          t4, s3, s11
                  c.srai       a2, 4
                  c.srai       a2, 4
                  srli         sp, s3, 10
                  c.andi       a0, -1
                  sll          s8, a6, a2
                  c.srli       a0, 28
                  ori          s6, t3, 246
                  srai         t0, t0, 4
                  sll          s8, a6, a2
                  mulhsu       a7, s0, t4
                  mulhsu       a7, s0, t4
                  c.srai       a2, 4
                  mul          a1, s6, s6
                  mulh         s11, s9, gp
                  lui          t2, 776121
                  c.li         a0, 21
                  c.addi       t4, 20
                  sub          s11, t4, a3
                  slti         gp, tp, -1791
                  c.lui        s8, 31
                  li           s5, 0x80000000 #start riscv_int_numeric_corner_stream_24
                  li           a4, 0x0
                  li           s11, 0x558b41c4
                  li           sp, 0xffffffff
                  li           a5, 0x9f5c8d5
                  li           a1, 0x80000000
                  li           s4, 0x80000000
                  li           ra, 0x0
                  li           a7, 0x80000000
                  li           s1, 0x74a890aa
                  mulhsu       ra, s5, s1
                  rem          a4, ra, a7
                  mul          s1, a7, a7
                  mulhu        a7, a5, a1
                  nop
                  div          s4, s4, s5
                  mulhsu       ra, s5, s1
                  mulhu        a7, a5, a1
                  divu         s4, s1, s11
                  remu         a4, s5, s1
                  sub          s5, s4, a4
                  add          a4, s1, sp
                  mulh         s5, s11, a1
                  mulh         s5, s11, a1
                  addi         a5, s1, 596
                  addi         a5, s1, 596
                  lui          a7, 776121
                  addi         a5, s1, 596
                  lui          a7, 776121
                  add          a4, s1, sp
                  addi         a5, s1, 596
                  nop
                  div          s4, s4, s5
                  auipc        s5, 881820 #end riscv_int_numeric_corner_stream_24
                  sra          s8, a5, s8
                  remu         s6, a4, s2
                  c.nop
                  srl          gp, a7, s6
                  srai         t0, t0, 4
                  ori          s6, t3, 246
                  c.addi4spn   s1, sp, 32
                  auipc        a4, 881820
                  srl          gp, a7, s6
                  add          s6, s2, s10
                  c.or         a2, a5
                  auipc        a4, 881820
                  divu         s10, sp, s1
                  add          s6, s2, s10
                  sltu         s8, s9, s11
                  c.and        s0, a3
                  c.mv         s8, a5
                  rem          s6, a2, t4
                  ori          s6, t3, 246
                  rem          s6, a2, t4
                  or           a4, s7, s8
                  nop
                  c.addi       t4, 20
                  slt          t4, s3, s11
                  c.xor        s0, a5
                  c.andi       a0, -1
                  sra          s8, a5, s8
                  sltiu        a1, s4, 1988
                  slt          t4, s3, s11
                  c.xor        s0, a5
                  and          t5, t0, a7
                  c.mv         s8, a5
                  sra          s8, a5, s8
                  c.addi       t4, 20
                  sub          s11, t4, a3
                  c.srli       a0, 28
                  slli         s4, a5, 26
                  and          t5, t0, a7
                  c.srli       a0, 28
                  slti         gp, tp, -1791
                  c.or         a2, a5
                  ori          s6, t3, 246
                  slti         gp, tp, -1791
                  c.addi4spn   s1, sp, 32
                  remu         s6, a4, s2
                  sll          s8, a6, a2
                  divu         s10, sp, s1
                  addi         s8, s2, 596
                  c.and        s0, a3
                  c.li         a0, 21
                  auipc        a4, 881820
                  c.srai       a2, 4
                  divu         s10, sp, s1
                  and          t5, t0, a7
                  lui          t2, 776121
                  mulh         s11, s9, gp
                  c.li         a0, 21
                  c.addi       t4, 20
                  c.andi       a0, -1
                  mulhsu       a7, s0, t4
                  nop
                  xor          a4, s11, s7
                  div          s0, t2, a0
                  xor          a4, s11, s7
                  mulhu        t2, s5, t5
                  srl          gp, a7, s6
                  sltu         s8, s9, s11
                  addi         s8, s2, 596
                  c.nop
                  srl          gp, a7, s6
                  srl          gp, a7, s6
                  srai         t0, t0, 4
                  c.add        t2, s3
                  c.slli       s11, 17
                  c.add        t2, s3
                  remu         s6, a4, s2
                  c.li         a0, 21
                  c.addi4spn   s1, sp, 32
                  c.addi16sp   sp, 400
                  remu         s6, a4, s2
                  c.andi       a0, -1
                  auipc        a4, 881820
                  lui          t2, 776121
                  add          s6, s2, s10
                  c.slli       s11, 17
                  c.xor        s0, a5
                  sra          s8, a5, s8
                  auipc        a4, 881820
                  c.li         a0, 21
                  addi         s8, s2, 596
                  andi         t0, s11, 1760
                  or           a4, s7, s8
                  srl          gp, a7, s6
                  sltiu        a1, s4, 1988
                  srl          gp, a7, s6
                  ori          s6, t3, 246
                  c.srai       a2, 4
                  c.xor        s0, a5
                  c.or         a2, a5
                  mul          a1, s6, s6
                  divu         s10, sp, s1
                  sll          s8, a6, a2
                  sltu         s8, s9, s11
                  sltu         s8, s9, s11
                  c.slli       s11, 17
                  c.srai       a2, 4
                  sll          s8, a6, a2
                  c.andi       a0, -1
                  div          s0, t2, a0
                  remu         s6, a4, s2
                  c.add        t2, s3
                  sltu         s8, s9, s11
                  c.addi4spn   s1, sp, 32
                  srl          gp, a7, s6
                  slti         gp, tp, -1791
                  mulhsu       a7, s0, t4
                  xor          a4, s11, s7
                  c.andi       a0, -1
                  ori          s6, t3, 246
                  c.or         a2, a5
                  remu         s6, a4, s2
                  xori         a3, s3, -1008
                  c.xor        s0, a5
                  rem          s6, a2, t4
                  ori          s6, t3, 246
                  slli         s4, a5, 26
                  add          s6, s2, s10
                  xor          a4, s11, s7
                  ori          s6, t3, 246
                  sltu         s8, s9, s11
                  c.srli       a0, 28
                  c.mv         s8, a5
                  slt          t4, s3, s11
                  c.xor        s0, a5
                  ori          s6, t3, 246
                  c.or         a2, a5
                  c.or         a2, a5
                  ori          s6, t3, 246
                  c.add        t2, s3
                  div          s0, t2, a0
                  mul          a1, s6, s6
                  and          t5, t0, a7
                  slti         gp, tp, -1791
                  c.addi16sp   sp, 400
                  xori         a3, s3, -1008
                  c.andi       a0, -1
                  lui          t2, 776121
                  slli         s4, a5, 26
                  c.nop
                  mul          a1, s6, s6
                  c.nop
                  ori          s6, t3, 246
                  mulhsu       a7, s0, t4
                  c.addi       t4, 20
                  auipc        a4, 881820
                  or           a4, s7, s8
                  c.or         a2, a5
                  sltu         s8, s9, s11
                  c.addi       t4, 20
                  mulhu        t2, s5, t5
                  xori         a3, s3, -1008
                  c.sub        a3, s1
                  mul          a1, s6, s6
                  c.slli       s11, 17
                  divu         s10, sp, s1
                  c.lui        s8, 31
                  c.nop
                  nop
                  c.nop
                  slt          t4, s3, s11
                  c.lui        s8, 31
                  sltiu        a1, s4, 1988
                  auipc        a4, 881820
                  ori          s6, t3, 246
                  slt          t4, s3, s11
                  mulh         s11, s9, gp
                  c.or         a2, a5
                  divu         s10, sp, s1
                  srai         t0, t0, 4
                  slti         gp, tp, -1791
                  addi         s8, s2, 596
                  c.slli       s11, 17
                  rem          s6, a2, t4
                  c.or         a2, a5
                  c.addi4spn   s1, sp, 32
                  c.andi       a0, -1
                  srai         t0, t0, 4
                  or           a4, s7, s8
                  ori          s6, t3, 246
                  c.addi       t4, 20
                  xor          a4, s11, s7
                  srl          gp, a7, s6
                  or           a4, s7, s8
                  slti         gp, tp, -1791
                  c.lui        s8, 31
                  c.addi16sp   sp, 400
                  c.nop
                  c.addi16sp   sp, 400
                  sra          s8, a5, s8
                  sltu         s8, s9, s11
                  srl          gp, a7, s6
                  c.slli       s11, 17
                  div          s0, t2, a0
                  c.xor        s0, a5
                  c.addi       t4, 20
                  div          s0, t2, a0
                  c.lui        s8, 31
                  xori         a3, s3, -1008
                  mul          a1, s6, s6
                  c.andi       a0, -1
                  c.slli       s11, 17
                  srai         t0, t0, 4
                  c.xor        s0, a5
                  auipc        a4, 881820
                  mulhsu       a7, s0, t4
                  mulhsu       a7, s0, t4
                  c.add        t2, s3
                  rem          s6, a2, t4
                  c.or         a2, a5
                  lui          t2, 776121
                  divu         s10, sp, s1
                  srli         sp, s3, 10
                  mulhsu       a7, s0, t4
                  srai         t0, t0, 4
                  ori          s6, t3, 246
                  c.srai       a2, 4
                  c.srai       a2, 4
                  sll          s8, a6, a2
                  divu         s10, sp, s1
                  xor          a4, s11, s7
                  c.nop
                  c.xor        s0, a5
                  c.srli       a0, 28
                  c.srai       a2, 4
                  rem          s6, a2, t4
                  c.mv         s8, a5
                  c.andi       a0, -1
                  remu         s6, a4, s2
                  ori          s6, t3, 246
                  sll          s8, a6, a2
                  c.addi4spn   s1, sp, 32
                  c.addi16sp   sp, 400
                  slt          t4, s3, s11
                  remu         s6, a4, s2
                  mulh         s11, s9, gp
                  c.mv         s8, a5
                  or           a4, s7, s8
                  c.andi       a0, -1
                  c.sub        a3, s1
                  auipc        a4, 881820
                  ori          s6, t3, 246
                  c.andi       a0, -1
                  sll          s8, a6, a2
                  slti         gp, tp, -1791
                  c.or         a2, a5
                  divu         s10, sp, s1
                  c.mv         s8, a5
                  sra          s8, a5, s8
                  c.lui        s8, 31
                  xor          a4, s11, s7
                  c.sub        a3, s1
                  c.and        s0, a3
                  auipc        a4, 881820
                  nop
                  c.add        t2, s3
                  div          s0, t2, a0
                  lui          t2, 776121
                  srai         t0, t0, 4
                  and          t5, t0, a7
                  addi         s8, s2, 596
                  auipc        a4, 881820
                  add          s6, s2, s10
                  c.and        s0, a3
                  xor          a4, s11, s7
                  sra          s8, a5, s8
                  mulh         s11, s9, gp
                  mulhsu       a7, s0, t4
                  xori         a3, s3, -1008
                  c.lui        s8, 31
                  ori          s6, t3, 246
                  mulhu        t2, s5, t5
                  and          t5, t0, a7
                  mulhu        t2, s5, t5
                  c.xor        s0, a5
                  c.add        t2, s3
                  or           a4, s7, s8
                  c.andi       a0, -1
                  remu         s6, a4, s2
                  div          s0, t2, a0
                  mulhsu       a7, s0, t4
                  and          t5, t0, a7
                  c.sub        a3, s1
                  slli         s4, a5, 26
                  or           a4, s7, s8
                  nop
                  c.addi       t4, 20
                  c.addi16sp   sp, 400
                  c.addi16sp   sp, 400
                  c.andi       a0, -1
                  and          t5, t0, a7
                  c.addi4spn   s1, sp, 32
                  xor          a4, s11, s7
                  mul          a1, s6, s6
                  c.mv         s8, a5
                  andi         t0, s11, 1760
                  add          s6, s2, s10
                  c.addi4spn   s1, sp, 32
                  slli         s4, a5, 26
                  sub          s11, t4, a3
                  divu         s10, sp, s1
                  c.add        t2, s3
                  sra          s8, a5, s8
                  c.nop
                  rem          s6, a2, t4
                  addi         s8, s2, 596
                  remu         s6, a4, s2
                  ori          s6, t3, 246
                  c.addi       t4, 20
                  c.addi       t4, 20
                  xori         a3, s3, -1008
                  c.lui        s8, 31
                  c.and        s0, a3
                  sll          s8, a6, a2
                  ori          s6, t3, 246
                  ori          s6, t3, 246
                  xori         a3, s3, -1008
                  c.andi       a0, -1
                  rem          s6, a2, t4
                  c.slli       s11, 17
                  ori          s6, t3, 246
                  c.xor        s0, a5
                  div          s0, t2, a0
                  xor          a4, s11, s7
                  c.addi16sp   sp, 400
                  c.mv         s8, a5
                  sltiu        a1, s4, 1988
                  c.lui        s8, 31
                  sra          s8, a5, s8
                  mulhsu       a7, s0, t4
                  sll          s8, a6, a2
                  c.or         a2, a5
                  slli         s4, a5, 26
                  c.addi       t4, 20
                  lui          t2, 776121
                  xor          a4, s11, s7
                  c.addi       t4, 20
                  sll          s8, a6, a2
                  sll          s8, a6, a2
                  auipc        a4, 881820
                  mul          a1, s6, s6
                  c.add        t2, s3
                  c.li         a0, 21
                  div          s0, t2, a0
                  sub          s11, t4, a3
                  srl          gp, a7, s6
                  c.xor        s0, a5
                  mulhu        t2, s5, t5
                  andi         t0, s11, 1760
                  srai         t0, t0, 4
                  c.lui        s8, 31
                  xori         a3, s3, -1008
                  srl          gp, a7, s6
                  c.or         a2, a5
                  mul          a1, s6, s6
                  srli         sp, s3, 10
                  xor          a4, s11, s7
                  sltu         s8, s9, s11
                  divu         s10, sp, s1
                  c.andi       a0, -1
                  nop
                  rem          s6, a2, t4
                  xor          a4, s11, s7
                  c.lui        s8, 31
                  or           a4, s7, s8
                  c.add        t2, s3
                  mulh         s11, s9, gp
                  c.addi16sp   sp, 400
                  c.addi4spn   s1, sp, 32
                  srai         t0, t0, 4
                  lui          t2, 776121
                  c.and        s0, a3
                  srli         sp, s3, 10
                  slli         s4, a5, 26
                  sltiu        a1, s4, 1988
                  c.or         a2, a5
                  sltiu        a1, s4, 1988
                  sltiu        a1, s4, 1988
                  nop
                  c.sub        a3, s1
                  lui          t2, 776121
                  sltu         s8, s9, s11
                  c.addi4spn   s1, sp, 32
                  ori          s6, t3, 246
                  c.andi       a0, -1
                  add          s6, s2, s10
                  add          s6, s2, s10
                  divu         s10, sp, s1
                  c.and        s0, a3
                  c.xor        s0, a5
                  mulhu        t2, s5, t5
                  xor          a4, s11, s7
                  sra          s8, a5, s8
                  lui          t2, 776121
                  andi         t0, s11, 1760
                  remu         s6, a4, s2
                  sltu         s8, s9, s11
                  div          s0, t2, a0
                  sra          s8, a5, s8
                  c.mv         s8, a5
                  sltiu        a1, s4, 1988
                  or           a4, s7, s8
                  srl          gp, a7, s6
                  c.add        t2, s3
                  addi         s8, s2, 596
                  sltu         s8, s9, s11
                  rem          s6, a2, t4
                  c.nop
                  srl          gp, a7, s6
                  sub          s11, t4, a3
                  mulh         s11, s9, gp
                  c.add        t2, s3
                  c.and        s0, a3
                  c.add        t2, s3
                  and          t5, t0, a7
                  slli         s4, a5, 26
                  remu         s6, a4, s2
                  c.srai       a2, 4
                  mulh         s11, s9, gp
                  c.sub        a3, s1
                  c.andi       a0, -1
                  sltu         s8, s9, s11
                  mul          a1, s6, s6
                  andi         t0, s11, 1760
                  srli         sp, s3, 10
                  c.addi       t4, 20
                  srli         sp, s3, 10
                  and          t5, t0, a7
                  c.li         a0, 21
                  addi         s8, s2, 596
                  c.addi4spn   s1, sp, 32
                  c.or         a2, a5
                  srli         sp, s3, 10
                  slt          t4, s3, s11
                  rem          s6, a2, t4
                  srl          gp, a7, s6
                  and          t5, t0, a7
                  mulh         s11, s9, gp
                  c.addi16sp   sp, 400
                  remu         s6, a4, s2
                  remu         s6, a4, s2
                  mulhu        t2, s5, t5
                  and          t5, t0, a7
                  c.lui        s8, 31
                  c.add        t2, s3
                  c.add        t2, s3
                  mulh         s11, s9, gp
                  mul          a1, s6, s6
                  slt          t4, s3, s11
                  ori          s6, t3, 246
                  slt          t4, s3, s11
                  c.srli       a0, 28
                  c.srai       a2, 4
                  srai         t0, t0, 4
                  slti         gp, tp, -1791
                  c.sub        a3, s1
                  lui          t2, 776121
                  c.xor        s0, a5
                  nop
                  nop
                  c.or         a2, a5
                  c.srai       a2, 4
                  sltu         s8, s9, s11
                  srai         t0, t0, 4
                  xori         a3, s3, -1008
                  lui          t2, 776121
                  nop
                  sltiu        a1, s4, 1988
                  lui          t2, 776121
                  c.xor        s0, a5
                  sltu         s8, s9, s11
                  c.nop
                  ori          s6, t3, 246
                  c.or         a2, a5
                  c.addi       t4, 20
                  add          s6, s2, s10
                  auipc        a4, 881820
                  addi         s8, s2, 596
                  c.addi16sp   sp, 400
                  c.mv         s8, a5
                  c.slli       s11, 17
                  andi         t0, s11, 1760
                  ori          s6, t3, 246
                  auipc        a4, 881820
                  c.add        t2, s3
                  c.srli       a0, 28
                  c.srai       a2, 4
                  c.addi       t4, 20
                  c.sub        a3, s1
                  sub          s11, t4, a3
                  c.addi       t4, 20
                  nop
                  c.nop
                  and          t5, t0, a7
                  c.or         a2, a5
                  sll          s8, a6, a2
                  c.xor        s0, a5
                  c.nop
                  nop
                  sll          s8, a6, a2
                  srli         sp, s3, 10
                  c.lui        s8, 31
                  slli         s4, a5, 26
                  sll          s8, a6, a2
                  xori         a3, s3, -1008
                  srl          gp, a7, s6
                  srli         sp, s3, 10
                  c.andi       a0, -1
                  srai         t0, t0, 4
                  c.addi16sp   sp, 400
                  divu         s10, sp, s1
                  c.lui        s8, 31
                  c.or         a2, a5
                  div          s0, t2, a0
                  auipc        a4, 881820
                  srli         sp, s3, 10
                  or           a4, s7, s8
                  mul          a1, s6, s6
                  sltu         s8, s9, s11
                  sub          s11, t4, a3
                  ori          s6, t3, 246
                  c.li         a0, 21
                  c.lui        s8, 31
                  slli         s4, a5, 26
                  c.add        t2, s3
                  c.addi       t4, 20
                  c.add        t2, s3
                  mul          a1, s6, s6
                  sra          s8, a5, s8
                  li           a2, 0xffffffff #start riscv_int_numeric_corner_stream_34
                  li           s6, 0x80000000
                  li           gp, 0xe521c645
                  li           t6, 0x0
                  li           t3, 0x0
                  li           s9, 0xffffffff
                  li           s8, 0x80000000
                  li           tp, 0x0
                  li           sp, 0x80000000
                  li           s2, 0x80000000
                  rem          s2, sp, s8
                  remu         s2, t3, tp
                  add          s2, tp, gp
                  remu         s2, t3, tp
                  div          s9, s9, t3
                  mulhsu       sp, t3, tp
                  auipc        t3, 881820
                  addi         s6, tp, 596
                  divu         s9, tp, t6
                  divu         s9, tp, t6
                  rem          s2, sp, s8
                  addi         s6, tp, 596
                  mulh         t3, t6, a2
                  nop
                  lui          s8, 776121
                  nop
                  mulhu        s8, s6, a2
                  mul          tp, s8, s8
                  sub          t3, s9, s2
                  mulhsu       sp, t3, tp
                  mulhsu       sp, t3, tp
                  mulhu        s8, s6, a2
                  mulhsu       sp, t3, tp
                  auipc        t3, 881820 #end riscv_int_numeric_corner_stream_34
                  c.nop
                  c.srli       a0, 28
                  c.or         a2, a5
                  c.andi       a0, -1
                  c.sub        a3, s1
                  c.andi       a0, -1
                  c.sub        a3, s1
                  c.xor        s0, a5
                  slli         s4, a5, 26
                  c.addi       t4, 20
                  and          t5, t0, a7
                  slt          t4, s3, s11
                  c.srai       a2, 4
                  mulhsu       a7, s0, t4
                  lui          t2, 776121
                  c.slli       s11, 17
                  xor          a4, s11, s7
                  c.add        t2, s3
                  slt          t4, s3, s11
                  c.srli       a0, 28
                  slt          t4, s3, s11
                  slti         gp, tp, -1791
                  addi         s8, s2, 596
                  or           a4, s7, s8
                  mulh         s11, s9, gp
                  mulhsu       a7, s0, t4
                  sll          s8, a6, a2
                  c.or         a2, a5
                  c.or         a2, a5
                  auipc        a4, 881820
                  lui          t2, 776121
                  mul          a1, s6, s6
                  addi         s8, s2, 596
                  c.nop
                  and          t5, t0, a7
                  sra          s8, a5, s8
                  sub          s11, t4, a3
                  c.li         a0, 21
                  xor          a4, s11, s7
                  add          s6, s2, s10
                  add          s6, s2, s10
                  nop
                  c.and        s0, a3
                  c.addi16sp   sp, 400
                  mulhsu       a7, s0, t4
                  c.addi16sp   sp, 400
                  c.addi16sp   sp, 400
                  lui          t2, 776121
                  and          t5, t0, a7
                  mulh         s11, s9, gp
                  c.addi4spn   s1, sp, 32
                  sra          s8, a5, s8
                  c.and        s0, a3
                  mulhsu       a7, s0, t4
                  and          t5, t0, a7
                  c.li         a0, 21
                  c.xor        s0, a5
                  xor          a4, s11, s7
                  mulhsu       a7, s0, t4
                  c.nop
                  sub          s11, t4, a3
                  addi         s8, s2, 596
                  c.addi       t4, 20
                  sra          s8, a5, s8
                  c.mv         s8, a5
                  mulhu        t2, s5, t5
                  divu         s10, sp, s1
                  mulhsu       a7, s0, t4
                  c.mv         s8, a5
                  srai         t0, t0, 4
                  c.andi       a0, -1
                  sra          s8, a5, s8
                  sra          s8, a5, s8
                  sra          s8, a5, s8
                  c.lui        s8, 31
                  srai         t0, t0, 4
                  or           a4, s7, s8
                  srl          gp, a7, s6
                  c.addi4spn   s1, sp, 32
                  c.srai       a2, 4
                  slt          t4, s3, s11
                  c.and        s0, a3
                  sll          s8, a6, a2
                  sra          s8, a5, s8
                  srai         t0, t0, 4
                  rem          s6, a2, t4
                  mulh         s11, s9, gp
                  sltu         s8, s9, s11
                  sub          s11, t4, a3
                  slli         s4, a5, 26
                  c.li         a0, 21
                  mul          a1, s6, s6
                  mulh         s11, s9, gp
                  sltu         s8, s9, s11
                  addi         s8, s2, 596
                  mul          a1, s6, s6
                  addi         s8, s2, 596
                  remu         s6, a4, s2
                  c.xor        s0, a5
                  srl          gp, a7, s6
                  c.mv         s8, a5
                  addi         s8, s2, 596
                  srl          gp, a7, s6
                  sltu         s8, s9, s11
                  andi         t0, s11, 1760
                  srl          gp, a7, s6
                  sltiu        a1, s4, 1988
                  c.srli       a0, 28
                  c.xor        s0, a5
                  c.mv         s8, a5
                  c.addi16sp   sp, 400
                  c.xor        s0, a5
                  sltiu        a1, s4, 1988
                  and          t5, t0, a7
                  auipc        a4, 881820
                  add          s6, s2, s10
                  c.mv         s8, a5
                  c.addi4spn   s1, sp, 32
                  c.addi16sp   sp, 400
                  mulh         s11, s9, gp
                  c.sub        a3, s1
                  nop
                  sltu         s8, s9, s11
                  or           a4, s7, s8
                  or           a4, s7, s8
                  mulh         s11, s9, gp
                  ori          s6, t3, 246
                  slti         gp, tp, -1791
                  slti         gp, tp, -1791
                  sltu         s8, s9, s11
                  sll          s8, a6, a2
                  c.addi16sp   sp, 400
                  c.lui        s8, 31
                  c.mv         s8, a5
                  mulhsu       a7, s0, t4
                  slli         s4, a5, 26
                  c.li         a0, 21
                  c.add        t2, s3
                  rem          s6, a2, t4
                  sltiu        a1, s4, 1988
                  c.addi4spn   s1, sp, 32
                  c.or         a2, a5
                  add          s6, s2, s10
                  mulhsu       a7, s0, t4
                  lui          t2, 776121
                  or           a4, s7, s8
                  lui          t2, 776121
                  sltiu        a1, s4, 1988
                  srai         t0, t0, 4
                  div          s0, t2, a0
                  xor          a4, s11, s7
                  srl          gp, a7, s6
                  c.mv         s8, a5
                  slt          t4, s3, s11
                  mulhsu       a7, s0, t4
                  slli         s4, a5, 26
                  srl          gp, a7, s6
                  div          s0, t2, a0
                  sltu         s8, s9, s11
                  lui          t2, 776121
                  srl          gp, a7, s6
                  slti         gp, tp, -1791
                  sll          s8, a6, a2
                  mul          a1, s6, s6
                  c.addi       t4, 20
                  ori          s6, t3, 246
                  c.addi       t4, 20
                  xori         a3, s3, -1008
                  nop
                  slli         s4, a5, 26
                  c.andi       a0, -1
                  divu         s10, sp, s1
                  sra          s8, a5, s8
                  c.addi       t4, 20
                  mulh         s11, s9, gp
                  c.mv         s8, a5
                  sll          s8, a6, a2
                  mulhu        t2, s5, t5
                  c.xor        s0, a5
                  nop
                  sll          s8, a6, a2
                  srl          gp, a7, s6
                  c.addi       t4, 20
                  c.add        t2, s3
                  slt          t4, s3, s11
                  sltiu        a1, s4, 1988
                  rem          s6, a2, t4
                  srl          gp, a7, s6
                  c.srai       a2, 4
                  xor          a4, s11, s7
                  mulhu        t2, s5, t5
                  sll          s8, a6, a2
                  sltu         s8, s9, s11
                  srl          gp, a7, s6
                  mulhu        t2, s5, t5
                  c.lui        s8, 31
                  xori         a3, s3, -1008
                  c.and        s0, a3
                  srai         t0, t0, 4
                  c.addi       t4, 20
                  addi         s8, s2, 596
                  c.slli       s11, 17
                  div          s0, t2, a0
                  slt          t4, s3, s11
                  c.sub        a3, s1
                  auipc        a4, 881820
                  sll          s8, a6, a2
                  divu         s10, sp, s1
                  sltu         s8, s9, s11
                  c.nop
                  andi         t0, s11, 1760
                  or           a4, s7, s8
                  mul          a1, s6, s6
                  sltiu        a1, s4, 1988
                  c.and        s0, a3
                  c.xor        s0, a5
                  xori         a3, s3, -1008
                  c.and        s0, a3
                  mulhu        t2, s5, t5
                  c.slli       s11, 17
                  andi         t0, s11, 1760
                  and          t5, t0, a7
                  c.sub        a3, s1
                  c.or         a2, a5
                  c.slli       s11, 17
                  xori         a3, s3, -1008
                  c.addi       t4, 20
                  li           t2, 0x80000000 #start riscv_int_numeric_corner_stream_25
                  li           t0, 0x563d265f
                  li           s4, 0x0
                  li           s5, 0x1a94fed3
                  li           a5, 0xffffffff
                  li           a6, 0x0
                  li           gp, 0x76af40a8
                  li           t6, 0x0
                  li           s1, 0x80000000
                  li           ra, 0x2fc17a72
                  addi         a5, t0, 596
                  addi         a5, t0, 596
                  mul          t0, a6, a6
                  sub          s5, s4, s1
                  sub          s5, s4, s1
                  mulh         s5, t6, t2
                  mul          t0, a6, a6
                  divu         s4, t0, t6
                  remu         s1, s5, t0
                  div          s4, s4, s5
                  add          s1, t0, gp
                  div          s4, s4, s5
                  nop
                  nop
                  auipc        s5, 881820
                  auipc        s5, 881820 #end riscv_int_numeric_corner_stream_25
                  slt          t4, s3, s11
                  add          s6, s2, s10
                  c.addi       t4, 20
                  c.xor        s0, a5
                  divu         s10, sp, s1
                  c.srli       a0, 28
                  ori          s6, t3, 246
                  c.or         a2, a5
                  c.srli       a0, 28
                  and          t5, t0, a7
                  nop
                  auipc        a4, 881820
                  c.sub        a3, s1
                  c.andi       a0, -1
                  or           a4, s7, s8
                  remu         s6, a4, s2
                  lui          t2, 776121
                  c.and        s0, a3
                  c.mv         s8, a5
                  srai         t0, t0, 4
                  ori          s6, t3, 246
                  c.li         a0, 21
                  c.lui        s8, 31
                  c.mv         s8, a5
                  nop
                  c.slli       s11, 17
                  slti         gp, tp, -1791
                  c.li         a0, 21
                  remu         s6, a4, s2
                  c.sub        a3, s1
                  sra          s8, a5, s8
                  srli         sp, s3, 10
                  lui          t2, 776121
                  sra          s8, a5, s8
                  sltu         s8, s9, s11
                  c.xor        s0, a5
                  c.nop
                  c.slli       s11, 17
                  slti         gp, tp, -1791
                  xor          a4, s11, s7
                  c.andi       a0, -1
                  mulhu        t2, s5, t5
                  ori          s6, t3, 246
                  srli         sp, s3, 10
                  addi         s8, s2, 596
                  c.srli       a0, 28
                  c.mv         s8, a5
                  c.srai       a2, 4
                  c.li         a0, 21
                  andi         t0, s11, 1760
                  c.add        t2, s3
                  slt          t4, s3, s11
                  sra          s8, a5, s8
                  and          t5, t0, a7
                  c.sub        a3, s1
                  srli         sp, s3, 10
                  c.nop
                  sltiu        a1, s4, 1988
                  srai         t0, t0, 4
                  c.slli       s11, 17
                  c.li         a0, 21
                  rem          s6, a2, t4
                  c.lui        s8, 31
                  sra          s8, a5, s8
                  c.andi       a0, -1
                  c.srai       a2, 4
                  sra          s8, a5, s8
                  div          s0, t2, a0
                  sltiu        a1, s4, 1988
                  remu         s6, a4, s2
                  srli         sp, s3, 10
                  c.li         a0, 21
                  c.and        s0, a3
                  c.nop
                  divu         s10, sp, s1
                  c.nop
                  mulhsu       a7, s0, t4
                  xori         a3, s3, -1008
                  c.slli       s11, 17
                  auipc        a4, 881820
                  auipc        a4, 881820
                  sll          s8, a6, a2
                  and          t5, t0, a7
                  slli         s4, a5, 26
                  remu         s6, a4, s2
                  c.slli       s11, 17
                  sra          s8, a5, s8
                  c.nop
                  srai         t0, t0, 4
                  div          s0, t2, a0
                  mulhu        t2, s5, t5
                  c.srli       a0, 28
                  c.addi       t4, 20
                  lui          t2, 776121
                  c.li         a0, 21
                  ori          s6, t3, 246
                  c.lui        s8, 31
                  lui          t2, 776121
                  c.xor        s0, a5
                  sra          s8, a5, s8
                  srai         t0, t0, 4
                  div          s0, t2, a0
                  sll          s8, a6, a2
                  sltu         s8, s9, s11
                  auipc        a4, 881820
                  c.or         a2, a5
                  c.and        s0, a3
                  c.andi       a0, -1
                  c.or         a2, a5
                  sltiu        a1, s4, 1988
                  c.sub        a3, s1
                  c.add        t2, s3
                  c.xor        s0, a5
                  c.addi       t4, 20
                  c.andi       a0, -1
                  c.slli       s11, 17
                  rem          s6, a2, t4
                  mulhsu       a7, s0, t4
                  nop
                  c.mv         s8, a5
                  c.sub        a3, s1
                  c.addi       t4, 20
                  c.and        s0, a3
                  lui          t2, 776121
                  c.srai       a2, 4
                  xor          a4, s11, s7
                  remu         s6, a4, s2
                  lui          t2, 776121
                  mulh         s11, s9, gp
                  c.srli       a0, 28
                  mulhsu       a7, s0, t4
                  c.addi4spn   s1, sp, 32
                  c.or         a2, a5
                  slli         s4, a5, 26
                  sltiu        a1, s4, 1988
                  li           s10, 0x0 #start riscv_int_numeric_corner_stream_28
                  li           gp, 0xbff04653
                  li           t4, 0x0
                  li           t5, 0xe7e902f5
                  li           s9, 0x7037acb1
                  li           a5, 0x80000000
                  li           a2, 0xffffffff
                  li           t0, 0xffffffff
                  li           a4, 0x71a080a
                  li           s4, 0x64200396
                  rem          a5, gp, s9
                  add          a5, a2, t0
                  mulhsu       gp, t4, a2
                  div          s10, s10, t4
                  div          s10, s10, t4
                  mulhu        s9, s4, a4
                  nop
                  remu         a5, t4, a2
                  mulhu        s9, s4, a4
                  mulhsu       gp, t4, a2
                  sub          t4, s10, a5
                  mulh         t4, t5, a4
                  add          a5, a2, t0
                  rem          a5, gp, s9
                  remu         a5, t4, a2
                  rem          a5, gp, s9
                  nop
                  remu         a5, t4, a2
                  addi         s4, a2, 596
                  sub          t4, s10, a5
                  rem          a5, gp, s9
                  mulhsu       gp, t4, a2
                  auipc        t4, 881820
                  mulhu        s9, s4, a4
                  mul          a2, s9, s9
                  div          s10, s10, t4
                  sub          t4, s10, a5 #end riscv_int_numeric_corner_stream_28
                  slt          t4, s3, s11
                  sltiu        a1, s4, 1988
                  c.addi       t4, 20
                  c.sub        a3, s1
                  mulhsu       a7, s0, t4
                  c.srai       a2, 4
                  sll          s8, a6, a2
                  div          s0, t2, a0
                  c.and        s0, a3
                  ori          s6, t3, 246
                  and          t5, t0, a7
                  lui          t2, 776121
                  srai         t0, t0, 4
                  addi         s8, s2, 596
                  c.xor        s0, a5
                  c.lui        s8, 31
                  sll          s8, a6, a2
                  mul          a1, s6, s6
                  sltu         s8, s9, s11
                  c.srli       a0, 28
                  srl          gp, a7, s6
                  mulhu        t2, s5, t5
                  xor          a4, s11, s7
                  c.addi       t4, 20
                  sra          s8, a5, s8
                  andi         t0, s11, 1760
                  c.addi4spn   s1, sp, 32
                  sra          s8, a5, s8
                  c.slli       s11, 17
                  or           a4, s7, s8
                  sltiu        a1, s4, 1988
                  srli         sp, s3, 10
                  nop
                  andi         t0, s11, 1760
                  c.srai       a2, 4
                  c.add        t2, s3
                  srli         sp, s3, 10
                  c.add        t2, s3
                  or           a4, s7, s8
                  or           a4, s7, s8
                  mul          a1, s6, s6
                  nop
                  c.addi4spn   s1, sp, 32
                  c.xor        s0, a5
                  rem          s6, a2, t4
                  auipc        a4, 881820
                  sub          s11, t4, a3
                  add          s6, s2, s10
                  div          s0, t2, a0
                  c.addi16sp   sp, 400
                  c.sub        a3, s1
                  mulh         s11, s9, gp
                  sll          s8, a6, a2
                  divu         s10, sp, s1
                  c.addi       t4, 20
                  c.add        t2, s3
                  addi         s8, s2, 596
                  c.and        s0, a3
                  rem          s6, a2, t4
                  rem          s6, a2, t4
                  auipc        a4, 881820
                  divu         s10, sp, s1
                  or           a4, s7, s8
                  and          t5, t0, a7
                  sra          s8, a5, s8
                  c.sub        a3, s1
                  c.add        t2, s3
                  c.addi       t4, 20
                  c.andi       a0, -1
                  mul          a1, s6, s6
                  ori          s6, t3, 246
                  rem          s6, a2, t4
                  c.and        s0, a3
                  slti         gp, tp, -1791
                  sltiu        a1, s4, 1988
                  c.sub        a3, s1
                  sub          s11, t4, a3
                  lui          t2, 776121
                  add          s6, s2, s10
                  sltiu        a1, s4, 1988
                  c.xor        s0, a5
                  rem          s6, a2, t4
                  c.lui        s8, 31
                  c.xor        s0, a5
                  sltiu        a1, s4, 1988
                  slt          t4, s3, s11
                  c.sub        a3, s1
                  c.or         a2, a5
                  slti         gp, tp, -1791
                  c.add        t2, s3
                  sra          s8, a5, s8
                  sub          s11, t4, a3
                  addi         s8, s2, 596
                  srli         sp, s3, 10
                  addi         s8, s2, 596
                  c.addi       t4, 20
                  addi         s8, s2, 596
                  sra          s8, a5, s8
                  lui          t2, 776121
                  mulhsu       a7, s0, t4
                  sltu         s8, s9, s11
                  divu         s10, sp, s1
                  divu         s10, sp, s1
                  c.and        s0, a3
                  c.or         a2, a5
                  c.or         a2, a5
                  addi         s8, s2, 596
                  c.lui        s8, 31
                  c.or         a2, a5
                  c.xor        s0, a5
                  sltiu        a1, s4, 1988
                  c.andi       a0, -1
                  c.or         a2, a5
                  sra          s8, a5, s8
                  mulhsu       a7, s0, t4
                  slti         gp, tp, -1791
                  mulh         s11, s9, gp
                  addi         s8, s2, 596
                  sltu         s8, s9, s11
                  add          s6, s2, s10
                  xor          a4, s11, s7
                  slli         s4, a5, 26
                  remu         s6, a4, s2
                  srli         sp, s3, 10
                  c.srai       a2, 4
                  c.nop
                  slt          t4, s3, s11
                  slt          t4, s3, s11
                  xor          a4, s11, s7
                  or           a4, s7, s8
                  sub          s11, t4, a3
                  c.addi4spn   s1, sp, 32
                  srli         sp, s3, 10
                  c.addi       t4, 20
                  addi         s8, s2, 596
                  slli         s4, a5, 26
                  srai         t0, t0, 4
                  mulh         s11, s9, gp
                  sra          s8, a5, s8
                  c.and        s0, a3
                  slt          t4, s3, s11
                  remu         s6, a4, s2
                  srai         t0, t0, 4
                  andi         t0, s11, 1760
                  sra          s8, a5, s8
                  c.addi       t4, 20
                  c.add        t2, s3
                  div          s0, t2, a0
                  c.or         a2, a5
                  c.sub        a3, s1
                  div          s0, t2, a0
                  add          s6, s2, s10
                  ori          s6, t3, 246
                  auipc        a4, 881820
                  xori         a3, s3, -1008
                  auipc        a4, 881820
                  slli         s4, a5, 26
                  c.sub        a3, s1
                  c.li         a0, 21
                  slli         s4, a5, 26
                  or           a4, s7, s8
                  mulhsu       a7, s0, t4
                  c.addi       t4, 20
                  srai         t0, t0, 4
                  c.addi       t4, 20
                  rem          s6, a2, t4
                  c.li         a0, 21
                  sltu         s8, s9, s11
                  mul          a1, s6, s6
                  slli         s4, a5, 26
                  c.and        s0, a3
                  c.slli       s11, 17
                  c.addi4spn   s1, sp, 32
                  c.mv         s8, a5
                  c.mv         s8, a5
                  slt          t4, s3, s11
                  div          s0, t2, a0
                  c.li         a0, 21
                  lui          t2, 776121
                  slti         gp, tp, -1791
                  c.addi       t4, 20
                  sra          s8, a5, s8
                  xor          a4, s11, s7
                  and          t5, t0, a7
                  c.lui        s8, 31
                  nop
                  or           a4, s7, s8
                  c.nop
                  c.lui        s8, 31
                  mulhsu       a7, s0, t4
                  sltiu        a1, s4, 1988
                  div          s0, t2, a0
                  c.srli       a0, 28
                  srl          gp, a7, s6
                  slti         gp, tp, -1791
                  nop
                  div          s0, t2, a0
                  c.srai       a2, 4
                  mulh         s11, s9, gp
                  c.addi       t4, 20
                  mul          a1, s6, s6
                  divu         s10, sp, s1
                  mulhu        t2, s5, t5
                  srli         sp, s3, 10
                  srl          gp, a7, s6
                  mulhu        t2, s5, t5
                  c.nop
                  c.xor        s0, a5
                  addi         s8, s2, 596
                  c.sub        a3, s1
                  c.slli       s11, 17
                  c.li         a0, 21
                  or           a4, s7, s8
                  srl          gp, a7, s6
                  sltu         s8, s9, s11
                  c.srli       a0, 28
                  srai         t0, t0, 4
                  slt          t4, s3, s11
                  c.slli       s11, 17
                  lui          t2, 776121
                  xori         a3, s3, -1008
                  ori          s6, t3, 246
                  add          s6, s2, s10
                  mulhsu       a7, s0, t4
                  sll          s8, a6, a2
                  xor          a4, s11, s7
                  c.srli       a0, 28
                  sub          s11, t4, a3
                  c.mv         s8, a5
                  c.add        t2, s3
                  andi         t0, s11, 1760
                  sra          s8, a5, s8
                  c.addi       t4, 20
                  sub          s11, t4, a3
                  addi         s8, s2, 596
                  c.andi       a0, -1
                  c.li         a0, 21
                  c.andi       a0, -1
                  mul          a1, s6, s6
                  mulhsu       a7, s0, t4
                  c.lui        s8, 31
                  ori          s6, t3, 246
                  slli         s4, a5, 26
                  srl          gp, a7, s6
                  srl          gp, a7, s6
                  mulhsu       a7, s0, t4
                  c.xor        s0, a5
                  c.xor        s0, a5
                  c.lui        s8, 31
                  lui          t2, 776121
                  slti         gp, tp, -1791
                  or           a4, s7, s8
                  srl          gp, a7, s6
                  c.andi       a0, -1
                  sra          s8, a5, s8
                  mul          a1, s6, s6
                  mulhu        t2, s5, t5
                  c.slli       s11, 17
                  or           a4, s7, s8
                  add          s6, s2, s10
                  c.nop
                  auipc        a4, 881820
                  sltu         s8, s9, s11
                  remu         s6, a4, s2
                  srl          gp, a7, s6
                  c.lui        s8, 31
                  slt          t4, s3, s11
                  sll          s8, a6, a2
                  c.addi16sp   sp, 400
                  c.srai       a2, 4
                  c.nop
                  srai         t0, t0, 4
                  sltu         s8, s9, s11
                  andi         t0, s11, 1760
                  sll          s8, a6, a2
                  slli         s4, a5, 26
                  c.srai       a2, 4
                  or           a4, s7, s8
                  c.addi4spn   s1, sp, 32
                  srl          gp, a7, s6
                  xor          a4, s11, s7
                  slti         gp, tp, -1791
                  mulh         s11, s9, gp
                  sltiu        a1, s4, 1988
                  c.addi4spn   s1, sp, 32
                  c.addi       t4, 20
                  c.srai       a2, 4
                  rem          s6, a2, t4
                  c.addi16sp   sp, 400
                  sltu         s8, s9, s11
                  sltiu        a1, s4, 1988
                  c.mv         s8, a5
                  c.sub        a3, s1
                  slti         gp, tp, -1791
                  xori         a3, s3, -1008
                  c.or         a2, a5
                  c.andi       a0, -1
                  ori          s6, t3, 246
                  xor          a4, s11, s7
                  slt          t4, s3, s11
                  slt          t4, s3, s11
                  divu         s10, sp, s1
                  divu         s10, sp, s1
                  sll          s8, a6, a2
                  c.andi       a0, -1
                  srli         sp, s3, 10
                  c.xor        s0, a5
                  c.xor        s0, a5
                  sub          s11, t4, a3
                  sltu         s8, s9, s11
                  srl          gp, a7, s6
                  or           a4, s7, s8
                  rem          s6, a2, t4
                  c.slli       s11, 17
                  slt          t4, s3, s11
                  add          s6, s2, s10
                  sll          s8, a6, a2
                  c.mv         s8, a5
                  c.lui        s8, 31
                  c.srli       a0, 28
                  sltiu        a1, s4, 1988
                  srli         sp, s3, 10
                  addi         s8, s2, 596
                  mulhu        t2, s5, t5
                  xor          a4, s11, s7
                  divu         s10, sp, s1
                  srl          gp, a7, s6
                  rem          s6, a2, t4
                  slt          t4, s3, s11
                  c.sub        a3, s1
                  srl          gp, a7, s6
                  andi         t0, s11, 1760
                  add          s6, s2, s10
                  mulh         s11, s9, gp
                  c.addi       t4, 20
                  c.mv         s8, a5
                  mulhu        t2, s5, t5
                  auipc        a4, 881820
                  mul          a1, s6, s6
                  c.sub        a3, s1
                  or           a4, s7, s8
                  c.add        t2, s3
                  c.srli       a0, 28
                  slt          t4, s3, s11
                  slt          t4, s3, s11
                  andi         t0, s11, 1760
                  c.andi       a0, -1
                  auipc        a4, 881820
                  c.li         a0, 21
                  or           a4, s7, s8
                  c.addi       t4, 20
                  c.addi4spn   s1, sp, 32
                  c.addi       t4, 20
                  sll          s8, a6, a2
                  c.lui        s8, 31
                  c.srai       a2, 4
                  addi         s8, s2, 596
                  sltiu        a1, s4, 1988
                  c.slli       s11, 17
                  slti         gp, tp, -1791
                  remu         s6, a4, s2
                  c.li         a0, 21
                  auipc        a4, 881820
                  c.nop
                  sltiu        a1, s4, 1988
                  c.and        s0, a3
                  andi         t0, s11, 1760
                  mul          a1, s6, s6
                  c.xor        s0, a5
                  c.srai       a2, 4
                  sltiu        a1, s4, 1988
                  slli         s4, a5, 26
                  c.li         a0, 21
                  div          s0, t2, a0
                  c.srai       a2, 4
                  ori          s6, t3, 246
                  remu         s6, a4, s2
                  c.slli       s11, 17
                  sra          s8, a5, s8
                  sub          s11, t4, a3
                  srli         sp, s3, 10
                  xor          a4, s11, s7
                  c.addi16sp   sp, 400
                  remu         s6, a4, s2
                  sltu         s8, s9, s11
                  sll          s8, a6, a2
                  c.xor        s0, a5
                  mulhu        t2, s5, t5
                  srl          gp, a7, s6
                  c.addi4spn   s1, sp, 32
                  c.or         a2, a5
                  sltiu        a1, s4, 1988
                  c.add        t2, s3
                  auipc        a4, 881820
                  c.sub        a3, s1
                  c.add        t2, s3
                  c.srli       a0, 28
                  c.addi       t4, 20
                  srai         t0, t0, 4
                  sll          s8, a6, a2
                  lui          t2, 776121
                  c.sub        a3, s1
                  c.addi4spn   s1, sp, 32
                  srai         t0, t0, 4
                  c.addi4spn   s1, sp, 32
                  rem          s6, a2, t4
                  and          t5, t0, a7
                  andi         t0, s11, 1760
                  c.andi       a0, -1
                  add          s6, s2, s10
                  c.mv         s8, a5
                  c.addi16sp   sp, 400
                  sltiu        a1, s4, 1988
                  auipc        a4, 881820
                  xor          a4, s11, s7
                  c.sub        a3, s1
                  auipc        a4, 881820
                  sltu         s8, s9, s11
                  mul          a1, s6, s6
                  c.nop
                  srli         sp, s3, 10
                  remu         s6, a4, s2
                  or           a4, s7, s8
                  c.srli       a0, 28
                  slli         s4, a5, 26
                  and          t5, t0, a7
                  c.nop
                  c.and        s0, a3
                  ori          s6, t3, 246
                  c.xor        s0, a5
                  c.srli       a0, 28
                  xori         a3, s3, -1008
                  mulhu        t2, s5, t5
                  c.mv         s8, a5
                  andi         t0, s11, 1760
                  sltu         s8, s9, s11
                  xori         a3, s3, -1008
                  xori         a3, s3, -1008
                  div          s0, t2, a0
                  mulh         s11, s9, gp
                  nop
                  sltiu        a1, s4, 1988
                  c.srai       a2, 4
                  c.li         a0, 21
                  c.andi       a0, -1
                  c.srai       a2, 4
                  xor          a4, s11, s7
                  c.slli       s11, 17
                  slt          t4, s3, s11
                  c.li         a0, 21
                  mulhu        t2, s5, t5
                  sltiu        a1, s4, 1988
                  c.nop
                  or           a4, s7, s8
                  divu         s10, sp, s1
                  c.lui        s8, 31
                  nop
                  or           a4, s7, s8
                  srli         sp, s3, 10
                  mulhsu       a7, s0, t4
                  mulhsu       a7, s0, t4
                  sra          s8, a5, s8
                  srl          gp, a7, s6
                  c.add        t2, s3
                  sltiu        a1, s4, 1988
                  c.addi16sp   sp, 400
                  mulhsu       a7, s0, t4
                  srai         t0, t0, 4
                  mulhsu       a7, s0, t4
                  nop
                  slti         gp, tp, -1791
                  c.xor        s0, a5
                  c.addi4spn   s1, sp, 32
                  c.add        t2, s3
                  mul          a1, s6, s6
                  remu         s6, a4, s2
                  slti         gp, tp, -1791
                  srl          gp, a7, s6
                  srai         t0, t0, 4
                  and          t5, t0, a7
                  c.lui        s8, 31
                  andi         t0, s11, 1760
                  mulhu        t2, s5, t5
                  srai         t0, t0, 4
                  mulh         s11, s9, gp
                  c.slli       s11, 17
                  slt          t4, s3, s11
                  c.sub        a3, s1
                  addi         s8, s2, 596
                  ori          s6, t3, 246
                  remu         s6, a4, s2
                  c.srai       a2, 4
                  c.andi       a0, -1
                  slti         gp, tp, -1791
                  c.and        s0, a3
                  c.andi       a0, -1
                  and          t5, t0, a7
                  c.add        t2, s3
                  sra          s8, a5, s8
                  slli         s4, a5, 26
                  ori          s6, t3, 246
                  slt          t4, s3, s11
                  divu         s10, sp, s1
                  remu         s6, a4, s2
                  auipc        a4, 881820
                  rem          s6, a2, t4
                  mulh         s11, s9, gp
                  slti         gp, tp, -1791
                  add          s6, s2, s10
                  div          s0, t2, a0
                  divu         s10, sp, s1
                  sub          s11, t4, a3
                  sltu         s8, s9, s11
                  mulhu        t2, s5, t5
                  remu         s6, a4, s2
                  remu         s6, a4, s2
                  mulh         s11, s9, gp
                  andi         t0, s11, 1760
                  c.xor        s0, a5
                  lui          t2, 776121
                  addi         s8, s2, 596
                  c.li         a0, 21
                  srli         sp, s3, 10
                  c.li         a0, 21
                  sll          s8, a6, a2
                  sltu         s8, s9, s11
                  remu         s6, a4, s2
                  slt          t4, s3, s11
                  addi         s8, s2, 596
                  srl          gp, a7, s6
                  slt          t4, s3, s11
                  mul          a1, s6, s6
                  or           a4, s7, s8
                  c.mv         s8, a5
                  mulhsu       a7, s0, t4
                  c.mv         s8, a5
                  c.addi4spn   s1, sp, 32
                  c.srli       a0, 28
                  remu         s6, a4, s2
                  slt          t4, s3, s11
                  rem          s6, a2, t4
                  and          t5, t0, a7
                  c.lui        s8, 31
                  c.andi       a0, -1
                  c.addi16sp   sp, 400
                  c.xor        s0, a5
                  addi         s8, s2, 596
                  lui          t2, 776121
                  c.slli       s11, 17
                  c.lui        s8, 31
                  c.srai       a2, 4
                  c.or         a2, a5
                  sltiu        a1, s4, 1988
                  c.xor        s0, a5
                  sra          s8, a5, s8
                  xori         a3, s3, -1008
                  c.nop
                  addi         s8, s2, 596
                  c.slli       s11, 17
                  c.addi4spn   s1, sp, 32
                  c.srai       a2, 4
                  c.and        s0, a3
                  sltu         s8, s9, s11
                  c.slli       s11, 17
                  mulhsu       a7, s0, t4
                  divu         s10, sp, s1
                  c.li         a0, 21
                  c.srai       a2, 4
                  c.andi       a0, -1
                  c.and        s0, a3
                  addi         s8, s2, 596
                  c.addi       t4, 20
                  rem          s6, a2, t4
                  mulhsu       a7, s0, t4
                  remu         s6, a4, s2
                  sltiu        a1, s4, 1988
                  c.andi       a0, -1
                  nop
                  c.andi       a0, -1
                  sll          s8, a6, a2
                  lui          t2, 776121
                  auipc        a4, 881820
                  remu         s6, a4, s2
                  c.slli       s11, 17
                  or           a4, s7, s8
                  nop
                  c.nop
                  c.mv         s8, a5
                  andi         t0, s11, 1760
                  slli         s4, a5, 26
                  lui          t2, 776121
                  lui          t2, 776121
                  c.nop
                  c.srai       a2, 4
                  mulhsu       a7, s0, t4
                  mulh         s11, s9, gp
                  and          t5, t0, a7
                  c.lui        s8, 31
                  mulhu        t2, s5, t5
                  srl          gp, a7, s6
                  addi         s8, s2, 596
                  and          t5, t0, a7
                  mulhsu       a7, s0, t4
                  c.xor        s0, a5
                  lui          t2, 776121
                  div          s0, t2, a0
                  xor          a4, s11, s7
                  div          s0, t2, a0
                  sra          s8, a5, s8
                  divu         s10, sp, s1
                  divu         s10, sp, s1
                  c.mv         s8, a5
                  c.xor        s0, a5
                  c.addi       t4, 20
                  add          s6, s2, s10
                  andi         t0, s11, 1760
                  andi         t0, s11, 1760
                  mulhsu       a7, s0, t4
                  sltu         s8, s9, s11
                  addi         s8, s2, 596
                  auipc        a4, 881820
                  c.srai       a2, 4
                  auipc        a4, 881820
                  c.sub        a3, s1
                  xor          a4, s11, s7
                  mul          a1, s6, s6
                  auipc        a4, 881820
                  c.srli       a0, 28
                  c.addi16sp   sp, 400
                  mulh         s11, s9, gp
                  slt          t4, s3, s11
                  c.addi       t4, 20
                  c.or         a2, a5
                  sltiu        a1, s4, 1988
                  remu         s6, a4, s2
                  srli         sp, s3, 10
                  c.lui        s8, 31
                  c.srli       a0, 28
                  remu         s6, a4, s2
                  c.mv         s8, a5
                  mul          a1, s6, s6
                  c.lui        s8, 31
                  c.addi       t4, 20
                  sltiu        a1, s4, 1988
                  xor          a4, s11, s7
                  c.li         a0, 21
                  slt          t4, s3, s11
                  c.xor        s0, a5
                  xori         a3, s3, -1008
                  mulhsu       a7, s0, t4
                  sra          s8, a5, s8
                  c.srai       a2, 4
                  slti         gp, tp, -1791
                  c.addi4spn   s1, sp, 32
                  slt          t4, s3, s11
                  sub          s11, t4, a3
                  addi         s8, s2, 596
                  c.or         a2, a5
                  nop
                  sll          s8, a6, a2
                  andi         t0, s11, 1760
                  lui          t2, 776121
                  c.srai       a2, 4
                  lui          t2, 776121
                  sltu         s8, s9, s11
                  slti         gp, tp, -1791
                  auipc        a4, 881820
                  mul          a1, s6, s6
                  lui          t2, 776121
                  c.xor        s0, a5
                  slt          t4, s3, s11
                  sll          s8, a6, a2
                  c.nop
                  andi         t0, s11, 1760
                  c.addi       t4, 20
                  c.andi       a0, -1
                  andi         t0, s11, 1760
                  sra          s8, a5, s8
                  c.addi16sp   sp, 400
                  srli         sp, s3, 10
                  c.andi       a0, -1
                  c.xor        s0, a5
                  ori          s6, t3, 246
                  andi         t0, s11, 1760
                  xori         a3, s3, -1008
                  c.add        t2, s3
                  auipc        a4, 881820
                  c.add        t2, s3
                  slt          t4, s3, s11
                  slli         s4, a5, 26
                  c.li         a0, 21
                  xori         a3, s3, -1008
                  andi         t0, s11, 1760
                  xori         a3, s3, -1008
                  c.or         a2, a5
                  c.li         a0, 21
                  c.addi16sp   sp, 400
                  c.addi       t4, 20
                  rem          s6, a2, t4
                  c.addi4spn   s1, sp, 32
                  mulhu        t2, s5, t5
                  sltu         s8, s9, s11
                  addi         s8, s2, 596
                  addi         s8, s2, 596
                  add          s6, s2, s10
                  c.xor        s0, a5
                  nop
                  c.slli       s11, 17
                  rem          s6, a2, t4
                  c.xor        s0, a5
                  c.nop
                  c.addi16sp   sp, 400
                  srai         t0, t0, 4
                  xori         a3, s3, -1008
                  sll          s8, a6, a2
                  c.nop
                  sll          s8, a6, a2
                  srl          gp, a7, s6
                  slt          t4, s3, s11
                  sltu         s8, s9, s11
                  mulhsu       a7, s0, t4
                  c.addi       t4, 20
                  c.lui        s8, 31
                  andi         t0, s11, 1760
                  srai         t0, t0, 4
                  auipc        a4, 881820
                  c.slli       s11, 17
                  remu         s6, a4, s2
                  slti         gp, tp, -1791
                  and          t5, t0, a7
                  mulh         s11, s9, gp
                  c.li         a0, 21
                  xor          a4, s11, s7
                  c.li         a0, 21
                  srli         sp, s3, 10
                  xor          a4, s11, s7
                  auipc        a4, 881820
                  c.addi       t4, 20
                  or           a4, s7, s8
                  mulhu        t2, s5, t5
                  or           a4, s7, s8
                  div          s0, t2, a0
                  mulhu        t2, s5, t5
                  c.li         a0, 21
                  slli         s4, a5, 26
                  c.add        t2, s3
                  divu         s10, sp, s1
                  c.addi16sp   sp, 400
                  srl          gp, a7, s6
                  sltu         s8, s9, s11
                  remu         s6, a4, s2
                  sra          s8, a5, s8
                  c.srli       a0, 28
                  srai         t0, t0, 4
                  xori         a3, s3, -1008
                  mulhsu       a7, s0, t4
                  divu         s10, sp, s1
                  c.xor        s0, a5
                  sll          s8, a6, a2
                  mulhsu       a7, s0, t4
                  c.srai       a2, 4
                  c.lui        s8, 31
                  c.andi       a0, -1
                  add          s6, s2, s10
                  auipc        a4, 881820
                  c.li         a0, 21
                  c.li         a0, 21
                  sra          s8, a5, s8
                  c.andi       a0, -1
                  nop
                  or           a4, s7, s8
                  c.and        s0, a3
                  sltu         s8, s9, s11
                  mul          a1, s6, s6
                  sltu         s8, s9, s11
                  nop
                  ori          s6, t3, 246
                  and          t5, t0, a7
                  c.addi4spn   s1, sp, 32
                  c.xor        s0, a5
                  nop
                  addi         s8, s2, 596
                  c.srli       a0, 28
                  c.and        s0, a3
                  srli         sp, s3, 10
                  nop
                  addi         s8, s2, 596
                  c.addi16sp   sp, 400
                  lui          t2, 776121
                  sltu         s8, s9, s11
                  mulhu        t2, s5, t5
                  rem          s6, a2, t4
                  slt          t4, s3, s11
                  sll          s8, a6, a2
                  c.addi       t4, 20
                  add          s6, s2, s10
                  ori          s6, t3, 246
                  mul          a1, s6, s6
                  c.addi       t4, 20
                  c.or         a2, a5
                  srli         sp, s3, 10
                  c.slli       s11, 17
                  rem          s6, a2, t4
                  rem          s6, a2, t4
                  xori         a3, s3, -1008
                  srli         sp, s3, 10
                  c.srai       a2, 4
                  c.li         a0, 21
                  c.and        s0, a3
                  mulhu        t2, s5, t5
                  c.li         a0, 21
                  mulhu        t2, s5, t5
                  sltu         s8, s9, s11
                  c.srli       a0, 28
                  sltiu        a1, s4, 1988
                  sll          s8, a6, a2
                  c.li         a0, 21
                  xori         a3, s3, -1008
                  sltu         s8, s9, s11
                  mulhu        t2, s5, t5
                  mulhu        t2, s5, t5
                  and          t5, t0, a7
                  mulhsu       a7, s0, t4
                  divu         s10, sp, s1
                  sltiu        a1, s4, 1988
                  divu         s10, sp, s1
                  c.andi       a0, -1
                  c.xor        s0, a5
                  slli         s4, a5, 26
                  mulhsu       a7, s0, t4
                  c.mv         s8, a5
                  xori         a3, s3, -1008
                  c.srai       a2, 4
                  div          s0, t2, a0
                  mulh         s11, s9, gp
                  c.sub        a3, s1
                  ori          s6, t3, 246
                  mulhsu       a7, s0, t4
                  srli         sp, s3, 10
                  addi         s8, s2, 596
                  c.srai       a2, 4
                  slt          t4, s3, s11
                  mulh         s11, s9, gp
                  mulhsu       a7, s0, t4
                  and          t5, t0, a7
                  c.mv         s8, a5
                  slti         gp, tp, -1791
                  sra          s8, a5, s8
                  c.li         a0, 21
                  c.srai       a2, 4
                  c.xor        s0, a5
                  andi         t0, s11, 1760
                  xori         a3, s3, -1008
                  c.li         a0, 21
                  xori         a3, s3, -1008
                  mulhu        t2, s5, t5
                  xori         a3, s3, -1008
                  c.xor        s0, a5
                  rem          s6, a2, t4
                  sra          s8, a5, s8
                  xori         a3, s3, -1008
                  slti         gp, tp, -1791
                  srli         sp, s3, 10
                  sll          s8, a6, a2
                  addi         s8, s2, 596
                  c.add        t2, s3
                  c.or         a2, a5
                  remu         s6, a4, s2
                  xori         a3, s3, -1008
                  sub          s11, t4, a3
                  mulhu        t2, s5, t5
                  c.addi4spn   s1, sp, 32
                  xori         a3, s3, -1008
                  mulh         s11, s9, gp
                  addi         s8, s2, 596
                  c.mv         s8, a5
                  c.li         a0, 21
                  srl          gp, a7, s6
                  mulh         s11, s9, gp
                  sltiu        a1, s4, 1988
                  sub          s11, t4, a3
                  andi         t0, s11, 1760
                  xor          a4, s11, s7
                  and          t5, t0, a7
                  c.add        t2, s3
                  mul          a1, s6, s6
                  c.nop
                  addi         s8, s2, 596
                  c.slli       s11, 17
                  c.addi       t4, 20
                  ori          s6, t3, 246
                  srli         sp, s3, 10
                  c.addi       t4, 20
                  addi         s8, s2, 596
                  slli         s4, a5, 26
                  ori          s6, t3, 246
                  mulh         s11, s9, gp
                  c.addi       t4, 20
                  lui          t2, 776121
                  ori          s6, t3, 246
                  ori          s6, t3, 246
                  c.mv         s8, a5
                  divu         s10, sp, s1
                  divu         s10, sp, s1
                  mulhu        t2, s5, t5
                  nop
                  xori         a3, s3, -1008
                  c.li         a0, 21
                  mulhsu       a7, s0, t4
                  auipc        a4, 881820
                  and          t5, t0, a7
                  c.mv         s8, a5
                  div          s0, t2, a0
                  sltiu        a1, s4, 1988
                  slt          t4, s3, s11
                  c.slli       s11, 17
                  xor          a4, s11, s7
                  mul          a1, s6, s6
                  sra          s8, a5, s8
                  sub          s11, t4, a3
                  sub          s11, t4, a3
                  andi         t0, s11, 1760
                  divu         s10, sp, s1
                  remu         s6, a4, s2
                  sll          s8, a6, a2
                  mulhu        t2, s5, t5
                  c.and        s0, a3
                  slti         gp, tp, -1791
                  c.and        s0, a3
                  rem          s6, a2, t4
                  c.or         a2, a5
                  srai         t0, t0, 4
                  c.andi       a0, -1
                  add          s6, s2, s10
                  nop
                  c.slli       s11, 17
                  srai         t0, t0, 4
                  srl          gp, a7, s6
                  lui          t2, 776121
                  c.xor        s0, a5
                  sltiu        a1, s4, 1988
                  sltu         s8, s9, s11
                  nop
                  c.srli       a0, 28
                  mulhu        t2, s5, t5
                  auipc        a4, 881820
                  lui          t2, 776121
                  rem          s6, a2, t4
                  addi         s8, s2, 596
                  mulh         s11, s9, gp
                  lui          t2, 776121
                  nop
                  c.and        s0, a3
                  c.sub        a3, s1
                  srl          gp, a7, s6
                  rem          s6, a2, t4
                  c.nop
                  addi         s8, s2, 596
                  mulhsu       a7, s0, t4
                  or           a4, s7, s8
                  slt          t4, s3, s11
                  srli         sp, s3, 10
                  div          s0, t2, a0
                  div          s0, t2, a0
                  addi         s8, s2, 596
                  rem          s6, a2, t4
                  c.lui        s8, 31
                  c.or         a2, a5
                  slli         s4, a5, 26
                  xori         a3, s3, -1008
                  mul          a1, s6, s6
                  c.addi       t4, 20
                  xori         a3, s3, -1008
                  xori         a3, s3, -1008
                  c.addi4spn   s1, sp, 32
                  c.add        t2, s3
                  mulh         s11, s9, gp
                  sub          s11, t4, a3
                  remu         s6, a4, s2
                  lui          t2, 776121
                  c.li         a0, 21
                  mulhsu       a7, s0, t4
                  mul          a1, s6, s6
                  c.slli       s11, 17
                  c.slli       s11, 17
                  mulhu        t2, s5, t5
                  sltu         s8, s9, s11
                  rem          s6, a2, t4
                  sub          s11, t4, a3
                  or           a4, s7, s8
                  mul          a1, s6, s6
                  c.addi       t4, 20
                  addi         s8, s2, 596
                  auipc        a4, 881820
                  sltiu        a1, s4, 1988
                  c.slli       s11, 17
                  slt          t4, s3, s11
                  c.slli       s11, 17
                  c.add        t2, s3
                  c.sub        a3, s1
                  c.add        t2, s3
                  sra          s8, a5, s8
                  srl          gp, a7, s6
                  addi         s8, s2, 596
                  mulhu        t2, s5, t5
                  sub          s11, t4, a3
                  divu         s10, sp, s1
                  mul          a1, s6, s6
                  xori         a3, s3, -1008
                  sltu         s8, s9, s11
                  srl          gp, a7, s6
                  and          t5, t0, a7
                  mulh         s11, s9, gp
                  lui          t2, 776121
                  rem          s6, a2, t4
                  li           t6, 0x80000000 #start riscv_int_numeric_corner_stream_1
                  li           s9, 0xffffffff
                  li           a4, 0x80000000
                  li           s4, 0x80000000
                  li           ra, 0x1e9d7a55
                  li           a2, 0x0
                  li           a1, 0x0
                  li           t2, 0xffffffff
                  li           s6, 0x0
                  li           a0, 0x0
                  mul          a0, s4, s4
                  auipc        s9, 881820
                  add          a2, a0, t2
                  nop
                  mulhu        s4, a4, a1
                  divu         s6, a0, t6
                  div          s6, s6, s9
                  mulh         s9, t6, a1
                  nop
                  remu         a2, s9, a0
                  rem          a2, ra, s4
                  rem          a2, ra, s4
                  lui          s4, 776121
                  lui          s4, 776121
                  remu         a2, s9, a0
                  divu         s6, a0, t6
                  div          s6, s6, s9
                  lui          s4, 776121
                  mulhsu       ra, s9, a0
                  mulh         s9, t6, a1
                  divu         s6, a0, t6
                  div          s6, s6, s9
                  lui          s4, 776121
                  divu         s6, a0, t6
                  divu         s6, a0, t6
                  mulhsu       ra, s9, a0
                  mulh         s9, t6, a1 #end riscv_int_numeric_corner_stream_1
                  c.slli       s11, 17
                  and          t5, t0, a7
                  sltiu        a1, s4, 1988
                  sra          s8, a5, s8
                  srli         sp, s3, 10
                  nop
                  c.and        s0, a3
                  or           a4, s7, s8
                  xor          a4, s11, s7
                  mulh         s11, s9, gp
                  auipc        a4, 881820
                  c.srli       a0, 28
                  srai         t0, t0, 4
                  divu         s10, sp, s1
                  xor          a4, s11, s7
                  c.or         a2, a5
                  lui          t2, 776121
                  slli         s4, a5, 26
                  c.lui        s8, 31
                  mulh         s11, s9, gp
                  sltu         s8, s9, s11
                  sub          s11, t4, a3
                  slli         s4, a5, 26
                  remu         s6, a4, s2
                  c.srai       a2, 4
                  or           a4, s7, s8
                  sll          s8, a6, a2
                  mulhsu       a7, s0, t4
                  slli         s4, a5, 26
                  c.add        t2, s3
                  xor          a4, s11, s7
                  andi         t0, s11, 1760
                  sub          s11, t4, a3
                  c.srli       a0, 28
                  c.srli       a0, 28
                  sra          s8, a5, s8
                  c.srai       a2, 4
                  c.li         a0, 21
                  c.srai       a2, 4
                  mulhu        t2, s5, t5
                  add          s6, s2, s10
                  c.andi       a0, -1
                  xor          a4, s11, s7
                  mulh         s11, s9, gp
                  c.li         a0, 21
                  mulhu        t2, s5, t5
                  mulhsu       a7, s0, t4
                  mulhu        t2, s5, t5
                  or           a4, s7, s8
                  srli         sp, s3, 10
                  c.addi4spn   s1, sp, 32
                  add          s6, s2, s10
                  divu         s10, sp, s1
                  c.lui        s8, 31
                  sltu         s8, s9, s11
                  slt          t4, s3, s11
                  c.lui        s8, 31
                  c.sub        a3, s1
                  c.lui        s8, 31
                  auipc        a4, 881820
                  c.li         a0, 21
                  xori         a3, s3, -1008
                  addi         s8, s2, 596
                  lui          t2, 776121
                  sll          s8, a6, a2
                  mulh         s11, s9, gp
                  xor          a4, s11, s7
                  c.nop
                  div          s0, t2, a0
                  c.srli       a0, 28
                  sra          s8, a5, s8
                  c.lui        s8, 31
                  div          s0, t2, a0
                  c.addi       t4, 20
                  andi         t0, s11, 1760
                  c.srai       a2, 4
                  add          s6, s2, s10
                  mulhu        t2, s5, t5
                  nop
                  c.addi4spn   s1, sp, 32
                  c.addi4spn   s1, sp, 32
                  add          s6, s2, s10
                  c.or         a2, a5
                  xori         a3, s3, -1008
                  c.add        t2, s3
                  c.addi       t4, 20
                  srl          gp, a7, s6
                  c.srai       a2, 4
                  mulh         s11, s9, gp
                  andi         t0, s11, 1760
                  c.and        s0, a3
                  c.mv         s8, a5
                  mulh         s11, s9, gp
                  div          s0, t2, a0
                  c.add        t2, s3
                  nop
                  nop
                  sltiu        a1, s4, 1988
                  addi         s8, s2, 596
                  xori         a3, s3, -1008
                  mul          a1, s6, s6
                  mulhu        t2, s5, t5
                  slti         gp, tp, -1791
                  srl          gp, a7, s6
                  nop
                  div          s0, t2, a0
                  xori         a3, s3, -1008
                  c.xor        s0, a5
                  srai         t0, t0, 4
                  mulhsu       a7, s0, t4
                  c.srli       a0, 28
                  c.sub        a3, s1
                  li           s11, 0x0 #start riscv_int_numeric_corner_stream_5
                  li           ra, 0x0
                  li           tp, 0xffffffff
                  li           t4, 0x80000000
                  li           sp, 0x80000000
                  li           t5, 0x80000000
                  li           t0, 0x0
                  li           s4, 0x8cecc953
                  li           a7, 0x0
                  li           t2, 0xbf184070
                  auipc        t4, 881820
                  sub          t4, s11, t2
                  div          s11, s11, t4
                  lui          s4, 776121
                  rem          t2, ra, s4
                  remu         t2, t4, tp
                  mulhsu       ra, t4, tp
                  remu         t2, t4, tp
                  mul          tp, s4, s4
                  rem          t2, ra, s4
                  nop
                  mulhsu       ra, t4, tp
                  auipc        t4, 881820
                  remu         t2, t4, tp
                  auipc        t4, 881820
                  add          t2, tp, sp
                  add          t2, tp, sp
                  addi         a7, tp, 596
                  mulhu        s4, a7, t0
                  divu         s11, tp, t5
                  remu         t2, t4, tp
                  div          s11, s11, t4
                  divu         s11, tp, t5
                  lui          s4, 776121
                  mulhsu       ra, t4, tp
                  auipc        t4, 881820
                  rem          t2, ra, s4
                  mul          tp, s4, s4 #end riscv_int_numeric_corner_stream_5
                  ori          s6, t3, 246
                  auipc        a4, 881820
                  and          t5, t0, a7
                  c.lui        s8, 31
                  divu         s10, sp, s1
                  rem          s6, a2, t4
                  remu         s6, a4, s2
                  and          t5, t0, a7
                  c.li         a0, 21
                  c.add        t2, s3
                  slli         s4, a5, 26
                  mulhsu       a7, s0, t4
                  c.andi       a0, -1
                  addi         s8, s2, 596
                  slt          t4, s3, s11
                  remu         s6, a4, s2
                  ori          s6, t3, 246
                  c.addi       t4, 20
                  div          s0, t2, a0
                  or           a4, s7, s8
                  c.andi       a0, -1
                  mulhu        t2, s5, t5
                  sll          s8, a6, a2
                  c.slli       s11, 17
                  xor          a4, s11, s7
                  xori         a3, s3, -1008
                  c.add        t2, s3
                  lui          t2, 776121
                  c.addi16sp   sp, 400
                  c.andi       a0, -1
                  xor          a4, s11, s7
                  c.nop
                  mulh         s11, s9, gp
                  sub          s11, t4, a3
                  c.lui        s8, 31
                  c.xor        s0, a5
                  c.srli       a0, 28
                  slti         gp, tp, -1791
                  c.xor        s0, a5
                  mulh         s11, s9, gp
                  c.nop
                  ori          s6, t3, 246
                  c.mv         s8, a5
                  sltiu        a1, s4, 1988
                  rem          s6, a2, t4
                  c.li         a0, 21
                  c.mv         s8, a5
                  c.or         a2, a5
                  c.andi       a0, -1
                  remu         s6, a4, s2
                  c.addi       t4, 20
                  c.nop
                  lui          t2, 776121
                  srai         t0, t0, 4
                  remu         s6, a4, s2
                  add          s6, s2, s10
                  c.mv         s8, a5
                  lui          t2, 776121
                  rem          s6, a2, t4
                  mulh         s11, s9, gp
                  xor          a4, s11, s7
                  xori         a3, s3, -1008
                  c.slli       s11, 17
                  auipc        a4, 881820
                  div          s0, t2, a0
                  remu         s6, a4, s2
                  rem          s6, a2, t4
                  add          s6, s2, s10
                  slt          t4, s3, s11
                  sub          s11, t4, a3
                  auipc        a4, 881820
                  srai         t0, t0, 4
                  nop
                  c.xor        s0, a5
                  or           a4, s7, s8
                  c.or         a2, a5
                  c.nop
                  c.andi       a0, -1
                  xori         a3, s3, -1008
                  auipc        a4, 881820
                  c.slli       s11, 17
                  addi         s8, s2, 596
                  c.or         a2, a5
                  xori         a3, s3, -1008
                  mulhsu       a7, s0, t4
                  slt          t4, s3, s11
                  xori         a3, s3, -1008
                  slt          t4, s3, s11
                  nop
                  c.or         a2, a5
                  c.addi16sp   sp, 400
                  slt          t4, s3, s11
                  slli         s4, a5, 26
                  c.xor        s0, a5
                  srli         sp, s3, 10
                  c.andi       a0, -1
                  lui          t2, 776121
                  nop
                  srli         sp, s3, 10
                  xor          a4, s11, s7
                  c.sub        a3, s1
                  c.andi       a0, -1
                  c.add        t2, s3
                  andi         t0, s11, 1760
                  mulhsu       a7, s0, t4
                  c.srai       a2, 4
                  nop
                  lui          t2, 776121
                  ori          s6, t3, 246
                  and          t5, t0, a7
                  c.or         a2, a5
                  andi         t0, s11, 1760
                  lui          t2, 776121
                  xori         a3, s3, -1008
                  srli         sp, s3, 10
                  c.sub        a3, s1
                  c.and        s0, a3
                  c.add        t2, s3
                  or           a4, s7, s8
                  srli         sp, s3, 10
                  slli         s4, a5, 26
                  remu         s6, a4, s2
                  c.addi16sp   sp, 400
                  c.li         a0, 21
                  remu         s6, a4, s2
                  c.slli       s11, 17
                  sll          s8, a6, a2
                  rem          s6, a2, t4
                  sltu         s8, s9, s11
                  c.lui        s8, 31
                  mulhsu       a7, s0, t4
                  slt          t4, s3, s11
                  xori         a3, s3, -1008
                  slt          t4, s3, s11
                  sltu         s8, s9, s11
                  sub          s11, t4, a3
                  sltiu        a1, s4, 1988
                  c.nop
                  c.addi       t4, 20
                  srai         t0, t0, 4
                  c.lui        s8, 31
                  sltu         s8, s9, s11
                  c.lui        s8, 31
                  addi         s8, s2, 596
                  or           a4, s7, s8
                  c.lui        s8, 31
                  xori         a3, s3, -1008
                  sltiu        a1, s4, 1988
                  sltu         s8, s9, s11
                  sltiu        a1, s4, 1988
                  c.lui        s8, 31
                  slti         gp, tp, -1791
                  andi         t0, s11, 1760
                  c.add        t2, s3
                  c.andi       a0, -1
                  c.addi4spn   s1, sp, 32
                  c.or         a2, a5
                  c.addi16sp   sp, 400
                  sll          s8, a6, a2
                  ori          s6, t3, 246
                  addi         s8, s2, 596
                  c.xor        s0, a5
                  rem          s6, a2, t4
                  slli         s4, a5, 26
                  c.li         a0, 21
                  remu         s6, a4, s2
                  auipc        a4, 881820
                  and          t5, t0, a7
                  c.mv         s8, a5
                  mulhu        t2, s5, t5
                  addi         s8, s2, 596
                  c.addi4spn   s1, sp, 32
                  auipc        a4, 881820
                  sltu         s8, s9, s11
                  auipc        a4, 881820
                  auipc        a4, 881820
                  c.srli       a0, 28
                  c.addi16sp   sp, 400
                  c.addi16sp   sp, 400
                  srli         sp, s3, 10
                  c.or         a2, a5
                  auipc        a4, 881820
                  sub          s11, t4, a3
                  lui          t2, 776121
                  add          s6, s2, s10
                  c.lui        s8, 31
                  c.sub        a3, s1
                  ori          s6, t3, 246
                  ori          s6, t3, 246
                  lui          t2, 776121
                  c.addi16sp   sp, 400
                  mul          a1, s6, s6
                  c.srai       a2, 4
                  slti         gp, tp, -1791
                  c.andi       a0, -1
                  sltiu        a1, s4, 1988
                  div          s0, t2, a0
                  remu         s6, a4, s2
                  sltu         s8, s9, s11
                  slti         gp, tp, -1791
                  c.andi       a0, -1
                  or           a4, s7, s8
                  c.or         a2, a5
                  c.and        s0, a3
                  c.addi       t4, 20
                  andi         t0, s11, 1760
                  mulhsu       a7, s0, t4
                  srli         sp, s3, 10
                  mulh         s11, s9, gp
                  c.srai       a2, 4
                  c.lui        s8, 31
                  remu         s6, a4, s2
                  c.add        t2, s3
                  sltiu        a1, s4, 1988
                  mulhu        t2, s5, t5
                  c.srli       a0, 28
                  c.addi16sp   sp, 400
                  xori         a3, s3, -1008
                  c.mv         s8, a5
                  mulhu        t2, s5, t5
                  c.or         a2, a5
                  c.lui        s8, 31
                  c.lui        s8, 31
                  mulhsu       a7, s0, t4
                  c.or         a2, a5
                  srai         t0, t0, 4
                  sll          s8, a6, a2
                  sub          s11, t4, a3
                  xor          a4, s11, s7
                  c.or         a2, a5
                  mulhsu       a7, s0, t4
                  sub          s11, t4, a3
                  nop
                  auipc        a4, 881820
                  c.addi16sp   sp, 400
                  c.li         a0, 21
                  c.or         a2, a5
                  mulh         s11, s9, gp
                  or           a4, s7, s8
                  andi         t0, s11, 1760
                  c.srli       a0, 28
                  sltu         s8, s9, s11
                  sll          s8, a6, a2
                  rem          s6, a2, t4
                  c.addi4spn   s1, sp, 32
                  sra          s8, a5, s8
                  or           a4, s7, s8
                  c.add        t2, s3
                  lui          t2, 776121
                  sll          s8, a6, a2
                  rem          s6, a2, t4
                  add          s6, s2, s10
                  mulhu        t2, s5, t5
                  slt          t4, s3, s11
                  srli         sp, s3, 10
                  c.xor        s0, a5
                  c.slli       s11, 17
                  c.li         a0, 21
                  c.lui        s8, 31
                  sll          s8, a6, a2
                  xori         a3, s3, -1008
                  c.xor        s0, a5
                  mulhu        t2, s5, t5
                  rem          s6, a2, t4
                  sll          s8, a6, a2
                  sltu         s8, s9, s11
                  remu         s6, a4, s2
                  c.sub        a3, s1
                  c.slli       s11, 17
                  add          s6, s2, s10
                  c.srai       a2, 4
                  c.slli       s11, 17
                  xori         a3, s3, -1008
                  and          t5, t0, a7
                  mulh         s11, s9, gp
                  xor          a4, s11, s7
                  ori          s6, t3, 246
                  addi         s8, s2, 596
                  c.li         a0, 21
                  slli         s4, a5, 26
                  c.nop
                  c.andi       a0, -1
                  c.mv         s8, a5
                  and          t5, t0, a7
                  c.andi       a0, -1
                  c.addi16sp   sp, 400
                  slti         gp, tp, -1791
                  divu         s10, sp, s1
                  c.xor        s0, a5
                  xor          a4, s11, s7
                  sll          s8, a6, a2
                  sltu         s8, s9, s11
                  add          s6, s2, s10
                  ori          s6, t3, 246
                  c.mv         s8, a5
                  c.sub        a3, s1
                  sll          s8, a6, a2
                  sll          s8, a6, a2
                  or           a4, s7, s8
                  mulhsu       a7, s0, t4
                  mulhu        t2, s5, t5
                  mul          a1, s6, s6
                  sltiu        a1, s4, 1988
                  rem          s6, a2, t4
                  sub          s11, t4, a3
                  xori         a3, s3, -1008
                  div          s0, t2, a0
                  c.li         a0, 21
                  sltiu        a1, s4, 1988
                  nop
                  ori          s6, t3, 246
                  c.xor        s0, a5
                  c.lui        s8, 31
                  mulhsu       a7, s0, t4
                  remu         s6, a4, s2
                  andi         t0, s11, 1760
                  c.and        s0, a3
                  c.slli       s11, 17
                  ori          s6, t3, 246
                  remu         s6, a4, s2
                  sltu         s8, s9, s11
                  slli         s4, a5, 26
                  sltu         s8, s9, s11
                  mulhu        t2, s5, t5
                  sltu         s8, s9, s11
                  xori         a3, s3, -1008
                  c.lui        s8, 31
                  slti         gp, tp, -1791
                  c.slli       s11, 17
                  srli         sp, s3, 10
                  or           a4, s7, s8
                  c.addi4spn   s1, sp, 32
                  srai         t0, t0, 4
                  slti         gp, tp, -1791
                  sll          s8, a6, a2
                  c.andi       a0, -1
                  div          s0, t2, a0
                  sub          s11, t4, a3
                  sra          s8, a5, s8
                  mulh         s11, s9, gp
                  xor          a4, s11, s7
                  andi         t0, s11, 1760
                  c.mv         s8, a5
                  rem          s6, a2, t4
                  srai         t0, t0, 4
                  srl          gp, a7, s6
                  mulhu        t2, s5, t5
                  c.andi       a0, -1
                  c.nop
                  divu         s10, sp, s1
                  c.lui        s8, 31
                  c.srai       a2, 4
                  srai         t0, t0, 4
                  div          s0, t2, a0
                  c.srai       a2, 4
                  sltiu        a1, s4, 1988
                  sll          s8, a6, a2
                  sltu         s8, s9, s11
                  c.add        t2, s3
                  c.srli       a0, 28
                  srli         sp, s3, 10
                  mulhu        t2, s5, t5
                  c.addi4spn   s1, sp, 32
                  divu         s10, sp, s1
                  c.lui        s8, 31
                  mulhsu       a7, s0, t4
                  mul          a1, s6, s6
                  or           a4, s7, s8
                  c.srli       a0, 28
                  xor          a4, s11, s7
                  sltiu        a1, s4, 1988
                  c.addi16sp   sp, 400
                  mul          a1, s6, s6
                  c.lui        s8, 31
                  or           a4, s7, s8
                  addi         s8, s2, 596
                  andi         t0, s11, 1760
                  c.xor        s0, a5
                  or           a4, s7, s8
                  ori          s6, t3, 246
                  mulhsu       a7, s0, t4
                  div          s0, t2, a0
                  div          s0, t2, a0
                  c.nop
                  andi         t0, s11, 1760
                  addi         s8, s2, 596
                  nop
                  addi         s8, s2, 596
                  srai         t0, t0, 4
                  mulh         s11, s9, gp
                  auipc        a4, 881820
                  srai         t0, t0, 4
                  ori          s6, t3, 246
                  c.add        t2, s3
                  mul          a1, s6, s6
                  div          s0, t2, a0
                  mulhu        t2, s5, t5
                  c.srai       a2, 4
                  c.and        s0, a3
                  slti         gp, tp, -1791
                  add          s6, s2, s10
                  ori          s6, t3, 246
                  mul          a1, s6, s6
                  srli         sp, s3, 10
                  auipc        a4, 881820
                  sub          s11, t4, a3
                  auipc        a4, 881820
                  c.srai       a2, 4
                  c.li         a0, 21
                  mulhu        t2, s5, t5
                  mul          a1, s6, s6
                  c.sub        a3, s1
                  xor          a4, s11, s7
                  c.addi16sp   sp, 400
                  and          t5, t0, a7
                  sll          s8, a6, a2
                  rem          s6, a2, t4
                  and          t5, t0, a7
                  sub          s11, t4, a3
                  mulhu        t2, s5, t5
                  c.add        t2, s3
                  srli         sp, s3, 10
                  and          t5, t0, a7
                  xori         a3, s3, -1008
                  slti         gp, tp, -1791
                  c.slli       s11, 17
                  div          s0, t2, a0
                  slli         s4, a5, 26
                  c.li         a0, 21
                  lui          t2, 776121
                  c.addi16sp   sp, 400
                  c.and        s0, a3
                  slt          t4, s3, s11
                  sub          s11, t4, a3
                  rem          s6, a2, t4
                  c.or         a2, a5
                  c.sub        a3, s1
                  sll          s8, a6, a2
                  lui          t2, 776121
                  ori          s6, t3, 246
                  c.addi4spn   s1, sp, 32
                  divu         s10, sp, s1
                  sltiu        a1, s4, 1988
                  c.srai       a2, 4
                  srai         t0, t0, 4
                  srli         sp, s3, 10
                  and          t5, t0, a7
                  andi         t0, s11, 1760
                  andi         t0, s11, 1760
                  slt          t4, s3, s11
                  srli         sp, s3, 10
                  c.andi       a0, -1
                  c.and        s0, a3
                  xor          a4, s11, s7
                  c.li         a0, 21
                  sltiu        a1, s4, 1988
                  mul          a1, s6, s6
                  c.lui        s8, 31
                  c.slli       s11, 17
                  c.srai       a2, 4
                  c.addi16sp   sp, 400
                  c.addi16sp   sp, 400
                  c.addi       t4, 20
                  slti         gp, tp, -1791
                  sra          s8, a5, s8
                  rem          s6, a2, t4
                  c.mv         s8, a5
                  lui          t2, 776121
                  c.li         a0, 21
                  sra          s8, a5, s8
                  xor          a4, s11, s7
                  sltiu        a1, s4, 1988
                  sra          s8, a5, s8
                  c.addi4spn   s1, sp, 32
                  slli         s4, a5, 26
                  slti         gp, tp, -1791
                  or           a4, s7, s8
                  lui          t2, 776121
                  lui          t2, 776121
                  c.mv         s8, a5
                  srai         t0, t0, 4
                  c.slli       s11, 17
                  mulh         s11, s9, gp
                  c.or         a2, a5
                  sll          s8, a6, a2
                  mulhu        t2, s5, t5
                  xori         a3, s3, -1008
                  c.xor        s0, a5
                  nop
                  and          t5, t0, a7
                  c.mv         s8, a5
                  c.srai       a2, 4
                  addi         s8, s2, 596
                  c.li         a0, 21
                  mulhsu       a7, s0, t4
                  mulhu        t2, s5, t5
                  c.addi       t4, 20
                  c.andi       a0, -1
                  xori         a3, s3, -1008
                  c.lui        s8, 31
                  ori          s6, t3, 246
                  c.lui        s8, 31
                  sra          s8, a5, s8
                  sltu         s8, s9, s11
                  c.andi       a0, -1
                  c.mv         s8, a5
                  sub          s11, t4, a3
                  c.addi       t4, 20
                  ori          s6, t3, 246
                  auipc        a4, 881820
                  c.addi4spn   s1, sp, 32
                  c.lui        s8, 31
                  sltiu        a1, s4, 1988
                  c.and        s0, a3
                  c.and        s0, a3
                  add          s6, s2, s10
                  c.and        s0, a3
                  slt          t4, s3, s11
                  auipc        a4, 881820
                  sra          s8, a5, s8
                  sltu         s8, s9, s11
                  or           a4, s7, s8
                  srai         t0, t0, 4
                  div          s0, t2, a0
                  rem          s6, a2, t4
                  c.addi4spn   s1, sp, 32
                  srai         t0, t0, 4
                  slti         gp, tp, -1791
                  or           a4, s7, s8
                  and          t5, t0, a7
                  mulh         s11, s9, gp
                  sra          s8, a5, s8
                  srai         t0, t0, 4
                  nop
                  slli         s4, a5, 26
                  c.li         a0, 21
                  c.addi4spn   s1, sp, 32
                  c.addi       t4, 20
                  sub          s11, t4, a3
                  c.srai       a2, 4
                  sub          s11, t4, a3
                  c.andi       a0, -1
                  add          s6, s2, s10
                  nop
                  slti         gp, tp, -1791
                  and          t5, t0, a7
                  c.and        s0, a3
                  nop
                  srl          gp, a7, s6
                  and          t5, t0, a7
                  c.add        t2, s3
                  mulhsu       a7, s0, t4
                  ori          s6, t3, 246
                  div          s0, t2, a0
                  srl          gp, a7, s6
                  xor          a4, s11, s7
                  mulh         s11, s9, gp
                  xori         a3, s3, -1008
                  divu         s10, sp, s1
                  sub          s11, t4, a3
                  srl          gp, a7, s6
                  srai         t0, t0, 4
                  auipc        a4, 881820
                  c.addi16sp   sp, 400
                  c.srai       a2, 4
                  addi         s8, s2, 596
                  divu         s10, sp, s1
                  srl          gp, a7, s6
                  slt          t4, s3, s11
                  nop
                  c.slli       s11, 17
                  slt          t4, s3, s11
                  sltu         s8, s9, s11
                  ori          s6, t3, 246
                  add          s6, s2, s10
                  andi         t0, s11, 1760
                  nop
                  c.lui        s8, 31
                  sltu         s8, s9, s11
                  sub          s11, t4, a3
                  srl          gp, a7, s6
                  div          s0, t2, a0
                  mulhsu       a7, s0, t4
                  mulh         s11, s9, gp
                  ori          s6, t3, 246
                  nop
                  div          s0, t2, a0
                  remu         s6, a4, s2
                  c.nop
                  srai         t0, t0, 4
                  c.add        t2, s3
                  div          s0, t2, a0
                  or           a4, s7, s8
                  auipc        a4, 881820
                  andi         t0, s11, 1760
                  andi         t0, s11, 1760
                  auipc        a4, 881820
                  c.addi16sp   sp, 400
                  sub          s11, t4, a3
                  nop
                  remu         s6, a4, s2
                  rem          s6, a2, t4
                  c.addi16sp   sp, 400
                  sub          s11, t4, a3
                  nop
                  xor          a4, s11, s7
                  and          t5, t0, a7
                  c.slli       s11, 17
                  xori         a3, s3, -1008
                  nop
                  sltiu        a1, s4, 1988
                  c.andi       a0, -1
                  srli         sp, s3, 10
                  mulhu        t2, s5, t5
                  slt          t4, s3, s11
                  xor          a4, s11, s7
                  ori          s6, t3, 246
                  srai         t0, t0, 4
                  c.addi4spn   s1, sp, 32
                  c.addi4spn   s1, sp, 32
                  and          t5, t0, a7
                  c.srli       a0, 28
                  sra          s8, a5, s8
                  slt          t4, s3, s11
                  mulhu        t2, s5, t5
                  lui          t2, 776121
                  lui          t2, 776121
                  c.xor        s0, a5
                  mul          a1, s6, s6
                  divu         s10, sp, s1
                  xori         a3, s3, -1008
                  mulhu        t2, s5, t5
                  nop
                  slt          t4, s3, s11
                  sll          s8, a6, a2
                  c.lui        s8, 31
                  sltiu        a1, s4, 1988
                  div          s0, t2, a0
                  addi         s8, s2, 596
                  c.mv         s8, a5
                  c.addi16sp   sp, 400
                  and          t5, t0, a7
                  xori         a3, s3, -1008
                  c.mv         s8, a5
                  lui          t2, 776121
                  srai         t0, t0, 4
                  c.slli       s11, 17
                  c.lui        s8, 31
                  c.addi16sp   sp, 400
                  c.li         a0, 21
                  slli         s4, a5, 26
                  ori          s6, t3, 246
                  sll          s8, a6, a2
                  add          s6, s2, s10
                  c.srai       a2, 4
                  srli         sp, s3, 10
                  mulhsu       a7, s0, t4
                  c.srai       a2, 4
                  c.add        t2, s3
                  ori          s6, t3, 246
                  or           a4, s7, s8
                  xori         a3, s3, -1008
                  c.addi       t4, 20
                  c.li         a0, 21
                  mulhu        t2, s5, t5
                  xor          a4, s11, s7
                  srli         sp, s3, 10
                  srli         sp, s3, 10
                  mulhu        t2, s5, t5
                  divu         s10, sp, s1
                  c.and        s0, a3
                  slti         gp, tp, -1791
                  sra          s8, a5, s8
                  nop
                  rem          s6, a2, t4
                  and          t5, t0, a7
                  c.slli       s11, 17
                  c.addi4spn   s1, sp, 32
                  rem          s6, a2, t4
                  or           a4, s7, s8
                  nop
                  xori         a3, s3, -1008
                  ori          s6, t3, 246
                  divu         s10, sp, s1
                  srl          gp, a7, s6
                  c.sub        a3, s1
                  andi         t0, s11, 1760
                  srli         sp, s3, 10
                  and          t5, t0, a7
                  c.nop
                  c.addi16sp   sp, 400
                  sltu         s8, s9, s11
                  slt          t4, s3, s11
                  c.nop
                  c.mv         s8, a5
                  slti         gp, tp, -1791
                  sra          s8, a5, s8
                  c.nop
                  c.and        s0, a3
                  lui          t2, 776121
                  slti         gp, tp, -1791
                  c.and        s0, a3
                  c.srli       a0, 28
                  slli         s4, a5, 26
                  add          s6, s2, s10
                  sltiu        a1, s4, 1988
                  c.li         a0, 21
                  c.lui        s8, 31
                  c.lui        s8, 31
                  mul          a1, s6, s6
                  sra          s8, a5, s8
                  div          s0, t2, a0
                  c.srli       a0, 28
                  slti         gp, tp, -1791
                  auipc        a4, 881820
                  c.addi       t4, 20
                  c.nop
                  mulhu        t2, s5, t5
                  slli         s4, a5, 26
                  sltiu        a1, s4, 1988
                  sltiu        a1, s4, 1988
                  slli         s4, a5, 26
                  srai         t0, t0, 4
                  c.add        t2, s3
                  c.addi       t4, 20
                  srai         t0, t0, 4
                  c.slli       s11, 17
                  sra          s8, a5, s8
                  sub          s11, t4, a3
                  c.xor        s0, a5
                  mul          a1, s6, s6
                  mul          a1, s6, s6
                  srai         t0, t0, 4
                  sll          s8, a6, a2
                  andi         t0, s11, 1760
                  slti         gp, tp, -1791
                  c.slli       s11, 17
                  andi         t0, s11, 1760
                  c.lui        s8, 31
                  c.lui        s8, 31
                  c.add        t2, s3
                  mulhsu       a7, s0, t4
                  c.srli       a0, 28
                  remu         s6, a4, s2
                  mulh         s11, s9, gp
                  nop
                  slli         s4, a5, 26
                  mulhu        t2, s5, t5
                  srai         t0, t0, 4
                  andi         t0, s11, 1760
                  c.addi4spn   s1, sp, 32
                  c.sub        a3, s1
                  rem          s6, a2, t4
                  nop
                  c.srai       a2, 4
                  sltu         s8, s9, s11
                  remu         s6, a4, s2
                  c.addi16sp   sp, 400
                  c.lui        s8, 31
                  srai         t0, t0, 4
                  rem          s6, a2, t4
                  lui          t2, 776121
                  divu         s10, sp, s1
                  srai         t0, t0, 4
                  c.srai       a2, 4
                  c.mv         s8, a5
                  srli         sp, s3, 10
                  add          s6, s2, s10
                  c.or         a2, a5
                  mul          a1, s6, s6
                  slti         gp, tp, -1791
                  c.or         a2, a5
                  c.or         a2, a5
                  remu         s6, a4, s2
                  and          t5, t0, a7
                  c.lui        s8, 31
                  add          s6, s2, s10
                  nop
                  sll          s8, a6, a2
                  lui          t2, 776121
                  c.nop
                  c.slli       s11, 17
                  addi         s8, s2, 596
                  andi         t0, s11, 1760
                  mulhu        t2, s5, t5
                  slti         gp, tp, -1791
                  c.sub        a3, s1
                  addi         s8, s2, 596
                  addi         s8, s2, 596
                  nop
                  c.lui        s8, 31
                  srli         sp, s3, 10
                  add          s6, s2, s10
                  ori          s6, t3, 246
                  c.mv         s8, a5
                  c.addi       t4, 20
                  srai         t0, t0, 4
                  c.slli       s11, 17
                  sub          s11, t4, a3
                  mulhsu       a7, s0, t4
                  slt          t4, s3, s11
                  c.nop
                  c.nop
                  c.addi       t4, 20
                  sll          s8, a6, a2
                  c.addi       t4, 20
                  c.srli       a0, 28
                  c.and        s0, a3
                  c.or         a2, a5
                  divu         s10, sp, s1
                  sltu         s8, s9, s11
                  c.xor        s0, a5
                  c.and        s0, a3
                  remu         s6, a4, s2
                  c.li         a0, 21
                  c.add        t2, s3
                  c.or         a2, a5
                  sra          s8, a5, s8
                  divu         s10, sp, s1
                  srli         sp, s3, 10
                  c.li         a0, 21
                  c.andi       a0, -1
                  c.addi16sp   sp, 400
                  c.or         a2, a5
                  slt          t4, s3, s11
                  c.nop
                  ori          s6, t3, 246
                  ori          s6, t3, 246
                  auipc        a4, 881820
                  sub          s11, t4, a3
                  nop
                  srai         t0, t0, 4
                  div          s0, t2, a0
                  srl          gp, a7, s6
                  c.addi4spn   s1, sp, 32
                  rem          s6, a2, t4
                  addi         s8, s2, 596
                  divu         s10, sp, s1
                  auipc        a4, 881820
                  c.lui        s8, 31
                  c.add        t2, s3
                  c.andi       a0, -1
                  c.srai       a2, 4
                  c.and        s0, a3
                  mulh         s11, s9, gp
                  c.addi4spn   s1, sp, 32
                  xor          a4, s11, s7
                  and          t5, t0, a7
                  andi         t0, s11, 1760
                  divu         s10, sp, s1
                  andi         t0, s11, 1760
                  and          t5, t0, a7
                  srai         t0, t0, 4
                  sltu         s8, s9, s11
                  sll          s8, a6, a2
                  mulh         s11, s9, gp
                  c.addi16sp   sp, 400
                  addi         s8, s2, 596
                  div          s0, t2, a0
                  c.xor        s0, a5
                  srai         t0, t0, 4
                  srli         sp, s3, 10
                  c.sub        a3, s1
                  nop
                  remu         s6, a4, s2
                  srl          gp, a7, s6
                  c.slli       s11, 17
                  sltu         s8, s9, s11
                  c.srai       a2, 4
                  c.and        s0, a3
                  ori          s6, t3, 246
                  c.srli       a0, 28
                  srli         sp, s3, 10
                  srai         t0, t0, 4
                  ori          s6, t3, 246
                  mulhsu       a7, s0, t4
                  c.li         a0, 21
                  slli         s4, a5, 26
                  c.or         a2, a5
                  rem          s6, a2, t4
                  andi         t0, s11, 1760
                  c.addi16sp   sp, 400
                  c.slli       s11, 17
                  c.andi       a0, -1
                  sub          s11, t4, a3
                  sll          s8, a6, a2
                  c.xor        s0, a5
                  or           a4, s7, s8
                  sub          s11, t4, a3
                  c.xor        s0, a5
                  li           a7, 0xffffffff #start riscv_int_numeric_corner_stream_7
                  li           s5, 0x0
                  li           s0, 0x0
                  li           a5, 0xf868c9fb
                  li           t2, 0xffffffff
                  li           s6, 0xffffffff
                  li           a4, 0xffffffff
                  li           s10, 0x0
                  li           t4, 0x6a36f232
                  li           tp, 0x80000000
                  mulhu        s5, a7, a4
                  auipc        s10, 881820
                  mulhsu       tp, s10, s0
                  mulhu        s5, a7, a4
                  sub          s10, s6, a5
                  mulhsu       tp, s10, s0
                  remu         a5, s10, s0
                  remu         a5, s10, s0
                  nop
                  mul          s0, s5, s5
                  mulhu        s5, a7, a4
                  div          s6, s6, s10
                  rem          a5, tp, s5
                  mulhu        s5, a7, a4
                  add          a5, s0, t2
                  divu         s6, s0, t4
                  mulhu        s5, a7, a4
                  mulhsu       tp, s10, s0
                  rem          a5, tp, s5
                  sub          s10, s6, a5
                  mulh         s10, t4, a4 #end riscv_int_numeric_corner_stream_7
                  mulhsu       a7, s0, t4
                  div          s0, t2, a0
                  slt          t4, s3, s11
                  c.addi4spn   s1, sp, 32
                  mulhsu       a7, s0, t4
                  srl          gp, a7, s6
                  c.andi       a0, -1
                  sltu         s8, s9, s11
                  c.addi4spn   s1, sp, 32
                  remu         s6, a4, s2
                  c.xor        s0, a5
                  divu         s10, sp, s1
                  c.andi       a0, -1
                  lui          t2, 776121
                  c.mv         s8, a5
                  c.andi       a0, -1
                  srl          gp, a7, s6
                  c.and        s0, a3
                  sltiu        a1, s4, 1988
                  mulhsu       a7, s0, t4
                  lui          t2, 776121
                  c.addi       t4, 20
                  c.or         a2, a5
                  c.nop
                  and          t5, t0, a7
                  remu         s6, a4, s2
                  c.mv         s8, a5
                  or           a4, s7, s8
                  remu         s6, a4, s2
                  auipc        a4, 881820
                  c.xor        s0, a5
                  rem          s6, a2, t4
                  sra          s8, a5, s8
                  sltu         s8, s9, s11
                  slt          t4, s3, s11
                  add          s6, s2, s10
                  srai         t0, t0, 4
                  c.slli       s11, 17
                  c.sub        a3, s1
                  auipc        a4, 881820
                  c.srai       a2, 4
                  ori          s6, t3, 246
                  nop
                  mulhsu       a7, s0, t4
                  c.and        s0, a3
                  sub          s11, t4, a3
                  remu         s6, a4, s2
                  sll          s8, a6, a2
                  ori          s6, t3, 246
                  lui          t2, 776121
                  remu         s6, a4, s2
                  sra          s8, a5, s8
                  c.addi       t4, 20
                  addi         s8, s2, 596
                  or           a4, s7, s8
                  c.nop
                  mulhu        t2, s5, t5
                  mulhsu       a7, s0, t4
                  srl          gp, a7, s6
                  c.nop
                  srl          gp, a7, s6
                  srai         t0, t0, 4
                  c.addi       t4, 20
                  mulh         s11, s9, gp
                  slti         gp, tp, -1791
                  nop
                  c.and        s0, a3
                  mulhu        t2, s5, t5
                  srai         t0, t0, 4
                  c.or         a2, a5
                  sltiu        a1, s4, 1988
                  sltu         s8, s9, s11
                  c.mv         s8, a5
                  mulhsu       a7, s0, t4
                  xor          a4, s11, s7
                  c.addi16sp   sp, 400
                  or           a4, s7, s8
                  c.xor        s0, a5
                  sll          s8, a6, a2
                  c.or         a2, a5
                  ori          s6, t3, 246
                  remu         s6, a4, s2
                  c.sub        a3, s1
                  c.nop
                  srai         t0, t0, 4
                  sltiu        a1, s4, 1988
                  auipc        a4, 881820
                  slti         gp, tp, -1791
                  lui          t2, 776121
                  auipc        a4, 881820
                  sub          s11, t4, a3
                  c.addi16sp   sp, 400
                  lui          t2, 776121
                  ori          s6, t3, 246
                  sltu         s8, s9, s11
                  c.xor        s0, a5
                  c.add        t2, s3
                  srai         t0, t0, 4
                  c.add        t2, s3
                  mulhu        t2, s5, t5
                  c.or         a2, a5
                  nop
                  remu         s6, a4, s2
                  nop
                  div          s0, t2, a0
                  lui          t2, 776121
                  ori          s6, t3, 246
                  c.and        s0, a3
                  slti         gp, tp, -1791
                  c.xor        s0, a5
                  mulhu        t2, s5, t5
                  addi         s8, s2, 596
                  c.sub        a3, s1
                  rem          s6, a2, t4
                  srl          gp, a7, s6
                  c.mv         s8, a5
                  xor          a4, s11, s7
                  srli         sp, s3, 10
                  addi         s8, s2, 596
                  c.add        t2, s3
                  c.add        t2, s3
                  c.srli       a0, 28
                  c.srai       a2, 4
                  sra          s8, a5, s8
                  auipc        a4, 881820
                  addi         s8, s2, 596
                  c.addi4spn   s1, sp, 32
                  andi         t0, s11, 1760
                  lui          t2, 776121
                  sltu         s8, s9, s11
                  c.addi16sp   sp, 400
                  c.addi       t4, 20
                  and          t5, t0, a7
                  c.andi       a0, -1
                  sltu         s8, s9, s11
                  slt          t4, s3, s11
                  c.addi4spn   s1, sp, 32
                  c.lui        s8, 31
                  sub          s11, t4, a3
                  c.addi4spn   s1, sp, 32
                  sub          s11, t4, a3
                  c.sub        a3, s1
                  c.slli       s11, 17
                  c.or         a2, a5
                  divu         s10, sp, s1
                  xori         a3, s3, -1008
                  remu         s6, a4, s2
                  slli         s4, a5, 26
                  c.nop
                  slti         gp, tp, -1791
                  c.lui        s8, 31
                  c.srai       a2, 4
                  c.mv         s8, a5
                  xori         a3, s3, -1008
                  mul          a1, s6, s6
                  c.addi16sp   sp, 400
                  ori          s6, t3, 246
                  remu         s6, a4, s2
                  mulh         s11, s9, gp
                  c.xor        s0, a5
                  sltiu        a1, s4, 1988
                  lui          t2, 776121
                  c.and        s0, a3
                  c.add        t2, s3
                  andi         t0, s11, 1760
                  sltu         s8, s9, s11
                  nop
                  slli         s4, a5, 26
                  slt          t4, s3, s11
                  auipc        a4, 881820
                  srl          gp, a7, s6
                  c.mv         s8, a5
                  addi         s8, s2, 596
                  c.sub        a3, s1
                  andi         t0, s11, 1760
                  or           a4, s7, s8
                  xor          a4, s11, s7
                  add          s6, s2, s10
                  c.mv         s8, a5
                  sll          s8, a6, a2
                  slt          t4, s3, s11
                  sltiu        a1, s4, 1988
                  div          s0, t2, a0
                  xori         a3, s3, -1008
                  c.mv         s8, a5
                  auipc        a4, 881820
                  xor          a4, s11, s7
                  slt          t4, s3, s11
                  div          s0, t2, a0
                  c.addi16sp   sp, 400
                  li           a2, 0xffffffff #start riscv_int_numeric_corner_stream_26
                  li           t4, 0x0
                  li           tp, 0x0
                  li           s1, 0x80000000
                  li           s9, 0x8ba3f408
                  li           s5, 0x80000000
                  li           t0, 0x80000000
                  li           s6, 0x0
                  li           t3, 0xffffffff
                  li           a1, 0x80000000
                  add          a2, s1, t0
                  auipc        t3, 881820
                  rem          a2, tp, s6
                  remu         a2, t3, s1
                  add          a2, s1, t0
                  mulhsu       tp, t3, s1
                  add          a2, s1, t0
                  sub          t3, s9, a2
                  remu         a2, t3, s1
                  auipc        t3, 881820
                  mul          s1, s6, s6
                  mulhsu       tp, t3, s1
                  remu         a2, t3, s1
                  lui          s6, 776121
                  addi         s5, s1, 596
                  mulhu        s6, s5, a1
                  nop
                  sub          t3, s9, a2
                  divu         s9, s1, t4
                  addi         s5, s1, 596
                  mulhsu       tp, t3, s1
                  rem          a2, tp, s6
                  divu         s9, s1, t4
                  sub          t3, s9, a2
                  remu         a2, t3, s1
                  nop
                  addi         s5, s1, 596 #end riscv_int_numeric_corner_stream_26
                  ori          s6, t3, 246
                  c.mv         s8, a5
                  c.and        s0, a3
                  c.li         a0, 21
                  ori          s6, t3, 246
                  andi         t0, s11, 1760
                  c.srli       a0, 28
                  c.addi       t4, 20
                  add          s6, s2, s10
                  sltu         s8, s9, s11
                  rem          s6, a2, t4
                  andi         t0, s11, 1760
                  c.addi4spn   s1, sp, 32
                  c.li         a0, 21
                  ori          s6, t3, 246
                  c.li         a0, 21
                  sltu         s8, s9, s11
                  sltiu        a1, s4, 1988
                  c.addi4spn   s1, sp, 32
                  slti         gp, tp, -1791
                  slti         gp, tp, -1791
                  c.and        s0, a3
                  c.andi       a0, -1
                  slt          t4, s3, s11
                  divu         s10, sp, s1
                  or           a4, s7, s8
                  c.li         a0, 21
                  rem          s6, a2, t4
                  c.andi       a0, -1
                  srl          gp, a7, s6
                  c.or         a2, a5
                  mulhsu       a7, s0, t4
                  slt          t4, s3, s11
                  sll          s8, a6, a2
                  mulh         s11, s9, gp
                  c.sub        a3, s1
                  sll          s8, a6, a2
                  div          s0, t2, a0
                  auipc        a4, 881820
                  slt          t4, s3, s11
                  xori         a3, s3, -1008
                  auipc        a4, 881820
                  c.li         a0, 21
                  remu         s6, a4, s2
                  c.li         a0, 21
                  add          s6, s2, s10
                  sll          s8, a6, a2
                  addi         s8, s2, 596
                  li           a1, 0x0 #start riscv_int_numeric_corner_stream_20
                  li           s5, 0xffffffff
                  li           sp, 0x0
                  li           s9, 0x80000000
                  li           a2, 0x80000000
                  li           t6, 0x0
                  li           t0, 0x80000000
                  li           s11, 0x0
                  li           a7, 0xffffffff
                  li           a0, 0xd8515237
                  rem          a2, sp, s5
                  mul          a0, s5, s5
                  mul          a0, s5, s5
                  remu         a2, s11, a0
                  add          a2, a0, t0
                  mulhu        s5, a7, a1
                  add          a2, a0, t0
                  sub          s11, s9, a2
                  addi         a7, a0, 596
                  sub          s11, s9, a2
                  mulhu        s5, a7, a1
                  sub          s11, s9, a2
                  sub          s11, s9, a2
                  divu         s9, a0, t6
                  mulh         s11, t6, a1
                  add          a2, a0, t0
                  mulhsu       sp, s11, a0
                  addi         a7, a0, 596
                  mulhsu       sp, s11, a0
                  rem          a2, sp, s5
                  mulhsu       sp, s11, a0
                  rem          a2, sp, s5
                  auipc        s11, 881820
                  remu         a2, s11, a0
                  addi         a7, a0, 596
                  addi         a7, a0, 596
                  mul          a0, s5, s5 #end riscv_int_numeric_corner_stream_20
                  slli         s4, a5, 26
                  mul          a1, s6, s6
                  div          s0, t2, a0
                  mul          a1, s6, s6
                  c.addi16sp   sp, 400
                  add          s6, s2, s10
                  and          t5, t0, a7
                  c.li         a0, 21
                  nop
                  mulhsu       a7, s0, t4
                  mulhsu       a7, s0, t4
                  srl          gp, a7, s6
                  c.andi       a0, -1
                  sltiu        a1, s4, 1988
                  divu         s10, sp, s1
                  nop
                  add          s6, s2, s10
                  slli         s4, a5, 26
                  c.srai       a2, 4
                  mulh         s11, s9, gp
                  remu         s6, a4, s2
                  rem          s6, a2, t4
                  divu         s10, sp, s1
                  mulhsu       a7, s0, t4
                  c.sub        a3, s1
                  sra          s8, a5, s8
                  c.nop
                  c.addi16sp   sp, 400
                  c.sub        a3, s1
                  slt          t4, s3, s11
                  auipc        a4, 881820
                  c.nop
                  slt          t4, s3, s11
                  mulhu        t2, s5, t5
                  sltiu        a1, s4, 1988
                  c.addi4spn   s1, sp, 32
                  remu         s6, a4, s2
                  c.mv         s8, a5
                  divu         s10, sp, s1
                  slli         s4, a5, 26
                  sub          s11, t4, a3
                  c.mv         s8, a5
                  c.mv         s8, a5
                  slt          t4, s3, s11
                  c.addi       t4, 20
                  sll          s8, a6, a2
                  c.add        t2, s3
                  ori          s6, t3, 246
                  rem          s6, a2, t4
                  mulhsu       a7, s0, t4
                  srli         sp, s3, 10
                  sltu         s8, s9, s11
                  remu         s6, a4, s2
                  div          s0, t2, a0
                  div          s0, t2, a0
                  or           a4, s7, s8
                  c.addi4spn   s1, sp, 32
                  xori         a3, s3, -1008
                  c.li         a0, 21
                  auipc        a4, 881820
                  srai         t0, t0, 4
                  c.nop
                  xor          a4, s11, s7
                  sltu         s8, s9, s11
                  remu         s6, a4, s2
                  mul          a1, s6, s6
                  sra          s8, a5, s8
                  addi         s8, s2, 596
                  c.slli       s11, 17
                  slt          t4, s3, s11
                  c.and        s0, a3
                  c.slli       s11, 17
                  c.mv         s8, a5
                  andi         t0, s11, 1760
                  sub          s11, t4, a3
                  c.and        s0, a3
                  sub          s11, t4, a3
                  and          t5, t0, a7
                  c.mv         s8, a5
                  slti         gp, tp, -1791
                  andi         t0, s11, 1760
                  srli         sp, s3, 10
                  c.add        t2, s3
                  srl          gp, a7, s6
                  xori         a3, s3, -1008
                  mulh         s11, s9, gp
                  c.nop
                  srl          gp, a7, s6
                  rem          s6, a2, t4
                  ori          s6, t3, 246
                  remu         s6, a4, s2
                  remu         s6, a4, s2
                  remu         s6, a4, s2
                  c.addi16sp   sp, 400
                  srai         t0, t0, 4
                  ori          s6, t3, 246
                  or           a4, s7, s8
                  addi         s8, s2, 596
                  c.add        t2, s3
                  and          t5, t0, a7
                  or           a4, s7, s8
                  c.lui        s8, 31
                  c.srai       a2, 4
                  mulhsu       a7, s0, t4
                  c.add        t2, s3
                  add          s6, s2, s10
                  c.addi       t4, 20
                  mul          a1, s6, s6
                  sub          s11, t4, a3
                  c.slli       s11, 17
                  c.slli       s11, 17
                  c.add        t2, s3
                  divu         s10, sp, s1
                  c.srli       a0, 28
                  mulhu        t2, s5, t5
                  mul          a1, s6, s6
                  c.slli       s11, 17
                  add          s6, s2, s10
                  c.and        s0, a3
                  addi         s8, s2, 596
                  c.srai       a2, 4
                  slli         s4, a5, 26
                  c.or         a2, a5
                  li           s8, 0x0 #start riscv_int_numeric_corner_stream_21
                  li           s11, 0x80000000
                  li           s1, 0x749d3dd2
                  li           gp, 0xa08eef6a
                  li           a5, 0x17d13817
                  li           ra, 0x0
                  li           s2, 0x80000000
                  li           a1, 0xffffffff
                  li           a6, 0x80000000
                  li           s9, 0xffffffff
                  mul          s1, s2, s2
                  rem          a5, ra, s2
                  rem          a5, ra, s2
                  mul          s1, s2, s2
                  nop
                  mulhu        s2, a6, a1
                  addi         a6, s1, 596
                  sub          s9, s8, a5
                  mulhsu       ra, s9, s1
                  remu         a5, s9, s1
                  lui          s2, 776121
                  divu         s8, s1, s11
                  div          s8, s8, s9
                  div          s8, s8, s9
                  mulhu        s2, a6, a1
                  mulh         s9, s11, a1
                  auipc        s9, 881820
                  mulh         s9, s11, a1
                  auipc        s9, 881820
                  mul          s1, s2, s2
                  divu         s8, s1, s11
                  add          a5, s1, gp
                  addi         a6, s1, 596
                  add          a5, s1, gp #end riscv_int_numeric_corner_stream_21
                  c.addi       t4, 20
                  ori          s6, t3, 246
                  and          t5, t0, a7
                  c.srli       a0, 28
                  add          s6, s2, s10
                  c.li         a0, 21
                  srli         sp, s3, 10
                  or           a4, s7, s8
                  c.mv         s8, a5
                  c.or         a2, a5
                  srli         sp, s3, 10
                  srli         sp, s3, 10
                  c.sub        a3, s1
                  c.or         a2, a5
                  c.and        s0, a3
                  c.srli       a0, 28
                  add          s6, s2, s10
                  and          t5, t0, a7
                  c.nop
                  c.slli       s11, 17
                  nop
                  slti         gp, tp, -1791
                  sub          s11, t4, a3
                  c.xor        s0, a5
                  lui          t2, 776121
                  xori         a3, s3, -1008
                  c.li         a0, 21
                  srl          gp, a7, s6
                  c.sub        a3, s1
                  div          s0, t2, a0
                  c.slli       s11, 17
                  sll          s8, a6, a2
                  c.andi       a0, -1
                  sltu         s8, s9, s11
                  slt          t4, s3, s11
                  c.li         a0, 21
                  c.mv         s8, a5
                  xor          a4, s11, s7
                  c.addi4spn   s1, sp, 32
                  c.and        s0, a3
                  andi         t0, s11, 1760
                  addi         s8, s2, 596
                  sra          s8, a5, s8
                  rem          s6, a2, t4
                  or           a4, s7, s8
                  sra          s8, a5, s8
                  remu         s6, a4, s2
                  sra          s8, a5, s8
                  auipc        a4, 881820
                  mulh         s11, s9, gp
                  c.lui        s8, 31
                  c.srai       a2, 4
                  mulhsu       a7, s0, t4
                  add          s6, s2, s10
                  nop
                  sltiu        a1, s4, 1988
                  c.nop
                  c.andi       a0, -1
                  c.li         a0, 21
                  div          s0, t2, a0
                  srai         t0, t0, 4
                  div          s0, t2, a0
                  c.lui        s8, 31
                  or           a4, s7, s8
                  slti         gp, tp, -1791
                  c.addi16sp   sp, 400
                  mulh         s11, s9, gp
                  c.add        t2, s3
                  sll          s8, a6, a2
                  c.addi16sp   sp, 400
                  slt          t4, s3, s11
                  c.li         a0, 21
                  rem          s6, a2, t4
                  auipc        a4, 881820
                  c.addi4spn   s1, sp, 32
                  c.xor        s0, a5
                  c.srli       a0, 28
                  xor          a4, s11, s7
                  c.addi16sp   sp, 400
                  srl          gp, a7, s6
                  mulhsu       a7, s0, t4
                  mulh         s11, s9, gp
                  c.nop
                  sra          s8, a5, s8
                  and          t5, t0, a7
                  sra          s8, a5, s8
                  add          s6, s2, s10
                  xor          a4, s11, s7
                  add          s6, s2, s10
                  slli         s4, a5, 26
                  xori         a3, s3, -1008
                  c.andi       a0, -1
                  sub          s11, t4, a3
                  mul          a1, s6, s6
                  srli         sp, s3, 10
                  slli         s4, a5, 26
                  xor          a4, s11, s7
                  addi         s8, s2, 596
                  lui          t2, 776121
                  c.nop
                  sra          s8, a5, s8
                  remu         s6, a4, s2
                  c.nop
                  srl          gp, a7, s6
                  c.li         a0, 21
                  c.nop
                  c.li         a0, 21
                  xori         a3, s3, -1008
                  andi         t0, s11, 1760
                  remu         s6, a4, s2
                  c.srai       a2, 4
                  auipc        a4, 881820
                  c.srai       a2, 4
                  mulhsu       a7, s0, t4
                  nop
                  sll          s8, a6, a2
                  sub          s11, t4, a3
                  c.addi4spn   s1, sp, 32
                  xori         a3, s3, -1008
                  c.lui        s8, 31
                  mulhsu       a7, s0, t4
                  lui          t2, 776121
                  remu         s6, a4, s2
                  c.addi4spn   s1, sp, 32
                  sub          s11, t4, a3
                  c.sub        a3, s1
                  add          s6, s2, s10
                  add          s6, s2, s10
                  and          t5, t0, a7
                  c.addi4spn   s1, sp, 32
                  sltu         s8, s9, s11
                  slt          t4, s3, s11
                  div          s0, t2, a0
                  mul          a1, s6, s6
                  c.slli       s11, 17
                  c.addi16sp   sp, 400
                  srli         sp, s3, 10
                  divu         s10, sp, s1
                  slt          t4, s3, s11
                  mulh         s11, s9, gp
                  c.xor        s0, a5
                  c.mv         s8, a5
                  slti         gp, tp, -1791
                  sll          s8, a6, a2
                  slti         gp, tp, -1791
                  slli         s4, a5, 26
                  remu         s6, a4, s2
                  srl          gp, a7, s6
                  auipc        a4, 881820
                  remu         s6, a4, s2
                  lui          t2, 776121
                  c.srli       a0, 28
                  c.sub        a3, s1
                  mulhsu       a7, s0, t4
                  c.mv         s8, a5
                  c.srai       a2, 4
                  sltiu        a1, s4, 1988
                  srl          gp, a7, s6
                  srai         t0, t0, 4
                  c.add        t2, s3
                  add          s6, s2, s10
                  nop
                  c.sub        a3, s1
                  c.nop
                  addi         s8, s2, 596
                  c.addi16sp   sp, 400
                  rem          s6, a2, t4
                  lui          t2, 776121
                  c.slli       s11, 17
                  c.lui        s8, 31
                  c.andi       a0, -1
                  or           a4, s7, s8
                  sltiu        a1, s4, 1988
                  div          s0, t2, a0
                  slt          t4, s3, s11
                  c.slli       s11, 17
                  remu         s6, a4, s2
                  or           a4, s7, s8
                  c.add        t2, s3
                  c.nop
                  sub          s11, t4, a3
                  slti         gp, tp, -1791
                  sltiu        a1, s4, 1988
                  auipc        a4, 881820
                  or           a4, s7, s8
                  mulh         s11, s9, gp
                  andi         t0, s11, 1760
                  xori         a3, s3, -1008
                  c.addi       t4, 20
                  c.addi16sp   sp, 400
                  slt          t4, s3, s11
                  mulhu        t2, s5, t5
                  c.xor        s0, a5
                  andi         t0, s11, 1760
                  c.nop
                  auipc        a4, 881820
                  c.lui        s8, 31
                  c.addi4spn   s1, sp, 32
                  c.sub        a3, s1
                  srli         sp, s3, 10
                  nop
                  srai         t0, t0, 4
                  mul          a1, s6, s6
                  mul          a1, s6, s6
                  c.sub        a3, s1
                  auipc        a4, 881820
                  add          s6, s2, s10
                  c.addi4spn   s1, sp, 32
                  srl          gp, a7, s6
                  and          t5, t0, a7
                  c.xor        s0, a5
                  c.slli       s11, 17
                  ori          s6, t3, 246
                  c.addi4spn   s1, sp, 32
                  c.xor        s0, a5
                  sltu         s8, s9, s11
                  c.sub        a3, s1
                  c.srai       a2, 4
                  lui          t2, 776121
                  c.nop
                  mulh         s11, s9, gp
                  c.add        t2, s3
                  rem          s6, a2, t4
                  c.or         a2, a5
                  divu         s10, sp, s1
                  sltiu        a1, s4, 1988
                  mulh         s11, s9, gp
                  xor          a4, s11, s7
                  and          t5, t0, a7
                  add          s6, s2, s10
                  div          s0, t2, a0
                  c.addi       t4, 20
                  sra          s8, a5, s8
                  c.srli       a0, 28
                  mul          a1, s6, s6
                  mulhsu       a7, s0, t4
                  c.xor        s0, a5
                  c.add        t2, s3
                  and          t5, t0, a7
                  sra          s8, a5, s8
                  mulhsu       a7, s0, t4
                  mulh         s11, s9, gp
                  c.addi       t4, 20
                  c.mv         s8, a5
                  srai         t0, t0, 4
                  mulhu        t2, s5, t5
                  slli         s4, a5, 26
                  c.srli       a0, 28
                  c.or         a2, a5
                  add          s6, s2, s10
                  or           a4, s7, s8
                  nop
                  c.slli       s11, 17
                  ori          s6, t3, 246
                  nop
                  mulhsu       a7, s0, t4
                  xori         a3, s3, -1008
                  andi         t0, s11, 1760
                  auipc        a4, 881820
                  xori         a3, s3, -1008
                  addi         s8, s2, 596
                  xor          a4, s11, s7
                  c.nop
                  c.srli       a0, 28
                  add          s6, s2, s10
                  sltu         s8, s9, s11
                  srli         sp, s3, 10
                  auipc        a4, 881820
                  srl          gp, a7, s6
                  sra          s8, a5, s8
                  slt          t4, s3, s11
                  srli         sp, s3, 10
                  c.slli       s11, 17
                  slt          t4, s3, s11
                  srli         sp, s3, 10
                  srl          gp, a7, s6
                  divu         s10, sp, s1
                  mulhsu       a7, s0, t4
                  divu         s10, sp, s1
                  divu         s10, sp, s1
                  c.mv         s8, a5
                  c.xor        s0, a5
                  c.xor        s0, a5
                  auipc        a4, 881820
                  srli         sp, s3, 10
                  c.slli       s11, 17
                  mulh         s11, s9, gp
                  mulhu        t2, s5, t5
                  andi         t0, s11, 1760
                  c.addi4spn   s1, sp, 32
                  xori         a3, s3, -1008
                  remu         s6, a4, s2
                  andi         t0, s11, 1760
                  srl          gp, a7, s6
                  srli         sp, s3, 10
                  nop
                  mulhsu       a7, s0, t4
                  sra          s8, a5, s8
                  c.add        t2, s3
                  c.mv         s8, a5
                  sra          s8, a5, s8
                  addi         s8, s2, 596
                  lui          t2, 776121
                  auipc        a4, 881820
                  lui          t2, 776121
                  sra          s8, a5, s8
                  c.and        s0, a3
                  c.addi16sp   sp, 400
                  mulhsu       a7, s0, t4
                  and          t5, t0, a7
                  sltu         s8, s9, s11
                  sll          s8, a6, a2
                  srli         sp, s3, 10
                  sra          s8, a5, s8
                  divu         s10, sp, s1
                  c.srai       a2, 4
                  or           a4, s7, s8
                  c.mv         s8, a5
                  mul          a1, s6, s6
                  add          s6, s2, s10
                  c.addi4spn   s1, sp, 32
                  nop
                  c.lui        s8, 31
                  sltu         s8, s9, s11
                  slti         gp, tp, -1791
                  sltu         s8, s9, s11
                  c.add        t2, s3
                  remu         s6, a4, s2
                  mulhsu       a7, s0, t4
                  mulh         s11, s9, gp
                  c.add        t2, s3
                  c.nop
                  auipc        a4, 881820
                  sltu         s8, s9, s11
                  slti         gp, tp, -1791
                  xori         a3, s3, -1008
                  ori          s6, t3, 246
                  auipc        a4, 881820
                  c.sub        a3, s1
                  slli         s4, a5, 26
                  srai         t0, t0, 4
                  sll          s8, a6, a2
                  c.andi       a0, -1
                  c.or         a2, a5
                  sra          s8, a5, s8
                  rem          s6, a2, t4
                  c.addi4spn   s1, sp, 32
                  c.slli       s11, 17
                  c.add        t2, s3
                  c.addi4spn   s1, sp, 32
                  sra          s8, a5, s8
                  c.nop
                  div          s0, t2, a0
                  c.addi4spn   s1, sp, 32
                  c.and        s0, a3
                  andi         t0, s11, 1760
                  sra          s8, a5, s8
                  divu         s10, sp, s1
                  slt          t4, s3, s11
                  c.srai       a2, 4
                  c.sub        a3, s1
                  remu         s6, a4, s2
                  div          s0, t2, a0
                  sub          s11, t4, a3
                  slli         s4, a5, 26
                  mulh         s11, s9, gp
                  or           a4, s7, s8
                  divu         s10, sp, s1
                  slli         s4, a5, 26
                  mulhu        t2, s5, t5
                  sltiu        a1, s4, 1988
                  mulhu        t2, s5, t5
                  mulh         s11, s9, gp
                  c.srai       a2, 4
                  mulhsu       a7, s0, t4
                  c.addi4spn   s1, sp, 32
                  srl          gp, a7, s6
                  mulhu        t2, s5, t5
                  mulhu        t2, s5, t5
                  andi         t0, s11, 1760
                  c.add        t2, s3
                  mulhu        t2, s5, t5
                  slt          t4, s3, s11
                  xori         a3, s3, -1008
                  srl          gp, a7, s6
                  mulhu        t2, s5, t5
                  div          s0, t2, a0
                  sub          s11, t4, a3
                  sra          s8, a5, s8
                  c.andi       a0, -1
                  c.addi       t4, 20
                  div          s0, t2, a0
                  andi         t0, s11, 1760
                  divu         s10, sp, s1
                  c.addi       t4, 20
                  sub          s11, t4, a3
                  srli         sp, s3, 10
                  c.slli       s11, 17
                  srai         t0, t0, 4
                  andi         t0, s11, 1760
                  srli         sp, s3, 10
                  div          s0, t2, a0
                  andi         t0, s11, 1760
                  c.nop
                  slt          t4, s3, s11
                  srai         t0, t0, 4
                  c.sub        a3, s1
                  sltiu        a1, s4, 1988
                  c.andi       a0, -1
                  nop
                  slli         s4, a5, 26
                  c.sub        a3, s1
                  ori          s6, t3, 246
                  srai         t0, t0, 4
                  srai         t0, t0, 4
                  c.and        s0, a3
                  c.li         a0, 21
                  sll          s8, a6, a2
                  c.or         a2, a5
                  mul          a1, s6, s6
                  nop
                  srl          gp, a7, s6
                  sltu         s8, s9, s11
                  mulhu        t2, s5, t5
                  slti         gp, tp, -1791
                  sra          s8, a5, s8
                  c.or         a2, a5
                  c.nop
                  c.nop
                  c.addi16sp   sp, 400
                  c.sub        a3, s1
                  sra          s8, a5, s8
                  nop
                  c.li         a0, 21
                  auipc        a4, 881820
                  c.srli       a0, 28
                  c.srai       a2, 4
                  sltiu        a1, s4, 1988
                  xori         a3, s3, -1008
                  sub          s11, t4, a3
                  c.srai       a2, 4
                  lui          t2, 776121
                  c.xor        s0, a5
                  and          t5, t0, a7
                  sub          s11, t4, a3
                  c.or         a2, a5
                  c.srai       a2, 4
                  c.and        s0, a3
                  c.addi16sp   sp, 400
                  ori          s6, t3, 246
                  mulhu        t2, s5, t5
                  c.slli       s11, 17
                  c.li         a0, 21
                  c.mv         s8, a5
                  sll          s8, a6, a2
                  srai         t0, t0, 4
                  c.srli       a0, 28
                  c.nop
                  slt          t4, s3, s11
                  sltu         s8, s9, s11
                  mulh         s11, s9, gp
                  c.xor        s0, a5
                  c.xor        s0, a5
                  srli         sp, s3, 10
                  sltiu        a1, s4, 1988
                  sll          s8, a6, a2
                  mul          a1, s6, s6
                  sub          s11, t4, a3
                  c.li         a0, 21
                  div          s0, t2, a0
                  xori         a3, s3, -1008
                  c.andi       a0, -1
                  srai         t0, t0, 4
                  c.add        t2, s3
                  add          s6, s2, s10
                  srli         sp, s3, 10
                  remu         s6, a4, s2
                  c.addi16sp   sp, 400
                  or           a4, s7, s8
                  c.xor        s0, a5
                  nop
                  auipc        a4, 881820
                  slt          t4, s3, s11
                  lui          t2, 776121
                  sltu         s8, s9, s11
                  auipc        a4, 881820
                  c.addi4spn   s1, sp, 32
                  c.addi4spn   s1, sp, 32
                  c.slli       s11, 17
                  c.andi       a0, -1
                  srai         t0, t0, 4
                  div          s0, t2, a0
                  sub          s11, t4, a3
                  srl          gp, a7, s6
                  c.andi       a0, -1
                  c.or         a2, a5
                  srai         t0, t0, 4
                  divu         s10, sp, s1
                  auipc        a4, 881820
                  slli         s4, a5, 26
                  ori          s6, t3, 246
                  c.and        s0, a3
                  xor          a4, s11, s7
                  addi         s8, s2, 596
                  andi         t0, s11, 1760
                  sll          s8, a6, a2
                  srl          gp, a7, s6
                  c.slli       s11, 17
                  xori         a3, s3, -1008
                  c.addi       t4, 20
                  xor          a4, s11, s7
                  xori         a3, s3, -1008
                  add          s6, s2, s10
                  mulhsu       a7, s0, t4
                  srl          gp, a7, s6
                  c.srai       a2, 4
                  c.lui        s8, 31
                  slli         s4, a5, 26
                  divu         s10, sp, s1
                  c.mv         s8, a5
                  and          t5, t0, a7
                  c.or         a2, a5
                  lui          t2, 776121
                  c.nop
                  mulh         s11, s9, gp
                  c.xor        s0, a5
                  srli         sp, s3, 10
                  c.add        t2, s3
                  lui          t2, 776121
                  slt          t4, s3, s11
                  nop
                  mulhu        t2, s5, t5
                  sra          s8, a5, s8
                  div          s0, t2, a0
                  mulh         s11, s9, gp
                  c.nop
                  div          s0, t2, a0
                  divu         s10, sp, s1
                  slli         s4, a5, 26
                  sll          s8, a6, a2
                  srai         t0, t0, 4
                  c.andi       a0, -1
                  c.addi16sp   sp, 400
                  xor          a4, s11, s7
                  divu         s10, sp, s1
                  sltiu        a1, s4, 1988
                  c.sub        a3, s1
                  and          t5, t0, a7
                  sub          s11, t4, a3
                  andi         t0, s11, 1760
                  srl          gp, a7, s6
                  srai         t0, t0, 4
                  div          s0, t2, a0
                  lui          t2, 776121
                  c.andi       a0, -1
                  c.or         a2, a5
                  sltu         s8, s9, s11
                  c.addi16sp   sp, 400
                  c.addi16sp   sp, 400
                  rem          s6, a2, t4
                  divu         s10, sp, s1
                  c.add        t2, s3
                  sll          s8, a6, a2
                  c.srli       a0, 28
                  xori         a3, s3, -1008
                  c.srai       a2, 4
                  c.or         a2, a5
                  c.and        s0, a3
                  sltu         s8, s9, s11
                  slti         gp, tp, -1791
                  mulhsu       a7, s0, t4
                  and          t5, t0, a7
                  c.mv         s8, a5
                  srai         t0, t0, 4
                  sub          s11, t4, a3
                  nop
                  srl          gp, a7, s6
                  c.mv         s8, a5
                  srai         t0, t0, 4
                  nop
                  xor          a4, s11, s7
                  c.lui        s8, 31
                  addi         s8, s2, 596
                  ori          s6, t3, 246
                  c.srli       a0, 28
                  srli         sp, s3, 10
                  c.xor        s0, a5
                  srli         sp, s3, 10
                  slli         s4, a5, 26
                  c.addi       t4, 20
                  mulh         s11, s9, gp
                  slli         s4, a5, 26
                  srai         t0, t0, 4
                  slli         s4, a5, 26
                  slli         s4, a5, 26
                  c.sub        a3, s1
                  ori          s6, t3, 246
                  c.addi       t4, 20
                  sra          s8, a5, s8
                  c.sub        a3, s1
                  srl          gp, a7, s6
                  c.lui        s8, 31
                  c.addi       t4, 20
                  addi         s8, s2, 596
                  slt          t4, s3, s11
                  sra          s8, a5, s8
                  mulhu        t2, s5, t5
                  srai         t0, t0, 4
                  addi         s8, s2, 596
                  sub          s11, t4, a3
                  and          t5, t0, a7
                  c.lui        s8, 31
                  addi         s8, s2, 596
                  c.srli       a0, 28
                  xor          a4, s11, s7
                  add          s6, s2, s10
                  slti         gp, tp, -1791
                  c.sub        a3, s1
                  c.or         a2, a5
                  c.srli       a0, 28
                  divu         s10, sp, s1
                  c.mv         s8, a5
                  c.slli       s11, 17
                  srl          gp, a7, s6
                  divu         s10, sp, s1
                  mulh         s11, s9, gp
                  c.addi16sp   sp, 400
                  xori         a3, s3, -1008
                  addi         s8, s2, 596
                  sltu         s8, s9, s11
                  c.addi       t4, 20
                  c.mv         s8, a5
                  c.mv         s8, a5
                  c.mv         s8, a5
                  c.andi       a0, -1
                  c.nop
                  remu         s6, a4, s2
                  or           a4, s7, s8
                  addi         s8, s2, 596
                  c.mv         s8, a5
                  li           s8, 0x0 #start riscv_int_numeric_corner_stream_11
                  li           gp, 0x0
                  li           t6, 0x80000000
                  li           t3, 0x89381841
                  li           s0, 0x0
                  li           s9, 0x0
                  li           s6, 0x80000000
                  li           a1, 0xffffffff
                  li           s11, 0xe5ad3c0b
                  li           a6, 0x80000000
                  divu         s11, a1, t6
                  div          s11, s11, t3
                  lui          s9, 776121
                  mulhu        s9, s8, a6
                  add          s6, a1, s0
                  rem          s6, gp, s9
                  mulhsu       gp, t3, a1
                  remu         s6, t3, a1
                  nop
                  addi         s8, a1, 596
                  mulh         t3, t6, a6
                  mul          a1, s9, s9
                  mulhu        s9, s8, a6
                  rem          s6, gp, s9
                  mulhsu       gp, t3, a1
                  mulhu        s9, s8, a6
                  div          s11, s11, t3
                  auipc        t3, 881820
                  divu         s11, a1, t6
                  rem          s6, gp, s9
                  div          s11, s11, t3 #end riscv_int_numeric_corner_stream_11
                  slli         s4, a5, 26
                  ori          s6, t3, 246
                  andi         t0, s11, 1760
                  sll          s8, a6, a2
                  srai         t0, t0, 4
                  sltu         s8, s9, s11
                  c.andi       a0, -1
                  add          s6, s2, s10
                  or           a4, s7, s8
                  sltiu        a1, s4, 1988
                  srli         sp, s3, 10
                  sra          s8, a5, s8
                  c.or         a2, a5
                  rem          s6, a2, t4
                  xor          a4, s11, s7
                  c.addi16sp   sp, 400
                  sll          s8, a6, a2
                  c.andi       a0, -1
                  mulhsu       a7, s0, t4
                  sub          s11, t4, a3
                  lui          t2, 776121
                  c.addi4spn   s1, sp, 32
                  mul          a1, s6, s6
                  divu         s10, sp, s1
                  rem          s6, a2, t4
                  c.addi       t4, 20
                  c.srai       a2, 4
                  slt          t4, s3, s11
                  c.addi16sp   sp, 400
                  slli         s4, a5, 26
                  c.srli       a0, 28
                  sra          s8, a5, s8
                  c.and        s0, a3
                  slti         gp, tp, -1791
                  c.li         a0, 21
                  c.lui        s8, 31
                  c.and        s0, a3
                  c.slli       s11, 17
                  sra          s8, a5, s8
                  add          s6, s2, s10
                  nop
                  c.srli       a0, 28
                  rem          s6, a2, t4
                  andi         t0, s11, 1760
                  c.addi4spn   s1, sp, 32
                  c.srai       a2, 4
                  c.andi       a0, -1
                  slti         gp, tp, -1791
                  c.li         a0, 21
                  and          t5, t0, a7
                  mulhu        t2, s5, t5
                  c.and        s0, a3
                  mulhu        t2, s5, t5
                  c.addi4spn   s1, sp, 32
                  divu         s10, sp, s1
                  c.slli       s11, 17
                  c.srli       a0, 28
                  xor          a4, s11, s7
                  and          t5, t0, a7
                  slti         gp, tp, -1791
                  c.addi       t4, 20
                  c.or         a2, a5
                  xor          a4, s11, s7
                  lui          t2, 776121
                  div          s0, t2, a0
                  c.slli       s11, 17
                  c.srai       a2, 4
                  div          s0, t2, a0
                  slti         gp, tp, -1791
                  or           a4, s7, s8
                  lui          t2, 776121
                  c.or         a2, a5
                  c.mv         s8, a5
                  c.xor        s0, a5
                  srli         sp, s3, 10
                  c.addi4spn   s1, sp, 32
                  andi         t0, s11, 1760
                  slli         s4, a5, 26
                  c.lui        s8, 31
                  c.and        s0, a3
                  slli         s4, a5, 26
                  auipc        a4, 881820
                  ori          s6, t3, 246
                  ori          s6, t3, 246
                  c.addi4spn   s1, sp, 32
                  mulhsu       a7, s0, t4
                  c.andi       a0, -1
                  srli         sp, s3, 10
                  add          s6, s2, s10
                  sll          s8, a6, a2
                  c.nop
                  lui          t2, 776121
                  c.lui        s8, 31
                  srl          gp, a7, s6
                  c.lui        s8, 31
                  div          s0, t2, a0
                  c.srli       a0, 28
                  slt          t4, s3, s11
                  c.mv         s8, a5
                  c.slli       s11, 17
                  or           a4, s7, s8
                  lui          t2, 776121
                  sll          s8, a6, a2
                  mulhu        t2, s5, t5
                  c.xor        s0, a5
                  or           a4, s7, s8
                  c.or         a2, a5
                  c.addi4spn   s1, sp, 32
                  lui          t2, 776121
                  ori          s6, t3, 246
                  c.srli       a0, 28
                  nop
                  nop
                  ori          s6, t3, 246
                  ori          s6, t3, 246
                  mulhsu       a7, s0, t4
                  sra          s8, a5, s8
                  ori          s6, t3, 246
                  c.or         a2, a5
                  c.mv         s8, a5
                  srai         t0, t0, 4
                  mulhsu       a7, s0, t4
                  xor          a4, s11, s7
                  c.and        s0, a3
                  and          t5, t0, a7
                  sll          s8, a6, a2
                  c.li         a0, 21
                  c.add        t2, s3
                  ori          s6, t3, 246
                  slt          t4, s3, s11
                  and          t5, t0, a7
                  c.addi16sp   sp, 400
                  divu         s10, sp, s1
                  mulhu        t2, s5, t5
                  srli         sp, s3, 10
                  or           a4, s7, s8
                  c.and        s0, a3
                  c.mv         s8, a5
                  c.addi16sp   sp, 400
                  addi         s8, s2, 596
                  ori          s6, t3, 246
                  sll          s8, a6, a2
                  sll          s8, a6, a2
                  srl          gp, a7, s6
                  c.li         a0, 21
                  srl          gp, a7, s6
                  c.or         a2, a5
                  c.srai       a2, 4
                  c.add        t2, s3
                  c.li         a0, 21
                  c.srli       a0, 28
                  or           a4, s7, s8
                  c.addi4spn   s1, sp, 32
                  c.srai       a2, 4
                  slti         gp, tp, -1791
                  sub          s11, t4, a3
                  mul          a1, s6, s6
                  nop
                  addi         s8, s2, 596
                  c.sub        a3, s1
                  c.slli       s11, 17
                  c.slli       s11, 17
                  c.addi16sp   sp, 400
                  ori          s6, t3, 246
                  mulhsu       a7, s0, t4
                  lui          t2, 776121
                  c.srli       a0, 28
                  c.addi       t4, 20
                  divu         s10, sp, s1
                  and          t5, t0, a7
                  addi         s8, s2, 596
                  sra          s8, a5, s8
                  c.or         a2, a5
                  c.sub        a3, s1
                  auipc        a4, 881820
                  addi         s8, s2, 596
                  sra          s8, a5, s8
                  mulh         s11, s9, gp
                  c.addi4spn   s1, sp, 32
                  addi         s8, s2, 596
                  sll          s8, a6, a2
                  sltiu        a1, s4, 1988
                  c.and        s0, a3
                  c.or         a2, a5
                  remu         s6, a4, s2
                  srli         sp, s3, 10
                  addi         s8, s2, 596
                  c.and        s0, a3
                  mulhu        t2, s5, t5
                  lui          t2, 776121
                  lui          t2, 776121
                  mulh         s11, s9, gp
                  c.slli       s11, 17
                  c.andi       a0, -1
                  add          s6, s2, s10
                  lui          t2, 776121
                  srai         t0, t0, 4
                  add          s6, s2, s10
                  c.or         a2, a5
                  sub          s11, t4, a3
                  srl          gp, a7, s6
                  or           a4, s7, s8
                  c.lui        s8, 31
                  c.li         a0, 21
                  lui          t2, 776121
                  c.xor        s0, a5
                  c.xor        s0, a5
                  c.slli       s11, 17
                  slt          t4, s3, s11
                  c.or         a2, a5
                  rem          s6, a2, t4
                  c.addi       t4, 20
                  c.add        t2, s3
                  sub          s11, t4, a3
                  srl          gp, a7, s6
                  slt          t4, s3, s11
                  sltu         s8, s9, s11
                  c.and        s0, a3
                  ori          s6, t3, 246
                  c.lui        s8, 31
                  c.addi       t4, 20
                  mulhsu       a7, s0, t4
                  lui          t2, 776121
                  c.li         a0, 21
                  c.addi4spn   s1, sp, 32
                  c.srai       a2, 4
                  mulhu        t2, s5, t5
                  c.addi       t4, 20
                  sub          s11, t4, a3
                  sltu         s8, s9, s11
                  sub          s11, t4, a3
                  c.xor        s0, a5
                  c.srli       a0, 28
                  c.lui        s8, 31
                  c.addi       t4, 20
                  sltu         s8, s9, s11
                  mulhsu       a7, s0, t4
                  auipc        a4, 881820
                  sltiu        a1, s4, 1988
                  c.add        t2, s3
                  c.mv         s8, a5
                  mulhu        t2, s5, t5
                  c.andi       a0, -1
                  xor          a4, s11, s7
                  c.and        s0, a3
                  c.nop
                  mul          a1, s6, s6
                  nop
                  ori          s6, t3, 246
                  nop
                  c.or         a2, a5
                  and          t5, t0, a7
                  xori         a3, s3, -1008
                  c.add        t2, s3
                  c.and        s0, a3
                  xori         a3, s3, -1008
                  slli         s4, a5, 26
                  mulh         s11, s9, gp
                  auipc        a4, 881820
                  xor          a4, s11, s7
                  add          s6, s2, s10
                  mul          a1, s6, s6
                  c.lui        s8, 31
                  c.add        t2, s3
                  c.mv         s8, a5
                  add          s6, s2, s10
                  c.nop
                  c.nop
                  sltiu        a1, s4, 1988
                  srl          gp, a7, s6
                  c.sub        a3, s1
                  auipc        a4, 881820
                  c.or         a2, a5
                  c.sub        a3, s1
                  slt          t4, s3, s11
                  c.add        t2, s3
                  div          s0, t2, a0
                  sltu         s8, s9, s11
                  slli         s4, a5, 26
                  div          s0, t2, a0
                  mulhu        t2, s5, t5
                  c.and        s0, a3
                  mulh         s11, s9, gp
                  rem          s6, a2, t4
                  mulhsu       a7, s0, t4
                  c.sub        a3, s1
                  c.slli       s11, 17
                  ori          s6, t3, 246
                  nop
                  c.andi       a0, -1
                  xori         a3, s3, -1008
                  andi         t0, s11, 1760
                  c.mv         s8, a5
                  c.slli       s11, 17
                  c.srli       a0, 28
                  c.srli       a0, 28
                  mulh         s11, s9, gp
                  c.addi       t4, 20
                  c.li         a0, 21
                  or           a4, s7, s8
                  c.mv         s8, a5
                  srl          gp, a7, s6
                  c.or         a2, a5
                  sltiu        a1, s4, 1988
                  divu         s10, sp, s1
                  ori          s6, t3, 246
                  c.add        t2, s3
                  div          s0, t2, a0
                  c.srai       a2, 4
                  ori          s6, t3, 246
                  sltiu        a1, s4, 1988
                  xori         a3, s3, -1008
                  lui          t2, 776121
                  c.addi16sp   sp, 400
                  ori          s6, t3, 246
                  addi         s8, s2, 596
                  c.lui        s8, 31
                  nop
                  srai         t0, t0, 4
                  sll          s8, a6, a2
                  c.sub        a3, s1
                  sub          s11, t4, a3
                  c.or         a2, a5
                  nop
                  srl          gp, a7, s6
                  mul          a1, s6, s6
                  sltu         s8, s9, s11
                  sltiu        a1, s4, 1988
                  add          s6, s2, s10
                  mulh         s11, s9, gp
                  c.and        s0, a3
                  xor          a4, s11, s7
                  rem          s6, a2, t4
                  lui          t2, 776121
                  divu         s10, sp, s1
                  andi         t0, s11, 1760
                  c.li         a0, 21
                  srli         sp, s3, 10
                  or           a4, s7, s8
                  mul          a1, s6, s6
                  auipc        a4, 881820
                  add          s6, s2, s10
                  rem          s6, a2, t4
                  add          s6, s2, s10
                  slti         gp, tp, -1791
                  divu         s10, sp, s1
                  lui          t2, 776121
                  li           a3, 0x80000000 #start riscv_int_numeric_corner_stream_31
                  li           a5, 0xffffffff
                  li           s0, 0xffffffff
                  li           a4, 0x0
                  li           t0, 0x80000000
                  li           s8, 0x0
                  li           a0, 0x80000000
                  li           s9, 0x80000000
                  li           s4, 0x0
                  li           s10, 0x86452c31
                  nop
                  mulhsu       t0, s9, a0
                  sub          s9, s8, a4
                  mulhsu       t0, s9, a0
                  nop
                  div          s8, s8, s9
                  divu         s8, a0, s10
                  mulh         s9, s10, a3
                  rem          a4, t0, s4
                  auipc        s9, 881820
                  mulhu        s4, a5, a3
                  sub          s9, s8, a4
                  lui          s4, 776121
                  remu         a4, s9, a0
                  lui          s4, 776121
                  sub          s9, s8, a4
                  addi         a5, a0, 596
                  remu         a4, s9, a0
                  nop
                  remu         a4, s9, a0
                  rem          a4, t0, s4
                  remu         a4, s9, a0 #end riscv_int_numeric_corner_stream_31
                  c.or         a2, a5
                  lui          t2, 776121
                  c.slli       s11, 17
                  c.and        s0, a3
                  andi         t0, s11, 1760
                  c.xor        s0, a5
                  c.slli       s11, 17
                  nop
                  remu         s6, a4, s2
                  c.andi       a0, -1
                  mulh         s11, s9, gp
                  andi         t0, s11, 1760
                  addi         s8, s2, 596
                  mulh         s11, s9, gp
                  mulhu        t2, s5, t5
                  c.xor        s0, a5
                  slti         gp, tp, -1791
                  remu         s6, a4, s2
                  remu         s6, a4, s2
                  xori         a3, s3, -1008
                  c.add        t2, s3
                  xor          a4, s11, s7
                  c.mv         s8, a5
                  xori         a3, s3, -1008
                  srai         t0, t0, 4
                  c.nop
                  andi         t0, s11, 1760
                  auipc        a4, 881820
                  mulhsu       a7, s0, t4
                  slt          t4, s3, s11
                  srli         sp, s3, 10
                  srl          gp, a7, s6
                  divu         s10, sp, s1
                  mulhsu       a7, s0, t4
                  c.addi16sp   sp, 400
                  c.lui        s8, 31
                  mulhu        t2, s5, t5
                  andi         t0, s11, 1760
                  c.andi       a0, -1
                  auipc        a4, 881820
                  sra          s8, a5, s8
                  c.slli       s11, 17
                  divu         s10, sp, s1
                  c.lui        s8, 31
                  lui          t2, 776121
                  c.addi16sp   sp, 400
                  c.xor        s0, a5
                  sub          s11, t4, a3
                  srli         sp, s3, 10
                  c.add        t2, s3
                  add          s6, s2, s10
                  nop
                  sltiu        a1, s4, 1988
                  sra          s8, a5, s8
                  sltu         s8, s9, s11
                  c.li         a0, 21
                  or           a4, s7, s8
                  slli         s4, a5, 26
                  nop
                  c.xor        s0, a5
                  andi         t0, s11, 1760
                  xor          a4, s11, s7
                  srli         sp, s3, 10
                  srai         t0, t0, 4
                  c.addi4spn   s1, sp, 32
                  sub          s11, t4, a3
                  c.and        s0, a3
                  sra          s8, a5, s8
                  c.srai       a2, 4
                  c.xor        s0, a5
                  c.mv         s8, a5
                  c.addi16sp   sp, 400
                  xor          a4, s11, s7
                  c.addi16sp   sp, 400
                  c.addi       t4, 20
                  xor          a4, s11, s7
                  mul          a1, s6, s6
                  sltu         s8, s9, s11
                  nop
                  c.andi       a0, -1
                  c.or         a2, a5
                  slt          t4, s3, s11
                  sltiu        a1, s4, 1988
                  sltiu        a1, s4, 1988
                  srl          gp, a7, s6
                  c.addi16sp   sp, 400
                  c.lui        s8, 31
                  rem          s6, a2, t4
                  c.srli       a0, 28
                  xori         a3, s3, -1008
                  mulhsu       a7, s0, t4
                  xor          a4, s11, s7
                  mulh         s11, s9, gp
                  auipc        a4, 881820
                  andi         t0, s11, 1760
                  auipc        a4, 881820
                  div          s0, t2, a0
                  sra          s8, a5, s8
                  srli         sp, s3, 10
                  c.and        s0, a3
                  c.sub        a3, s1
                  slti         gp, tp, -1791
                  c.lui        s8, 31
                  c.xor        s0, a5
                  or           a4, s7, s8
                  slli         s4, a5, 26
                  sra          s8, a5, s8
                  c.add        t2, s3
                  c.or         a2, a5
                  remu         s6, a4, s2
                  c.mv         s8, a5
                  div          s0, t2, a0
                  andi         t0, s11, 1760
                  srli         sp, s3, 10
                  div          s0, t2, a0
                  mulhu        t2, s5, t5
                  or           a4, s7, s8
                  c.addi       t4, 20
                  slti         gp, tp, -1791
                  c.slli       s11, 17
                  c.li         a0, 21
                  mulh         s11, s9, gp
                  c.slli       s11, 17
                  add          s6, s2, s10
                  c.xor        s0, a5
                  sltu         s8, s9, s11
                  c.xor        s0, a5
                  slti         gp, tp, -1791
                  srl          gp, a7, s6
                  mulhu        t2, s5, t5
                  c.or         a2, a5
                  sltu         s8, s9, s11
                  sra          s8, a5, s8
                  c.and        s0, a3
                  slt          t4, s3, s11
                  mul          a1, s6, s6
                  div          s0, t2, a0
                  c.slli       s11, 17
                  nop
                  addi         s8, s2, 596
                  nop
                  sll          s8, a6, a2
                  ori          s6, t3, 246
                  c.addi       t4, 20
                  divu         s10, sp, s1
                  xor          a4, s11, s7
                  sll          s8, a6, a2
                  xor          a4, s11, s7
                  div          s0, t2, a0
                  sub          s11, t4, a3
                  mulh         s11, s9, gp
                  c.slli       s11, 17
                  mulhsu       a7, s0, t4
                  c.slli       s11, 17
                  mulhsu       a7, s0, t4
                  c.addi       t4, 20
                  slti         gp, tp, -1791
                  c.or         a2, a5
                  c.sub        a3, s1
                  slli         s4, a5, 26
                  addi         s8, s2, 596
                  xor          a4, s11, s7
                  mulhsu       a7, s0, t4
                  nop
                  add          s6, s2, s10
                  lui          t2, 776121
                  c.addi       t4, 20
                  srl          gp, a7, s6
                  sltu         s8, s9, s11
                  c.addi16sp   sp, 400
                  rem          s6, a2, t4
                  or           a4, s7, s8
                  c.mv         s8, a5
                  srl          gp, a7, s6
                  remu         s6, a4, s2
                  add          s6, s2, s10
                  srai         t0, t0, 4
                  c.lui        s8, 31
                  c.addi       t4, 20
                  mulhu        t2, s5, t5
                  sltiu        a1, s4, 1988
                  c.li         a0, 21
                  mul          a1, s6, s6
                  auipc        a4, 881820
                  addi         s8, s2, 596
                  c.slli       s11, 17
                  c.andi       a0, -1
                  sltiu        a1, s4, 1988
                  ori          s6, t3, 246
                  srai         t0, t0, 4
                  c.addi16sp   sp, 400
                  ori          s6, t3, 246
                  mulhsu       a7, s0, t4
                  mulhsu       a7, s0, t4
                  c.andi       a0, -1
                  sltiu        a1, s4, 1988
                  srai         t0, t0, 4
                  c.slli       s11, 17
                  c.or         a2, a5
                  c.lui        s8, 31
                  c.add        t2, s3
                  div          s0, t2, a0
                  xor          a4, s11, s7
                  c.addi4spn   s1, sp, 32
                  c.srli       a0, 28
                  sltu         s8, s9, s11
                  c.lui        s8, 31
                  rem          s6, a2, t4
                  divu         s10, sp, s1
                  add          s6, s2, s10
                  ori          s6, t3, 246
                  c.or         a2, a5
                  and          t5, t0, a7
                  mulh         s11, s9, gp
                  srl          gp, a7, s6
                  andi         t0, s11, 1760
                  and          t5, t0, a7
                  mulh         s11, s9, gp
                  srl          gp, a7, s6
                  addi         s8, s2, 596
                  xori         a3, s3, -1008
                  xor          a4, s11, s7
                  remu         s6, a4, s2
                  slt          t4, s3, s11
                  srl          gp, a7, s6
                  c.lui        s8, 31
                  rem          s6, a2, t4
                  and          t5, t0, a7
                  sltu         s8, s9, s11
                  srli         sp, s3, 10
                  c.mv         s8, a5
                  slt          t4, s3, s11
                  sltiu        a1, s4, 1988
                  c.mv         s8, a5
                  sltiu        a1, s4, 1988
                  slti         gp, tp, -1791
                  c.addi4spn   s1, sp, 32
                  ori          s6, t3, 246
                  sub          s11, t4, a3
                  c.sub        a3, s1
                  c.addi16sp   sp, 400
                  srl          gp, a7, s6
                  c.addi4spn   s1, sp, 32
                  andi         t0, s11, 1760
                  addi         s8, s2, 596
                  sltiu        a1, s4, 1988
                  slt          t4, s3, s11
                  c.mv         s8, a5
                  andi         t0, s11, 1760
                  slli         s4, a5, 26
                  c.or         a2, a5
                  c.srli       a0, 28
                  c.and        s0, a3
                  sltu         s8, s9, s11
                  xor          a4, s11, s7
                  c.or         a2, a5
                  c.srli       a0, 28
                  andi         t0, s11, 1760
                  add          s6, s2, s10
                  sltiu        a1, s4, 1988
                  ori          s6, t3, 246
                  c.addi16sp   sp, 400
                  c.or         a2, a5
                  ori          s6, t3, 246
                  and          t5, t0, a7
                  c.or         a2, a5
                  srli         sp, s3, 10
                  sra          s8, a5, s8
                  c.srai       a2, 4
                  remu         s6, a4, s2
                  lui          t2, 776121
                  srl          gp, a7, s6
                  andi         t0, s11, 1760
                  srai         t0, t0, 4
                  rem          s6, a2, t4
                  c.nop
                  slli         s4, a5, 26
                  add          s6, s2, s10
                  nop
                  c.srli       a0, 28
                  c.add        t2, s3
                  andi         t0, s11, 1760
                  divu         s10, sp, s1
                  c.addi       t4, 20
                  c.or         a2, a5
                  and          t5, t0, a7
                  c.li         a0, 21
                  sltu         s8, s9, s11
                  ori          s6, t3, 246
                  c.addi4spn   s1, sp, 32
                  c.andi       a0, -1
                  and          t5, t0, a7
                  c.or         a2, a5
                  sra          s8, a5, s8
                  srai         t0, t0, 4
                  lui          t2, 776121
                  xori         a3, s3, -1008
                  add          s6, s2, s10
                  slti         gp, tp, -1791
                  srl          gp, a7, s6
                  div          s0, t2, a0
                  sub          s11, t4, a3
                  div          s0, t2, a0
                  sub          s11, t4, a3
                  or           a4, s7, s8
                  addi         s8, s2, 596
                  c.or         a2, a5
                  divu         s10, sp, s1
                  slti         gp, tp, -1791
                  c.lui        s8, 31
                  ori          s6, t3, 246
                  xor          a4, s11, s7
                  slt          t4, s3, s11
                  c.addi4spn   s1, sp, 32
                  divu         s10, sp, s1
                  sltiu        a1, s4, 1988
                  ori          s6, t3, 246
                  nop
                  slli         s4, a5, 26
                  c.nop
                  ori          s6, t3, 246
                  or           a4, s7, s8
                  div          s0, t2, a0
                  addi         s8, s2, 596
                  c.addi       t4, 20
                  xor          a4, s11, s7
                  sltu         s8, s9, s11
                  slt          t4, s3, s11
                  c.li         a0, 21
                  slti         gp, tp, -1791
                  c.lui        s8, 31
                  xori         a3, s3, -1008
                  c.add        t2, s3
                  c.srli       a0, 28
                  c.lui        s8, 31
                  sll          s8, a6, a2
                  xori         a3, s3, -1008
                  lui          t2, 776121
                  or           a4, s7, s8
                  slli         s4, a5, 26
                  slli         s4, a5, 26
                  srai         t0, t0, 4
                  mul          a1, s6, s6
                  divu         s10, sp, s1
                  mulhsu       a7, s0, t4
                  andi         t0, s11, 1760
                  remu         s6, a4, s2
                  c.srli       a0, 28
                  sltu         s8, s9, s11
                  div          s0, t2, a0
                  rem          s6, a2, t4
                  xori         a3, s3, -1008
                  srli         sp, s3, 10
                  sltiu        a1, s4, 1988
                  divu         s10, sp, s1
                  remu         s6, a4, s2
                  andi         t0, s11, 1760
                  srli         sp, s3, 10
                  c.mv         s8, a5
                  add          s6, s2, s10
                  c.add        t2, s3
                  c.and        s0, a3
                  c.add        t2, s3
                  addi         s8, s2, 596
                  c.and        s0, a3
                  nop
                  sub          s11, t4, a3
                  mul          a1, s6, s6
                  mulhu        t2, s5, t5
                  and          t5, t0, a7
                  c.li         a0, 21
                  xori         a3, s3, -1008
                  srli         sp, s3, 10
                  sub          s11, t4, a3
                  mulhsu       a7, s0, t4
                  addi         s8, s2, 596
                  sltiu        a1, s4, 1988
                  slli         s4, a5, 26
                  c.nop
                  c.mv         s8, a5
                  rem          s6, a2, t4
                  c.nop
                  mulhsu       a7, s0, t4
                  c.slli       s11, 17
                  c.mv         s8, a5
                  c.andi       a0, -1
                  srai         t0, t0, 4
                  c.add        t2, s3
                  c.andi       a0, -1
                  mulhu        t2, s5, t5
                  c.slli       s11, 17
                  and          t5, t0, a7
                  or           a4, s7, s8
                  c.addi16sp   sp, 400
                  mulh         s11, s9, gp
                  xor          a4, s11, s7
                  ori          s6, t3, 246
                  c.li         a0, 21
                  c.addi4spn   s1, sp, 32
                  c.add        t2, s3
                  c.mv         s8, a5
                  ori          s6, t3, 246
                  c.addi       t4, 20
                  srai         t0, t0, 4
                  c.addi16sp   sp, 400
                  mulh         s11, s9, gp
                  c.sub        a3, s1
                  c.xor        s0, a5
                  c.addi4spn   s1, sp, 32
                  slli         s4, a5, 26
                  nop
                  xori         a3, s3, -1008
                  and          t5, t0, a7
                  sub          s11, t4, a3
                  lui          t2, 776121
                  rem          s6, a2, t4
                  divu         s10, sp, s1
                  srl          gp, a7, s6
                  sltiu        a1, s4, 1988
                  c.add        t2, s3
                  addi         s8, s2, 596
                  add          s6, s2, s10
                  srai         t0, t0, 4
                  c.add        t2, s3
                  auipc        a4, 881820
                  srai         t0, t0, 4
                  c.sub        a3, s1
                  c.and        s0, a3
                  c.addi4spn   s1, sp, 32
                  srli         sp, s3, 10
                  c.sub        a3, s1
                  c.srai       a2, 4
                  sra          s8, a5, s8
                  mul          a1, s6, s6
                  srl          gp, a7, s6
                  c.mv         s8, a5
                  c.sub        a3, s1
                  slti         gp, tp, -1791
                  sltu         s8, s9, s11
                  sra          s8, a5, s8
                  remu         s6, a4, s2
                  c.addi4spn   s1, sp, 32
                  xori         a3, s3, -1008
                  or           a4, s7, s8
                  slli         s4, a5, 26
                  sltiu        a1, s4, 1988
                  rem          s6, a2, t4
                  lui          t2, 776121
                  and          t5, t0, a7
                  xor          a4, s11, s7
                  c.nop
                  c.lui        s8, 31
                  slli         s4, a5, 26
                  c.and        s0, a3
                  mulhu        t2, s5, t5
                  add          s6, s2, s10
                  c.srli       a0, 28
                  remu         s6, a4, s2
                  c.lui        s8, 31
                  sll          s8, a6, a2
                  srli         sp, s3, 10
                  div          s0, t2, a0
                  c.addi       t4, 20
                  c.sub        a3, s1
                  mul          a1, s6, s6
                  sltu         s8, s9, s11
                  lui          t2, 776121
                  c.xor        s0, a5
                  c.slli       s11, 17
                  andi         t0, s11, 1760
                  mulhsu       a7, s0, t4
                  xor          a4, s11, s7
                  sltu         s8, s9, s11
                  xori         a3, s3, -1008
                  srl          gp, a7, s6
                  slli         s4, a5, 26
                  sll          s8, a6, a2
                  lui          t2, 776121
                  c.slli       s11, 17
                  mulhsu       a7, s0, t4
                  ori          s6, t3, 246
                  c.xor        s0, a5
                  srli         sp, s3, 10
                  sltu         s8, s9, s11
                  c.addi4spn   s1, sp, 32
                  c.srli       a0, 28
                  sltu         s8, s9, s11
                  sltu         s8, s9, s11
                  remu         s6, a4, s2
                  mulhu        t2, s5, t5
                  xor          a4, s11, s7
                  c.li         a0, 21
                  divu         s10, sp, s1
                  c.andi       a0, -1
                  c.andi       a0, -1
                  c.srai       a2, 4
                  addi         s8, s2, 596
                  srl          gp, a7, s6
                  sltiu        a1, s4, 1988
                  addi         s8, s2, 596
                  srai         t0, t0, 4
                  srl          gp, a7, s6
                  c.lui        s8, 31
                  remu         s6, a4, s2
                  c.addi4spn   s1, sp, 32
                  c.addi16sp   sp, 400
                  addi         s8, s2, 596
                  slli         s4, a5, 26
                  and          t5, t0, a7
                  slli         s4, a5, 26
                  lui          t2, 776121
                  c.mv         s8, a5
                  c.srai       a2, 4
                  sra          s8, a5, s8
                  c.nop
                  andi         t0, s11, 1760
                  sub          s11, t4, a3
                  andi         t0, s11, 1760
                  li           s4, 0x0 #start riscv_int_numeric_corner_stream_18
                  li           a5, 0x0
                  li           s9, 0x859baa47
                  li           a3, 0x7d3eec8a
                  li           s1, 0x0
                  li           s0, 0x80000000
                  li           a0, 0x80000000
                  li           gp, 0xffffffff
                  li           t5, 0x0
                  li           t2, 0x80000000
                  lui          a5, 776121
                  nop
                  mulhu        a5, a3, s1
                  auipc        s9, 881820
                  rem          a0, gp, a5
                  nop
                  nop
                  mul          s0, a5, a5
                  div          s4, s4, s9
                  addi         a3, s0, 596
                  sub          s9, s4, a0
                  div          s4, s4, s9
                  rem          a0, gp, a5
                  auipc        s9, 881820
                  sub          s9, s4, a0
                  remu         a0, s9, s0
                  nop
                  divu         s4, s0, t5
                  mul          s0, a5, a5
                  sub          s9, s4, a0
                  mulh         s9, t5, s1
                  sub          s9, s4, a0
                  mulhsu       gp, s9, s0
                  auipc        s9, 881820
                  divu         s4, s0, t5
                  addi         a3, s0, 596
                  addi         a3, s0, 596
                  remu         a0, s9, s0
                  mulh         s9, t5, s1
                  add          a0, s0, t2 #end riscv_int_numeric_corner_stream_18
                  divu         s10, sp, s1
                  rem          s6, a2, t4
                  c.xor        s0, a5
                  xor          a4, s11, s7
                  sltiu        a1, s4, 1988
                  c.addi4spn   s1, sp, 32
                  c.xor        s0, a5
                  mulh         s11, s9, gp
                  c.addi4spn   s1, sp, 32
                  xor          a4, s11, s7
                  c.addi4spn   s1, sp, 32
                  mulhu        t2, s5, t5
                  c.lui        s8, 31
                  sltiu        a1, s4, 1988
                  srli         sp, s3, 10
                  c.addi       t4, 20
                  c.nop
                  c.mv         s8, a5
                  sltu         s8, s9, s11
                  c.andi       a0, -1
                  c.xor        s0, a5
                  nop
                  divu         s10, sp, s1
                  c.or         a2, a5
                  c.mv         s8, a5
                  srli         sp, s3, 10
                  c.srai       a2, 4
                  c.slli       s11, 17
                  c.sub        a3, s1
                  c.srli       a0, 28
                  c.nop
                  slli         s4, a5, 26
                  mulhsu       a7, s0, t4
                  mulhsu       a7, s0, t4
                  slti         gp, tp, -1791
                  auipc        a4, 881820
                  c.sub        a3, s1
                  c.mv         s8, a5
                  xori         a3, s3, -1008
                  and          t5, t0, a7
                  c.lui        s8, 31
                  c.nop
                  sll          s8, a6, a2
                  divu         s10, sp, s1
                  c.lui        s8, 31
                  addi         s8, s2, 596
                  sll          s8, a6, a2
                  sub          s11, t4, a3
                  sltu         s8, s9, s11
                  c.and        s0, a3
                  sub          s11, t4, a3
                  sltiu        a1, s4, 1988
                  and          t5, t0, a7
                  xori         a3, s3, -1008
                  or           a4, s7, s8
                  c.nop
                  c.nop
                  c.lui        s8, 31
                  mulhsu       a7, s0, t4
                  or           a4, s7, s8
                  c.add        t2, s3
                  auipc        a4, 881820
                  srai         t0, t0, 4
                  mulhsu       a7, s0, t4
                  mulhsu       a7, s0, t4
                  c.srai       a2, 4
                  c.srli       a0, 28
                  ori          s6, t3, 246
                  c.mv         s8, a5
                  or           a4, s7, s8
                  c.addi16sp   sp, 400
                  srai         t0, t0, 4
                  li           a5, 0x80000000 #start riscv_int_numeric_corner_stream_35
                  li           tp, 0x350fc61f
                  li           a0, 0x631d4339
                  li           a1, 0x30ee1625
                  li           t2, 0x257f0e13
                  li           t6, 0x0
                  li           s2, 0x0
                  li           s6, 0x80000000
                  li           a6, 0xffffffff
                  li           s10, 0xb5c307f0
                  auipc        s10, 881820
                  nop
                  auipc        s10, 881820
                  mulhu        s2, a6, a1
                  rem          a5, tp, s2
                  auipc        s10, 881820
                  divu         s6, a0, t6
                  div          s6, s6, s10
                  add          a5, a0, t2
                  addi         a6, a0, 596
                  sub          s10, s6, a5
                  addi         a6, a0, 596
                  mul          a0, s2, s2
                  div          s6, s6, s10
                  add          a5, a0, t2
                  addi         a6, a0, 596
                  mul          a0, s2, s2
                  remu         a5, s10, a0
                  addi         a6, a0, 596
                  addi         a6, a0, 596
                  sub          s10, s6, a5
                  rem          a5, tp, s2
                  div          s6, s6, s10
                  rem          a5, tp, s2
                  addi         a6, a0, 596
                  nop #end riscv_int_numeric_corner_stream_35
                  nop
                  divu         s10, sp, s1
                  c.sub        a3, s1
                  sltiu        a1, s4, 1988
                  auipc        a4, 881820
                  mulhu        t2, s5, t5
                  or           a4, s7, s8
                  sra          s8, a5, s8
                  xor          a4, s11, s7
                  c.li         a0, 21
                  c.or         a2, a5
                  lui          t2, 776121
                  c.srli       a0, 28
                  c.add        t2, s3
                  xori         a3, s3, -1008
                  slt          t4, s3, s11
                  mulh         s11, s9, gp
                  xori         a3, s3, -1008
                  div          s0, t2, a0
                  divu         s10, sp, s1
                  xori         a3, s3, -1008
                  c.add        t2, s3
                  slt          t4, s3, s11
                  sub          s11, t4, a3
                  divu         s10, sp, s1
                  remu         s6, a4, s2
                  xori         a3, s3, -1008
                  c.and        s0, a3
                  c.mv         s8, a5
                  srai         t0, t0, 4
                  c.xor        s0, a5
                  mul          a1, s6, s6
                  remu         s6, a4, s2
                  ori          s6, t3, 246
                  slt          t4, s3, s11
                  srli         sp, s3, 10
                  remu         s6, a4, s2
                  c.li         a0, 21
                  c.xor        s0, a5
                  ori          s6, t3, 246
                  srl          gp, a7, s6
                  c.srai       a2, 4
                  slt          t4, s3, s11
                  c.li         a0, 21
                  sub          s11, t4, a3
                  c.sub        a3, s1
                  srai         t0, t0, 4
                  c.sub        a3, s1
                  c.xor        s0, a5
                  c.xor        s0, a5
                  c.srai       a2, 4
                  c.sub        a3, s1
                  c.addi       t4, 20
                  slt          t4, s3, s11
                  c.li         a0, 21
                  slli         s4, a5, 26
                  srl          gp, a7, s6
                  sltu         s8, s9, s11
                  sub          s11, t4, a3
                  c.and        s0, a3
                  c.or         a2, a5
                  slti         gp, tp, -1791
                  remu         s6, a4, s2
                  add          s6, s2, s10
                  addi         s8, s2, 596
                  c.slli       s11, 17
                  divu         s10, sp, s1
                  divu         s10, sp, s1
                  c.addi4spn   s1, sp, 32
                  c.mv         s8, a5
                  div          s0, t2, a0
                  xor          a4, s11, s7
                  xori         a3, s3, -1008
                  c.addi16sp   sp, 400
                  add          s6, s2, s10
                  c.li         a0, 21
                  c.nop
                  srai         t0, t0, 4
                  xor          a4, s11, s7
                  or           a4, s7, s8
                  c.add        t2, s3
                  xor          a4, s11, s7
                  mulhsu       a7, s0, t4
                  c.and        s0, a3
                  nop
                  addi         s8, s2, 596
                  c.lui        s8, 31
                  sll          s8, a6, a2
                  c.li         a0, 21
                  auipc        a4, 881820
                  andi         t0, s11, 1760
                  sltiu        a1, s4, 1988
                  c.li         a0, 21
                  c.mv         s8, a5
                  andi         t0, s11, 1760
                  c.add        t2, s3
                  c.li         a0, 21
                  srli         sp, s3, 10
                  remu         s6, a4, s2
                  c.addi4spn   s1, sp, 32
                  mulhsu       a7, s0, t4
                  sltiu        a1, s4, 1988
                  auipc        a4, 881820
                  mulhu        t2, s5, t5
                  c.srai       a2, 4
                  sltiu        a1, s4, 1988
                  mul          a1, s6, s6
                  c.and        s0, a3
                  slt          t4, s3, s11
                  c.li         a0, 21
                  sra          s8, a5, s8
                  auipc        a4, 881820
                  xori         a3, s3, -1008
                  slt          t4, s3, s11
                  remu         s6, a4, s2
                  c.addi16sp   sp, 400
                  c.addi4spn   s1, sp, 32
                  c.sub        a3, s1
                  c.srli       a0, 28
                  divu         s10, sp, s1
                  c.li         a0, 21
                  and          t5, t0, a7
                  nop
                  c.add        t2, s3
                  c.addi4spn   s1, sp, 32
                  c.mv         s8, a5
                  ori          s6, t3, 246
                  c.srli       a0, 28
                  c.li         a0, 21
                  srl          gp, a7, s6
                  c.srli       a0, 28
                  slti         gp, tp, -1791
                  or           a4, s7, s8
                  slli         s4, a5, 26
                  c.addi16sp   sp, 400
                  srli         sp, s3, 10
                  srli         sp, s3, 10
                  sra          s8, a5, s8
                  div          s0, t2, a0
                  c.or         a2, a5
                  c.li         a0, 21
                  c.and        s0, a3
                  lui          t2, 776121
                  srli         sp, s3, 10
                  auipc        a4, 881820
                  rem          s6, a2, t4
                  mulhu        t2, s5, t5
                  auipc        a4, 881820
                  c.srli       a0, 28
                  auipc        a4, 881820
                  sltu         s8, s9, s11
                  sra          s8, a5, s8
                  c.nop
                  or           a4, s7, s8
                  c.addi4spn   s1, sp, 32
                  c.srai       a2, 4
                  sra          s8, a5, s8
                  div          s0, t2, a0
                  ori          s6, t3, 246
                  c.xor        s0, a5
                  xor          a4, s11, s7
                  div          s0, t2, a0
                  slt          t4, s3, s11
                  divu         s10, sp, s1
                  sltiu        a1, s4, 1988
                  mulhsu       a7, s0, t4
                  c.and        s0, a3
                  c.li         a0, 21
                  sltiu        a1, s4, 1988
                  and          t5, t0, a7
                  sra          s8, a5, s8
                  sltu         s8, s9, s11
                  remu         s6, a4, s2
                  c.lui        s8, 31
                  slti         gp, tp, -1791
                  sub          s11, t4, a3
                  c.srli       a0, 28
                  addi         s8, s2, 596
                  mulhu        t2, s5, t5
                  c.mv         s8, a5
                  c.mv         s8, a5
                  and          t5, t0, a7
                  sltiu        a1, s4, 1988
                  sltu         s8, s9, s11
                  c.sub        a3, s1
                  sll          s8, a6, a2
                  c.addi       t4, 20
                  or           a4, s7, s8
                  c.and        s0, a3
                  sltiu        a1, s4, 1988
                  slli         s4, a5, 26
                  mulhsu       a7, s0, t4
                  lui          t2, 776121
                  c.addi16sp   sp, 400
                  rem          s6, a2, t4
                  nop
                  xor          a4, s11, s7
                  auipc        a4, 881820
                  sub          s11, t4, a3
                  or           a4, s7, s8
                  mulh         s11, s9, gp
                  c.or         a2, a5
                  sltu         s8, s9, s11
                  addi         s8, s2, 596
                  c.addi       t4, 20
                  c.sub        a3, s1
                  div          s0, t2, a0
                  c.or         a2, a5
                  c.and        s0, a3
                  rem          s6, a2, t4
                  remu         s6, a4, s2
                  or           a4, s7, s8
                  sub          s11, t4, a3
                  xori         a3, s3, -1008
                  c.nop
                  or           a4, s7, s8
                  sra          s8, a5, s8
                  c.and        s0, a3
                  c.and        s0, a3
                  c.lui        s8, 31
                  xori         a3, s3, -1008
                  divu         s10, sp, s1
                  sub          s11, t4, a3
                  div          s0, t2, a0
                  addi         s8, s2, 596
                  c.add        t2, s3
                  add          s6, s2, s10
                  andi         t0, s11, 1760
                  mulhu        t2, s5, t5
                  sltu         s8, s9, s11
                  nop
                  c.srai       a2, 4
                  slli         s4, a5, 26
                  srl          gp, a7, s6
                  sub          s11, t4, a3
                  srai         t0, t0, 4
                  xori         a3, s3, -1008
                  c.srli       a0, 28
                  sra          s8, a5, s8
                  srai         t0, t0, 4
                  c.or         a2, a5
                  add          s6, s2, s10
                  srai         t0, t0, 4
                  auipc        a4, 881820
                  nop
                  c.sub        a3, s1
                  or           a4, s7, s8
                  mulhsu       a7, s0, t4
                  srli         sp, s3, 10
                  c.li         a0, 21
                  sra          s8, a5, s8
                  c.andi       a0, -1
                  c.addi       t4, 20
                  c.addi16sp   sp, 400
                  xori         a3, s3, -1008
                  andi         t0, s11, 1760
                  c.andi       a0, -1
                  auipc        a4, 881820
                  sltu         s8, s9, s11
                  srai         t0, t0, 4
                  c.srli       a0, 28
                  sub          s11, t4, a3
                  ori          s6, t3, 246
                  lui          t2, 776121
                  sltu         s8, s9, s11
                  c.xor        s0, a5
                  mul          a1, s6, s6
                  c.mv         s8, a5
                  lui          t2, 776121
                  c.or         a2, a5
                  c.andi       a0, -1
                  mulhsu       a7, s0, t4
                  c.srai       a2, 4
                  c.add        t2, s3
                  andi         t0, s11, 1760
                  c.xor        s0, a5
                  srai         t0, t0, 4
                  c.nop
                  sltiu        a1, s4, 1988
                  slt          t4, s3, s11
                  c.addi4spn   s1, sp, 32
                  c.li         a0, 21
                  mulhu        t2, s5, t5
                  mul          a1, s6, s6
                  rem          s6, a2, t4
                  srli         sp, s3, 10
                  addi         s8, s2, 596
                  srl          gp, a7, s6
                  srli         sp, s3, 10
                  sra          s8, a5, s8
                  sll          s8, a6, a2
                  sltiu        a1, s4, 1988
                  xori         a3, s3, -1008
                  slli         s4, a5, 26
                  ori          s6, t3, 246
                  c.lui        s8, 31
                  c.srli       a0, 28
                  mulhu        t2, s5, t5
                  c.andi       a0, -1
                  mul          a1, s6, s6
                  c.srli       a0, 28
                  add          s6, s2, s10
                  c.addi16sp   sp, 400
                  sltu         s8, s9, s11
                  mulhu        t2, s5, t5
                  c.xor        s0, a5
                  addi         s8, s2, 596
                  sra          s8, a5, s8
                  auipc        a4, 881820
                  slli         s4, a5, 26
                  c.nop
                  rem          s6, a2, t4
                  and          t5, t0, a7
                  srl          gp, a7, s6
                  c.addi4spn   s1, sp, 32
                  sltiu        a1, s4, 1988
                  c.srli       a0, 28
                  c.addi16sp   sp, 400
                  c.slli       s11, 17
                  mulhsu       a7, s0, t4
                  c.or         a2, a5
                  nop
                  mul          a1, s6, s6
                  c.slli       s11, 17
                  c.slli       s11, 17
                  addi         s8, s2, 596
                  c.or         a2, a5
                  and          t5, t0, a7
                  mulhsu       a7, s0, t4
                  c.lui        s8, 31
                  c.li         a0, 21
                  xor          a4, s11, s7
                  sub          s11, t4, a3
                  slti         gp, tp, -1791
                  slt          t4, s3, s11
                  c.mv         s8, a5
                  mulhsu       a7, s0, t4
                  c.mv         s8, a5
                  c.slli       s11, 17
                  c.lui        s8, 31
                  add          s6, s2, s10
                  c.andi       a0, -1
                  sltiu        a1, s4, 1988
                  sll          s8, a6, a2
                  xori         a3, s3, -1008
                  c.sub        a3, s1
                  xori         a3, s3, -1008
                  sra          s8, a5, s8
                  mulhsu       a7, s0, t4
                  c.addi       t4, 20
                  or           a4, s7, s8
                  c.sub        a3, s1
                  c.srli       a0, 28
                  nop
                  andi         t0, s11, 1760
                  addi         s8, s2, 596
                  c.li         a0, 21
                  mulhsu       a7, s0, t4
                  srai         t0, t0, 4
                  mul          a1, s6, s6
                  mulhu        t2, s5, t5
                  xori         a3, s3, -1008
                  c.addi       t4, 20
                  andi         t0, s11, 1760
                  c.mv         s8, a5
                  c.andi       a0, -1
                  ori          s6, t3, 246
                  slli         s4, a5, 26
                  slti         gp, tp, -1791
                  and          t5, t0, a7
                  c.nop
                  sltu         s8, s9, s11
                  xori         a3, s3, -1008
                  auipc        a4, 881820
                  srli         sp, s3, 10
                  c.addi       t4, 20
                  c.nop
                  mulhu        t2, s5, t5
                  c.srli       a0, 28
                  c.and        s0, a3
                  sra          s8, a5, s8
                  ori          s6, t3, 246
                  c.nop
                  srai         t0, t0, 4
                  c.mv         s8, a5
                  c.addi16sp   sp, 400
                  sub          s11, t4, a3
                  c.li         a0, 21
                  c.add        t2, s3
                  c.xor        s0, a5
                  c.sub        a3, s1
                  c.addi16sp   sp, 400
                  sra          s8, a5, s8
                  and          t5, t0, a7
                  slt          t4, s3, s11
                  nop
                  div          s0, t2, a0
                  mul          a1, s6, s6
                  slt          t4, s3, s11
                  addi         s8, s2, 596
                  slli         s4, a5, 26
                  c.srai       a2, 4
                  c.xor        s0, a5
                  srli         sp, s3, 10
                  sll          s8, a6, a2
                  c.lui        s8, 31
                  mulh         s11, s9, gp
                  c.and        s0, a3
                  c.addi4spn   s1, sp, 32
                  nop
                  lui          t2, 776121
                  c.or         a2, a5
                  xor          a4, s11, s7
                  c.add        t2, s3
                  c.add        t2, s3
                  mul          a1, s6, s6
                  sltiu        a1, s4, 1988
                  or           a4, s7, s8
                  mulhsu       a7, s0, t4
                  rem          s6, a2, t4
                  slt          t4, s3, s11
                  c.addi16sp   sp, 400
                  lui          t2, 776121
                  remu         s6, a4, s2
                  srl          gp, a7, s6
                  c.lui        s8, 31
                  srl          gp, a7, s6
                  c.nop
                  sltiu        a1, s4, 1988
                  c.andi       a0, -1
                  ori          s6, t3, 246
                  c.addi4spn   s1, sp, 32
                  xori         a3, s3, -1008
                  sltu         s8, s9, s11
                  c.add        t2, s3
                  c.nop
                  c.mv         s8, a5
                  c.nop
                  ori          s6, t3, 246
                  andi         t0, s11, 1760
                  sltu         s8, s9, s11
                  slt          t4, s3, s11
                  mul          a1, s6, s6
                  lui          t2, 776121
                  lui          t2, 776121
                  slt          t4, s3, s11
                  c.addi16sp   sp, 400
                  or           a4, s7, s8
                  c.addi16sp   sp, 400
                  xori         a3, s3, -1008
                  rem          s6, a2, t4
                  c.add        t2, s3
                  nop
                  mulh         s11, s9, gp
                  slli         s4, a5, 26
                  mulhsu       a7, s0, t4
                  c.nop
                  remu         s6, a4, s2
                  mul          a1, s6, s6
                  sra          s8, a5, s8
                  mulhu        t2, s5, t5
                  divu         s10, sp, s1
                  c.nop
                  nop
                  c.addi4spn   s1, sp, 32
                  c.srai       a2, 4
                  c.mv         s8, a5
                  c.srai       a2, 4
                  sll          s8, a6, a2
                  c.addi4spn   s1, sp, 32
                  slt          t4, s3, s11
                  slti         gp, tp, -1791
                  c.mv         s8, a5
                  slti         gp, tp, -1791
                  sll          s8, a6, a2
                  xori         a3, s3, -1008
                  and          t5, t0, a7
                  lui          t2, 776121
                  sltu         s8, s9, s11
                  slli         s4, a5, 26
                  srl          gp, a7, s6
                  andi         t0, s11, 1760
                  lui          t2, 776121
                  mulhsu       a7, s0, t4
                  nop
                  c.or         a2, a5
                  c.srai       a2, 4
                  c.or         a2, a5
                  c.mv         s8, a5
                  xor          a4, s11, s7
                  ori          s6, t3, 246
                  sra          s8, a5, s8
                  c.mv         s8, a5
                  slti         gp, tp, -1791
                  remu         s6, a4, s2
                  srai         t0, t0, 4
                  c.slli       s11, 17
                  sra          s8, a5, s8
                  slt          t4, s3, s11
                  c.slli       s11, 17
                  lui          t2, 776121
                  nop
                  sltu         s8, s9, s11
                  c.or         a2, a5
                  c.addi4spn   s1, sp, 32
                  or           a4, s7, s8
                  srl          gp, a7, s6
                  c.add        t2, s3
                  xori         a3, s3, -1008
                  add          s6, s2, s10
                  mul          a1, s6, s6
                  c.xor        s0, a5
                  xori         a3, s3, -1008
                  divu         s10, sp, s1
                  c.lui        s8, 31
                  c.addi       t4, 20
                  c.lui        s8, 31
                  c.slli       s11, 17
                  addi         s8, s2, 596
                  sltu         s8, s9, s11
                  slt          t4, s3, s11
                  sll          s8, a6, a2
                  mulhsu       a7, s0, t4
                  add          s6, s2, s10
                  c.srli       a0, 28
                  sltiu        a1, s4, 1988
                  andi         t0, s11, 1760
                  c.sub        a3, s1
                  mulhu        t2, s5, t5
                  mul          a1, s6, s6
                  divu         s10, sp, s1
                  c.or         a2, a5
                  c.srli       a0, 28
                  c.xor        s0, a5
                  xor          a4, s11, s7
                  c.add        t2, s3
                  mulhu        t2, s5, t5
                  c.addi4spn   s1, sp, 32
                  nop
                  srl          gp, a7, s6
                  mulhu        t2, s5, t5
                  andi         t0, s11, 1760
                  c.andi       a0, -1
                  xor          a4, s11, s7
                  c.xor        s0, a5
                  c.addi16sp   sp, 400
                  sub          s11, t4, a3
                  c.xor        s0, a5
                  srl          gp, a7, s6
                  sub          s11, t4, a3
                  srl          gp, a7, s6
                  andi         t0, s11, 1760
                  mulhsu       a7, s0, t4
                  divu         s10, sp, s1
                  xori         a3, s3, -1008
                  divu         s10, sp, s1
                  c.xor        s0, a5
                  slt          t4, s3, s11
                  c.xor        s0, a5
                  c.slli       s11, 17
                  c.addi16sp   sp, 400
                  c.and        s0, a3
                  c.and        s0, a3
                  add          s6, s2, s10
                  rem          s6, a2, t4
                  c.slli       s11, 17
                  c.add        t2, s3
                  c.addi16sp   sp, 400
                  srai         t0, t0, 4
                  c.lui        s8, 31
                  addi         s8, s2, 596
                  c.srli       a0, 28
                  lui          t2, 776121
                  c.srai       a2, 4
                  sra          s8, a5, s8
                  c.srai       a2, 4
                  sll          s8, a6, a2
                  c.srai       a2, 4
                  auipc        a4, 881820
                  c.mv         s8, a5
                  srl          gp, a7, s6
                  srli         sp, s3, 10
                  mulhu        t2, s5, t5
                  sub          s11, t4, a3
                  or           a4, s7, s8
                  mulhsu       a7, s0, t4
                  slli         s4, a5, 26
                  mulhu        t2, s5, t5
                  remu         s6, a4, s2
                  sll          s8, a6, a2
                  div          s0, t2, a0
                  srl          gp, a7, s6
                  sub          s11, t4, a3
                  c.addi4spn   s1, sp, 32
                  slt          t4, s3, s11
                  sra          s8, a5, s8
                  c.andi       a0, -1
                  c.addi4spn   s1, sp, 32
                  xor          a4, s11, s7
                  c.addi       t4, 20
                  c.srai       a2, 4
                  rem          s6, a2, t4
                  ori          s6, t3, 246
                  andi         t0, s11, 1760
                  srai         t0, t0, 4
                  c.srai       a2, 4
                  andi         t0, s11, 1760
                  slti         gp, tp, -1791
                  sll          s8, a6, a2
                  or           a4, s7, s8
                  c.sub        a3, s1
                  srai         t0, t0, 4
                  slti         gp, tp, -1791
                  xor          a4, s11, s7
                  sltiu        a1, s4, 1988
                  auipc        a4, 881820
                  remu         s6, a4, s2
                  mulhsu       a7, s0, t4
                  c.sub        a3, s1
                  slti         gp, tp, -1791
                  c.mv         s8, a5
                  c.srli       a0, 28
                  mulh         s11, s9, gp
                  srli         sp, s3, 10
                  c.mv         s8, a5
                  srai         t0, t0, 4
                  c.andi       a0, -1
                  sra          s8, a5, s8
                  xor          a4, s11, s7
                  sra          s8, a5, s8
                  srl          gp, a7, s6
                  c.addi       t4, 20
                  rem          s6, a2, t4
                  c.sub        a3, s1
                  xori         a3, s3, -1008
                  srli         sp, s3, 10
                  rem          s6, a2, t4
                  c.or         a2, a5
                  c.add        t2, s3
                  c.slli       s11, 17
                  c.sub        a3, s1
                  c.nop
                  lui          t2, 776121
                  srli         sp, s3, 10
                  c.mv         s8, a5
                  or           a4, s7, s8
                  andi         t0, s11, 1760
                  mulh         s11, s9, gp
                  sltiu        a1, s4, 1988
                  mulhsu       a7, s0, t4
                  c.sub        a3, s1
                  sub          s11, t4, a3
                  c.addi       t4, 20
                  sra          s8, a5, s8
                  div          s0, t2, a0
                  c.xor        s0, a5
                  c.or         a2, a5
                  c.li         a0, 21
                  lui          t2, 776121
                  c.mv         s8, a5
                  lui          t2, 776121
                  slli         s4, a5, 26
                  slli         s4, a5, 26
                  c.andi       a0, -1
                  rem          s6, a2, t4
                  div          s0, t2, a0
                  slt          t4, s3, s11
                  ori          s6, t3, 246
                  c.addi       t4, 20
                  srl          gp, a7, s6
                  sltu         s8, s9, s11
                  sltiu        a1, s4, 1988
                  rem          s6, a2, t4
                  nop
                  add          s6, s2, s10
                  and          t5, t0, a7
                  srli         sp, s3, 10
                  sra          s8, a5, s8
                  c.li         a0, 21
                  addi         s8, s2, 596
                  sltu         s8, s9, s11
                  rem          s6, a2, t4
                  slti         gp, tp, -1791
                  sub          s11, t4, a3
                  c.srli       a0, 28
                  xor          a4, s11, s7
                  ori          s6, t3, 246
                  divu         s10, sp, s1
                  c.and        s0, a3
                  slt          t4, s3, s11
                  slli         s4, a5, 26
                  sltiu        a1, s4, 1988
                  and          t5, t0, a7
                  mulhu        t2, s5, t5
                  xori         a3, s3, -1008
                  sra          s8, a5, s8
                  c.srai       a2, 4
                  divu         s10, sp, s1
                  and          t5, t0, a7
                  c.li         a0, 21
                  sra          s8, a5, s8
                  c.sub        a3, s1
                  sub          s11, t4, a3
                  slli         s4, a5, 26
                  nop
                  c.or         a2, a5
                  c.addi       t4, 20
                  c.sub        a3, s1
                  c.li         a0, 21
                  sub          s11, t4, a3
                  c.li         a0, 21
                  xor          a4, s11, s7
                  c.li         a0, 21
                  c.nop
                  c.andi       a0, -1
                  sra          s8, a5, s8
                  rem          s6, a2, t4
                  c.nop
                  c.or         a2, a5
                  c.addi       t4, 20
                  srl          gp, a7, s6
                  mulh         s11, s9, gp
                  divu         s10, sp, s1
                  sltiu        a1, s4, 1988
                  add          s6, s2, s10
                  add          s6, s2, s10
                  c.srai       a2, 4
                  mulhu        t2, s5, t5
                  c.srli       a0, 28
                  c.addi       t4, 20
                  and          t5, t0, a7
                  mulh         s11, s9, gp
                  add          s6, s2, s10
                  srl          gp, a7, s6
                  slti         gp, tp, -1791
                  slt          t4, s3, s11
                  c.add        t2, s3
                  c.or         a2, a5
                  c.addi16sp   sp, 400
                  mul          a1, s6, s6
                  c.or         a2, a5
                  c.mv         s8, a5
                  mulhu        t2, s5, t5
                  add          s6, s2, s10
                  addi         s8, s2, 596
                  rem          s6, a2, t4
                  c.addi       t4, 20
                  mulh         s11, s9, gp
                  or           a4, s7, s8
                  auipc        a4, 881820
                  srl          gp, a7, s6
                  c.li         a0, 21
                  c.andi       a0, -1
                  sra          s8, a5, s8
                  add          s6, s2, s10
                  c.addi16sp   sp, 400
                  addi         s8, s2, 596
                  c.lui        s8, 31
                  c.lui        s8, 31
                  c.sub        a3, s1
                  nop
                  c.andi       a0, -1
                  mulh         s11, s9, gp
                  srai         t0, t0, 4
                  and          t5, t0, a7
                  or           a4, s7, s8
                  c.addi4spn   s1, sp, 32
                  lui          t2, 776121
                  auipc        a4, 881820
                  srai         t0, t0, 4
                  srl          gp, a7, s6
                  c.li         a0, 21
                  li           s6, 0x0 #start riscv_int_numeric_corner_stream_17
                  li           t3, 0xcccdf2b5
                  li           s5, 0x80000000
                  li           tp, 0xffffffff
                  li           a5, 0x0
                  li           ra, 0xdd35cd74
                  li           s8, 0x4b941d54
                  li           a3, 0x0
                  li           t6, 0x0
                  li           s2, 0x0
                  add          s2, a3, tp
                  divu         s8, a3, t6
                  addi         s5, a3, 596
                  sub          t3, s8, s2
                  lui          s6, 776121
                  auipc        t3, 881820
                  mulhsu       ra, t3, a3
                  mul          a3, s6, s6
                  mul          a3, s6, s6
                  mul          a3, s6, s6
                  auipc        t3, 881820
                  mulhsu       ra, t3, a3
                  rem          s2, ra, s6
                  sub          t3, s8, s2
                  mulh         t3, t6, a5
                  nop
                  nop
                  div          s8, s8, t3
                  rem          s2, ra, s6
                  rem          s2, ra, s6
                  divu         s8, a3, t6
                  lui          s6, 776121
                  rem          s2, ra, s6
                  mulhu        s6, s5, a5
                  add          s2, a3, tp #end riscv_int_numeric_corner_stream_17
                  xori         a3, s3, -1008
                  mulh         s11, s9, gp
                  sub          s11, t4, a3
                  add          s6, s2, s10
                  slli         s4, a5, 26
                  lui          t2, 776121
                  ori          s6, t3, 246
                  c.and        s0, a3
                  div          s0, t2, a0
                  andi         t0, s11, 1760
                  c.xor        s0, a5
                  c.slli       s11, 17
                  c.andi       a0, -1
                  c.mv         s8, a5
                  slt          t4, s3, s11
                  c.li         a0, 21
                  mulhsu       a7, s0, t4
                  addi         s8, s2, 596
                  add          s6, s2, s10
                  c.or         a2, a5
                  c.addi4spn   s1, sp, 32
                  lui          t2, 776121
                  c.addi4spn   s1, sp, 32
                  c.lui        s8, 31
                  sltu         s8, s9, s11
                  and          t5, t0, a7
                  nop
                  nop
                  c.addi       t4, 20
                  c.xor        s0, a5
                  c.addi       t4, 20
                  mulhu        t2, s5, t5
                  c.slli       s11, 17
                  c.and        s0, a3
                  sub          s11, t4, a3
                  c.xor        s0, a5
                  sra          s8, a5, s8
                  sub          s11, t4, a3
                  xori         a3, s3, -1008
                  slli         s4, a5, 26
                  c.srli       a0, 28
                  c.or         a2, a5
                  ori          s6, t3, 246
                  nop
                  slli         s4, a5, 26
                  srli         sp, s3, 10
                  divu         s10, sp, s1
                  c.sub        a3, s1
                  sll          s8, a6, a2
                  add          s6, s2, s10
                  c.lui        s8, 31
                  c.lui        s8, 31
                  xor          a4, s11, s7
                  mulh         s11, s9, gp
                  lui          t2, 776121
                  srai         t0, t0, 4
                  addi         s8, s2, 596
                  sub          s11, t4, a3
                  mulhsu       a7, s0, t4
                  c.sub        a3, s1
                  c.or         a2, a5
                  ori          s6, t3, 246
                  or           a4, s7, s8
                  sub          s11, t4, a3
                  c.addi4spn   s1, sp, 32
                  mul          a1, s6, s6
                  add          s6, s2, s10
                  div          s0, t2, a0
                  sll          s8, a6, a2
                  c.addi16sp   sp, 400
                  c.or         a2, a5
                  c.add        t2, s3
                  mulhu        t2, s5, t5
                  sra          s8, a5, s8
                  c.addi4spn   s1, sp, 32
                  c.addi       t4, 20
                  remu         s6, a4, s2
                  c.addi4spn   s1, sp, 32
                  ori          s6, t3, 246
                  c.li         a0, 21
                  ori          s6, t3, 246
                  xor          a4, s11, s7
                  andi         t0, s11, 1760
                  c.sub        a3, s1
                  div          s0, t2, a0
                  sll          s8, a6, a2
                  auipc        a4, 881820
                  auipc        a4, 881820
                  c.lui        s8, 31
                  slli         s4, a5, 26
                  srl          gp, a7, s6
                  andi         t0, s11, 1760
                  sltu         s8, s9, s11
                  andi         t0, s11, 1760
                  c.srli       a0, 28
                  slt          t4, s3, s11
                  c.addi       t4, 20
                  c.lui        s8, 31
                  srli         sp, s3, 10
                  andi         t0, s11, 1760
                  c.slli       s11, 17
                  rem          s6, a2, t4
                  rem          s6, a2, t4
                  mulhu        t2, s5, t5
                  c.addi16sp   sp, 400
                  sltu         s8, s9, s11
                  srli         sp, s3, 10
                  and          t5, t0, a7
                  lui          t2, 776121
                  srl          gp, a7, s6
                  sltiu        a1, s4, 1988
                  and          t5, t0, a7
                  or           a4, s7, s8
                  srl          gp, a7, s6
                  srl          gp, a7, s6
                  sub          s11, t4, a3
                  c.srai       a2, 4
                  c.sub        a3, s1
                  c.and        s0, a3
                  slti         gp, tp, -1791
                  nop
                  c.sub        a3, s1
                  mulhsu       a7, s0, t4
                  c.xor        s0, a5
                  sra          s8, a5, s8
                  or           a4, s7, s8
                  slt          t4, s3, s11
                  ori          s6, t3, 246
                  mulhsu       a7, s0, t4
                  nop
                  sltu         s8, s9, s11
                  auipc        a4, 881820
                  slli         s4, a5, 26
                  mulhu        t2, s5, t5
                  xor          a4, s11, s7
                  c.sub        a3, s1
                  c.addi16sp   sp, 400
                  srli         sp, s3, 10
                  sra          s8, a5, s8
                  c.srli       a0, 28
                  nop
                  srli         sp, s3, 10
                  c.and        s0, a3
                  c.sub        a3, s1
                  c.mv         s8, a5
                  sra          s8, a5, s8
                  c.or         a2, a5
                  or           a4, s7, s8
                  slt          t4, s3, s11
                  slti         gp, tp, -1791
                  slli         s4, a5, 26
                  remu         s6, a4, s2
                  mulhsu       a7, s0, t4
                  lui          t2, 776121
                  mulhu        t2, s5, t5
                  addi         s8, s2, 596
                  andi         t0, s11, 1760
                  mulhsu       a7, s0, t4
                  remu         s6, a4, s2
                  c.xor        s0, a5
                  rem          s6, a2, t4
                  srl          gp, a7, s6
                  c.addi       t4, 20
                  div          s0, t2, a0
                  auipc        a4, 881820
                  sltiu        a1, s4, 1988
                  c.mv         s8, a5
                  lui          t2, 776121
                  andi         t0, s11, 1760
                  c.addi       t4, 20
                  mulhu        t2, s5, t5
                  lui          t2, 776121
                  or           a4, s7, s8
                  andi         t0, s11, 1760
                  c.addi       t4, 20
                  c.addi16sp   sp, 400
                  sra          s8, a5, s8
                  slt          t4, s3, s11
                  c.li         a0, 21
                  auipc        a4, 881820
                  c.xor        s0, a5
                  srli         sp, s3, 10
                  divu         s10, sp, s1
                  remu         s6, a4, s2
                  xor          a4, s11, s7
                  mulhu        t2, s5, t5
                  mul          a1, s6, s6
                  and          t5, t0, a7
                  mulhsu       a7, s0, t4
                  lui          t2, 776121
                  add          s6, s2, s10
                  and          t5, t0, a7
                  slti         gp, tp, -1791
                  divu         s10, sp, s1
                  c.addi4spn   s1, sp, 32
                  srli         sp, s3, 10
                  or           a4, s7, s8
                  and          t5, t0, a7
                  c.xor        s0, a5
                  c.addi       t4, 20
                  c.andi       a0, -1
                  c.and        s0, a3
                  c.sub        a3, s1
                  c.sub        a3, s1
                  c.addi       t4, 20
                  c.slli       s11, 17
                  c.li         a0, 21
                  c.addi       t4, 20
                  remu         s6, a4, s2
                  auipc        a4, 881820
                  srl          gp, a7, s6
                  xor          a4, s11, s7
                  srli         sp, s3, 10
                  c.lui        s8, 31
                  srl          gp, a7, s6
                  ori          s6, t3, 246
                  auipc        a4, 881820
                  c.addi       t4, 20
                  c.and        s0, a3
                  c.li         a0, 21
                  slt          t4, s3, s11
                  c.xor        s0, a5
                  or           a4, s7, s8
                  mul          a1, s6, s6
                  c.li         a0, 21
                  ori          s6, t3, 246
                  sltu         s8, s9, s11
                  c.addi       t4, 20
                  remu         s6, a4, s2
                  c.andi       a0, -1
                  andi         t0, s11, 1760
                  slli         s4, a5, 26
                  c.add        t2, s3
                  andi         t0, s11, 1760
                  srli         sp, s3, 10
                  c.srai       a2, 4
                  c.srli       a0, 28
                  sltiu        a1, s4, 1988
                  c.or         a2, a5
                  srl          gp, a7, s6
                  sltiu        a1, s4, 1988
                  mulhu        t2, s5, t5
                  c.xor        s0, a5
                  c.li         a0, 21
                  mulh         s11, s9, gp
                  srli         sp, s3, 10
                  remu         s6, a4, s2
                  c.or         a2, a5
                  remu         s6, a4, s2
                  xor          a4, s11, s7
                  ori          s6, t3, 246
                  c.srli       a0, 28
                  srli         sp, s3, 10
                  c.slli       s11, 17
                  srai         t0, t0, 4
                  c.or         a2, a5
                  rem          s6, a2, t4
                  ori          s6, t3, 246
                  sub          s11, t4, a3
                  addi         s8, s2, 596
                  remu         s6, a4, s2
                  mulhsu       a7, s0, t4
                  c.li         a0, 21
                  and          t5, t0, a7
                  c.sub        a3, s1
                  divu         s10, sp, s1
                  c.lui        s8, 31
                  ori          s6, t3, 246
                  ori          s6, t3, 246
                  nop
                  sltiu        a1, s4, 1988
                  div          s0, t2, a0
                  sra          s8, a5, s8
                  c.addi       t4, 20
                  c.li         a0, 21
                  ori          s6, t3, 246
                  srai         t0, t0, 4
                  mulh         s11, s9, gp
                  c.andi       a0, -1
                  c.li         a0, 21
                  mulhsu       a7, s0, t4
                  mul          a1, s6, s6
                  c.lui        s8, 31
                  c.or         a2, a5
                  sub          s11, t4, a3
                  nop
                  mulh         s11, s9, gp
                  or           a4, s7, s8
                  addi         s8, s2, 596
                  sltu         s8, s9, s11
                  or           a4, s7, s8
                  addi         s8, s2, 596
                  c.sub        a3, s1
                  c.addi16sp   sp, 400
                  c.xor        s0, a5
                  c.andi       a0, -1
                  mul          a1, s6, s6
                  or           a4, s7, s8
                  mulhu        t2, s5, t5
                  srai         t0, t0, 4
                  c.andi       a0, -1
                  c.lui        s8, 31
                  c.addi4spn   s1, sp, 32
                  remu         s6, a4, s2
                  rem          s6, a2, t4
                  xor          a4, s11, s7
                  div          s0, t2, a0
                  auipc        a4, 881820
                  mulh         s11, s9, gp
                  c.li         a0, 21
                  sltiu        a1, s4, 1988
                  c.mv         s8, a5
                  nop
                  ori          s6, t3, 246
                  mulhsu       a7, s0, t4
                  rem          s6, a2, t4
                  and          t5, t0, a7
                  c.srli       a0, 28
                  sll          s8, a6, a2
                  c.andi       a0, -1
                  add          s6, s2, s10
                  srl          gp, a7, s6
                  mul          a1, s6, s6
                  c.or         a2, a5
                  c.nop
                  c.mv         s8, a5
                  mulh         s11, s9, gp
                  remu         s6, a4, s2
                  nop
                  mulhu        t2, s5, t5
                  c.and        s0, a3
                  or           a4, s7, s8
                  c.or         a2, a5
                  rem          s6, a2, t4
                  slti         gp, tp, -1791
                  c.mv         s8, a5
                  srai         t0, t0, 4
                  srli         sp, s3, 10
                  rem          s6, a2, t4
                  c.lui        s8, 31
                  mulhsu       a7, s0, t4
                  xori         a3, s3, -1008
                  mulh         s11, s9, gp
                  sub          s11, t4, a3
                  sra          s8, a5, s8
                  c.add        t2, s3
                  mul          a1, s6, s6
                  srli         sp, s3, 10
                  sra          s8, a5, s8
                  sra          s8, a5, s8
                  c.lui        s8, 31
                  or           a4, s7, s8
                  divu         s10, sp, s1
                  c.lui        s8, 31
                  andi         t0, s11, 1760
                  c.nop
                  divu         s10, sp, s1
                  addi         s8, s2, 596
                  sra          s8, a5, s8
                  c.slli       s11, 17
                  andi         t0, s11, 1760
                  c.andi       a0, -1
                  xor          a4, s11, s7
                  mulhu        t2, s5, t5
                  mulhsu       a7, s0, t4
                  c.sub        a3, s1
                  or           a4, s7, s8
                  c.and        s0, a3
                  rem          s6, a2, t4
                  sra          s8, a5, s8
                  mulhsu       a7, s0, t4
                  c.addi       t4, 20
                  sub          s11, t4, a3
                  c.mv         s8, a5
                  c.and        s0, a3
                  sra          s8, a5, s8
                  c.addi16sp   sp, 400
                  srl          gp, a7, s6
                  slli         s4, a5, 26
                  slli         s4, a5, 26
                  sra          s8, a5, s8
                  remu         s6, a4, s2
                  ori          s6, t3, 246
                  rem          s6, a2, t4
                  c.add        t2, s3
                  addi         s8, s2, 596
                  srli         sp, s3, 10
                  c.andi       a0, -1
                  divu         s10, sp, s1
                  auipc        a4, 881820
                  srai         t0, t0, 4
                  nop
                  c.add        t2, s3
                  divu         s10, sp, s1
                  slti         gp, tp, -1791
                  add          s6, s2, s10
                  srl          gp, a7, s6
                  c.srli       a0, 28
                  or           a4, s7, s8
                  or           a4, s7, s8
                  slt          t4, s3, s11
                  addi         s8, s2, 596
                  xor          a4, s11, s7
                  ori          s6, t3, 246
                  mulh         s11, s9, gp
                  nop
                  sltiu        a1, s4, 1988
                  c.srai       a2, 4
                  c.add        t2, s3
                  c.mv         s8, a5
                  remu         s6, a4, s2
                  rem          s6, a2, t4
                  slli         s4, a5, 26
                  c.li         a0, 21
                  c.sub        a3, s1
                  sra          s8, a5, s8
                  c.andi       a0, -1
                  c.srai       a2, 4
                  nop
                  srli         sp, s3, 10
                  sll          s8, a6, a2
                  slli         s4, a5, 26
                  c.nop
                  c.addi4spn   s1, sp, 32
                  c.mv         s8, a5
                  c.mv         s8, a5
                  add          s6, s2, s10
                  c.slli       s11, 17
                  c.nop
                  slt          t4, s3, s11
                  divu         s10, sp, s1
                  c.nop
                  mulhu        t2, s5, t5
                  c.lui        s8, 31
                  c.addi16sp   sp, 400
                  sra          s8, a5, s8
                  c.slli       s11, 17
                  sra          s8, a5, s8
                  rem          s6, a2, t4
                  slti         gp, tp, -1791
                  addi         s8, s2, 596
                  srai         t0, t0, 4
                  c.addi4spn   s1, sp, 32
                  c.mv         s8, a5
                  sltu         s8, s9, s11
                  slti         gp, tp, -1791
                  c.li         a0, 21
                  c.sub        a3, s1
                  rem          s6, a2, t4
                  sra          s8, a5, s8
                  ori          s6, t3, 246
                  rem          s6, a2, t4
                  slli         s4, a5, 26
                  slt          t4, s3, s11
                  slt          t4, s3, s11
                  c.nop
                  c.lui        s8, 31
                  sra          s8, a5, s8
                  c.srli       a0, 28
                  c.slli       s11, 17
                  divu         s10, sp, s1
                  c.slli       s11, 17
                  c.and        s0, a3
                  mulh         s11, s9, gp
                  srli         sp, s3, 10
                  nop
                  c.addi       t4, 20
                  c.xor        s0, a5
                  c.srli       a0, 28
                  andi         t0, s11, 1760
                  sll          s8, a6, a2
                  mulhu        t2, s5, t5
                  rem          s6, a2, t4
                  c.addi16sp   sp, 400
                  srl          gp, a7, s6
                  c.li         a0, 21
                  c.mv         s8, a5
                  rem          s6, a2, t4
                  slti         gp, tp, -1791
                  mulhsu       a7, s0, t4
                  c.lui        s8, 31
                  and          t5, t0, a7
                  div          s0, t2, a0
                  sll          s8, a6, a2
                  sra          s8, a5, s8
                  and          t5, t0, a7
                  ori          s6, t3, 246
                  mulhsu       a7, s0, t4
                  c.slli       s11, 17
                  c.srai       a2, 4
                  lui          t2, 776121
                  c.xor        s0, a5
                  c.add        t2, s3
                  c.add        t2, s3
                  nop
                  lui          t2, 776121
                  srl          gp, a7, s6
                  c.lui        s8, 31
                  c.nop
                  mul          a1, s6, s6
                  sltiu        a1, s4, 1988
                  sll          s8, a6, a2
                  c.lui        s8, 31
                  remu         s6, a4, s2
                  xor          a4, s11, s7
                  sra          s8, a5, s8
                  c.or         a2, a5
                  auipc        a4, 881820
                  c.add        t2, s3
                  mulhsu       a7, s0, t4
                  c.mv         s8, a5
                  mul          a1, s6, s6
                  c.srli       a0, 28
                  c.nop
                  c.slli       s11, 17
                  mulh         s11, s9, gp
                  c.addi16sp   sp, 400
                  mulhu        t2, s5, t5
                  srl          gp, a7, s6
                  sll          s8, a6, a2
                  sub          s11, t4, a3
                  auipc        a4, 881820
                  c.lui        s8, 31
                  lui          t2, 776121
                  c.nop
                  xor          a4, s11, s7
                  srai         t0, t0, 4
                  c.andi       a0, -1
                  mulhsu       a7, s0, t4
                  c.slli       s11, 17
                  xor          a4, s11, s7
                  c.slli       s11, 17
                  c.addi4spn   s1, sp, 32
                  c.and        s0, a3
                  or           a4, s7, s8
                  auipc        a4, 881820
                  sltu         s8, s9, s11
                  c.add        t2, s3
                  srai         t0, t0, 4
                  mulhsu       a7, s0, t4
                  addi         s8, s2, 596
                  c.and        s0, a3
                  mulhsu       a7, s0, t4
                  sub          s11, t4, a3
                  and          t5, t0, a7
                  c.and        s0, a3
                  auipc        a4, 881820
                  mul          a1, s6, s6
                  andi         t0, s11, 1760
                  c.srli       a0, 28
                  lui          t2, 776121
                  divu         s10, sp, s1
                  c.mv         s8, a5
                  c.and        s0, a3
                  andi         t0, s11, 1760
                  mulhu        t2, s5, t5
                  mulh         s11, s9, gp
                  srl          gp, a7, s6
                  xori         a3, s3, -1008
                  c.addi16sp   sp, 400
                  srai         t0, t0, 4
                  c.lui        s8, 31
                  c.srai       a2, 4
                  nop
                  andi         t0, s11, 1760
                  c.andi       a0, -1
                  nop
                  slti         gp, tp, -1791
                  auipc        a4, 881820
                  c.lui        s8, 31
                  slli         s4, a5, 26
                  c.mv         s8, a5
                  slti         gp, tp, -1791
                  sub          s11, t4, a3
                  rem          s6, a2, t4
                  srl          gp, a7, s6
                  sltiu        a1, s4, 1988
                  slli         s4, a5, 26
                  mulh         s11, s9, gp
                  c.and        s0, a3
                  c.andi       a0, -1
                  c.addi16sp   sp, 400
                  ori          s6, t3, 246
                  addi         s8, s2, 596
                  auipc        a4, 881820
                  sll          s8, a6, a2
                  add          s6, s2, s10
                  mulhsu       a7, s0, t4
                  sub          s11, t4, a3
                  li           sp, 0x0 #start riscv_int_numeric_corner_stream_29
                  li           s0, 0x0
                  li           s6, 0xffffffff
                  li           s11, 0x0
                  li           s5, 0x0
                  li           t6, 0x0
                  li           s10, 0x80000000
                  li           a2, 0x7c527eed
                  li           s8, 0x80000000
                  li           t2, 0xffffffff
                  mulh         s11, t6, a2
                  divu         s10, s0, t6
                  auipc        s11, 881820
                  lui          s8, 776121
                  divu         s10, s0, t6
                  mulhsu       sp, s11, s0
                  mul          s0, s8, s8
                  add          s5, s0, t2
                  auipc        s11, 881820
                  lui          s8, 776121
                  divu         s10, s0, t6
                  remu         s5, s11, s0
                  add          s5, s0, t2
                  auipc        s11, 881820
                  mulh         s11, t6, a2
                  remu         s5, s11, s0
                  mulh         s11, t6, a2
                  div          s10, s10, s11
                  mul          s0, s8, s8
                  mulhsu       sp, s11, s0
                  remu         s5, s11, s0
                  mulhsu       sp, s11, s0
                  add          s5, s0, t2
                  remu         s5, s11, s0
                  rem          s5, sp, s8
                  div          s10, s10, s11
                  mulhsu       sp, s11, s0 #end riscv_int_numeric_corner_stream_29
                  c.or         a2, a5
                  c.addi       t4, 20
                  div          s0, t2, a0
                  divu         s10, sp, s1
                  auipc        a4, 881820
                  c.xor        s0, a5
                  c.add        t2, s3
                  c.mv         s8, a5
                  or           a4, s7, s8
                  srl          gp, a7, s6
                  c.add        t2, s3
                  c.lui        s8, 31
                  c.srai       a2, 4
                  andi         t0, s11, 1760
                  c.xor        s0, a5
                  c.li         a0, 21
                  sra          s8, a5, s8
                  c.addi       t4, 20
                  div          s0, t2, a0
                  xori         a3, s3, -1008
                  slti         gp, tp, -1791
                  c.or         a2, a5
                  div          s0, t2, a0
                  or           a4, s7, s8
                  remu         s6, a4, s2
                  slt          t4, s3, s11
                  sll          s8, a6, a2
                  c.nop
                  andi         t0, s11, 1760
                  c.addi16sp   sp, 400
                  c.sub        a3, s1
                  auipc        a4, 881820
                  c.srai       a2, 4
                  sub          s11, t4, a3
                  c.xor        s0, a5
                  c.andi       a0, -1
                  c.xor        s0, a5
                  mul          a1, s6, s6
                  addi         s8, s2, 596
                  srl          gp, a7, s6
                  c.and        s0, a3
                  andi         t0, s11, 1760
                  mulhsu       a7, s0, t4
                  c.lui        s8, 31
                  sltiu        a1, s4, 1988
                  slti         gp, tp, -1791
                  auipc        a4, 881820
                  divu         s10, sp, s1
                  add          s6, s2, s10
                  xori         a3, s3, -1008
                  mulhsu       a7, s0, t4
                  div          s0, t2, a0
                  srli         sp, s3, 10
                  srl          gp, a7, s6
                  nop
                  c.lui        s8, 31
                  c.li         a0, 21
                  c.and        s0, a3
                  c.or         a2, a5
                  c.add        t2, s3
                  slli         s4, a5, 26
                  ori          s6, t3, 246
                  add          s6, s2, s10
                  c.addi16sp   sp, 400
                  or           a4, s7, s8
                  mulhu        t2, s5, t5
                  c.or         a2, a5
                  andi         t0, s11, 1760
                  c.andi       a0, -1
                  c.li         a0, 21
                  divu         s10, sp, s1
                  srai         t0, t0, 4
                  srl          gp, a7, s6
                  ori          s6, t3, 246
                  srai         t0, t0, 4
                  mul          a1, s6, s6
                  remu         s6, a4, s2
                  lui          t2, 776121
                  c.mv         s8, a5
                  auipc        a4, 881820
                  c.nop
                  c.nop
                  c.xor        s0, a5
                  xor          a4, s11, s7
                  c.slli       s11, 17
                  sub          s11, t4, a3
                  c.or         a2, a5
                  li           a1, 0x0 #start riscv_int_numeric_corner_stream_12
                  li           sp, 0x0
                  li           t3, 0x80000000
                  li           s9, 0x5e0e1fc0
                  li           a4, 0x80000000
                  li           t6, 0x0
                  li           s0, 0x80000000
                  li           ra, 0x0
                  li           s4, 0x0
                  li           a6, 0x0
                  auipc        t3, 881820
                  addi         a6, s0, 596
                  mulhsu       ra, t3, s0
                  nop
                  lui          s4, 776121
                  rem          a4, ra, s4
                  sub          t3, s9, a4
                  rem          a4, ra, s4
                  addi         a6, s0, 596
                  mulhsu       ra, t3, s0
                  addi         a6, s0, 596
                  nop
                  add          a4, s0, sp
                  addi         a6, s0, 596
                  mulhu        s4, a6, a1
                  div          s9, s9, t3
                  add          a4, s0, sp
                  mulhu        s4, a6, a1 #end riscv_int_numeric_corner_stream_12
                  srli         sp, s3, 10
                  c.srli       a0, 28
                  nop
                  c.addi       t4, 20
                  mulhsu       a7, s0, t4
                  sll          s8, a6, a2
                  sra          s8, a5, s8
                  c.mv         s8, a5
                  c.mv         s8, a5
                  nop
                  addi         s8, s2, 596
                  slt          t4, s3, s11
                  srli         sp, s3, 10
                  mulh         s11, s9, gp
                  srl          gp, a7, s6
                  c.nop
                  add          s6, s2, s10
                  rem          s6, a2, t4
                  divu         s10, sp, s1
                  mul          a1, s6, s6
                  divu         s10, sp, s1
                  c.or         a2, a5
                  c.nop
                  c.addi4spn   s1, sp, 32
                  sltiu        a1, s4, 1988
                  sub          s11, t4, a3
                  nop
                  c.and        s0, a3
                  c.and        s0, a3
                  slt          t4, s3, s11
                  c.lui        s8, 31
                  c.li         a0, 21
                  mulh         s11, s9, gp
                  c.or         a2, a5
                  div          s0, t2, a0
                  mul          a1, s6, s6
                  ori          s6, t3, 246
                  c.addi16sp   sp, 400
                  xori         a3, s3, -1008
                  c.xor        s0, a5
                  slli         s4, a5, 26
                  srl          gp, a7, s6
                  c.mv         s8, a5
                  c.nop
                  c.addi       t4, 20
                  add          s6, s2, s10
                  mulh         s11, s9, gp
                  slt          t4, s3, s11
                  c.addi       t4, 20
                  xor          a4, s11, s7
                  and          t5, t0, a7
                  add          s6, s2, s10
                  ori          s6, t3, 246
                  mulh         s11, s9, gp
                  c.mv         s8, a5
                  sltu         s8, s9, s11
                  mul          a1, s6, s6
                  xori         a3, s3, -1008
                  auipc        a4, 881820
                  sltiu        a1, s4, 1988
                  and          t5, t0, a7
                  and          t5, t0, a7
                  andi         t0, s11, 1760
                  ori          s6, t3, 246
                  c.and        s0, a3
                  lui          t2, 776121
                  c.mv         s8, a5
                  srai         t0, t0, 4
                  c.mv         s8, a5
                  slli         s4, a5, 26
                  c.andi       a0, -1
                  nop
                  ori          s6, t3, 246
                  slt          t4, s3, s11
                  addi         s8, s2, 596
                  rem          s6, a2, t4
                  nop
                  nop
                  ori          s6, t3, 246
                  sub          s11, t4, a3
                  slli         s4, a5, 26
                  remu         s6, a4, s2
                  xor          a4, s11, s7
                  c.mv         s8, a5
                  nop
                  slti         gp, tp, -1791
                  c.slli       s11, 17
                  sra          s8, a5, s8
                  mulhsu       a7, s0, t4
                  c.andi       a0, -1
                  c.and        s0, a3
                  c.and        s0, a3
                  xor          a4, s11, s7
                  slt          t4, s3, s11
                  c.or         a2, a5
                  sltu         s8, s9, s11
                  or           a4, s7, s8
                  nop
                  slt          t4, s3, s11
                  div          s0, t2, a0
                  div          s0, t2, a0
                  div          s0, t2, a0
                  and          t5, t0, a7
                  c.srai       a2, 4
                  slli         s4, a5, 26
                  c.slli       s11, 17
                  lui          t2, 776121
                  c.or         a2, a5
                  remu         s6, a4, s2
                  div          s0, t2, a0
                  sltu         s8, s9, s11
                  sltiu        a1, s4, 1988
                  xori         a3, s3, -1008
                  srai         t0, t0, 4
                  c.andi       a0, -1
                  c.xor        s0, a5
                  addi         s8, s2, 596
                  sltu         s8, s9, s11
                  slti         gp, tp, -1791
                  addi         s8, s2, 596
                  c.or         a2, a5
                  sltu         s8, s9, s11
                  c.slli       s11, 17
                  lui          t2, 776121
                  rem          s6, a2, t4
                  andi         t0, s11, 1760
                  mulhsu       a7, s0, t4
                  c.nop
                  mul          a1, s6, s6
                  divu         s10, sp, s1
                  and          t5, t0, a7
                  remu         s6, a4, s2
                  sll          s8, a6, a2
                  c.li         a0, 21
                  c.addi16sp   sp, 400
                  xor          a4, s11, s7
                  c.sub        a3, s1
                  c.nop
                  c.add        t2, s3
                  c.lui        s8, 31
                  c.add        t2, s3
                  c.nop
                  and          t5, t0, a7
                  slli         s4, a5, 26
                  slt          t4, s3, s11
                  c.nop
                  nop
                  sltu         s8, s9, s11
                  c.srli       a0, 28
                  rem          s6, a2, t4
                  slt          t4, s3, s11
                  c.lui        s8, 31
                  rem          s6, a2, t4
                  div          s0, t2, a0
                  c.slli       s11, 17
                  c.and        s0, a3
                  c.add        t2, s3
                  sltiu        a1, s4, 1988
                  mul          a1, s6, s6
                  slli         s4, a5, 26
                  xor          a4, s11, s7
                  sub          s11, t4, a3
                  c.sub        a3, s1
                  remu         s6, a4, s2
                  srli         sp, s3, 10
                  c.srai       a2, 4
                  c.srli       a0, 28
                  sub          s11, t4, a3
                  srli         sp, s3, 10
                  c.slli       s11, 17
                  c.li         a0, 21
                  c.andi       a0, -1
                  c.addi       t4, 20
                  c.srli       a0, 28
                  slt          t4, s3, s11
                  li           a5, 0xffa68e78 #start riscv_int_numeric_corner_stream_27
                  li           a6, 0x0
                  li           tp, 0xffffffff
                  li           a3, 0x80000000
                  li           a2, 0xffffffff
                  li           a7, 0xffffffff
                  li           s1, 0x0
                  li           t0, 0x1947c0ab
                  li           s4, 0xadb1c865
                  li           s11, 0x80000000
                  div          a7, a7, s4
                  lui          a6, 776121
                  rem          a3, tp, a6
                  divu         a7, s1, s11
                  add          a3, s1, t0
                  add          a3, s1, t0
                  sub          s4, a7, a3
                  addi         a5, s1, 596
                  add          a3, s1, t0
                  sub          s4, a7, a3
                  mulhu        a6, a5, a2
                  mul          s1, a6, a6
                  lui          a6, 776121
                  nop
                  mulh         s4, s11, a2
                  sub          s4, a7, a3
                  mul          s1, a6, a6
                  mulh         s4, s11, a2
                  div          a7, a7, s4
                  sub          s4, a7, a3
                  mulhu        a6, a5, a2
                  add          a3, s1, t0
                  add          a3, s1, t0
                  add          a3, s1, t0
                  divu         a7, s1, s11
                  divu         a7, s1, s11
                  remu         a3, s4, s1
                  rem          a3, tp, a6
                  rem          a3, tp, a6 #end riscv_int_numeric_corner_stream_27
                  c.srli       a0, 28
                  mulh         s11, s9, gp
                  c.add        t2, s3
                  c.mv         s8, a5
                  addi         s8, s2, 596
                  srai         t0, t0, 4
                  xor          a4, s11, s7
                  or           a4, s7, s8
                  divu         s10, sp, s1
                  c.and        s0, a3
                  c.srai       a2, 4
                  div          s0, t2, a0
                  c.srai       a2, 4
                  rem          s6, a2, t4
                  remu         s6, a4, s2
                  xor          a4, s11, s7
                  nop
                  slli         s4, a5, 26
                  srai         t0, t0, 4
                  sra          s8, a5, s8
                  c.nop
                  mul          a1, s6, s6
                  c.and        s0, a3
                  divu         s10, sp, s1
                  addi         s8, s2, 596
                  mul          a1, s6, s6
                  xor          a4, s11, s7
                  slli         s4, a5, 26
                  sra          s8, a5, s8
                  div          s0, t2, a0
                  c.sub        a3, s1
                  mulhsu       a7, s0, t4
                  and          t5, t0, a7
                  slt          t4, s3, s11
                  c.andi       a0, -1
                  c.nop
                  c.srai       a2, 4
                  and          t5, t0, a7
                  c.addi16sp   sp, 400
                  add          s6, s2, s10
                  c.slli       s11, 17
                  mulh         s11, s9, gp
                  c.sub        a3, s1
                  c.and        s0, a3
                  andi         t0, s11, 1760
                  c.addi16sp   sp, 400
                  mulh         s11, s9, gp
                  div          s0, t2, a0
                  c.sub        a3, s1
                  c.xor        s0, a5
                  srl          gp, a7, s6
                  ori          s6, t3, 246
                  c.and        s0, a3
                  c.addi4spn   s1, sp, 32
                  c.srli       a0, 28
                  nop
                  slti         gp, tp, -1791
                  slli         s4, a5, 26
                  addi         s8, s2, 596
                  slt          t4, s3, s11
                  xori         a3, s3, -1008
                  sub          s11, t4, a3
                  mul          a1, s6, s6
                  sltu         s8, s9, s11
                  andi         t0, s11, 1760
                  slt          t4, s3, s11
                  add          s6, s2, s10
                  c.nop
                  and          t5, t0, a7
                  sra          s8, a5, s8
                  srai         t0, t0, 4
                  c.addi4spn   s1, sp, 32
                  c.add        t2, s3
                  slli         s4, a5, 26
                  c.add        t2, s3
                  sltiu        a1, s4, 1988
                  c.sub        a3, s1
                  ori          s6, t3, 246
                  sll          s8, a6, a2
                  c.mv         s8, a5
                  c.add        t2, s3
                  c.srai       a2, 4
                  auipc        a4, 881820
                  mulhu        t2, s5, t5
                  slti         gp, tp, -1791
                  mulh         s11, s9, gp
                  c.nop
                  and          t5, t0, a7
                  c.and        s0, a3
                  c.srli       a0, 28
                  c.addi4spn   s1, sp, 32
                  c.and        s0, a3
                  xori         a3, s3, -1008
                  c.andi       a0, -1
                  c.slli       s11, 17
                  lui          t2, 776121
                  divu         s10, sp, s1
                  xori         a3, s3, -1008
                  c.addi16sp   sp, 400
                  srai         t0, t0, 4
                  auipc        a4, 881820
                  addi         s8, s2, 596
                  and          t5, t0, a7
                  sub          s11, t4, a3
                  c.mv         s8, a5
                  c.or         a2, a5
                  mulhsu       a7, s0, t4
                  mulhu        t2, s5, t5
                  c.addi       t4, 20
                  auipc        a4, 881820
                  mulh         s11, s9, gp
                  slt          t4, s3, s11
                  mulhsu       a7, s0, t4
                  xor          a4, s11, s7
                  c.li         a0, 21
                  nop
                  c.addi       t4, 20
                  andi         t0, s11, 1760
                  c.li         a0, 21
                  srli         sp, s3, 10
                  slt          t4, s3, s11
                  sub          s11, t4, a3
                  mul          a1, s6, s6
                  remu         s6, a4, s2
                  xori         a3, s3, -1008
                  c.li         a0, 21
                  add          s6, s2, s10
                  add          s6, s2, s10
                  c.or         a2, a5
                  div          s0, t2, a0
                  c.addi16sp   sp, 400
                  mul          a1, s6, s6
                  c.slli       s11, 17
                  nop
                  slti         gp, tp, -1791
                  c.xor        s0, a5
                  c.li         a0, 21
                  c.addi       t4, 20
                  sub          s11, t4, a3
                  c.addi       t4, 20
                  slti         gp, tp, -1791
                  lui          t2, 776121
                  mulhsu       a7, s0, t4
                  c.li         a0, 21
                  c.xor        s0, a5
                  auipc        a4, 881820
                  slli         s4, a5, 26
                  rem          s6, a2, t4
                  c.addi       t4, 20
                  slt          t4, s3, s11
                  c.li         a0, 21
                  mulhsu       a7, s0, t4
                  c.slli       s11, 17
                  divu         s10, sp, s1
                  c.lui        s8, 31
                  and          t5, t0, a7
                  or           a4, s7, s8
                  c.srli       a0, 28
                  c.addi16sp   sp, 400
                  c.add        t2, s3
                  sub          s11, t4, a3
                  mulhsu       a7, s0, t4
                  c.slli       s11, 17
                  c.or         a2, a5
                  c.lui        s8, 31
                  sltu         s8, s9, s11
                  add          s6, s2, s10
                  c.addi16sp   sp, 400
                  srl          gp, a7, s6
                  sltiu        a1, s4, 1988
                  divu         s10, sp, s1
                  sll          s8, a6, a2
                  slti         gp, tp, -1791
                  remu         s6, a4, s2
                  and          t5, t0, a7
                  c.sub        a3, s1
                  c.nop
                  c.andi       a0, -1
                  sub          s11, t4, a3
                  remu         s6, a4, s2
                  c.srli       a0, 28
                  c.xor        s0, a5
                  sll          s8, a6, a2
                  c.srli       a0, 28
                  andi         t0, s11, 1760
                  slli         s4, a5, 26
                  auipc        a4, 881820
                  xor          a4, s11, s7
                  c.xor        s0, a5
                  andi         t0, s11, 1760
                  c.addi16sp   sp, 400
                  c.srli       a0, 28
                  c.and        s0, a3
                  c.xor        s0, a5
                  sltu         s8, s9, s11
                  addi         s8, s2, 596
                  c.add        t2, s3
                  mulhu        t2, s5, t5
                  sll          s8, a6, a2
                  c.lui        s8, 31
                  rem          s6, a2, t4
                  mul          a1, s6, s6
                  mul          a1, s6, s6
                  srli         sp, s3, 10
                  auipc        a4, 881820
                  div          s0, t2, a0
                  c.sub        a3, s1
                  c.xor        s0, a5
                  c.andi       a0, -1
                  c.addi4spn   s1, sp, 32
                  mulhsu       a7, s0, t4
                  c.andi       a0, -1
                  c.sub        a3, s1
                  c.slli       s11, 17
                  c.addi       t4, 20
                  add          s6, s2, s10
                  srl          gp, a7, s6
                  divu         s10, sp, s1
                  srl          gp, a7, s6
                  mulhsu       a7, s0, t4
                  sll          s8, a6, a2
                  remu         s6, a4, s2
                  c.lui        s8, 31
                  srl          gp, a7, s6
                  sra          s8, a5, s8
                  c.addi16sp   sp, 400
                  srl          gp, a7, s6
                  andi         t0, s11, 1760
                  c.or         a2, a5
                  c.li         a0, 21
                  slti         gp, tp, -1791
                  slti         gp, tp, -1791
                  slt          t4, s3, s11
                  c.slli       s11, 17
                  c.srli       a0, 28
                  lui          t2, 776121
                  ori          s6, t3, 246
                  divu         s10, sp, s1
                  mul          a1, s6, s6
                  sltu         s8, s9, s11
                  c.mv         s8, a5
                  srli         sp, s3, 10
                  remu         s6, a4, s2
                  rem          s6, a2, t4
                  c.srli       a0, 28
                  c.add        t2, s3
                  slli         s4, a5, 26
                  srl          gp, a7, s6
                  mulhu        t2, s5, t5
                  mulhsu       a7, s0, t4
                  c.li         a0, 21
                  or           a4, s7, s8
                  andi         t0, s11, 1760
                  or           a4, s7, s8
                  rem          s6, a2, t4
                  slli         s4, a5, 26
                  lui          t2, 776121
                  xor          a4, s11, s7
                  remu         s6, a4, s2
                  xori         a3, s3, -1008
                  c.and        s0, a3
                  addi         s8, s2, 596
                  or           a4, s7, s8
                  add          s6, s2, s10
                  xori         a3, s3, -1008
                  or           a4, s7, s8
                  c.lui        s8, 31
                  c.li         a0, 21
                  ori          s6, t3, 246
                  c.addi16sp   sp, 400
                  remu         s6, a4, s2
                  lui          t2, 776121
                  divu         s10, sp, s1
                  c.nop
                  c.or         a2, a5
                  c.addi4spn   s1, sp, 32
                  sltiu        a1, s4, 1988
                  c.add        t2, s3
                  c.addi4spn   s1, sp, 32
                  sra          s8, a5, s8
                  c.andi       a0, -1
                  srl          gp, a7, s6
                  c.slli       s11, 17
                  nop
                  c.li         a0, 21
                  c.nop
                  remu         s6, a4, s2
                  sltiu        a1, s4, 1988
                  srl          gp, a7, s6
                  mulhu        t2, s5, t5
                  c.xor        s0, a5
                  slt          t4, s3, s11
                  c.addi16sp   sp, 400
                  mul          a1, s6, s6
                  c.nop
                  c.srai       a2, 4
                  c.or         a2, a5
                  c.addi4spn   s1, sp, 32
                  slli         s4, a5, 26
                  c.li         a0, 21
                  c.srli       a0, 28
                  andi         t0, s11, 1760
                  c.srai       a2, 4
                  and          t5, t0, a7
                  mulh         s11, s9, gp
                  c.addi16sp   sp, 400
                  c.nop
                  addi         s8, s2, 596
                  auipc        a4, 881820
                  rem          s6, a2, t4
                  slti         gp, tp, -1791
                  remu         s6, a4, s2
                  c.or         a2, a5
                  c.slli       s11, 17
                  mul          a1, s6, s6
                  c.xor        s0, a5
                  c.slli       s11, 17
                  sub          s11, t4, a3
                  div          s0, t2, a0
                  c.and        s0, a3
                  srl          gp, a7, s6
                  sra          s8, a5, s8
                  c.nop
                  addi         s8, s2, 596
                  c.li         a0, 21
                  sll          s8, a6, a2
                  c.srai       a2, 4
                  and          t5, t0, a7
                  add          s6, s2, s10
                  c.sub        a3, s1
                  slti         gp, tp, -1791
                  auipc        a4, 881820
                  remu         s6, a4, s2
                  c.mv         s8, a5
                  sra          s8, a5, s8
                  slli         s4, a5, 26
                  srl          gp, a7, s6
                  c.andi       a0, -1
                  add          s6, s2, s10
                  ori          s6, t3, 246
                  mulhsu       a7, s0, t4
                  addi         s8, s2, 596
                  xor          a4, s11, s7
                  c.or         a2, a5
                  c.andi       a0, -1
                  or           a4, s7, s8
                  andi         t0, s11, 1760
                  mulhu        t2, s5, t5
                  slt          t4, s3, s11
                  and          t5, t0, a7
                  c.mv         s8, a5
                  slt          t4, s3, s11
                  c.or         a2, a5
                  c.add        t2, s3
                  slti         gp, tp, -1791
                  mulhu        t2, s5, t5
                  c.li         a0, 21
                  c.and        s0, a3
                  mulhu        t2, s5, t5
                  mulhu        t2, s5, t5
                  divu         s10, sp, s1
                  auipc        a4, 881820
                  li           gp, 0xffffffff #start riscv_int_numeric_corner_stream_39
                  li           s11, 0x80000000
                  li           t6, 0xffffffff
                  li           a2, 0x0
                  li           a5, 0x6e40ff66
                  li           s2, 0xf80f59f4
                  li           t4, 0x7f49efad
                  li           t5, 0x80000000
                  li           s0, 0x3bcc6c95
                  li           a4, 0x80000000
                  mulhsu       gp, t5, a2
                  lui          s11, 776121
                  rem          a5, gp, s11
                  add          a5, a2, s0
                  div          t4, t4, t5
                  rem          a5, gp, s11
                  nop
                  auipc        t5, 881820
                  auipc        t5, 881820
                  rem          a5, gp, s11
                  mulhsu       gp, t5, a2
                  remu         a5, t5, a2
                  lui          s11, 776121
                  nop
                  divu         t4, a2, t6
                  add          a5, a2, s0
                  remu         a5, t5, a2
                  divu         t4, a2, t6
                  addi         s2, a2, 596
                  add          a5, a2, s0
                  nop
                  rem          a5, gp, s11
                  remu         a5, t5, a2
                  add          a5, a2, s0
                  lui          s11, 776121
                  nop
                  divu         t4, a2, t6
                  add          a5, a2, s0
                  add          a5, a2, s0
                  rem          a5, gp, s11 #end riscv_int_numeric_corner_stream_39
                  c.or         a2, a5
                  c.addi16sp   sp, 400
                  c.slli       s11, 17
                  c.li         a0, 21
                  andi         t0, s11, 1760
                  c.mv         s8, a5
                  mulh         s11, s9, gp
                  or           a4, s7, s8
                  or           a4, s7, s8
                  c.xor        s0, a5
                  sub          s11, t4, a3
                  srai         t0, t0, 4
                  mul          a1, s6, s6
                  c.add        t2, s3
                  li           tp, 0xffffffff #start riscv_int_numeric_corner_stream_32
                  li           gp, 0x8bf58ff2
                  li           s2, 0xffffffff
                  li           s8, 0xa305d683
                  li           s6, 0xffffffff
                  li           s10, 0x0
                  li           a5, 0x80000000
                  li           t0, 0xffffffff
                  li           t6, 0x8d4afcad
                  li           a2, 0x0
                  mulhu        s6, s2, a2
                  divu         s8, t0, t6
                  addi         s2, t0, 596
                  div          s8, s8, s10
                  rem          a5, gp, s6
                  nop
                  sub          s10, s8, a5
                  remu         a5, s10, t0
                  divu         s8, t0, t6
                  rem          a5, gp, s6
                  add          a5, t0, tp
                  mulh         s10, t6, a2
                  lui          s6, 776121
                  mulhsu       gp, s10, t0
                  nop
                  nop
                  lui          s6, 776121
                  sub          s10, s8, a5
                  mulhsu       gp, s10, t0
                  addi         s2, t0, 596
                  nop
                  mulh         s10, t6, a2
                  rem          a5, gp, s6
                  rem          a5, gp, s6
                  mulhu        s6, s2, a2
                  lui          s6, 776121
                  sub          s10, s8, a5
                  nop
                  lui          s6, 776121
                  mulh         s10, t6, a2 #end riscv_int_numeric_corner_stream_32
                  c.lui        s8, 31
                  c.lui        s8, 31
                  c.andi       a0, -1
                  c.li         a0, 21
                  c.xor        s0, a5
                  ori          s6, t3, 246
                  mulhsu       a7, s0, t4
                  sub          s11, t4, a3
                  c.sub        a3, s1
                  c.sub        a3, s1
                  c.xor        s0, a5
                  xor          a4, s11, s7
                  srli         sp, s3, 10
                  addi         s8, s2, 596
                  lui          t2, 776121
                  c.andi       a0, -1
                  c.sub        a3, s1
                  c.srli       a0, 28
                  c.slli       s11, 17
                  sltiu        a1, s4, 1988
                  c.addi4spn   s1, sp, 32
                  c.andi       a0, -1
                  c.addi       t4, 20
                  c.addi16sp   sp, 400
                  nop
                  sub          s11, t4, a3
                  c.srai       a2, 4
                  xor          a4, s11, s7
                  mulhsu       a7, s0, t4
                  rem          s6, a2, t4
                  srl          gp, a7, s6
                  c.add        t2, s3
                  mulhu        t2, s5, t5
                  divu         s10, sp, s1
                  addi         s8, s2, 596
                  c.andi       a0, -1
                  c.slli       s11, 17
                  c.nop
                  c.sub        a3, s1
                  mulhsu       a7, s0, t4
                  remu         s6, a4, s2
                  auipc        a4, 881820
                  and          t5, t0, a7
                  divu         s10, sp, s1
                  sltiu        a1, s4, 1988
                  c.nop
                  or           a4, s7, s8
                  mulhu        t2, s5, t5
                  mul          a1, s6, s6
                  sub          s11, t4, a3
                  addi         s8, s2, 596
                  divu         s10, sp, s1
                  add          s6, s2, s10
                  srai         t0, t0, 4
                  c.sub        a3, s1
                  c.addi16sp   sp, 400
                  or           a4, s7, s8
                  c.xor        s0, a5
                  andi         t0, s11, 1760
                  sltu         s8, s9, s11
                  lui          t2, 776121
                  slti         gp, tp, -1791
                  c.andi       a0, -1
                  c.xor        s0, a5
                  c.lui        s8, 31
                  sltu         s8, s9, s11
                  c.andi       a0, -1
                  c.addi16sp   sp, 400
                  nop
                  slt          t4, s3, s11
                  rem          s6, a2, t4
                  sltu         s8, s9, s11
                  mul          a1, s6, s6
                  slti         gp, tp, -1791
                  ori          s6, t3, 246
                  add          s6, s2, s10
                  c.addi16sp   sp, 400
                  c.xor        s0, a5
                  auipc        a4, 881820
                  sll          s8, a6, a2
                  c.nop
                  xor          a4, s11, s7
                  sub          s11, t4, a3
                  slti         gp, tp, -1791
                  xori         a3, s3, -1008
                  xori         a3, s3, -1008
                  andi         t0, s11, 1760
                  sll          s8, a6, a2
                  or           a4, s7, s8
                  and          t5, t0, a7
                  divu         s10, sp, s1
                  c.and        s0, a3
                  ori          s6, t3, 246
                  c.add        t2, s3
                  sra          s8, a5, s8
                  c.sub        a3, s1
                  and          t5, t0, a7
                  c.addi       t4, 20
                  div          s0, t2, a0
                  sub          s11, t4, a3
                  c.lui        s8, 31
                  remu         s6, a4, s2
                  slt          t4, s3, s11
                  rem          s6, a2, t4
                  xor          a4, s11, s7
                  sra          s8, a5, s8
                  lui          t2, 776121
                  slt          t4, s3, s11
                  sll          s8, a6, a2
                  srli         sp, s3, 10
                  or           a4, s7, s8
                  slt          t4, s3, s11
                  sltu         s8, s9, s11
                  lui          t2, 776121
                  c.sub        a3, s1
                  c.srai       a2, 4
                  mulhsu       a7, s0, t4
                  and          t5, t0, a7
                  sub          s11, t4, a3
                  c.mv         s8, a5
                  c.sub        a3, s1
                  or           a4, s7, s8
                  sub          s11, t4, a3
                  srai         t0, t0, 4
                  remu         s6, a4, s2
                  c.addi4spn   s1, sp, 32
                  c.nop
                  xor          a4, s11, s7
                  addi         s8, s2, 596
                  c.or         a2, a5
                  slti         gp, tp, -1791
                  c.add        t2, s3
                  add          s6, s2, s10
                  c.srli       a0, 28
                  sra          s8, a5, s8
                  c.srli       a0, 28
                  c.srli       a0, 28
                  srl          gp, a7, s6
                  srli         sp, s3, 10
                  c.addi4spn   s1, sp, 32
                  slt          t4, s3, s11
                  mul          a1, s6, s6
                  c.slli       s11, 17
                  mul          a1, s6, s6
                  ori          s6, t3, 246
                  andi         t0, s11, 1760
                  andi         t0, s11, 1760
                  lui          t2, 776121
                  mulhu        t2, s5, t5
                  and          t5, t0, a7
                  nop
                  slt          t4, s3, s11
                  xor          a4, s11, s7
                  c.andi       a0, -1
                  or           a4, s7, s8
                  sub          s11, t4, a3
                  c.mv         s8, a5
                  c.mv         s8, a5
                  c.lui        s8, 31
                  c.add        t2, s3
                  sltu         s8, s9, s11
                  sll          s8, a6, a2
                  c.sub        a3, s1
                  ori          s6, t3, 246
                  srai         t0, t0, 4
                  c.or         a2, a5
                  sltu         s8, s9, s11
                  remu         s6, a4, s2
                  xor          a4, s11, s7
                  mul          a1, s6, s6
                  c.nop
                  remu         s6, a4, s2
                  nop
                  srl          gp, a7, s6
                  c.sub        a3, s1
                  slli         s4, a5, 26
                  auipc        a4, 881820
                  c.lui        s8, 31
                  c.nop
                  xori         a3, s3, -1008
                  c.mv         s8, a5
                  mulhu        t2, s5, t5
                  xori         a3, s3, -1008
                  slli         s4, a5, 26
                  remu         s6, a4, s2
                  xori         a3, s3, -1008
                  srl          gp, a7, s6
                  c.mv         s8, a5
                  rem          s6, a2, t4
                  add          s6, s2, s10
                  slli         s4, a5, 26
                  c.lui        s8, 31
                  slt          t4, s3, s11
                  xori         a3, s3, -1008
                  c.addi       t4, 20
                  rem          s6, a2, t4
                  xori         a3, s3, -1008
                  add          s6, s2, s10
                  or           a4, s7, s8
                  xori         a3, s3, -1008
                  c.srai       a2, 4
                  c.li         a0, 21
                  sll          s8, a6, a2
                  addi         s8, s2, 596
                  srai         t0, t0, 4
                  c.add        t2, s3
                  c.and        s0, a3
                  sra          s8, a5, s8
                  srl          gp, a7, s6
                  auipc        a4, 881820
                  mul          a1, s6, s6
                  c.srli       a0, 28
                  xor          a4, s11, s7
                  sltiu        a1, s4, 1988
                  c.lui        s8, 31
                  slti         gp, tp, -1791
                  div          s0, t2, a0
                  ori          s6, t3, 246
                  slti         gp, tp, -1791
                  c.sub        a3, s1
                  remu         s6, a4, s2
                  addi         s8, s2, 596
                  sub          s11, t4, a3
                  slt          t4, s3, s11
                  srl          gp, a7, s6
                  divu         s10, sp, s1
                  remu         s6, a4, s2
                  srl          gp, a7, s6
                  srl          gp, a7, s6
                  srl          gp, a7, s6
                  xor          a4, s11, s7
                  sra          s8, a5, s8
                  c.sub        a3, s1
                  c.add        t2, s3
                  srai         t0, t0, 4
                  lui          t2, 776121
                  c.sub        a3, s1
                  slli         s4, a5, 26
                  ori          s6, t3, 246
                  div          s0, t2, a0
                  c.lui        s8, 31
                  remu         s6, a4, s2
                  c.sub        a3, s1
                  slli         s4, a5, 26
                  srli         sp, s3, 10
                  c.srli       a0, 28
                  mul          a1, s6, s6
                  srai         t0, t0, 4
                  mulhsu       a7, s0, t4
                  nop
                  addi         s8, s2, 596
                  andi         t0, s11, 1760
                  c.mv         s8, a5
                  c.addi16sp   sp, 400
                  c.xor        s0, a5
                  divu         s10, sp, s1
                  ori          s6, t3, 246
                  slli         s4, a5, 26
                  c.or         a2, a5
                  sltu         s8, s9, s11
                  sll          s8, a6, a2
                  slli         s4, a5, 26
                  srl          gp, a7, s6
                  andi         t0, s11, 1760
                  rem          s6, a2, t4
                  c.addi16sp   sp, 400
                  sltu         s8, s9, s11
                  srl          gp, a7, s6
                  c.and        s0, a3
                  or           a4, s7, s8
                  ori          s6, t3, 246
                  srai         t0, t0, 4
                  xori         a3, s3, -1008
                  sltu         s8, s9, s11
                  c.addi       t4, 20
                  nop
                  xori         a3, s3, -1008
                  ori          s6, t3, 246
                  srai         t0, t0, 4
                  c.sub        a3, s1
                  srli         sp, s3, 10
                  c.mv         s8, a5
                  add          s6, s2, s10
                  add          s6, s2, s10
                  c.li         a0, 21
                  slt          t4, s3, s11
                  c.addi       t4, 20
                  addi         s8, s2, 596
                  ori          s6, t3, 246
                  xori         a3, s3, -1008
                  c.srli       a0, 28
                  srai         t0, t0, 4
                  andi         t0, s11, 1760
                  c.slli       s11, 17
                  srl          gp, a7, s6
                  xori         a3, s3, -1008
                  xori         a3, s3, -1008
                  c.or         a2, a5
                  c.xor        s0, a5
                  c.lui        s8, 31
                  mulh         s11, s9, gp
                  srli         sp, s3, 10
                  srli         sp, s3, 10
                  xori         a3, s3, -1008
                  c.addi16sp   sp, 400
                  divu         s10, sp, s1
                  divu         s10, sp, s1
                  c.addi4spn   s1, sp, 32
                  c.srli       a0, 28
                  c.li         a0, 21
                  sltiu        a1, s4, 1988
                  andi         t0, s11, 1760
                  div          s0, t2, a0
                  and          t5, t0, a7
                  c.srai       a2, 4
                  mulh         s11, s9, gp
                  c.slli       s11, 17
                  srai         t0, t0, 4
                  xori         a3, s3, -1008
                  div          s0, t2, a0
                  c.addi16sp   sp, 400
                  add          s6, s2, s10
                  c.srai       a2, 4
                  c.addi16sp   sp, 400
                  c.or         a2, a5
                  c.and        s0, a3
                  c.srli       a0, 28
                  add          s6, s2, s10
                  c.addi       t4, 20
                  c.addi4spn   s1, sp, 32
                  andi         t0, s11, 1760
                  or           a4, s7, s8
                  div          s0, t2, a0
                  c.andi       a0, -1
                  li           t5, 0xa2b37ba9 #start riscv_int_numeric_corner_stream_16
                  li           tp, 0x0
                  li           t3, 0xffffffff
                  li           s4, 0x80000000
                  li           s9, 0x0
                  li           a5, 0x80000000
                  li           sp, 0x80000000
                  li           t6, 0x80000000
                  li           a7, 0x88bd06f4
                  li           s1, 0x0
                  mulhsu       sp, t5, s1
                  rem          a7, sp, s9
                  addi         s4, s1, 596
                  addi         s4, s1, 596
                  div          t3, t3, t5
                  rem          a7, sp, s9
                  mulhu        s9, s4, a5
                  mulhsu       sp, t5, s1
                  remu         a7, t5, s1
                  auipc        t5, 881820
                  mulhsu       sp, t5, s1
                  add          a7, s1, tp
                  remu         a7, t5, s1
                  divu         t3, s1, t6
                  divu         t3, s1, t6
                  sub          t5, t3, a7
                  div          t3, t3, t5
                  add          a7, s1, tp
                  remu         a7, t5, s1
                  addi         s4, s1, 596
                  divu         t3, s1, t6
                  sub          t5, t3, a7
                  addi         s4, s1, 596
                  divu         t3, s1, t6
                  div          t3, t3, t5 #end riscv_int_numeric_corner_stream_16
                  sltu         s8, s9, s11
                  c.and        s0, a3
                  c.nop
                  srl          gp, a7, s6
                  lui          t2, 776121
                  slt          t4, s3, s11
                  c.li         a0, 21
                  c.mv         s8, a5
                  sltu         s8, s9, s11
                  add          s6, s2, s10
                  and          t5, t0, a7
                  div          s0, t2, a0
                  or           a4, s7, s8
                  xor          a4, s11, s7
                  c.add        t2, s3
                  c.add        t2, s3
                  add          s6, s2, s10
                  sll          s8, a6, a2
                  div          s0, t2, a0
                  slli         s4, a5, 26
                  c.slli       s11, 17
                  addi         s8, s2, 596
                  or           a4, s7, s8
                  xor          a4, s11, s7
                  c.and        s0, a3
                  srli         sp, s3, 10
                  c.addi       t4, 20
                  sltu         s8, s9, s11
                  slli         s4, a5, 26
                  lui          t2, 776121
                  c.sub        a3, s1
                  mulhsu       a7, s0, t4
                  sltiu        a1, s4, 1988
                  c.and        s0, a3
                  sltiu        a1, s4, 1988
                  sra          s8, a5, s8
                  sra          s8, a5, s8
                  c.nop
                  srai         t0, t0, 4
                  c.mv         s8, a5
                  c.andi       a0, -1
                  slti         gp, tp, -1791
                  c.or         a2, a5
                  c.sub        a3, s1
                  c.li         a0, 21
                  sll          s8, a6, a2
                  slti         gp, tp, -1791
                  sltu         s8, s9, s11
                  c.mv         s8, a5
                  sll          s8, a6, a2
                  c.addi16sp   sp, 400
                  c.sub        a3, s1
                  c.addi16sp   sp, 400
                  c.lui        s8, 31
                  srli         sp, s3, 10
                  addi         s8, s2, 596
                  and          t5, t0, a7
                  and          t5, t0, a7
                  and          t5, t0, a7
                  c.srli       a0, 28
                  addi         s8, s2, 596
                  mulhsu       a7, s0, t4
                  sub          s11, t4, a3
                  slti         gp, tp, -1791
                  addi         s8, s2, 596
                  c.li         a0, 21
                  c.sub        a3, s1
                  c.addi       t4, 20
                  auipc        a4, 881820
                  srl          gp, a7, s6
                  c.addi4spn   s1, sp, 32
                  c.or         a2, a5
                  c.and        s0, a3
                  sltu         s8, s9, s11
                  c.slli       s11, 17
                  ori          s6, t3, 246
                  add          s6, s2, s10
                  c.nop
                  add          s6, s2, s10
                  lui          t2, 776121
                  c.mv         s8, a5
                  c.srai       a2, 4
                  c.nop
                  xor          a4, s11, s7
                  c.lui        s8, 31
                  xor          a4, s11, s7
                  c.nop
                  c.srai       a2, 4
                  xor          a4, s11, s7
                  mulh         s11, s9, gp
                  div          s0, t2, a0
                  c.srai       a2, 4
                  addi         s8, s2, 596
                  andi         t0, s11, 1760
                  or           a4, s7, s8
                  c.and        s0, a3
                  c.mv         s8, a5
                  ori          s6, t3, 246
                  mulhu        t2, s5, t5
                  rem          s6, a2, t4
                  c.mv         s8, a5
                  add          s6, s2, s10
                  sltu         s8, s9, s11
                  sub          s11, t4, a3
                  c.mv         s8, a5
                  xori         a3, s3, -1008
                  divu         s10, sp, s1
                  c.li         a0, 21
                  c.srli       a0, 28
                  sll          s8, a6, a2
                  sub          s11, t4, a3
                  rem          s6, a2, t4
                  c.srli       a0, 28
                  c.lui        s8, 31
                  nop
                  slt          t4, s3, s11
                  c.addi       t4, 20
                  c.or         a2, a5
                  remu         s6, a4, s2
                  or           a4, s7, s8
                  sltiu        a1, s4, 1988
                  c.addi16sp   sp, 400
                  nop
                  c.xor        s0, a5
                  c.addi       t4, 20
                  and          t5, t0, a7
                  xori         a3, s3, -1008
                  srli         sp, s3, 10
                  sra          s8, a5, s8
                  c.mv         s8, a5
                  andi         t0, s11, 1760
                  divu         s10, sp, s1
                  and          t5, t0, a7
                  mul          a1, s6, s6
                  c.nop
                  or           a4, s7, s8
                  sltu         s8, s9, s11
                  xor          a4, s11, s7
                  or           a4, s7, s8
                  c.mv         s8, a5
                  c.add        t2, s3
                  rem          s6, a2, t4
                  slti         gp, tp, -1791
                  c.andi       a0, -1
                  c.andi       a0, -1
                  c.or         a2, a5
                  div          s0, t2, a0
                  or           a4, s7, s8
                  c.slli       s11, 17
                  c.or         a2, a5
                  divu         s10, sp, s1
                  c.slli       s11, 17
                  auipc        a4, 881820
                  sltu         s8, s9, s11
                  sll          s8, a6, a2
                  mulh         s11, s9, gp
                  lui          t2, 776121
                  c.andi       a0, -1
                  mulhu        t2, s5, t5
                  xor          a4, s11, s7
                  c.addi4spn   s1, sp, 32
                  xori         a3, s3, -1008
                  divu         s10, sp, s1
                  xor          a4, s11, s7
                  sub          s11, t4, a3
                  slli         s4, a5, 26
                  c.addi       t4, 20
                  andi         t0, s11, 1760
                  divu         s10, sp, s1
                  div          s0, t2, a0
                  c.addi4spn   s1, sp, 32
                  mulh         s11, s9, gp
                  auipc        a4, 881820
                  and          t5, t0, a7
                  c.addi       t4, 20
                  rem          s6, a2, t4
                  c.lui        s8, 31
                  sll          s8, a6, a2
                  mul          a1, s6, s6
                  c.addi16sp   sp, 400
                  c.nop
                  and          t5, t0, a7
                  lui          t2, 776121
                  sltiu        a1, s4, 1988
                  slli         s4, a5, 26
                  li           s1, 0x0 #start riscv_int_numeric_corner_stream_10
                  li           sp, 0x0
                  li           a6, 0x13453158
                  li           s0, 0xffffffff
                  li           t2, 0x0
                  li           gp, 0xffffffff
                  li           s6, 0xffffffff
                  li           t5, 0xffffffff
                  li           s11, 0xffffffff
                  li           a0, 0x80000000
                  div          s6, s6, s11
                  nop
                  addi         a0, t2, 596
                  mulh         s11, t5, s0
                  rem          s1, sp, a6
                  remu         s1, s11, t2
                  add          s1, t2, gp
                  divu         s6, t2, t5
                  add          s1, t2, gp
                  div          s6, s6, s11
                  add          s1, t2, gp
                  mulhu        a6, a0, s0
                  addi         a0, t2, 596
                  mulhu        a6, a0, s0
                  lui          a6, 776121
                  div          s6, s6, s11
                  sub          s11, s6, s1 #end riscv_int_numeric_corner_stream_10
                  auipc        a4, 881820
                  srai         t0, t0, 4
                  remu         s6, a4, s2
                  sltiu        a1, s4, 1988
                  mulhsu       a7, s0, t4
                  remu         s6, a4, s2
                  c.srai       a2, 4
                  add          s6, s2, s10
                  and          t5, t0, a7
                  li           a6, 0x80000000 #start riscv_int_numeric_corner_stream_38
                  li           t4, 0x80000000
                  li           a1, 0x0
                  li           s0, 0x80000000
                  li           s4, 0x0
                  li           s11, 0x2f7f71cc
                  li           s1, 0xffffffff
                  li           a4, 0x96409a07
                  li           s5, 0x80000000
                  li           gp, 0x0
                  auipc        s11, 881820
                  remu         a4, s11, s1
                  mulhu        s4, a6, a1
                  rem          a4, gp, s4
                  mulhsu       gp, s11, s1
                  addi         a6, s1, 596
                  mulhsu       gp, s11, s1
                  remu         a4, s11, s1
                  addi         a6, s1, 596
                  div          s5, s5, s11
                  sub          s11, s5, a4
                  nop
                  mulhu        s4, a6, a1
                  auipc        s11, 881820
                  nop
                  remu         a4, s11, s1
                  addi         a6, s1, 596
                  lui          s4, 776121
                  mulhsu       gp, s11, s1
                  mulhsu       gp, s11, s1
                  remu         a4, s11, s1
                  lui          s4, 776121
                  mulh         s11, t4, a1
                  mul          s1, s4, s4
                  mul          s1, s4, s4
                  remu         a4, s11, s1
                  lui          s4, 776121
                  mulhu        s4, a6, a1
                  div          s5, s5, s11 #end riscv_int_numeric_corner_stream_38
                  c.nop
                  c.li         a0, 21
                  srli         sp, s3, 10
                  c.or         a2, a5
                  div          s0, t2, a0
                  c.sub        a3, s1
                  c.andi       a0, -1
                  c.mv         s8, a5
                  sltiu        a1, s4, 1988
                  c.andi       a0, -1
                  xor          a4, s11, s7
                  c.srai       a2, 4
                  c.srli       a0, 28
                  mul          a1, s6, s6
                  c.addi16sp   sp, 400
                  add          s6, s2, s10
                  slt          t4, s3, s11
                  addi         s8, s2, 596
                  nop
                  or           a4, s7, s8
                  c.addi16sp   sp, 400
                  srai         t0, t0, 4
                  slli         s4, a5, 26
                  srai         t0, t0, 4
                  nop
                  xori         a3, s3, -1008
                  sll          s8, a6, a2
                  c.srli       a0, 28
                  c.addi4spn   s1, sp, 32
                  slti         gp, tp, -1791
                  mulh         s11, s9, gp
                  nop
                  srai         t0, t0, 4
                  c.and        s0, a3
                  remu         s6, a4, s2
                  andi         t0, s11, 1760
                  c.nop
                  c.addi       t4, 20
                  and          t5, t0, a7
                  c.srai       a2, 4
                  mulh         s11, s9, gp
                  sltiu        a1, s4, 1988
                  c.addi       t4, 20
                  nop
                  c.xor        s0, a5
                  c.xor        s0, a5
                  c.slli       s11, 17
                  slti         gp, tp, -1791
                  c.or         a2, a5
                  c.or         a2, a5
                  mulhu        t2, s5, t5
                  addi         s8, s2, 596
                  c.sub        a3, s1
                  ori          s6, t3, 246
                  sub          s11, t4, a3
                  slti         gp, tp, -1791
                  mulhu        t2, s5, t5
                  c.slli       s11, 17
                  srai         t0, t0, 4
                  c.slli       s11, 17
                  c.addi       t4, 20
                  sra          s8, a5, s8
                  slti         gp, tp, -1791
                  mulhu        t2, s5, t5
                  c.lui        s8, 31
                  sll          s8, a6, a2
                  c.srai       a2, 4
                  slli         s4, a5, 26
                  c.lui        s8, 31
                  c.slli       s11, 17
                  c.nop
                  sltu         s8, s9, s11
                  rem          s6, a2, t4
                  c.andi       a0, -1
                  ori          s6, t3, 246
                  c.lui        s8, 31
                  nop
                  mulh         s11, s9, gp
                  c.add        t2, s3
                  mulh         s11, s9, gp
                  c.mv         s8, a5
                  c.nop
                  c.addi16sp   sp, 400
                  remu         s6, a4, s2
                  c.xor        s0, a5
                  c.andi       a0, -1
                  sll          s8, a6, a2
                  sltiu        a1, s4, 1988
                  lui          t2, 776121
                  mul          a1, s6, s6
                  c.nop
                  slli         s4, a5, 26
                  srai         t0, t0, 4
                  and          t5, t0, a7
                  c.li         a0, 21
                  sltu         s8, s9, s11
                  c.slli       s11, 17
                  sltiu        a1, s4, 1988
                  sra          s8, a5, s8
                  addi         s8, s2, 596
                  addi         s8, s2, 596
                  c.or         a2, a5
                  c.mv         s8, a5
                  c.mv         s8, a5
                  sltu         s8, s9, s11
                  mulhsu       a7, s0, t4
                  srli         sp, s3, 10
                  c.and        s0, a3
                  slt          t4, s3, s11
                  c.srai       a2, 4
                  mulhu        t2, s5, t5
                  c.xor        s0, a5
                  c.srli       a0, 28
                  remu         s6, a4, s2
                  xor          a4, s11, s7
                  c.sub        a3, s1
                  c.srli       a0, 28
                  ori          s6, t3, 246
                  sll          s8, a6, a2
                  c.li         a0, 21
                  mulhu        t2, s5, t5
                  slt          t4, s3, s11
                  c.andi       a0, -1
                  auipc        a4, 881820
                  c.sub        a3, s1
                  c.andi       a0, -1
                  and          t5, t0, a7
                  c.srli       a0, 28
                  sltiu        a1, s4, 1988
                  divu         s10, sp, s1
                  divu         s10, sp, s1
                  c.srai       a2, 4
                  addi         s8, s2, 596
                  c.addi16sp   sp, 400
                  srli         sp, s3, 10
                  div          s0, t2, a0
                  c.mv         s8, a5
                  andi         t0, s11, 1760
                  srl          gp, a7, s6
                  sll          s8, a6, a2
                  mulhsu       a7, s0, t4
                  c.and        s0, a3
                  andi         t0, s11, 1760
                  mulhu        t2, s5, t5
                  c.add        t2, s3
                  c.addi16sp   sp, 400
                  slti         gp, tp, -1791
                  auipc        a4, 881820
                  sltu         s8, s9, s11
                  slli         s4, a5, 26
                  c.add        t2, s3
                  mulhsu       a7, s0, t4
                  c.or         a2, a5
                  c.addi       t4, 20
                  lui          t2, 776121
                  c.nop
                  sltiu        a1, s4, 1988
                  ori          s6, t3, 246
                  nop
                  nop
                  rem          s6, a2, t4
                  c.srli       a0, 28
                  sll          s8, a6, a2
                  c.mv         s8, a5
                  addi         s8, s2, 596
                  sltiu        a1, s4, 1988
                  sll          s8, a6, a2
                  mulhsu       a7, s0, t4
                  sltu         s8, s9, s11
                  add          s6, s2, s10
                  auipc        a4, 881820
                  slti         gp, tp, -1791
                  c.sub        a3, s1
                  slti         gp, tp, -1791
                  remu         s6, a4, s2
                  sub          s11, t4, a3
                  mulhu        t2, s5, t5
                  sltiu        a1, s4, 1988
                  rem          s6, a2, t4
                  mulh         s11, s9, gp
                  c.srli       a0, 28
                  mulh         s11, s9, gp
                  ori          s6, t3, 246
                  c.andi       a0, -1
                  srli         sp, s3, 10
                  c.lui        s8, 31
                  srli         sp, s3, 10
                  c.srli       a0, 28
                  c.xor        s0, a5
                  remu         s6, a4, s2
                  lui          t2, 776121
                  c.nop
                  c.li         a0, 21
                  c.and        s0, a3
                  mulh         s11, s9, gp
                  srl          gp, a7, s6
                  slti         gp, tp, -1791
                  c.slli       s11, 17
                  nop
                  sub          s11, t4, a3
                  sltu         s8, s9, s11
                  srai         t0, t0, 4
                  c.li         a0, 21
                  c.srai       a2, 4
                  c.mv         s8, a5
                  sra          s8, a5, s8
                  and          t5, t0, a7
                  andi         t0, s11, 1760
                  srai         t0, t0, 4
                  sltu         s8, s9, s11
                  ori          s6, t3, 246
                  lui          t2, 776121
                  slt          t4, s3, s11
                  c.slli       s11, 17
                  sltu         s8, s9, s11
                  c.mv         s8, a5
                  c.andi       a0, -1
                  andi         t0, s11, 1760
                  c.li         a0, 21
                  c.lui        s8, 31
                  and          t5, t0, a7
                  and          t5, t0, a7
                  sltu         s8, s9, s11
                  remu         s6, a4, s2
                  c.xor        s0, a5
                  slt          t4, s3, s11
                  c.addi16sp   sp, 400
                  sltiu        a1, s4, 1988
                  c.nop
                  c.add        t2, s3
                  slti         gp, tp, -1791
                  mulhu        t2, s5, t5
                  addi         s8, s2, 596
                  add          s6, s2, s10
                  mul          a1, s6, s6
                  divu         s10, sp, s1
                  c.nop
                  c.slli       s11, 17
                  and          t5, t0, a7
                  c.srai       a2, 4
                  c.sub        a3, s1
                  add          s6, s2, s10
                  or           a4, s7, s8
                  sltu         s8, s9, s11
                  c.add        t2, s3
                  remu         s6, a4, s2
                  ori          s6, t3, 246
                  div          s0, t2, a0
                  c.srli       a0, 28
                  div          s0, t2, a0
                  ori          s6, t3, 246
                  div          s0, t2, a0
                  c.andi       a0, -1
                  mulhsu       a7, s0, t4
                  c.and        s0, a3
                  sltiu        a1, s4, 1988
                  c.addi16sp   sp, 400
                  nop
                  sltu         s8, s9, s11
                  c.addi16sp   sp, 400
                  c.li         a0, 21
                  add          s6, s2, s10
                  addi         s8, s2, 596
                  c.srai       a2, 4
                  c.mv         s8, a5
                  srli         sp, s3, 10
                  c.nop
                  c.slli       s11, 17
                  addi         s8, s2, 596
                  sra          s8, a5, s8
                  c.addi16sp   sp, 400
                  c.sub        a3, s1
                  slti         gp, tp, -1791
                  divu         s10, sp, s1
                  sra          s8, a5, s8
                  nop
                  c.addi16sp   sp, 400
                  sub          s11, t4, a3
                  c.andi       a0, -1
                  c.slli       s11, 17
                  c.addi16sp   sp, 400
                  ori          s6, t3, 246
                  andi         t0, s11, 1760
                  remu         s6, a4, s2
                  c.and        s0, a3
                  lui          t2, 776121
                  c.and        s0, a3
                  c.slli       s11, 17
                  remu         s6, a4, s2
                  slt          t4, s3, s11
                  mul          a1, s6, s6
                  c.xor        s0, a5
                  c.add        t2, s3
                  sra          s8, a5, s8
                  ori          s6, t3, 246
                  c.or         a2, a5
                  div          s0, t2, a0
                  c.addi       t4, 20
                  rem          s6, a2, t4
                  c.andi       a0, -1
                  c.sub        a3, s1
                  add          s6, s2, s10
                  srai         t0, t0, 4
                  andi         t0, s11, 1760
                  c.addi       t4, 20
                  add          s6, s2, s10
                  c.and        s0, a3
                  c.xor        s0, a5
                  c.srai       a2, 4
                  div          s0, t2, a0
                  ori          s6, t3, 246
                  add          s6, s2, s10
                  mulhsu       a7, s0, t4
                  rem          s6, a2, t4
                  slli         s4, a5, 26
                  mulhsu       a7, s0, t4
                  c.add        t2, s3
                  xor          a4, s11, s7
                  c.xor        s0, a5
                  xori         a3, s3, -1008
                  c.or         a2, a5
                  addi         s8, s2, 596
                  sub          s11, t4, a3
                  c.srli       a0, 28
                  c.and        s0, a3
                  c.andi       a0, -1
                  add          s6, s2, s10
                  c.sub        a3, s1
                  remu         s6, a4, s2
                  c.srai       a2, 4
                  sub          s11, t4, a3
                  c.li         a0, 21
                  sll          s8, a6, a2
                  sll          s8, a6, a2
                  andi         t0, s11, 1760
                  c.lui        s8, 31
                  addi         s8, s2, 596
                  xor          a4, s11, s7
                  srl          gp, a7, s6
                  c.sub        a3, s1
                  nop
                  c.li         a0, 21
                  auipc        a4, 881820
                  c.srai       a2, 4
                  c.srai       a2, 4
                  c.addi4spn   s1, sp, 32
                  srli         sp, s3, 10
                  c.and        s0, a3
                  sll          s8, a6, a2
                  lui          t2, 776121
                  c.srai       a2, 4
                  c.lui        s8, 31
                  remu         s6, a4, s2
                  c.xor        s0, a5
                  sra          s8, a5, s8
                  andi         t0, s11, 1760
                  c.mv         s8, a5
                  c.or         a2, a5
                  slt          t4, s3, s11
                  xor          a4, s11, s7
                  c.li         a0, 21
                  c.addi       t4, 20
                  c.andi       a0, -1
                  mulhu        t2, s5, t5
                  sltiu        a1, s4, 1988
                  divu         s10, sp, s1
                  mulh         s11, s9, gp
                  and          t5, t0, a7
                  c.andi       a0, -1
                  c.xor        s0, a5
                  addi         s8, s2, 596
                  mulhsu       a7, s0, t4
                  c.srli       a0, 28
                  mulhsu       a7, s0, t4
                  mul          a1, s6, s6
                  c.addi16sp   sp, 400
                  mulh         s11, s9, gp
                  sra          s8, a5, s8
                  addi         s8, s2, 596
                  addi         s8, s2, 596
                  li           s11, 0x0 #start riscv_int_numeric_corner_stream_19
                  li           tp, 0xffffffff
                  li           a1, 0xffffffff
                  li           s10, 0xb4eb123c
                  li           a3, 0x80000000
                  li           t6, 0x44c18fe5
                  li           a0, 0x60da19df
                  li           gp, 0xffffffff
                  li           a2, 0xeefd9072
                  li           a7, 0x80000000
                  nop
                  sub          s11, s10, a2
                  addi         a3, a0, 596
                  remu         a2, s11, a0
                  mulhu        a7, a3, a1
                  sub          s11, s10, a2
                  auipc        s11, 881820
                  divu         s10, a0, t6
                  mulh         s11, t6, a1
                  add          a2, a0, tp
                  mul          a0, a7, a7
                  mul          a0, a7, a7
                  div          s10, s10, s11
                  auipc        s11, 881820
                  remu         a2, s11, a0
                  mul          a0, a7, a7 #end riscv_int_numeric_corner_stream_19
                  sub          s11, t4, a3
                  rem          s6, a2, t4
                  c.addi16sp   sp, 400
                  c.li         a0, 21
                  c.addi16sp   sp, 400
                  andi         t0, s11, 1760
                  c.addi       t4, 20
                  remu         s6, a4, s2
                  sltiu        a1, s4, 1988
                  c.srli       a0, 28
                  c.addi4spn   s1, sp, 32
                  c.mv         s8, a5
                  c.li         a0, 21
                  slti         gp, tp, -1791
                  div          s0, t2, a0
                  xori         a3, s3, -1008
                  sltu         s8, s9, s11
                  c.and        s0, a3
                  c.sub        a3, s1
                  slti         gp, tp, -1791
                  addi         s8, s2, 596
                  div          s0, t2, a0
                  sub          s11, t4, a3
                  auipc        a4, 881820
                  andi         t0, s11, 1760
                  slt          t4, s3, s11
                  c.nop
                  mul          a1, s6, s6
                  divu         s10, sp, s1
                  mulh         s11, s9, gp
                  add          s6, s2, s10
                  c.sub        a3, s1
                  andi         t0, s11, 1760
                  rem          s6, a2, t4
                  sltiu        a1, s4, 1988
                  or           a4, s7, s8
                  rem          s6, a2, t4
                  and          t5, t0, a7
                  c.lui        s8, 31
                  c.and        s0, a3
                  and          t5, t0, a7
                  andi         t0, s11, 1760
                  or           a4, s7, s8
                  andi         t0, s11, 1760
                  sll          s8, a6, a2
                  sltu         s8, s9, s11
                  sub          s11, t4, a3
                  slli         s4, a5, 26
                  rem          s6, a2, t4
                  slt          t4, s3, s11
                  srl          gp, a7, s6
                  addi         s8, s2, 596
                  remu         s6, a4, s2
                  c.sub        a3, s1
                  c.andi       a0, -1
                  ori          s6, t3, 246
                  srai         t0, t0, 4
                  div          s0, t2, a0
                  xori         a3, s3, -1008
                  slt          t4, s3, s11
                  c.andi       a0, -1
                  c.srli       a0, 28
                  c.lui        s8, 31
                  remu         s6, a4, s2
                  c.li         a0, 21
                  mul          a1, s6, s6
                  c.addi16sp   sp, 400
                  sub          s11, t4, a3
                  div          s0, t2, a0
                  srai         t0, t0, 4
                  c.andi       a0, -1
                  c.li         a0, 21
                  c.add        t2, s3
                  sltiu        a1, s4, 1988
                  c.mv         s8, a5
                  mulhu        t2, s5, t5
                  auipc        a4, 881820
                  srl          gp, a7, s6
                  mul          a1, s6, s6
                  c.mv         s8, a5
                  c.srli       a0, 28
                  rem          s6, a2, t4
                  sltiu        a1, s4, 1988
                  srl          gp, a7, s6
                  div          s0, t2, a0
                  srai         t0, t0, 4
                  nop
                  div          s0, t2, a0
                  c.li         a0, 21
                  c.nop
                  nop
                  srl          gp, a7, s6
                  c.nop
                  srl          gp, a7, s6
                  c.addi16sp   sp, 400
                  c.xor        s0, a5
                  c.and        s0, a3
                  c.addi       t4, 20
                  div          s0, t2, a0
                  and          t5, t0, a7
                  srai         t0, t0, 4
                  c.addi4spn   s1, sp, 32
                  c.lui        s8, 31
                  sll          s8, a6, a2
                  nop
                  sra          s8, a5, s8
                  c.addi       t4, 20
                  mulhu        t2, s5, t5
                  nop
                  add          s6, s2, s10
                  mulh         s11, s9, gp
                  slli         s4, a5, 26
                  c.xor        s0, a5
                  divu         s10, sp, s1
                  andi         t0, s11, 1760
                  srl          gp, a7, s6
                  mulhsu       a7, s0, t4
                  mulh         s11, s9, gp
                  sub          s11, t4, a3
                  mul          a1, s6, s6
                  xori         a3, s3, -1008
                  sra          s8, a5, s8
                  sltu         s8, s9, s11
                  nop
                  c.or         a2, a5
                  lui          t2, 776121
                  srli         sp, s3, 10
                  slt          t4, s3, s11
                  addi         s8, s2, 596
                  xor          a4, s11, s7
                  mul          a1, s6, s6
                  c.srai       a2, 4
                  c.srli       a0, 28
                  auipc        a4, 881820
                  mulh         s11, s9, gp
                  c.or         a2, a5
                  mul          a1, s6, s6
                  mulhsu       a7, s0, t4
                  c.or         a2, a5
                  nop
                  sltiu        a1, s4, 1988
                  c.lui        s8, 31
                  c.add        t2, s3
                  c.mv         s8, a5
                  remu         s6, a4, s2
                  c.addi4spn   s1, sp, 32
                  or           a4, s7, s8
                  srl          gp, a7, s6
                  addi         s8, s2, 596
                  c.srli       a0, 28
                  c.slli       s11, 17
                  add          s6, s2, s10
                  mulhsu       a7, s0, t4
                  sra          s8, a5, s8
                  auipc        a4, 881820
                  mulhsu       a7, s0, t4
                  sra          s8, a5, s8
                  c.lui        s8, 31
                  auipc        a4, 881820
                  mulh         s11, s9, gp
                  c.or         a2, a5
                  nop
                  divu         s10, sp, s1
                  c.mv         s8, a5
                  mul          a1, s6, s6
                  c.add        t2, s3
                  c.nop
                  c.andi       a0, -1
                  c.li         a0, 21
                  ori          s6, t3, 246
                  c.addi       t4, 20
                  c.andi       a0, -1
                  c.slli       s11, 17
                  or           a4, s7, s8
                  sltu         s8, s9, s11
                  mulhsu       a7, s0, t4
                  sub          s11, t4, a3
                  nop
                  sra          s8, a5, s8
                  c.addi       t4, 20
                  c.mv         s8, a5
                  srl          gp, a7, s6
                  sra          s8, a5, s8
                  slt          t4, s3, s11
                  sra          s8, a5, s8
                  mulh         s11, s9, gp
                  mulh         s11, s9, gp
                  c.addi16sp   sp, 400
                  or           a4, s7, s8
                  divu         s10, sp, s1
                  nop
                  c.lui        s8, 31
                  slti         gp, tp, -1791
                  c.li         a0, 21
                  sll          s8, a6, a2
                  and          t5, t0, a7
                  auipc        a4, 881820
                  sll          s8, a6, a2
                  sltiu        a1, s4, 1988
                  c.xor        s0, a5
                  c.mv         s8, a5
                  sra          s8, a5, s8
                  slt          t4, s3, s11
                  mul          a1, s6, s6
                  addi         s8, s2, 596
                  srai         t0, t0, 4
                  c.srai       a2, 4
                  c.slli       s11, 17
                  or           a4, s7, s8
                  sltiu        a1, s4, 1988
                  xori         a3, s3, -1008
                  mulhsu       a7, s0, t4
                  lui          t2, 776121
                  or           a4, s7, s8
                  or           a4, s7, s8
                  div          s0, t2, a0
                  slli         s4, a5, 26
                  remu         s6, a4, s2
                  addi         s8, s2, 596
                  lui          t2, 776121
                  c.add        t2, s3
                  c.slli       s11, 17
                  auipc        a4, 881820
                  xor          a4, s11, s7
                  c.srai       a2, 4
                  mul          a1, s6, s6
                  sub          s11, t4, a3
                  nop
                  c.andi       a0, -1
                  c.srai       a2, 4
                  mulhsu       a7, s0, t4
                  c.sub        a3, s1
                  srli         sp, s3, 10
                  sub          s11, t4, a3
                  or           a4, s7, s8
                  xor          a4, s11, s7
                  c.addi16sp   sp, 400
                  c.addi4spn   s1, sp, 32
                  c.addi       t4, 20
                  andi         t0, s11, 1760
                  c.add        t2, s3
                  andi         t0, s11, 1760
                  mulhsu       a7, s0, t4
                  c.nop
                  slt          t4, s3, s11
                  c.nop
                  slti         gp, tp, -1791
                  c.addi16sp   sp, 400
                  rem          s6, a2, t4
                  c.and        s0, a3
                  nop
                  divu         s10, sp, s1
                  xor          a4, s11, s7
                  sra          s8, a5, s8
                  c.addi       t4, 20
                  xor          a4, s11, s7
                  srl          gp, a7, s6
                  divu         s10, sp, s1
                  c.or         a2, a5
                  c.and        s0, a3
                  c.sub        a3, s1
                  sub          s11, t4, a3
                  c.sub        a3, s1
                  divu         s10, sp, s1
                  c.addi16sp   sp, 400
                  sltu         s8, s9, s11
                  c.addi16sp   sp, 400
                  mulhsu       a7, s0, t4
                  andi         t0, s11, 1760
                  sltiu        a1, s4, 1988
                  c.nop
                  srl          gp, a7, s6
                  sltu         s8, s9, s11
                  ori          s6, t3, 246
                  sub          s11, t4, a3
                  c.addi4spn   s1, sp, 32
                  c.nop
                  divu         s10, sp, s1
                  mulhsu       a7, s0, t4
                  c.or         a2, a5
                  mul          a1, s6, s6
                  nop
                  srai         t0, t0, 4
                  nop
                  c.add        t2, s3
                  lui          t2, 776121
                  and          t5, t0, a7
                  nop
                  add          s6, s2, s10
                  div          s0, t2, a0
                  c.addi       t4, 20
                  addi         s8, s2, 596
                  slti         gp, tp, -1791
                  auipc        a4, 881820
                  c.li         a0, 21
                  rem          s6, a2, t4
                  c.lui        s8, 31
                  sltu         s8, s9, s11
                  xor          a4, s11, s7
                  xori         a3, s3, -1008
                  srli         sp, s3, 10
                  c.srli       a0, 28
                  c.add        t2, s3
                  auipc        a4, 881820
                  add          s6, s2, s10
                  div          s0, t2, a0
                  c.nop
                  lui          t2, 776121
                  auipc        a4, 881820
                  and          t5, t0, a7
                  sll          s8, a6, a2
                  c.addi16sp   sp, 400
                  xori         a3, s3, -1008
                  or           a4, s7, s8
                  and          t5, t0, a7
                  c.li         a0, 21
                  srai         t0, t0, 4
                  c.srai       a2, 4
                  addi         s8, s2, 596
                  sltu         s8, s9, s11
                  mulhu        t2, s5, t5
                  or           a4, s7, s8
                  slli         s4, a5, 26
                  c.sub        a3, s1
                  mul          a1, s6, s6
                  slli         s4, a5, 26
                  srai         t0, t0, 4
                  c.srai       a2, 4
                  c.add        t2, s3
                  sltu         s8, s9, s11
                  slti         gp, tp, -1791
                  c.mv         s8, a5
                  div          s0, t2, a0
                  nop
                  nop
                  c.slli       s11, 17
                  sltiu        a1, s4, 1988
                  c.slli       s11, 17
                  addi         s8, s2, 596
                  c.srli       a0, 28
                  mul          a1, s6, s6
                  mulh         s11, s9, gp
                  c.lui        s8, 31
                  xor          a4, s11, s7
                  srli         sp, s3, 10
                  c.or         a2, a5
                  c.and        s0, a3
                  mulhsu       a7, s0, t4
                  remu         s6, a4, s2
                  c.srai       a2, 4
                  c.addi4spn   s1, sp, 32
                  c.srai       a2, 4
                  divu         s10, sp, s1
                  ori          s6, t3, 246
                  c.addi16sp   sp, 400
                  slti         gp, tp, -1791
                  nop
                  auipc        a4, 881820
                  and          t5, t0, a7
                  sub          s11, t4, a3
                  remu         s6, a4, s2
                  c.andi       a0, -1
                  add          s6, s2, s10
                  mul          a1, s6, s6
                  mulhsu       a7, s0, t4
                  c.addi16sp   sp, 400
                  mulhsu       a7, s0, t4
                  srl          gp, a7, s6
                  c.mv         s8, a5
                  slti         gp, tp, -1791
                  lui          t2, 776121
                  c.addi4spn   s1, sp, 32
                  sub          s11, t4, a3
                  div          s0, t2, a0
                  c.andi       a0, -1
                  divu         s10, sp, s1
                  c.or         a2, a5
                  c.xor        s0, a5
                  and          t5, t0, a7
                  andi         t0, s11, 1760
                  sra          s8, a5, s8
                  c.add        t2, s3
                  c.nop
                  c.li         a0, 21
                  divu         s10, sp, s1
                  c.srli       a0, 28
                  remu         s6, a4, s2
                  c.xor        s0, a5
                  sll          s8, a6, a2
                  mulhu        t2, s5, t5
                  add          s6, s2, s10
                  andi         t0, s11, 1760
                  c.addi4spn   s1, sp, 32
                  slt          t4, s3, s11
                  c.slli       s11, 17
                  lui          t2, 776121
                  sll          s8, a6, a2
                  c.nop
                  c.srli       a0, 28
                  div          s0, t2, a0
                  div          s0, t2, a0
                  c.slli       s11, 17
                  c.srai       a2, 4
                  c.lui        s8, 31
                  srl          gp, a7, s6
                  c.or         a2, a5
                  xori         a3, s3, -1008
                  or           a4, s7, s8
                  xori         a3, s3, -1008
                  c.addi4spn   s1, sp, 32
                  c.addi4spn   s1, sp, 32
                  c.addi       t4, 20
                  c.addi16sp   sp, 400
                  sra          s8, a5, s8
                  xor          a4, s11, s7
                  xori         a3, s3, -1008
                  ori          s6, t3, 246
                  sub          s11, t4, a3
                  sll          s8, a6, a2
                  add          s6, s2, s10
                  addi         s8, s2, 596
                  c.add        t2, s3
                  divu         s10, sp, s1
                  c.sub        a3, s1
                  c.addi16sp   sp, 400
                  c.and        s0, a3
                  c.lui        s8, 31
                  slti         gp, tp, -1791
                  srai         t0, t0, 4
                  xor          a4, s11, s7
                  ori          s6, t3, 246
                  c.lui        s8, 31
                  c.xor        s0, a5
                  c.slli       s11, 17
                  mul          a1, s6, s6
                  slt          t4, s3, s11
                  sub          s11, t4, a3
                  sltiu        a1, s4, 1988
                  slli         s4, a5, 26
                  srli         sp, s3, 10
                  addi         s8, s2, 596
                  add          s6, s2, s10
                  slt          t4, s3, s11
                  mulhu        t2, s5, t5
                  c.srli       a0, 28
                  mul          a1, s6, s6
                  c.add        t2, s3
                  slli         s4, a5, 26
                  mulh         s11, s9, gp
                  and          t5, t0, a7
                  mulhsu       a7, s0, t4
                  sltu         s8, s9, s11
                  slli         s4, a5, 26
                  nop
                  xor          a4, s11, s7
                  c.sub        a3, s1
                  slti         gp, tp, -1791
                  addi         s8, s2, 596
                  c.addi4spn   s1, sp, 32
                  c.addi16sp   sp, 400
                  mulhu        t2, s5, t5
                  c.mv         s8, a5
                  remu         s6, a4, s2
                  div          s0, t2, a0
                  addi         s8, s2, 596
                  remu         s6, a4, s2
                  sltu         s8, s9, s11
                  sub          s11, t4, a3
                  remu         s6, a4, s2
                  mulhsu       a7, s0, t4
                  rem          s6, a2, t4
                  c.addi16sp   sp, 400
                  slli         s4, a5, 26
                  srli         sp, s3, 10
                  c.sub        a3, s1
                  mulhsu       a7, s0, t4
                  srli         sp, s3, 10
                  lui          t2, 776121
                  addi         s8, s2, 596
                  c.srai       a2, 4
                  mulhu        t2, s5, t5
                  c.li         a0, 21
                  or           a4, s7, s8
                  addi         s8, s2, 596
                  divu         s10, sp, s1
                  srli         sp, s3, 10
                  ori          s6, t3, 246
                  add          s6, s2, s10
                  ori          s6, t3, 246
                  ori          s6, t3, 246
                  c.srli       a0, 28
                  xor          a4, s11, s7
                  slti         gp, tp, -1791
                  and          t5, t0, a7
                  srai         t0, t0, 4
                  slli         s4, a5, 26
                  div          s0, t2, a0
                  c.addi16sp   sp, 400
                  srl          gp, a7, s6
                  c.addi4spn   s1, sp, 32
                  div          s0, t2, a0
                  c.andi       a0, -1
                  sra          s8, a5, s8
                  c.mv         s8, a5
                  add          s6, s2, s10
                  nop
                  c.lui        s8, 31
                  c.xor        s0, a5
                  lui          t2, 776121
                  c.addi4spn   s1, sp, 32
                  c.addi       t4, 20
                  c.add        t2, s3
                  addi         s8, s2, 596
                  mulh         s11, s9, gp
                  xori         a3, s3, -1008
                  slt          t4, s3, s11
                  remu         s6, a4, s2
                  srai         t0, t0, 4
                  mulhsu       a7, s0, t4
                  mulhu        t2, s5, t5
                  sub          s11, t4, a3
                  lui          t2, 776121
                  rem          s6, a2, t4
                  divu         s10, sp, s1
                  srl          gp, a7, s6
                  c.add        t2, s3
                  mulh         s11, s9, gp
                  c.srai       a2, 4
                  sltu         s8, s9, s11
                  mulh         s11, s9, gp
                  c.andi       a0, -1
                  mulhsu       a7, s0, t4
                  srl          gp, a7, s6
                  srl          gp, a7, s6
                  c.xor        s0, a5
                  slti         gp, tp, -1791
                  lui          t2, 776121
                  c.andi       a0, -1
                  sub          s11, t4, a3
                  rem          s6, a2, t4
                  c.add        t2, s3
                  mul          a1, s6, s6
                  c.and        s0, a3
                  add          s6, s2, s10
                  sltu         s8, s9, s11
                  mulh         s11, s9, gp
                  c.addi       t4, 20
                  andi         t0, s11, 1760
                  c.mv         s8, a5
                  slt          t4, s3, s11
                  c.and        s0, a3
                  c.addi4spn   s1, sp, 32
                  mulhsu       a7, s0, t4
                  addi         s8, s2, 596
                  and          t5, t0, a7
                  sra          s8, a5, s8
                  add          s6, s2, s10
                  c.sub        a3, s1
                  auipc        a4, 881820
                  c.add        t2, s3
                  ori          s6, t3, 246
                  c.sub        a3, s1
                  srai         t0, t0, 4
                  srli         sp, s3, 10
                  xor          a4, s11, s7
                  c.or         a2, a5
                  srl          gp, a7, s6
                  c.andi       a0, -1
                  add          s6, s2, s10
                  c.lui        s8, 31
                  srli         sp, s3, 10
                  divu         s10, sp, s1
                  sltu         s8, s9, s11
                  mulhsu       a7, s0, t4
                  nop
                  sub          s11, t4, a3
                  sltiu        a1, s4, 1988
                  mul          a1, s6, s6
                  c.and        s0, a3
                  sub          s11, t4, a3
                  srli         sp, s3, 10
                  nop
                  srai         t0, t0, 4
                  sltiu        a1, s4, 1988
                  c.andi       a0, -1
                  divu         s10, sp, s1
                  andi         t0, s11, 1760
                  andi         t0, s11, 1760
                  slli         s4, a5, 26
                  divu         s10, sp, s1
                  rem          s6, a2, t4
                  srli         sp, s3, 10
                  c.addi       t4, 20
                  addi         s8, s2, 596
                  c.xor        s0, a5
                  xor          a4, s11, s7
                  c.add        t2, s3
                  c.and        s0, a3
                  addi         s8, s2, 596
                  and          t5, t0, a7
                  rem          s6, a2, t4
                  c.addi       t4, 20
                  sltiu        a1, s4, 1988
                  c.or         a2, a5
                  or           a4, s7, s8
                  c.mv         s8, a5
                  c.mv         s8, a5
                  srli         sp, s3, 10
                  c.addi4spn   s1, sp, 32
                  srl          gp, a7, s6
                  andi         t0, s11, 1760
                  slt          t4, s3, s11
                  c.addi4spn   s1, sp, 32
                  c.nop
                  c.srli       a0, 28
                  nop
                  divu         s10, sp, s1
                  remu         s6, a4, s2
                  nop
                  c.addi       t4, 20
                  sll          s8, a6, a2
                  or           a4, s7, s8
                  and          t5, t0, a7
                  c.srai       a2, 4
                  mulhu        t2, s5, t5
                  mulhu        t2, s5, t5
                  slli         s4, a5, 26
                  c.slli       s11, 17
                  mul          a1, s6, s6
                  or           a4, s7, s8
                  nop
                  c.slli       s11, 17
                  remu         s6, a4, s2
                  c.addi4spn   s1, sp, 32
                  xori         a3, s3, -1008
                  mulhsu       a7, s0, t4
                  mulhu        t2, s5, t5
                  and          t5, t0, a7
                  remu         s6, a4, s2
                  mulhu        t2, s5, t5
                  xor          a4, s11, s7
                  ori          s6, t3, 246
                  c.lui        s8, 31
                  c.li         a0, 21
                  slli         s4, a5, 26
                  c.nop
                  c.andi       a0, -1
                  remu         s6, a4, s2
                  slt          t4, s3, s11
                  c.and        s0, a3
                  mulh         s11, s9, gp
                  srli         sp, s3, 10
                  mulhu        t2, s5, t5
                  c.and        s0, a3
                  c.andi       a0, -1
                  c.or         a2, a5
                  remu         s6, a4, s2
                  sltiu        a1, s4, 1988
                  c.and        s0, a3
                  andi         t0, s11, 1760
                  mul          a1, s6, s6
                  add          s6, s2, s10
                  remu         s6, a4, s2
                  c.srai       a2, 4
                  c.addi16sp   sp, 400
                  ori          s6, t3, 246
                  srai         t0, t0, 4
                  or           a4, s7, s8
                  c.slli       s11, 17
                  c.add        t2, s3
                  mulhu        t2, s5, t5
                  sll          s8, a6, a2
                  c.andi       a0, -1
                  remu         s6, a4, s2
                  c.addi4spn   s1, sp, 32
                  ori          s6, t3, 246
                  srl          gp, a7, s6
                  c.addi16sp   sp, 400
                  mulh         s11, s9, gp
                  mulhsu       a7, s0, t4
                  c.andi       a0, -1
                  c.addi4spn   s1, sp, 32
                  ori          s6, t3, 246
                  xor          a4, s11, s7
                  mulhu        t2, s5, t5
                  xori         a3, s3, -1008
                  c.addi4spn   s1, sp, 32
                  c.lui        s8, 31
                  c.andi       a0, -1
                  ori          s6, t3, 246
                  slli         s4, a5, 26
                  xor          a4, s11, s7
                  c.slli       s11, 17
                  mul          a1, s6, s6
                  and          t5, t0, a7
                  c.mv         s8, a5
                  mulhsu       a7, s0, t4
                  c.slli       s11, 17
                  c.li         a0, 21
                  and          t5, t0, a7
                  remu         s6, a4, s2
                  sltiu        a1, s4, 1988
                  divu         s10, sp, s1
                  sltiu        a1, s4, 1988
                  add          s6, s2, s10
                  srai         t0, t0, 4
                  or           a4, s7, s8
                  mul          a1, s6, s6
                  nop
                  addi         s8, s2, 596
                  divu         s10, sp, s1
                  c.srli       a0, 28
                  c.xor        s0, a5
                  c.add        t2, s3
                  add          s6, s2, s10
                  xor          a4, s11, s7
                  c.slli       s11, 17
                  lui          t2, 776121
                  divu         s10, sp, s1
                  div          s0, t2, a0
                  srl          gp, a7, s6
                  mulh         s11, s9, gp
                  mul          a1, s6, s6
                  c.or         a2, a5
                  slt          t4, s3, s11
                  div          s0, t2, a0
                  c.andi       a0, -1
                  c.xor        s0, a5
                  slti         gp, tp, -1791
                  xori         a3, s3, -1008
                  divu         s10, sp, s1
                  or           a4, s7, s8
                  sll          s8, a6, a2
                  sltu         s8, s9, s11
                  c.srai       a2, 4
                  srli         sp, s3, 10
                  c.sub        a3, s1
                  slti         gp, tp, -1791
                  c.slli       s11, 17
                  add          s6, s2, s10
                  div          s0, t2, a0
                  auipc        a4, 881820
                  c.xor        s0, a5
                  add          s6, s2, s10
                  or           a4, s7, s8
                  srli         sp, s3, 10
                  sll          s8, a6, a2
                  c.xor        s0, a5
                  slt          t4, s3, s11
                  remu         s6, a4, s2
                  auipc        a4, 881820
                  c.li         a0, 21
                  srli         sp, s3, 10
                  rem          s6, a2, t4
                  c.mv         s8, a5
                  sub          s11, t4, a3
                  mulhu        t2, s5, t5
                  andi         t0, s11, 1760
                  addi         s8, s2, 596
                  nop
                  divu         s10, sp, s1
                  lui          t2, 776121
                  or           a4, s7, s8
                  c.xor        s0, a5
                  sub          s11, t4, a3
                  c.lui        s8, 31
                  mul          a1, s6, s6
                  sltiu        a1, s4, 1988
                  c.addi4spn   s1, sp, 32
                  c.andi       a0, -1
                  c.srai       a2, 4
                  andi         t0, s11, 1760
                  c.srai       a2, 4
                  addi         s8, s2, 596
                  sltiu        a1, s4, 1988
                  c.srai       a2, 4
                  c.slli       s11, 17
                  slti         gp, tp, -1791
                  remu         s6, a4, s2
                  sub          s11, t4, a3
                  div          s0, t2, a0
                  addi         s8, s2, 596
                  div          s0, t2, a0
                  ori          s6, t3, 246
                  slli         s4, a5, 26
                  slti         gp, tp, -1791
                  c.and        s0, a3
                  mulhsu       a7, s0, t4
                  c.and        s0, a3
                  sub          s11, t4, a3
                  mulhsu       a7, s0, t4
                  slli         s4, a5, 26
                  c.addi16sp   sp, 400
                  c.or         a2, a5
                  c.or         a2, a5
                  c.srli       a0, 28
                  srl          gp, a7, s6
                  xor          a4, s11, s7
                  addi         s8, s2, 596
                  c.add        t2, s3
                  slti         gp, tp, -1791
                  sltiu        a1, s4, 1988
                  slt          t4, s3, s11
                  divu         s10, sp, s1
                  c.srai       a2, 4
                  sltiu        a1, s4, 1988
                  lui          t2, 776121
                  addi         s8, s2, 596
                  mulhu        t2, s5, t5
                  nop
                  sltu         s8, s9, s11
                  sub          s11, t4, a3
                  nop
                  slti         gp, tp, -1791
                  or           a4, s7, s8
                  mulhsu       a7, s0, t4
                  mul          a1, s6, s6
                  rem          s6, a2, t4
                  xori         a3, s3, -1008
                  andi         t0, s11, 1760
                  xor          a4, s11, s7
                  add          s6, s2, s10
                  c.andi       a0, -1
                  mul          a1, s6, s6
                  xor          a4, s11, s7
                  or           a4, s7, s8
                  c.srli       a0, 28
                  nop
                  mulh         s11, s9, gp
                  c.srai       a2, 4
                  c.srli       a0, 28
                  slti         gp, tp, -1791
                  xori         a3, s3, -1008
                  andi         t0, s11, 1760
                  xori         a3, s3, -1008
                  c.andi       a0, -1
                  c.srai       a2, 4
                  auipc        a4, 881820
                  c.addi16sp   sp, 400
                  addi         s8, s2, 596
                  lui          t2, 776121
                  sltiu        a1, s4, 1988
                  c.sub        a3, s1
                  srli         sp, s3, 10
                  c.xor        s0, a5
                  auipc        a4, 881820
                  c.add        t2, s3
                  andi         t0, s11, 1760
                  slli         s4, a5, 26
                  mul          a1, s6, s6
                  add          s6, s2, s10
                  srli         sp, s3, 10
                  c.addi4spn   s1, sp, 32
                  lui          t2, 776121
                  andi         t0, s11, 1760
                  divu         s10, sp, s1
                  c.andi       a0, -1
                  sub          s11, t4, a3
                  c.or         a2, a5
                  auipc        a4, 881820
                  sltu         s8, s9, s11
                  add          s6, s2, s10
                  remu         s6, a4, s2
                  nop
                  c.xor        s0, a5
                  remu         s6, a4, s2
                  div          s0, t2, a0
                  sra          s8, a5, s8
                  slti         gp, tp, -1791
                  mul          a1, s6, s6
                  slt          t4, s3, s11
                  ori          s6, t3, 246
                  mul          a1, s6, s6
                  c.add        t2, s3
                  c.lui        s8, 31
                  c.addi4spn   s1, sp, 32
                  c.addi       t4, 20
                  c.addi4spn   s1, sp, 32
                  ori          s6, t3, 246
                  and          t5, t0, a7
                  c.mv         s8, a5
                  sltiu        a1, s4, 1988
                  andi         t0, s11, 1760
                  xori         a3, s3, -1008
                  mulhsu       a7, s0, t4
                  xor          a4, s11, s7
                  add          s6, s2, s10
                  c.sub        a3, s1
                  add          s6, s2, s10
                  sltiu        a1, s4, 1988
                  divu         s10, sp, s1
                  c.li         a0, 21
                  ori          s6, t3, 246
                  slli         s4, a5, 26
                  mulhsu       a7, s0, t4
                  mulhu        t2, s5, t5
                  divu         s10, sp, s1
                  mul          a1, s6, s6
                  c.srai       a2, 4
                  c.nop
                  c.addi4spn   s1, sp, 32
                  xor          a4, s11, s7
                  c.mv         s8, a5
                  slli         s4, a5, 26
                  c.add        t2, s3
                  rem          s6, a2, t4
                  c.lui        s8, 31
                  c.addi16sp   sp, 400
                  slli         s4, a5, 26
                  c.and        s0, a3
                  lui          t2, 776121
                  srl          gp, a7, s6
                  xor          a4, s11, s7
                  slli         s4, a5, 26
                  c.srai       a2, 4
                  srl          gp, a7, s6
                  sltu         s8, s9, s11
                  c.addi16sp   sp, 400
                  and          t5, t0, a7
                  slli         s4, a5, 26
                  xor          a4, s11, s7
                  sltiu        a1, s4, 1988
                  ori          s6, t3, 246
                  rem          s6, a2, t4
                  c.mv         s8, a5
                  nop
                  addi         s8, s2, 596
                  sll          s8, a6, a2
                  and          t5, t0, a7
                  ori          s6, t3, 246
                  c.mv         s8, a5
                  c.addi16sp   sp, 400
                  and          t5, t0, a7
                  addi         s8, s2, 596
                  c.lui        s8, 31
                  srl          gp, a7, s6
                  rem          s6, a2, t4
                  c.li         a0, 21
                  or           a4, s7, s8
                  c.xor        s0, a5
                  div          s0, t2, a0
                  div          s0, t2, a0
                  c.li         a0, 21
                  c.addi4spn   s1, sp, 32
                  addi         s8, s2, 596
                  sltu         s8, s9, s11
                  mul          a1, s6, s6
                  addi         s8, s2, 596
                  c.srai       a2, 4
                  c.lui        s8, 31
                  div          s0, t2, a0
                  c.and        s0, a3
                  remu         s6, a4, s2
                  srli         sp, s3, 10
                  c.xor        s0, a5
                  c.nop
                  remu         s6, a4, s2
                  c.add        t2, s3
                  slt          t4, s3, s11
                  sltiu        a1, s4, 1988
                  c.slli       s11, 17
                  slti         gp, tp, -1791
                  c.slli       s11, 17
                  c.addi       t4, 20
                  sra          s8, a5, s8
                  mulh         s11, s9, gp
                  slti         gp, tp, -1791
                  slt          t4, s3, s11
                  srai         t0, t0, 4
                  rem          s6, a2, t4
                  srli         sp, s3, 10
                  c.addi4spn   s1, sp, 32
                  c.and        s0, a3
                  rem          s6, a2, t4
                  srl          gp, a7, s6
                  xori         a3, s3, -1008
                  srli         sp, s3, 10
                  mulhsu       a7, s0, t4
                  srli         sp, s3, 10
                  c.andi       a0, -1
                  mulhsu       a7, s0, t4
                  mulh         s11, s9, gp
                  srli         sp, s3, 10
                  c.addi       t4, 20
                  nop
                  slli         s4, a5, 26
                  slt          t4, s3, s11
                  c.li         a0, 21
                  divu         s10, sp, s1
                  add          s6, s2, s10
                  li           a2, 0x80000000 #start riscv_int_numeric_corner_stream_0
                  li           s11, 0x0
                  li           s5, 0xffffffff
                  li           t0, 0x0
                  li           a5, 0x0
                  li           a0, 0x80000000
                  li           gp, 0x70987db
                  li           t5, 0x96b16a8
                  li           a4, 0x0
                  li           tp, 0x80000000
                  nop
                  mulh         s11, t5, a0
                  addi         a4, t0, 596
                  rem          a2, gp, a5
                  remu         a2, s11, t0
                  addi         a4, t0, 596
                  mulhu        a5, a4, a0
                  add          a2, t0, tp
                  addi         a4, t0, 596
                  divu         s5, t0, t5
                  sub          s11, s5, a2
                  mulh         s11, t5, a0
                  sub          s11, s5, a2
                  mulhsu       gp, s11, t0
                  mulhu        a5, a4, a0
                  auipc        s11, 881820
                  auipc        s11, 881820
                  add          a2, t0, tp
                  mul          t0, a5, a5
                  nop
                  mulhsu       gp, s11, t0
                  rem          a2, gp, a5
                  mulh         s11, t5, a0 #end riscv_int_numeric_corner_stream_0
                  or           a4, s7, s8
                  srl          gp, a7, s6
                  and          t5, t0, a7
                  xori         a3, s3, -1008
                  c.li         a0, 21
                  sltu         s8, s9, s11
                  auipc        a4, 881820
                  add          s6, s2, s10
                  mul          a1, s6, s6
                  sltiu        a1, s4, 1988
                  c.xor        s0, a5
                  c.andi       a0, -1
                  slti         gp, tp, -1791
                  c.li         a0, 21
                  c.lui        s8, 31
                  c.lui        s8, 31
                  srli         sp, s3, 10
                  div          s0, t2, a0
                  mul          a1, s6, s6
                  c.mv         s8, a5
                  sltu         s8, s9, s11
                  slt          t4, s3, s11
                  c.addi16sp   sp, 400
                  srli         sp, s3, 10
                  c.addi       t4, 20
                  and          t5, t0, a7
                  rem          s6, a2, t4
                  lui          t2, 776121
                  slt          t4, s3, s11
                  rem          s6, a2, t4
                  addi         s8, s2, 596
                  c.addi16sp   sp, 400
                  auipc        a4, 881820
                  lui          t2, 776121
                  add          s6, s2, s10
                  xor          a4, s11, s7
                  sll          s8, a6, a2
                  mulhsu       a7, s0, t4
                  c.srai       a2, 4
                  c.and        s0, a3
                  or           a4, s7, s8
                  c.and        s0, a3
                  slli         s4, a5, 26
                  c.slli       s11, 17
                  addi         s8, s2, 596
                  div          s0, t2, a0
                  sltiu        a1, s4, 1988
                  lui          t2, 776121
                  c.add        t2, s3
                  sra          s8, a5, s8
                  c.andi       a0, -1
                  mulhu        t2, s5, t5
                  slli         s4, a5, 26
                  xori         a3, s3, -1008
                  c.slli       s11, 17
                  divu         s10, sp, s1
                  ori          s6, t3, 246
                  c.addi       t4, 20
                  div          s0, t2, a0
                  c.and        s0, a3
                  srai         t0, t0, 4
                  addi         s8, s2, 596
                  srl          gp, a7, s6
                  srli         sp, s3, 10
                  c.add        t2, s3
                  lui          t2, 776121
                  c.slli       s11, 17
                  c.nop
                  c.addi4spn   s1, sp, 32
                  and          t5, t0, a7
                  slt          t4, s3, s11
                  auipc        a4, 881820
                  c.li         a0, 21
                  mulhsu       a7, s0, t4
                  xor          a4, s11, s7
                  sltu         s8, s9, s11
                  c.slli       s11, 17
                  addi         s8, s2, 596
                  c.and        s0, a3
                  c.nop
                  xori         a3, s3, -1008
                  divu         s10, sp, s1
                  remu         s6, a4, s2
                  c.and        s0, a3
                  slt          t4, s3, s11
                  xori         a3, s3, -1008
                  sll          s8, a6, a2
                  and          t5, t0, a7
                  add          s6, s2, s10
                  c.srli       a0, 28
                  div          s0, t2, a0
                  remu         s6, a4, s2
                  add          s6, s2, s10
                  c.or         a2, a5
                  sll          s8, a6, a2
                  c.add        t2, s3
                  mul          a1, s6, s6
                  remu         s6, a4, s2
                  c.sub        a3, s1
                  c.nop
                  remu         s6, a4, s2
                  ori          s6, t3, 246
                  c.addi16sp   sp, 400
                  mulhu        t2, s5, t5
                  sra          s8, a5, s8
                  c.nop
                  xor          a4, s11, s7
                  nop
                  c.addi16sp   sp, 400
                  c.nop
                  srl          gp, a7, s6
                  div          s0, t2, a0
                  c.slli       s11, 17
                  c.addi       t4, 20
                  auipc        a4, 881820
                  add          s6, s2, s10
                  c.add        t2, s3
                  xor          a4, s11, s7
                  slli         s4, a5, 26
                  add          s6, s2, s10
                  c.andi       a0, -1
                  rem          s6, a2, t4
                  c.sub        a3, s1
                  sltu         s8, s9, s11
                  c.addi4spn   s1, sp, 32
                  auipc        a4, 881820
                  c.and        s0, a3
                  mul          a1, s6, s6
                  sltu         s8, s9, s11
                  xori         a3, s3, -1008
                  c.and        s0, a3
                  c.sub        a3, s1
                  c.nop
                  xor          a4, s11, s7
                  c.andi       a0, -1
                  xor          a4, s11, s7
                  c.andi       a0, -1
                  mulh         s11, s9, gp
                  ori          s6, t3, 246
                  mulh         s11, s9, gp
                  slt          t4, s3, s11
                  xori         a3, s3, -1008
                  or           a4, s7, s8
                  rem          s6, a2, t4
                  ori          s6, t3, 246
                  div          s0, t2, a0
                  c.li         a0, 21
                  c.and        s0, a3
                  ori          s6, t3, 246
                  srli         sp, s3, 10
                  andi         t0, s11, 1760
                  nop
                  and          t5, t0, a7
                  c.srli       a0, 28
                  c.sub        a3, s1
                  mul          a1, s6, s6
                  addi         s8, s2, 596
                  xor          a4, s11, s7
                  slti         gp, tp, -1791
                  c.li         a0, 21
                  srai         t0, t0, 4
                  c.and        s0, a3
                  c.sub        a3, s1
                  xori         a3, s3, -1008
                  c.addi       t4, 20
                  div          s0, t2, a0
                  c.sub        a3, s1
                  c.add        t2, s3
                  sltiu        a1, s4, 1988
                  andi         t0, s11, 1760
                  auipc        a4, 881820
                  c.and        s0, a3
                  lui          t2, 776121
                  or           a4, s7, s8
                  c.nop
                  c.and        s0, a3
                  c.and        s0, a3
                  c.or         a2, a5
                  c.or         a2, a5
                  nop
                  c.and        s0, a3
                  and          t5, t0, a7
                  mulh         s11, s9, gp
                  c.lui        s8, 31
                  mul          a1, s6, s6
                  ori          s6, t3, 246
                  rem          s6, a2, t4
                  c.nop
                  slt          t4, s3, s11
                  sra          s8, a5, s8
                  remu         s6, a4, s2
                  auipc        a4, 881820
                  slti         gp, tp, -1791
                  srli         sp, s3, 10
                  c.add        t2, s3
                  rem          s6, a2, t4
                  sltu         s8, s9, s11
                  c.xor        s0, a5
                  srai         t0, t0, 4
                  sub          s11, t4, a3
                  sltu         s8, s9, s11
                  mul          a1, s6, s6
                  lui          t2, 776121
                  nop
                  c.mv         s8, a5
                  sltiu        a1, s4, 1988
                  sub          s11, t4, a3
                  andi         t0, s11, 1760
                  auipc        a4, 881820
                  srai         t0, t0, 4
                  sll          s8, a6, a2
                  ori          s6, t3, 246
                  mulhsu       a7, s0, t4
                  divu         s10, sp, s1
                  srl          gp, a7, s6
                  c.xor        s0, a5
                  nop
                  add          s6, s2, s10
                  c.or         a2, a5
                  divu         s10, sp, s1
                  slli         s4, a5, 26
                  mulhsu       a7, s0, t4
                  c.andi       a0, -1
                  c.addi       t4, 20
                  slti         gp, tp, -1791
                  div          s0, t2, a0
                  sll          s8, a6, a2
                  srai         t0, t0, 4
                  c.or         a2, a5
                  slt          t4, s3, s11
                  c.mv         s8, a5
                  sltu         s8, s9, s11
                  srli         sp, s3, 10
                  lui          t2, 776121
                  addi         s8, s2, 596
                  sltiu        a1, s4, 1988
                  ori          s6, t3, 246
                  sra          s8, a5, s8
                  c.slli       s11, 17
                  mulhsu       a7, s0, t4
                  mul          a1, s6, s6
                  sub          s11, t4, a3
                  c.or         a2, a5
                  and          t5, t0, a7
                  c.slli       s11, 17
                  mul          a1, s6, s6
                  lui          t2, 776121
                  c.add        t2, s3
                  lui          t2, 776121
                  c.li         a0, 21
                  c.addi16sp   sp, 400
                  add          s6, s2, s10
                  andi         t0, s11, 1760
                  c.add        t2, s3
                  sltu         s8, s9, s11
                  mulhu        t2, s5, t5
                  sltiu        a1, s4, 1988
                  c.srai       a2, 4
                  c.add        t2, s3
                  c.sub        a3, s1
                  sra          s8, a5, s8
                  c.srai       a2, 4
                  add          s6, s2, s10
                  slti         gp, tp, -1791
                  c.add        t2, s3
                  sltiu        a1, s4, 1988
                  sltiu        a1, s4, 1988
                  remu         s6, a4, s2
                  srl          gp, a7, s6
                  c.xor        s0, a5
                  auipc        a4, 881820
                  slli         s4, a5, 26
                  c.slli       s11, 17
                  mul          a1, s6, s6
                  remu         s6, a4, s2
                  slti         gp, tp, -1791
                  andi         t0, s11, 1760
                  srai         t0, t0, 4
                  addi         s8, s2, 596
                  c.add        t2, s3
                  andi         t0, s11, 1760
                  mul          a1, s6, s6
                  c.li         a0, 21
                  lui          t2, 776121
                  sll          s8, a6, a2
                  ori          s6, t3, 246
                  c.li         a0, 21
                  sra          s8, a5, s8
                  divu         s10, sp, s1
                  lui          t2, 776121
                  slti         gp, tp, -1791
                  c.srai       a2, 4
                  c.slli       s11, 17
                  rem          s6, a2, t4
                  sll          s8, a6, a2
                  ori          s6, t3, 246
                  mulh         s11, s9, gp
                  c.li         a0, 21
                  mulhu        t2, s5, t5
                  or           a4, s7, s8
                  xor          a4, s11, s7
                  mulh         s11, s9, gp
                  mulhu        t2, s5, t5
                  sll          s8, a6, a2
                  sra          s8, a5, s8
                  sltu         s8, s9, s11
                  c.slli       s11, 17
                  addi         s8, s2, 596
                  divu         s10, sp, s1
                  nop
                  sltu         s8, s9, s11
                  ori          s6, t3, 246
                  xor          a4, s11, s7
                  c.addi       t4, 20
                  rem          s6, a2, t4
                  xori         a3, s3, -1008
                  c.or         a2, a5
                  c.addi       t4, 20
                  mul          a1, s6, s6
                  c.xor        s0, a5
                  c.lui        s8, 31
                  c.slli       s11, 17
                  divu         s10, sp, s1
                  slt          t4, s3, s11
                  mul          a1, s6, s6
                  slti         gp, tp, -1791
                  c.addi4spn   s1, sp, 32
                  slti         gp, tp, -1791
                  or           a4, s7, s8
                  mul          a1, s6, s6
                  slt          t4, s3, s11
                  mulhu        t2, s5, t5
                  remu         s6, a4, s2
                  remu         s6, a4, s2
                  divu         s10, sp, s1
                  xor          a4, s11, s7
                  c.srai       a2, 4
                  c.srli       a0, 28
                  slt          t4, s3, s11
                  sub          s11, t4, a3
                  srai         t0, t0, 4
                  c.sub        a3, s1
                  div          s0, t2, a0
                  or           a4, s7, s8
                  mulhsu       a7, s0, t4
                  sltu         s8, s9, s11
                  sll          s8, a6, a2
                  nop
                  auipc        a4, 881820
                  c.add        t2, s3
                  c.lui        s8, 31
                  xori         a3, s3, -1008
                  c.andi       a0, -1
                  sltiu        a1, s4, 1988
                  or           a4, s7, s8
                  remu         s6, a4, s2
                  sltu         s8, s9, s11
                  c.li         a0, 21
                  or           a4, s7, s8
                  auipc        a4, 881820
                  lui          t2, 776121
                  mulhu        t2, s5, t5
                  mul          a1, s6, s6
                  mulh         s11, s9, gp
                  xori         a3, s3, -1008
                  mulh         s11, s9, gp
                  sub          s11, t4, a3
                  nop
                  srai         t0, t0, 4
                  xor          a4, s11, s7
                  xor          a4, s11, s7
                  sltiu        a1, s4, 1988
                  auipc        a4, 881820
                  slti         gp, tp, -1791
                  auipc        a4, 881820
                  sltiu        a1, s4, 1988
                  or           a4, s7, s8
                  or           a4, s7, s8
                  sll          s8, a6, a2
                  rem          s6, a2, t4
                  c.add        t2, s3
                  slt          t4, s3, s11
                  c.and        s0, a3
                  c.or         a2, a5
                  xori         a3, s3, -1008
                  c.add        t2, s3
                  lui          t2, 776121
                  or           a4, s7, s8
                  c.andi       a0, -1
                  c.addi       t4, 20
                  c.addi16sp   sp, 400
                  div          s0, t2, a0
                  c.mv         s8, a5
                  divu         s10, sp, s1
                  lui          t2, 776121
                  sub          s11, t4, a3
                  sub          s11, t4, a3
                  c.add        t2, s3
                  c.andi       a0, -1
                  c.andi       a0, -1
                  mulhsu       a7, s0, t4
                  mul          a1, s6, s6
                  c.andi       a0, -1
                  c.mv         s8, a5
                  xori         a3, s3, -1008
                  c.addi4spn   s1, sp, 32
                  c.add        t2, s3
                  c.sub        a3, s1
                  sltiu        a1, s4, 1988
                  addi         s8, s2, 596
                  c.addi       t4, 20
                  nop
                  c.xor        s0, a5
                  nop
                  c.srai       a2, 4
                  mulhu        t2, s5, t5
                  c.li         a0, 21
                  div          s0, t2, a0
                  div          s0, t2, a0
                  ori          s6, t3, 246
                  slti         gp, tp, -1791
                  slti         gp, tp, -1791
                  c.andi       a0, -1
                  c.addi       t4, 20
                  add          s6, s2, s10
                  c.lui        s8, 31
                  sll          s8, a6, a2
                  slt          t4, s3, s11
                  sltu         s8, s9, s11
                  c.srai       a2, 4
                  mul          a1, s6, s6
                  sub          s11, t4, a3
                  xor          a4, s11, s7
                  c.lui        s8, 31
                  c.or         a2, a5
                  c.addi       t4, 20
                  slt          t4, s3, s11
                  c.xor        s0, a5
                  c.and        s0, a3
                  rem          s6, a2, t4
                  nop
                  c.srai       a2, 4
                  c.addi16sp   sp, 400
                  lui          t2, 776121
                  c.or         a2, a5
                  mul          a1, s6, s6
                  c.addi       t4, 20
                  or           a4, s7, s8
                  mulh         s11, s9, gp
                  div          s0, t2, a0
                  lui          t2, 776121
                  c.srli       a0, 28
                  andi         t0, s11, 1760
                  divu         s10, sp, s1
                  c.nop
                  divu         s10, sp, s1
                  c.nop
                  srai         t0, t0, 4
                  add          s6, s2, s10
                  andi         t0, s11, 1760
                  div          s0, t2, a0
                  mulhsu       a7, s0, t4
                  xor          a4, s11, s7
                  srli         sp, s3, 10
                  c.nop
                  add          s6, s2, s10
                  sll          s8, a6, a2
                  auipc        a4, 881820
                  c.addi16sp   sp, 400
                  andi         t0, s11, 1760
                  mulh         s11, s9, gp
                  c.lui        s8, 31
                  c.addi16sp   sp, 400
                  ori          s6, t3, 246
                  srl          gp, a7, s6
                  c.addi4spn   s1, sp, 32
                  addi         s8, s2, 596
                  add          s6, s2, s10
                  andi         t0, s11, 1760
                  srl          gp, a7, s6
                  xor          a4, s11, s7
                  sra          s8, a5, s8
                  and          t5, t0, a7
                  sltiu        a1, s4, 1988
                  srl          gp, a7, s6
                  c.nop
                  c.slli       s11, 17
                  c.mv         s8, a5
                  and          t5, t0, a7
                  addi         s8, s2, 596
                  c.srai       a2, 4
                  mul          a1, s6, s6
                  lui          t2, 776121
                  andi         t0, s11, 1760
                  mulh         s11, s9, gp
                  nop
                  sub          s11, t4, a3
                  div          s0, t2, a0
                  lui          t2, 776121
                  mulh         s11, s9, gp
                  c.andi       a0, -1
                  slli         s4, a5, 26
                  c.and        s0, a3
                  c.lui        s8, 31
                  c.srli       a0, 28
                  xori         a3, s3, -1008
                  c.andi       a0, -1
                  mulh         s11, s9, gp
                  lui          t2, 776121
                  auipc        a4, 881820
                  remu         s6, a4, s2
                  slt          t4, s3, s11
                  c.or         a2, a5
                  add          s6, s2, s10
                  nop
                  add          s6, s2, s10
                  c.li         a0, 21
                  srli         sp, s3, 10
                  rem          s6, a2, t4
                  and          t5, t0, a7
                  c.lui        s8, 31
                  c.srli       a0, 28
                  sltiu        a1, s4, 1988
                  c.mv         s8, a5
                  slli         s4, a5, 26
                  c.srli       a0, 28
                  sll          s8, a6, a2
                  c.xor        s0, a5
                  c.and        s0, a3
                  rem          s6, a2, t4
                  c.addi16sp   sp, 400
                  c.andi       a0, -1
                  c.mv         s8, a5
                  sra          s8, a5, s8
                  c.andi       a0, -1
                  c.srai       a2, 4
                  sltu         s8, s9, s11
                  c.addi4spn   s1, sp, 32
                  c.srai       a2, 4
                  c.sub        a3, s1
                  c.andi       a0, -1
                  xori         a3, s3, -1008
                  c.addi16sp   sp, 400
                  c.addi       t4, 20
                  mulhu        t2, s5, t5
                  c.addi       t4, 20
                  slti         gp, tp, -1791
                  sltiu        a1, s4, 1988
                  xor          a4, s11, s7
                  xor          a4, s11, s7
                  rem          s6, a2, t4
                  c.srai       a2, 4
                  sltu         s8, s9, s11
                  slli         s4, a5, 26
                  c.addi4spn   s1, sp, 32
                  div          s0, t2, a0
                  rem          s6, a2, t4
                  c.li         a0, 21
                  c.sub        a3, s1
                  c.mv         s8, a5
                  andi         t0, s11, 1760
                  lui          t2, 776121
                  lui          t2, 776121
                  c.andi       a0, -1
                  divu         s10, sp, s1
                  srl          gp, a7, s6
                  mulh         s11, s9, gp
                  c.lui        s8, 31
                  div          s0, t2, a0
                  lui          t2, 776121
                  c.sub        a3, s1
                  c.xor        s0, a5
                  xor          a4, s11, s7
                  sll          s8, a6, a2
                  c.or         a2, a5
                  sra          s8, a5, s8
                  mulhsu       a7, s0, t4
                  xori         a3, s3, -1008
                  sltu         s8, s9, s11
                  xori         a3, s3, -1008
                  xori         a3, s3, -1008
                  addi         s8, s2, 596
                  mulh         s11, s9, gp
                  slti         gp, tp, -1791
                  c.andi       a0, -1
                  xori         a3, s3, -1008
                  c.xor        s0, a5
                  sll          s8, a6, a2
                  xori         a3, s3, -1008
                  srl          gp, a7, s6
                  auipc        a4, 881820
                  srai         t0, t0, 4
                  or           a4, s7, s8
                  c.addi4spn   s1, sp, 32
                  and          t5, t0, a7
                  c.slli       s11, 17
                  add          s6, s2, s10
                  slti         gp, tp, -1791
                  lui          t2, 776121
                  mulh         s11, s9, gp
                  add          s6, s2, s10
                  c.xor        s0, a5
                  remu         s6, a4, s2
                  addi         s8, s2, 596
                  addi         s8, s2, 596
                  c.mv         s8, a5
                  c.mv         s8, a5
                  div          s0, t2, a0
                  c.sub        a3, s1
                  addi         s8, s2, 596
                  sub          s11, t4, a3
                  remu         s6, a4, s2
                  remu         s6, a4, s2
                  div          s0, t2, a0
                  ori          s6, t3, 246
                  c.li         a0, 21
                  sll          s8, a6, a2
                  mulh         s11, s9, gp
                  c.addi4spn   s1, sp, 32
                  c.andi       a0, -1
                  srai         t0, t0, 4
                  xori         a3, s3, -1008
                  lui          t2, 776121
                  c.mv         s8, a5
                  c.addi4spn   s1, sp, 32
                  c.sub        a3, s1
                  c.add        t2, s3
                  sltiu        a1, s4, 1988
                  divu         s10, sp, s1
                  mul          a1, s6, s6
                  mulhsu       a7, s0, t4
                  sltiu        a1, s4, 1988
                  sub          s11, t4, a3
                  c.sub        a3, s1
                  nop
                  ori          s6, t3, 246
                  rem          s6, a2, t4
                  xor          a4, s11, s7
                  addi         s8, s2, 596
                  div          s0, t2, a0
                  sll          s8, a6, a2
                  sll          s8, a6, a2
                  c.addi16sp   sp, 400
                  mulhsu       a7, s0, t4
                  rem          s6, a2, t4
                  c.mv         s8, a5
                  c.mv         s8, a5
                  slti         gp, tp, -1791
                  auipc        a4, 881820
                  srl          gp, a7, s6
                  c.li         a0, 21
                  add          s6, s2, s10
                  c.li         a0, 21
                  mul          a1, s6, s6
                  c.sub        a3, s1
                  sltu         s8, s9, s11
                  sltu         s8, s9, s11
                  c.lui        s8, 31
                  c.srli       a0, 28
                  c.addi16sp   sp, 400
                  lui          t2, 776121
                  c.slli       s11, 17
                  c.or         a2, a5
                  c.addi4spn   s1, sp, 32
                  sub          s11, t4, a3
                  slt          t4, s3, s11
                  c.lui        s8, 31
                  remu         s6, a4, s2
                  div          s0, t2, a0
                  c.mv         s8, a5
                  c.mv         s8, a5
                  c.lui        s8, 31
                  mul          a1, s6, s6
                  c.li         a0, 21
                  slli         s4, a5, 26
                  c.or         a2, a5
                  xori         a3, s3, -1008
                  xor          a4, s11, s7
                  mulhsu       a7, s0, t4
                  slli         s4, a5, 26
                  sll          s8, a6, a2
                  mul          a1, s6, s6
                  xor          a4, s11, s7
                  sltiu        a1, s4, 1988
                  or           a4, s7, s8
                  c.and        s0, a3
                  divu         s10, sp, s1
                  sll          s8, a6, a2
                  mulh         s11, s9, gp
                  xor          a4, s11, s7
                  c.or         a2, a5
                  slli         s4, a5, 26
                  slt          t4, s3, s11
                  c.addi16sp   sp, 400
                  mulh         s11, s9, gp
                  srai         t0, t0, 4
                  slt          t4, s3, s11
                  slli         s4, a5, 26
                  c.andi       a0, -1
                  remu         s6, a4, s2
                  c.lui        s8, 31
                  remu         s6, a4, s2
                  remu         s6, a4, s2
                  srai         t0, t0, 4
                  c.addi4spn   s1, sp, 32
                  slt          t4, s3, s11
                  c.xor        s0, a5
                  c.srai       a2, 4
                  srai         t0, t0, 4
                  slti         gp, tp, -1791
                  slli         s4, a5, 26
                  c.mv         s8, a5
                  and          t5, t0, a7
                  auipc        a4, 881820
                  c.and        s0, a3
                  srli         sp, s3, 10
                  mulhu        t2, s5, t5
                  slti         gp, tp, -1791
                  c.srai       a2, 4
                  lui          t2, 776121
                  sltiu        a1, s4, 1988
                  mul          a1, s6, s6
                  mul          a1, s6, s6
                  sltiu        a1, s4, 1988
                  xor          a4, s11, s7
                  div          s0, t2, a0
                  mulhu        t2, s5, t5
                  nop
                  c.addi16sp   sp, 400
                  c.srli       a0, 28
                  xori         a3, s3, -1008
                  mulhsu       a7, s0, t4
                  xori         a3, s3, -1008
                  c.and        s0, a3
                  c.or         a2, a5
                  mulhsu       a7, s0, t4
                  ori          s6, t3, 246
                  c.addi       t4, 20
                  andi         t0, s11, 1760
                  rem          s6, a2, t4
                  rem          s6, a2, t4
                  slt          t4, s3, s11
                  lui          t2, 776121
                  srl          gp, a7, s6
                  c.srli       a0, 28
                  sltu         s8, s9, s11
                  rem          s6, a2, t4
                  c.andi       a0, -1
                  nop
                  ori          s6, t3, 246
                  lui          t2, 776121
                  c.addi4spn   s1, sp, 32
                  addi         s8, s2, 596
                  sub          s11, t4, a3
                  c.addi       t4, 20
                  mulhu        t2, s5, t5
                  xori         a3, s3, -1008
                  c.add        t2, s3
                  c.and        s0, a3
                  c.add        t2, s3
                  remu         s6, a4, s2
                  auipc        a4, 881820
                  mulhu        t2, s5, t5
                  c.mv         s8, a5
                  c.slli       s11, 17
                  sll          s8, a6, a2
                  mulhu        t2, s5, t5
                  c.addi16sp   sp, 400
                  sltiu        a1, s4, 1988
                  srl          gp, a7, s6
                  c.li         a0, 21
                  mulhu        t2, s5, t5
                  remu         s6, a4, s2
                  or           a4, s7, s8
                  lui          t2, 776121
                  c.li         a0, 21
                  c.lui        s8, 31
                  sub          s11, t4, a3
                  andi         t0, s11, 1760
                  slti         gp, tp, -1791
                  c.srli       a0, 28
                  c.sub        a3, s1
                  c.li         a0, 21
                  mulhu        t2, s5, t5
                  xori         a3, s3, -1008
                  c.and        s0, a3
                  la x19, test_done
                  jalr x0, x19, 0
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
                  addi x23, x23, -4
                  sw  x6, (x23)
                  add x6, x23, zero
                  addi x6, x6, -128
                  sw  x1, 4(x6)
                  sw  x2, 8(x6)
                  sw  x3, 12(x6)
                  sw  x4, 16(x6)
                  sw  x5, 20(x6)
                  sw  x6, 24(x6)
                  sw  x7, 28(x6)
                  sw  x8, 32(x6)
                  sw  x9, 36(x6)
                  sw  x10, 40(x6)
                  sw  x11, 44(x6)
                  sw  x12, 48(x6)
                  sw  x13, 52(x6)
                  sw  x14, 56(x6)
                  sw  x15, 60(x6)
                  sw  x16, 64(x6)
                  sw  x17, 68(x6)
                  sw  x18, 72(x6)
                  sw  x19, 76(x6)
                  sw  x20, 80(x6)
                  sw  x21, 84(x6)
                  sw  x22, 88(x6)
                  sw  x23, 92(x6)
                  sw  x24, 96(x6)
                  sw  x25, 100(x6)
                  sw  x26, 104(x6)
                  sw  x27, 108(x6)
                  sw  x28, 112(x6)
                  sw  x29, 116(x6)
                  sw  x30, 120(x6)
                  sw  x31, 124(x6)
                  add x23, x6, zero
                  csrr x9, 0x300 # MSTATUS
                  csrr x9, 0x342 # MCAUSE
                  srli x9, x9, 31
                  bne x9, x0, mmode_intr_handler

mmode_exception_handler:
                  csrr x9, 0x341 # MEPC
                  csrr x9, 0x342 # MCAUSE
                  li x22, 0x3 # BREAKPOINT
                  beq x9, x22, ebreak_handler
                  li x22, 0x8 # ECALL_UMODE
                  beq x9, x22, ecall_handler
                  li x22, 0x9 # ECALL_SMODE
                  beq x9, x22, ecall_handler
                  li x22, 0xb # ECALL_MMODE
                  beq x9, x22, ecall_handler
                  li x22, 0x1
                  beq x9, x22, instr_fault_handler
                  li x22, 0x5
                  beq x9, x22, load_fault_handler
                  li x22, 0x7
                  beq x9, x22, store_fault_handler
                  li x22, 0xc
                  beq x9, x22, pt_fault_handler
                  li x22, 0xd
                  beq x9, x22, pt_fault_handler
                  li x22, 0xf
                  beq x9, x22, pt_fault_handler
                  li x22, 0x2 # ILLEGAL_INSTRUCTION
                  beq x9, x22, illegal_instr_handler
                  csrr x22, 0x343 # MTVAL
                  1: la x19, test_done
                  jalr x1, x19, 0

ecall_handler:    
                  la x9, _start
                  sw x0, 0(x9)
                  sw x1, 4(x9)
                  sw x2, 8(x9)
                  sw x3, 12(x9)
                  sw x4, 16(x9)
                  sw x5, 20(x9)
                  sw x6, 24(x9)
                  sw x7, 28(x9)
                  sw x8, 32(x9)
                  sw x9, 36(x9)
                  sw x10, 40(x9)
                  sw x11, 44(x9)
                  sw x12, 48(x9)
                  sw x13, 52(x9)
                  sw x14, 56(x9)
                  sw x15, 60(x9)
                  sw x16, 64(x9)
                  sw x17, 68(x9)
                  sw x18, 72(x9)
                  sw x19, 76(x9)
                  sw x20, 80(x9)
                  sw x21, 84(x9)
                  sw x22, 88(x9)
                  sw x23, 92(x9)
                  sw x24, 96(x9)
                  sw x25, 100(x9)
                  sw x26, 104(x9)
                  sw x27, 108(x9)
                  sw x28, 112(x9)
                  sw x29, 116(x9)
                  sw x30, 120(x9)
                  sw x31, 124(x9)
                  la x19, write_tohost
                  jalr x0, x19, 0

instr_fault_handler:
                  add x6, x23, zero
                  lw  x1, 4(x6)
                  lw  x2, 8(x6)
                  lw  x3, 12(x6)
                  lw  x4, 16(x6)
                  lw  x5, 20(x6)
                  lw  x6, 24(x6)
                  lw  x7, 28(x6)
                  lw  x8, 32(x6)
                  lw  x9, 36(x6)
                  lw  x10, 40(x6)
                  lw  x11, 44(x6)
                  lw  x12, 48(x6)
                  lw  x13, 52(x6)
                  lw  x14, 56(x6)
                  lw  x15, 60(x6)
                  lw  x16, 64(x6)
                  lw  x17, 68(x6)
                  lw  x18, 72(x6)
                  lw  x19, 76(x6)
                  lw  x20, 80(x6)
                  lw  x21, 84(x6)
                  lw  x22, 88(x6)
                  lw  x23, 92(x6)
                  lw  x24, 96(x6)
                  lw  x25, 100(x6)
                  lw  x26, 104(x6)
                  lw  x27, 108(x6)
                  lw  x28, 112(x6)
                  lw  x29, 116(x6)
                  lw  x30, 120(x6)
                  lw  x31, 124(x6)
                  addi x6, x6, 128
                  add x23, x6, zero
                  lw  x6, (x23)
                  addi x23, x23, 4
                  mret

load_fault_handler:
                  add x6, x23, zero
                  lw  x1, 4(x6)
                  lw  x2, 8(x6)
                  lw  x3, 12(x6)
                  lw  x4, 16(x6)
                  lw  x5, 20(x6)
                  lw  x6, 24(x6)
                  lw  x7, 28(x6)
                  lw  x8, 32(x6)
                  lw  x9, 36(x6)
                  lw  x10, 40(x6)
                  lw  x11, 44(x6)
                  lw  x12, 48(x6)
                  lw  x13, 52(x6)
                  lw  x14, 56(x6)
                  lw  x15, 60(x6)
                  lw  x16, 64(x6)
                  lw  x17, 68(x6)
                  lw  x18, 72(x6)
                  lw  x19, 76(x6)
                  lw  x20, 80(x6)
                  lw  x21, 84(x6)
                  lw  x22, 88(x6)
                  lw  x23, 92(x6)
                  lw  x24, 96(x6)
                  lw  x25, 100(x6)
                  lw  x26, 104(x6)
                  lw  x27, 108(x6)
                  lw  x28, 112(x6)
                  lw  x29, 116(x6)
                  lw  x30, 120(x6)
                  lw  x31, 124(x6)
                  addi x6, x6, 128
                  add x23, x6, zero
                  lw  x6, (x23)
                  addi x23, x23, 4
                  mret

store_fault_handler:
                  add x6, x23, zero
                  lw  x1, 4(x6)
                  lw  x2, 8(x6)
                  lw  x3, 12(x6)
                  lw  x4, 16(x6)
                  lw  x5, 20(x6)
                  lw  x6, 24(x6)
                  lw  x7, 28(x6)
                  lw  x8, 32(x6)
                  lw  x9, 36(x6)
                  lw  x10, 40(x6)
                  lw  x11, 44(x6)
                  lw  x12, 48(x6)
                  lw  x13, 52(x6)
                  lw  x14, 56(x6)
                  lw  x15, 60(x6)
                  lw  x16, 64(x6)
                  lw  x17, 68(x6)
                  lw  x18, 72(x6)
                  lw  x19, 76(x6)
                  lw  x20, 80(x6)
                  lw  x21, 84(x6)
                  lw  x22, 88(x6)
                  lw  x23, 92(x6)
                  lw  x24, 96(x6)
                  lw  x25, 100(x6)
                  lw  x26, 104(x6)
                  lw  x27, 108(x6)
                  lw  x28, 112(x6)
                  lw  x29, 116(x6)
                  lw  x30, 120(x6)
                  lw  x31, 124(x6)
                  addi x6, x6, 128
                  add x23, x6, zero
                  lw  x6, (x23)
                  addi x23, x23, 4
                  mret

ebreak_handler:   
                  csrr  x9, 0x341
                  addi  x9, x9, 4
                  csrw  0x341, x9
                  add x6, x23, zero
                  lw  x1, 4(x6)
                  lw  x2, 8(x6)
                  lw  x3, 12(x6)
                  lw  x4, 16(x6)
                  lw  x5, 20(x6)
                  lw  x6, 24(x6)
                  lw  x7, 28(x6)
                  lw  x8, 32(x6)
                  lw  x9, 36(x6)
                  lw  x10, 40(x6)
                  lw  x11, 44(x6)
                  lw  x12, 48(x6)
                  lw  x13, 52(x6)
                  lw  x14, 56(x6)
                  lw  x15, 60(x6)
                  lw  x16, 64(x6)
                  lw  x17, 68(x6)
                  lw  x18, 72(x6)
                  lw  x19, 76(x6)
                  lw  x20, 80(x6)
                  lw  x21, 84(x6)
                  lw  x22, 88(x6)
                  lw  x23, 92(x6)
                  lw  x24, 96(x6)
                  lw  x25, 100(x6)
                  lw  x26, 104(x6)
                  lw  x27, 108(x6)
                  lw  x28, 112(x6)
                  lw  x29, 116(x6)
                  lw  x30, 120(x6)
                  lw  x31, 124(x6)
                  addi x6, x6, 128
                  add x23, x6, zero
                  lw  x6, (x23)
                  addi x23, x23, 4
                  mret

illegal_instr_handler:
                  csrr  x9, 0x341
                  addi  x9, x9, 4
                  csrw  0x341, x9
                  add x6, x23, zero
                  lw  x1, 4(x6)
                  lw  x2, 8(x6)
                  lw  x3, 12(x6)
                  lw  x4, 16(x6)
                  lw  x5, 20(x6)
                  lw  x6, 24(x6)
                  lw  x7, 28(x6)
                  lw  x8, 32(x6)
                  lw  x9, 36(x6)
                  lw  x10, 40(x6)
                  lw  x11, 44(x6)
                  lw  x12, 48(x6)
                  lw  x13, 52(x6)
                  lw  x14, 56(x6)
                  lw  x15, 60(x6)
                  lw  x16, 64(x6)
                  lw  x17, 68(x6)
                  lw  x18, 72(x6)
                  lw  x19, 76(x6)
                  lw  x20, 80(x6)
                  lw  x21, 84(x6)
                  lw  x22, 88(x6)
                  lw  x23, 92(x6)
                  lw  x24, 96(x6)
                  lw  x25, 100(x6)
                  lw  x26, 104(x6)
                  lw  x27, 108(x6)
                  lw  x28, 112(x6)
                  lw  x29, 116(x6)
                  lw  x30, 120(x6)
                  lw  x31, 124(x6)
                  addi x6, x6, 128
                  add x23, x6, zero
                  lw  x6, (x23)
                  addi x23, x23, 4
                  mret

pt_fault_handler: 
                  nop

.align 2
mmode_intr_handler:
                  csrr  x9, 0x300 # MSTATUS;
                  csrr  x9, 0x304 # MIE;
                  csrr  x9, 0x344 # MIP;
                  csrrc x9, 0x344, x9 # MIP;
                  add x6, x23, zero
                  lw  x1, 4(x6)
                  lw  x2, 8(x6)
                  lw  x3, 12(x6)
                  lw  x4, 16(x6)
                  lw  x5, 20(x6)
                  lw  x6, 24(x6)
                  lw  x7, 28(x6)
                  lw  x8, 32(x6)
                  lw  x9, 36(x6)
                  lw  x10, 40(x6)
                  lw  x11, 44(x6)
                  lw  x12, 48(x6)
                  lw  x13, 52(x6)
                  lw  x14, 56(x6)
                  lw  x15, 60(x6)
                  lw  x16, 64(x6)
                  lw  x17, 68(x6)
                  lw  x18, 72(x6)
                  lw  x19, 76(x6)
                  lw  x20, 80(x6)
                  lw  x21, 84(x6)
                  lw  x22, 88(x6)
                  lw  x23, 92(x6)
                  lw  x24, 96(x6)
                  lw  x25, 100(x6)
                  lw  x26, 104(x6)
                  lw  x27, 108(x6)
                  lw  x28, 112(x6)
                  lw  x29, 116(x6)
                  lw  x30, 120(x6)
                  lw  x31, 124(x6)
                  addi x6, x6, 128
                  add x23, x6, zero
                  lw  x6, (x23)
                  addi x23, x23, 4
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
