.include "user_define.h"
.globl _start
.section .text
_start:           
                  .include "user_init.s"
                  csrr x5, 0xf14
                  li x6, 0
                  beq x5, x6, 0f

0: la x14, h0_start
jalr x0, x14, 0
h0_start:
                  li x25, 0x40001104
                  csrw 0x301, x25
kernel_sp:        
                  la x20, kernel_stack_end

trap_vec_init:    
                  la x25, mtvec_handler
                  ori x25, x25, 0
                  csrw 0x305, x25 # MTVEC

mepc_setup:       
                  la x25, init
                  csrw 0x341, x25

custom_csr_setup: 
                  nop

init_machine_mode:
                  li x25, 0x1800
                  csrw 0x300, x25 # MSTATUS
                  li x25, 0x0
                  csrw 0x304, x25 # MIE
                  mret
init:             
                  li x0, 0x3
                  li x1, 0x0
                  li x2, 0x1
                  li x3, 0x5
                  li x4, 0x80000000
                  li x5, 0x0
                  li x6, 0x0
                  li x7, 0x80000000
                  li x8, 0x80000000
                  li x9, 0x0
                  li x11, 0xfd34cb2f
                  li x12, 0x0
                  li x13, 0xfdc224ad
                  li x14, 0x5
                  li x15, 0x80000000
                  li x16, 0x0
                  li x17, 0xf892dd47
                  li x18, 0x0
                  li x19, 0xf82ad652
                  li x21, 0xfb7ebc2b
                  li x22, 0x0
                  li x23, 0xfef79ea9
                  li x24, 0xfc71e2c9
                  li x25, 0x80000000
                  li x26, 0x2808253c
                  li x27, 0xb
                  li x28, 0x80000000
                  li x29, 0x80000000
                  li x30, 0x25e792f8
                  li x31, 0x0
                  la x10, user_stack_end
main:             li           t2, 0xaeddecb4 #start riscv_int_numeric_corner_stream_6
                  li           a6, 0x80000000
                  li           s5, 0x0
                  li           s11, 0x60f5f0c9
                  li           a1, 0xffffffff
                  li           t0, 0x39a38543
                  li           s8, 0x0
                  li           s3, 0xde50a51a
                  li           sp, 0x80000000
                  li           a7, 0xffffffff
                  lui          s11, 172841
                  divu         t2, s5, t2
                  mulhu        t2, s8, sp
                  mulhu        t2, s8, sp
                  mul          s8, sp, t0
                  div          a7, t0, s11
                  addi         s8, a7, -143
                  add          sp, a1, s8
                  mulhu        t2, s8, sp
                  rem          a7, s8, sp
                  divu         t2, s5, t2
                  nop
                  rem          a7, s8, sp
                  rem          a7, s8, sp
                  add          sp, a1, s8
                  divu         t2, s5, t2
                  nop
                  rem          a7, s8, sp
                  mul          s8, sp, t0
                  mulhu        t2, s8, sp
                  div          a7, t0, s11
                  rem          a7, s8, sp
                  sub          s11, s11, s5
                  divu         t2, s5, t2
                  rem          a7, s8, sp
                  div          a7, t0, s11
                  divu         t2, s5, t2 #end riscv_int_numeric_corner_stream_6
                  li           s8, 0xffffffff #start riscv_int_numeric_corner_stream_3
                  li           t3, 0x0
                  li           t1, 0x5581b59e
                  li           s9, 0xbb90c20
                  li           s0, 0xbfa6f887
                  li           tp, 0x80000000
                  li           t0, 0xffffffff
                  li           t4, 0xc98548bd
                  li           sp, 0xffffffff
                  li           a7, 0xffffffff
                  sub          t4, t4, s9
                  addi         t3, a7, -143
                  mulh         sp, t1, a7
                  auipc        sp, 631536
                  nop
                  sub          t4, t4, s9
                  divu         t0, s9, t0
                  mulh         sp, t1, a7
                  div          a7, tp, t4
                  rem          a7, t3, sp
                  add          sp, t1, t3
                  sub          t4, t4, s9
                  mulhsu       s9, t1, s0
                  add          sp, t1, t3
                  mulhsu       s9, t1, s0
                  nop
                  divu         t0, s9, t0
                  addi         t3, a7, -143
                  auipc        sp, 631536
                  divu         t0, s9, t0
                  div          a7, tp, t4
                  mulh         sp, t1, a7
                  mulhsu       s9, t1, s0
                  mul          t3, sp, tp
                  mulh         sp, t1, a7
                  div          a7, tp, t4
                  mulhu        t0, t3, sp
                  mulh         sp, t1, a7
                  addi         t3, a7, -143 #end riscv_int_numeric_corner_stream_3
                  li           s6, 0xffffffff #start riscv_int_numeric_corner_stream_5
                  li           a7, 0x0
                  li           s0, 0xa152009c
                  li           a2, 0x80000000
                  li           s8, 0x0
                  li           t5, 0xffffffff
                  li           s5, 0x80000000
                  li           s7, 0xee4204b3
                  li           sp, 0x80000000
                  li           t3, 0x5eec347c
                  div          s6, s0, t5
                  div          s6, s0, t5
                  remu         s7, a2, s7
                  nop
                  mulhsu       s8, a7, s5
                  nop
                  mul          t3, sp, s0
                  remu         s7, a2, s7
                  lui          t5, 172841
                  div          s6, s0, t5
                  mulhsu       s8, a7, s5
                  divu         a2, s8, a2
                  mulh         sp, a7, s6
                  add          sp, a7, t3
                  divu         a2, s8, a2
                  addi         t3, s6, -143
                  div          s6, s0, t5
                  nop #end riscv_int_numeric_corner_stream_5
                  li           t0, 0xffffffff #start riscv_int_numeric_corner_stream_25
                  li           s11, 0x647c0484
                  li           s8, 0x0
                  li           t1, 0x9aa73664
                  li           s0, 0x0
                  li           s7, 0x80000000
                  li           s6, 0xffffffff
                  li           a5, 0xffffffff
                  li           s10, 0xffffffff
                  li           t4, 0x549fabcf
                  nop
                  addi         s11, s7, -143
                  add          t0, a5, s11
                  lui          t4, 172841
                  sub          t4, t4, s10
                  lui          t4, 172841
                  remu         s8, s0, s8
                  rem          s7, s11, t0
                  add          t0, a5, s11
                  remu         s8, s0, s8
                  rem          s7, s11, t0
                  auipc        t0, 631536
                  div          s7, t1, t4
                  remu         s8, s0, s8
                  mul          s11, t0, t1
                  mulhu        s0, s11, t0
                  nop
                  div          s7, t1, t4
                  remu         s8, s0, s8
                  remu         s8, s0, s8 #end riscv_int_numeric_corner_stream_25
                  li           s11, 0x335d725a #start riscv_int_numeric_corner_stream_21
                  li           gp, 0xa22ccd76
                  li           a2, 0x0
                  li           a5, 0xffffffff
                  li           a3, 0x71d834b8
                  li           s6, 0x0
                  li           t3, 0xffffffff
                  li           t6, 0x80000000
                  li           s7, 0x80000000
                  li           t0, 0x0
                  mul          t3, gp, t0
                  divu         a2, s11, a2
                  mulh         gp, a3, s6
                  mul          t3, gp, t0
                  mulh         gp, a3, s6
                  addi         t3, s6, -143
                  mulhsu       s11, a3, a5
                  remu         s7, a2, s7
                  div          s6, t0, t6
                  add          gp, a3, t3
                  lui          t6, 172841
                  lui          t6, 172841
                  remu         s7, a2, s7
                  mulhu        a2, t3, gp
                  sub          t6, t6, s11
                  mulhsu       s11, a3, a5
                  auipc        gp, 631536
                  sub          t6, t6, s11
                  divu         a2, s11, a2
                  mul          t3, gp, t0
                  lui          t6, 172841
                  sub          t6, t6, s11
                  auipc        gp, 631536
                  divu         a2, s11, a2
                  addi         t3, s6, -143
                  mulh         gp, a3, s6 #end riscv_int_numeric_corner_stream_21
                  li           a2, 0xffffffff #start riscv_int_numeric_corner_stream_15
                  li           s9, 0x0
                  li           t0, 0x80000000
                  li           t1, 0xffffffff
                  li           s5, 0x0
                  li           s10, 0x9f3deecd
                  li           s0, 0x80000000
                  li           t4, 0x0
                  li           s6, 0xffffffff
                  li           sp, 0x80000000
                  div          s5, t0, t4
                  addi         s10, s5, -143
                  divu         t1, s9, t1
                  auipc        sp, 631536
                  rem          s5, s10, sp
                  lui          t4, 172841
                  rem          s5, s10, sp
                  sub          t4, t4, s9
                  auipc        sp, 631536
                  remu         s6, t1, s6
                  add          sp, s0, s10
                  mulhsu       s9, s0, a2
                  mul          s10, sp, t0
                  divu         t1, s9, t1
                  add          sp, s0, s10
                  divu         t1, s9, t1
                  addi         s10, s5, -143
                  remu         s6, t1, s6
                  addi         s10, s5, -143
                  sub          t4, t4, s9 #end riscv_int_numeric_corner_stream_15
                  li           a5, 0x0 #start riscv_int_numeric_corner_stream_0
                  li           s8, 0x0
                  li           s7, 0xffffffff
                  li           s5, 0xffffffff
                  li           t6, 0x0
                  li           t3, 0x0
                  li           s3, 0xb2787dae
                  li           t5, 0xffffffff
                  li           a7, 0xffffffff
                  li           t0, 0xffffffff
                  div          s7, a5, t6
                  addi         t5, s7, -143
                  mulh         t0, s3, s7
                  add          t0, s3, t5
                  div          s7, a5, t6
                  mulhsu       t3, s3, s5
                  div          s7, a5, t6
                  mul          t5, t0, a5
                  mulhu        a7, t5, t0
                  sub          t6, t6, t3
                  mulhsu       t3, s3, s5
                  div          s7, a5, t6
                  lui          t6, 172841
                  add          t0, s3, t5
                  remu         s8, a7, s8
                  div          s7, a5, t6
                  mulhu        a7, t5, t0 #end riscv_int_numeric_corner_stream_0
                  li           s5, 0xffffffff #start riscv_int_numeric_corner_stream_10
                  li           s8, 0x80000000
                  li           s0, 0xd1b8c9a7
                  li           s9, 0x0
                  li           s10, 0x799d159f
                  li           t1, 0xffffffff
                  li           t5, 0x0
                  li           a6, 0xffffffff
                  li           t4, 0xffffffff
                  li           s1, 0x4b372dcc
                  nop
                  nop
                  nop
                  remu         s9, s1, s9
                  sub          t5, t5, s10
                  rem          s8, t4, t1
                  rem          s8, t4, t1
                  rem          s8, t4, t1
                  rem          s8, t4, t1
                  divu         s1, s10, s1
                  remu         s9, s1, s9
                  add          t1, a6, t4
                  mulhsu       s10, a6, s5
                  addi         t4, s8, -143
                  mulhu        s1, t4, t1
                  auipc        t1, 631536
                  nop
                  lui          t5, 172841
                  rem          s8, t4, t1
                  divu         s1, s10, s1
                  rem          s8, t4, t1
                  rem          s8, t4, t1
                  remu         s9, s1, s9
                  mulhu        s1, t4, t1
                  mulhsu       s10, a6, s5
                  rem          s8, t4, t1
                  mulhu        s1, t4, t1
                  nop #end riscv_int_numeric_corner_stream_10
                  li           s3, 0x0 #start riscv_int_numeric_corner_stream_23
                  li           gp, 0x315794ff
                  li           s10, 0x0
                  li           s7, 0x89a74c45
                  li           a2, 0x3444c616
                  li           ra, 0xffffffff
                  li           t1, 0x80000000
                  li           s5, 0xffffffff
                  li           t5, 0xffffffff
                  li           t0, 0x0
                  addi         s10, s3, -143
                  div          s3, gp, t5
                  mulhsu       s7, t1, a2
                  div          s3, gp, t5
                  div          s3, gp, t5
                  nop
                  mul          s10, ra, gp
                  addi         s10, s3, -143
                  divu         t0, s7, t0
                  add          ra, t1, s10
                  addi         s10, s3, -143
                  auipc        ra, 631536
                  auipc        ra, 631536
                  mulh         ra, t1, s3
                  lui          t5, 172841
                  rem          s3, s10, ra
                  auipc        ra, 631536
                  rem          s3, s10, ra
                  addi         s10, s3, -143
                  auipc        ra, 631536
                  mulhu        t0, s10, ra
                  mulhsu       s7, t1, a2
                  sub          t5, t5, s7
                  addi         s10, s3, -143
                  divu         t0, s7, t0
                  rem          s3, s10, ra
                  div          s3, gp, t5 #end riscv_int_numeric_corner_stream_23
                  li           t4, 0x0 #start riscv_int_numeric_corner_stream_34
                  li           s6, 0x80000000
                  li           sp, 0x2a883e92
                  li           a6, 0x0
                  li           a7, 0xffffffff
                  li           a2, 0x80000000
                  li           s5, 0x0
                  li           tp, 0xffffffff
                  li           t3, 0x0
                  li           t6, 0xffffffff
                  addi         t4, s5, -143
                  rem          s5, t4, sp
                  remu         s6, a2, s6
                  nop
                  divu         a2, t3, a2
                  mulh         sp, a6, s5
                  mulh         sp, a6, s5
                  auipc        sp, 631536
                  rem          s5, t4, sp
                  nop
                  nop
                  div          s5, tp, t6
                  rem          s5, t4, sp
                  auipc        sp, 631536
                  lui          t6, 172841 #end riscv_int_numeric_corner_stream_34
                  li           t5, 0x780fc177 #start riscv_int_numeric_corner_stream_32
                  li           s0, 0x0
                  li           s10, 0x80000000
                  li           t4, 0xffffffff
                  li           t6, 0xffffffff
                  li           s7, 0x80000000
                  li           t0, 0xffffffff
                  li           a3, 0x80000000
                  li           s11, 0x80000000
                  li           t3, 0x0
                  mulh         t0, s7, s11
                  div          s11, s0, t6
                  mul          t5, t0, s0
                  lui          t6, 172841
                  remu         t3, a3, t3
                  mulhsu       t4, s7, s10
                  mulh         t0, s7, s11
                  mulhsu       t4, s7, s10
                  remu         t3, a3, t3
                  auipc        t0, 631536
                  auipc        t0, 631536
                  mulh         t0, s7, s11
                  lui          t6, 172841
                  mul          t5, t0, s0
                  lui          t6, 172841
                  addi         t5, s11, -143
                  remu         t3, a3, t3
                  nop
                  addi         t5, s11, -143
                  add          t0, s7, t5
                  rem          s11, t5, t0
                  rem          s11, t5, t0
                  divu         a3, t4, a3
                  auipc        t0, 631536
                  mulh         t0, s7, s11
                  mulh         t0, s7, s11
                  addi         t5, s11, -143
                  mulh         t0, s7, s11 #end riscv_int_numeric_corner_stream_32
                  li           s2, 0xffffffff #start riscv_int_numeric_corner_stream_7
                  li           a3, 0xffffffff
                  li           t3, 0xffffffff
                  li           t6, 0xffffffff
                  li           t2, 0xd82f1d88
                  li           s11, 0x90d3831b
                  li           t5, 0x80000000
                  li           a2, 0xe7a16c04
                  li           t0, 0x80000000
                  li           s5, 0xffffffff
                  divu         a2, t3, a2
                  nop
                  lui          t6, 172841
                  remu         s11, a2, s11
                  mul          t5, t0, t2
                  rem          s5, t5, t0
                  auipc        t0, 631536
                  rem          s5, t5, t0
                  sub          t6, t6, t3
                  remu         s11, a2, s11
                  mulhu        a2, t5, t0
                  mulhu        a2, t5, t0
                  mulh         t0, a3, s5
                  mulh         t0, a3, s5
                  sub          t6, t6, t3
                  sub          t6, t6, t3
                  div          s5, t2, t6 #end riscv_int_numeric_corner_stream_7
                  li           gp, 0x80000000 #start riscv_int_numeric_corner_stream_33
                  li           tp, 0x80000000
                  li           t3, 0x80000000
                  li           s8, 0xffffffff
                  li           ra, 0x7d4bea08
                  li           t6, 0x0
                  li           s11, 0x51a1e3e3
                  li           s0, 0x80000000
                  li           sp, 0xffffffff
                  li           t5, 0x80000000
                  mulhsu       t3, tp, s0
                  sub          t6, t6, t3
                  remu         s11, gp, s11
                  sub          t6, t6, t3
                  divu         gp, t3, gp
                  remu         s11, gp, s11
                  nop
                  mulhu        gp, t5, ra
                  auipc        ra, 631536
                  remu         s11, gp, s11
                  rem          s8, t5, ra
                  add          ra, tp, t5
                  remu         s11, gp, s11
                  add          ra, tp, t5
                  auipc        ra, 631536
                  remu         s11, gp, s11 #end riscv_int_numeric_corner_stream_33
                  li           t2, 0x0 #start riscv_int_numeric_corner_stream_26
                  li           a3, 0xffffffff
                  li           t5, 0x0
                  li           s8, 0xffffffff
                  li           tp, 0x80000000
                  li           a6, 0x1c3501fb
                  li           sp, 0x0
                  li           a7, 0xffffffff
                  li           ra, 0x80000000
                  li           a2, 0x9b61db45
                  addi         s8, a3, -143
                  divu         tp, a7, tp
                  div          a3, sp, t5
                  nop
                  lui          t5, 172841
                  lui          t5, 172841
                  mulhu        tp, s8, ra
                  addi         s8, a3, -143
                  mulhu        tp, s8, ra
                  divu         tp, a7, tp
                  remu         a6, tp, a6
                  divu         tp, a7, tp
                  sub          t5, t5, a7
                  rem          a3, s8, ra
                  mulhsu       a7, t2, a2
                  auipc        ra, 631536
                  rem          a3, s8, ra
                  lui          t5, 172841
                  sub          t5, t5, a7
                  rem          a3, s8, ra
                  mul          s8, ra, sp
                  add          ra, t2, s8
                  divu         tp, a7, tp
                  remu         a6, tp, a6 #end riscv_int_numeric_corner_stream_26
                  li           sp, 0x0 #start riscv_int_numeric_corner_stream_14
                  li           gp, 0xffffffff
                  li           s8, 0x9146f9ce
                  li           s9, 0x0
                  li           a1, 0x7b54ae08
                  li           t5, 0x1f973e3e
                  li           s11, 0x80000000
                  li           tp, 0x80000000
                  li           s5, 0xffffffff
                  li           s6, 0x80000000
                  mulhu        tp, s11, sp
                  mulh         sp, a1, s6
                  nop
                  divu         tp, s9, tp
                  rem          s6, s11, sp
                  nop
                  mulh         sp, a1, s6
                  add          sp, a1, s11
                  div          s6, gp, t5
                  mulhsu       s9, a1, s5
                  sub          t5, t5, s9
                  divu         tp, s9, tp
                  mul          s11, sp, gp
                  add          sp, a1, s11
                  remu         s8, tp, s8
                  divu         tp, s9, tp
                  mulh         sp, a1, s6
                  div          s6, gp, t5
                  add          sp, a1, s11
                  auipc        sp, 631536
                  mulhu        tp, s11, sp
                  add          sp, a1, s11
                  lui          t5, 172841
                  lui          t5, 172841
                  nop
                  lui          t5, 172841
                  add          sp, a1, s11 #end riscv_int_numeric_corner_stream_14
                  li           t4, 0x5cb83c62 #start riscv_int_numeric_corner_stream_16
                  li           s8, 0x507aba5a
                  li           t3, 0xffffffff
                  li           a3, 0xffffffff
                  li           s5, 0x0
                  li           ra, 0x0
                  li           t1, 0xbdc0f326
                  li           gp, 0xffffffff
                  li           s11, 0x0
                  li           a2, 0x0
                  mulh         ra, a2, s5
                  lui          t4, 172841
                  sub          t4, t4, s11
                  sub          t4, t4, s11
                  auipc        ra, 631536
                  mul          t3, ra, gp
                  nop
                  mulhu        t1, t3, ra
                  lui          t4, 172841
                  sub          t4, t4, s11
                  divu         t1, s11, t1
                  mulh         ra, a2, s5
                  mul          t3, ra, gp
                  add          ra, a2, t3
                  add          ra, a2, t3
                  remu         s8, t1, s8 #end riscv_int_numeric_corner_stream_16
                  li           s6, 0xffffffff #start riscv_int_numeric_corner_stream_22
                  li           s8, 0x0
                  li           s11, 0x0
                  li           s3, 0xffffffff
                  li           t3, 0xffffffff
                  li           s7, 0xf028996b
                  li           a6, 0xffffffff
                  li           a7, 0x80000000
                  li           gp, 0x0
                  li           s10, 0x80000000
                  divu         a7, s10, a7
                  mulhsu       s10, s3, s6
                  auipc        gp, 631536
                  auipc        gp, 631536
                  rem          s7, s11, gp
                  mulh         gp, s3, s7
                  sub          t3, t3, s10
                  mulh         gp, s3, s7
                  addi         s11, s7, -143
                  mulhu        a7, s11, gp
                  auipc        gp, 631536
                  mulh         gp, s3, s7
                  add          gp, s3, s11
                  add          gp, s3, s11
                  div          s7, a6, t3
                  remu         s8, a7, s8
                  mul          s11, gp, a6
                  div          s7, a6, t3
                  mul          s11, gp, a6
                  rem          s7, s11, gp
                  lui          t3, 172841
                  rem          s7, s11, gp
                  remu         s8, a7, s8
                  mulhsu       s10, s3, s6
                  addi         s11, s7, -143
                  addi         s11, s7, -143
                  mulh         gp, s3, s7
                  divu         a7, s10, a7
                  rem          s7, s11, gp #end riscv_int_numeric_corner_stream_22
                  sub          t3, a0, t2
                  mulhu        s5, t3, zero
                  sra          s1, s7, t6
                  nop
                  sra          s1, s7, t6
                  c.or         a2, a3
                  c.nop
                  divu         sp, t2, s2
                  xor          s5, s7, t6
                  srai         s11, a5, 6
                  slti         s6, tp, 996
                  andi         s6, a4, 204
                  c.andi       s0, -1
                  c.nop
                  c.mv         s6, sp
                  mulh         t4, s3, s10
                  c.mv         s6, sp
                  divu         sp, t2, s2
                  c.andi       s0, -1
                  c.add        ra, a0
                  c.addi4spn   a1, sp, 480
                  sltu         t1, a6, a2
                  c.li         gp, -1
                  mul          s11, a6, a7
                  addi         s11, s11, -143
                  divu         sp, t2, s2
                  rem          s8, t3, s11
                  c.addi       s5, -1
                  auipc        zero, 631536
                  c.addi16sp   sp, 384
                  mulh         t4, s3, s10
                  auipc        zero, 631536
                  lui          t4, 172841
                  ori          s1, a7, 303
                  c.lui        t2, 18
                  divu         sp, t2, s2
                  c.mv         s6, sp
                  c.xor        a2, a5
                  or           s8, s8, t2
                  mulhsu       a1, gp, a0
                  rem          s8, t3, s11
                  sltiu        t6, sp, 205
                  addi         s11, s11, -143
                  slli         t0, zero, 18
                  srli         tp, ra, 29
                  c.add        ra, a0
                  c.slli       a5, 14
                  c.andi       s0, -1
                  ori          s1, a7, 303
                  c.lui        t2, 18
                  rem          s8, t3, s11
                  c.addi16sp   sp, 384
                  c.srli       s1, 18
                  c.and        a1, a3
                  mulhu        s5, t3, zero
                  sltiu        t6, sp, 205
                  xori         t0, t6, -1239
                  c.nop
                  nop
                  c.or         a2, a3
                  divu         sp, t2, s2
                  div          s8, ra, a4
                  or           s8, s8, t2
                  c.li         gp, -1
                  c.sub        s0, s0
                  and          a1, s3, s0
                  nop
                  ori          s1, a7, 303
                  nop
                  divu         sp, t2, s2
                  mul          s11, a6, a7
                  slti         s6, tp, 996
                  mulhu        s5, t3, zero
                  addi         s11, s11, -143
                  slti         s6, tp, 996
                  slti         s6, tp, 996
                  slti         s6, tp, 996
                  c.lui        t2, 18
                  c.nop
                  add          s2, gp, s8
                  mulhsu       a1, gp, a0
                  ori          s1, a7, 303
                  sll          a2, t6, tp
                  c.addi16sp   sp, 384
                  c.addi4spn   a1, sp, 480
                  c.lui        t2, 18
                  srli         tp, ra, 29
                  c.addi16sp   sp, 384
                  andi         s6, a4, 204
                  sll          a2, t6, tp
                  add          s2, gp, s8
                  c.slli       a5, 14
                  addi         s11, s11, -143
                  or           s8, s8, t2
                  c.addi       s5, -1
                  addi         s11, s11, -143
                  c.andi       s0, -1
                  mulhu        s5, t3, zero
                  slt          s6, s6, gp
                  c.and        a1, a3
                  and          a1, s3, s0
                  addi         s11, s11, -143
                  nop
                  rem          s8, t3, s11
                  c.lui        t2, 18
                  add          s2, gp, s8
                  mulhsu       a1, gp, a0
                  c.mv         s6, sp
                  rem          s8, t3, s11
                  mulhu        s5, t3, zero
                  srl          a6, s8, s9
                  sll          a2, t6, tp
                  c.or         a2, a3
                  nop
                  c.sub        s0, s0
                  c.or         a2, a3
                  c.slli       a5, 14
                  c.addi16sp   sp, 384
                  c.addi4spn   a1, sp, 480
                  c.lui        t2, 18
                  add          s2, gp, s8
                  add          s2, gp, s8
                  c.or         a2, a3
                  c.li         gp, -1
                  mul          s11, a6, a7
                  auipc        zero, 631536
                  c.slli       a5, 14
                  c.andi       s0, -1
                  or           s8, s8, t2
                  and          a1, s3, s0
                  srai         s11, a5, 6
                  mul          s11, a6, a7
                  sltu         t1, a6, a2
                  lui          t4, 172841
                  slt          s6, s6, gp
                  mulhu        s5, t3, zero
                  divu         sp, t2, s2
                  c.nop
                  c.and        a1, a3
                  c.addi16sp   sp, 384
                  c.or         a2, a3
                  c.addi16sp   sp, 384
                  srli         tp, ra, 29
                  c.mv         s6, sp
                  srai         s11, a5, 6
                  mulhsu       a1, gp, a0
                  c.addi4spn   a1, sp, 480
                  xori         t0, t6, -1239
                  slti         s6, tp, 996
                  slt          s6, s6, gp
                  mulhu        s5, t3, zero
                  xori         t0, t6, -1239
                  srai         s11, a5, 6
                  xor          s5, s7, t6
                  c.or         a2, a3
                  c.sub        s0, s0
                  rem          s8, t3, s11
                  sub          t3, a0, t2
                  c.srli       s1, 18
                  or           s8, s8, t2
                  sub          t3, a0, t2
                  c.li         gp, -1
                  c.slli       a5, 14
                  c.add        ra, a0
                  c.addi       s5, -1
                  c.srli       s1, 18
                  nop
                  sltiu        t6, sp, 205
                  sll          a2, t6, tp
                  divu         sp, t2, s2
                  srai         s11, a5, 6
                  sltu         t1, a6, a2
                  c.and        a1, a3
                  mulhu        s5, t3, zero
                  slti         s6, tp, 996
                  c.xor        a2, a5
                  ori          s1, a7, 303
                  c.lui        t2, 18
                  c.or         a2, a3
                  c.li         gp, -1
                  c.srli       s1, 18
                  c.or         a2, a3
                  c.srai       s1, 8
                  mulh         t4, s3, s10
                  remu         s9, a2, t1
                  nop
                  auipc        zero, 631536
                  sltiu        t6, sp, 205
                  addi         s11, s11, -143
                  c.mv         s6, sp
                  slti         s6, tp, 996
                  c.andi       s0, -1
                  mul          s11, a6, a7
                  c.addi16sp   sp, 384
                  sub          t3, a0, t2
                  c.srai       s1, 8
                  or           s8, s8, t2
                  c.addi4spn   a1, sp, 480
                  c.sub        s0, s0
                  srl          a6, s8, s9
                  c.addi       s5, -1
                  li           s7, 0xebeb8807 #start riscv_int_numeric_corner_stream_12
                  li           a5, 0xffffffff
                  li           t0, 0xffffffff
                  li           s8, 0x80000000
                  li           t3, 0x9dddbd63
                  li           sp, 0x2f6e5564
                  li           s9, 0x53ccbac3
                  li           tp, 0x0
                  li           s11, 0xffffffff
                  li           s10, 0xb6324193
                  divu         t0, s10, t0
                  auipc        sp, 631536
                  mulhu        t0, s11, sp
                  mul          s11, sp, tp
                  rem          s8, s11, sp
                  addi         s11, s8, -143
                  auipc        sp, 631536
                  lui          t3, 172841
                  rem          s8, s11, sp
                  div          s8, tp, t3
                  mul          s11, sp, tp
                  sub          t3, t3, s10
                  remu         s9, t0, s9
                  divu         t0, s10, t0
                  remu         s9, t0, s9
                  add          sp, a5, s11
                  rem          s8, s11, sp
                  remu         s9, t0, s9
                  div          s8, tp, t3
                  div          s8, tp, t3
                  mulhsu       s10, a5, s7
                  remu         s9, t0, s9
                  auipc        sp, 631536
                  mulh         sp, a5, s8
                  sub          t3, t3, s10 #end riscv_int_numeric_corner_stream_12
                  sltu         t1, a6, a2
                  c.addi       s5, -1
                  sra          s1, s7, t6
                  c.or         a2, a3
                  c.addi16sp   sp, 384
                  c.add        ra, a0
                  nop
                  mul          s11, a6, a7
                  sub          t3, a0, t2
                  c.addi4spn   a1, sp, 480
                  c.addi16sp   sp, 384
                  slt          s6, s6, gp
                  sll          a2, t6, tp
                  c.xor        a2, a5
                  mulh         t4, s3, s10
                  addi         s11, s11, -143
                  sltu         t1, a6, a2
                  c.xor        a2, a5
                  divu         sp, t2, s2
                  mulhsu       a1, gp, a0
                  c.xor        a2, a5
                  mul          s11, a6, a7
                  c.addi4spn   a1, sp, 480
                  c.li         gp, -1
                  c.addi       s5, -1
                  c.nop
                  srli         tp, ra, 29
                  c.addi       s5, -1
                  remu         s9, a2, t1
                  c.and        a1, a3
                  mul          s11, a6, a7
                  c.add        ra, a0
                  add          s2, gp, s8
                  c.add        ra, a0
                  and          a1, s3, s0
                  c.slli       a5, 14
                  c.andi       s0, -1
                  slt          s6, s6, gp
                  sra          s1, s7, t6
                  slli         t0, zero, 18
                  c.add        ra, a0
                  divu         sp, t2, s2
                  slt          s6, s6, gp
                  sub          t3, a0, t2
                  slli         t0, zero, 18
                  c.li         gp, -1
                  sltiu        t6, sp, 205
                  ori          s1, a7, 303
                  mul          s11, a6, a7
                  c.and        a1, a3
                  sltu         t1, a6, a2
                  c.add        ra, a0
                  c.sub        s0, s0
                  c.sub        s0, s0
                  andi         s6, a4, 204
                  sub          t3, a0, t2
                  c.sub        s0, s0
                  xori         t0, t6, -1239
                  c.nop
                  sll          a2, t6, tp
                  srli         tp, ra, 29
                  srai         s11, a5, 6
                  ori          s1, a7, 303
                  c.slli       a5, 14
                  addi         s11, s11, -143
                  c.add        ra, a0
                  srli         tp, ra, 29
                  mul          s11, a6, a7
                  sra          s1, s7, t6
                  c.add        ra, a0
                  mulhsu       a1, gp, a0
                  andi         s6, a4, 204
                  slli         t0, zero, 18
                  andi         s6, a4, 204
                  divu         sp, t2, s2
                  mulhu        s5, t3, zero
                  xori         t0, t6, -1239
                  c.slli       a5, 14
                  c.slli       a5, 14
                  nop
                  c.nop
                  c.mv         s6, sp
                  c.lui        t2, 18
                  c.andi       s0, -1
                  c.srli       s1, 18
                  srl          a6, s8, s9
                  remu         s9, a2, t1
                  and          a1, s3, s0
                  c.add        ra, a0
                  c.xor        a2, a5
                  remu         s9, a2, t1
                  c.and        a1, a3
                  rem          s8, t3, s11
                  c.slli       a5, 14
                  and          a1, s3, s0
                  slli         t0, zero, 18
                  mulhsu       a1, gp, a0
                  c.and        a1, a3
                  sltu         t1, a6, a2
                  add          s2, gp, s8
                  xori         t0, t6, -1239
                  divu         sp, t2, s2
                  c.add        ra, a0
                  addi         s11, s11, -143
                  nop
                  sltu         t1, a6, a2
                  divu         sp, t2, s2
                  remu         s9, a2, t1
                  sub          t3, a0, t2
                  srli         tp, ra, 29
                  mulhsu       a1, gp, a0
                  c.nop
                  mul          s11, a6, a7
                  c.sub        s0, s0
                  sra          s1, s7, t6
                  c.xor        a2, a5
                  sll          a2, t6, tp
                  or           s8, s8, t2
                  and          a1, s3, s0
                  c.or         a2, a3
                  c.slli       a5, 14
                  c.li         gp, -1
                  xori         t0, t6, -1239
                  c.addi       s5, -1
                  remu         s9, a2, t1
                  c.and        a1, a3
                  li           s1, 0x0 #start riscv_int_numeric_corner_stream_18
                  li           s0, 0x0
                  li           t1, 0x80000000
                  li           a3, 0xffffffff
                  li           s8, 0x2f9a4952
                  li           s6, 0x80000000
                  li           t6, 0x80000000
                  li           t0, 0x93de75f
                  li           a1, 0x0
                  li           s11, 0x0
                  mul          s11, t0, t1
                  nop
                  sub          t6, t6, s8
                  add          t0, s1, s11
                  sub          t6, t6, s8
                  add          t0, s1, s11
                  rem          a3, s11, t0
                  sub          t6, t6, s8
                  add          t0, s1, s11
                  auipc        t0, 631536
                  mulhsu       s8, s1, a1
                  rem          a3, s11, t0
                  rem          a3, s11, t0
                  auipc        t0, 631536
                  mulhu        s0, s11, t0 #end riscv_int_numeric_corner_stream_18
                  c.nop
                  c.mv         s6, sp
                  c.xor        a2, a5
                  c.nop
                  sltiu        t6, sp, 205
                  c.add        ra, a0
                  c.add        ra, a0
                  sra          s1, s7, t6
                  sll          a2, t6, tp
                  sltiu        t6, sp, 205
                  sltu         t1, a6, a2
                  sra          s1, s7, t6
                  c.lui        t2, 18
                  mul          s11, a6, a7
                  remu         s9, a2, t1
                  rem          s8, t3, s11
                  c.sub        s0, s0
                  andi         s6, a4, 204
                  remu         s9, a2, t1
                  sltiu        t6, sp, 205
                  sltiu        t6, sp, 205
                  c.sub        s0, s0
                  c.or         a2, a3
                  c.lui        t2, 18
                  mul          s11, a6, a7
                  c.lui        t2, 18
                  c.addi       s5, -1
                  sltu         t1, a6, a2
                  divu         sp, t2, s2
                  c.and        a1, a3
                  c.addi       s5, -1
                  c.lui        t2, 18
                  remu         s9, a2, t1
                  andi         s6, a4, 204
                  c.slli       a5, 14
                  mulhu        s5, t3, zero
                  add          s2, gp, s8
                  and          a1, s3, s0
                  div          s8, ra, a4
                  slt          s6, s6, gp
                  mulh         t4, s3, s10
                  c.xor        a2, a5
                  addi         s11, s11, -143
                  rem          s8, t3, s11
                  srai         s11, a5, 6
                  addi         s11, s11, -143
                  slti         s6, tp, 996
                  c.li         gp, -1
                  lui          t4, 172841
                  rem          s8, t3, s11
                  c.add        ra, a0
                  rem          s8, t3, s11
                  c.srai       s1, 8
                  c.andi       s0, -1
                  mulhsu       a1, gp, a0
                  c.srli       s1, 18
                  c.addi       s5, -1
                  xor          s5, s7, t6
                  mulhsu       a1, gp, a0
                  lui          t4, 172841
                  c.slli       a5, 14
                  sltu         t1, a6, a2
                  sltiu        t6, sp, 205
                  c.or         a2, a3
                  c.lui        t2, 18
                  c.slli       a5, 14
                  andi         s6, a4, 204
                  add          s2, gp, s8
                  nop
                  andi         s6, a4, 204
                  slt          s6, s6, gp
                  srai         s11, a5, 6
                  sra          s1, s7, t6
                  rem          s8, t3, s11
                  slli         t0, zero, 18
                  divu         sp, t2, s2
                  mul          s11, a6, a7
                  c.nop
                  add          s2, gp, s8
                  c.or         a2, a3
                  xori         t0, t6, -1239
                  andi         s6, a4, 204
                  divu         sp, t2, s2
                  div          s8, ra, a4
                  slt          s6, s6, gp
                  rem          s8, t3, s11
                  xori         t0, t6, -1239
                  c.sub        s0, s0
                  divu         sp, t2, s2
                  c.srli       s1, 18
                  c.li         gp, -1
                  c.andi       s0, -1
                  c.sub        s0, s0
                  c.sub        s0, s0
                  c.slli       a5, 14
                  nop
                  lui          t4, 172841
                  c.li         gp, -1
                  andi         s6, a4, 204
                  xor          s5, s7, t6
                  c.addi4spn   a1, sp, 480
                  c.or         a2, a3
                  mulh         t4, s3, s10
                  mul          s11, a6, a7
                  nop
                  srai         s11, a5, 6
                  div          s8, ra, a4
                  or           s8, s8, t2
                  slli         t0, zero, 18
                  mul          s11, a6, a7
                  div          s8, ra, a4
                  divu         sp, t2, s2
                  c.xor        a2, a5
                  div          s8, ra, a4
                  c.and        a1, a3
                  slt          s6, s6, gp
                  c.sub        s0, s0
                  auipc        zero, 631536
                  c.andi       s0, -1
                  and          a1, s3, s0
                  c.add        ra, a0
                  and          a1, s3, s0
                  divu         sp, t2, s2
                  and          a1, s3, s0
                  xori         t0, t6, -1239
                  sub          t3, a0, t2
                  srli         tp, ra, 29
                  c.addi16sp   sp, 384
                  sltu         t1, a6, a2
                  c.xor        a2, a5
                  sra          s1, s7, t6
                  srl          a6, s8, s9
                  c.add        ra, a0
                  c.addi4spn   a1, sp, 480
                  sra          s1, s7, t6
                  xor          s5, s7, t6
                  slti         s6, tp, 996
                  mulhu        s5, t3, zero
                  srli         tp, ra, 29
                  and          a1, s3, s0
                  sra          s1, s7, t6
                  mulh         t4, s3, s10
                  add          s2, gp, s8
                  addi         s11, s11, -143
                  srli         tp, ra, 29
                  c.mv         s6, sp
                  div          s8, ra, a4
                  slli         t0, zero, 18
                  xor          s5, s7, t6
                  add          s2, gp, s8
                  sub          t3, a0, t2
                  c.andi       s0, -1
                  c.andi       s0, -1
                  mulhsu       a1, gp, a0
                  xor          s5, s7, t6
                  divu         sp, t2, s2
                  mulh         t4, s3, s10
                  c.slli       a5, 14
                  c.li         gp, -1
                  c.xor        a2, a5
                  c.lui        t2, 18
                  mulh         t4, s3, s10
                  sra          s1, s7, t6
                  mulhu        s5, t3, zero
                  andi         s6, a4, 204
                  div          s8, ra, a4
                  div          s8, ra, a4
                  c.slli       a5, 14
                  sra          s1, s7, t6
                  c.addi16sp   sp, 384
                  sub          t3, a0, t2
                  c.srai       s1, 8
                  c.li         gp, -1
                  c.li         gp, -1
                  srl          a6, s8, s9
                  c.andi       s0, -1
                  rem          s8, t3, s11
                  c.slli       a5, 14
                  c.addi16sp   sp, 384
                  c.sub        s0, s0
                  and          a1, s3, s0
                  sub          t3, a0, t2
                  c.addi       s5, -1
                  c.lui        t2, 18
                  mulhsu       a1, gp, a0
                  divu         sp, t2, s2
                  nop
                  c.srai       s1, 8
                  sll          a2, t6, tp
                  div          s8, ra, a4
                  c.and        a1, a3
                  c.addi16sp   sp, 384
                  c.lui        t2, 18
                  slt          s6, s6, gp
                  sll          a2, t6, tp
                  lui          t4, 172841
                  addi         s11, s11, -143
                  li           s9, 0x0 #start riscv_int_numeric_corner_stream_1
                  li           t4, 0x80000000
                  li           s10, 0x0
                  li           s7, 0xffffffff
                  li           a1, 0x80000000
                  li           t3, 0x0
                  li           s1, 0xffffffff
                  li           tp, 0x80000000
                  li           ra, 0xd923080b
                  li           s8, 0x0
                  div          s8, tp, t4
                  mul          t3, ra, tp
                  sub          t4, t4, s10
                  sub          t4, t4, s10
                  mul          t3, ra, tp
                  mulh         ra, a1, s8
                  rem          s8, t3, ra
                  divu         s1, s10, s1
                  nop
                  mulhsu       s10, a1, s7
                  mulhu        s1, t3, ra
                  div          s8, tp, t4
                  auipc        ra, 631536
                  mulhu        s1, t3, ra
                  nop
                  mulh         ra, a1, s8
                  mulhu        s1, t3, ra
                  mulh         ra, a1, s8
                  add          ra, a1, t3
                  addi         t3, s8, -143
                  rem          s8, t3, ra
                  sub          t4, t4, s10
                  div          s8, tp, t4
                  divu         s1, s10, s1
                  auipc        ra, 631536
                  mulhsu       s10, a1, s7
                  add          ra, a1, t3 #end riscv_int_numeric_corner_stream_1
                  sltu         t1, a6, a2
                  add          s2, gp, s8
                  addi         s11, s11, -143
                  mulhu        s5, t3, zero
                  c.xor        a2, a5
                  add          s2, gp, s8
                  xori         t0, t6, -1239
                  lui          t4, 172841
                  c.nop
                  c.mv         s6, sp
                  auipc        zero, 631536
                  slti         s6, tp, 996
                  mul          s11, a6, a7
                  srl          a6, s8, s9
                  c.or         a2, a3
                  auipc        zero, 631536
                  c.and        a1, a3
                  c.srli       s1, 18
                  mulhsu       a1, gp, a0
                  c.add        ra, a0
                  c.srli       s1, 18
                  c.andi       s0, -1
                  sub          t3, a0, t2
                  c.nop
                  add          s2, gp, s8
                  c.andi       s0, -1
                  ori          s1, a7, 303
                  divu         sp, t2, s2
                  c.addi16sp   sp, 384
                  mulh         t4, s3, s10
                  sltu         t1, a6, a2
                  c.addi4spn   a1, sp, 480
                  srl          a6, s8, s9
                  divu         sp, t2, s2
                  andi         s6, a4, 204
                  ori          s1, a7, 303
                  xori         t0, t6, -1239
                  or           s8, s8, t2
                  c.srai       s1, 8
                  xori         t0, t6, -1239
                  remu         s9, a2, t1
                  sra          s1, s7, t6
                  c.addi       s5, -1
                  add          s2, gp, s8
                  c.lui        t2, 18
                  slli         t0, zero, 18
                  nop
                  nop
                  c.xor        a2, a5
                  mulhu        s5, t3, zero
                  andi         s6, a4, 204
                  auipc        zero, 631536
                  lui          t4, 172841
                  xor          s5, s7, t6
                  add          s2, gp, s8
                  sll          a2, t6, tp
                  mul          s11, a6, a7
                  c.addi4spn   a1, sp, 480
                  c.addi16sp   sp, 384
                  c.lui        t2, 18
                  c.andi       s0, -1
                  ori          s1, a7, 303
                  rem          s8, t3, s11
                  rem          s8, t3, s11
                  srai         s11, a5, 6
                  sltu         t1, a6, a2
                  ori          s1, a7, 303
                  slt          s6, s6, gp
                  c.slli       a5, 14
                  mulhu        s5, t3, zero
                  srli         tp, ra, 29
                  sra          s1, s7, t6
                  c.addi4spn   a1, sp, 480
                  c.and        a1, a3
                  c.andi       s0, -1
                  remu         s9, a2, t1
                  lui          t4, 172841
                  sub          t3, a0, t2
                  slli         t0, zero, 18
                  c.srli       s1, 18
                  div          s8, ra, a4
                  nop
                  c.andi       s0, -1
                  slti         s6, tp, 996
                  sub          t3, a0, t2
                  rem          s8, t3, s11
                  mulhsu       a1, gp, a0
                  c.or         a2, a3
                  c.and        a1, a3
                  c.lui        t2, 18
                  mul          s11, a6, a7
                  nop
                  sltu         t1, a6, a2
                  c.addi       s5, -1
                  add          s2, gp, s8
                  sltiu        t6, sp, 205
                  mulh         t4, s3, s10
                  or           s8, s8, t2
                  rem          s8, t3, s11
                  ori          s1, a7, 303
                  sltu         t1, a6, a2
                  lui          t4, 172841
                  andi         s6, a4, 204
                  srl          a6, s8, s9
                  sltu         t1, a6, a2
                  c.addi4spn   a1, sp, 480
                  c.nop
                  sra          s1, s7, t6
                  xor          s5, s7, t6
                  or           s8, s8, t2
                  c.addi4spn   a1, sp, 480
                  c.and        a1, a3
                  c.slli       a5, 14
                  sra          s1, s7, t6
                  srai         s11, a5, 6
                  mulhu        s5, t3, zero
                  lui          t4, 172841
                  c.lui        t2, 18
                  c.slli       a5, 14
                  c.slli       a5, 14
                  andi         s6, a4, 204
                  or           s8, s8, t2
                  mul          s11, a6, a7
                  mulh         t4, s3, s10
                  add          s2, gp, s8
                  mulhu        s5, t3, zero
                  c.sub        s0, s0
                  c.lui        t2, 18
                  mulhsu       a1, gp, a0
                  remu         s9, a2, t1
                  c.srli       s1, 18
                  c.slli       a5, 14
                  c.lui        t2, 18
                  add          s2, gp, s8
                  c.andi       s0, -1
                  srai         s11, a5, 6
                  c.nop
                  c.add        ra, a0
                  divu         sp, t2, s2
                  sltiu        t6, sp, 205
                  c.xor        a2, a5
                  c.lui        t2, 18
                  c.xor        a2, a5
                  mulhsu       a1, gp, a0
                  c.or         a2, a3
                  addi         s11, s11, -143
                  and          a1, s3, s0
                  rem          s8, t3, s11
                  divu         sp, t2, s2
                  or           s8, s8, t2
                  slt          s6, s6, gp
                  xori         t0, t6, -1239
                  c.xor        a2, a5
                  c.add        ra, a0
                  c.srli       s1, 18
                  lui          t4, 172841
                  sll          a2, t6, tp
                  c.and        a1, a3
                  slt          s6, s6, gp
                  c.srai       s1, 8
                  c.addi       s5, -1
                  srl          a6, s8, s9
                  xori         t0, t6, -1239
                  sll          a2, t6, tp
                  div          s8, ra, a4
                  c.srli       s1, 18
                  xori         t0, t6, -1239
                  sltiu        t6, sp, 205
                  remu         s9, a2, t1
                  xori         t0, t6, -1239
                  add          s2, gp, s8
                  auipc        zero, 631536
                  add          s2, gp, s8
                  rem          s8, t3, s11
                  c.addi       s5, -1
                  c.andi       s0, -1
                  c.addi16sp   sp, 384
                  rem          s8, t3, s11
                  c.srli       s1, 18
                  rem          s8, t3, s11
                  c.srli       s1, 18
                  slti         s6, tp, 996
                  c.lui        t2, 18
                  slt          s6, s6, gp
                  add          s2, gp, s8
                  ori          s1, a7, 303
                  xori         t0, t6, -1239
                  sra          s1, s7, t6
                  c.srli       s1, 18
                  slti         s6, tp, 996
                  c.srli       s1, 18
                  andi         s6, a4, 204
                  li           a2, 0x80000000 #start riscv_int_numeric_corner_stream_38
                  li           tp, 0x8d05e443
                  li           t3, 0x0
                  li           a6, 0x65ba7d11
                  li           gp, 0x0
                  li           t0, 0xffffffff
                  li           a1, 0xffffffff
                  li           s7, 0xffffffff
                  li           s10, 0x0
                  li           t6, 0xd0764f27
                  mulhu        t0, t3, gp
                  rem          a6, t3, gp
                  rem          a6, t3, gp
                  sub          t6, t6, s10
                  lui          t6, 172841
                  remu         s7, t0, s7
                  add          gp, a1, t3
                  mul          t3, gp, tp
                  mul          t3, gp, tp
                  mulh         gp, a1, a6
                  div          a6, tp, t6
                  divu         t0, s10, t0
                  mulh         gp, a1, a6
                  lui          t6, 172841
                  div          a6, tp, t6
                  divu         t0, s10, t0
                  add          gp, a1, t3
                  mulhu        t0, t3, gp
                  sub          t6, t6, s10
                  sub          t6, t6, s10
                  mulhu        t0, t3, gp
                  rem          a6, t3, gp
                  divu         t0, s10, t0
                  div          a6, tp, t6 #end riscv_int_numeric_corner_stream_38
                  c.sub        s0, s0
                  c.or         a2, a3
                  sltu         t1, a6, a2
                  mulhu        s5, t3, zero
                  slti         s6, tp, 996
                  sltiu        t6, sp, 205
                  or           s8, s8, t2
                  mulhu        s5, t3, zero
                  slt          s6, s6, gp
                  srai         s11, a5, 6
                  c.addi4spn   a1, sp, 480
                  addi         s11, s11, -143
                  srli         tp, ra, 29
                  c.addi16sp   sp, 384
                  xori         t0, t6, -1239
                  remu         s9, a2, t1
                  c.andi       s0, -1
                  sltu         t1, a6, a2
                  div          s8, ra, a4
                  div          s8, ra, a4
                  xori         t0, t6, -1239
                  slti         s6, tp, 996
                  mulhsu       a1, gp, a0
                  c.mv         s6, sp
                  c.nop
                  sra          s1, s7, t6
                  lui          t4, 172841
                  sltiu        t6, sp, 205
                  rem          s8, t3, s11
                  c.srli       s1, 18
                  divu         sp, t2, s2
                  c.srai       s1, 8
                  auipc        zero, 631536
                  c.lui        t2, 18
                  srai         s11, a5, 6
                  c.nop
                  c.andi       s0, -1
                  mulhsu       a1, gp, a0
                  c.and        a1, a3
                  mulhu        s5, t3, zero
                  sltiu        t6, sp, 205
                  c.add        ra, a0
                  c.addi16sp   sp, 384
                  c.slli       a5, 14
                  divu         sp, t2, s2
                  slli         t0, zero, 18
                  c.add        ra, a0
                  c.mv         s6, sp
                  sra          s1, s7, t6
                  srai         s11, a5, 6
                  ori          s1, a7, 303
                  c.or         a2, a3
                  xori         t0, t6, -1239
                  rem          s8, t3, s11
                  c.mv         s6, sp
                  mul          s11, a6, a7
                  c.and        a1, a3
                  nop
                  sltu         t1, a6, a2
                  c.srai       s1, 8
                  sra          s1, s7, t6
                  sra          s1, s7, t6
                  mul          s11, a6, a7
                  c.mv         s6, sp
                  c.or         a2, a3
                  or           s8, s8, t2
                  divu         sp, t2, s2
                  mulh         t4, s3, s10
                  sub          t3, a0, t2
                  xor          s5, s7, t6
                  c.xor        a2, a5
                  c.li         gp, -1
                  c.xor        a2, a5
                  c.mv         s6, sp
                  mulh         t4, s3, s10
                  sub          t3, a0, t2
                  addi         s11, s11, -143
                  xori         t0, t6, -1239
                  xori         t0, t6, -1239
                  c.addi4spn   a1, sp, 480
                  addi         s11, s11, -143
                  remu         s9, a2, t1
                  slti         s6, tp, 996
                  slti         s6, tp, 996
                  andi         s6, a4, 204
                  c.addi4spn   a1, sp, 480
                  rem          s8, t3, s11
                  slti         s6, tp, 996
                  c.srai       s1, 8
                  c.add        ra, a0
                  slt          s6, s6, gp
                  sra          s1, s7, t6
                  sra          s1, s7, t6
                  rem          s8, t3, s11
                  c.xor        a2, a5
                  and          a1, s3, s0
                  ori          s1, a7, 303
                  ori          s1, a7, 303
                  c.addi16sp   sp, 384
                  addi         s11, s11, -143
                  c.add        ra, a0
                  auipc        zero, 631536
                  c.addi4spn   a1, sp, 480
                  c.addi       s5, -1
                  srai         s11, a5, 6
                  and          a1, s3, s0
                  ori          s1, a7, 303
                  c.or         a2, a3
                  ori          s1, a7, 303
                  mulhu        s5, t3, zero
                  auipc        zero, 631536
                  ori          s1, a7, 303
                  c.slli       a5, 14
                  srli         tp, ra, 29
                  xor          s5, s7, t6
                  c.addi4spn   a1, sp, 480
                  c.addi4spn   a1, sp, 480
                  sra          s1, s7, t6
                  sub          t3, a0, t2
                  ori          s1, a7, 303
                  sltiu        t6, sp, 205
                  c.slli       a5, 14
                  c.mv         s6, sp
                  sub          t3, a0, t2
                  slti         s6, tp, 996
                  mul          s11, a6, a7
                  c.and        a1, a3
                  c.add        ra, a0
                  sra          s1, s7, t6
                  slt          s6, s6, gp
                  c.slli       a5, 14
                  srl          a6, s8, s9
                  c.li         gp, -1
                  andi         s6, a4, 204
                  c.addi4spn   a1, sp, 480
                  sub          t3, a0, t2
                  lui          t4, 172841
                  div          s8, ra, a4
                  srai         s11, a5, 6
                  xor          s5, s7, t6
                  c.addi       s5, -1
                  slli         t0, zero, 18
                  div          s8, ra, a4
                  c.xor        a2, a5
                  add          s2, gp, s8
                  xori         t0, t6, -1239
                  andi         s6, a4, 204
                  div          s8, ra, a4
                  c.and        a1, a3
                  c.and        a1, a3
                  c.slli       a5, 14
                  c.add        ra, a0
                  and          a1, s3, s0
                  srli         tp, ra, 29
                  divu         sp, t2, s2
                  mulh         t4, s3, s10
                  add          s2, gp, s8
                  slt          s6, s6, gp
                  div          s8, ra, a4
                  ori          s1, a7, 303
                  slli         t0, zero, 18
                  c.srli       s1, 18
                  lui          t4, 172841
                  mulh         t4, s3, s10
                  c.srai       s1, 8
                  slt          s6, s6, gp
                  remu         s9, a2, t1
                  c.andi       s0, -1
                  sltiu        t6, sp, 205
                  remu         s9, a2, t1
                  c.addi       s5, -1
                  srai         s11, a5, 6
                  or           s8, s8, t2
                  mulhsu       a1, gp, a0
                  divu         sp, t2, s2
                  c.slli       a5, 14
                  mul          s11, a6, a7
                  rem          s8, t3, s11
                  c.addi4spn   a1, sp, 480
                  c.andi       s0, -1
                  c.nop
                  xori         t0, t6, -1239
                  srli         tp, ra, 29
                  divu         sp, t2, s2
                  mulhsu       a1, gp, a0
                  c.srli       s1, 18
                  andi         s6, a4, 204
                  srl          a6, s8, s9
                  and          a1, s3, s0
                  c.and        a1, a3
                  c.addi16sp   sp, 384
                  sub          t3, a0, t2
                  nop
                  c.xor        a2, a5
                  remu         s9, a2, t1
                  mulhsu       a1, gp, a0
                  c.mv         s6, sp
                  or           s8, s8, t2
                  mul          s11, a6, a7
                  mul          s11, a6, a7
                  srl          a6, s8, s9
                  sltu         t1, a6, a2
                  addi         s11, s11, -143
                  c.andi       s0, -1
                  c.slli       a5, 14
                  c.slli       a5, 14
                  div          s8, ra, a4
                  sltiu        t6, sp, 205
                  lui          t4, 172841
                  c.addi4spn   a1, sp, 480
                  sll          a2, t6, tp
                  or           s8, s8, t2
                  c.srai       s1, 8
                  c.li         gp, -1
                  and          a1, s3, s0
                  mulhsu       a1, gp, a0
                  c.nop
                  divu         sp, t2, s2
                  mulhu        s5, t3, zero
                  mulh         t4, s3, s10
                  addi         s11, s11, -143
                  addi         s11, s11, -143
                  rem          s8, t3, s11
                  c.andi       s0, -1
                  xori         t0, t6, -1239
                  c.and        a1, a3
                  andi         s6, a4, 204
                  c.add        ra, a0
                  slti         s6, tp, 996
                  xori         t0, t6, -1239
                  c.srai       s1, 8
                  xori         t0, t6, -1239
                  ori          s1, a7, 303
                  srli         tp, ra, 29
                  srai         s11, a5, 6
                  mulhsu       a1, gp, a0
                  sra          s1, s7, t6
                  c.srli       s1, 18
                  c.addi4spn   a1, sp, 480
                  c.andi       s0, -1
                  sra          s1, s7, t6
                  or           s8, s8, t2
                  slli         t0, zero, 18
                  lui          t4, 172841
                  divu         sp, t2, s2
                  c.nop
                  sltu         t1, a6, a2
                  sll          a2, t6, tp
                  c.addi       s5, -1
                  c.srli       s1, 18
                  c.srli       s1, 18
                  c.sub        s0, s0
                  ori          s1, a7, 303
                  c.addi16sp   sp, 384
                  mul          s11, a6, a7
                  ori          s1, a7, 303
                  c.addi16sp   sp, 384
                  srai         s11, a5, 6
                  sltu         t1, a6, a2
                  srli         tp, ra, 29
                  c.nop
                  srl          a6, s8, s9
                  ori          s1, a7, 303
                  c.add        ra, a0
                  c.slli       a5, 14
                  andi         s6, a4, 204
                  lui          t4, 172841
                  c.andi       s0, -1
                  ori          s1, a7, 303
                  c.li         gp, -1
                  rem          s8, t3, s11
                  c.andi       s0, -1
                  c.and        a1, a3
                  c.srli       s1, 18
                  xor          s5, s7, t6
                  xor          s5, s7, t6
                  slti         s6, tp, 996
                  sra          s1, s7, t6
                  lui          t4, 172841
                  addi         s11, s11, -143
                  c.sub        s0, s0
                  mul          s11, a6, a7
                  add          s2, gp, s8
                  nop
                  sra          s1, s7, t6
                  c.slli       a5, 14
                  xori         t0, t6, -1239
                  c.srli       s1, 18
                  xori         t0, t6, -1239
                  div          s8, ra, a4
                  mul          s11, a6, a7
                  or           s8, s8, t2
                  c.addi4spn   a1, sp, 480
                  c.srai       s1, 8
                  srli         tp, ra, 29
                  c.mv         s6, sp
                  srl          a6, s8, s9
                  sub          t3, a0, t2
                  addi         s11, s11, -143
                  slt          s6, s6, gp
                  mulh         t4, s3, s10
                  sll          a2, t6, tp
                  auipc        zero, 631536
                  c.addi16sp   sp, 384
                  mul          s11, a6, a7
                  add          s2, gp, s8
                  mul          s11, a6, a7
                  sub          t3, a0, t2
                  c.and        a1, a3
                  c.addi       s5, -1
                  c.li         gp, -1
                  xori         t0, t6, -1239
                  sub          t3, a0, t2
                  c.and        a1, a3
                  c.addi16sp   sp, 384
                  auipc        zero, 631536
                  slt          s6, s6, gp
                  andi         s6, a4, 204
                  srai         s11, a5, 6
                  slli         t0, zero, 18
                  slli         t0, zero, 18
                  c.mv         s6, sp
                  ori          s1, a7, 303
                  c.srai       s1, 8
                  xor          s5, s7, t6
                  sub          t3, a0, t2
                  c.addi16sp   sp, 384
                  mul          s11, a6, a7
                  c.nop
                  xor          s5, s7, t6
                  sltiu        t6, sp, 205
                  lui          t4, 172841
                  xori         t0, t6, -1239
                  c.slli       a5, 14
                  sra          s1, s7, t6
                  srl          a6, s8, s9
                  mulh         t4, s3, s10
                  mul          s11, a6, a7
                  rem          s8, t3, s11
                  c.addi16sp   sp, 384
                  add          s2, gp, s8
                  rem          s8, t3, s11
                  sra          s1, s7, t6
                  c.li         gp, -1
                  addi         s11, s11, -143
                  c.li         gp, -1
                  div          s8, ra, a4
                  c.addi16sp   sp, 384
                  sltiu        t6, sp, 205
                  lui          t4, 172841
                  divu         sp, t2, s2
                  c.slli       a5, 14
                  c.slli       a5, 14
                  remu         s9, a2, t1
                  c.lui        t2, 18
                  slli         t0, zero, 18
                  c.addi       s5, -1
                  c.sub        s0, s0
                  c.slli       a5, 14
                  xor          s5, s7, t6
                  c.or         a2, a3
                  slt          s6, s6, gp
                  srl          a6, s8, s9
                  addi         s11, s11, -143
                  sll          a2, t6, tp
                  srai         s11, a5, 6
                  mul          s11, a6, a7
                  addi         s11, s11, -143
                  srli         tp, ra, 29
                  c.srli       s1, 18
                  xor          s5, s7, t6
                  mulhsu       a1, gp, a0
                  div          s8, ra, a4
                  c.nop
                  srl          a6, s8, s9
                  c.sub        s0, s0
                  slli         t0, zero, 18
                  add          s2, gp, s8
                  sra          s1, s7, t6
                  and          a1, s3, s0
                  srai         s11, a5, 6
                  c.or         a2, a3
                  slt          s6, s6, gp
                  auipc        zero, 631536
                  srli         tp, ra, 29
                  mulhu        s5, t3, zero
                  srl          a6, s8, s9
                  c.nop
                  c.xor        a2, a5
                  c.addi       s5, -1
                  xori         t0, t6, -1239
                  slli         t0, zero, 18
                  c.srli       s1, 18
                  c.mv         s6, sp
                  mul          s11, a6, a7
                  slt          s6, s6, gp
                  c.addi16sp   sp, 384
                  and          a1, s3, s0
                  c.mv         s6, sp
                  remu         s9, a2, t1
                  xor          s5, s7, t6
                  c.xor        a2, a5
                  lui          t4, 172841
                  mulhu        s5, t3, zero
                  slti         s6, tp, 996
                  auipc        zero, 631536
                  xor          s5, s7, t6
                  sra          s1, s7, t6
                  c.slli       a5, 14
                  divu         sp, t2, s2
                  srai         s11, a5, 6
                  srai         s11, a5, 6
                  c.lui        t2, 18
                  sub          t3, a0, t2
                  sltu         t1, a6, a2
                  and          a1, s3, s0
                  c.or         a2, a3
                  lui          t4, 172841
                  div          s8, ra, a4
                  add          s2, gp, s8
                  slt          s6, s6, gp
                  remu         s9, a2, t1
                  remu         s9, a2, t1
                  srai         s11, a5, 6
                  auipc        zero, 631536
                  andi         s6, a4, 204
                  c.mv         s6, sp
                  slt          s6, s6, gp
                  slli         t0, zero, 18
                  c.srai       s1, 8
                  nop
                  c.and        a1, a3
                  div          s8, ra, a4
                  c.addi16sp   sp, 384
                  sltu         t1, a6, a2
                  rem          s8, t3, s11
                  or           s8, s8, t2
                  c.srai       s1, 8
                  c.lui        t2, 18
                  and          a1, s3, s0
                  mulhu        s5, t3, zero
                  sltiu        t6, sp, 205
                  mulh         t4, s3, s10
                  remu         s9, a2, t1
                  sltiu        t6, sp, 205
                  nop
                  mulhsu       a1, gp, a0
                  sub          t3, a0, t2
                  slli         t0, zero, 18
                  c.li         gp, -1
                  c.lui        t2, 18
                  xor          s5, s7, t6
                  c.mv         s6, sp
                  mulhu        s5, t3, zero
                  c.or         a2, a3
                  mul          s11, a6, a7
                  slti         s6, tp, 996
                  c.srli       s1, 18
                  c.xor        a2, a5
                  c.or         a2, a3
                  c.addi4spn   a1, sp, 480
                  divu         sp, t2, s2
                  c.lui        t2, 18
                  c.srai       s1, 8
                  sltu         t1, a6, a2
                  or           s8, s8, t2
                  c.srai       s1, 8
                  mulhsu       a1, gp, a0
                  sll          a2, t6, tp
                  sll          a2, t6, tp
                  c.mv         s6, sp
                  c.li         gp, -1
                  sltu         t1, a6, a2
                  divu         sp, t2, s2
                  xor          s5, s7, t6
                  c.and        a1, a3
                  c.nop
                  xori         t0, t6, -1239
                  c.and        a1, a3
                  mulhu        s5, t3, zero
                  rem          s8, t3, s11
                  c.mv         s6, sp
                  mulhsu       a1, gp, a0
                  or           s8, s8, t2
                  mulhsu       a1, gp, a0
                  ori          s1, a7, 303
                  srl          a6, s8, s9
                  auipc        zero, 631536
                  sub          t3, a0, t2
                  c.andi       s0, -1
                  c.or         a2, a3
                  xori         t0, t6, -1239
                  div          s8, ra, a4
                  c.or         a2, a3
                  sll          a2, t6, tp
                  c.addi16sp   sp, 384
                  srai         s11, a5, 6
                  ori          s1, a7, 303
                  c.add        ra, a0
                  divu         sp, t2, s2
                  nop
                  slti         s6, tp, 996
                  mulhu        s5, t3, zero
                  srl          a6, s8, s9
                  c.xor        a2, a5
                  sltiu        t6, sp, 205
                  sltiu        t6, sp, 205
                  c.srai       s1, 8
                  srai         s11, a5, 6
                  c.mv         s6, sp
                  c.slli       a5, 14
                  c.srli       s1, 18
                  add          s2, gp, s8
                  srl          a6, s8, s9
                  div          s8, ra, a4
                  slti         s6, tp, 996
                  c.andi       s0, -1
                  c.addi16sp   sp, 384
                  c.lui        t2, 18
                  sll          a2, t6, tp
                  srl          a6, s8, s9
                  lui          t4, 172841
                  slti         s6, tp, 996
                  andi         s6, a4, 204
                  auipc        zero, 631536
                  c.addi16sp   sp, 384
                  rem          s8, t3, s11
                  divu         sp, t2, s2
                  c.slli       a5, 14
                  c.srai       s1, 8
                  rem          s8, t3, s11
                  sll          a2, t6, tp
                  ori          s1, a7, 303
                  mulhu        s5, t3, zero
                  c.and        a1, a3
                  c.addi       s5, -1
                  rem          s8, t3, s11
                  c.addi4spn   a1, sp, 480
                  add          s2, gp, s8
                  c.addi16sp   sp, 384
                  c.srli       s1, 18
                  nop
                  slti         s6, tp, 996
                  remu         s9, a2, t1
                  slt          s6, s6, gp
                  addi         s11, s11, -143
                  mulhsu       a1, gp, a0
                  sltu         t1, a6, a2
                  mulh         t4, s3, s10
                  or           s8, s8, t2
                  ori          s1, a7, 303
                  div          s8, ra, a4
                  c.addi4spn   a1, sp, 480
                  srl          a6, s8, s9
                  or           s8, s8, t2
                  nop
                  c.add        ra, a0
                  sltu         t1, a6, a2
                  mul          s11, a6, a7
                  add          s2, gp, s8
                  lui          t4, 172841
                  srli         tp, ra, 29
                  c.addi4spn   a1, sp, 480
                  c.lui        t2, 18
                  c.andi       s0, -1
                  add          s2, gp, s8
                  mul          s11, a6, a7
                  c.or         a2, a3
                  andi         s6, a4, 204
                  c.add        ra, a0
                  sra          s1, s7, t6
                  ori          s1, a7, 303
                  xor          s5, s7, t6
                  andi         s6, a4, 204
                  mul          s11, a6, a7
                  srai         s11, a5, 6
                  auipc        zero, 631536
                  div          s8, ra, a4
                  xor          s5, s7, t6
                  nop
                  and          a1, s3, s0
                  div          s8, ra, a4
                  c.sub        s0, s0
                  remu         s9, a2, t1
                  c.addi4spn   a1, sp, 480
                  andi         s6, a4, 204
                  remu         s9, a2, t1
                  srli         tp, ra, 29
                  c.add        ra, a0
                  nop
                  add          s2, gp, s8
                  addi         s11, s11, -143
                  c.or         a2, a3
                  sra          s1, s7, t6
                  xori         t0, t6, -1239
                  c.srli       s1, 18
                  srai         s11, a5, 6
                  c.sub        s0, s0
                  c.li         gp, -1
                  mul          s11, a6, a7
                  auipc        zero, 631536
                  addi         s11, s11, -143
                  c.mv         s6, sp
                  c.sub        s0, s0
                  rem          s8, t3, s11
                  mul          s11, a6, a7
                  c.addi4spn   a1, sp, 480
                  xor          s5, s7, t6
                  sra          s1, s7, t6
                  c.nop
                  c.li         gp, -1
                  sltu         t1, a6, a2
                  addi         s11, s11, -143
                  c.addi4spn   a1, sp, 480
                  divu         sp, t2, s2
                  mulh         t4, s3, s10
                  c.lui        t2, 18
                  addi         s11, s11, -143
                  c.srli       s1, 18
                  divu         sp, t2, s2
                  divu         sp, t2, s2
                  mulh         t4, s3, s10
                  addi         s11, s11, -143
                  add          s2, gp, s8
                  nop
                  and          a1, s3, s0
                  c.nop
                  slli         t0, zero, 18
                  addi         s11, s11, -143
                  addi         s11, s11, -143
                  slti         s6, tp, 996
                  c.slli       a5, 14
                  c.or         a2, a3
                  srli         tp, ra, 29
                  rem          s8, t3, s11
                  c.xor        a2, a5
                  sll          a2, t6, tp
                  c.and        a1, a3
                  and          a1, s3, s0
                  sll          a2, t6, tp
                  c.mv         s6, sp
                  divu         sp, t2, s2
                  divu         sp, t2, s2
                  srli         tp, ra, 29
                  and          a1, s3, s0
                  sltu         t1, a6, a2
                  slt          s6, s6, gp
                  remu         s9, a2, t1
                  c.addi4spn   a1, sp, 480
                  xor          s5, s7, t6
                  sll          a2, t6, tp
                  sub          t3, a0, t2
                  slli         t0, zero, 18
                  auipc        zero, 631536
                  li           a1, 0x80000000 #start riscv_int_numeric_corner_stream_8
                  li           s1, 0x0
                  li           s5, 0x80000000
                  li           s8, 0xffffffff
                  li           t0, 0x80000000
                  li           a7, 0x80000000
                  li           s10, 0xffffffff
                  li           t3, 0x0
                  li           s2, 0x730f798c
                  li           gp, 0x71f2ce3e
                  addi         s10, s2, -143
                  mul          s10, gp, t0
                  lui          t3, 172841
                  lui          t3, 172841
                  nop
                  sub          t3, t3, s8
                  mulhsu       s8, a1, a7
                  mulhsu       s8, a1, a7
                  div          s2, t0, t3
                  addi         s10, s2, -143
                  rem          s2, s10, gp
                  auipc        gp, 631536
                  add          gp, a1, s10
                  mulhu        s1, s10, gp
                  sub          t3, t3, s8
                  div          s2, t0, t3
                  mulhsu       s8, a1, a7
                  add          gp, a1, s10 #end riscv_int_numeric_corner_stream_8
                  c.andi       s0, -1
                  auipc        zero, 631536
                  divu         sp, t2, s2
                  c.li         gp, -1
                  srli         tp, ra, 29
                  div          s8, ra, a4
                  c.li         gp, -1
                  c.lui        t2, 18
                  andi         s6, a4, 204
                  and          a1, s3, s0
                  and          a1, s3, s0
                  mulhu        s5, t3, zero
                  c.addi4spn   a1, sp, 480
                  nop
                  mulhsu       a1, gp, a0
                  or           s8, s8, t2
                  srli         tp, ra, 29
                  divu         sp, t2, s2
                  addi         s11, s11, -143
                  or           s8, s8, t2
                  srai         s11, a5, 6
                  srai         s11, a5, 6
                  c.addi4spn   a1, sp, 480
                  c.slli       a5, 14
                  sra          s1, s7, t6
                  c.andi       s0, -1
                  slli         t0, zero, 18
                  lui          t4, 172841
                  srai         s11, a5, 6
                  c.mv         s6, sp
                  c.srai       s1, 8
                  sltu         t1, a6, a2
                  c.add        ra, a0
                  rem          s8, t3, s11
                  add          s2, gp, s8
                  c.andi       s0, -1
                  nop
                  c.nop
                  c.or         a2, a3
                  c.sub        s0, s0
                  c.xor        a2, a5
                  remu         s9, a2, t1
                  andi         s6, a4, 204
                  c.addi       s5, -1
                  sltiu        t6, sp, 205
                  lui          t4, 172841
                  srai         s11, a5, 6
                  c.addi16sp   sp, 384
                  andi         s6, a4, 204
                  c.sub        s0, s0
                  c.mv         s6, sp
                  c.lui        t2, 18
                  c.slli       a5, 14
                  addi         s11, s11, -143
                  c.and        a1, a3
                  c.addi       s5, -1
                  sll          a2, t6, tp
                  mulhu        s5, t3, zero
                  c.li         gp, -1
                  c.xor        a2, a5
                  c.slli       a5, 14
                  xori         t0, t6, -1239
                  auipc        zero, 631536
                  ori          s1, a7, 303
                  c.add        ra, a0
                  xori         t0, t6, -1239
                  mulhu        s5, t3, zero
                  c.addi       s5, -1
                  mulhsu       a1, gp, a0
                  remu         s9, a2, t1
                  ori          s1, a7, 303
                  sltu         t1, a6, a2
                  c.add        ra, a0
                  remu         s9, a2, t1
                  c.addi4spn   a1, sp, 480
                  c.addi       s5, -1
                  rem          s8, t3, s11
                  auipc        zero, 631536
                  remu         s9, a2, t1
                  c.sub        s0, s0
                  mulhsu       a1, gp, a0
                  c.addi16sp   sp, 384
                  c.addi       s5, -1
                  sub          t3, a0, t2
                  srli         tp, ra, 29
                  c.lui        t2, 18
                  mul          s11, a6, a7
                  slli         t0, zero, 18
                  mulh         t4, s3, s10
                  srl          a6, s8, s9
                  mulh         t4, s3, s10
                  mulhsu       a1, gp, a0
                  c.addi16sp   sp, 384
                  sltiu        t6, sp, 205
                  slti         s6, tp, 996
                  mulhu        s5, t3, zero
                  c.andi       s0, -1
                  srl          a6, s8, s9
                  c.mv         s6, sp
                  andi         s6, a4, 204
                  xori         t0, t6, -1239
                  remu         s9, a2, t1
                  slti         s6, tp, 996
                  srli         tp, ra, 29
                  add          s2, gp, s8
                  and          a1, s3, s0
                  slti         s6, tp, 996
                  c.mv         s6, sp
                  mul          s11, a6, a7
                  mulhsu       a1, gp, a0
                  and          a1, s3, s0
                  auipc        zero, 631536
                  or           s8, s8, t2
                  c.sub        s0, s0
                  andi         s6, a4, 204
                  c.or         a2, a3
                  c.srli       s1, 18
                  c.li         gp, -1
                  sll          a2, t6, tp
                  c.srai       s1, 8
                  srli         tp, ra, 29
                  nop
                  nop
                  c.or         a2, a3
                  nop
                  xori         t0, t6, -1239
                  c.mv         s6, sp
                  nop
                  c.and        a1, a3
                  srl          a6, s8, s9
                  nop
                  c.add        ra, a0
                  andi         s6, a4, 204
                  c.and        a1, a3
                  c.li         gp, -1
                  c.addi       s5, -1
                  rem          s8, t3, s11
                  c.slli       a5, 14
                  xori         t0, t6, -1239
                  mulhu        s5, t3, zero
                  addi         s11, s11, -143
                  add          s2, gp, s8
                  sub          t3, a0, t2
                  mul          s11, a6, a7
                  c.slli       a5, 14
                  c.andi       s0, -1
                  auipc        zero, 631536
                  mulhsu       a1, gp, a0
                  sltiu        t6, sp, 205
                  c.and        a1, a3
                  div          s8, ra, a4
                  divu         sp, t2, s2
                  c.sub        s0, s0
                  mulhu        s5, t3, zero
                  addi         s11, s11, -143
                  sll          a2, t6, tp
                  c.add        ra, a0
                  srai         s11, a5, 6
                  c.slli       a5, 14
                  c.addi4spn   a1, sp, 480
                  c.addi       s5, -1
                  ori          s1, a7, 303
                  andi         s6, a4, 204
                  sub          t3, a0, t2
                  sub          t3, a0, t2
                  c.and        a1, a3
                  c.addi16sp   sp, 384
                  c.addi4spn   a1, sp, 480
                  or           s8, s8, t2
                  mul          s11, a6, a7
                  add          s2, gp, s8
                  ori          s1, a7, 303
                  auipc        zero, 631536
                  sub          t3, a0, t2
                  c.and        a1, a3
                  sltiu        t6, sp, 205
                  mulh         t4, s3, s10
                  ori          s1, a7, 303
                  c.slli       a5, 14
                  srl          a6, s8, s9
                  div          s8, ra, a4
                  mulhsu       a1, gp, a0
                  c.sub        s0, s0
                  slli         t0, zero, 18
                  c.or         a2, a3
                  c.addi16sp   sp, 384
                  lui          t4, 172841
                  c.sub        s0, s0
                  c.xor        a2, a5
                  nop
                  mulhsu       a1, gp, a0
                  c.add        ra, a0
                  c.sub        s0, s0
                  sll          a2, t6, tp
                  c.or         a2, a3
                  srli         tp, ra, 29
                  c.xor        a2, a5
                  auipc        zero, 631536
                  c.xor        a2, a5
                  srli         tp, ra, 29
                  c.and        a1, a3
                  c.nop
                  c.slli       a5, 14
                  c.addi4spn   a1, sp, 480
                  slt          s6, s6, gp
                  and          a1, s3, s0
                  slli         t0, zero, 18
                  c.and        a1, a3
                  divu         sp, t2, s2
                  c.addi4spn   a1, sp, 480
                  auipc        zero, 631536
                  c.srli       s1, 18
                  c.addi4spn   a1, sp, 480
                  mulhu        s5, t3, zero
                  c.add        ra, a0
                  c.addi16sp   sp, 384
                  slti         s6, tp, 996
                  c.li         gp, -1
                  div          s8, ra, a4
                  c.andi       s0, -1
                  slti         s6, tp, 996
                  slti         s6, tp, 996
                  slti         s6, tp, 996
                  c.li         gp, -1
                  rem          s8, t3, s11
                  sub          t3, a0, t2
                  rem          s8, t3, s11
                  mul          s11, a6, a7
                  add          s2, gp, s8
                  mulh         t4, s3, s10
                  c.mv         s6, sp
                  srl          a6, s8, s9
                  c.addi4spn   a1, sp, 480
                  srl          a6, s8, s9
                  srai         s11, a5, 6
                  slli         t0, zero, 18
                  c.mv         s6, sp
                  div          s8, ra, a4
                  srli         tp, ra, 29
                  c.srli       s1, 18
                  rem          s8, t3, s11
                  lui          t4, 172841
                  and          a1, s3, s0
                  slli         t0, zero, 18
                  c.xor        a2, a5
                  ori          s1, a7, 303
                  andi         s6, a4, 204
                  mulh         t4, s3, s10
                  mulhu        s5, t3, zero
                  srli         tp, ra, 29
                  xori         t0, t6, -1239
                  srli         tp, ra, 29
                  rem          s8, t3, s11
                  divu         sp, t2, s2
                  mulh         t4, s3, s10
                  c.srli       s1, 18
                  xor          s5, s7, t6
                  srli         tp, ra, 29
                  c.xor        a2, a5
                  or           s8, s8, t2
                  c.addi       s5, -1
                  addi         s11, s11, -143
                  c.and        a1, a3
                  lui          t4, 172841
                  c.or         a2, a3
                  sub          t3, a0, t2
                  c.nop
                  c.add        ra, a0
                  c.addi       s5, -1
                  c.slli       a5, 14
                  lui          t4, 172841
                  mulhu        s5, t3, zero
                  addi         s11, s11, -143
                  sltu         t1, a6, a2
                  c.mv         s6, sp
                  remu         s9, a2, t1
                  divu         sp, t2, s2
                  sltiu        t6, sp, 205
                  lui          t4, 172841
                  mulhsu       a1, gp, a0
                  c.sub        s0, s0
                  c.or         a2, a3
                  c.lui        t2, 18
                  c.xor        a2, a5
                  slti         s6, tp, 996
                  slli         t0, zero, 18
                  c.nop
                  c.sub        s0, s0
                  c.and        a1, a3
                  sltu         t1, a6, a2
                  c.slli       a5, 14
                  lui          t4, 172841
                  c.addi       s5, -1
                  srai         s11, a5, 6
                  remu         s9, a2, t1
                  sra          s1, s7, t6
                  c.sub        s0, s0
                  sll          a2, t6, tp
                  mulhsu       a1, gp, a0
                  auipc        zero, 631536
                  xor          s5, s7, t6
                  div          s8, ra, a4
                  srl          a6, s8, s9
                  c.or         a2, a3
                  sub          t3, a0, t2
                  add          s2, gp, s8
                  sltu         t1, a6, a2
                  c.andi       s0, -1
                  mulh         t4, s3, s10
                  mul          s11, a6, a7
                  sra          s1, s7, t6
                  mul          s11, a6, a7
                  c.slli       a5, 14
                  c.sub        s0, s0
                  slt          s6, s6, gp
                  xori         t0, t6, -1239
                  srai         s11, a5, 6
                  sltiu        t6, sp, 205
                  c.addi       s5, -1
                  sra          s1, s7, t6
                  xor          s5, s7, t6
                  sub          t3, a0, t2
                  mulh         t4, s3, s10
                  and          a1, s3, s0
                  c.srai       s1, 8
                  c.andi       s0, -1
                  c.add        ra, a0
                  sra          s1, s7, t6
                  c.sub        s0, s0
                  srl          a6, s8, s9
                  mulhsu       a1, gp, a0
                  c.xor        a2, a5
                  add          s2, gp, s8
                  c.slli       a5, 14
                  srli         tp, ra, 29
                  mul          s11, a6, a7
                  c.add        ra, a0
                  xor          s5, s7, t6
                  c.srai       s1, 8
                  slt          s6, s6, gp
                  ori          s1, a7, 303
                  c.addi       s5, -1
                  xor          s5, s7, t6
                  div          s8, ra, a4
                  c.slli       a5, 14
                  nop
                  c.addi4spn   a1, sp, 480
                  c.xor        a2, a5
                  slli         t0, zero, 18
                  c.slli       a5, 14
                  lui          t4, 172841
                  srai         s11, a5, 6
                  c.srli       s1, 18
                  srl          a6, s8, s9
                  c.lui        t2, 18
                  c.sub        s0, s0
                  divu         sp, t2, s2
                  c.addi16sp   sp, 384
                  sltu         t1, a6, a2
                  mulhsu       a1, gp, a0
                  srl          a6, s8, s9
                  c.lui        t2, 18
                  c.srai       s1, 8
                  addi         s11, s11, -143
                  c.add        ra, a0
                  c.sub        s0, s0
                  xor          s5, s7, t6
                  lui          t4, 172841
                  addi         s11, s11, -143
                  slli         t0, zero, 18
                  c.li         gp, -1
                  c.nop
                  c.andi       s0, -1
                  c.lui        t2, 18
                  divu         sp, t2, s2
                  sll          a2, t6, tp
                  c.addi       s5, -1
                  li           a2, 0x1798497d #start riscv_int_numeric_corner_stream_39
                  li           s3, 0x80000000
                  li           s0, 0x5c31aef0
                  li           a6, 0x80000000
                  li           t4, 0x80000000
                  li           t2, 0x0
                  li           a5, 0x0
                  li           t5, 0x80000000
                  li           s6, 0x80000000
                  li           s2, 0x944f97ae
                  lui          t5, 172841
                  add          t2, a5, t4
                  mulhu        a2, t4, t2
                  nop
                  mulh         t2, a5, s2
                  div          s2, s0, t5
                  divu         a2, s6, a2
                  add          t2, a5, t4
                  div          s2, s0, t5
                  mulhsu       s6, a5, a6
                  addi         t4, s2, -143
                  divu         a2, s6, a2
                  divu         a2, s6, a2
                  mulhsu       s6, a5, a6
                  mulhsu       s6, a5, a6
                  nop
                  auipc        t2, 631536
                  mulhu        a2, t4, t2
                  divu         a2, s6, a2
                  mulhsu       s6, a5, a6
                  addi         t4, s2, -143
                  add          t2, a5, t4
                  mulhsu       s6, a5, a6
                  nop
                  mulhsu       s6, a5, a6
                  auipc        t2, 631536
                  sub          t5, t5, s6
                  div          s2, s0, t5
                  mulhu        a2, t4, t2
                  addi         t4, s2, -143 #end riscv_int_numeric_corner_stream_39
                  sltiu        t6, sp, 205
                  sll          a2, t6, tp
                  mul          s11, a6, a7
                  sra          s1, s7, t6
                  c.mv         s6, sp
                  c.xor        a2, a5
                  ori          s1, a7, 303
                  slli         t0, zero, 18
                  rem          s8, t3, s11
                  sll          a2, t6, tp
                  slt          s6, s6, gp
                  andi         s6, a4, 204
                  c.srli       s1, 18
                  andi         s6, a4, 204
                  c.xor        a2, a5
                  div          s8, ra, a4
                  add          s2, gp, s8
                  sltiu        t6, sp, 205
                  slli         t0, zero, 18
                  divu         sp, t2, s2
                  c.sub        s0, s0
                  ori          s1, a7, 303
                  add          s2, gp, s8
                  c.andi       s0, -1
                  c.add        ra, a0
                  c.addi16sp   sp, 384
                  andi         s6, a4, 204
                  andi         s6, a4, 204
                  c.or         a2, a3
                  li           t3, 0x0 #start riscv_int_numeric_corner_stream_2
                  li           sp, 0x0
                  li           s2, 0xffffffff
                  li           ra, 0xffffffff
                  li           a3, 0x6f89b0fe
                  li           gp, 0x0
                  li           a6, 0x0
                  li           tp, 0xb8079b47
                  li           t0, 0x3bcea136
                  li           s3, 0x664f9f65
                  rem          a3, s3, ra
                  nop
                  lui          t3, 172841
                  mulhsu       s2, tp, t0
                  add          ra, tp, s3
                  div          a3, sp, t3
                  sub          t3, t3, s2
                  div          a3, sp, t3
                  mulh         ra, tp, a3
                  div          a3, sp, t3
                  mulh         ra, tp, a3
                  divu         gp, s2, gp
                  nop
                  mulh         ra, tp, a3
                  mulh         ra, tp, a3
                  rem          a3, s3, ra
                  add          ra, tp, s3
                  addi         s3, a3, -143
                  remu         a6, gp, a6
                  nop
                  auipc        ra, 631536 #end riscv_int_numeric_corner_stream_2
                  c.srli       s1, 18
                  c.lui        t2, 18
                  xor          s5, s7, t6
                  sra          s1, s7, t6
                  nop
                  slti         s6, tp, 996
                  sll          a2, t6, tp
                  c.srli       s1, 18
                  mul          s11, a6, a7
                  c.addi       s5, -1
                  c.lui        t2, 18
                  c.nop
                  sra          s1, s7, t6
                  mulhsu       a1, gp, a0
                  andi         s6, a4, 204
                  srai         s11, a5, 6
                  mulhsu       a1, gp, a0
                  srli         tp, ra, 29
                  c.addi16sp   sp, 384
                  sub          t3, a0, t2
                  lui          t4, 172841
                  or           s8, s8, t2
                  add          s2, gp, s8
                  c.li         gp, -1
                  mulh         t4, s3, s10
                  sltu         t1, a6, a2
                  c.andi       s0, -1
                  c.mv         s6, sp
                  c.srli       s1, 18
                  div          s8, ra, a4
                  c.slli       a5, 14
                  rem          s8, t3, s11
                  sltu         t1, a6, a2
                  lui          t4, 172841
                  ori          s1, a7, 303
                  slli         t0, zero, 18
                  c.slli       a5, 14
                  srli         tp, ra, 29
                  slli         t0, zero, 18
                  mulhu        s5, t3, zero
                  div          s8, ra, a4
                  andi         s6, a4, 204
                  srai         s11, a5, 6
                  srl          a6, s8, s9
                  divu         sp, t2, s2
                  c.xor        a2, a5
                  sltu         t1, a6, a2
                  lui          t4, 172841
                  c.xor        a2, a5
                  slti         s6, tp, 996
                  c.slli       a5, 14
                  mul          s11, a6, a7
                  sltu         t1, a6, a2
                  c.addi16sp   sp, 384
                  add          s2, gp, s8
                  mulhu        s5, t3, zero
                  xor          s5, s7, t6
                  mulhu        s5, t3, zero
                  sub          t3, a0, t2
                  mul          s11, a6, a7
                  c.xor        a2, a5
                  sub          t3, a0, t2
                  c.mv         s6, sp
                  c.xor        a2, a5
                  sra          s1, s7, t6
                  sll          a2, t6, tp
                  c.li         gp, -1
                  c.sub        s0, s0
                  div          s8, ra, a4
                  mulhu        s5, t3, zero
                  mulhsu       a1, gp, a0
                  c.lui        t2, 18
                  nop
                  c.addi       s5, -1
                  c.add        ra, a0
                  xor          s5, s7, t6
                  slli         t0, zero, 18
                  div          s8, ra, a4
                  mulh         t4, s3, s10
                  nop
                  slti         s6, tp, 996
                  c.and        a1, a3
                  mulhu        s5, t3, zero
                  c.nop
                  srl          a6, s8, s9
                  nop
                  c.mv         s6, sp
                  remu         s9, a2, t1
                  c.addi16sp   sp, 384
                  c.mv         s6, sp
                  andi         s6, a4, 204
                  c.slli       a5, 14
                  c.xor        a2, a5
                  add          s2, gp, s8
                  c.li         gp, -1
                  andi         s6, a4, 204
                  c.andi       s0, -1
                  c.addi       s5, -1
                  div          s8, ra, a4
                  srli         tp, ra, 29
                  nop
                  lui          t4, 172841
                  c.xor        a2, a5
                  xor          s5, s7, t6
                  c.srai       s1, 8
                  c.srai       s1, 8
                  c.mv         s6, sp
                  rem          s8, t3, s11
                  sltu         t1, a6, a2
                  c.nop
                  c.addi       s5, -1
                  c.sub        s0, s0
                  c.srai       s1, 8
                  nop
                  c.mv         s6, sp
                  lui          t4, 172841
                  remu         s9, a2, t1
                  c.addi16sp   sp, 384
                  c.andi       s0, -1
                  divu         sp, t2, s2
                  c.andi       s0, -1
                  mulh         t4, s3, s10
                  auipc        zero, 631536
                  srl          a6, s8, s9
                  sltu         t1, a6, a2
                  c.lui        t2, 18
                  mul          s11, a6, a7
                  auipc        zero, 631536
                  c.add        ra, a0
                  xori         t0, t6, -1239
                  srli         tp, ra, 29
                  srl          a6, s8, s9
                  ori          s1, a7, 303
                  srl          a6, s8, s9
                  lui          t4, 172841
                  mulhu        s5, t3, zero
                  c.xor        a2, a5
                  auipc        zero, 631536
                  mulhsu       a1, gp, a0
                  add          s2, gp, s8
                  c.addi       s5, -1
                  remu         s9, a2, t1
                  mulhu        s5, t3, zero
                  auipc        zero, 631536
                  c.sub        s0, s0
                  c.addi4spn   a1, sp, 480
                  c.slli       a5, 14
                  add          s2, gp, s8
                  sll          a2, t6, tp
                  sra          s1, s7, t6
                  c.srai       s1, 8
                  c.srli       s1, 18
                  andi         s6, a4, 204
                  remu         s9, a2, t1
                  c.li         gp, -1
                  c.xor        a2, a5
                  c.slli       a5, 14
                  div          s8, ra, a4
                  sll          a2, t6, tp
                  slti         s6, tp, 996
                  xor          s5, s7, t6
                  ori          s1, a7, 303
                  slli         t0, zero, 18
                  srl          a6, s8, s9
                  nop
                  c.or         a2, a3
                  c.slli       a5, 14
                  c.addi       s5, -1
                  c.and        a1, a3
                  sub          t3, a0, t2
                  c.add        ra, a0
                  c.or         a2, a3
                  c.addi       s5, -1
                  sltu         t1, a6, a2
                  c.addi4spn   a1, sp, 480
                  slt          s6, s6, gp
                  c.slli       a5, 14
                  c.nop
                  c.nop
                  c.or         a2, a3
                  mulh         t4, s3, s10
                  slti         s6, tp, 996
                  rem          s8, t3, s11
                  slti         s6, tp, 996
                  c.and        a1, a3
                  c.sub        s0, s0
                  div          s8, ra, a4
                  c.srli       s1, 18
                  c.addi16sp   sp, 384
                  sll          a2, t6, tp
                  c.lui        t2, 18
                  add          s2, gp, s8
                  srai         s11, a5, 6
                  xori         t0, t6, -1239
                  sltiu        t6, sp, 205
                  sub          t3, a0, t2
                  srli         tp, ra, 29
                  sltiu        t6, sp, 205
                  c.sub        s0, s0
                  mulhu        s5, t3, zero
                  sra          s1, s7, t6
                  auipc        zero, 631536
                  mulhu        s5, t3, zero
                  c.andi       s0, -1
                  c.li         gp, -1
                  srl          a6, s8, s9
                  nop
                  slli         t0, zero, 18
                  c.sub        s0, s0
                  sll          a2, t6, tp
                  c.andi       s0, -1
                  srai         s11, a5, 6
                  sra          s1, s7, t6
                  xor          s5, s7, t6
                  c.add        ra, a0
                  mul          s11, a6, a7
                  c.addi16sp   sp, 384
                  nop
                  slli         t0, zero, 18
                  srai         s11, a5, 6
                  c.addi       s5, -1
                  c.addi16sp   sp, 384
                  xori         t0, t6, -1239
                  c.add        ra, a0
                  slt          s6, s6, gp
                  sub          t3, a0, t2
                  sub          t3, a0, t2
                  c.xor        a2, a5
                  xor          s5, s7, t6
                  srl          a6, s8, s9
                  c.srai       s1, 8
                  addi         s11, s11, -143
                  slti         s6, tp, 996
                  add          s2, gp, s8
                  c.srai       s1, 8
                  sra          s1, s7, t6
                  lui          t4, 172841
                  ori          s1, a7, 303
                  auipc        zero, 631536
                  c.mv         s6, sp
                  ori          s1, a7, 303
                  c.add        ra, a0
                  sra          s1, s7, t6
                  c.add        ra, a0
                  c.srai       s1, 8
                  srai         s11, a5, 6
                  xor          s5, s7, t6
                  c.mv         s6, sp
                  remu         s9, a2, t1
                  mulh         t4, s3, s10
                  auipc        zero, 631536
                  c.andi       s0, -1
                  mul          s11, a6, a7
                  slt          s6, s6, gp
                  c.mv         s6, sp
                  andi         s6, a4, 204
                  c.and        a1, a3
                  andi         s6, a4, 204
                  c.srli       s1, 18
                  c.sub        s0, s0
                  c.addi16sp   sp, 384
                  auipc        zero, 631536
                  andi         s6, a4, 204
                  andi         s6, a4, 204
                  addi         s11, s11, -143
                  lui          t4, 172841
                  srai         s11, a5, 6
                  slti         s6, tp, 996
                  mulhsu       a1, gp, a0
                  c.srai       s1, 8
                  mul          s11, a6, a7
                  ori          s1, a7, 303
                  mulhu        s5, t3, zero
                  c.srai       s1, 8
                  c.srli       s1, 18
                  c.srai       s1, 8
                  c.nop
                  auipc        zero, 631536
                  lui          t4, 172841
                  sltu         t1, a6, a2
                  nop
                  rem          s8, t3, s11
                  slt          s6, s6, gp
                  slt          s6, s6, gp
                  div          s8, ra, a4
                  sltiu        t6, sp, 205
                  ori          s1, a7, 303
                  div          s8, ra, a4
                  slti         s6, tp, 996
                  divu         sp, t2, s2
                  c.add        ra, a0
                  c.nop
                  xor          s5, s7, t6
                  sltu         t1, a6, a2
                  remu         s9, a2, t1
                  xor          s5, s7, t6
                  ori          s1, a7, 303
                  li           s2, 0xffffffff #start riscv_int_numeric_corner_stream_19
                  li           gp, 0x29eab0bf
                  li           a3, 0x0
                  li           t0, 0xffffffff
                  li           sp, 0xcd95fbfc
                  li           t3, 0x51ff64d7
                  li           t4, 0xffffffff
                  li           ra, 0x0
                  li           s0, 0xe02faa79
                  li           t2, 0xffffffff
                  auipc        ra, 631536
                  auipc        ra, 631536
                  mulhu        gp, t3, ra
                  mul          t3, ra, sp
                  mulhu        gp, t3, ra
                  mulhu        gp, t3, ra
                  sub          t4, t4, s2
                  nop
                  addi         t3, s0, -143
                  auipc        ra, 631536
                  div          s0, sp, t4
                  sub          t4, t4, s2
                  mulhu        gp, t3, ra
                  auipc        ra, 631536
                  auipc        ra, 631536
                  div          s0, sp, t4
                  add          ra, t0, t3 #end riscv_int_numeric_corner_stream_19
                  c.sub        s0, s0
                  auipc        zero, 631536
                  ori          s1, a7, 303
                  c.sub        s0, s0
                  c.lui        t2, 18
                  mulh         t4, s3, s10
                  srli         tp, ra, 29
                  srai         s11, a5, 6
                  slli         t0, zero, 18
                  divu         sp, t2, s2
                  sub          t3, a0, t2
                  c.li         gp, -1
                  mul          s11, a6, a7
                  c.li         gp, -1
                  slt          s6, s6, gp
                  c.addi4spn   a1, sp, 480
                  or           s8, s8, t2
                  div          s8, ra, a4
                  ori          s1, a7, 303
                  add          s2, gp, s8
                  c.srli       s1, 18
                  ori          s1, a7, 303
                  c.srai       s1, 8
                  slli         t0, zero, 18
                  ori          s1, a7, 303
                  ori          s1, a7, 303
                  mulhu        s5, t3, zero
                  c.sub        s0, s0
                  c.nop
                  ori          s1, a7, 303
                  srl          a6, s8, s9
                  sll          a2, t6, tp
                  add          s2, gp, s8
                  c.srli       s1, 18
                  srai         s11, a5, 6
                  sub          t3, a0, t2
                  c.andi       s0, -1
                  div          s8, ra, a4
                  srl          a6, s8, s9
                  srai         s11, a5, 6
                  c.slli       a5, 14
                  remu         s9, a2, t1
                  sll          a2, t6, tp
                  c.or         a2, a3
                  or           s8, s8, t2
                  c.add        ra, a0
                  c.sub        s0, s0
                  sub          t3, a0, t2
                  divu         sp, t2, s2
                  slt          s6, s6, gp
                  srl          a6, s8, s9
                  c.addi4spn   a1, sp, 480
                  sll          a2, t6, tp
                  c.sub        s0, s0
                  srli         tp, ra, 29
                  mulhsu       a1, gp, a0
                  div          s8, ra, a4
                  xor          s5, s7, t6
                  c.lui        t2, 18
                  mulh         t4, s3, s10
                  slt          s6, s6, gp
                  xor          s5, s7, t6
                  c.srai       s1, 8
                  add          s2, gp, s8
                  andi         s6, a4, 204
                  nop
                  rem          s8, t3, s11
                  xori         t0, t6, -1239
                  c.li         gp, -1
                  c.mv         s6, sp
                  slt          s6, s6, gp
                  sub          t3, a0, t2
                  andi         s6, a4, 204
                  srli         tp, ra, 29
                  c.addi4spn   a1, sp, 480
                  andi         s6, a4, 204
                  c.addi4spn   a1, sp, 480
                  remu         s9, a2, t1
                  xor          s5, s7, t6
                  c.mv         s6, sp
                  sra          s1, s7, t6
                  sltiu        t6, sp, 205
                  srai         s11, a5, 6
                  c.srli       s1, 18
                  ori          s1, a7, 303
                  c.and        a1, a3
                  slt          s6, s6, gp
                  c.li         gp, -1
                  div          s8, ra, a4
                  rem          s8, t3, s11
                  c.addi4spn   a1, sp, 480
                  sltu         t1, a6, a2
                  srl          a6, s8, s9
                  lui          t4, 172841
                  sltiu        t6, sp, 205
                  c.slli       a5, 14
                  c.andi       s0, -1
                  c.addi       s5, -1
                  add          s2, gp, s8
                  slt          s6, s6, gp
                  lui          t4, 172841
                  c.or         a2, a3
                  c.li         gp, -1
                  add          s2, gp, s8
                  mulhsu       a1, gp, a0
                  mulh         t4, s3, s10
                  xor          s5, s7, t6
                  nop
                  c.srai       s1, 8
                  mul          s11, a6, a7
                  sub          t3, a0, t2
                  mulhsu       a1, gp, a0
                  srl          a6, s8, s9
                  lui          t4, 172841
                  or           s8, s8, t2
                  ori          s1, a7, 303
                  divu         sp, t2, s2
                  lui          t4, 172841
                  mulh         t4, s3, s10
                  slli         t0, zero, 18
                  c.srli       s1, 18
                  add          s2, gp, s8
                  xor          s5, s7, t6
                  srl          a6, s8, s9
                  srli         tp, ra, 29
                  slti         s6, tp, 996
                  sltu         t1, a6, a2
                  mulhu        s5, t3, zero
                  add          s2, gp, s8
                  srli         tp, ra, 29
                  rem          s8, t3, s11
                  sll          a2, t6, tp
                  rem          s8, t3, s11
                  or           s8, s8, t2
                  add          s2, gp, s8
                  slti         s6, tp, 996
                  div          s8, ra, a4
                  sra          s1, s7, t6
                  c.addi       s5, -1
                  or           s8, s8, t2
                  srli         tp, ra, 29
                  sub          t3, a0, t2
                  mulh         t4, s3, s10
                  mulhu        s5, t3, zero
                  c.srli       s1, 18
                  mul          s11, a6, a7
                  sra          s1, s7, t6
                  mulhsu       a1, gp, a0
                  sltu         t1, a6, a2
                  srli         tp, ra, 29
                  c.lui        t2, 18
                  slti         s6, tp, 996
                  c.srli       s1, 18
                  c.lui        t2, 18
                  mulhsu       a1, gp, a0
                  slti         s6, tp, 996
                  sra          s1, s7, t6
                  slt          s6, s6, gp
                  add          s2, gp, s8
                  c.nop
                  c.and        a1, a3
                  c.xor        a2, a5
                  mulhu        s5, t3, zero
                  c.xor        a2, a5
                  lui          t4, 172841
                  andi         s6, a4, 204
                  div          s8, ra, a4
                  sltiu        t6, sp, 205
                  slli         t0, zero, 18
                  c.or         a2, a3
                  mulhsu       a1, gp, a0
                  mulhsu       a1, gp, a0
                  sub          t3, a0, t2
                  c.and        a1, a3
                  sub          t3, a0, t2
                  remu         s9, a2, t1
                  sra          s1, s7, t6
                  c.addi4spn   a1, sp, 480
                  sll          a2, t6, tp
                  sub          t3, a0, t2
                  divu         sp, t2, s2
                  addi         s11, s11, -143
                  slli         t0, zero, 18
                  add          s2, gp, s8
                  divu         sp, t2, s2
                  c.add        ra, a0
                  remu         s9, a2, t1
                  srl          a6, s8, s9
                  mulhu        s5, t3, zero
                  auipc        zero, 631536
                  c.slli       a5, 14
                  divu         sp, t2, s2
                  srl          a6, s8, s9
                  and          a1, s3, s0
                  c.or         a2, a3
                  c.srli       s1, 18
                  mulhu        s5, t3, zero
                  remu         s9, a2, t1
                  remu         s9, a2, t1
                  c.sub        s0, s0
                  lui          t4, 172841
                  c.nop
                  lui          t4, 172841
                  sltiu        t6, sp, 205
                  srai         s11, a5, 6
                  nop
                  mul          s11, a6, a7
                  c.sub        s0, s0
                  slt          s6, s6, gp
                  divu         sp, t2, s2
                  c.add        ra, a0
                  c.slli       a5, 14
                  c.slli       a5, 14
                  mulh         t4, s3, s10
                  c.lui        t2, 18
                  slli         t0, zero, 18
                  srai         s11, a5, 6
                  xori         t0, t6, -1239
                  sll          a2, t6, tp
                  xor          s5, s7, t6
                  divu         sp, t2, s2
                  mul          s11, a6, a7
                  c.addi4spn   a1, sp, 480
                  divu         sp, t2, s2
                  divu         sp, t2, s2
                  remu         s9, a2, t1
                  slli         t0, zero, 18
                  mul          s11, a6, a7
                  sltiu        t6, sp, 205
                  c.mv         s6, sp
                  remu         s9, a2, t1
                  lui          t4, 172841
                  c.addi16sp   sp, 384
                  slli         t0, zero, 18
                  c.or         a2, a3
                  divu         sp, t2, s2
                  c.lui        t2, 18
                  c.xor        a2, a5
                  lui          t4, 172841
                  c.or         a2, a3
                  mulhsu       a1, gp, a0
                  and          a1, s3, s0
                  mulhu        s5, t3, zero
                  slli         t0, zero, 18
                  c.lui        t2, 18
                  mulhsu       a1, gp, a0
                  lui          t4, 172841
                  sll          a2, t6, tp
                  add          s2, gp, s8
                  nop
                  c.mv         s6, sp
                  sltiu        t6, sp, 205
                  c.andi       s0, -1
                  andi         s6, a4, 204
                  sltiu        t6, sp, 205
                  c.li         gp, -1
                  lui          t4, 172841
                  rem          s8, t3, s11
                  c.add        ra, a0
                  lui          t4, 172841
                  mulh         t4, s3, s10
                  slti         s6, tp, 996
                  xor          s5, s7, t6
                  c.srai       s1, 8
                  sltu         t1, a6, a2
                  remu         s9, a2, t1
                  mulhsu       a1, gp, a0
                  srai         s11, a5, 6
                  remu         s9, a2, t1
                  c.nop
                  c.li         gp, -1
                  c.andi       s0, -1
                  mul          s11, a6, a7
                  div          s8, ra, a4
                  c.li         gp, -1
                  slli         t0, zero, 18
                  c.and        a1, a3
                  c.and        a1, a3
                  sltiu        t6, sp, 205
                  sltu         t1, a6, a2
                  sltiu        t6, sp, 205
                  c.sub        s0, s0
                  ori          s1, a7, 303
                  nop
                  add          s2, gp, s8
                  andi         s6, a4, 204
                  c.addi4spn   a1, sp, 480
                  sra          s1, s7, t6
                  ori          s1, a7, 303
                  mul          s11, a6, a7
                  sra          s1, s7, t6
                  srli         tp, ra, 29
                  mulhu        s5, t3, zero
                  andi         s6, a4, 204
                  add          s2, gp, s8
                  or           s8, s8, t2
                  mulh         t4, s3, s10
                  c.addi       s5, -1
                  c.add        ra, a0
                  c.and        a1, a3
                  c.lui        t2, 18
                  andi         s6, a4, 204
                  add          s2, gp, s8
                  c.xor        a2, a5
                  c.srli       s1, 18
                  or           s8, s8, t2
                  sub          t3, a0, t2
                  slli         t0, zero, 18
                  sltu         t1, a6, a2
                  sltiu        t6, sp, 205
                  c.lui        t2, 18
                  c.lui        t2, 18
                  rem          s8, t3, s11
                  or           s8, s8, t2
                  srl          a6, s8, s9
                  slti         s6, tp, 996
                  mulhsu       a1, gp, a0
                  c.srli       s1, 18
                  c.andi       s0, -1
                  c.srai       s1, 8
                  sll          a2, t6, tp
                  srl          a6, s8, s9
                  divu         sp, t2, s2
                  xor          s5, s7, t6
                  slt          s6, s6, gp
                  srai         s11, a5, 6
                  andi         s6, a4, 204
                  c.addi       s5, -1
                  nop
                  srl          a6, s8, s9
                  mul          s11, a6, a7
                  add          s2, gp, s8
                  c.and        a1, a3
                  or           s8, s8, t2
                  c.nop
                  c.nop
                  mulhsu       a1, gp, a0
                  slli         t0, zero, 18
                  c.li         gp, -1
                  c.slli       a5, 14
                  xor          s5, s7, t6
                  or           s8, s8, t2
                  sra          s1, s7, t6
                  divu         sp, t2, s2
                  sub          t3, a0, t2
                  c.addi       s5, -1
                  slt          s6, s6, gp
                  sll          a2, t6, tp
                  mul          s11, a6, a7
                  ori          s1, a7, 303
                  sll          a2, t6, tp
                  sll          a2, t6, tp
                  c.and        a1, a3
                  c.and        a1, a3
                  c.mv         s6, sp
                  c.xor        a2, a5
                  add          s2, gp, s8
                  c.and        a1, a3
                  c.srai       s1, 8
                  srli         tp, ra, 29
                  mulhsu       a1, gp, a0
                  rem          s8, t3, s11
                  xor          s5, s7, t6
                  lui          t4, 172841
                  c.lui        t2, 18
                  or           s8, s8, t2
                  mulh         t4, s3, s10
                  srl          a6, s8, s9
                  c.srli       s1, 18
                  c.addi4spn   a1, sp, 480
                  sra          s1, s7, t6
                  c.addi16sp   sp, 384
                  sub          t3, a0, t2
                  sltiu        t6, sp, 205
                  nop
                  ori          s1, a7, 303
                  c.andi       s0, -1
                  rem          s8, t3, s11
                  c.sub        s0, s0
                  lui          t4, 172841
                  c.lui        t2, 18
                  divu         sp, t2, s2
                  srli         tp, ra, 29
                  c.addi4spn   a1, sp, 480
                  andi         s6, a4, 204
                  and          a1, s3, s0
                  mulhu        s5, t3, zero
                  divu         sp, t2, s2
                  srl          a6, s8, s9
                  sll          a2, t6, tp
                  c.li         gp, -1
                  c.addi       s5, -1
                  remu         s9, a2, t1
                  srl          a6, s8, s9
                  xor          s5, s7, t6
                  c.addi       s5, -1
                  nop
                  c.addi4spn   a1, sp, 480
                  sll          a2, t6, tp
                  c.li         gp, -1
                  c.addi16sp   sp, 384
                  remu         s9, a2, t1
                  c.li         gp, -1
                  srai         s11, a5, 6
                  divu         sp, t2, s2
                  divu         sp, t2, s2
                  slt          s6, s6, gp
                  c.and        a1, a3
                  c.srli       s1, 18
                  sltu         t1, a6, a2
                  remu         s9, a2, t1
                  mulhsu       a1, gp, a0
                  srai         s11, a5, 6
                  c.xor        a2, a5
                  nop
                  c.srli       s1, 18
                  srl          a6, s8, s9
                  xor          s5, s7, t6
                  c.or         a2, a3
                  slti         s6, tp, 996
                  sub          t3, a0, t2
                  c.srai       s1, 8
                  c.or         a2, a3
                  c.andi       s0, -1
                  c.srai       s1, 8
                  c.addi16sp   sp, 384
                  and          a1, s3, s0
                  sltiu        t6, sp, 205
                  mul          s11, a6, a7
                  c.add        ra, a0
                  remu         s9, a2, t1
                  sll          a2, t6, tp
                  ori          s1, a7, 303
                  div          s8, ra, a4
                  divu         sp, t2, s2
                  slli         t0, zero, 18
                  c.addi16sp   sp, 384
                  slti         s6, tp, 996
                  and          a1, s3, s0
                  srl          a6, s8, s9
                  c.srli       s1, 18
                  sub          t3, a0, t2
                  sltu         t1, a6, a2
                  c.sub        s0, s0
                  or           s8, s8, t2
                  xori         t0, t6, -1239
                  srl          a6, s8, s9
                  c.xor        a2, a5
                  and          a1, s3, s0
                  slt          s6, s6, gp
                  slt          s6, s6, gp
                  xori         t0, t6, -1239
                  mulhsu       a1, gp, a0
                  c.addi4spn   a1, sp, 480
                  c.xor        a2, a5
                  c.addi       s5, -1
                  mulhu        s5, t3, zero
                  c.addi       s5, -1
                  c.srli       s1, 18
                  lui          t4, 172841
                  srl          a6, s8, s9
                  xori         t0, t6, -1239
                  auipc        zero, 631536
                  c.nop
                  rem          s8, t3, s11
                  rem          s8, t3, s11
                  sltu         t1, a6, a2
                  xor          s5, s7, t6
                  c.nop
                  mulh         t4, s3, s10
                  c.and        a1, a3
                  lui          t4, 172841
                  xor          s5, s7, t6
                  c.nop
                  sltu         t1, a6, a2
                  c.addi       s5, -1
                  mul          s11, a6, a7
                  rem          s8, t3, s11
                  add          s2, gp, s8
                  srli         tp, ra, 29
                  lui          t4, 172841
                  andi         s6, a4, 204
                  mulhu        s5, t3, zero
                  srli         tp, ra, 29
                  sltiu        t6, sp, 205
                  lui          t4, 172841
                  c.nop
                  c.sub        s0, s0
                  add          s2, gp, s8
                  sub          t3, a0, t2
                  add          s2, gp, s8
                  addi         s11, s11, -143
                  slti         s6, tp, 996
                  rem          s8, t3, s11
                  c.andi       s0, -1
                  c.srli       s1, 18
                  rem          s8, t3, s11
                  c.sub        s0, s0
                  add          s2, gp, s8
                  sub          t3, a0, t2
                  add          s2, gp, s8
                  srl          a6, s8, s9
                  div          s8, ra, a4
                  sltiu        t6, sp, 205
                  remu         s9, a2, t1
                  sll          a2, t6, tp
                  ori          s1, a7, 303
                  c.andi       s0, -1
                  c.nop
                  sltu         t1, a6, a2
                  nop
                  lui          t4, 172841
                  c.sub        s0, s0
                  c.addi4spn   a1, sp, 480
                  mulhu        s5, t3, zero
                  c.sub        s0, s0
                  ori          s1, a7, 303
                  ori          s1, a7, 303
                  slti         s6, tp, 996
                  slt          s6, s6, gp
                  slt          s6, s6, gp
                  andi         s6, a4, 204
                  c.andi       s0, -1
                  c.srai       s1, 8
                  ori          s1, a7, 303
                  c.and        a1, a3
                  c.slli       a5, 14
                  sll          a2, t6, tp
                  sltu         t1, a6, a2
                  srli         tp, ra, 29
                  div          s8, ra, a4
                  c.nop
                  c.and        a1, a3
                  c.sub        s0, s0
                  c.addi       s5, -1
                  c.or         a2, a3
                  c.addi       s5, -1
                  c.add        ra, a0
                  c.andi       s0, -1
                  c.andi       s0, -1
                  slt          s6, s6, gp
                  nop
                  c.li         gp, -1
                  and          a1, s3, s0
                  c.sub        s0, s0
                  sub          t3, a0, t2
                  sltiu        t6, sp, 205
                  add          s2, gp, s8
                  c.srli       s1, 18
                  c.lui        t2, 18
                  srli         tp, ra, 29
                  div          s8, ra, a4
                  c.addi16sp   sp, 384
                  srai         s11, a5, 6
                  lui          t4, 172841
                  sltiu        t6, sp, 205
                  ori          s1, a7, 303
                  nop
                  srai         s11, a5, 6
                  c.xor        a2, a5
                  c.add        ra, a0
                  mulhsu       a1, gp, a0
                  c.xor        a2, a5
                  nop
                  c.mv         s6, sp
                  c.xor        a2, a5
                  c.addi       s5, -1
                  sltiu        t6, sp, 205
                  c.addi       s5, -1
                  c.slli       a5, 14
                  c.srai       s1, 8
                  c.or         a2, a3
                  c.srai       s1, 8
                  sltiu        t6, sp, 205
                  mul          s11, a6, a7
                  sra          s1, s7, t6
                  c.li         gp, -1
                  lui          t4, 172841
                  slti         s6, tp, 996
                  and          a1, s3, s0
                  xor          s5, s7, t6
                  sll          a2, t6, tp
                  slli         t0, zero, 18
                  sltiu        t6, sp, 205
                  sra          s1, s7, t6
                  c.nop
                  c.andi       s0, -1
                  c.nop
                  c.srai       s1, 8
                  mulh         t4, s3, s10
                  c.or         a2, a3
                  c.nop
                  mul          s11, a6, a7
                  c.mv         s6, sp
                  c.and        a1, a3
                  c.or         a2, a3
                  sltu         t1, a6, a2
                  div          s8, ra, a4
                  c.srli       s1, 18
                  nop
                  div          s8, ra, a4
                  remu         s9, a2, t1
                  c.addi4spn   a1, sp, 480
                  srli         tp, ra, 29
                  rem          s8, t3, s11
                  sub          t3, a0, t2
                  srli         tp, ra, 29
                  add          s2, gp, s8
                  srl          a6, s8, s9
                  lui          t4, 172841
                  add          s2, gp, s8
                  and          a1, s3, s0
                  or           s8, s8, t2
                  auipc        zero, 631536
                  c.addi       s5, -1
                  c.srli       s1, 18
                  c.andi       s0, -1
                  c.slli       a5, 14
                  mulh         t4, s3, s10
                  sltu         t1, a6, a2
                  mulh         t4, s3, s10
                  xori         t0, t6, -1239
                  srl          a6, s8, s9
                  mulh         t4, s3, s10
                  mul          s11, a6, a7
                  slli         t0, zero, 18
                  addi         s11, s11, -143
                  mulh         t4, s3, s10
                  add          s2, gp, s8
                  c.addi16sp   sp, 384
                  xor          s5, s7, t6
                  c.lui        t2, 18
                  xor          s5, s7, t6
                  add          s2, gp, s8
                  xor          s5, s7, t6
                  srai         s11, a5, 6
                  c.srai       s1, 8
                  mulhu        s5, t3, zero
                  srai         s11, a5, 6
                  mulhu        s5, t3, zero
                  c.li         gp, -1
                  srl          a6, s8, s9
                  or           s8, s8, t2
                  divu         sp, t2, s2
                  srl          a6, s8, s9
                  ori          s1, a7, 303
                  mul          s11, a6, a7
                  srai         s11, a5, 6
                  srai         s11, a5, 6
                  c.andi       s0, -1
                  and          a1, s3, s0
                  slt          s6, s6, gp
                  sub          t3, a0, t2
                  slli         t0, zero, 18
                  c.nop
                  c.and        a1, a3
                  xor          s5, s7, t6
                  srai         s11, a5, 6
                  c.srli       s1, 18
                  c.add        ra, a0
                  andi         s6, a4, 204
                  sltiu        t6, sp, 205
                  sra          s1, s7, t6
                  c.srai       s1, 8
                  div          s8, ra, a4
                  c.srli       s1, 18
                  remu         s9, a2, t1
                  c.lui        t2, 18
                  mul          s11, a6, a7
                  mulhu        s5, t3, zero
                  c.lui        t2, 18
                  add          s2, gp, s8
                  c.addi       s5, -1
                  c.add        ra, a0
                  andi         s6, a4, 204
                  mulh         t4, s3, s10
                  c.li         gp, -1
                  slti         s6, tp, 996
                  c.lui        t2, 18
                  or           s8, s8, t2
                  ori          s1, a7, 303
                  c.mv         s6, sp
                  add          s2, gp, s8
                  srai         s11, a5, 6
                  xori         t0, t6, -1239
                  c.li         gp, -1
                  slli         t0, zero, 18
                  srli         tp, ra, 29
                  div          s8, ra, a4
                  mulh         t4, s3, s10
                  rem          s8, t3, s11
                  c.srli       s1, 18
                  c.or         a2, a3
                  add          s2, gp, s8
                  c.srli       s1, 18
                  c.and        a1, a3
                  c.lui        t2, 18
                  c.add        ra, a0
                  ori          s1, a7, 303
                  mulh         t4, s3, s10
                  srai         s11, a5, 6
                  c.or         a2, a3
                  sltu         t1, a6, a2
                  c.addi       s5, -1
                  rem          s8, t3, s11
                  c.lui        t2, 18
                  andi         s6, a4, 204
                  sub          t3, a0, t2
                  c.lui        t2, 18
                  srli         tp, ra, 29
                  c.xor        a2, a5
                  remu         s9, a2, t1
                  sll          a2, t6, tp
                  c.addi       s5, -1
                  mulhu        s5, t3, zero
                  addi         s11, s11, -143
                  xor          s5, s7, t6
                  slti         s6, tp, 996
                  mul          s11, a6, a7
                  c.addi4spn   a1, sp, 480
                  slt          s6, s6, gp
                  remu         s9, a2, t1
                  c.lui        t2, 18
                  sub          t3, a0, t2
                  c.li         gp, -1
                  srai         s11, a5, 6
                  div          s8, ra, a4
                  mulh         t4, s3, s10
                  rem          s8, t3, s11
                  xori         t0, t6, -1239
                  c.srai       s1, 8
                  c.xor        a2, a5
                  srai         s11, a5, 6
                  remu         s9, a2, t1
                  sra          s1, s7, t6
                  c.nop
                  srai         s11, a5, 6
                  c.or         a2, a3
                  c.addi4spn   a1, sp, 480
                  c.srai       s1, 8
                  or           s8, s8, t2
                  c.add        ra, a0
                  c.li         gp, -1
                  c.add        ra, a0
                  c.addi       s5, -1
                  c.addi16sp   sp, 384
                  c.add        ra, a0
                  or           s8, s8, t2
                  c.srli       s1, 18
                  c.slli       a5, 14
                  ori          s1, a7, 303
                  c.srli       s1, 18
                  or           s8, s8, t2
                  slti         s6, tp, 996
                  c.lui        t2, 18
                  c.srli       s1, 18
                  c.srai       s1, 8
                  sltu         t1, a6, a2
                  srli         tp, ra, 29
                  c.xor        a2, a5
                  c.lui        t2, 18
                  c.andi       s0, -1
                  add          s2, gp, s8
                  divu         sp, t2, s2
                  srl          a6, s8, s9
                  slti         s6, tp, 996
                  srli         tp, ra, 29
                  c.srli       s1, 18
                  srai         s11, a5, 6
                  xor          s5, s7, t6
                  sub          t3, a0, t2
                  c.slli       a5, 14
                  add          s2, gp, s8
                  c.addi4spn   a1, sp, 480
                  addi         s11, s11, -143
                  mulhsu       a1, gp, a0
                  c.addi16sp   sp, 384
                  xor          s5, s7, t6
                  c.andi       s0, -1
                  sll          a2, t6, tp
                  c.srai       s1, 8
                  remu         s9, a2, t1
                  c.addi16sp   sp, 384
                  add          s2, gp, s8
                  sub          t3, a0, t2
                  sltu         t1, a6, a2
                  slti         s6, tp, 996
                  sra          s1, s7, t6
                  ori          s1, a7, 303
                  or           s8, s8, t2
                  sub          t3, a0, t2
                  c.slli       a5, 14
                  slli         t0, zero, 18
                  auipc        zero, 631536
                  xor          s5, s7, t6
                  srli         tp, ra, 29
                  mul          s11, a6, a7
                  c.mv         s6, sp
                  addi         s11, s11, -143
                  slli         t0, zero, 18
                  slti         s6, tp, 996
                  divu         sp, t2, s2
                  sub          t3, a0, t2
                  or           s8, s8, t2
                  c.lui        t2, 18
                  c.and        a1, a3
                  divu         sp, t2, s2
                  divu         sp, t2, s2
                  mulhu        s5, t3, zero
                  nop
                  c.mv         s6, sp
                  c.andi       s0, -1
                  sll          a2, t6, tp
                  remu         s9, a2, t1
                  slti         s6, tp, 996
                  c.li         gp, -1
                  c.slli       a5, 14
                  c.li         gp, -1
                  srl          a6, s8, s9
                  slti         s6, tp, 996
                  c.mv         s6, sp
                  andi         s6, a4, 204
                  and          a1, s3, s0
                  div          s8, ra, a4
                  c.lui        t2, 18
                  div          s8, ra, a4
                  c.and        a1, a3
                  auipc        zero, 631536
                  srl          a6, s8, s9
                  c.sub        s0, s0
                  xor          s5, s7, t6
                  auipc        zero, 631536
                  divu         sp, t2, s2
                  sub          t3, a0, t2
                  slt          s6, s6, gp
                  sltu         t1, a6, a2
                  c.lui        t2, 18
                  srl          a6, s8, s9
                  sltu         t1, a6, a2
                  c.addi4spn   a1, sp, 480
                  add          s2, gp, s8
                  sltu         t1, a6, a2
                  c.or         a2, a3
                  c.mv         s6, sp
                  slt          s6, s6, gp
                  c.mv         s6, sp
                  and          a1, s3, s0
                  c.or         a2, a3
                  c.sub        s0, s0
                  xor          s5, s7, t6
                  rem          s8, t3, s11
                  mul          s11, a6, a7
                  sra          s1, s7, t6
                  rem          s8, t3, s11
                  ori          s1, a7, 303
                  lui          t4, 172841
                  c.xor        a2, a5
                  andi         s6, a4, 204
                  mulhsu       a1, gp, a0
                  div          s8, ra, a4
                  or           s8, s8, t2
                  mulhsu       a1, gp, a0
                  addi         s11, s11, -143
                  c.add        ra, a0
                  c.and        a1, a3
                  c.andi       s0, -1
                  c.addi4spn   a1, sp, 480
                  andi         s6, a4, 204
                  sltu         t1, a6, a2
                  divu         sp, t2, s2
                  c.srai       s1, 8
                  sra          s1, s7, t6
                  nop
                  c.xor        a2, a5
                  c.li         gp, -1
                  div          s8, ra, a4
                  c.addi       s5, -1
                  c.andi       s0, -1
                  srli         tp, ra, 29
                  c.xor        a2, a5
                  c.mv         s6, sp
                  c.andi       s0, -1
                  rem          s8, t3, s11
                  sra          s1, s7, t6
                  add          s2, gp, s8
                  c.sub        s0, s0
                  add          s2, gp, s8
                  srli         tp, ra, 29
                  nop
                  slt          s6, s6, gp
                  auipc        zero, 631536
                  addi         s11, s11, -143
                  c.xor        a2, a5
                  c.mv         s6, sp
                  mulhu        s5, t3, zero
                  nop
                  srl          a6, s8, s9
                  c.addi16sp   sp, 384
                  mulhu        s5, t3, zero
                  c.and        a1, a3
                  slti         s6, tp, 996
                  slti         s6, tp, 996
                  c.addi       s5, -1
                  add          s2, gp, s8
                  add          s2, gp, s8
                  remu         s9, a2, t1
                  add          s2, gp, s8
                  c.sub        s0, s0
                  c.sub        s0, s0
                  rem          s8, t3, s11
                  sra          s1, s7, t6
                  xori         t0, t6, -1239
                  c.and        a1, a3
                  c.add        ra, a0
                  c.addi16sp   sp, 384
                  and          a1, s3, s0
                  c.li         gp, -1
                  nop
                  div          s8, ra, a4
                  mulhsu       a1, gp, a0
                  mulhsu       a1, gp, a0
                  c.or         a2, a3
                  c.addi16sp   sp, 384
                  mulh         t4, s3, s10
                  mulh         t4, s3, s10
                  c.addi16sp   sp, 384
                  nop
                  srl          a6, s8, s9
                  div          s8, ra, a4
                  divu         sp, t2, s2
                  mulhu        s5, t3, zero
                  sra          s1, s7, t6
                  mul          s11, a6, a7
                  rem          s8, t3, s11
                  mulhu        s5, t3, zero
                  c.addi16sp   sp, 384
                  ori          s1, a7, 303
                  rem          s8, t3, s11
                  addi         s11, s11, -143
                  xori         t0, t6, -1239
                  xor          s5, s7, t6
                  c.mv         s6, sp
                  sll          a2, t6, tp
                  xor          s5, s7, t6
                  divu         sp, t2, s2
                  c.or         a2, a3
                  c.srai       s1, 8
                  addi         s11, s11, -143
                  c.addi4spn   a1, sp, 480
                  slt          s6, s6, gp
                  c.srli       s1, 18
                  c.and        a1, a3
                  addi         s11, s11, -143
                  slli         t0, zero, 18
                  srli         tp, ra, 29
                  nop
                  divu         sp, t2, s2
                  c.mv         s6, sp
                  mulhu        s5, t3, zero
                  xori         t0, t6, -1239
                  slli         t0, zero, 18
                  c.srai       s1, 8
                  remu         s9, a2, t1
                  sltu         t1, a6, a2
                  c.srai       s1, 8
                  lui          t4, 172841
                  c.sub        s0, s0
                  c.li         gp, -1
                  c.addi4spn   a1, sp, 480
                  sltiu        t6, sp, 205
                  c.add        ra, a0
                  auipc        zero, 631536
                  rem          s8, t3, s11
                  sll          a2, t6, tp
                  c.and        a1, a3
                  srli         tp, ra, 29
                  slt          s6, s6, gp
                  or           s8, s8, t2
                  c.addi       s5, -1
                  c.or         a2, a3
                  srai         s11, a5, 6
                  mulhu        s5, t3, zero
                  c.addi       s5, -1
                  lui          t4, 172841
                  c.add        ra, a0
                  c.and        a1, a3
                  c.srli       s1, 18
                  rem          s8, t3, s11
                  div          s8, ra, a4
                  xor          s5, s7, t6
                  mulh         t4, s3, s10
                  mulhsu       a1, gp, a0
                  c.xor        a2, a5
                  c.xor        a2, a5
                  or           s8, s8, t2
                  c.andi       s0, -1
                  slli         t0, zero, 18
                  c.addi4spn   a1, sp, 480
                  lui          t4, 172841
                  srl          a6, s8, s9
                  andi         s6, a4, 204
                  sll          a2, t6, tp
                  remu         s9, a2, t1
                  sub          t3, a0, t2
                  mulhsu       a1, gp, a0
                  slli         t0, zero, 18
                  c.srai       s1, 8
                  c.srli       s1, 18
                  c.addi4spn   a1, sp, 480
                  srl          a6, s8, s9
                  slli         t0, zero, 18
                  addi         s11, s11, -143
                  srli         tp, ra, 29
                  slt          s6, s6, gp
                  xor          s5, s7, t6
                  ori          s1, a7, 303
                  andi         s6, a4, 204
                  and          a1, s3, s0
                  c.lui        t2, 18
                  c.addi       s5, -1
                  mul          s11, a6, a7
                  c.xor        a2, a5
                  slt          s6, s6, gp
                  c.slli       a5, 14
                  sub          t3, a0, t2
                  c.slli       a5, 14
                  andi         s6, a4, 204
                  c.nop
                  remu         s9, a2, t1
                  c.or         a2, a3
                  div          s8, ra, a4
                  c.sub        s0, s0
                  mul          s11, a6, a7
                  slli         t0, zero, 18
                  c.addi4spn   a1, sp, 480
                  c.srai       s1, 8
                  c.and        a1, a3
                  c.mv         s6, sp
                  slli         t0, zero, 18
                  srai         s11, a5, 6
                  divu         sp, t2, s2
                  srai         s11, a5, 6
                  xor          s5, s7, t6
                  c.lui        t2, 18
                  add          s2, gp, s8
                  slli         t0, zero, 18
                  add          s2, gp, s8
                  lui          t4, 172841
                  c.xor        a2, a5
                  addi         s11, s11, -143
                  c.srai       s1, 8
                  c.add        ra, a0
                  sub          t3, a0, t2
                  rem          s8, t3, s11
                  mulh         t4, s3, s10
                  c.srli       s1, 18
                  slli         t0, zero, 18
                  sll          a2, t6, tp
                  c.addi16sp   sp, 384
                  mulhu        s5, t3, zero
                  c.addi       s5, -1
                  srli         tp, ra, 29
                  mulhu        s5, t3, zero
                  xor          s5, s7, t6
                  remu         s9, a2, t1
                  c.li         gp, -1
                  xor          s5, s7, t6
                  c.mv         s6, sp
                  or           s8, s8, t2
                  c.addi16sp   sp, 384
                  sltu         t1, a6, a2
                  srli         tp, ra, 29
                  c.sub        s0, s0
                  c.nop
                  c.sub        s0, s0
                  remu         s9, a2, t1
                  slt          s6, s6, gp
                  c.srli       s1, 18
                  rem          s8, t3, s11
                  sltiu        t6, sp, 205
                  divu         sp, t2, s2
                  andi         s6, a4, 204
                  sub          t3, a0, t2
                  lui          t4, 172841
                  c.add        ra, a0
                  c.add        ra, a0
                  c.xor        a2, a5
                  c.addi16sp   sp, 384
                  add          s2, gp, s8
                  c.mv         s6, sp
                  div          s8, ra, a4
                  c.or         a2, a3
                  c.sub        s0, s0
                  c.addi16sp   sp, 384
                  ori          s1, a7, 303
                  divu         sp, t2, s2
                  slli         t0, zero, 18
                  c.li         gp, -1
                  slt          s6, s6, gp
                  or           s8, s8, t2
                  ori          s1, a7, 303
                  addi         s11, s11, -143
                  c.nop
                  mulhsu       a1, gp, a0
                  c.srli       s1, 18
                  srli         tp, ra, 29
                  c.addi16sp   sp, 384
                  c.mv         s6, sp
                  c.xor        a2, a5
                  sltu         t1, a6, a2
                  c.srai       s1, 8
                  ori          s1, a7, 303
                  c.slli       a5, 14
                  srai         s11, a5, 6
                  c.mv         s6, sp
                  div          s8, ra, a4
                  and          a1, s3, s0
                  div          s8, ra, a4
                  remu         s9, a2, t1
                  or           s8, s8, t2
                  slti         s6, tp, 996
                  sltiu        t6, sp, 205
                  div          s8, ra, a4
                  mulhsu       a1, gp, a0
                  add          s2, gp, s8
                  c.addi       s5, -1
                  c.srai       s1, 8
                  srl          a6, s8, s9
                  c.srli       s1, 18
                  c.and        a1, a3
                  c.and        a1, a3
                  c.and        a1, a3
                  slti         s6, tp, 996
                  lui          t4, 172841
                  xori         t0, t6, -1239
                  sll          a2, t6, tp
                  c.slli       a5, 14
                  sll          a2, t6, tp
                  slli         t0, zero, 18
                  sub          t3, a0, t2
                  c.xor        a2, a5
                  auipc        zero, 631536
                  ori          s1, a7, 303
                  mulhu        s5, t3, zero
                  c.sub        s0, s0
                  c.addi16sp   sp, 384
                  c.andi       s0, -1
                  ori          s1, a7, 303
                  mul          s11, a6, a7
                  c.mv         s6, sp
                  c.andi       s0, -1
                  c.addi16sp   sp, 384
                  sll          a2, t6, tp
                  c.addi       s5, -1
                  remu         s9, a2, t1
                  c.li         gp, -1
                  sra          s1, s7, t6
                  sra          s1, s7, t6
                  c.or         a2, a3
                  c.addi       s5, -1
                  divu         sp, t2, s2
                  and          a1, s3, s0
                  addi         s11, s11, -143
                  c.andi       s0, -1
                  and          a1, s3, s0
                  c.xor        a2, a5
                  c.li         gp, -1
                  remu         s9, a2, t1
                  li           s6, 0x80000000 #start riscv_int_numeric_corner_stream_29
                  li           sp, 0xffffffff
                  li           s1, 0xffffffff
                  li           t3, 0x80000000
                  li           a7, 0x0
                  li           s10, 0x0
                  li           a1, 0x66ad2c00
                  li           s0, 0x80000000
                  li           a5, 0x0
                  li           t6, 0x0
                  mulh         sp, a1, a7
                  auipc        sp, 631536
                  mulhu        s1, t3, sp
                  sub          t6, t6, s10
                  mulhu        s1, t3, sp
                  div          a7, s0, t6
                  nop
                  div          a7, s0, t6
                  lui          t6, 172841
                  auipc        sp, 631536
                  nop
                  addi         t3, a7, -143
                  nop
                  auipc        sp, 631536
                  mulhsu       s10, a1, a5
                  mulhu        s1, t3, sp
                  mulhu        s1, t3, sp
                  divu         s1, s10, s1
                  sub          t6, t6, s10
                  lui          t6, 172841
                  nop
                  remu         s6, s1, s6
                  mulhu        s1, t3, sp
                  mulhu        s1, t3, sp
                  auipc        sp, 631536
                  nop
                  nop
                  div          a7, s0, t6
                  divu         s1, s10, s1 #end riscv_int_numeric_corner_stream_29
                  slt          s6, s6, gp
                  sub          t3, a0, t2
                  add          s2, gp, s8
                  divu         sp, t2, s2
                  c.li         gp, -1
                  c.addi       s5, -1
                  lui          t4, 172841
                  sra          s1, s7, t6
                  c.or         a2, a3
                  mulhsu       a1, gp, a0
                  xori         t0, t6, -1239
                  c.nop
                  c.mv         s6, sp
                  sub          t3, a0, t2
                  c.and        a1, a3
                  c.addi4spn   a1, sp, 480
                  addi         s11, s11, -143
                  c.lui        t2, 18
                  slti         s6, tp, 996
                  srai         s11, a5, 6
                  sltiu        t6, sp, 205
                  c.lui        t2, 18
                  and          a1, s3, s0
                  sub          t3, a0, t2
                  srai         s11, a5, 6
                  nop
                  sltu         t1, a6, a2
                  c.nop
                  c.li         gp, -1
                  c.mv         s6, sp
                  mulh         t4, s3, s10
                  slti         s6, tp, 996
                  slt          s6, s6, gp
                  srli         tp, ra, 29
                  mul          s11, a6, a7
                  auipc        zero, 631536
                  mulhsu       a1, gp, a0
                  mulhu        s5, t3, zero
                  sra          s1, s7, t6
                  sltu         t1, a6, a2
                  sra          s1, s7, t6
                  c.addi16sp   sp, 384
                  ori          s1, a7, 303
                  c.add        ra, a0
                  mulh         t4, s3, s10
                  sra          s1, s7, t6
                  mulh         t4, s3, s10
                  c.add        ra, a0
                  and          a1, s3, s0
                  lui          t4, 172841
                  c.andi       s0, -1
                  c.addi16sp   sp, 384
                  mul          s11, a6, a7
                  c.mv         s6, sp
                  ori          s1, a7, 303
                  slli         t0, zero, 18
                  sub          t3, a0, t2
                  sltiu        t6, sp, 205
                  xor          s5, s7, t6
                  c.lui        t2, 18
                  sra          s1, s7, t6
                  addi         s11, s11, -143
                  c.li         gp, -1
                  c.mv         s6, sp
                  c.or         a2, a3
                  slli         t0, zero, 18
                  c.mv         s6, sp
                  c.lui        t2, 18
                  xor          s5, s7, t6
                  c.addi       s5, -1
                  xor          s5, s7, t6
                  c.sub        s0, s0
                  xori         t0, t6, -1239
                  slti         s6, tp, 996
                  c.xor        a2, a5
                  sltiu        t6, sp, 205
                  c.srli       s1, 18
                  add          s2, gp, s8
                  c.sub        s0, s0
                  rem          s8, t3, s11
                  srai         s11, a5, 6
                  remu         s9, a2, t1
                  c.srli       s1, 18
                  c.li         gp, -1
                  c.srli       s1, 18
                  lui          t4, 172841
                  div          s8, ra, a4
                  slt          s6, s6, gp
                  c.slli       a5, 14
                  c.xor        a2, a5
                  ori          s1, a7, 303
                  mul          s11, a6, a7
                  srl          a6, s8, s9
                  mulh         t4, s3, s10
                  nop
                  sub          t3, a0, t2
                  c.mv         s6, sp
                  sll          a2, t6, tp
                  sltu         t1, a6, a2
                  andi         s6, a4, 204
                  sra          s1, s7, t6
                  c.addi       s5, -1
                  mulh         t4, s3, s10
                  slt          s6, s6, gp
                  lui          t4, 172841
                  c.li         gp, -1
                  c.srai       s1, 8
                  remu         s9, a2, t1
                  remu         s9, a2, t1
                  c.addi16sp   sp, 384
                  c.and        a1, a3
                  slti         s6, tp, 996
                  mulhsu       a1, gp, a0
                  div          s8, ra, a4
                  mulhsu       a1, gp, a0
                  rem          s8, t3, s11
                  mulhsu       a1, gp, a0
                  auipc        zero, 631536
                  c.lui        t2, 18
                  sltiu        t6, sp, 205
                  or           s8, s8, t2
                  sll          a2, t6, tp
                  slti         s6, tp, 996
                  mulhsu       a1, gp, a0
                  c.nop
                  or           s8, s8, t2
                  divu         sp, t2, s2
                  c.addi       s5, -1
                  c.add        ra, a0
                  c.nop
                  and          a1, s3, s0
                  lui          t4, 172841
                  mulh         t4, s3, s10
                  sltu         t1, a6, a2
                  c.slli       a5, 14
                  slti         s6, tp, 996
                  div          s8, ra, a4
                  xori         t0, t6, -1239
                  remu         s9, a2, t1
                  sll          a2, t6, tp
                  mulhsu       a1, gp, a0
                  sll          a2, t6, tp
                  sll          a2, t6, tp
                  c.and        a1, a3
                  mul          s11, a6, a7
                  c.sub        s0, s0
                  c.or         a2, a3
                  div          s8, ra, a4
                  srl          a6, s8, s9
                  c.add        ra, a0
                  slli         t0, zero, 18
                  c.addi16sp   sp, 384
                  sltiu        t6, sp, 205
                  mulhu        s5, t3, zero
                  xor          s5, s7, t6
                  ori          s1, a7, 303
                  c.and        a1, a3
                  nop
                  rem          s8, t3, s11
                  andi         s6, a4, 204
                  c.xor        a2, a5
                  xor          s5, s7, t6
                  c.or         a2, a3
                  and          a1, s3, s0
                  ori          s1, a7, 303
                  rem          s8, t3, s11
                  c.addi       s5, -1
                  slli         t0, zero, 18
                  c.lui        t2, 18
                  slt          s6, s6, gp
                  c.andi       s0, -1
                  c.andi       s0, -1
                  c.srai       s1, 8
                  sub          t3, a0, t2
                  slt          s6, s6, gp
                  divu         sp, t2, s2
                  c.srli       s1, 18
                  c.andi       s0, -1
                  divu         sp, t2, s2
                  add          s2, gp, s8
                  sltu         t1, a6, a2
                  c.addi16sp   sp, 384
                  sll          a2, t6, tp
                  c.mv         s6, sp
                  c.xor        a2, a5
                  sub          t3, a0, t2
                  c.or         a2, a3
                  sra          s1, s7, t6
                  c.addi       s5, -1
                  c.add        ra, a0
                  mul          s11, a6, a7
                  c.srli       s1, 18
                  nop
                  mul          s11, a6, a7
                  or           s8, s8, t2
                  xori         t0, t6, -1239
                  c.srli       s1, 18
                  slti         s6, tp, 996
                  c.andi       s0, -1
                  slti         s6, tp, 996
                  mulhsu       a1, gp, a0
                  c.andi       s0, -1
                  srl          a6, s8, s9
                  andi         s6, a4, 204
                  c.addi16sp   sp, 384
                  c.li         gp, -1
                  remu         s9, a2, t1
                  sra          s1, s7, t6
                  xor          s5, s7, t6
                  c.and        a1, a3
                  c.andi       s0, -1
                  lui          t4, 172841
                  nop
                  lui          t4, 172841
                  slti         s6, tp, 996
                  sltu         t1, a6, a2
                  c.addi4spn   a1, sp, 480
                  remu         s9, a2, t1
                  c.and        a1, a3
                  andi         s6, a4, 204
                  c.addi4spn   a1, sp, 480
                  mulhu        s5, t3, zero
                  andi         s6, a4, 204
                  srli         tp, ra, 29
                  sltiu        t6, sp, 205
                  c.lui        t2, 18
                  c.nop
                  slli         t0, zero, 18
                  c.andi       s0, -1
                  slli         t0, zero, 18
                  c.addi       s5, -1
                  addi         s11, s11, -143
                  lui          t4, 172841
                  slli         t0, zero, 18
                  c.addi16sp   sp, 384
                  and          a1, s3, s0
                  srli         tp, ra, 29
                  slli         t0, zero, 18
                  sra          s1, s7, t6
                  add          s2, gp, s8
                  xori         t0, t6, -1239
                  remu         s9, a2, t1
                  srl          a6, s8, s9
                  and          a1, s3, s0
                  addi         s11, s11, -143
                  sltu         t1, a6, a2
                  srai         s11, a5, 6
                  remu         s9, a2, t1
                  c.andi       s0, -1
                  sll          a2, t6, tp
                  rem          s8, t3, s11
                  sltu         t1, a6, a2
                  slti         s6, tp, 996
                  addi         s11, s11, -143
                  c.li         gp, -1
                  lui          t4, 172841
                  c.addi4spn   a1, sp, 480
                  sub          t3, a0, t2
                  divu         sp, t2, s2
                  srl          a6, s8, s9
                  slt          s6, s6, gp
                  mulhu        s5, t3, zero
                  lui          t4, 172841
                  c.addi16sp   sp, 384
                  slti         s6, tp, 996
                  mulh         t4, s3, s10
                  lui          t4, 172841
                  addi         s11, s11, -143
                  c.xor        a2, a5
                  sll          a2, t6, tp
                  and          a1, s3, s0
                  c.srai       s1, 8
                  nop
                  and          a1, s3, s0
                  div          s8, ra, a4
                  divu         sp, t2, s2
                  auipc        zero, 631536
                  slli         t0, zero, 18
                  c.xor        a2, a5
                  c.xor        a2, a5
                  c.andi       s0, -1
                  lui          t4, 172841
                  mulhu        s5, t3, zero
                  sltiu        t6, sp, 205
                  mul          s11, a6, a7
                  or           s8, s8, t2
                  mul          s11, a6, a7
                  c.xor        a2, a5
                  rem          s8, t3, s11
                  c.mv         s6, sp
                  sub          t3, a0, t2
                  c.or         a2, a3
                  sltiu        t6, sp, 205
                  c.lui        t2, 18
                  andi         s6, a4, 204
                  div          s8, ra, a4
                  c.or         a2, a3
                  lui          t4, 172841
                  c.addi       s5, -1
                  auipc        zero, 631536
                  nop
                  c.srli       s1, 18
                  and          a1, s3, s0
                  andi         s6, a4, 204
                  sltu         t1, a6, a2
                  nop
                  c.li         gp, -1
                  c.or         a2, a3
                  xor          s5, s7, t6
                  srl          a6, s8, s9
                  divu         sp, t2, s2
                  c.xor        a2, a5
                  lui          t4, 172841
                  c.and        a1, a3
                  div          s8, ra, a4
                  c.addi       s5, -1
                  xor          s5, s7, t6
                  slt          s6, s6, gp
                  c.addi4spn   a1, sp, 480
                  rem          s8, t3, s11
                  mulhsu       a1, gp, a0
                  c.or         a2, a3
                  c.mv         s6, sp
                  srl          a6, s8, s9
                  c.xor        a2, a5
                  nop
                  add          s2, gp, s8
                  sub          t3, a0, t2
                  c.and        a1, a3
                  c.li         gp, -1
                  addi         s11, s11, -143
                  auipc        zero, 631536
                  srai         s11, a5, 6
                  sra          s1, s7, t6
                  c.mv         s6, sp
                  sll          a2, t6, tp
                  mulh         t4, s3, s10
                  c.or         a2, a3
                  mulhu        s5, t3, zero
                  sra          s1, s7, t6
                  c.andi       s0, -1
                  c.or         a2, a3
                  c.or         a2, a3
                  or           s8, s8, t2
                  sltiu        t6, sp, 205
                  c.slli       a5, 14
                  c.or         a2, a3
                  rem          s8, t3, s11
                  c.srai       s1, 8
                  slt          s6, s6, gp
                  slli         t0, zero, 18
                  sltu         t1, a6, a2
                  mul          s11, a6, a7
                  sltu         t1, a6, a2
                  c.addi16sp   sp, 384
                  srai         s11, a5, 6
                  c.and        a1, a3
                  c.and        a1, a3
                  auipc        zero, 631536
                  mulhu        s5, t3, zero
                  or           s8, s8, t2
                  nop
                  c.addi       s5, -1
                  auipc        zero, 631536
                  sra          s1, s7, t6
                  srli         tp, ra, 29
                  or           s8, s8, t2
                  divu         sp, t2, s2
                  c.srai       s1, 8
                  mulhu        s5, t3, zero
                  c.addi4spn   a1, sp, 480
                  c.slli       a5, 14
                  mulhsu       a1, gp, a0
                  add          s2, gp, s8
                  xor          s5, s7, t6
                  mulh         t4, s3, s10
                  srai         s11, a5, 6
                  andi         s6, a4, 204
                  c.srai       s1, 8
                  mulhsu       a1, gp, a0
                  srai         s11, a5, 6
                  addi         s11, s11, -143
                  xori         t0, t6, -1239
                  divu         sp, t2, s2
                  ori          s1, a7, 303
                  sll          a2, t6, tp
                  c.addi4spn   a1, sp, 480
                  c.lui        t2, 18
                  sltu         t1, a6, a2
                  add          s2, gp, s8
                  srli         tp, ra, 29
                  c.and        a1, a3
                  mulhu        s5, t3, zero
                  ori          s1, a7, 303
                  c.or         a2, a3
                  c.addi4spn   a1, sp, 480
                  c.sub        s0, s0
                  add          s2, gp, s8
                  srli         tp, ra, 29
                  c.srli       s1, 18
                  sll          a2, t6, tp
                  c.slli       a5, 14
                  sltu         t1, a6, a2
                  auipc        zero, 631536
                  srl          a6, s8, s9
                  c.mv         s6, sp
                  c.srli       s1, 18
                  c.srai       s1, 8
                  c.addi       s5, -1
                  andi         s6, a4, 204
                  sll          a2, t6, tp
                  div          s8, ra, a4
                  srai         s11, a5, 6
                  ori          s1, a7, 303
                  c.srli       s1, 18
                  remu         s9, a2, t1
                  c.lui        t2, 18
                  c.mv         s6, sp
                  andi         s6, a4, 204
                  sltiu        t6, sp, 205
                  slt          s6, s6, gp
                  lui          t4, 172841
                  mul          s11, a6, a7
                  slt          s6, s6, gp
                  slti         s6, tp, 996
                  c.addi4spn   a1, sp, 480
                  c.andi       s0, -1
                  c.slli       a5, 14
                  mulh         t4, s3, s10
                  sltiu        t6, sp, 205
                  mul          s11, a6, a7
                  mulh         t4, s3, s10
                  slt          s6, s6, gp
                  c.addi4spn   a1, sp, 480
                  srl          a6, s8, s9
                  c.nop
                  c.slli       a5, 14
                  c.xor        a2, a5
                  andi         s6, a4, 204
                  addi         s11, s11, -143
                  remu         s9, a2, t1
                  srl          a6, s8, s9
                  c.add        ra, a0
                  c.nop
                  c.srli       s1, 18
                  ori          s1, a7, 303
                  c.addi       s5, -1
                  srl          a6, s8, s9
                  mul          s11, a6, a7
                  div          s8, ra, a4
                  nop
                  xor          s5, s7, t6
                  mulhsu       a1, gp, a0
                  c.addi       s5, -1
                  mulhu        s5, t3, zero
                  c.or         a2, a3
                  srli         tp, ra, 29
                  remu         s9, a2, t1
                  c.addi       s5, -1
                  xor          s5, s7, t6
                  xori         t0, t6, -1239
                  ori          s1, a7, 303
                  slt          s6, s6, gp
                  c.lui        t2, 18
                  add          s2, gp, s8
                  c.or         a2, a3
                  c.andi       s0, -1
                  c.slli       a5, 14
                  c.nop
                  xori         t0, t6, -1239
                  c.addi       s5, -1
                  rem          s8, t3, s11
                  c.sub        s0, s0
                  c.addi4spn   a1, sp, 480
                  lui          t4, 172841
                  nop
                  and          a1, s3, s0
                  c.or         a2, a3
                  rem          s8, t3, s11
                  srli         tp, ra, 29
                  slti         s6, tp, 996
                  sub          t3, a0, t2
                  mulhsu       a1, gp, a0
                  c.srai       s1, 8
                  c.add        ra, a0
                  mulhsu       a1, gp, a0
                  lui          t4, 172841
                  sll          a2, t6, tp
                  addi         s11, s11, -143
                  slti         s6, tp, 996
                  sltiu        t6, sp, 205
                  slti         s6, tp, 996
                  c.srai       s1, 8
                  c.add        ra, a0
                  auipc        zero, 631536
                  auipc        zero, 631536
                  mul          s11, a6, a7
                  sltiu        t6, sp, 205
                  c.and        a1, a3
                  mulh         t4, s3, s10
                  sltiu        t6, sp, 205
                  c.and        a1, a3
                  c.add        ra, a0
                  c.sub        s0, s0
                  sra          s1, s7, t6
                  mul          s11, a6, a7
                  c.andi       s0, -1
                  srl          a6, s8, s9
                  slli         t0, zero, 18
                  sll          a2, t6, tp
                  auipc        zero, 631536
                  c.nop
                  sub          t3, a0, t2
                  slt          s6, s6, gp
                  add          s2, gp, s8
                  xori         t0, t6, -1239
                  addi         s11, s11, -143
                  c.xor        a2, a5
                  c.nop
                  auipc        zero, 631536
                  add          s2, gp, s8
                  sltu         t1, a6, a2
                  xor          s5, s7, t6
                  or           s8, s8, t2
                  ori          s1, a7, 303
                  c.addi4spn   a1, sp, 480
                  c.nop
                  sll          a2, t6, tp
                  xori         t0, t6, -1239
                  addi         s11, s11, -143
                  and          a1, s3, s0
                  c.sub        s0, s0
                  or           s8, s8, t2
                  sltu         t1, a6, a2
                  sll          a2, t6, tp
                  srli         tp, ra, 29
                  srai         s11, a5, 6
                  c.or         a2, a3
                  c.xor        a2, a5
                  sltiu        t6, sp, 205
                  sub          t3, a0, t2
                  mulh         t4, s3, s10
                  c.mv         s6, sp
                  c.addi       s5, -1
                  sub          t3, a0, t2
                  nop
                  c.andi       s0, -1
                  slti         s6, tp, 996
                  remu         s9, a2, t1
                  mulhu        s5, t3, zero
                  sltiu        t6, sp, 205
                  srl          a6, s8, s9
                  slt          s6, s6, gp
                  add          s2, gp, s8
                  sll          a2, t6, tp
                  sll          a2, t6, tp
                  sub          t3, a0, t2
                  srai         s11, a5, 6
                  mulhsu       a1, gp, a0
                  slt          s6, s6, gp
                  and          a1, s3, s0
                  or           s8, s8, t2
                  c.and        a1, a3
                  or           s8, s8, t2
                  c.addi       s5, -1
                  mulh         t4, s3, s10
                  slt          s6, s6, gp
                  c.addi       s5, -1
                  andi         s6, a4, 204
                  c.srli       s1, 18
                  c.addi       s5, -1
                  c.add        ra, a0
                  sltiu        t6, sp, 205
                  lui          t4, 172841
                  c.lui        t2, 18
                  andi         s6, a4, 204
                  c.lui        t2, 18
                  c.and        a1, a3
                  addi         s11, s11, -143
                  c.or         a2, a3
                  remu         s9, a2, t1
                  andi         s6, a4, 204
                  srai         s11, a5, 6
                  c.lui        t2, 18
                  mulhu        s5, t3, zero
                  rem          s8, t3, s11
                  mul          s11, a6, a7
                  c.li         gp, -1
                  ori          s1, a7, 303
                  c.addi       s5, -1
                  c.srli       s1, 18
                  sltiu        t6, sp, 205
                  srai         s11, a5, 6
                  slti         s6, tp, 996
                  remu         s9, a2, t1
                  add          s2, gp, s8
                  slli         t0, zero, 18
                  ori          s1, a7, 303
                  sra          s1, s7, t6
                  c.addi16sp   sp, 384
                  srli         tp, ra, 29
                  auipc        zero, 631536
                  mul          s11, a6, a7
                  sra          s1, s7, t6
                  c.addi4spn   a1, sp, 480
                  c.sub        s0, s0
                  c.andi       s0, -1
                  remu         s9, a2, t1
                  c.addi16sp   sp, 384
                  add          s2, gp, s8
                  slt          s6, s6, gp
                  c.nop
                  c.sub        s0, s0
                  c.and        a1, a3
                  c.xor        a2, a5
                  c.add        ra, a0
                  div          s8, ra, a4
                  c.xor        a2, a5
                  sll          a2, t6, tp
                  c.lui        t2, 18
                  mulh         t4, s3, s10
                  c.li         gp, -1
                  sltu         t1, a6, a2
                  divu         sp, t2, s2
                  c.sub        s0, s0
                  rem          s8, t3, s11
                  remu         s9, a2, t1
                  addi         s11, s11, -143
                  c.mv         s6, sp
                  nop
                  slt          s6, s6, gp
                  sub          t3, a0, t2
                  c.add        ra, a0
                  c.sub        s0, s0
                  mul          s11, a6, a7
                  nop
                  c.andi       s0, -1
                  ori          s1, a7, 303
                  mulhu        s5, t3, zero
                  mulh         t4, s3, s10
                  lui          t4, 172841
                  sll          a2, t6, tp
                  c.and        a1, a3
                  srli         tp, ra, 29
                  slt          s6, s6, gp
                  slli         t0, zero, 18
                  c.srli       s1, 18
                  nop
                  c.nop
                  sll          a2, t6, tp
                  c.srli       s1, 18
                  srli         tp, ra, 29
                  sll          a2, t6, tp
                  c.sub        s0, s0
                  ori          s1, a7, 303
                  xori         t0, t6, -1239
                  sltiu        t6, sp, 205
                  c.add        ra, a0
                  sra          s1, s7, t6
                  xori         t0, t6, -1239
                  or           s8, s8, t2
                  divu         sp, t2, s2
                  add          s2, gp, s8
                  xor          s5, s7, t6
                  slli         t0, zero, 18
                  c.mv         s6, sp
                  divu         sp, t2, s2
                  andi         s6, a4, 204
                  rem          s8, t3, s11
                  or           s8, s8, t2
                  c.addi4spn   a1, sp, 480
                  slt          s6, s6, gp
                  and          a1, s3, s0
                  xori         t0, t6, -1239
                  mul          s11, a6, a7
                  rem          s8, t3, s11
                  c.xor        a2, a5
                  c.nop
                  div          s8, ra, a4
                  div          s8, ra, a4
                  or           s8, s8, t2
                  c.srli       s1, 18
                  c.srai       s1, 8
                  auipc        zero, 631536
                  srl          a6, s8, s9
                  c.sub        s0, s0
                  sltu         t1, a6, a2
                  xori         t0, t6, -1239
                  c.andi       s0, -1
                  c.add        ra, a0
                  c.lui        t2, 18
                  lui          t4, 172841
                  xori         t0, t6, -1239
                  c.addi16sp   sp, 384
                  div          s8, ra, a4
                  divu         sp, t2, s2
                  c.mv         s6, sp
                  c.addi4spn   a1, sp, 480
                  ori          s1, a7, 303
                  slti         s6, tp, 996
                  sll          a2, t6, tp
                  mulhu        s5, t3, zero
                  nop
                  sltu         t1, a6, a2
                  mulhsu       a1, gp, a0
                  mulhsu       a1, gp, a0
                  sra          s1, s7, t6
                  nop
                  mulhu        s5, t3, zero
                  c.xor        a2, a5
                  mul          s11, a6, a7
                  sra          s1, s7, t6
                  andi         s6, a4, 204
                  remu         s9, a2, t1
                  c.addi       s5, -1
                  c.sub        s0, s0
                  and          a1, s3, s0
                  slt          s6, s6, gp
                  srai         s11, a5, 6
                  mulhu        s5, t3, zero
                  sltu         t1, a6, a2
                  xori         t0, t6, -1239
                  sra          s1, s7, t6
                  sub          t3, a0, t2
                  c.and        a1, a3
                  sub          t3, a0, t2
                  remu         s9, a2, t1
                  mulhsu       a1, gp, a0
                  remu         s9, a2, t1
                  addi         s11, s11, -143
                  c.xor        a2, a5
                  add          s2, gp, s8
                  and          a1, s3, s0
                  lui          t4, 172841
                  and          a1, s3, s0
                  and          a1, s3, s0
                  andi         s6, a4, 204
                  nop
                  c.addi       s5, -1
                  c.and        a1, a3
                  sub          t3, a0, t2
                  slti         s6, tp, 996
                  addi         s11, s11, -143
                  slti         s6, tp, 996
                  c.srai       s1, 8
                  mulhsu       a1, gp, a0
                  mulh         t4, s3, s10
                  addi         s11, s11, -143
                  c.addi       s5, -1
                  c.add        ra, a0
                  c.srli       s1, 18
                  sra          s1, s7, t6
                  and          a1, s3, s0
                  or           s8, s8, t2
                  c.lui        t2, 18
                  c.or         a2, a3
                  xor          s5, s7, t6
                  div          s8, ra, a4
                  nop
                  c.slli       a5, 14
                  mulhsu       a1, gp, a0
                  c.and        a1, a3
                  nop
                  c.lui        t2, 18
                  slli         t0, zero, 18
                  c.li         gp, -1
                  slti         s6, tp, 996
                  remu         s9, a2, t1
                  c.add        ra, a0
                  c.or         a2, a3
                  sltiu        t6, sp, 205
                  add          s2, gp, s8
                  c.srai       s1, 8
                  slli         t0, zero, 18
                  c.addi       s5, -1
                  c.li         gp, -1
                  c.addi16sp   sp, 384
                  c.li         gp, -1
                  lui          t4, 172841
                  c.xor        a2, a5
                  c.slli       a5, 14
                  xor          s5, s7, t6
                  and          a1, s3, s0
                  add          s2, gp, s8
                  c.and        a1, a3
                  srl          a6, s8, s9
                  mulhsu       a1, gp, a0
                  slli         t0, zero, 18
                  c.or         a2, a3
                  mul          s11, a6, a7
                  sll          a2, t6, tp
                  and          a1, s3, s0
                  mulh         t4, s3, s10
                  c.li         gp, -1
                  c.lui        t2, 18
                  lui          t4, 172841
                  c.mv         s6, sp
                  c.nop
                  srli         tp, ra, 29
                  c.li         gp, -1
                  srai         s11, a5, 6
                  c.addi16sp   sp, 384
                  sll          a2, t6, tp
                  andi         s6, a4, 204
                  sltu         t1, a6, a2
                  sltu         t1, a6, a2
                  c.sub        s0, s0
                  andi         s6, a4, 204
                  sltiu        t6, sp, 205
                  mulhu        s5, t3, zero
                  c.add        ra, a0
                  and          a1, s3, s0
                  c.srli       s1, 18
                  c.li         gp, -1
                  slt          s6, s6, gp
                  lui          t4, 172841
                  sub          t3, a0, t2
                  or           s8, s8, t2
                  sltu         t1, a6, a2
                  c.sub        s0, s0
                  c.srli       s1, 18
                  slt          s6, s6, gp
                  c.or         a2, a3
                  c.lui        t2, 18
                  c.addi16sp   sp, 384
                  c.or         a2, a3
                  mul          s11, a6, a7
                  auipc        zero, 631536
                  sltiu        t6, sp, 205
                  c.or         a2, a3
                  c.addi4spn   a1, sp, 480
                  c.xor        a2, a5
                  addi         s11, s11, -143
                  sll          a2, t6, tp
                  c.nop
                  slt          s6, s6, gp
                  slli         t0, zero, 18
                  srli         tp, ra, 29
                  xori         t0, t6, -1239
                  div          s8, ra, a4
                  sltiu        t6, sp, 205
                  c.srli       s1, 18
                  sll          a2, t6, tp
                  or           s8, s8, t2
                  mulhsu       a1, gp, a0
                  andi         s6, a4, 204
                  andi         s6, a4, 204
                  c.sub        s0, s0
                  slti         s6, tp, 996
                  slt          s6, s6, gp
                  c.li         gp, -1
                  xor          s5, s7, t6
                  nop
                  slti         s6, tp, 996
                  remu         s9, a2, t1
                  c.mv         s6, sp
                  addi         s11, s11, -143
                  c.add        ra, a0
                  c.mv         s6, sp
                  c.nop
                  sll          a2, t6, tp
                  c.mv         s6, sp
                  c.andi       s0, -1
                  sltiu        t6, sp, 205
                  c.xor        a2, a5
                  c.addi4spn   a1, sp, 480
                  c.li         gp, -1
                  addi         s11, s11, -143
                  auipc        zero, 631536
                  c.addi       s5, -1
                  addi         s11, s11, -143
                  and          a1, s3, s0
                  and          a1, s3, s0
                  sll          a2, t6, tp
                  slti         s6, tp, 996
                  sltu         t1, a6, a2
                  c.srai       s1, 8
                  c.li         gp, -1
                  c.andi       s0, -1
                  divu         sp, t2, s2
                  slt          s6, s6, gp
                  addi         s11, s11, -143
                  srai         s11, a5, 6
                  c.nop
                  c.li         gp, -1
                  div          s8, ra, a4
                  rem          s8, t3, s11
                  sll          a2, t6, tp
                  addi         s11, s11, -143
                  sltu         t1, a6, a2
                  c.srai       s1, 8
                  c.srli       s1, 18
                  addi         s11, s11, -143
                  andi         s6, a4, 204
                  c.slli       a5, 14
                  slli         t0, zero, 18
                  mul          s11, a6, a7
                  or           s8, s8, t2
                  c.lui        t2, 18
                  andi         s6, a4, 204
                  sltiu        t6, sp, 205
                  mul          s11, a6, a7
                  ori          s1, a7, 303
                  mulh         t4, s3, s10
                  addi         s11, s11, -143
                  remu         s9, a2, t1
                  c.addi       s5, -1
                  c.xor        a2, a5
                  c.li         gp, -1
                  c.add        ra, a0
                  lui          t4, 172841
                  ori          s1, a7, 303
                  srli         tp, ra, 29
                  c.lui        t2, 18
                  lui          t4, 172841
                  c.lui        t2, 18
                  c.lui        t2, 18
                  slti         s6, tp, 996
                  sll          a2, t6, tp
                  nop
                  c.and        a1, a3
                  mulhsu       a1, gp, a0
                  lui          t4, 172841
                  or           s8, s8, t2
                  c.andi       s0, -1
                  srli         tp, ra, 29
                  sltu         t1, a6, a2
                  c.and        a1, a3
                  div          s8, ra, a4
                  c.and        a1, a3
                  c.addi       s5, -1
                  sltu         t1, a6, a2
                  xori         t0, t6, -1239
                  rem          s8, t3, s11
                  xor          s5, s7, t6
                  remu         s9, a2, t1
                  ori          s1, a7, 303
                  c.and        a1, a3
                  or           s8, s8, t2
                  ori          s1, a7, 303
                  mulhu        s5, t3, zero
                  ori          s1, a7, 303
                  rem          s8, t3, s11
                  auipc        zero, 631536
                  c.andi       s0, -1
                  c.addi16sp   sp, 384
                  sub          t3, a0, t2
                  auipc        zero, 631536
                  ori          s1, a7, 303
                  srai         s11, a5, 6
                  slli         t0, zero, 18
                  c.andi       s0, -1
                  srli         tp, ra, 29
                  sltiu        t6, sp, 205
                  c.addi16sp   sp, 384
                  rem          s8, t3, s11
                  andi         s6, a4, 204
                  c.addi4spn   a1, sp, 480
                  c.and        a1, a3
                  mulhsu       a1, gp, a0
                  and          a1, s3, s0
                  c.srai       s1, 8
                  slti         s6, tp, 996
                  xor          s5, s7, t6
                  mul          s11, a6, a7
                  remu         s9, a2, t1
                  mulh         t4, s3, s10
                  slti         s6, tp, 996
                  sra          s1, s7, t6
                  c.addi16sp   sp, 384
                  xori         t0, t6, -1239
                  mulh         t4, s3, s10
                  c.slli       a5, 14
                  srli         tp, ra, 29
                  c.add        ra, a0
                  xor          s5, s7, t6
                  nop
                  c.andi       s0, -1
                  slt          s6, s6, gp
                  auipc        zero, 631536
                  c.addi16sp   sp, 384
                  c.and        a1, a3
                  c.srai       s1, 8
                  c.andi       s0, -1
                  c.addi16sp   sp, 384
                  srl          a6, s8, s9
                  rem          s8, t3, s11
                  c.addi       s5, -1
                  c.add        ra, a0
                  c.nop
                  nop
                  mulhsu       a1, gp, a0
                  xori         t0, t6, -1239
                  nop
                  or           s8, s8, t2
                  sra          s1, s7, t6
                  slt          s6, s6, gp
                  andi         s6, a4, 204
                  addi         s11, s11, -143
                  mul          s11, a6, a7
                  c.srli       s1, 18
                  c.mv         s6, sp
                  c.slli       a5, 14
                  sltu         t1, a6, a2
                  c.slli       a5, 14
                  c.xor        a2, a5
                  srai         s11, a5, 6
                  c.xor        a2, a5
                  divu         sp, t2, s2
                  srli         tp, ra, 29
                  divu         sp, t2, s2
                  sra          s1, s7, t6
                  slt          s6, s6, gp
                  c.nop
                  srai         s11, a5, 6
                  srl          a6, s8, s9
                  nop
                  c.lui        t2, 18
                  c.nop
                  xori         t0, t6, -1239
                  rem          s8, t3, s11
                  sltu         t1, a6, a2
                  c.addi4spn   a1, sp, 480
                  or           s8, s8, t2
                  c.lui        t2, 18
                  c.addi16sp   sp, 384
                  c.nop
                  and          a1, s3, s0
                  srai         s11, a5, 6
                  and          a1, s3, s0
                  c.add        ra, a0
                  xor          s5, s7, t6
                  and          a1, s3, s0
                  c.srai       s1, 8
                  add          s2, gp, s8
                  sltu         t1, a6, a2
                  c.lui        t2, 18
                  and          a1, s3, s0
                  c.addi16sp   sp, 384
                  c.xor        a2, a5
                  divu         sp, t2, s2
                  xor          s5, s7, t6
                  c.srli       s1, 18
                  c.or         a2, a3
                  sltu         t1, a6, a2
                  mul          s11, a6, a7
                  c.lui        t2, 18
                  mul          s11, a6, a7
                  c.slli       a5, 14
                  c.srli       s1, 18
                  divu         sp, t2, s2
                  lui          t4, 172841
                  sltu         t1, a6, a2
                  srai         s11, a5, 6
                  andi         s6, a4, 204
                  c.lui        t2, 18
                  srl          a6, s8, s9
                  remu         s9, a2, t1
                  divu         sp, t2, s2
                  srai         s11, a5, 6
                  li           t6, 0xffffffff #start riscv_int_numeric_corner_stream_36
                  li           t1, 0xffffffff
                  li           s11, 0x0
                  li           a1, 0x0
                  li           s2, 0xffffffff
                  li           tp, 0x873a2806
                  li           sp, 0x31dadbe0
                  li           s0, 0xffffffff
                  li           s1, 0x0
                  li           s3, 0xdba7a879
                  remu         s2, t1, s2
                  lui          t6, 172841
                  rem          a1, s11, sp
                  mul          s11, sp, tp
                  auipc        sp, 631536
                  mulh         sp, s0, a1
                  mulhsu       s3, s0, s1
                  auipc        sp, 631536
                  mulhsu       s3, s0, s1
                  addi         s11, a1, -143
                  rem          a1, s11, sp
                  addi         s11, a1, -143
                  add          sp, s0, s11
                  auipc        sp, 631536
                  mulh         sp, s0, a1
                  rem          a1, s11, sp
                  sub          t6, t6, s3
                  mulh         sp, s0, a1
                  sub          t6, t6, s3
                  addi         s11, a1, -143
                  auipc        sp, 631536
                  mulh         sp, s0, a1
                  add          sp, s0, s11
                  add          sp, s0, s11
                  auipc        sp, 631536
                  divu         t1, s3, t1
                  mulhsu       s3, s0, s1
                  mul          s11, sp, tp
                  sub          t6, t6, s3 #end riscv_int_numeric_corner_stream_36
                  andi         s6, a4, 204
                  sltiu        t6, sp, 205
                  div          s8, ra, a4
                  ori          s1, a7, 303
                  or           s8, s8, t2
                  c.addi       s5, -1
                  auipc        zero, 631536
                  slli         t0, zero, 18
                  c.li         gp, -1
                  srli         tp, ra, 29
                  sra          s1, s7, t6
                  srl          a6, s8, s9
                  c.slli       a5, 14
                  c.addi4spn   a1, sp, 480
                  slti         s6, tp, 996
                  srl          a6, s8, s9
                  c.add        ra, a0
                  srl          a6, s8, s9
                  sra          s1, s7, t6
                  c.addi16sp   sp, 384
                  and          a1, s3, s0
                  c.lui        t2, 18
                  c.or         a2, a3
                  lui          t4, 172841
                  c.and        a1, a3
                  add          s2, gp, s8
                  c.li         gp, -1
                  and          a1, s3, s0
                  mulh         t4, s3, s10
                  c.andi       s0, -1
                  c.addi4spn   a1, sp, 480
                  addi         s11, s11, -143
                  mul          s11, a6, a7
                  c.andi       s0, -1
                  slli         t0, zero, 18
                  c.sub        s0, s0
                  c.nop
                  sra          s1, s7, t6
                  c.nop
                  remu         s9, a2, t1
                  mul          s11, a6, a7
                  srl          a6, s8, s9
                  mulhsu       a1, gp, a0
                  c.or         a2, a3
                  sltiu        t6, sp, 205
                  slt          s6, s6, gp
                  lui          t4, 172841
                  addi         s11, s11, -143
                  srli         tp, ra, 29
                  rem          s8, t3, s11
                  mulhu        s5, t3, zero
                  or           s8, s8, t2
                  ori          s1, a7, 303
                  addi         s11, s11, -143
                  c.and        a1, a3
                  ori          s1, a7, 303
                  c.or         a2, a3
                  xor          s5, s7, t6
                  sll          a2, t6, tp
                  xori         t0, t6, -1239
                  remu         s9, a2, t1
                  slt          s6, s6, gp
                  nop
                  c.lui        t2, 18
                  c.or         a2, a3
                  slli         t0, zero, 18
                  srl          a6, s8, s9
                  slt          s6, s6, gp
                  lui          t4, 172841
                  sll          a2, t6, tp
                  auipc        zero, 631536
                  sll          a2, t6, tp
                  c.xor        a2, a5
                  mul          s11, a6, a7
                  divu         sp, t2, s2
                  sub          t3, a0, t2
                  slti         s6, tp, 996
                  remu         s9, a2, t1
                  mulh         t4, s3, s10
                  addi         s11, s11, -143
                  slt          s6, s6, gp
                  mulh         t4, s3, s10
                  slt          s6, s6, gp
                  c.or         a2, a3
                  xor          s5, s7, t6
                  c.slli       a5, 14
                  sra          s1, s7, t6
                  div          s8, ra, a4
                  or           s8, s8, t2
                  c.andi       s0, -1
                  c.srli       s1, 18
                  lui          t4, 172841
                  divu         sp, t2, s2
                  c.slli       a5, 14
                  mulhsu       a1, gp, a0
                  lui          t4, 172841
                  div          s8, ra, a4
                  xor          s5, s7, t6
                  andi         s6, a4, 204
                  c.srli       s1, 18
                  xor          s5, s7, t6
                  and          a1, s3, s0
                  slli         t0, zero, 18
                  c.addi16sp   sp, 384
                  auipc        zero, 631536
                  c.xor        a2, a5
                  sltu         t1, a6, a2
                  xor          s5, s7, t6
                  xor          s5, s7, t6
                  srai         s11, a5, 6
                  andi         s6, a4, 204
                  remu         s9, a2, t1
                  c.nop
                  c.srli       s1, 18
                  or           s8, s8, t2
                  sra          s1, s7, t6
                  slli         t0, zero, 18
                  sltu         t1, a6, a2
                  mul          s11, a6, a7
                  ori          s1, a7, 303
                  ori          s1, a7, 303
                  c.or         a2, a3
                  c.li         gp, -1
                  c.mv         s6, sp
                  slti         s6, tp, 996
                  mulhu        s5, t3, zero
                  c.srli       s1, 18
                  srli         tp, ra, 29
                  lui          t4, 172841
                  lui          t4, 172841
                  and          a1, s3, s0
                  andi         s6, a4, 204
                  or           s8, s8, t2
                  c.slli       a5, 14
                  rem          s8, t3, s11
                  sll          a2, t6, tp
                  xor          s5, s7, t6
                  divu         sp, t2, s2
                  divu         sp, t2, s2
                  c.addi16sp   sp, 384
                  c.srai       s1, 8
                  div          s8, ra, a4
                  c.addi4spn   a1, sp, 480
                  c.addi16sp   sp, 384
                  lui          t4, 172841
                  slli         t0, zero, 18
                  c.add        ra, a0
                  mul          s11, a6, a7
                  sltu         t1, a6, a2
                  nop
                  lui          t4, 172841
                  c.sub        s0, s0
                  andi         s6, a4, 204
                  andi         s6, a4, 204
                  c.addi4spn   a1, sp, 480
                  sra          s1, s7, t6
                  srai         s11, a5, 6
                  sra          s1, s7, t6
                  sub          t3, a0, t2
                  sll          a2, t6, tp
                  sll          a2, t6, tp
                  c.slli       a5, 14
                  c.li         gp, -1
                  slli         t0, zero, 18
                  auipc        zero, 631536
                  srli         tp, ra, 29
                  c.mv         s6, sp
                  c.addi       s5, -1
                  c.li         gp, -1
                  c.srai       s1, 8
                  or           s8, s8, t2
                  c.or         a2, a3
                  and          a1, s3, s0
                  sub          t3, a0, t2
                  c.add        ra, a0
                  c.lui        t2, 18
                  c.or         a2, a3
                  auipc        zero, 631536
                  c.addi       s5, -1
                  slli         t0, zero, 18
                  sra          s1, s7, t6
                  c.srli       s1, 18
                  c.and        a1, a3
                  c.nop
                  c.srli       s1, 18
                  c.srli       s1, 18
                  c.srai       s1, 8
                  srli         tp, ra, 29
                  c.add        ra, a0
                  c.addi       s5, -1
                  sltiu        t6, sp, 205
                  c.slli       a5, 14
                  c.add        ra, a0
                  c.addi       s5, -1
                  lui          t4, 172841
                  c.srai       s1, 8
                  c.xor        a2, a5
                  or           s8, s8, t2
                  ori          s1, a7, 303
                  mul          s11, a6, a7
                  sltu         t1, a6, a2
                  addi         s11, s11, -143
                  xor          s5, s7, t6
                  sltiu        t6, sp, 205
                  c.mv         s6, sp
                  slt          s6, s6, gp
                  sltiu        t6, sp, 205
                  mulhsu       a1, gp, a0
                  slli         t0, zero, 18
                  srli         tp, ra, 29
                  c.srli       s1, 18
                  sll          a2, t6, tp
                  c.nop
                  c.addi4spn   a1, sp, 480
                  c.addi       s5, -1
                  sltu         t1, a6, a2
                  c.slli       a5, 14
                  c.sub        s0, s0
                  c.or         a2, a3
                  c.mv         s6, sp
                  xor          s5, s7, t6
                  nop
                  c.sub        s0, s0
                  auipc        zero, 631536
                  sub          t3, a0, t2
                  xor          s5, s7, t6
                  c.and        a1, a3
                  sltiu        t6, sp, 205
                  slt          s6, s6, gp
                  div          s8, ra, a4
                  c.mv         s6, sp
                  mulhu        s5, t3, zero
                  c.lui        t2, 18
                  rem          s8, t3, s11
                  and          a1, s3, s0
                  c.andi       s0, -1
                  c.xor        a2, a5
                  andi         s6, a4, 204
                  and          a1, s3, s0
                  xori         t0, t6, -1239
                  slt          s6, s6, gp
                  c.lui        t2, 18
                  sltiu        t6, sp, 205
                  c.sub        s0, s0
                  sub          t3, a0, t2
                  c.li         gp, -1
                  sll          a2, t6, tp
                  mulhsu       a1, gp, a0
                  c.srai       s1, 8
                  mulhsu       a1, gp, a0
                  sll          a2, t6, tp
                  rem          s8, t3, s11
                  lui          t4, 172841
                  auipc        zero, 631536
                  c.mv         s6, sp
                  div          s8, ra, a4
                  sra          s1, s7, t6
                  c.or         a2, a3
                  srli         tp, ra, 29
                  sra          s1, s7, t6
                  slt          s6, s6, gp
                  sub          t3, a0, t2
                  c.xor        a2, a5
                  rem          s8, t3, s11
                  c.srli       s1, 18
                  c.or         a2, a3
                  c.srli       s1, 18
                  div          s8, ra, a4
                  c.nop
                  c.addi4spn   a1, sp, 480
                  c.lui        t2, 18
                  slt          s6, s6, gp
                  c.and        a1, a3
                  sub          t3, a0, t2
                  c.slli       a5, 14
                  div          s8, ra, a4
                  divu         sp, t2, s2
                  c.mv         s6, sp
                  xori         t0, t6, -1239
                  ori          s1, a7, 303
                  c.addi4spn   a1, sp, 480
                  sra          s1, s7, t6
                  c.mv         s6, sp
                  c.li         gp, -1
                  c.srai       s1, 8
                  c.addi16sp   sp, 384
                  slt          s6, s6, gp
                  c.sub        s0, s0
                  c.slli       a5, 14
                  xori         t0, t6, -1239
                  add          s2, gp, s8
                  mulh         t4, s3, s10
                  remu         s9, a2, t1
                  mul          s11, a6, a7
                  slti         s6, tp, 996
                  add          s2, gp, s8
                  srli         tp, ra, 29
                  addi         s11, s11, -143
                  ori          s1, a7, 303
                  c.srai       s1, 8
                  rem          s8, t3, s11
                  mul          s11, a6, a7
                  c.addi4spn   a1, sp, 480
                  c.or         a2, a3
                  c.srai       s1, 8
                  or           s8, s8, t2
                  ori          s1, a7, 303
                  xori         t0, t6, -1239
                  slt          s6, s6, gp
                  srai         s11, a5, 6
                  rem          s8, t3, s11
                  andi         s6, a4, 204
                  srl          a6, s8, s9
                  c.add        ra, a0
                  c.addi4spn   a1, sp, 480
                  c.addi4spn   a1, sp, 480
                  lui          t4, 172841
                  sltiu        t6, sp, 205
                  srl          a6, s8, s9
                  c.li         gp, -1
                  andi         s6, a4, 204
                  addi         s11, s11, -143
                  xori         t0, t6, -1239
                  mulhsu       a1, gp, a0
                  c.slli       a5, 14
                  c.li         gp, -1
                  c.srli       s1, 18
                  div          s8, ra, a4
                  remu         s9, a2, t1
                  sltiu        t6, sp, 205
                  auipc        zero, 631536
                  srli         tp, ra, 29
                  xor          s5, s7, t6
                  add          s2, gp, s8
                  c.andi       s0, -1
                  c.mv         s6, sp
                  addi         s11, s11, -143
                  srli         tp, ra, 29
                  addi         s11, s11, -143
                  slli         t0, zero, 18
                  c.srli       s1, 18
                  srl          a6, s8, s9
                  c.lui        t2, 18
                  add          s2, gp, s8
                  addi         s11, s11, -143
                  ori          s1, a7, 303
                  ori          s1, a7, 303
                  nop
                  c.li         gp, -1
                  xor          s5, s7, t6
                  remu         s9, a2, t1
                  sll          a2, t6, tp
                  mulhsu       a1, gp, a0
                  slt          s6, s6, gp
                  c.sub        s0, s0
                  mulh         t4, s3, s10
                  xori         t0, t6, -1239
                  remu         s9, a2, t1
                  sub          t3, a0, t2
                  xori         t0, t6, -1239
                  c.sub        s0, s0
                  or           s8, s8, t2
                  c.addi16sp   sp, 384
                  mulh         t4, s3, s10
                  c.nop
                  addi         s11, s11, -143
                  c.srai       s1, 8
                  slti         s6, tp, 996
                  nop
                  add          s2, gp, s8
                  slt          s6, s6, gp
                  slti         s6, tp, 996
                  sll          a2, t6, tp
                  addi         s11, s11, -143
                  srl          a6, s8, s9
                  srl          a6, s8, s9
                  c.addi4spn   a1, sp, 480
                  mulhsu       a1, gp, a0
                  ori          s1, a7, 303
                  c.add        ra, a0
                  mulhu        s5, t3, zero
                  c.nop
                  ori          s1, a7, 303
                  slti         s6, tp, 996
                  c.addi4spn   a1, sp, 480
                  lui          t4, 172841
                  sltu         t1, a6, a2
                  c.addi       s5, -1
                  sltiu        t6, sp, 205
                  and          a1, s3, s0
                  or           s8, s8, t2
                  c.xor        a2, a5
                  mulhsu       a1, gp, a0
                  sub          t3, a0, t2
                  srai         s11, a5, 6
                  remu         s9, a2, t1
                  addi         s11, s11, -143
                  mulhu        s5, t3, zero
                  xori         t0, t6, -1239
                  c.srli       s1, 18
                  auipc        zero, 631536
                  c.sub        s0, s0
                  slt          s6, s6, gp
                  c.nop
                  c.srli       s1, 18
                  c.slli       a5, 14
                  auipc        zero, 631536
                  c.addi4spn   a1, sp, 480
                  addi         s11, s11, -143
                  slt          s6, s6, gp
                  c.srli       s1, 18
                  sra          s1, s7, t6
                  and          a1, s3, s0
                  xori         t0, t6, -1239
                  c.addi16sp   sp, 384
                  c.add        ra, a0
                  sub          t3, a0, t2
                  slli         t0, zero, 18
                  sltiu        t6, sp, 205
                  c.add        ra, a0
                  c.addi16sp   sp, 384
                  ori          s1, a7, 303
                  add          s2, gp, s8
                  c.xor        a2, a5
                  or           s8, s8, t2
                  c.srli       s1, 18
                  c.addi4spn   a1, sp, 480
                  c.mv         s6, sp
                  slt          s6, s6, gp
                  c.slli       a5, 14
                  addi         s11, s11, -143
                  c.andi       s0, -1
                  c.li         gp, -1
                  addi         s11, s11, -143
                  sra          s1, s7, t6
                  c.addi       s5, -1
                  slli         t0, zero, 18
                  xor          s5, s7, t6
                  c.and        a1, a3
                  sltu         t1, a6, a2
                  c.slli       a5, 14
                  c.sub        s0, s0
                  c.lui        t2, 18
                  slli         t0, zero, 18
                  remu         s9, a2, t1
                  sll          a2, t6, tp
                  xori         t0, t6, -1239
                  srli         tp, ra, 29
                  c.addi4spn   a1, sp, 480
                  c.xor        a2, a5
                  mulhsu       a1, gp, a0
                  c.add        ra, a0
                  c.lui        t2, 18
                  andi         s6, a4, 204
                  c.sub        s0, s0
                  sra          s1, s7, t6
                  divu         sp, t2, s2
                  ori          s1, a7, 303
                  srli         tp, ra, 29
                  c.slli       a5, 14
                  divu         sp, t2, s2
                  c.and        a1, a3
                  or           s8, s8, t2
                  srli         tp, ra, 29
                  c.srai       s1, 8
                  c.li         gp, -1
                  c.mv         s6, sp
                  c.nop
                  andi         s6, a4, 204
                  c.andi       s0, -1
                  c.or         a2, a3
                  mulhu        s5, t3, zero
                  c.addi4spn   a1, sp, 480
                  slti         s6, tp, 996
                  sra          s1, s7, t6
                  c.or         a2, a3
                  c.and        a1, a3
                  or           s8, s8, t2
                  or           s8, s8, t2
                  sll          a2, t6, tp
                  and          a1, s3, s0
                  and          a1, s3, s0
                  c.add        ra, a0
                  xori         t0, t6, -1239
                  divu         sp, t2, s2
                  srl          a6, s8, s9
                  srl          a6, s8, s9
                  c.or         a2, a3
                  xor          s5, s7, t6
                  li           tp, 0xdc8aa659 #start riscv_int_numeric_corner_stream_17
                  li           s1, 0x0
                  li           s6, 0xffffffff
                  li           s5, 0xffffffff
                  li           sp, 0xd2ff14f2
                  li           t4, 0x0
                  li           t2, 0x0
                  li           s10, 0x80000000
                  li           s2, 0x0
                  li           t5, 0x9816cb4c
                  divu         t2, s10, t2
                  divu         t2, s10, t2
                  mul          t4, sp, tp
                  rem          s5, t4, sp
                  auipc        sp, 631536
                  lui          t5, 172841
                  sub          t5, t5, s10
                  addi         t4, s5, -143
                  div          s5, tp, t5
                  rem          s5, t4, sp
                  nop
                  rem          s5, t4, sp
                  mulh         sp, s1, s5
                  mul          t4, sp, tp
                  addi         t4, s5, -143
                  div          s5, tp, t5
                  remu         s6, t2, s6 #end riscv_int_numeric_corner_stream_17
                  add          s2, gp, s8
                  andi         s6, a4, 204
                  ori          s1, a7, 303
                  nop
                  and          a1, s3, s0
                  auipc        zero, 631536
                  rem          s8, t3, s11
                  divu         sp, t2, s2
                  add          s2, gp, s8
                  c.lui        t2, 18
                  c.addi4spn   a1, sp, 480
                  sub          t3, a0, t2
                  slti         s6, tp, 996
                  c.li         gp, -1
                  addi         s11, s11, -143
                  c.andi       s0, -1
                  rem          s8, t3, s11
                  add          s2, gp, s8
                  remu         s9, a2, t1
                  slti         s6, tp, 996
                  c.srai       s1, 8
                  xor          s5, s7, t6
                  divu         sp, t2, s2
                  srli         tp, ra, 29
                  nop
                  mulhsu       a1, gp, a0
                  andi         s6, a4, 204
                  addi         s11, s11, -143
                  c.li         gp, -1
                  c.addi4spn   a1, sp, 480
                  c.li         gp, -1
                  c.add        ra, a0
                  add          s2, gp, s8
                  srai         s11, a5, 6
                  sra          s1, s7, t6
                  div          s8, ra, a4
                  lui          t4, 172841
                  divu         sp, t2, s2
                  rem          s8, t3, s11
                  srl          a6, s8, s9
                  andi         s6, a4, 204
                  c.slli       a5, 14
                  div          s8, ra, a4
                  srli         tp, ra, 29
                  c.slli       a5, 14
                  slti         s6, tp, 996
                  remu         s9, a2, t1
                  sltiu        t6, sp, 205
                  slti         s6, tp, 996
                  and          a1, s3, s0
                  andi         s6, a4, 204
                  c.srai       s1, 8
                  div          s8, ra, a4
                  sltu         t1, a6, a2
                  nop
                  c.andi       s0, -1
                  or           s8, s8, t2
                  and          a1, s3, s0
                  c.or         a2, a3
                  and          a1, s3, s0
                  sll          a2, t6, tp
                  andi         s6, a4, 204
                  rem          s8, t3, s11
                  auipc        zero, 631536
                  nop
                  sub          t3, a0, t2
                  andi         s6, a4, 204
                  andi         s6, a4, 204
                  srli         tp, ra, 29
                  or           s8, s8, t2
                  divu         sp, t2, s2
                  remu         s9, a2, t1
                  c.addi       s5, -1
                  c.or         a2, a3
                  mul          s11, a6, a7
                  c.nop
                  div          s8, ra, a4
                  sub          t3, a0, t2
                  ori          s1, a7, 303
                  slli         t0, zero, 18
                  mul          s11, a6, a7
                  c.nop
                  andi         s6, a4, 204
                  divu         sp, t2, s2
                  addi         s11, s11, -143
                  xori         t0, t6, -1239
                  c.slli       a5, 14
                  lui          t4, 172841
                  c.add        ra, a0
                  xori         t0, t6, -1239
                  slli         t0, zero, 18
                  sltiu        t6, sp, 205
                  c.addi4spn   a1, sp, 480
                  auipc        zero, 631536
                  c.andi       s0, -1
                  srai         s11, a5, 6
                  c.addi       s5, -1
                  c.slli       a5, 14
                  srai         s11, a5, 6
                  divu         sp, t2, s2
                  remu         s9, a2, t1
                  srli         tp, ra, 29
                  c.addi16sp   sp, 384
                  div          s8, ra, a4
                  c.mv         s6, sp
                  c.nop
                  srli         tp, ra, 29
                  slt          s6, s6, gp
                  rem          s8, t3, s11
                  auipc        zero, 631536
                  ori          s1, a7, 303
                  div          s8, ra, a4
                  rem          s8, t3, s11
                  slt          s6, s6, gp
                  remu         s9, a2, t1
                  sltiu        t6, sp, 205
                  c.add        ra, a0
                  c.nop
                  or           s8, s8, t2
                  mul          s11, a6, a7
                  ori          s1, a7, 303
                  mulhsu       a1, gp, a0
                  xor          s5, s7, t6
                  mulhu        s5, t3, zero
                  c.and        a1, a3
                  and          a1, s3, s0
                  c.and        a1, a3
                  sra          s1, s7, t6
                  srai         s11, a5, 6
                  c.lui        t2, 18
                  c.andi       s0, -1
                  and          a1, s3, s0
                  lui          t4, 172841
                  lui          t4, 172841
                  add          s2, gp, s8
                  add          s2, gp, s8
                  c.andi       s0, -1
                  c.addi16sp   sp, 384
                  slt          s6, s6, gp
                  add          s2, gp, s8
                  add          s2, gp, s8
                  c.addi16sp   sp, 384
                  or           s8, s8, t2
                  nop
                  c.or         a2, a3
                  c.sub        s0, s0
                  c.srli       s1, 18
                  lui          t4, 172841
                  li           tp, 0xcdc50bcf #start riscv_int_numeric_corner_stream_4
                  li           s8, 0x80000000
                  li           a5, 0x0
                  li           s6, 0x0
                  li           t6, 0x0
                  li           t4, 0x80000000
                  li           a6, 0x80000000
                  li           t3, 0x0
                  li           s7, 0xffffffff
                  li           a2, 0x164f854d
                  mulh         tp, a6, s7
                  mul          t4, tp, a2
                  nop
                  lui          t6, 172841
                  sub          t6, t6, t3
                  div          s7, a2, t6
                  rem          s7, t4, tp
                  addi         t4, s7, -143
                  auipc        tp, 631536
                  mulhu        a5, t4, tp
                  remu         s8, a5, s8
                  mulhsu       t3, a6, s6
                  mul          t4, tp, a2
                  sub          t6, t6, t3
                  mulh         tp, a6, s7
                  lui          t6, 172841
                  mulh         tp, a6, s7
                  mul          t4, tp, a2
                  rem          s7, t4, tp
                  lui          t6, 172841
                  mulhu        a5, t4, tp
                  add          tp, a6, t4
                  mulh         tp, a6, s7
                  auipc        tp, 631536
                  mul          t4, tp, a2
                  addi         t4, s7, -143
                  mulh         tp, a6, s7
                  mulhu        a5, t4, tp
                  mulh         tp, a6, s7
                  mulhsu       t3, a6, s6 #end riscv_int_numeric_corner_stream_4
                  c.sub        s0, s0
                  slti         s6, tp, 996
                  slti         s6, tp, 996
                  remu         s9, a2, t1
                  nop
                  c.slli       a5, 14
                  srai         s11, a5, 6
                  c.addi16sp   sp, 384
                  xori         t0, t6, -1239
                  xori         t0, t6, -1239
                  xor          s5, s7, t6
                  c.mv         s6, sp
                  slli         t0, zero, 18
                  slti         s6, tp, 996
                  c.addi16sp   sp, 384
                  lui          t4, 172841
                  c.xor        a2, a5
                  remu         s9, a2, t1
                  c.mv         s6, sp
                  c.andi       s0, -1
                  addi         s11, s11, -143
                  lui          t4, 172841
                  sltiu        t6, sp, 205
                  sll          a2, t6, tp
                  mul          s11, a6, a7
                  c.addi16sp   sp, 384
                  slt          s6, s6, gp
                  srai         s11, a5, 6
                  c.andi       s0, -1
                  mul          s11, a6, a7
                  sra          s1, s7, t6
                  slt          s6, s6, gp
                  c.add        ra, a0
                  sub          t3, a0, t2
                  add          s2, gp, s8
                  nop
                  xor          s5, s7, t6
                  slt          s6, s6, gp
                  c.and        a1, a3
                  mulhu        s5, t3, zero
                  srl          a6, s8, s9
                  c.nop
                  srai         s11, a5, 6
                  srli         tp, ra, 29
                  srai         s11, a5, 6
                  srli         tp, ra, 29
                  or           s8, s8, t2
                  c.addi4spn   a1, sp, 480
                  lui          t4, 172841
                  auipc        zero, 631536
                  lui          t4, 172841
                  sltu         t1, a6, a2
                  lui          t4, 172841
                  sub          t3, a0, t2
                  c.nop
                  srli         tp, ra, 29
                  slt          s6, s6, gp
                  divu         sp, t2, s2
                  andi         s6, a4, 204
                  div          s8, ra, a4
                  mulhsu       a1, gp, a0
                  slt          s6, s6, gp
                  c.li         gp, -1
                  nop
                  nop
                  c.nop
                  srl          a6, s8, s9
                  and          a1, s3, s0
                  mulhu        s5, t3, zero
                  slt          s6, s6, gp
                  addi         s11, s11, -143
                  and          a1, s3, s0
                  xor          s5, s7, t6
                  andi         s6, a4, 204
                  rem          s8, t3, s11
                  srl          a6, s8, s9
                  sltiu        t6, sp, 205
                  sltu         t1, a6, a2
                  sltiu        t6, sp, 205
                  sub          t3, a0, t2
                  c.sub        s0, s0
                  c.lui        t2, 18
                  sub          t3, a0, t2
                  and          a1, s3, s0
                  sra          s1, s7, t6
                  and          a1, s3, s0
                  c.addi       s5, -1
                  slli         t0, zero, 18
                  sub          t3, a0, t2
                  sub          t3, a0, t2
                  xor          s5, s7, t6
                  lui          t4, 172841
                  auipc        zero, 631536
                  c.xor        a2, a5
                  c.srli       s1, 18
                  nop
                  auipc        zero, 631536
                  sll          a2, t6, tp
                  auipc        zero, 631536
                  mulhsu       a1, gp, a0
                  divu         sp, t2, s2
                  mulhsu       a1, gp, a0
                  srl          a6, s8, s9
                  andi         s6, a4, 204
                  c.mv         s6, sp
                  rem          s8, t3, s11
                  c.sub        s0, s0
                  sll          a2, t6, tp
                  mulhu        s5, t3, zero
                  c.addi       s5, -1
                  c.and        a1, a3
                  srai         s11, a5, 6
                  srli         tp, ra, 29
                  add          s2, gp, s8
                  mul          s11, a6, a7
                  xori         t0, t6, -1239
                  c.lui        t2, 18
                  ori          s1, a7, 303
                  c.li         gp, -1
                  c.li         gp, -1
                  ori          s1, a7, 303
                  mulhu        s5, t3, zero
                  srli         tp, ra, 29
                  c.or         a2, a3
                  c.mv         s6, sp
                  slti         s6, tp, 996
                  rem          s8, t3, s11
                  sltu         t1, a6, a2
                  c.andi       s0, -1
                  mulh         t4, s3, s10
                  srl          a6, s8, s9
                  srai         s11, a5, 6
                  srl          a6, s8, s9
                  srli         tp, ra, 29
                  c.li         gp, -1
                  c.addi4spn   a1, sp, 480
                  c.li         gp, -1
                  divu         sp, t2, s2
                  nop
                  li           s7, 0x7af67bf6 #start riscv_int_numeric_corner_stream_11
                  li           tp, 0x0
                  li           t1, 0x0
                  li           t4, 0xf259850
                  li           s1, 0x0
                  li           a6, 0x80000000
                  li           s3, 0x80000000
                  li           s0, 0xffffffff
                  li           t3, 0xbbf58394
                  li           a5, 0xda0d15cb
                  auipc        tp, 631536
                  div          a6, t1, t4
                  mulhsu       s7, s1, a5
                  nop
                  mulh         tp, s1, a6
                  div          a6, t1, t4
                  sub          t4, t4, s7
                  rem          a6, t3, tp
                  divu         s0, s7, s0
                  addi         t3, a6, -143
                  addi         t3, a6, -143
                  lui          t4, 172841
                  remu         s3, s0, s3
                  mulhu        s0, t3, tp
                  divu         s0, s7, s0
                  nop
                  div          a6, t1, t4
                  add          tp, s1, t3
                  mulh         tp, s1, a6
                  nop
                  mulhu        s0, t3, tp
                  sub          t4, t4, s7
                  nop
                  sub          t4, t4, s7
                  rem          a6, t3, tp
                  mulhu        s0, t3, tp
                  mulhu        s0, t3, tp #end riscv_int_numeric_corner_stream_11
                  mulhsu       a1, gp, a0
                  slt          s6, s6, gp
                  c.addi16sp   sp, 384
                  c.lui        t2, 18
                  divu         sp, t2, s2
                  xori         t0, t6, -1239
                  slt          s6, s6, gp
                  c.srli       s1, 18
                  sltu         t1, a6, a2
                  ori          s1, a7, 303
                  c.addi       s5, -1
                  srai         s11, a5, 6
                  sltiu        t6, sp, 205
                  slt          s6, s6, gp
                  mul          s11, a6, a7
                  lui          t4, 172841
                  c.slli       a5, 14
                  auipc        zero, 631536
                  or           s8, s8, t2
                  slt          s6, s6, gp
                  slt          s6, s6, gp
                  srl          a6, s8, s9
                  c.li         gp, -1
                  c.sub        s0, s0
                  xori         t0, t6, -1239
                  div          s8, ra, a4
                  c.addi       s5, -1
                  c.nop
                  mulhu        s5, t3, zero
                  srai         s11, a5, 6
                  c.add        ra, a0
                  divu         sp, t2, s2
                  or           s8, s8, t2
                  c.srli       s1, 18
                  sltu         t1, a6, a2
                  c.addi       s5, -1
                  sub          t3, a0, t2
                  and          a1, s3, s0
                  c.srli       s1, 18
                  div          s8, ra, a4
                  c.sub        s0, s0
                  div          s8, ra, a4
                  divu         sp, t2, s2
                  srli         tp, ra, 29
                  srli         tp, ra, 29
                  c.li         gp, -1
                  c.nop
                  sll          a2, t6, tp
                  c.srai       s1, 8
                  slti         s6, tp, 996
                  c.xor        a2, a5
                  c.addi       s5, -1
                  lui          t4, 172841
                  mulh         t4, s3, s10
                  sll          a2, t6, tp
                  c.nop
                  c.addi       s5, -1
                  rem          s8, t3, s11
                  c.addi4spn   a1, sp, 480
                  slti         s6, tp, 996
                  c.srli       s1, 18
                  divu         sp, t2, s2
                  divu         sp, t2, s2
                  or           s8, s8, t2
                  c.srli       s1, 18
                  andi         s6, a4, 204
                  mulhu        s5, t3, zero
                  sltu         t1, a6, a2
                  slli         t0, zero, 18
                  srl          a6, s8, s9
                  sltu         t1, a6, a2
                  slt          s6, s6, gp
                  mulhu        s5, t3, zero
                  slt          s6, s6, gp
                  sltu         t1, a6, a2
                  c.addi16sp   sp, 384
                  sltu         t1, a6, a2
                  c.mv         s6, sp
                  andi         s6, a4, 204
                  slt          s6, s6, gp
                  c.add        ra, a0
                  mul          s11, a6, a7
                  sll          a2, t6, tp
                  c.xor        a2, a5
                  mulhsu       a1, gp, a0
                  srl          a6, s8, s9
                  c.addi4spn   a1, sp, 480
                  c.li         gp, -1
                  div          s8, ra, a4
                  sra          s1, s7, t6
                  c.add        ra, a0
                  c.nop
                  c.and        a1, a3
                  sltiu        t6, sp, 205
                  c.add        ra, a0
                  rem          s8, t3, s11
                  sra          s1, s7, t6
                  and          a1, s3, s0
                  c.and        a1, a3
                  c.andi       s0, -1
                  ori          s1, a7, 303
                  c.andi       s0, -1
                  mulh         t4, s3, s10
                  nop
                  div          s8, ra, a4
                  c.xor        a2, a5
                  c.and        a1, a3
                  c.srli       s1, 18
                  c.nop
                  c.li         gp, -1
                  c.srai       s1, 8
                  c.nop
                  xori         t0, t6, -1239
                  auipc        zero, 631536
                  c.xor        a2, a5
                  c.addi16sp   sp, 384
                  remu         s9, a2, t1
                  auipc        zero, 631536
                  srai         s11, a5, 6
                  ori          s1, a7, 303
                  andi         s6, a4, 204
                  slt          s6, s6, gp
                  or           s8, s8, t2
                  c.addi4spn   a1, sp, 480
                  sub          t3, a0, t2
                  or           s8, s8, t2
                  srl          a6, s8, s9
                  c.or         a2, a3
                  srai         s11, a5, 6
                  nop
                  slt          s6, s6, gp
                  mul          s11, a6, a7
                  c.nop
                  c.mv         s6, sp
                  c.sub        s0, s0
                  lui          t4, 172841
                  c.lui        t2, 18
                  c.xor        a2, a5
                  c.andi       s0, -1
                  div          s8, ra, a4
                  ori          s1, a7, 303
                  c.srai       s1, 8
                  slti         s6, tp, 996
                  c.srai       s1, 8
                  c.mv         s6, sp
                  c.lui        t2, 18
                  auipc        zero, 631536
                  sub          t3, a0, t2
                  srli         tp, ra, 29
                  and          a1, s3, s0
                  slli         t0, zero, 18
                  c.add        ra, a0
                  xor          s5, s7, t6
                  srl          a6, s8, s9
                  c.nop
                  slt          s6, s6, gp
                  c.sub        s0, s0
                  sll          a2, t6, tp
                  mulhsu       a1, gp, a0
                  c.li         gp, -1
                  sll          a2, t6, tp
                  sltu         t1, a6, a2
                  c.xor        a2, a5
                  slti         s6, tp, 996
                  rem          s8, t3, s11
                  c.li         gp, -1
                  c.addi       s5, -1
                  c.lui        t2, 18
                  remu         s9, a2, t1
                  div          s8, ra, a4
                  div          s8, ra, a4
                  c.addi       s5, -1
                  or           s8, s8, t2
                  c.addi       s5, -1
                  remu         s9, a2, t1
                  srl          a6, s8, s9
                  c.and        a1, a3
                  andi         s6, a4, 204
                  c.addi16sp   sp, 384
                  addi         s11, s11, -143
                  c.srai       s1, 8
                  c.slli       a5, 14
                  mulh         t4, s3, s10
                  xori         t0, t6, -1239
                  slli         t0, zero, 18
                  c.srli       s1, 18
                  sltu         t1, a6, a2
                  auipc        zero, 631536
                  xori         t0, t6, -1239
                  nop
                  mulh         t4, s3, s10
                  remu         s9, a2, t1
                  c.xor        a2, a5
                  c.nop
                  xor          s5, s7, t6
                  c.addi4spn   a1, sp, 480
                  c.sub        s0, s0
                  remu         s9, a2, t1
                  sra          s1, s7, t6
                  and          a1, s3, s0
                  lui          t4, 172841
                  remu         s9, a2, t1
                  c.lui        t2, 18
                  srl          a6, s8, s9
                  ori          s1, a7, 303
                  addi         s11, s11, -143
                  mulhsu       a1, gp, a0
                  xori         t0, t6, -1239
                  xor          s5, s7, t6
                  mulhu        s5, t3, zero
                  rem          s8, t3, s11
                  add          s2, gp, s8
                  srli         tp, ra, 29
                  srl          a6, s8, s9
                  sltu         t1, a6, a2
                  c.andi       s0, -1
                  or           s8, s8, t2
                  mulhsu       a1, gp, a0
                  mulh         t4, s3, s10
                  remu         s9, a2, t1
                  srli         tp, ra, 29
                  c.mv         s6, sp
                  remu         s9, a2, t1
                  c.sub        s0, s0
                  auipc        zero, 631536
                  mul          s11, a6, a7
                  c.mv         s6, sp
                  srli         tp, ra, 29
                  srai         s11, a5, 6
                  c.srli       s1, 18
                  mulhu        s5, t3, zero
                  divu         sp, t2, s2
                  xor          s5, s7, t6
                  c.nop
                  c.li         gp, -1
                  divu         sp, t2, s2
                  remu         s9, a2, t1
                  nop
                  div          s8, ra, a4
                  rem          s8, t3, s11
                  c.nop
                  srl          a6, s8, s9
                  xori         t0, t6, -1239
                  c.slli       a5, 14
                  rem          s8, t3, s11
                  sltu         t1, a6, a2
                  c.nop
                  c.li         gp, -1
                  remu         s9, a2, t1
                  c.addi16sp   sp, 384
                  c.lui        t2, 18
                  c.srli       s1, 18
                  mulh         t4, s3, s10
                  c.srli       s1, 18
                  c.li         gp, -1
                  sltu         t1, a6, a2
                  mulhsu       a1, gp, a0
                  c.addi4spn   a1, sp, 480
                  slti         s6, tp, 996
                  or           s8, s8, t2
                  c.or         a2, a3
                  divu         sp, t2, s2
                  srai         s11, a5, 6
                  mulh         t4, s3, s10
                  addi         s11, s11, -143
                  srli         tp, ra, 29
                  or           s8, s8, t2
                  add          s2, gp, s8
                  sltiu        t6, sp, 205
                  c.srai       s1, 8
                  divu         sp, t2, s2
                  c.sub        s0, s0
                  slli         t0, zero, 18
                  addi         s11, s11, -143
                  c.srai       s1, 8
                  mulh         t4, s3, s10
                  slt          s6, s6, gp
                  divu         sp, t2, s2
                  srl          a6, s8, s9
                  mulhsu       a1, gp, a0
                  divu         sp, t2, s2
                  c.li         gp, -1
                  slti         s6, tp, 996
                  sltiu        t6, sp, 205
                  ori          s1, a7, 303
                  c.nop
                  c.addi16sp   sp, 384
                  c.nop
                  andi         s6, a4, 204
                  c.srli       s1, 18
                  slli         t0, zero, 18
                  add          s2, gp, s8
                  sra          s1, s7, t6
                  c.mv         s6, sp
                  c.sub        s0, s0
                  rem          s8, t3, s11
                  sra          s1, s7, t6
                  remu         s9, a2, t1
                  c.srli       s1, 18
                  addi         s11, s11, -143
                  and          a1, s3, s0
                  addi         s11, s11, -143
                  add          s2, gp, s8
                  c.srli       s1, 18
                  c.li         gp, -1
                  c.nop
                  c.addi16sp   sp, 384
                  divu         sp, t2, s2
                  c.addi4spn   a1, sp, 480
                  c.srai       s1, 8
                  c.slli       a5, 14
                  remu         s9, a2, t1
                  c.addi4spn   a1, sp, 480
                  ori          s1, a7, 303
                  sra          s1, s7, t6
                  slli         t0, zero, 18
                  and          a1, s3, s0
                  slti         s6, tp, 996
                  and          a1, s3, s0
                  c.addi16sp   sp, 384
                  sub          t3, a0, t2
                  srli         tp, ra, 29
                  c.addi16sp   sp, 384
                  c.and        a1, a3
                  add          s2, gp, s8
                  lui          t4, 172841
                  slt          s6, s6, gp
                  mulhsu       a1, gp, a0
                  and          a1, s3, s0
                  auipc        zero, 631536
                  c.srli       s1, 18
                  c.addi4spn   a1, sp, 480
                  c.andi       s0, -1
                  divu         sp, t2, s2
                  srai         s11, a5, 6
                  remu         s9, a2, t1
                  c.addi4spn   a1, sp, 480
                  divu         sp, t2, s2
                  andi         s6, a4, 204
                  lui          t4, 172841
                  rem          s8, t3, s11
                  mulhsu       a1, gp, a0
                  andi         s6, a4, 204
                  rem          s8, t3, s11
                  c.nop
                  slti         s6, tp, 996
                  c.srai       s1, 8
                  xor          s5, s7, t6
                  c.addi16sp   sp, 384
                  addi         s11, s11, -143
                  mulh         t4, s3, s10
                  and          a1, s3, s0
                  c.nop
                  sltu         t1, a6, a2
                  c.mv         s6, sp
                  c.addi4spn   a1, sp, 480
                  auipc        zero, 631536
                  srai         s11, a5, 6
                  divu         sp, t2, s2
                  srli         tp, ra, 29
                  and          a1, s3, s0
                  mulhu        s5, t3, zero
                  c.srai       s1, 8
                  auipc        zero, 631536
                  sub          t3, a0, t2
                  nop
                  div          s8, ra, a4
                  c.mv         s6, sp
                  c.or         a2, a3
                  andi         s6, a4, 204
                  mul          s11, a6, a7
                  c.andi       s0, -1
                  c.slli       a5, 14
                  sltu         t1, a6, a2
                  c.slli       a5, 14
                  ori          s1, a7, 303
                  sltiu        t6, sp, 205
                  sub          t3, a0, t2
                  lui          t4, 172841
                  div          s8, ra, a4
                  addi         s11, s11, -143
                  mulh         t4, s3, s10
                  c.mv         s6, sp
                  c.lui        t2, 18
                  and          a1, s3, s0
                  c.addi16sp   sp, 384
                  c.slli       a5, 14
                  srai         s11, a5, 6
                  addi         s11, s11, -143
                  c.and        a1, a3
                  div          s8, ra, a4
                  srl          a6, s8, s9
                  nop
                  c.and        a1, a3
                  slt          s6, s6, gp
                  c.mv         s6, sp
                  add          s2, gp, s8
                  sra          s1, s7, t6
                  sltiu        t6, sp, 205
                  rem          s8, t3, s11
                  c.lui        t2, 18
                  c.mv         s6, sp
                  sltu         t1, a6, a2
                  c.add        ra, a0
                  or           s8, s8, t2
                  mulh         t4, s3, s10
                  rem          s8, t3, s11
                  c.lui        t2, 18
                  mul          s11, a6, a7
                  c.mv         s6, sp
                  sub          t3, a0, t2
                  divu         sp, t2, s2
                  divu         sp, t2, s2
                  nop
                  c.mv         s6, sp
                  c.nop
                  sltiu        t6, sp, 205
                  sltiu        t6, sp, 205
                  lui          t4, 172841
                  c.and        a1, a3
                  srl          a6, s8, s9
                  slli         t0, zero, 18
                  and          a1, s3, s0
                  nop
                  mulhsu       a1, gp, a0
                  or           s8, s8, t2
                  divu         sp, t2, s2
                  slti         s6, tp, 996
                  srl          a6, s8, s9
                  c.slli       a5, 14
                  c.slli       a5, 14
                  lui          t4, 172841
                  srai         s11, a5, 6
                  c.andi       s0, -1
                  divu         sp, t2, s2
                  sra          s1, s7, t6
                  srai         s11, a5, 6
                  add          s2, gp, s8
                  addi         s11, s11, -143
                  c.addi4spn   a1, sp, 480
                  c.slli       a5, 14
                  or           s8, s8, t2
                  srli         tp, ra, 29
                  sll          a2, t6, tp
                  c.or         a2, a3
                  nop
                  c.andi       s0, -1
                  mul          s11, a6, a7
                  c.srai       s1, 8
                  sub          t3, a0, t2
                  c.xor        a2, a5
                  mul          s11, a6, a7
                  add          s2, gp, s8
                  c.lui        t2, 18
                  c.xor        a2, a5
                  srl          a6, s8, s9
                  nop
                  or           s8, s8, t2
                  mulh         t4, s3, s10
                  c.mv         s6, sp
                  sltu         t1, a6, a2
                  or           s8, s8, t2
                  xori         t0, t6, -1239
                  c.sub        s0, s0
                  c.nop
                  rem          s8, t3, s11
                  c.and        a1, a3
                  c.lui        t2, 18
                  srai         s11, a5, 6
                  c.andi       s0, -1
                  mulh         t4, s3, s10
                  mul          s11, a6, a7
                  c.or         a2, a3
                  c.mv         s6, sp
                  c.and        a1, a3
                  c.sub        s0, s0
                  c.xor        a2, a5
                  xor          s5, s7, t6
                  slti         s6, tp, 996
                  divu         sp, t2, s2
                  srl          a6, s8, s9
                  slt          s6, s6, gp
                  mulhsu       a1, gp, a0
                  c.srai       s1, 8
                  slt          s6, s6, gp
                  c.addi16sp   sp, 384
                  sltiu        t6, sp, 205
                  rem          s8, t3, s11
                  slt          s6, s6, gp
                  sltu         t1, a6, a2
                  sltiu        t6, sp, 205
                  c.srli       s1, 18
                  srl          a6, s8, s9
                  c.li         gp, -1
                  c.xor        a2, a5
                  add          s2, gp, s8
                  c.andi       s0, -1
                  lui          t4, 172841
                  sltu         t1, a6, a2
                  and          a1, s3, s0
                  rem          s8, t3, s11
                  sltu         t1, a6, a2
                  and          a1, s3, s0
                  auipc        zero, 631536
                  c.addi       s5, -1
                  slli         t0, zero, 18
                  mulhu        s5, t3, zero
                  slti         s6, tp, 996
                  lui          t4, 172841
                  slti         s6, tp, 996
                  c.or         a2, a3
                  slli         t0, zero, 18
                  c.nop
                  srl          a6, s8, s9
                  c.srai       s1, 8
                  addi         s11, s11, -143
                  auipc        zero, 631536
                  mulh         t4, s3, s10
                  c.and        a1, a3
                  add          s2, gp, s8
                  auipc        zero, 631536
                  c.srai       s1, 8
                  lui          t4, 172841
                  c.add        ra, a0
                  c.mv         s6, sp
                  xori         t0, t6, -1239
                  mulhu        s5, t3, zero
                  c.sub        s0, s0
                  sltiu        t6, sp, 205
                  c.addi4spn   a1, sp, 480
                  c.addi16sp   sp, 384
                  or           s8, s8, t2
                  srl          a6, s8, s9
                  c.and        a1, a3
                  c.add        ra, a0
                  c.nop
                  sra          s1, s7, t6
                  c.xor        a2, a5
                  srli         tp, ra, 29
                  rem          s8, t3, s11
                  mul          s11, a6, a7
                  sll          a2, t6, tp
                  c.slli       a5, 14
                  or           s8, s8, t2
                  srli         tp, ra, 29
                  c.li         gp, -1
                  slli         t0, zero, 18
                  andi         s6, a4, 204
                  c.sub        s0, s0
                  rem          s8, t3, s11
                  c.sub        s0, s0
                  c.addi       s5, -1
                  xor          s5, s7, t6
                  sltu         t1, a6, a2
                  rem          s8, t3, s11
                  div          s8, ra, a4
                  xor          s5, s7, t6
                  c.addi       s5, -1
                  srai         s11, a5, 6
                  or           s8, s8, t2
                  srai         s11, a5, 6
                  srli         tp, ra, 29
                  divu         sp, t2, s2
                  sltu         t1, a6, a2
                  slti         s6, tp, 996
                  c.xor        a2, a5
                  or           s8, s8, t2
                  div          s8, ra, a4
                  c.slli       a5, 14
                  and          a1, s3, s0
                  c.lui        t2, 18
                  mulhu        s5, t3, zero
                  nop
                  sra          s1, s7, t6
                  c.slli       a5, 14
                  c.srai       s1, 8
                  c.slli       a5, 14
                  addi         s11, s11, -143
                  lui          t4, 172841
                  sltu         t1, a6, a2
                  c.sub        s0, s0
                  mulh         t4, s3, s10
                  remu         s9, a2, t1
                  srl          a6, s8, s9
                  c.andi       s0, -1
                  mulh         t4, s3, s10
                  c.nop
                  mulhu        s5, t3, zero
                  c.li         gp, -1
                  c.slli       a5, 14
                  srli         tp, ra, 29
                  and          a1, s3, s0
                  c.sub        s0, s0
                  divu         sp, t2, s2
                  c.addi4spn   a1, sp, 480
                  c.nop
                  sub          t3, a0, t2
                  xor          s5, s7, t6
                  srai         s11, a5, 6
                  lui          t4, 172841
                  remu         s9, a2, t1
                  sltiu        t6, sp, 205
                  srl          a6, s8, s9
                  c.or         a2, a3
                  c.nop
                  ori          s1, a7, 303
                  mulhsu       a1, gp, a0
                  c.or         a2, a3
                  slli         t0, zero, 18
                  auipc        zero, 631536
                  nop
                  c.or         a2, a3
                  srai         s11, a5, 6
                  mulhu        s5, t3, zero
                  c.srai       s1, 8
                  c.lui        t2, 18
                  add          s2, gp, s8
                  xor          s5, s7, t6
                  divu         sp, t2, s2
                  addi         s11, s11, -143
                  c.add        ra, a0
                  sll          a2, t6, tp
                  c.andi       s0, -1
                  c.slli       a5, 14
                  c.srli       s1, 18
                  c.srai       s1, 8
                  rem          s8, t3, s11
                  c.or         a2, a3
                  remu         s9, a2, t1
                  sra          s1, s7, t6
                  slli         t0, zero, 18
                  or           s8, s8, t2
                  c.li         gp, -1
                  add          s2, gp, s8
                  mul          s11, a6, a7
                  c.srai       s1, 8
                  mulh         t4, s3, s10
                  c.addi4spn   a1, sp, 480
                  mulhu        s5, t3, zero
                  c.slli       a5, 14
                  xori         t0, t6, -1239
                  mul          s11, a6, a7
                  nop
                  sra          s1, s7, t6
                  mulhu        s5, t3, zero
                  slli         t0, zero, 18
                  c.or         a2, a3
                  c.srli       s1, 18
                  mulhsu       a1, gp, a0
                  c.addi       s5, -1
                  mulh         t4, s3, s10
                  c.srai       s1, 8
                  c.add        ra, a0
                  c.li         gp, -1
                  rem          s8, t3, s11
                  c.andi       s0, -1
                  c.sub        s0, s0
                  mulhsu       a1, gp, a0
                  c.addi       s5, -1
                  xori         t0, t6, -1239
                  div          s8, ra, a4
                  sub          t3, a0, t2
                  mulhsu       a1, gp, a0
                  c.addi16sp   sp, 384
                  c.addi16sp   sp, 384
                  c.lui        t2, 18
                  divu         sp, t2, s2
                  ori          s1, a7, 303
                  slti         s6, tp, 996
                  or           s8, s8, t2
                  xor          s5, s7, t6
                  mulhsu       a1, gp, a0
                  c.addi16sp   sp, 384
                  c.addi16sp   sp, 384
                  srl          a6, s8, s9
                  div          s8, ra, a4
                  c.slli       a5, 14
                  c.nop
                  xor          s5, s7, t6
                  c.slli       a5, 14
                  c.srai       s1, 8
                  c.lui        t2, 18
                  slt          s6, s6, gp
                  c.addi       s5, -1
                  mulh         t4, s3, s10
                  rem          s8, t3, s11
                  andi         s6, a4, 204
                  c.srli       s1, 18
                  sltu         t1, a6, a2
                  c.or         a2, a3
                  sltiu        t6, sp, 205
                  divu         sp, t2, s2
                  xor          s5, s7, t6
                  remu         s9, a2, t1
                  andi         s6, a4, 204
                  c.xor        a2, a5
                  slti         s6, tp, 996
                  c.slli       a5, 14
                  slli         t0, zero, 18
                  auipc        zero, 631536
                  auipc        zero, 631536
                  mulhsu       a1, gp, a0
                  ori          s1, a7, 303
                  c.lui        t2, 18
                  sltiu        t6, sp, 205
                  c.sub        s0, s0
                  c.addi4spn   a1, sp, 480
                  xori         t0, t6, -1239
                  c.li         gp, -1
                  c.add        ra, a0
                  addi         s11, s11, -143
                  nop
                  c.srai       s1, 8
                  c.add        ra, a0
                  sll          a2, t6, tp
                  c.li         gp, -1
                  c.addi4spn   a1, sp, 480
                  auipc        zero, 631536
                  lui          t4, 172841
                  srl          a6, s8, s9
                  slt          s6, s6, gp
                  sll          a2, t6, tp
                  c.xor        a2, a5
                  c.xor        a2, a5
                  c.sub        s0, s0
                  c.and        a1, a3
                  mul          s11, a6, a7
                  slti         s6, tp, 996
                  div          s8, ra, a4
                  c.addi       s5, -1
                  c.andi       s0, -1
                  c.sub        s0, s0
                  lui          t4, 172841
                  c.srai       s1, 8
                  slt          s6, s6, gp
                  mulh         t4, s3, s10
                  c.add        ra, a0
                  addi         s11, s11, -143
                  slli         t0, zero, 18
                  mulhu        s5, t3, zero
                  xor          s5, s7, t6
                  nop
                  rem          s8, t3, s11
                  divu         sp, t2, s2
                  c.srai       s1, 8
                  sltu         t1, a6, a2
                  c.xor        a2, a5
                  srl          a6, s8, s9
                  xori         t0, t6, -1239
                  c.srli       s1, 18
                  c.add        ra, a0
                  c.mv         s6, sp
                  c.addi4spn   a1, sp, 480
                  slt          s6, s6, gp
                  c.andi       s0, -1
                  lui          t4, 172841
                  c.and        a1, a3
                  c.andi       s0, -1
                  andi         s6, a4, 204
                  mulhsu       a1, gp, a0
                  mulhu        s5, t3, zero
                  c.and        a1, a3
                  xor          s5, s7, t6
                  sltu         t1, a6, a2
                  xori         t0, t6, -1239
                  c.slli       a5, 14
                  c.nop
                  srli         tp, ra, 29
                  sltu         t1, a6, a2
                  xor          s5, s7, t6
                  sub          t3, a0, t2
                  c.srai       s1, 8
                  sra          s1, s7, t6
                  c.nop
                  c.slli       a5, 14
                  c.slli       a5, 14
                  c.xor        a2, a5
                  c.sub        s0, s0
                  add          s2, gp, s8
                  c.addi       s5, -1
                  and          a1, s3, s0
                  c.addi16sp   sp, 384
                  sltu         t1, a6, a2
                  c.xor        a2, a5
                  ori          s1, a7, 303
                  c.lui        t2, 18
                  c.and        a1, a3
                  mulh         t4, s3, s10
                  c.li         gp, -1
                  ori          s1, a7, 303
                  c.addi4spn   a1, sp, 480
                  c.sub        s0, s0
                  c.nop
                  nop
                  mul          s11, a6, a7
                  c.slli       a5, 14
                  c.srli       s1, 18
                  addi         s11, s11, -143
                  c.li         gp, -1
                  sra          s1, s7, t6
                  and          a1, s3, s0
                  and          a1, s3, s0
                  c.mv         s6, sp
                  slti         s6, tp, 996
                  srli         tp, ra, 29
                  xor          s5, s7, t6
                  addi         s11, s11, -143
                  c.addi4spn   a1, sp, 480
                  and          a1, s3, s0
                  c.addi       s5, -1
                  srai         s11, a5, 6
                  sra          s1, s7, t6
                  c.li         gp, -1
                  c.sub        s0, s0
                  srai         s11, a5, 6
                  c.nop
                  c.slli       a5, 14
                  c.slli       a5, 14
                  slt          s6, s6, gp
                  srl          a6, s8, s9
                  or           s8, s8, t2
                  mulh         t4, s3, s10
                  mulhsu       a1, gp, a0
                  c.addi       s5, -1
                  mulhu        s5, t3, zero
                  srai         s11, a5, 6
                  divu         sp, t2, s2
                  slt          s6, s6, gp
                  ori          s1, a7, 303
                  c.and        a1, a3
                  c.li         gp, -1
                  c.xor        a2, a5
                  add          s2, gp, s8
                  c.andi       s0, -1
                  ori          s1, a7, 303
                  srl          a6, s8, s9
                  add          s2, gp, s8
                  and          a1, s3, s0
                  slli         t0, zero, 18
                  rem          s8, t3, s11
                  c.or         a2, a3
                  srl          a6, s8, s9
                  c.xor        a2, a5
                  c.mv         s6, sp
                  c.and        a1, a3
                  xori         t0, t6, -1239
                  c.add        ra, a0
                  c.or         a2, a3
                  xor          s5, s7, t6
                  c.li         gp, -1
                  sltiu        t6, sp, 205
                  srl          a6, s8, s9
                  srl          a6, s8, s9
                  addi         s11, s11, -143
                  ori          s1, a7, 303
                  c.slli       a5, 14
                  c.mv         s6, sp
                  c.srli       s1, 18
                  or           s8, s8, t2
                  xor          s5, s7, t6
                  c.or         a2, a3
                  c.addi16sp   sp, 384
                  sll          a2, t6, tp
                  c.li         gp, -1
                  rem          s8, t3, s11
                  mulh         t4, s3, s10
                  c.andi       s0, -1
                  mulhsu       a1, gp, a0
                  and          a1, s3, s0
                  rem          s8, t3, s11
                  c.srai       s1, 8
                  nop
                  div          s8, ra, a4
                  c.mv         s6, sp
                  c.and        a1, a3
                  add          s2, gp, s8
                  auipc        zero, 631536
                  c.srai       s1, 8
                  sltu         t1, a6, a2
                  sltiu        t6, sp, 205
                  mulhsu       a1, gp, a0
                  add          s2, gp, s8
                  c.slli       a5, 14
                  mulhsu       a1, gp, a0
                  c.mv         s6, sp
                  c.xor        a2, a5
                  c.srai       s1, 8
                  sltiu        t6, sp, 205
                  c.nop
                  addi         s11, s11, -143
                  slti         s6, tp, 996
                  c.li         gp, -1
                  srli         tp, ra, 29
                  nop
                  c.srli       s1, 18
                  slt          s6, s6, gp
                  c.li         gp, -1
                  c.and        a1, a3
                  mulhu        s5, t3, zero
                  andi         s6, a4, 204
                  sltu         t1, a6, a2
                  auipc        zero, 631536
                  c.mv         s6, sp
                  rem          s8, t3, s11
                  slt          s6, s6, gp
                  auipc        zero, 631536
                  sltiu        t6, sp, 205
                  c.srli       s1, 18
                  mulhu        s5, t3, zero
                  xori         t0, t6, -1239
                  c.li         gp, -1
                  c.srai       s1, 8
                  mulhu        s5, t3, zero
                  srl          a6, s8, s9
                  sltu         t1, a6, a2
                  xori         t0, t6, -1239
                  remu         s9, a2, t1
                  c.srli       s1, 18
                  xor          s5, s7, t6
                  c.and        a1, a3
                  remu         s9, a2, t1
                  ori          s1, a7, 303
                  c.and        a1, a3
                  lui          t4, 172841
                  and          a1, s3, s0
                  c.or         a2, a3
                  c.and        a1, a3
                  lui          t4, 172841
                  slli         t0, zero, 18
                  rem          s8, t3, s11
                  auipc        zero, 631536
                  c.lui        t2, 18
                  srl          a6, s8, s9
                  lui          t4, 172841
                  c.mv         s6, sp
                  srli         tp, ra, 29
                  c.srli       s1, 18
                  c.addi4spn   a1, sp, 480
                  c.nop
                  c.srai       s1, 8
                  c.xor        a2, a5
                  c.sub        s0, s0
                  mulhsu       a1, gp, a0
                  srli         tp, ra, 29
                  auipc        zero, 631536
                  c.srai       s1, 8
                  rem          s8, t3, s11
                  c.and        a1, a3
                  c.slli       a5, 14
                  c.andi       s0, -1
                  andi         s6, a4, 204
                  c.mv         s6, sp
                  c.sub        s0, s0
                  c.addi       s5, -1
                  c.slli       a5, 14
                  c.or         a2, a3
                  sll          a2, t6, tp
                  slt          s6, s6, gp
                  c.addi       s5, -1
                  c.addi4spn   a1, sp, 480
                  xori         t0, t6, -1239
                  rem          s8, t3, s11
                  srai         s11, a5, 6
                  mulhu        s5, t3, zero
                  c.srli       s1, 18
                  slt          s6, s6, gp
                  c.and        a1, a3
                  c.and        a1, a3
                  sltu         t1, a6, a2
                  slli         t0, zero, 18
                  xori         t0, t6, -1239
                  divu         sp, t2, s2
                  sub          t3, a0, t2
                  auipc        zero, 631536
                  or           s8, s8, t2
                  c.srli       s1, 18
                  srli         tp, ra, 29
                  sltiu        t6, sp, 205
                  mul          s11, a6, a7
                  nop
                  and          a1, s3, s0
                  addi         s11, s11, -143
                  sltu         t1, a6, a2
                  mulh         t4, s3, s10
                  xori         t0, t6, -1239
                  sltiu        t6, sp, 205
                  c.or         a2, a3
                  and          a1, s3, s0
                  mulhu        s5, t3, zero
                  c.add        ra, a0
                  c.xor        a2, a5
                  andi         s6, a4, 204
                  div          s8, ra, a4
                  nop
                  c.addi       s5, -1
                  c.lui        t2, 18
                  sub          t3, a0, t2
                  rem          s8, t3, s11
                  c.xor        a2, a5
                  c.and        a1, a3
                  c.mv         s6, sp
                  ori          s1, a7, 303
                  slti         s6, tp, 996
                  add          s2, gp, s8
                  slti         s6, tp, 996
                  remu         s9, a2, t1
                  c.or         a2, a3
                  srai         s11, a5, 6
                  c.add        ra, a0
                  xor          s5, s7, t6
                  and          a1, s3, s0
                  mulh         t4, s3, s10
                  c.sub        s0, s0
                  div          s8, ra, a4
                  sra          s1, s7, t6
                  c.srai       s1, 8
                  and          a1, s3, s0
                  c.xor        a2, a5
                  mul          s11, a6, a7
                  xor          s5, s7, t6
                  or           s8, s8, t2
                  auipc        zero, 631536
                  sltiu        t6, sp, 205
                  c.and        a1, a3
                  divu         sp, t2, s2
                  c.andi       s0, -1
                  auipc        zero, 631536
                  c.or         a2, a3
                  xori         t0, t6, -1239
                  slt          s6, s6, gp
                  auipc        zero, 631536
                  c.addi16sp   sp, 384
                  c.slli       a5, 14
                  c.lui        t2, 18
                  ori          s1, a7, 303
                  c.or         a2, a3
                  c.slli       a5, 14
                  sltu         t1, a6, a2
                  c.lui        t2, 18
                  c.andi       s0, -1
                  c.li         gp, -1
                  c.li         gp, -1
                  c.addi16sp   sp, 384
                  c.sub        s0, s0
                  srli         tp, ra, 29
                  xori         t0, t6, -1239
                  c.sub        s0, s0
                  andi         s6, a4, 204
                  and          a1, s3, s0
                  sra          s1, s7, t6
                  c.mv         s6, sp
                  sra          s1, s7, t6
                  auipc        zero, 631536
                  srl          a6, s8, s9
                  auipc        zero, 631536
                  xori         t0, t6, -1239
                  slt          s6, s6, gp
                  remu         s9, a2, t1
                  srai         s11, a5, 6
                  c.andi       s0, -1
                  div          s8, ra, a4
                  add          s2, gp, s8
                  div          s8, ra, a4
                  andi         s6, a4, 204
                  c.mv         s6, sp
                  slt          s6, s6, gp
                  c.add        ra, a0
                  sra          s1, s7, t6
                  sll          a2, t6, tp
                  srl          a6, s8, s9
                  remu         s9, a2, t1
                  div          s8, ra, a4
                  mulhu        s5, t3, zero
                  andi         s6, a4, 204
                  srl          a6, s8, s9
                  remu         s9, a2, t1
                  mul          s11, a6, a7
                  c.addi       s5, -1
                  c.lui        t2, 18
                  c.andi       s0, -1
                  rem          s8, t3, s11
                  xori         t0, t6, -1239
                  slti         s6, tp, 996
                  slt          s6, s6, gp
                  srli         tp, ra, 29
                  slt          s6, s6, gp
                  c.and        a1, a3
                  c.addi16sp   sp, 384
                  mulhu        s5, t3, zero
                  slli         t0, zero, 18
                  c.andi       s0, -1
                  srl          a6, s8, s9
                  nop
                  auipc        zero, 631536
                  div          s8, ra, a4
                  xor          s5, s7, t6
                  c.andi       s0, -1
                  slt          s6, s6, gp
                  div          s8, ra, a4
                  sltu         t1, a6, a2
                  andi         s6, a4, 204
                  mulhu        s5, t3, zero
                  srl          a6, s8, s9
                  c.or         a2, a3
                  mulhsu       a1, gp, a0
                  divu         sp, t2, s2
                  c.srai       s1, 8
                  slt          s6, s6, gp
                  slli         t0, zero, 18
                  sltu         t1, a6, a2
                  mulhsu       a1, gp, a0
                  mul          s11, a6, a7
                  c.sub        s0, s0
                  c.slli       a5, 14
                  c.srai       s1, 8
                  or           s8, s8, t2
                  c.addi4spn   a1, sp, 480
                  c.and        a1, a3
                  c.lui        t2, 18
                  sltiu        t6, sp, 205
                  mulhsu       a1, gp, a0
                  srai         s11, a5, 6
                  c.add        ra, a0
                  sltiu        t6, sp, 205
                  add          s2, gp, s8
                  or           s8, s8, t2
                  slti         s6, tp, 996
                  div          s8, ra, a4
                  c.or         a2, a3
                  slti         s6, tp, 996
                  slli         t0, zero, 18
                  andi         s6, a4, 204
                  sltu         t1, a6, a2
                  slt          s6, s6, gp
                  mulhu        s5, t3, zero
                  or           s8, s8, t2
                  lui          t4, 172841
                  mulh         t4, s3, s10
                  c.add        ra, a0
                  c.sub        s0, s0
                  mul          s11, a6, a7
                  mul          s11, a6, a7
                  c.addi16sp   sp, 384
                  slti         s6, tp, 996
                  slti         s6, tp, 996
                  auipc        zero, 631536
                  c.mv         s6, sp
                  c.xor        a2, a5
                  mulhu        s5, t3, zero
                  and          a1, s3, s0
                  c.li         gp, -1
                  c.slli       a5, 14
                  c.andi       s0, -1
                  c.and        a1, a3
                  auipc        zero, 631536
                  c.mv         s6, sp
                  c.or         a2, a3
                  mulhsu       a1, gp, a0
                  c.addi16sp   sp, 384
                  rem          s8, t3, s11
                  c.srli       s1, 18
                  or           s8, s8, t2
                  c.addi4spn   a1, sp, 480
                  srli         tp, ra, 29
                  xor          s5, s7, t6
                  xor          s5, s7, t6
                  xori         t0, t6, -1239
                  c.li         gp, -1
                  sra          s1, s7, t6
                  or           s8, s8, t2
                  c.addi       s5, -1
                  srli         tp, ra, 29
                  c.addi4spn   a1, sp, 480
                  sra          s1, s7, t6
                  sra          s1, s7, t6
                  c.lui        t2, 18
                  c.addi       s5, -1
                  xor          s5, s7, t6
                  sll          a2, t6, tp
                  c.lui        t2, 18
                  mulhsu       a1, gp, a0
                  add          s2, gp, s8
                  remu         s9, a2, t1
                  auipc        zero, 631536
                  sltu         t1, a6, a2
                  lui          t4, 172841
                  srai         s11, a5, 6
                  srai         s11, a5, 6
                  c.sub        s0, s0
                  srl          a6, s8, s9
                  srai         s11, a5, 6
                  and          a1, s3, s0
                  c.mv         s6, sp
                  add          s2, gp, s8
                  c.addi       s5, -1
                  srl          a6, s8, s9
                  mulh         t4, s3, s10
                  slli         t0, zero, 18
                  sll          a2, t6, tp
                  sll          a2, t6, tp
                  ori          s1, a7, 303
                  nop
                  c.lui        t2, 18
                  sra          s1, s7, t6
                  ori          s1, a7, 303
                  srli         tp, ra, 29
                  c.nop
                  remu         s9, a2, t1
                  c.srli       s1, 18
                  slli         t0, zero, 18
                  sll          a2, t6, tp
                  c.add        ra, a0
                  rem          s8, t3, s11
                  c.nop
                  c.addi16sp   sp, 384
                  srl          a6, s8, s9
                  remu         s9, a2, t1
                  remu         s9, a2, t1
                  slti         s6, tp, 996
                  ori          s1, a7, 303
                  and          a1, s3, s0
                  srli         tp, ra, 29
                  and          a1, s3, s0
                  and          a1, s3, s0
                  mul          s11, a6, a7
                  c.slli       a5, 14
                  ori          s1, a7, 303
                  nop
                  ori          s1, a7, 303
                  ori          s1, a7, 303
                  c.xor        a2, a5
                  c.srli       s1, 18
                  srl          a6, s8, s9
                  and          a1, s3, s0
                  c.addi       s5, -1
                  xori         t0, t6, -1239
                  mulh         t4, s3, s10
                  add          s2, gp, s8
                  c.add        ra, a0
                  c.lui        t2, 18
                  sub          t3, a0, t2
                  srl          a6, s8, s9
                  c.lui        t2, 18
                  slli         t0, zero, 18
                  auipc        zero, 631536
                  c.and        a1, a3
                  c.xor        a2, a5
                  mul          s11, a6, a7
                  mul          s11, a6, a7
                  c.addi       s5, -1
                  c.xor        a2, a5
                  sub          t3, a0, t2
                  remu         s9, a2, t1
                  c.nop
                  c.andi       s0, -1
                  sra          s1, s7, t6
                  mulhsu       a1, gp, a0
                  c.srli       s1, 18
                  xori         t0, t6, -1239
                  c.addi       s5, -1
                  xor          s5, s7, t6
                  c.nop
                  c.addi4spn   a1, sp, 480
                  nop
                  c.srai       s1, 8
                  xor          s5, s7, t6
                  mulhu        s5, t3, zero
                  c.sub        s0, s0
                  ori          s1, a7, 303
                  c.addi4spn   a1, sp, 480
                  c.xor        a2, a5
                  divu         sp, t2, s2
                  c.addi4spn   a1, sp, 480
                  c.addi16sp   sp, 384
                  slli         t0, zero, 18
                  srai         s11, a5, 6
                  c.srli       s1, 18
                  c.addi       s5, -1
                  andi         s6, a4, 204
                  or           s8, s8, t2
                  or           s8, s8, t2
                  srai         s11, a5, 6
                  c.mv         s6, sp
                  rem          s8, t3, s11
                  mulh         t4, s3, s10
                  div          s8, ra, a4
                  c.slli       a5, 14
                  c.and        a1, a3
                  c.or         a2, a3
                  c.sub        s0, s0
                  c.or         a2, a3
                  c.andi       s0, -1
                  mulh         t4, s3, s10
                  rem          s8, t3, s11
                  c.srli       s1, 18
                  mulhsu       a1, gp, a0
                  xori         t0, t6, -1239
                  mulh         t4, s3, s10
                  slti         s6, tp, 996
                  slti         s6, tp, 996
                  c.add        ra, a0
                  c.or         a2, a3
                  sltu         t1, a6, a2
                  mulh         t4, s3, s10
                  add          s2, gp, s8
                  sra          s1, s7, t6
                  c.srli       s1, 18
                  xori         t0, t6, -1239
                  sltiu        t6, sp, 205
                  mul          s11, a6, a7
                  c.and        a1, a3
                  slli         t0, zero, 18
                  slli         t0, zero, 18
                  remu         s9, a2, t1
                  ori          s1, a7, 303
                  slli         t0, zero, 18
                  divu         sp, t2, s2
                  c.srli       s1, 18
                  add          s2, gp, s8
                  srai         s11, a5, 6
                  mulh         t4, s3, s10
                  c.addi       s5, -1
                  sltiu        t6, sp, 205
                  c.srai       s1, 8
                  srli         tp, ra, 29
                  c.addi       s5, -1
                  sub          t3, a0, t2
                  sltiu        t6, sp, 205
                  slt          s6, s6, gp
                  mul          s11, a6, a7
                  mulhsu       a1, gp, a0
                  div          s8, ra, a4
                  c.lui        t2, 18
                  slti         s6, tp, 996
                  c.sub        s0, s0
                  sll          a2, t6, tp
                  c.sub        s0, s0
                  mul          s11, a6, a7
                  srli         tp, ra, 29
                  c.addi4spn   a1, sp, 480
                  c.mv         s6, sp
                  sltu         t1, a6, a2
                  srl          a6, s8, s9
                  rem          s8, t3, s11
                  auipc        zero, 631536
                  div          s8, ra, a4
                  srli         tp, ra, 29
                  nop
                  auipc        zero, 631536
                  c.slli       a5, 14
                  c.addi4spn   a1, sp, 480
                  sub          t3, a0, t2
                  lui          t4, 172841
                  mulhsu       a1, gp, a0
                  slti         s6, tp, 996
                  c.addi       s5, -1
                  c.sub        s0, s0
                  sltu         t1, a6, a2
                  add          s2, gp, s8
                  sra          s1, s7, t6
                  lui          t4, 172841
                  c.add        ra, a0
                  c.li         gp, -1
                  c.srai       s1, 8
                  slli         t0, zero, 18
                  c.or         a2, a3
                  sra          s1, s7, t6
                  c.lui        t2, 18
                  c.li         gp, -1
                  remu         s9, a2, t1
                  auipc        zero, 631536
                  c.and        a1, a3
                  rem          s8, t3, s11
                  slti         s6, tp, 996
                  c.slli       a5, 14
                  auipc        zero, 631536
                  c.mv         s6, sp
                  srai         s11, a5, 6
                  auipc        zero, 631536
                  c.li         gp, -1
                  c.and        a1, a3
                  sub          t3, a0, t2
                  c.slli       a5, 14
                  auipc        zero, 631536
                  mulhu        s5, t3, zero
                  c.addi       s5, -1
                  c.mv         s6, sp
                  srl          a6, s8, s9
                  c.andi       s0, -1
                  c.nop
                  srai         s11, a5, 6
                  remu         s9, a2, t1
                  rem          s8, t3, s11
                  addi         s11, s11, -143
                  sra          s1, s7, t6
                  srai         s11, a5, 6
                  c.slli       a5, 14
                  remu         s9, a2, t1
                  xori         t0, t6, -1239
                  c.mv         s6, sp
                  andi         s6, a4, 204
                  ori          s1, a7, 303
                  c.nop
                  c.li         gp, -1
                  xori         t0, t6, -1239
                  sra          s1, s7, t6
                  srli         tp, ra, 29
                  slt          s6, s6, gp
                  slti         s6, tp, 996
                  srl          a6, s8, s9
                  mul          s11, a6, a7
                  div          s8, ra, a4
                  c.srli       s1, 18
                  xori         t0, t6, -1239
                  nop
                  addi         s11, s11, -143
                  c.add        ra, a0
                  addi         s11, s11, -143
                  sll          a2, t6, tp
                  mulh         t4, s3, s10
                  slti         s6, tp, 996
                  rem          s8, t3, s11
                  c.slli       a5, 14
                  mulhsu       a1, gp, a0
                  c.addi16sp   sp, 384
                  ori          s1, a7, 303
                  c.andi       s0, -1
                  rem          s8, t3, s11
                  c.add        ra, a0
                  mulh         t4, s3, s10
                  srai         s11, a5, 6
                  c.nop
                  c.srai       s1, 8
                  mul          s11, a6, a7
                  add          s2, gp, s8
                  xori         t0, t6, -1239
                  add          s2, gp, s8
                  c.addi       s5, -1
                  c.srai       s1, 8
                  c.srli       s1, 18
                  sltiu        t6, sp, 205
                  xori         t0, t6, -1239
                  ori          s1, a7, 303
                  slli         t0, zero, 18
                  addi         s11, s11, -143
                  remu         s9, a2, t1
                  sra          s1, s7, t6
                  andi         s6, a4, 204
                  nop
                  or           s8, s8, t2
                  mulhsu       a1, gp, a0
                  c.srli       s1, 18
                  sub          t3, a0, t2
                  sltu         t1, a6, a2
                  sll          a2, t6, tp
                  mul          s11, a6, a7
                  c.andi       s0, -1
                  nop
                  auipc        zero, 631536
                  c.or         a2, a3
                  c.li         gp, -1
                  mulhu        s5, t3, zero
                  lui          t4, 172841
                  remu         s9, a2, t1
                  c.addi       s5, -1
                  sra          s1, s7, t6
                  srl          a6, s8, s9
                  sltu         t1, a6, a2
                  c.addi16sp   sp, 384
                  add          s2, gp, s8
                  c.lui        t2, 18
                  c.nop
                  c.and        a1, a3
                  remu         s9, a2, t1
                  c.andi       s0, -1
                  div          s8, ra, a4
                  c.xor        a2, a5
                  add          s2, gp, s8
                  ori          s1, a7, 303
                  nop
                  sra          s1, s7, t6
                  c.sub        s0, s0
                  addi         s11, s11, -143
                  andi         s6, a4, 204
                  lui          t4, 172841
                  rem          s8, t3, s11
                  c.addi       s5, -1
                  sltu         t1, a6, a2
                  c.nop
                  c.addi4spn   a1, sp, 480
                  c.sub        s0, s0
                  c.li         gp, -1
                  mulh         t4, s3, s10
                  slt          s6, s6, gp
                  srl          a6, s8, s9
                  mulhsu       a1, gp, a0
                  c.li         gp, -1
                  xor          s5, s7, t6
                  xori         t0, t6, -1239
                  mulh         t4, s3, s10
                  remu         s9, a2, t1
                  c.addi4spn   a1, sp, 480
                  srl          a6, s8, s9
                  sll          a2, t6, tp
                  c.xor        a2, a5
                  c.addi4spn   a1, sp, 480
                  c.li         gp, -1
                  c.li         gp, -1
                  c.addi16sp   sp, 384
                  mulhu        s5, t3, zero
                  mulhu        s5, t3, zero
                  c.andi       s0, -1
                  c.nop
                  sll          a2, t6, tp
                  c.sub        s0, s0
                  and          a1, s3, s0
                  lui          t4, 172841
                  nop
                  addi         s11, s11, -143
                  slti         s6, tp, 996
                  c.slli       a5, 14
                  addi         s11, s11, -143
                  c.xor        a2, a5
                  c.lui        t2, 18
                  c.addi4spn   a1, sp, 480
                  sltiu        t6, sp, 205
                  sra          s1, s7, t6
                  sltiu        t6, sp, 205
                  rem          s8, t3, s11
                  sra          s1, s7, t6
                  c.xor        a2, a5
                  c.nop
                  c.add        ra, a0
                  xor          s5, s7, t6
                  or           s8, s8, t2
                  c.nop
                  c.li         gp, -1
                  sra          s1, s7, t6
                  c.slli       a5, 14
                  mul          s11, a6, a7
                  c.srli       s1, 18
                  rem          s8, t3, s11
                  c.xor        a2, a5
                  mul          s11, a6, a7
                  slt          s6, s6, gp
                  srl          a6, s8, s9
                  sra          s1, s7, t6
                  li           sp, 0xffffffff #start riscv_int_numeric_corner_stream_24
                  li           a7, 0x80000000
                  li           tp, 0xffffffff
                  li           t6, 0xad75cd85
                  li           a3, 0xc6ef3e54
                  li           s8, 0x0
                  li           s9, 0x0
                  li           t0, 0x8b12b738
                  li           s7, 0x9840e683
                  li           s1, 0x80000000
                  remu         s7, t0, s7
                  mul          s9, sp, tp
                  remu         s7, t0, s7
                  rem          a7, s9, sp
                  sub          t6, t6, s8
                  auipc        sp, 631536
                  nop
                  mulhsu       s8, s1, a3
                  sub          t6, t6, s8
                  mulhsu       s8, s1, a3
                  addi         s9, a7, -143
                  add          sp, s1, s9
                  addi         s9, a7, -143
                  mul          s9, sp, tp
                  mulhu        t0, s9, sp
                  mulhsu       s8, s1, a3
                  divu         t0, s8, t0
                  lui          t6, 172841
                  divu         t0, s8, t0
                  sub          t6, t6, s8
                  add          sp, s1, s9
                  div          a7, tp, t6
                  div          a7, tp, t6
                  addi         s9, a7, -143
                  addi         s9, a7, -143
                  remu         s7, t0, s7
                  mulhsu       s8, s1, a3
                  lui          t6, 172841
                  mulhsu       s8, s1, a3 #end riscv_int_numeric_corner_stream_24
                  sll          a2, t6, tp
                  mul          s11, a6, a7
                  slt          s6, s6, gp
                  slti         s6, tp, 996
                  sltiu        t6, sp, 205
                  c.mv         s6, sp
                  div          s8, ra, a4
                  li           t6, 0x80000000 #start riscv_int_numeric_corner_stream_31
                  li           s10, 0xffffffff
                  li           s11, 0xffffffff
                  li           t5, 0x0
                  li           gp, 0x80000000
                  li           s8, 0x16b12dd2
                  li           t1, 0x80000000
                  li           s7, 0xffffffff
                  li           sp, 0x1701793e
                  li           a1, 0xf2e80e56
                  lui          t6, 172841
                  div          s8, gp, t6
                  mulhsu       s11, a1, s7
                  nop
                  divu         t1, s11, t1
                  addi         t5, s8, -143
                  add          sp, a1, t5
                  add          sp, a1, t5
                  nop
                  rem          s8, t5, sp
                  lui          t6, 172841
                  mulhu        t1, t5, sp
                  addi         t5, s8, -143
                  auipc        sp, 631536
                  mulhsu       s11, a1, s7
                  auipc        sp, 631536
                  mulh         sp, a1, s8 #end riscv_int_numeric_corner_stream_31
                  sra          s1, s7, t6
                  divu         sp, t2, s2
                  c.andi       s0, -1
                  sll          a2, t6, tp
                  c.srli       s1, 18
                  mulh         t4, s3, s10
                  c.lui        t2, 18
                  div          s8, ra, a4
                  srl          a6, s8, s9
                  srai         s11, a5, 6
                  mulhsu       a1, gp, a0
                  slli         t0, zero, 18
                  c.addi4spn   a1, sp, 480
                  c.mv         s6, sp
                  div          s8, ra, a4
                  li           tp, 0x80000000 #start riscv_int_numeric_corner_stream_20
                  li           a1, 0xffffffff
                  li           s10, 0x0
                  li           sp, 0x0
                  li           t6, 0x2001c713
                  li           t3, 0x80000000
                  li           t0, 0xffffffff
                  li           s8, 0xfad6e5fa
                  li           a7, 0x0
                  li           s1, 0xffffffff
                  rem          a7, t3, sp
                  mulh         sp, s1, a7
                  remu         s8, t0, s8
                  mulhsu       s10, s1, a1
                  mulhsu       s10, s1, a1
                  remu         s8, t0, s8
                  mulhsu       s10, s1, a1
                  add          sp, s1, t3
                  sub          t6, t6, s10
                  auipc        sp, 631536
                  lui          t6, 172841
                  divu         t0, s10, t0
                  auipc        sp, 631536
                  divu         t0, s10, t0
                  mulh         sp, s1, a7
                  auipc        sp, 631536
                  mulhsu       s10, s1, a1
                  remu         s8, t0, s8
                  lui          t6, 172841
                  addi         t3, a7, -143
                  remu         s8, t0, s8
                  lui          t6, 172841
                  div          a7, tp, t6
                  mulhsu       s10, s1, a1
                  mulhu        t0, t3, sp
                  nop
                  nop
                  nop
                  mulhsu       s10, s1, a1 #end riscv_int_numeric_corner_stream_20
                  and          a1, s3, s0
                  auipc        zero, 631536
                  c.andi       s0, -1
                  c.srai       s1, 8
                  c.sub        s0, s0
                  c.srai       s1, 8
                  srl          a6, s8, s9
                  slti         s6, tp, 996
                  or           s8, s8, t2
                  mulhsu       a1, gp, a0
                  and          a1, s3, s0
                  div          s8, ra, a4
                  nop
                  andi         s6, a4, 204
                  c.nop
                  srai         s11, a5, 6
                  c.or         a2, a3
                  divu         sp, t2, s2
                  xori         t0, t6, -1239
                  mulhsu       a1, gp, a0
                  c.li         gp, -1
                  c.add        ra, a0
                  c.slli       a5, 14
                  c.add        ra, a0
                  sltiu        t6, sp, 205
                  c.andi       s0, -1
                  mulh         t4, s3, s10
                  c.nop
                  sra          s1, s7, t6
                  c.lui        t2, 18
                  lui          t4, 172841
                  c.andi       s0, -1
                  c.and        a1, a3
                  mulhu        s5, t3, zero
                  addi         s11, s11, -143
                  srli         tp, ra, 29
                  xori         t0, t6, -1239
                  divu         sp, t2, s2
                  divu         sp, t2, s2
                  or           s8, s8, t2
                  srli         tp, ra, 29
                  nop
                  c.and        a1, a3
                  div          s8, ra, a4
                  sltiu        t6, sp, 205
                  ori          s1, a7, 303
                  c.andi       s0, -1
                  andi         s6, a4, 204
                  sub          t3, a0, t2
                  sra          s1, s7, t6
                  srl          a6, s8, s9
                  srl          a6, s8, s9
                  slt          s6, s6, gp
                  and          a1, s3, s0
                  c.addi16sp   sp, 384
                  c.add        ra, a0
                  c.srai       s1, 8
                  c.andi       s0, -1
                  c.nop
                  c.nop
                  mulh         t4, s3, s10
                  c.addi       s5, -1
                  c.lui        t2, 18
                  c.addi4spn   a1, sp, 480
                  slt          s6, s6, gp
                  mulhu        s5, t3, zero
                  ori          s1, a7, 303
                  srai         s11, a5, 6
                  or           s8, s8, t2
                  c.sub        s0, s0
                  xor          s5, s7, t6
                  div          s8, ra, a4
                  c.and        a1, a3
                  andi         s6, a4, 204
                  mulh         t4, s3, s10
                  srai         s11, a5, 6
                  c.lui        t2, 18
                  c.addi       s5, -1
                  srai         s11, a5, 6
                  sltu         t1, a6, a2
                  sltiu        t6, sp, 205
                  sll          a2, t6, tp
                  c.mv         s6, sp
                  slt          s6, s6, gp
                  xor          s5, s7, t6
                  c.addi4spn   a1, sp, 480
                  c.lui        t2, 18
                  c.and        a1, a3
                  addi         s11, s11, -143
                  slt          s6, s6, gp
                  c.addi       s5, -1
                  lui          t4, 172841
                  srli         tp, ra, 29
                  c.and        a1, a3
                  c.add        ra, a0
                  slt          s6, s6, gp
                  srai         s11, a5, 6
                  c.slli       a5, 14
                  c.addi4spn   a1, sp, 480
                  c.xor        a2, a5
                  sltu         t1, a6, a2
                  sub          t3, a0, t2
                  sra          s1, s7, t6
                  sltiu        t6, sp, 205
                  c.xor        a2, a5
                  c.sub        s0, s0
                  sll          a2, t6, tp
                  c.xor        a2, a5
                  xor          s5, s7, t6
                  slt          s6, s6, gp
                  c.addi16sp   sp, 384
                  c.andi       s0, -1
                  c.or         a2, a3
                  c.xor        a2, a5
                  ori          s1, a7, 303
                  add          s2, gp, s8
                  xori         t0, t6, -1239
                  lui          t4, 172841
                  srl          a6, s8, s9
                  and          a1, s3, s0
                  c.li         gp, -1
                  sltiu        t6, sp, 205
                  and          a1, s3, s0
                  sra          s1, s7, t6
                  c.nop
                  c.nop
                  c.li         gp, -1
                  nop
                  c.srai       s1, 8
                  c.srai       s1, 8
                  srai         s11, a5, 6
                  c.addi4spn   a1, sp, 480
                  rem          s8, t3, s11
                  auipc        zero, 631536
                  divu         sp, t2, s2
                  sll          a2, t6, tp
                  addi         s11, s11, -143
                  sra          s1, s7, t6
                  c.and        a1, a3
                  andi         s6, a4, 204
                  auipc        zero, 631536
                  lui          t4, 172841
                  c.or         a2, a3
                  xor          s5, s7, t6
                  c.add        ra, a0
                  mul          s11, a6, a7
                  mul          s11, a6, a7
                  sltu         t1, a6, a2
                  c.sub        s0, s0
                  div          s8, ra, a4
                  lui          t4, 172841
                  c.xor        a2, a5
                  c.addi4spn   a1, sp, 480
                  c.lui        t2, 18
                  c.addi16sp   sp, 384
                  div          s8, ra, a4
                  remu         s9, a2, t1
                  srl          a6, s8, s9
                  ori          s1, a7, 303
                  ori          s1, a7, 303
                  sra          s1, s7, t6
                  andi         s6, a4, 204
                  c.lui        t2, 18
                  c.addi4spn   a1, sp, 480
                  c.li         gp, -1
                  mul          s11, a6, a7
                  c.mv         s6, sp
                  c.mv         s6, sp
                  mulhu        s5, t3, zero
                  c.add        ra, a0
                  slli         t0, zero, 18
                  c.slli       a5, 14
                  xori         t0, t6, -1239
                  sub          t3, a0, t2
                  mulh         t4, s3, s10
                  c.slli       a5, 14
                  c.or         a2, a3
                  c.sub        s0, s0
                  slt          s6, s6, gp
                  auipc        zero, 631536
                  divu         sp, t2, s2
                  c.li         gp, -1
                  andi         s6, a4, 204
                  c.li         gp, -1
                  c.add        ra, a0
                  sltu         t1, a6, a2
                  mulh         t4, s3, s10
                  auipc        zero, 631536
                  ori          s1, a7, 303
                  c.addi16sp   sp, 384
                  auipc        zero, 631536
                  c.or         a2, a3
                  c.andi       s0, -1
                  slli         t0, zero, 18
                  sub          t3, a0, t2
                  c.addi16sp   sp, 384
                  c.mv         s6, sp
                  c.li         gp, -1
                  c.li         gp, -1
                  sub          t3, a0, t2
                  slt          s6, s6, gp
                  srl          a6, s8, s9
                  mulh         t4, s3, s10
                  c.li         gp, -1
                  xori         t0, t6, -1239
                  slti         s6, tp, 996
                  c.or         a2, a3
                  srli         tp, ra, 29
                  add          s2, gp, s8
                  c.add        ra, a0
                  srli         tp, ra, 29
                  or           s8, s8, t2
                  or           s8, s8, t2
                  ori          s1, a7, 303
                  srai         s11, a5, 6
                  c.and        a1, a3
                  sltiu        t6, sp, 205
                  sltu         t1, a6, a2
                  srli         tp, ra, 29
                  mul          s11, a6, a7
                  auipc        zero, 631536
                  c.slli       a5, 14
                  sltiu        t6, sp, 205
                  c.slli       a5, 14
                  addi         s11, s11, -143
                  xori         t0, t6, -1239
                  srai         s11, a5, 6
                  sra          s1, s7, t6
                  mulh         t4, s3, s10
                  nop
                  srl          a6, s8, s9
                  c.addi4spn   a1, sp, 480
                  c.add        ra, a0
                  mul          s11, a6, a7
                  addi         s11, s11, -143
                  c.and        a1, a3
                  li           s5, 0x80000000 #start riscv_int_numeric_corner_stream_13
                  li           t5, 0xffffffff
                  li           s8, 0xffffffff
                  li           a1, 0x80000000
                  li           s6, 0x0
                  li           s0, 0xffffffff
                  li           t1, 0xffffffff
                  li           a5, 0xffffffff
                  li           a6, 0xffffffff
                  li           t4, 0xffffffff
                  mulh         t1, a5, s5
                  addi         t4, s5, -143
                  nop
                  mul          t4, t1, s0
                  nop
                  div          s5, s0, t5
                  addi         t4, s5, -143
                  mulhsu       s8, a5, a6
                  addi         t4, s5, -143
                  mul          t4, t1, s0
                  sub          t5, t5, s8
                  remu         s6, a1, s6
                  mulhsu       s8, a5, a6
                  remu         s6, a1, s6
                  sub          t5, t5, s8
                  divu         a1, s8, a1
                  mul          t4, t1, s0
                  nop
                  mulh         t1, a5, s5
                  sub          t5, t5, s8
                  nop
                  div          s5, s0, t5
                  div          s5, s0, t5
                  mulhsu       s8, a5, a6
                  div          s5, s0, t5
                  mulhsu       s8, a5, a6 #end riscv_int_numeric_corner_stream_13
                  sub          t3, a0, t2
                  sra          s1, s7, t6
                  srai         s11, a5, 6
                  c.lui        t2, 18
                  c.nop
                  sub          t3, a0, t2
                  c.li         gp, -1
                  remu         s9, a2, t1
                  mulhsu       a1, gp, a0
                  and          a1, s3, s0
                  slli         t0, zero, 18
                  mulhu        s5, t3, zero
                  sub          t3, a0, t2
                  sra          s1, s7, t6
                  c.add        ra, a0
                  srai         s11, a5, 6
                  ori          s1, a7, 303
                  sra          s1, s7, t6
                  sltiu        t6, sp, 205
                  sltu         t1, a6, a2
                  sra          s1, s7, t6
                  c.srli       s1, 18
                  c.or         a2, a3
                  divu         sp, t2, s2
                  c.nop
                  addi         s11, s11, -143
                  ori          s1, a7, 303
                  mulh         t4, s3, s10
                  c.addi4spn   a1, sp, 480
                  andi         s6, a4, 204
                  c.or         a2, a3
                  c.nop
                  c.nop
                  lui          t4, 172841
                  divu         sp, t2, s2
                  remu         s9, a2, t1
                  slli         t0, zero, 18
                  mulhsu       a1, gp, a0
                  c.li         gp, -1
                  c.slli       a5, 14
                  c.li         gp, -1
                  c.lui        t2, 18
                  sltu         t1, a6, a2
                  mulhu        s5, t3, zero
                  srai         s11, a5, 6
                  rem          s8, t3, s11
                  add          s2, gp, s8
                  c.sub        s0, s0
                  c.lui        t2, 18
                  add          s2, gp, s8
                  c.slli       a5, 14
                  c.li         gp, -1
                  rem          s8, t3, s11
                  srl          a6, s8, s9
                  xor          s5, s7, t6
                  slt          s6, s6, gp
                  c.or         a2, a3
                  sltu         t1, a6, a2
                  xor          s5, s7, t6
                  c.nop
                  addi         s11, s11, -143
                  sltu         t1, a6, a2
                  or           s8, s8, t2
                  c.srli       s1, 18
                  xor          s5, s7, t6
                  and          a1, s3, s0
                  c.slli       a5, 14
                  c.addi       s5, -1
                  xori         t0, t6, -1239
                  c.andi       s0, -1
                  c.nop
                  mulh         t4, s3, s10
                  nop
                  c.lui        t2, 18
                  nop
                  c.addi       s5, -1
                  or           s8, s8, t2
                  c.srai       s1, 8
                  c.and        a1, a3
                  c.srli       s1, 18
                  slt          s6, s6, gp
                  rem          s8, t3, s11
                  auipc        zero, 631536
                  sra          s1, s7, t6
                  auipc        zero, 631536
                  divu         sp, t2, s2
                  add          s2, gp, s8
                  div          s8, ra, a4
                  mul          s11, a6, a7
                  sltu         t1, a6, a2
                  c.addi16sp   sp, 384
                  c.addi16sp   sp, 384
                  sll          a2, t6, tp
                  srli         tp, ra, 29
                  mulhsu       a1, gp, a0
                  rem          s8, t3, s11
                  lui          t4, 172841
                  mul          s11, a6, a7
                  c.or         a2, a3
                  add          s2, gp, s8
                  xor          s5, s7, t6
                  andi         s6, a4, 204
                  mul          s11, a6, a7
                  div          s8, ra, a4
                  xori         t0, t6, -1239
                  sra          s1, s7, t6
                  xori         t0, t6, -1239
                  c.addi       s5, -1
                  srli         tp, ra, 29
                  c.addi       s5, -1
                  slti         s6, tp, 996
                  ori          s1, a7, 303
                  c.srli       s1, 18
                  c.or         a2, a3
                  c.and        a1, a3
                  c.slli       a5, 14
                  c.xor        a2, a5
                  addi         s11, s11, -143
                  xori         t0, t6, -1239
                  c.addi16sp   sp, 384
                  mulhu        s5, t3, zero
                  c.and        a1, a3
                  slti         s6, tp, 996
                  sltu         t1, a6, a2
                  sltu         t1, a6, a2
                  andi         s6, a4, 204
                  and          a1, s3, s0
                  c.srli       s1, 18
                  c.lui        t2, 18
                  sltiu        t6, sp, 205
                  slli         t0, zero, 18
                  c.lui        t2, 18
                  rem          s8, t3, s11
                  slt          s6, s6, gp
                  srl          a6, s8, s9
                  c.addi16sp   sp, 384
                  c.andi       s0, -1
                  c.add        ra, a0
                  xori         t0, t6, -1239
                  srli         tp, ra, 29
                  sltu         t1, a6, a2
                  mul          s11, a6, a7
                  c.srai       s1, 8
                  c.srai       s1, 8
                  c.li         gp, -1
                  xor          s5, s7, t6
                  xori         t0, t6, -1239
                  c.lui        t2, 18
                  auipc        zero, 631536
                  c.lui        t2, 18
                  c.add        ra, a0
                  c.slli       a5, 14
                  remu         s9, a2, t1
                  c.lui        t2, 18
                  rem          s8, t3, s11
                  mul          s11, a6, a7
                  slt          s6, s6, gp
                  sltu         t1, a6, a2
                  c.addi       s5, -1
                  mulh         t4, s3, s10
                  rem          s8, t3, s11
                  divu         sp, t2, s2
                  slti         s6, tp, 996
                  slt          s6, s6, gp
                  xori         t0, t6, -1239
                  xor          s5, s7, t6
                  divu         sp, t2, s2
                  ori          s1, a7, 303
                  slli         t0, zero, 18
                  rem          s8, t3, s11
                  andi         s6, a4, 204
                  srai         s11, a5, 6
                  mulh         t4, s3, s10
                  add          s2, gp, s8
                  sub          t3, a0, t2
                  c.mv         s6, sp
                  slli         t0, zero, 18
                  sra          s1, s7, t6
                  sub          t3, a0, t2
                  ori          s1, a7, 303
                  srai         s11, a5, 6
                  nop
                  andi         s6, a4, 204
                  srli         tp, ra, 29
                  c.addi4spn   a1, sp, 480
                  c.sub        s0, s0
                  srai         s11, a5, 6
                  c.li         gp, -1
                  auipc        zero, 631536
                  c.slli       a5, 14
                  slti         s6, tp, 996
                  sub          t3, a0, t2
                  sra          s1, s7, t6
                  c.slli       a5, 14
                  c.addi16sp   sp, 384
                  c.addi16sp   sp, 384
                  c.andi       s0, -1
                  sra          s1, s7, t6
                  sltiu        t6, sp, 205
                  c.addi       s5, -1
                  remu         s9, a2, t1
                  xori         t0, t6, -1239
                  nop
                  c.or         a2, a3
                  ori          s1, a7, 303
                  c.or         a2, a3
                  remu         s9, a2, t1
                  srl          a6, s8, s9
                  mulh         t4, s3, s10
                  slti         s6, tp, 996
                  nop
                  nop
                  remu         s9, a2, t1
                  rem          s8, t3, s11
                  mulh         t4, s3, s10
                  srai         s11, a5, 6
                  slt          s6, s6, gp
                  srl          a6, s8, s9
                  and          a1, s3, s0
                  c.srai       s1, 8
                  c.and        a1, a3
                  srli         tp, ra, 29
                  c.or         a2, a3
                  sra          s1, s7, t6
                  c.or         a2, a3
                  slt          s6, s6, gp
                  div          s8, ra, a4
                  lui          t4, 172841
                  auipc        zero, 631536
                  c.and        a1, a3
                  c.addi       s5, -1
                  c.or         a2, a3
                  sub          t3, a0, t2
                  xori         t0, t6, -1239
                  c.srai       s1, 8
                  c.mv         s6, sp
                  c.sub        s0, s0
                  c.add        ra, a0
                  sltiu        t6, sp, 205
                  c.srai       s1, 8
                  xori         t0, t6, -1239
                  and          a1, s3, s0
                  srl          a6, s8, s9
                  mul          s11, a6, a7
                  div          s8, ra, a4
                  sra          s1, s7, t6
                  div          s8, ra, a4
                  divu         sp, t2, s2
                  lui          t4, 172841
                  c.xor        a2, a5
                  add          s2, gp, s8
                  c.addi       s5, -1
                  c.add        ra, a0
                  c.addi4spn   a1, sp, 480
                  srl          a6, s8, s9
                  slt          s6, s6, gp
                  remu         s9, a2, t1
                  and          a1, s3, s0
                  mulhsu       a1, gp, a0
                  rem          s8, t3, s11
                  sub          t3, a0, t2
                  sra          s1, s7, t6
                  andi         s6, a4, 204
                  slti         s6, tp, 996
                  div          s8, ra, a4
                  andi         s6, a4, 204
                  add          s2, gp, s8
                  slli         t0, zero, 18
                  c.add        ra, a0
                  c.or         a2, a3
                  rem          s8, t3, s11
                  c.andi       s0, -1
                  rem          s8, t3, s11
                  c.srai       s1, 8
                  c.andi       s0, -1
                  c.addi4spn   a1, sp, 480
                  mulh         t4, s3, s10
                  lui          t4, 172841
                  c.srai       s1, 8
                  mulh         t4, s3, s10
                  c.nop
                  xor          s5, s7, t6
                  andi         s6, a4, 204
                  c.nop
                  auipc        zero, 631536
                  xor          s5, s7, t6
                  c.mv         s6, sp
                  sltiu        t6, sp, 205
                  andi         s6, a4, 204
                  c.li         gp, -1
                  c.andi       s0, -1
                  lui          t4, 172841
                  sll          a2, t6, tp
                  c.add        ra, a0
                  c.li         gp, -1
                  nop
                  addi         s11, s11, -143
                  ori          s1, a7, 303
                  or           s8, s8, t2
                  c.addi4spn   a1, sp, 480
                  mulhsu       a1, gp, a0
                  sub          t3, a0, t2
                  or           s8, s8, t2
                  c.srai       s1, 8
                  srli         tp, ra, 29
                  c.sub        s0, s0
                  sub          t3, a0, t2
                  c.slli       a5, 14
                  remu         s9, a2, t1
                  c.mv         s6, sp
                  div          s8, ra, a4
                  sltiu        t6, sp, 205
                  sltu         t1, a6, a2
                  auipc        zero, 631536
                  c.slli       a5, 14
                  c.lui        t2, 18
                  sra          s1, s7, t6
                  c.xor        a2, a5
                  remu         s9, a2, t1
                  srai         s11, a5, 6
                  mul          s11, a6, a7
                  add          s2, gp, s8
                  slti         s6, tp, 996
                  srli         tp, ra, 29
                  c.srli       s1, 18
                  ori          s1, a7, 303
                  c.mv         s6, sp
                  srl          a6, s8, s9
                  slt          s6, s6, gp
                  c.andi       s0, -1
                  c.srai       s1, 8
                  remu         s9, a2, t1
                  xori         t0, t6, -1239
                  sra          s1, s7, t6
                  mulhsu       a1, gp, a0
                  c.srli       s1, 18
                  c.andi       s0, -1
                  c.and        a1, a3
                  slli         t0, zero, 18
                  auipc        zero, 631536
                  c.addi16sp   sp, 384
                  addi         s11, s11, -143
                  srai         s11, a5, 6
                  xori         t0, t6, -1239
                  slli         t0, zero, 18
                  div          s8, ra, a4
                  add          s2, gp, s8
                  add          s2, gp, s8
                  c.xor        a2, a5
                  sra          s1, s7, t6
                  c.nop
                  mul          s11, a6, a7
                  sub          t3, a0, t2
                  c.lui        t2, 18
                  c.li         gp, -1
                  slti         s6, tp, 996
                  c.add        ra, a0
                  sll          a2, t6, tp
                  srl          a6, s8, s9
                  auipc        zero, 631536
                  c.addi4spn   a1, sp, 480
                  mulh         t4, s3, s10
                  c.slli       a5, 14
                  lui          t4, 172841
                  srai         s11, a5, 6
                  slli         t0, zero, 18
                  xor          s5, s7, t6
                  c.srai       s1, 8
                  srli         tp, ra, 29
                  and          a1, s3, s0
                  addi         s11, s11, -143
                  slt          s6, s6, gp
                  xor          s5, s7, t6
                  sltiu        t6, sp, 205
                  mul          s11, a6, a7
                  srai         s11, a5, 6
                  xori         t0, t6, -1239
                  or           s8, s8, t2
                  andi         s6, a4, 204
                  c.slli       a5, 14
                  andi         s6, a4, 204
                  c.li         gp, -1
                  srai         s11, a5, 6
                  c.sub        s0, s0
                  c.srli       s1, 18
                  mulhsu       a1, gp, a0
                  c.srli       s1, 18
                  or           s8, s8, t2
                  c.addi16sp   sp, 384
                  sltu         t1, a6, a2
                  slt          s6, s6, gp
                  c.nop
                  slti         s6, tp, 996
                  c.mv         s6, sp
                  addi         s11, s11, -143
                  or           s8, s8, t2
                  lui          t4, 172841
                  or           s8, s8, t2
                  sltu         t1, a6, a2
                  c.xor        a2, a5
                  c.or         a2, a3
                  auipc        zero, 631536
                  c.nop
                  c.and        a1, a3
                  c.xor        a2, a5
                  div          s8, ra, a4
                  c.andi       s0, -1
                  ori          s1, a7, 303
                  xori         t0, t6, -1239
                  xori         t0, t6, -1239
                  xori         t0, t6, -1239
                  sub          t3, a0, t2
                  c.nop
                  c.srai       s1, 8
                  c.addi       s5, -1
                  mulhsu       a1, gp, a0
                  sltu         t1, a6, a2
                  c.slli       a5, 14
                  mulhsu       a1, gp, a0
                  c.lui        t2, 18
                  c.nop
                  or           s8, s8, t2
                  mulhu        s5, t3, zero
                  remu         s9, a2, t1
                  div          s8, ra, a4
                  c.srai       s1, 8
                  or           s8, s8, t2
                  c.srli       s1, 18
                  sltiu        t6, sp, 205
                  c.addi       s5, -1
                  sub          t3, a0, t2
                  slti         s6, tp, 996
                  or           s8, s8, t2
                  mulhu        s5, t3, zero
                  c.add        ra, a0
                  c.mv         s6, sp
                  srai         s11, a5, 6
                  c.addi       s5, -1
                  div          s8, ra, a4
                  c.or         a2, a3
                  rem          s8, t3, s11
                  c.lui        t2, 18
                  slti         s6, tp, 996
                  lui          t4, 172841
                  li           gp, 0x0 #start riscv_int_numeric_corner_stream_30
                  li           a3, 0x80000000
                  li           s0, 0xffffffff
                  li           t3, 0x0
                  li           s5, 0x0
                  li           s1, 0x0
                  li           ra, 0x80000000
                  li           t2, 0x402fa80d
                  li           t5, 0xffffffff
                  li           a7, 0xffffffff
                  mul          t3, ra, gp
                  mul          t3, ra, gp
                  mulh         ra, s0, a3
                  mulh         ra, s0, a3
                  div          a3, gp, t5
                  addi         t3, a3, -143
                  auipc        ra, 631536
                  mulh         ra, s0, a3
                  mulhsu       s5, s0, s1
                  rem          a3, t3, ra
                  mulhu        t2, t3, ra
                  nop
                  mul          t3, ra, gp
                  sub          t5, t5, s5
                  mul          t3, ra, gp
                  auipc        ra, 631536
                  remu         a7, t2, a7
                  addi         t3, a3, -143
                  auipc        ra, 631536
                  mul          t3, ra, gp
                  div          a3, gp, t5
                  add          ra, s0, t3
                  lui          t5, 172841
                  divu         t2, s5, t2
                  mulhsu       s5, s0, s1
                  divu         t2, s5, t2
                  divu         t2, s5, t2
                  add          ra, s0, t3
                  remu         a7, t2, a7
                  remu         a7, t2, a7 #end riscv_int_numeric_corner_stream_30
                  c.srai       s1, 8
                  rem          s8, t3, s11
                  xori         t0, t6, -1239
                  mul          s11, a6, a7
                  slt          s6, s6, gp
                  c.andi       s0, -1
                  rem          s8, t3, s11
                  sll          a2, t6, tp
                  mulh         t4, s3, s10
                  addi         s11, s11, -143
                  c.xor        a2, a5
                  sub          t3, a0, t2
                  c.add        ra, a0
                  mul          s11, a6, a7
                  rem          s8, t3, s11
                  remu         s9, a2, t1
                  sltiu        t6, sp, 205
                  c.or         a2, a3
                  xori         t0, t6, -1239
                  mulhsu       a1, gp, a0
                  c.li         gp, -1
                  c.slli       a5, 14
                  addi         s11, s11, -143
                  sub          t3, a0, t2
                  rem          s8, t3, s11
                  slti         s6, tp, 996
                  c.xor        a2, a5
                  xor          s5, s7, t6
                  c.lui        t2, 18
                  remu         s9, a2, t1
                  auipc        zero, 631536
                  mulhsu       a1, gp, a0
                  c.li         gp, -1
                  c.addi4spn   a1, sp, 480
                  c.srli       s1, 18
                  c.nop
                  c.srli       s1, 18
                  slti         s6, tp, 996
                  mulhu        s5, t3, zero
                  sltu         t1, a6, a2
                  c.lui        t2, 18
                  c.sub        s0, s0
                  c.li         gp, -1
                  or           s8, s8, t2
                  mulhsu       a1, gp, a0
                  srai         s11, a5, 6
                  c.addi4spn   a1, sp, 480
                  srai         s11, a5, 6
                  c.li         gp, -1
                  c.andi       s0, -1
                  slt          s6, s6, gp
                  div          s8, ra, a4
                  add          s2, gp, s8
                  c.andi       s0, -1
                  sub          t3, a0, t2
                  slt          s6, s6, gp
                  c.addi       s5, -1
                  sltu         t1, a6, a2
                  divu         sp, t2, s2
                  sub          t3, a0, t2
                  sltu         t1, a6, a2
                  or           s8, s8, t2
                  auipc        zero, 631536
                  andi         s6, a4, 204
                  c.mv         s6, sp
                  xori         t0, t6, -1239
                  ori          s1, a7, 303
                  c.or         a2, a3
                  c.srai       s1, 8
                  andi         s6, a4, 204
                  lui          t4, 172841
                  andi         s6, a4, 204
                  slt          s6, s6, gp
                  c.sub        s0, s0
                  and          a1, s3, s0
                  sltu         t1, a6, a2
                  sub          t3, a0, t2
                  div          s8, ra, a4
                  c.add        ra, a0
                  mulhsu       a1, gp, a0
                  ori          s1, a7, 303
                  sltiu        t6, sp, 205
                  divu         sp, t2, s2
                  mul          s11, a6, a7
                  mulh         t4, s3, s10
                  li           t6, 0xffffffff #start riscv_int_numeric_corner_stream_28
                  li           a2, 0x80000000
                  li           t4, 0x44f4968a
                  li           tp, 0x80000000
                  li           ra, 0xffffffff
                  li           a1, 0xb57a90ff
                  li           s2, 0xffffffff
                  li           t0, 0xe0705559
                  li           s11, 0xffffffff
                  li           s6, 0x39c555e5
                  nop
                  rem          s2, t4, ra
                  mulh         ra, a1, s2
                  sub          t6, t6, s11
                  mul          t4, ra, tp
                  addi         t4, s2, -143
                  mul          t4, ra, tp
                  divu         t0, s11, t0
                  remu         s6, t0, s6
                  divu         t0, s11, t0
                  add          ra, a1, t4
                  lui          t6, 172841
                  mul          t4, ra, tp
                  remu         s6, t0, s6
                  lui          t6, 172841
                  div          s2, tp, t6
                  addi         t4, s2, -143
                  add          ra, a1, t4
                  rem          s2, t4, ra
                  divu         t0, s11, t0
                  add          ra, a1, t4
                  mulh         ra, a1, s2
                  add          ra, a1, t4
                  mul          t4, ra, tp
                  addi         t4, s2, -143
                  div          s2, tp, t6
                  divu         t0, s11, t0
                  divu         t0, s11, t0
                  mulhsu       s11, a1, a2
                  sub          t6, t6, s11 #end riscv_int_numeric_corner_stream_28
                  c.addi       s5, -1
                  c.addi       s5, -1
                  sra          s1, s7, t6
                  slt          s6, s6, gp
                  auipc        zero, 631536
                  c.nop
                  srai         s11, a5, 6
                  c.li         gp, -1
                  auipc        zero, 631536
                  c.add        ra, a0
                  rem          s8, t3, s11
                  c.lui        t2, 18
                  nop
                  c.xor        a2, a5
                  sub          t3, a0, t2
                  mul          s11, a6, a7
                  andi         s6, a4, 204
                  div          s8, ra, a4
                  xor          s5, s7, t6
                  c.nop
                  nop
                  slti         s6, tp, 996
                  andi         s6, a4, 204
                  nop
                  slt          s6, s6, gp
                  sll          a2, t6, tp
                  sll          a2, t6, tp
                  rem          s8, t3, s11
                  c.addi4spn   a1, sp, 480
                  srl          a6, s8, s9
                  slli         t0, zero, 18
                  auipc        zero, 631536
                  remu         s9, a2, t1
                  and          a1, s3, s0
                  slt          s6, s6, gp
                  c.mv         s6, sp
                  sltiu        t6, sp, 205
                  andi         s6, a4, 204
                  c.srli       s1, 18
                  addi         s11, s11, -143
                  c.mv         s6, sp
                  ori          s1, a7, 303
                  lui          t4, 172841
                  slt          s6, s6, gp
                  sltu         t1, a6, a2
                  slt          s6, s6, gp
                  divu         sp, t2, s2
                  auipc        zero, 631536
                  c.and        a1, a3
                  c.addi16sp   sp, 384
                  and          a1, s3, s0
                  c.nop
                  c.nop
                  div          s8, ra, a4
                  c.slli       a5, 14
                  sll          a2, t6, tp
                  remu         s9, a2, t1
                  mulhsu       a1, gp, a0
                  ori          s1, a7, 303
                  auipc        zero, 631536
                  srl          a6, s8, s9
                  sll          a2, t6, tp
                  or           s8, s8, t2
                  nop
                  mulhu        s5, t3, zero
                  xor          s5, s7, t6
                  c.add        ra, a0
                  c.sub        s0, s0
                  c.xor        a2, a5
                  xor          s5, s7, t6
                  c.nop
                  c.srli       s1, 18
                  srli         tp, ra, 29
                  c.srai       s1, 8
                  c.andi       s0, -1
                  or           s8, s8, t2
                  add          s2, gp, s8
                  xor          s5, s7, t6
                  sll          a2, t6, tp
                  mul          s11, a6, a7
                  srai         s11, a5, 6
                  sra          s1, s7, t6
                  c.addi4spn   a1, sp, 480
                  c.or         a2, a3
                  xor          s5, s7, t6
                  c.mv         s6, sp
                  c.slli       a5, 14
                  nop
                  c.srli       s1, 18
                  c.xor        a2, a5
                  c.srai       s1, 8
                  auipc        zero, 631536
                  sra          s1, s7, t6
                  c.nop
                  sra          s1, s7, t6
                  c.lui        t2, 18
                  div          s8, ra, a4
                  divu         sp, t2, s2
                  or           s8, s8, t2
                  c.srli       s1, 18
                  slt          s6, s6, gp
                  c.andi       s0, -1
                  remu         s9, a2, t1
                  c.sub        s0, s0
                  c.xor        a2, a5
                  xori         t0, t6, -1239
                  srl          a6, s8, s9
                  mulhsu       a1, gp, a0
                  and          a1, s3, s0
                  mul          s11, a6, a7
                  or           s8, s8, t2
                  or           s8, s8, t2
                  or           s8, s8, t2
                  c.and        a1, a3
                  mulhu        s5, t3, zero
                  mulhu        s5, t3, zero
                  xor          s5, s7, t6
                  div          s8, ra, a4
                  c.andi       s0, -1
                  sltu         t1, a6, a2
                  slli         t0, zero, 18
                  mul          s11, a6, a7
                  xor          s5, s7, t6
                  ori          s1, a7, 303
                  c.add        ra, a0
                  c.andi       s0, -1
                  andi         s6, a4, 204
                  srl          a6, s8, s9
                  srai         s11, a5, 6
                  addi         s11, s11, -143
                  mulh         t4, s3, s10
                  div          s8, ra, a4
                  sltiu        t6, sp, 205
                  sra          s1, s7, t6
                  ori          s1, a7, 303
                  auipc        zero, 631536
                  slt          s6, s6, gp
                  c.and        a1, a3
                  auipc        zero, 631536
                  div          s8, ra, a4
                  mulh         t4, s3, s10
                  c.or         a2, a3
                  c.sub        s0, s0
                  srl          a6, s8, s9
                  c.or         a2, a3
                  slli         t0, zero, 18
                  auipc        zero, 631536
                  divu         sp, t2, s2
                  andi         s6, a4, 204
                  c.addi16sp   sp, 384
                  sra          s1, s7, t6
                  remu         s9, a2, t1
                  c.mv         s6, sp
                  srl          a6, s8, s9
                  c.addi       s5, -1
                  add          s2, gp, s8
                  c.xor        a2, a5
                  rem          s8, t3, s11
                  c.addi4spn   a1, sp, 480
                  slt          s6, s6, gp
                  c.addi16sp   sp, 384
                  c.addi4spn   a1, sp, 480
                  mul          s11, a6, a7
                  auipc        zero, 631536
                  c.sub        s0, s0
                  div          s8, ra, a4
                  c.andi       s0, -1
                  xori         t0, t6, -1239
                  c.mv         s6, sp
                  slti         s6, tp, 996
                  nop
                  andi         s6, a4, 204
                  mulh         t4, s3, s10
                  and          a1, s3, s0
                  c.addi4spn   a1, sp, 480
                  c.sub        s0, s0
                  srl          a6, s8, s9
                  c.li         gp, -1
                  c.addi16sp   sp, 384
                  remu         s9, a2, t1
                  andi         s6, a4, 204
                  slt          s6, s6, gp
                  mulh         t4, s3, s10
                  sll          a2, t6, tp
                  c.lui        t2, 18
                  c.or         a2, a3
                  sltu         t1, a6, a2
                  c.addi       s5, -1
                  c.addi16sp   sp, 384
                  c.nop
                  and          a1, s3, s0
                  c.or         a2, a3
                  c.addi16sp   sp, 384
                  c.addi       s5, -1
                  mulhsu       a1, gp, a0
                  add          s2, gp, s8
                  c.or         a2, a3
                  slt          s6, s6, gp
                  or           s8, s8, t2
                  c.mv         s6, sp
                  mulhsu       a1, gp, a0
                  c.andi       s0, -1
                  slli         t0, zero, 18
                  c.addi4spn   a1, sp, 480
                  mulhu        s5, t3, zero
                  sra          s1, s7, t6
                  c.and        a1, a3
                  c.mv         s6, sp
                  lui          t4, 172841
                  c.sub        s0, s0
                  sltu         t1, a6, a2
                  mulh         t4, s3, s10
                  c.andi       s0, -1
                  srai         s11, a5, 6
                  lui          t4, 172841
                  add          s2, gp, s8
                  c.srai       s1, 8
                  slti         s6, tp, 996
                  addi         s11, s11, -143
                  ori          s1, a7, 303
                  c.srai       s1, 8
                  sltiu        t6, sp, 205
                  sltu         t1, a6, a2
                  slti         s6, tp, 996
                  remu         s9, a2, t1
                  xor          s5, s7, t6
                  c.nop
                  slti         s6, tp, 996
                  or           s8, s8, t2
                  mulhsu       a1, gp, a0
                  div          s8, ra, a4
                  sll          a2, t6, tp
                  c.xor        a2, a5
                  remu         s9, a2, t1
                  mulhu        s5, t3, zero
                  mulh         t4, s3, s10
                  c.addi       s5, -1
                  c.srai       s1, 8
                  c.addi16sp   sp, 384
                  sltu         t1, a6, a2
                  or           s8, s8, t2
                  c.addi16sp   sp, 384
                  nop
                  c.srai       s1, 8
                  c.sub        s0, s0
                  c.mv         s6, sp
                  mulhu        s5, t3, zero
                  mulhsu       a1, gp, a0
                  c.sub        s0, s0
                  sub          t3, a0, t2
                  c.and        a1, a3
                  slti         s6, tp, 996
                  c.lui        t2, 18
                  c.li         gp, -1
                  mulhu        s5, t3, zero
                  sub          t3, a0, t2
                  c.addi16sp   sp, 384
                  div          s8, ra, a4
                  srai         s11, a5, 6
                  mulh         t4, s3, s10
                  c.or         a2, a3
                  slti         s6, tp, 996
                  c.andi       s0, -1
                  sub          t3, a0, t2
                  c.lui        t2, 18
                  c.srli       s1, 18
                  c.srai       s1, 8
                  c.add        ra, a0
                  c.lui        t2, 18
                  c.sub        s0, s0
                  c.or         a2, a3
                  srl          a6, s8, s9
                  add          s2, gp, s8
                  addi         s11, s11, -143
                  c.xor        a2, a5
                  add          s2, gp, s8
                  sub          t3, a0, t2
                  sll          a2, t6, tp
                  div          s8, ra, a4
                  c.srai       s1, 8
                  c.andi       s0, -1
                  rem          s8, t3, s11
                  remu         s9, a2, t1
                  c.andi       s0, -1
                  slti         s6, tp, 996
                  sll          a2, t6, tp
                  auipc        zero, 631536
                  c.lui        t2, 18
                  div          s8, ra, a4
                  addi         s11, s11, -143
                  rem          s8, t3, s11
                  andi         s6, a4, 204
                  andi         s6, a4, 204
                  c.li         gp, -1
                  slt          s6, s6, gp
                  mulh         t4, s3, s10
                  mulhsu       a1, gp, a0
                  div          s8, ra, a4
                  mulhsu       a1, gp, a0
                  mul          s11, a6, a7
                  mul          s11, a6, a7
                  xori         t0, t6, -1239
                  c.or         a2, a3
                  sll          a2, t6, tp
                  mulhsu       a1, gp, a0
                  mulh         t4, s3, s10
                  and          a1, s3, s0
                  c.mv         s6, sp
                  sub          t3, a0, t2
                  c.addi       s5, -1
                  xor          s5, s7, t6
                  c.addi       s5, -1
                  ori          s1, a7, 303
                  c.xor        a2, a5
                  c.addi16sp   sp, 384
                  andi         s6, a4, 204
                  rem          s8, t3, s11
                  c.mv         s6, sp
                  c.slli       a5, 14
                  sub          t3, a0, t2
                  c.addi       s5, -1
                  c.lui        t2, 18
                  sll          a2, t6, tp
                  c.sub        s0, s0
                  sltu         t1, a6, a2
                  sltu         t1, a6, a2
                  c.nop
                  lui          t4, 172841
                  rem          s8, t3, s11
                  srl          a6, s8, s9
                  remu         s9, a2, t1
                  sltiu        t6, sp, 205
                  c.li         gp, -1
                  c.sub        s0, s0
                  li           a6, 0x80000000 #start riscv_int_numeric_corner_stream_37
                  li           s2, 0x80000000
                  li           s0, 0x0
                  li           t3, 0x0
                  li           t5, 0xa9864448
                  li           ra, 0x28600f9
                  li           s1, 0x30da68c0
                  li           t1, 0x0
                  li           t6, 0x94cd0306
                  li           a1, 0x0
                  mulhu        s0, t5, ra
                  div          a6, t1, t6
                  nop
                  sub          t6, t6, t3
                  addi         t5, a6, -143
                  div          a6, t1, t6
                  remu         s2, s0, s2
                  nop
                  mulhsu       t3, s1, a1
                  auipc        ra, 631536
                  divu         s0, t3, s0
                  rem          a6, t5, ra
                  nop
                  lui          t6, 172841
                  mul          t5, ra, t1
                  nop
                  lui          t6, 172841
                  rem          a6, t5, ra
                  addi         t5, a6, -143 #end riscv_int_numeric_corner_stream_37
                  divu         sp, t2, s2
                  mulhu        s5, t3, zero
                  sltu         t1, a6, a2
                  c.nop
                  remu         s9, a2, t1
                  c.mv         s6, sp
                  nop
                  c.and        a1, a3
                  c.and        a1, a3
                  c.srai       s1, 8
                  sltiu        t6, sp, 205
                  sra          s1, s7, t6
                  c.lui        t2, 18
                  sub          t3, a0, t2
                  slli         t0, zero, 18
                  or           s8, s8, t2
                  sra          s1, s7, t6
                  c.and        a1, a3
                  auipc        zero, 631536
                  slli         t0, zero, 18
                  c.srli       s1, 18
                  ori          s1, a7, 303
                  slli         t0, zero, 18
                  c.sub        s0, s0
                  c.slli       a5, 14
                  c.mv         s6, sp
                  c.lui        t2, 18
                  auipc        zero, 631536
                  div          s8, ra, a4
                  c.mv         s6, sp
                  mul          s11, a6, a7
                  sll          a2, t6, tp
                  srli         tp, ra, 29
                  srl          a6, s8, s9
                  c.addi       s5, -1
                  c.slli       a5, 14
                  c.addi       s5, -1
                  addi         s11, s11, -143
                  ori          s1, a7, 303
                  auipc        zero, 631536
                  srl          a6, s8, s9
                  slli         t0, zero, 18
                  sra          s1, s7, t6
                  c.nop
                  c.and        a1, a3
                  srli         tp, ra, 29
                  mul          s11, a6, a7
                  c.andi       s0, -1
                  mulhu        s5, t3, zero
                  slti         s6, tp, 996
                  remu         s9, a2, t1
                  mulhsu       a1, gp, a0
                  xori         t0, t6, -1239
                  xor          s5, s7, t6
                  addi         s11, s11, -143
                  lui          t4, 172841
                  srli         tp, ra, 29
                  c.addi16sp   sp, 384
                  xori         t0, t6, -1239
                  c.add        ra, a0
                  lui          t4, 172841
                  mulhsu       a1, gp, a0
                  lui          t4, 172841
                  xor          s5, s7, t6
                  nop
                  and          a1, s3, s0
                  sltu         t1, a6, a2
                  remu         s9, a2, t1
                  slli         t0, zero, 18
                  c.mv         s6, sp
                  mul          s11, a6, a7
                  sltu         t1, a6, a2
                  c.addi4spn   a1, sp, 480
                  c.li         gp, -1
                  c.or         a2, a3
                  div          s8, ra, a4
                  mulh         t4, s3, s10
                  srai         s11, a5, 6
                  mulhu        s5, t3, zero
                  sltu         t1, a6, a2
                  sltiu        t6, sp, 205
                  nop
                  mul          s11, a6, a7
                  c.sub        s0, s0
                  c.sub        s0, s0
                  sltu         t1, a6, a2
                  mulh         t4, s3, s10
                  auipc        zero, 631536
                  or           s8, s8, t2
                  sltiu        t6, sp, 205
                  c.srai       s1, 8
                  c.lui        t2, 18
                  and          a1, s3, s0
                  or           s8, s8, t2
                  c.xor        a2, a5
                  add          s2, gp, s8
                  xor          s5, s7, t6
                  xori         t0, t6, -1239
                  mulhsu       a1, gp, a0
                  srli         tp, ra, 29
                  xor          s5, s7, t6
                  mul          s11, a6, a7
                  c.and        a1, a3
                  slt          s6, s6, gp
                  remu         s9, a2, t1
                  sltu         t1, a6, a2
                  c.mv         s6, sp
                  c.addi16sp   sp, 384
                  sltiu        t6, sp, 205
                  slli         t0, zero, 18
                  c.and        a1, a3
                  add          s2, gp, s8
                  remu         s9, a2, t1
                  c.srli       s1, 18
                  sub          t3, a0, t2
                  divu         sp, t2, s2
                  c.srli       s1, 18
                  c.xor        a2, a5
                  addi         s11, s11, -143
                  srai         s11, a5, 6
                  slt          s6, s6, gp
                  mulh         t4, s3, s10
                  xori         t0, t6, -1239
                  srai         s11, a5, 6
                  addi         s11, s11, -143
                  slli         t0, zero, 18
                  mul          s11, a6, a7
                  xori         t0, t6, -1239
                  slli         t0, zero, 18
                  slti         s6, tp, 996
                  c.slli       a5, 14
                  srai         s11, a5, 6
                  mulhsu       a1, gp, a0
                  c.andi       s0, -1
                  c.add        ra, a0
                  ori          s1, a7, 303
                  c.mv         s6, sp
                  lui          t4, 172841
                  remu         s9, a2, t1
                  c.lui        t2, 18
                  srli         tp, ra, 29
                  lui          t4, 172841
                  sltiu        t6, sp, 205
                  c.xor        a2, a5
                  srl          a6, s8, s9
                  remu         s9, a2, t1
                  sll          a2, t6, tp
                  c.xor        a2, a5
                  c.andi       s0, -1
                  slli         t0, zero, 18
                  c.lui        t2, 18
                  xori         t0, t6, -1239
                  sub          t3, a0, t2
                  c.slli       a5, 14
                  and          a1, s3, s0
                  c.lui        t2, 18
                  mulh         t4, s3, s10
                  c.addi4spn   a1, sp, 480
                  slti         s6, tp, 996
                  addi         s11, s11, -143
                  add          s2, gp, s8
                  mulhsu       a1, gp, a0
                  slt          s6, s6, gp
                  sub          t3, a0, t2
                  divu         sp, t2, s2
                  c.srai       s1, 8
                  remu         s9, a2, t1
                  add          s2, gp, s8
                  nop
                  mulhu        s5, t3, zero
                  ori          s1, a7, 303
                  divu         sp, t2, s2
                  sltu         t1, a6, a2
                  mul          s11, a6, a7
                  c.addi       s5, -1
                  c.mv         s6, sp
                  c.srli       s1, 18
                  xori         t0, t6, -1239
                  rem          s8, t3, s11
                  xor          s5, s7, t6
                  mulh         t4, s3, s10
                  c.add        ra, a0
                  div          s8, ra, a4
                  c.nop
                  andi         s6, a4, 204
                  auipc        zero, 631536
                  srai         s11, a5, 6
                  addi         s11, s11, -143
                  andi         s6, a4, 204
                  c.addi4spn   a1, sp, 480
                  srli         tp, ra, 29
                  slt          s6, s6, gp
                  ori          s1, a7, 303
                  addi         s11, s11, -143
                  c.xor        a2, a5
                  ori          s1, a7, 303
                  c.li         gp, -1
                  slli         t0, zero, 18
                  srai         s11, a5, 6
                  sltiu        t6, sp, 205
                  srl          a6, s8, s9
                  srli         tp, ra, 29
                  remu         s9, a2, t1
                  and          a1, s3, s0
                  c.andi       s0, -1
                  lui          t4, 172841
                  slti         s6, tp, 996
                  and          a1, s3, s0
                  slt          s6, s6, gp
                  mulhsu       a1, gp, a0
                  remu         s9, a2, t1
                  c.addi16sp   sp, 384
                  c.addi       s5, -1
                  c.srli       s1, 18
                  remu         s9, a2, t1
                  c.lui        t2, 18
                  mulhsu       a1, gp, a0
                  sub          t3, a0, t2
                  c.and        a1, a3
                  and          a1, s3, s0
                  sll          a2, t6, tp
                  c.srai       s1, 8
                  div          s8, ra, a4
                  c.xor        a2, a5
                  c.or         a2, a3
                  xor          s5, s7, t6
                  c.and        a1, a3
                  xori         t0, t6, -1239
                  c.srai       s1, 8
                  c.xor        a2, a5
                  sra          s1, s7, t6
                  c.and        a1, a3
                  sra          s1, s7, t6
                  divu         sp, t2, s2
                  divu         sp, t2, s2
                  c.mv         s6, sp
                  lui          t4, 172841
                  or           s8, s8, t2
                  remu         s9, a2, t1
                  c.add        ra, a0
                  xori         t0, t6, -1239
                  div          s8, ra, a4
                  c.and        a1, a3
                  c.andi       s0, -1
                  c.lui        t2, 18
                  c.lui        t2, 18
                  remu         s9, a2, t1
                  c.srai       s1, 8
                  c.li         gp, -1
                  sub          t3, a0, t2
                  mulhsu       a1, gp, a0
                  mulhu        s5, t3, zero
                  c.xor        a2, a5
                  sub          t3, a0, t2
                  mulhu        s5, t3, zero
                  slt          s6, s6, gp
                  andi         s6, a4, 204
                  c.mv         s6, sp
                  mulhsu       a1, gp, a0
                  sub          t3, a0, t2
                  slt          s6, s6, gp
                  lui          t4, 172841
                  c.srli       s1, 18
                  c.sub        s0, s0
                  mulhu        s5, t3, zero
                  sra          s1, s7, t6
                  slli         t0, zero, 18
                  srli         tp, ra, 29
                  srli         tp, ra, 29
                  c.srai       s1, 8
                  slti         s6, tp, 996
                  rem          s8, t3, s11
                  c.nop
                  c.xor        a2, a5
                  nop
                  sltiu        t6, sp, 205
                  div          s8, ra, a4
                  sub          t3, a0, t2
                  srai         s11, a5, 6
                  andi         s6, a4, 204
                  lui          t4, 172841
                  slli         t0, zero, 18
                  slti         s6, tp, 996
                  rem          s8, t3, s11
                  sub          t3, a0, t2
                  nop
                  srl          a6, s8, s9
                  addi         s11, s11, -143
                  c.addi16sp   sp, 384
                  rem          s8, t3, s11
                  c.lui        t2, 18
                  c.mv         s6, sp
                  ori          s1, a7, 303
                  li           s2, 0xe11c65c9 #start riscv_int_numeric_corner_stream_27
                  li           s11, 0x80000000
                  li           s10, 0xffffffff
                  li           s1, 0x0
                  li           s3, 0x80000000
                  li           t4, 0xbd98703a
                  li           s9, 0x0
                  li           a6, 0xffffffff
                  li           a3, 0x80000000
                  li           sp, 0x0
                  lui          t4, 172841
                  div          s3, s1, t4
                  divu         a3, s10, a3
                  rem          s3, s11, sp
                  lui          t4, 172841
                  mulhsu       s10, a6, s2
                  div          s3, s1, t4
                  mulhu        a3, s11, sp
                  divu         a3, s10, a3
                  remu         s9, a3, s9
                  sub          t4, t4, s10
                  rem          s3, s11, sp
                  divu         a3, s10, a3
                  div          s3, s1, t4
                  addi         s11, s3, -143
                  remu         s9, a3, s9
                  add          sp, a6, s11
                  remu         s9, a3, s9 #end riscv_int_numeric_corner_stream_27
                  andi         s6, a4, 204
                  mulh         t4, s3, s10
                  slt          s6, s6, gp
                  mul          s11, a6, a7
                  xori         t0, t6, -1239
                  rem          s8, t3, s11
                  divu         sp, t2, s2
                  srli         tp, ra, 29
                  and          a1, s3, s0
                  c.mv         s6, sp
                  srli         tp, ra, 29
                  or           s8, s8, t2
                  xori         t0, t6, -1239
                  addi         s11, s11, -143
                  c.mv         s6, sp
                  c.nop
                  addi         s11, s11, -143
                  remu         s9, a2, t1
                  mulhsu       a1, gp, a0
                  c.srai       s1, 8
                  c.or         a2, a3
                  sltiu        t6, sp, 205
                  c.sub        s0, s0
                  c.or         a2, a3
                  divu         sp, t2, s2
                  sll          a2, t6, tp
                  c.sub        s0, s0
                  div          s8, ra, a4
                  and          a1, s3, s0
                  slli         t0, zero, 18
                  lui          t4, 172841
                  mulhsu       a1, gp, a0
                  slti         s6, tp, 996
                  andi         s6, a4, 204
                  andi         s6, a4, 204
                  c.mv         s6, sp
                  mulhu        s5, t3, zero
                  nop
                  remu         s9, a2, t1
                  c.andi       s0, -1
                  c.srli       s1, 18
                  c.andi       s0, -1
                  andi         s6, a4, 204
                  mulh         t4, s3, s10
                  xor          s5, s7, t6
                  rem          s8, t3, s11
                  sltu         t1, a6, a2
                  add          s2, gp, s8
                  c.srli       s1, 18
                  rem          s8, t3, s11
                  slt          s6, s6, gp
                  mulhu        s5, t3, zero
                  div          s8, ra, a4
                  c.addi4spn   a1, sp, 480
                  mulhu        s5, t3, zero
                  divu         sp, t2, s2
                  auipc        zero, 631536
                  slti         s6, tp, 996
                  c.addi16sp   sp, 384
                  c.and        a1, a3
                  c.srli       s1, 18
                  c.sub        s0, s0
                  remu         s9, a2, t1
                  remu         s9, a2, t1
                  c.li         gp, -1
                  c.or         a2, a3
                  c.addi16sp   sp, 384
                  sra          s1, s7, t6
                  c.srai       s1, 8
                  remu         s9, a2, t1
                  c.addi16sp   sp, 384
                  xori         t0, t6, -1239
                  add          s2, gp, s8
                  mulh         t4, s3, s10
                  c.xor        a2, a5
                  mulhsu       a1, gp, a0
                  c.nop
                  srl          a6, s8, s9
                  mul          s11, a6, a7
                  mulhu        s5, t3, zero
                  c.and        a1, a3
                  auipc        zero, 631536
                  c.slli       a5, 14
                  mul          s11, a6, a7
                  mul          s11, a6, a7
                  srl          a6, s8, s9
                  remu         s9, a2, t1
                  divu         sp, t2, s2
                  c.or         a2, a3
                  rem          s8, t3, s11
                  rem          s8, t3, s11
                  div          s8, ra, a4
                  c.sub        s0, s0
                  c.slli       a5, 14
                  sra          s1, s7, t6
                  remu         s9, a2, t1
                  c.addi4spn   a1, sp, 480
                  rem          s8, t3, s11
                  mulhu        s5, t3, zero
                  c.nop
                  sra          s1, s7, t6
                  c.li         gp, -1
                  mulhu        s5, t3, zero
                  c.addi16sp   sp, 384
                  c.addi16sp   sp, 384
                  div          s8, ra, a4
                  nop
                  add          s2, gp, s8
                  c.addi16sp   sp, 384
                  add          s2, gp, s8
                  c.addi       s5, -1
                  mul          s11, a6, a7
                  c.or         a2, a3
                  c.nop
                  slt          s6, s6, gp
                  c.li         gp, -1
                  c.li         gp, -1
                  srli         tp, ra, 29
                  srl          a6, s8, s9
                  c.addi16sp   sp, 384
                  slti         s6, tp, 996
                  divu         sp, t2, s2
                  c.lui        t2, 18
                  srli         tp, ra, 29
                  c.mv         s6, sp
                  c.li         gp, -1
                  divu         sp, t2, s2
                  c.xor        a2, a5
                  sub          t3, a0, t2
                  nop
                  slt          s6, s6, gp
                  sra          s1, s7, t6
                  slli         t0, zero, 18
                  or           s8, s8, t2
                  and          a1, s3, s0
                  divu         sp, t2, s2
                  or           s8, s8, t2
                  or           s8, s8, t2
                  sltu         t1, a6, a2
                  sll          a2, t6, tp
                  mulh         t4, s3, s10
                  mulhu        s5, t3, zero
                  add          s2, gp, s8
                  sub          t3, a0, t2
                  nop
                  and          a1, s3, s0
                  sra          s1, s7, t6
                  nop
                  auipc        zero, 631536
                  mulh         t4, s3, s10
                  c.li         gp, -1
                  add          s2, gp, s8
                  c.mv         s6, sp
                  or           s8, s8, t2
                  and          a1, s3, s0
                  or           s8, s8, t2
                  divu         sp, t2, s2
                  sltu         t1, a6, a2
                  nop
                  c.and        a1, a3
                  mulh         t4, s3, s10
                  div          s8, ra, a4
                  divu         sp, t2, s2
                  mulh         t4, s3, s10
                  slti         s6, tp, 996
                  div          s8, ra, a4
                  sll          a2, t6, tp
                  c.sub        s0, s0
                  c.srai       s1, 8
                  c.lui        t2, 18
                  divu         sp, t2, s2
                  slli         t0, zero, 18
                  xor          s5, s7, t6
                  c.lui        t2, 18
                  sltiu        t6, sp, 205
                  c.xor        a2, a5
                  xor          s5, s7, t6
                  c.addi16sp   sp, 384
                  c.addi       s5, -1
                  ori          s1, a7, 303
                  xor          s5, s7, t6
                  sltiu        t6, sp, 205
                  c.and        a1, a3
                  c.addi4spn   a1, sp, 480
                  sltiu        t6, sp, 205
                  sll          a2, t6, tp
                  c.srli       s1, 18
                  c.srli       s1, 18
                  c.srai       s1, 8
                  c.lui        t2, 18
                  srli         tp, ra, 29
                  c.lui        t2, 18
                  slli         t0, zero, 18
                  slt          s6, s6, gp
                  div          s8, ra, a4
                  xori         t0, t6, -1239
                  c.li         gp, -1
                  ori          s1, a7, 303
                  or           s8, s8, t2
                  rem          s8, t3, s11
                  xori         t0, t6, -1239
                  c.srli       s1, 18
                  lui          t4, 172841
                  lui          t4, 172841
                  lui          t4, 172841
                  mulh         t4, s3, s10
                  sltu         t1, a6, a2
                  srl          a6, s8, s9
                  c.mv         s6, sp
                  slli         t0, zero, 18
                  c.add        ra, a0
                  sra          s1, s7, t6
                  c.slli       a5, 14
                  xor          s5, s7, t6
                  c.srai       s1, 8
                  c.addi       s5, -1
                  mulhu        s5, t3, zero
                  add          s2, gp, s8
                  c.addi16sp   sp, 384
                  sll          a2, t6, tp
                  c.nop
                  ori          s1, a7, 303
                  mulhsu       a1, gp, a0
                  nop
                  auipc        zero, 631536
                  div          s8, ra, a4
                  c.addi16sp   sp, 384
                  c.sub        s0, s0
                  c.andi       s0, -1
                  mulh         t4, s3, s10
                  c.lui        t2, 18
                  slli         t0, zero, 18
                  c.nop
                  ori          s1, a7, 303
                  c.addi16sp   sp, 384
                  andi         s6, a4, 204
                  c.andi       s0, -1
                  c.or         a2, a3
                  sub          t3, a0, t2
                  mul          s11, a6, a7
                  nop
                  sub          t3, a0, t2
                  mulhu        s5, t3, zero
                  c.addi       s5, -1
                  div          s8, ra, a4
                  c.mv         s6, sp
                  li           a2, 0xffffffff #start riscv_int_numeric_corner_stream_35
                  li           t0, 0x0
                  li           a1, 0x0
                  li           a6, 0x0
                  li           ra, 0xffffffff
                  li           t4, 0xffffffff
                  li           s3, 0xffffffff
                  li           t2, 0x80000000
                  li           t6, 0x80000000
                  li           t5, 0x80000000
                  mulh         ra, a1, a6
                  sub          t6, t6, t4
                  auipc        ra, 631536
                  mulhsu       t4, a1, a2
                  mulhu        t2, t5, ra
                  rem          a6, t5, ra
                  rem          a6, t5, ra
                  add          ra, a1, t5
                  remu         s3, t2, s3
                  mulh         ra, a1, a6
                  mulh         ra, a1, a6
                  mulhsu       t4, a1, a2
                  divu         t2, t4, t2
                  divu         t2, t4, t2
                  addi         t5, a6, -143
                  divu         t2, t4, t2
                  add          ra, a1, t5
                  mulhu        t2, t5, ra
                  mulhu        t2, t5, ra
                  mul          t5, ra, t0
                  divu         t2, t4, t2
                  add          ra, a1, t5
                  auipc        ra, 631536
                  auipc        ra, 631536
                  lui          t6, 172841
                  auipc        ra, 631536
                  auipc        ra, 631536
                  add          ra, a1, t5
                  divu         t2, t4, t2 #end riscv_int_numeric_corner_stream_35
                  c.add        ra, a0
                  lui          t4, 172841
                  slti         s6, tp, 996
                  remu         s9, a2, t1
                  divu         sp, t2, s2
                  c.addi4spn   a1, sp, 480
                  sltiu        t6, sp, 205
                  ori          s1, a7, 303
                  mulh         t4, s3, s10
                  c.addi       s5, -1
                  or           s8, s8, t2
                  c.srai       s1, 8
                  sra          s1, s7, t6
                  c.xor        a2, a5
                  xori         t0, t6, -1239
                  div          s8, ra, a4
                  srli         tp, ra, 29
                  sub          t3, a0, t2
                  rem          s8, t3, s11
                  c.mv         s6, sp
                  c.and        a1, a3
                  c.add        ra, a0
                  c.srai       s1, 8
                  xor          s5, s7, t6
                  sub          t3, a0, t2
                  sll          a2, t6, tp
                  addi         s11, s11, -143
                  mulhsu       a1, gp, a0
                  c.xor        a2, a5
                  slli         t0, zero, 18
                  xori         t0, t6, -1239
                  c.xor        a2, a5
                  c.srli       s1, 18
                  slt          s6, s6, gp
                  slt          s6, s6, gp
                  c.andi       s0, -1
                  remu         s9, a2, t1
                  c.nop
                  and          a1, s3, s0
                  slli         t0, zero, 18
                  xor          s5, s7, t6
                  c.sub        s0, s0
                  sra          s1, s7, t6
                  xor          s5, s7, t6
                  srl          a6, s8, s9
                  slt          s6, s6, gp
                  lui          t4, 172841
                  c.xor        a2, a5
                  and          a1, s3, s0
                  mul          s11, a6, a7
                  slli         t0, zero, 18
                  xori         t0, t6, -1239
                  ori          s1, a7, 303
                  c.sub        s0, s0
                  c.addi16sp   sp, 384
                  xori         t0, t6, -1239
                  c.or         a2, a3
                  c.nop
                  slt          s6, s6, gp
                  mulh         t4, s3, s10
                  c.lui        t2, 18
                  c.li         gp, -1
                  lui          t4, 172841
                  sll          a2, t6, tp
                  add          s2, gp, s8
                  andi         s6, a4, 204
                  c.addi16sp   sp, 384
                  remu         s9, a2, t1
                  c.nop
                  sub          t3, a0, t2
                  sra          s1, s7, t6
                  ori          s1, a7, 303
                  c.or         a2, a3
                  c.addi       s5, -1
                  div          s8, ra, a4
                  divu         sp, t2, s2
                  c.nop
                  srai         s11, a5, 6
                  sltu         t1, a6, a2
                  c.or         a2, a3
                  c.srai       s1, 8
                  xor          s5, s7, t6
                  andi         s6, a4, 204
                  c.addi16sp   sp, 384
                  xor          s5, s7, t6
                  c.and        a1, a3
                  and          a1, s3, s0
                  sltiu        t6, sp, 205
                  andi         s6, a4, 204
                  srli         tp, ra, 29
                  c.mv         s6, sp
                  mulhsu       a1, gp, a0
                  sltiu        t6, sp, 205
                  c.and        a1, a3
                  c.lui        t2, 18
                  srl          a6, s8, s9
                  addi         s11, s11, -143
                  srai         s11, a5, 6
                  addi         s11, s11, -143
                  c.addi       s5, -1
                  rem          s8, t3, s11
                  slt          s6, s6, gp
                  nop
                  c.mv         s6, sp
                  xori         t0, t6, -1239
                  div          s8, ra, a4
                  and          a1, s3, s0
                  rem          s8, t3, s11
                  slt          s6, s6, gp
                  sltiu        t6, sp, 205
                  c.li         gp, -1
                  and          a1, s3, s0
                  c.sub        s0, s0
                  slli         t0, zero, 18
                  slli         t0, zero, 18
                  sltiu        t6, sp, 205
                  sra          s1, s7, t6
                  lui          t4, 172841
                  sra          s1, s7, t6
                  addi         s11, s11, -143
                  c.andi       s0, -1
                  c.srai       s1, 8
                  c.mv         s6, sp
                  or           s8, s8, t2
                  sra          s1, s7, t6
                  mulhu        s5, t3, zero
                  srai         s11, a5, 6
                  rem          s8, t3, s11
                  c.addi4spn   a1, sp, 480
                  c.slli       a5, 14
                  ori          s1, a7, 303
                  sll          a2, t6, tp
                  c.addi16sp   sp, 384
                  mulh         t4, s3, s10
                  srl          a6, s8, s9
                  c.addi       s5, -1
                  rem          s8, t3, s11
                  srl          a6, s8, s9
                  sltiu        t6, sp, 205
                  c.srai       s1, 8
                  mulhsu       a1, gp, a0
                  sra          s1, s7, t6
                  sltiu        t6, sp, 205
                  sltiu        t6, sp, 205
                  c.addi16sp   sp, 384
                  or           s8, s8, t2
                  lui          t4, 172841
                  add          s2, gp, s8
                  sll          a2, t6, tp
                  c.li         gp, -1
                  mulhsu       a1, gp, a0
                  c.sub        s0, s0
                  mul          s11, a6, a7
                  c.addi16sp   sp, 384
                  c.andi       s0, -1
                  mul          s11, a6, a7
                  c.xor        a2, a5
                  slti         s6, tp, 996
                  slti         s6, tp, 996
                  and          a1, s3, s0
                  remu         s9, a2, t1
                  sll          a2, t6, tp
                  c.and        a1, a3
                  addi         s11, s11, -143
                  c.srai       s1, 8
                  andi         s6, a4, 204
                  c.and        a1, a3
                  sra          s1, s7, t6
                  sub          t3, a0, t2
                  sll          a2, t6, tp
                  sra          s1, s7, t6
                  c.slli       a5, 14
                  ori          s1, a7, 303
                  andi         s6, a4, 204
                  sra          s1, s7, t6
                  ori          s1, a7, 303
                  mul          s11, a6, a7
                  c.andi       s0, -1
                  slli         t0, zero, 18
                  andi         s6, a4, 204
                  lui          t4, 172841
                  c.and        a1, a3
                  c.slli       a5, 14
                  c.addi16sp   sp, 384
                  c.sub        s0, s0
                  c.or         a2, a3
                  xori         t0, t6, -1239
                  c.nop
                  srai         s11, a5, 6
                  addi         s11, s11, -143
                  lui          t4, 172841
                  add          s2, gp, s8
                  c.li         gp, -1
                  slti         s6, tp, 996
                  sll          a2, t6, tp
                  c.nop
                  rem          s8, t3, s11
                  divu         sp, t2, s2
                  xor          s5, s7, t6
                  remu         s9, a2, t1
                  c.li         gp, -1
                  mulhu        s5, t3, zero
                  remu         s9, a2, t1
                  nop
                  and          a1, s3, s0
                  c.and        a1, a3
                  ori          s1, a7, 303
                  remu         s9, a2, t1
                  andi         s6, a4, 204
                  auipc        zero, 631536
                  c.nop
                  c.or         a2, a3
                  slt          s6, s6, gp
                  c.addi       s5, -1
                  xor          s5, s7, t6
                  c.li         gp, -1
                  mulhsu       a1, gp, a0
                  rem          s8, t3, s11
                  mul          s11, a6, a7
                  andi         s6, a4, 204
                  mulh         t4, s3, s10
                  srai         s11, a5, 6
                  c.sub        s0, s0
                  remu         s9, a2, t1
                  c.and        a1, a3
                  add          s2, gp, s8
                  c.and        a1, a3
                  c.addi16sp   sp, 384
                  xor          s5, s7, t6
                  ori          s1, a7, 303
                  divu         sp, t2, s2
                  c.lui        t2, 18
                  mul          s11, a6, a7
                  c.addi4spn   a1, sp, 480
                  c.or         a2, a3
                  slli         t0, zero, 18
                  lui          t4, 172841
                  c.and        a1, a3
                  c.addi4spn   a1, sp, 480
                  xor          s5, s7, t6
                  c.addi16sp   sp, 384
                  mulh         t4, s3, s10
                  c.andi       s0, -1
                  slli         t0, zero, 18
                  slti         s6, tp, 996
                  c.addi4spn   a1, sp, 480
                  and          a1, s3, s0
                  c.lui        t2, 18
                  c.addi       s5, -1
                  c.andi       s0, -1
                  c.add        ra, a0
                  c.sub        s0, s0
                  ori          s1, a7, 303
                  mulh         t4, s3, s10
                  xor          s5, s7, t6
                  xori         t0, t6, -1239
                  sll          a2, t6, tp
                  c.srai       s1, 8
                  c.xor        a2, a5
                  c.srai       s1, 8
                  slli         t0, zero, 18
                  c.lui        t2, 18
                  sltiu        t6, sp, 205
                  c.addi4spn   a1, sp, 480
                  sltu         t1, a6, a2
                  or           s8, s8, t2
                  div          s8, ra, a4
                  c.and        a1, a3
                  c.sub        s0, s0
                  rem          s8, t3, s11
                  rem          s8, t3, s11
                  c.srli       s1, 18
                  mulh         t4, s3, s10
                  c.xor        a2, a5
                  c.lui        t2, 18
                  mulhu        s5, t3, zero
                  mulhsu       a1, gp, a0
                  c.nop
                  mulhsu       a1, gp, a0
                  c.or         a2, a3
                  c.addi4spn   a1, sp, 480
                  sra          s1, s7, t6
                  c.nop
                  c.li         gp, -1
                  c.slli       a5, 14
                  srl          a6, s8, s9
                  mul          s11, a6, a7
                  c.and        a1, a3
                  srli         tp, ra, 29
                  auipc        zero, 631536
                  c.slli       a5, 14
                  ori          s1, a7, 303
                  rem          s8, t3, s11
                  add          s2, gp, s8
                  slli         t0, zero, 18
                  c.nop
                  c.addi4spn   a1, sp, 480
                  div          s8, ra, a4
                  c.srli       s1, 18
                  and          a1, s3, s0
                  andi         s6, a4, 204
                  srli         tp, ra, 29
                  mulhsu       a1, gp, a0
                  nop
                  c.addi4spn   a1, sp, 480
                  c.add        ra, a0
                  c.slli       a5, 14
                  slti         s6, tp, 996
                  c.addi4spn   a1, sp, 480
                  c.addi4spn   a1, sp, 480
                  c.mv         s6, sp
                  slt          s6, s6, gp
                  sra          s1, s7, t6
                  mulhsu       a1, gp, a0
                  c.li         gp, -1
                  srai         s11, a5, 6
                  sltiu        t6, sp, 205
                  c.li         gp, -1
                  sra          s1, s7, t6
                  c.nop
                  c.addi16sp   sp, 384
                  remu         s9, a2, t1
                  c.xor        a2, a5
                  c.xor        a2, a5
                  c.addi4spn   a1, sp, 480
                  sltiu        t6, sp, 205
                  c.li         gp, -1
                  slli         t0, zero, 18
                  addi         s11, s11, -143
                  c.mv         s6, sp
                  c.addi16sp   sp, 384
                  c.nop
                  lui          t4, 172841
                  srli         tp, ra, 29
                  slti         s6, tp, 996
                  auipc        zero, 631536
                  rem          s8, t3, s11
                  c.addi       s5, -1
                  auipc        zero, 631536
                  c.and        a1, a3
                  c.xor        a2, a5
                  auipc        zero, 631536
                  c.nop
                  addi         s11, s11, -143
                  xori         t0, t6, -1239
                  add          s2, gp, s8
                  c.addi       s5, -1
                  xori         t0, t6, -1239
                  lui          t4, 172841
                  mulh         t4, s3, s10
                  and          a1, s3, s0
                  sltu         t1, a6, a2
                  c.lui        t2, 18
                  or           s8, s8, t2
                  c.xor        a2, a5
                  xori         t0, t6, -1239
                  rem          s8, t3, s11
                  mulhu        s5, t3, zero
                  add          s2, gp, s8
                  c.srai       s1, 8
                  nop
                  div          s8, ra, a4
                  mul          s11, a6, a7
                  div          s8, ra, a4
                  mulhu        s5, t3, zero
                  auipc        zero, 631536
                  mulhsu       a1, gp, a0
                  lui          t4, 172841
                  mul          s11, a6, a7
                  c.mv         s6, sp
                  remu         s9, a2, t1
                  andi         s6, a4, 204
                  slt          s6, s6, gp
                  sltiu        t6, sp, 205
                  c.or         a2, a3
                  c.or         a2, a3
                  and          a1, s3, s0
                  mulhsu       a1, gp, a0
                  c.or         a2, a3
                  sltu         t1, a6, a2
                  mulhu        s5, t3, zero
                  mulh         t4, s3, s10
                  c.srai       s1, 8
                  c.or         a2, a3
                  c.addi       s5, -1
                  sltiu        t6, sp, 205
                  c.xor        a2, a5
                  c.xor        a2, a5
                  c.lui        t2, 18
                  mulh         t4, s3, s10
                  c.lui        t2, 18
                  c.and        a1, a3
                  addi         s11, s11, -143
                  c.addi16sp   sp, 384
                  c.lui        t2, 18
                  mulhu        s5, t3, zero
                  c.srli       s1, 18
                  c.addi       s5, -1
                  c.add        ra, a0
                  srai         s11, a5, 6
                  c.add        ra, a0
                  srai         s11, a5, 6
                  srli         tp, ra, 29
                  ori          s1, a7, 303
                  slli         t0, zero, 18
                  xor          s5, s7, t6
                  c.lui        t2, 18
                  addi         s11, s11, -143
                  slti         s6, tp, 996
                  xori         t0, t6, -1239
                  xori         t0, t6, -1239
                  slt          s6, s6, gp
                  rem          s8, t3, s11
                  sltiu        t6, sp, 205
                  c.lui        t2, 18
                  c.addi4spn   a1, sp, 480
                  mul          s11, a6, a7
                  add          s2, gp, s8
                  and          a1, s3, s0
                  srl          a6, s8, s9
                  addi         s11, s11, -143
                  c.srli       s1, 18
                  mulh         t4, s3, s10
                  c.sub        s0, s0
                  mulh         t4, s3, s10
                  c.add        ra, a0
                  srl          a6, s8, s9
                  c.addi16sp   sp, 384
                  c.nop
                  mulhsu       a1, gp, a0
                  c.addi       s5, -1
                  srai         s11, a5, 6
                  addi         s11, s11, -143
                  c.addi4spn   a1, sp, 480
                  div          s8, ra, a4
                  c.srli       s1, 18
                  auipc        zero, 631536
                  mulhu        s5, t3, zero
                  c.nop
                  srai         s11, a5, 6
                  sltiu        t6, sp, 205
                  xori         t0, t6, -1239
                  c.nop
                  slti         s6, tp, 996
                  rem          s8, t3, s11
                  xor          s5, s7, t6
                  remu         s9, a2, t1
                  c.srai       s1, 8
                  c.addi16sp   sp, 384
                  c.mv         s6, sp
                  and          a1, s3, s0
                  srl          a6, s8, s9
                  mulhu        s5, t3, zero
                  mulhsu       a1, gp, a0
                  slt          s6, s6, gp
                  and          a1, s3, s0
                  c.mv         s6, sp
                  sltiu        t6, sp, 205
                  xori         t0, t6, -1239
                  sltiu        t6, sp, 205
                  c.mv         s6, sp
                  xor          s5, s7, t6
                  mulhsu       a1, gp, a0
                  c.nop
                  or           s8, s8, t2
                  c.and        a1, a3
                  c.nop
                  or           s8, s8, t2
                  remu         s9, a2, t1
                  auipc        zero, 631536
                  xor          s5, s7, t6
                  ori          s1, a7, 303
                  slti         s6, tp, 996
                  xor          s5, s7, t6
                  c.srli       s1, 18
                  c.sub        s0, s0
                  sub          t3, a0, t2
                  c.li         gp, -1
                  sltiu        t6, sp, 205
                  srli         tp, ra, 29
                  slt          s6, s6, gp
                  slli         t0, zero, 18
                  mulhu        s5, t3, zero
                  c.xor        a2, a5
                  c.or         a2, a3
                  c.mv         s6, sp
                  xor          s5, s7, t6
                  c.lui        t2, 18
                  xor          s5, s7, t6
                  addi         s11, s11, -143
                  div          s8, ra, a4
                  c.li         gp, -1
                  c.mv         s6, sp
                  c.addi16sp   sp, 384
                  xor          s5, s7, t6
                  div          s8, ra, a4
                  c.mv         s6, sp
                  slti         s6, tp, 996
                  sll          a2, t6, tp
                  c.slli       a5, 14
                  c.and        a1, a3
                  add          s2, gp, s8
                  div          s8, ra, a4
                  c.srai       s1, 8
                  slt          s6, s6, gp
                  or           s8, s8, t2
                  c.srli       s1, 18
                  div          s8, ra, a4
                  c.xor        a2, a5
                  divu         sp, t2, s2
                  andi         s6, a4, 204
                  c.slli       a5, 14
                  sra          s1, s7, t6
                  c.sub        s0, s0
                  addi         s11, s11, -143
                  c.lui        t2, 18
                  mulhsu       a1, gp, a0
                  c.addi16sp   sp, 384
                  mulhsu       a1, gp, a0
                  c.slli       a5, 14
                  c.nop
                  nop
                  mulhu        s5, t3, zero
                  slt          s6, s6, gp
                  c.and        a1, a3
                  sra          s1, s7, t6
                  addi         s11, s11, -143
                  slti         s6, tp, 996
                  lui          t4, 172841
                  c.addi4spn   a1, sp, 480
                  c.and        a1, a3
                  auipc        zero, 631536
                  c.li         gp, -1
                  ori          s1, a7, 303
                  c.li         gp, -1
                  slti         s6, tp, 996
                  c.addi4spn   a1, sp, 480
                  xori         t0, t6, -1239
                  c.xor        a2, a5
                  sltu         t1, a6, a2
                  c.addi16sp   sp, 384
                  c.xor        a2, a5
                  rem          s8, t3, s11
                  lui          t4, 172841
                  mul          s11, a6, a7
                  and          a1, s3, s0
                  mulhu        s5, t3, zero
                  c.mv         s6, sp
                  c.li         gp, -1
                  c.lui        t2, 18
                  addi         s11, s11, -143
                  slt          s6, s6, gp
                  sll          a2, t6, tp
                  auipc        zero, 631536
                  lui          t4, 172841
                  c.add        ra, a0
                  slti         s6, tp, 996
                  c.addi16sp   sp, 384
                  srli         tp, ra, 29
                  c.srai       s1, 8
                  and          a1, s3, s0
                  sra          s1, s7, t6
                  auipc        zero, 631536
                  sll          a2, t6, tp
                  nop
                  c.addi4spn   a1, sp, 480
                  ori          s1, a7, 303
                  c.srai       s1, 8
                  c.and        a1, a3
                  nop
                  rem          s8, t3, s11
                  c.sub        s0, s0
                  c.add        ra, a0
                  xor          s5, s7, t6
                  remu         s9, a2, t1
                  lui          t4, 172841
                  nop
                  c.li         gp, -1
                  c.addi16sp   sp, 384
                  slti         s6, tp, 996
                  nop
                  c.slli       a5, 14
                  sub          t3, a0, t2
                  rem          s8, t3, s11
                  c.addi       s5, -1
                  c.lui        t2, 18
                  c.slli       a5, 14
                  c.addi4spn   a1, sp, 480
                  div          s8, ra, a4
                  or           s8, s8, t2
                  c.sub        s0, s0
                  mulhsu       a1, gp, a0
                  sll          a2, t6, tp
                  slti         s6, tp, 996
                  c.mv         s6, sp
                  xor          s5, s7, t6
                  c.add        ra, a0
                  c.andi       s0, -1
                  c.xor        a2, a5
                  add          s2, gp, s8
                  slt          s6, s6, gp
                  sll          a2, t6, tp
                  c.srai       s1, 8
                  c.slli       a5, 14
                  and          a1, s3, s0
                  ori          s1, a7, 303
                  and          a1, s3, s0
                  rem          s8, t3, s11
                  srli         tp, ra, 29
                  c.andi       s0, -1
                  sltiu        t6, sp, 205
                  add          s2, gp, s8
                  mulh         t4, s3, s10
                  slt          s6, s6, gp
                  c.addi       s5, -1
                  c.nop
                  slt          s6, s6, gp
                  c.srli       s1, 18
                  mulhsu       a1, gp, a0
                  or           s8, s8, t2
                  srli         tp, ra, 29
                  sltu         t1, a6, a2
                  lui          t4, 172841
                  srli         tp, ra, 29
                  c.addi16sp   sp, 384
                  ori          s1, a7, 303
                  add          s2, gp, s8
                  sll          a2, t6, tp
                  c.xor        a2, a5
                  c.mv         s6, sp
                  rem          s8, t3, s11
                  c.mv         s6, sp
                  sltu         t1, a6, a2
                  slti         s6, tp, 996
                  mul          s11, a6, a7
                  xor          s5, s7, t6
                  c.andi       s0, -1
                  slt          s6, s6, gp
                  slti         s6, tp, 996
                  sub          t3, a0, t2
                  c.sub        s0, s0
                  sltiu        t6, sp, 205
                  lui          t4, 172841
                  or           s8, s8, t2
                  c.srli       s1, 18
                  addi         s11, s11, -143
                  c.mv         s6, sp
                  rem          s8, t3, s11
                  xor          s5, s7, t6
                  c.or         a2, a3
                  c.add        ra, a0
                  c.andi       s0, -1
                  slt          s6, s6, gp
                  c.srli       s1, 18
                  remu         s9, a2, t1
                  mulhsu       a1, gp, a0
                  or           s8, s8, t2
                  c.mv         s6, sp
                  slli         t0, zero, 18
                  mulhsu       a1, gp, a0
                  and          a1, s3, s0
                  sll          a2, t6, tp
                  c.nop
                  sltiu        t6, sp, 205
                  nop
                  srai         s11, a5, 6
                  rem          s8, t3, s11
                  xor          s5, s7, t6
                  srl          a6, s8, s9
                  c.nop
                  slli         t0, zero, 18
                  slt          s6, s6, gp
                  sll          a2, t6, tp
                  auipc        zero, 631536
                  c.lui        t2, 18
                  andi         s6, a4, 204
                  c.addi4spn   a1, sp, 480
                  c.addi       s5, -1
                  c.lui        t2, 18
                  divu         sp, t2, s2
                  andi         s6, a4, 204
                  srli         tp, ra, 29
                  div          s8, ra, a4
                  addi         s11, s11, -143
                  add          s2, gp, s8
                  mulhu        s5, t3, zero
                  c.add        ra, a0
                  srl          a6, s8, s9
                  sub          t3, a0, t2
                  mulhu        s5, t3, zero
                  c.xor        a2, a5
                  c.sub        s0, s0
                  mulhu        s5, t3, zero
                  sll          a2, t6, tp
                  divu         sp, t2, s2
                  sub          t3, a0, t2
                  c.mv         s6, sp
                  addi         s11, s11, -143
                  c.or         a2, a3
                  sll          a2, t6, tp
                  xori         t0, t6, -1239
                  andi         s6, a4, 204
                  add          s2, gp, s8
                  andi         s6, a4, 204
                  sra          s1, s7, t6
                  rem          s8, t3, s11
                  mulh         t4, s3, s10
                  auipc        zero, 631536
                  c.andi       s0, -1
                  c.nop
                  c.lui        t2, 18
                  remu         s9, a2, t1
                  srai         s11, a5, 6
                  mul          s11, a6, a7
                  remu         s9, a2, t1
                  c.mv         s6, sp
                  div          s8, ra, a4
                  xor          s5, s7, t6
                  sll          a2, t6, tp
                  add          s2, gp, s8
                  c.nop
                  c.nop
                  xor          s5, s7, t6
                  xori         t0, t6, -1239
                  c.srai       s1, 8
                  c.srai       s1, 8
                  srli         tp, ra, 29
                  srl          a6, s8, s9
                  or           s8, s8, t2
                  mulhsu       a1, gp, a0
                  srl          a6, s8, s9
                  sra          s1, s7, t6
                  xor          s5, s7, t6
                  auipc        zero, 631536
                  or           s8, s8, t2
                  addi         s11, s11, -143
                  sub          t3, a0, t2
                  c.srli       s1, 18
                  remu         s9, a2, t1
                  c.addi4spn   a1, sp, 480
                  c.xor        a2, a5
                  c.mv         s6, sp
                  c.srai       s1, 8
                  c.addi4spn   a1, sp, 480
                  srli         tp, ra, 29
                  rem          s8, t3, s11
                  c.and        a1, a3
                  mulhu        s5, t3, zero
                  c.mv         s6, sp
                  mulhsu       a1, gp, a0
                  xori         t0, t6, -1239
                  lui          t4, 172841
                  andi         s6, a4, 204
                  c.xor        a2, a5
                  c.lui        t2, 18
                  srl          a6, s8, s9
                  srai         s11, a5, 6
                  c.and        a1, a3
                  andi         s6, a4, 204
                  slti         s6, tp, 996
                  slli         t0, zero, 18
                  auipc        zero, 631536
                  c.and        a1, a3
                  sub          t3, a0, t2
                  nop
                  mulh         t4, s3, s10
                  add          s2, gp, s8
                  divu         sp, t2, s2
                  c.andi       s0, -1
                  sub          t3, a0, t2
                  lui          t4, 172841
                  srai         s11, a5, 6
                  sra          s1, s7, t6
                  remu         s9, a2, t1
                  sra          s1, s7, t6
                  divu         sp, t2, s2
                  srai         s11, a5, 6
                  c.lui        t2, 18
                  ori          s1, a7, 303
                  c.add        ra, a0
                  slti         s6, tp, 996
                  c.xor        a2, a5
                  c.sub        s0, s0
                  slt          s6, s6, gp
                  c.srli       s1, 18
                  c.addi16sp   sp, 384
                  or           s8, s8, t2
                  c.srai       s1, 8
                  xori         t0, t6, -1239
                  srai         s11, a5, 6
                  c.addi       s5, -1
                  slli         t0, zero, 18
                  lui          t4, 172841
                  c.addi4spn   a1, sp, 480
                  c.srli       s1, 18
                  c.and        a1, a3
                  sra          s1, s7, t6
                  c.add        ra, a0
                  srl          a6, s8, s9
                  sll          a2, t6, tp
                  mulhsu       a1, gp, a0
                  c.or         a2, a3
                  c.or         a2, a3
                  slli         t0, zero, 18
                  c.andi       s0, -1
                  c.sub        s0, s0
                  mulhu        s5, t3, zero
                  ori          s1, a7, 303
                  c.andi       s0, -1
                  srai         s11, a5, 6
                  or           s8, s8, t2
                  c.mv         s6, sp
                  c.mv         s6, sp
                  c.andi       s0, -1
                  c.mv         s6, sp
                  c.addi16sp   sp, 384
                  c.srai       s1, 8
                  c.addi4spn   a1, sp, 480
                  or           s8, s8, t2
                  c.nop
                  divu         sp, t2, s2
                  andi         s6, a4, 204
                  c.li         gp, -1
                  c.slli       a5, 14
                  slli         t0, zero, 18
                  div          s8, ra, a4
                  add          s2, gp, s8
                  mulh         t4, s3, s10
                  remu         s9, a2, t1
                  div          s8, ra, a4
                  c.addi       s5, -1
                  c.xor        a2, a5
                  rem          s8, t3, s11
                  slt          s6, s6, gp
                  sltu         t1, a6, a2
                  div          s8, ra, a4
                  c.addi       s5, -1
                  c.sub        s0, s0
                  and          a1, s3, s0
                  ori          s1, a7, 303
                  lui          t4, 172841
                  mulh         t4, s3, s10
                  c.xor        a2, a5
                  c.or         a2, a3
                  sra          s1, s7, t6
                  c.andi       s0, -1
                  addi         s11, s11, -143
                  mulh         t4, s3, s10
                  div          s8, ra, a4
                  mulhsu       a1, gp, a0
                  sltu         t1, a6, a2
                  div          s8, ra, a4
                  c.andi       s0, -1
                  c.nop
                  c.mv         s6, sp
                  slli         t0, zero, 18
                  c.or         a2, a3
                  andi         s6, a4, 204
                  c.add        ra, a0
                  sltu         t1, a6, a2
                  c.lui        t2, 18
                  lui          t4, 172841
                  xori         t0, t6, -1239
                  sub          t3, a0, t2
                  sll          a2, t6, tp
                  srai         s11, a5, 6
                  c.slli       a5, 14
                  c.slli       a5, 14
                  remu         s9, a2, t1
                  c.lui        t2, 18
                  slt          s6, s6, gp
                  c.add        ra, a0
                  srl          a6, s8, s9
                  srai         s11, a5, 6
                  mul          s11, a6, a7
                  c.addi4spn   a1, sp, 480
                  remu         s9, a2, t1
                  c.li         gp, -1
                  c.addi16sp   sp, 384
                  c.and        a1, a3
                  c.srai       s1, 8
                  sll          a2, t6, tp
                  c.mv         s6, sp
                  c.xor        a2, a5
                  c.mv         s6, sp
                  c.slli       a5, 14
                  sltiu        t6, sp, 205
                  auipc        zero, 631536
                  and          a1, s3, s0
                  c.li         gp, -1
                  add          s2, gp, s8
                  addi         s11, s11, -143
                  srai         s11, a5, 6
                  c.xor        a2, a5
                  remu         s9, a2, t1
                  c.mv         s6, sp
                  slt          s6, s6, gp
                  ori          s1, a7, 303
                  nop
                  sub          t3, a0, t2
                  mul          s11, a6, a7
                  div          s8, ra, a4
                  addi         s11, s11, -143
                  c.nop
                  mulhsu       a1, gp, a0
                  c.srai       s1, 8
                  c.addi16sp   sp, 384
                  auipc        zero, 631536
                  c.andi       s0, -1
                  and          a1, s3, s0
                  sltu         t1, a6, a2
                  c.srli       s1, 18
                  mulhu        s5, t3, zero
                  and          a1, s3, s0
                  slti         s6, tp, 996
                  sltiu        t6, sp, 205
                  c.andi       s0, -1
                  c.srai       s1, 8
                  andi         s6, a4, 204
                  mulhsu       a1, gp, a0
                  c.or         a2, a3
                  andi         s6, a4, 204
                  c.andi       s0, -1
                  and          a1, s3, s0
                  mul          s11, a6, a7
                  divu         sp, t2, s2
                  c.or         a2, a3
                  c.xor        a2, a5
                  sll          a2, t6, tp
                  srai         s11, a5, 6
                  c.slli       a5, 14
                  c.addi       s5, -1
                  c.xor        a2, a5
                  div          s8, ra, a4
                  auipc        zero, 631536
                  xori         t0, t6, -1239
                  add          s2, gp, s8
                  slti         s6, tp, 996
                  div          s8, ra, a4
                  mulhu        s5, t3, zero
                  srai         s11, a5, 6
                  c.mv         s6, sp
                  add          s2, gp, s8
                  add          s2, gp, s8
                  xori         t0, t6, -1239
                  mul          s11, a6, a7
                  c.srai       s1, 8
                  c.addi4spn   a1, sp, 480
                  c.and        a1, a3
                  slt          s6, s6, gp
                  lui          t4, 172841
                  add          s2, gp, s8
                  c.srli       s1, 18
                  c.slli       a5, 14
                  sra          s1, s7, t6
                  xori         t0, t6, -1239
                  ori          s1, a7, 303
                  add          s2, gp, s8
                  nop
                  sub          t3, a0, t2
                  xor          s5, s7, t6
                  c.slli       a5, 14
                  mul          s11, a6, a7
                  c.lui        t2, 18
                  mulh         t4, s3, s10
                  andi         s6, a4, 204
                  auipc        zero, 631536
                  mulhsu       a1, gp, a0
                  c.srai       s1, 8
                  ori          s1, a7, 303
                  c.mv         s6, sp
                  slli         t0, zero, 18
                  andi         s6, a4, 204
                  sll          a2, t6, tp
                  mulhu        s5, t3, zero
                  c.addi4spn   a1, sp, 480
                  mul          s11, a6, a7
                  rem          s8, t3, s11
                  sll          a2, t6, tp
                  and          a1, s3, s0
                  srli         tp, ra, 29
                  addi         s11, s11, -143
                  ori          s1, a7, 303
                  c.srai       s1, 8
                  mulh         t4, s3, s10
                  and          a1, s3, s0
                  c.addi4spn   a1, sp, 480
                  slt          s6, s6, gp
                  sltu         t1, a6, a2
                  c.nop
                  c.srai       s1, 8
                  c.lui        t2, 18
                  sra          s1, s7, t6
                  mulhu        s5, t3, zero
                  sltiu        t6, sp, 205
                  sltu         t1, a6, a2
                  mulhu        s5, t3, zero
                  and          a1, s3, s0
                  c.slli       a5, 14
                  c.andi       s0, -1
                  sltiu        t6, sp, 205
                  mulhsu       a1, gp, a0
                  xori         t0, t6, -1239
                  remu         s9, a2, t1
                  or           s8, s8, t2
                  slti         s6, tp, 996
                  divu         sp, t2, s2
                  lui          t4, 172841
                  div          s8, ra, a4
                  sltiu        t6, sp, 205
                  divu         sp, t2, s2
                  sra          s1, s7, t6
                  c.mv         s6, sp
                  sub          t3, a0, t2
                  c.mv         s6, sp
                  sll          a2, t6, tp
                  c.andi       s0, -1
                  mul          s11, a6, a7
                  c.lui        t2, 18
                  divu         sp, t2, s2
                  c.mv         s6, sp
                  divu         sp, t2, s2
                  xori         t0, t6, -1239
                  srli         tp, ra, 29
                  sra          s1, s7, t6
                  sub          t3, a0, t2
                  c.slli       a5, 14
                  sra          s1, s7, t6
                  sltu         t1, a6, a2
                  sltu         t1, a6, a2
                  add          s2, gp, s8
                  c.addi       s5, -1
                  div          s8, ra, a4
                  xori         t0, t6, -1239
                  slti         s6, tp, 996
                  c.nop
                  lui          t4, 172841
                  remu         s9, a2, t1
                  rem          s8, t3, s11
                  c.srli       s1, 18
                  sll          a2, t6, tp
                  add          s2, gp, s8
                  auipc        zero, 631536
                  sltiu        t6, sp, 205
                  add          s2, gp, s8
                  sra          s1, s7, t6
                  srl          a6, s8, s9
                  c.addi       s5, -1
                  div          s8, ra, a4
                  rem          s8, t3, s11
                  or           s8, s8, t2
                  mul          s11, a6, a7
                  c.mv         s6, sp
                  srl          a6, s8, s9
                  srl          a6, s8, s9
                  sra          s1, s7, t6
                  c.li         gp, -1
                  sub          t3, a0, t2
                  c.or         a2, a3
                  c.srli       s1, 18
                  and          a1, s3, s0
                  sll          a2, t6, tp
                  nop
                  add          s2, gp, s8
                  divu         sp, t2, s2
                  sll          a2, t6, tp
                  slli         t0, zero, 18
                  or           s8, s8, t2
                  c.sub        s0, s0
                  c.addi       s5, -1
                  addi         s11, s11, -143
                  c.xor        a2, a5
                  c.or         a2, a3
                  slli         t0, zero, 18
                  mulhu        s5, t3, zero
                  slti         s6, tp, 996
                  c.add        ra, a0
                  lui          t4, 172841
                  xor          s5, s7, t6
                  c.addi       s5, -1
                  c.add        ra, a0
                  c.xor        a2, a5
                  c.addi4spn   a1, sp, 480
                  slt          s6, s6, gp
                  c.addi       s5, -1
                  addi         s11, s11, -143
                  and          a1, s3, s0
                  c.addi16sp   sp, 384
                  srli         tp, ra, 29
                  remu         s9, a2, t1
                  slti         s6, tp, 996
                  nop
                  c.nop
                  addi         s11, s11, -143
                  srai         s11, a5, 6
                  c.nop
                  c.li         gp, -1
                  add          s2, gp, s8
                  ori          s1, a7, 303
                  c.slli       a5, 14
                  nop
                  andi         s6, a4, 204
                  c.li         gp, -1
                  slti         s6, tp, 996
                  sltiu        t6, sp, 205
                  c.andi       s0, -1
                  c.andi       s0, -1
                  or           s8, s8, t2
                  c.lui        t2, 18
                  c.and        a1, a3
                  mulh         t4, s3, s10
                  srai         s11, a5, 6
                  sltu         t1, a6, a2
                  nop
                  c.mv         s6, sp
                  xori         t0, t6, -1239
                  slli         t0, zero, 18
                  srai         s11, a5, 6
                  div          s8, ra, a4
                  mulhsu       a1, gp, a0
                  mulhsu       a1, gp, a0
                  ori          s1, a7, 303
                  srl          a6, s8, s9
                  c.andi       s0, -1
                  xor          s5, s7, t6
                  mulh         t4, s3, s10
                  slti         s6, tp, 996
                  remu         s9, a2, t1
                  srl          a6, s8, s9
                  mulh         t4, s3, s10
                  mulhsu       a1, gp, a0
                  c.mv         s6, sp
                  add          s2, gp, s8
                  slti         s6, tp, 996
                  xori         t0, t6, -1239
                  or           s8, s8, t2
                  addi         s11, s11, -143
                  xor          s5, s7, t6
                  c.add        ra, a0
                  sll          a2, t6, tp
                  slt          s6, s6, gp
                  srl          a6, s8, s9
                  c.addi4spn   a1, sp, 480
                  srli         tp, ra, 29
                  c.srli       s1, 18
                  mulh         t4, s3, s10
                  c.slli       a5, 14
                  c.addi16sp   sp, 384
                  ori          s1, a7, 303
                  slti         s6, tp, 996
                  sltu         t1, a6, a2
                  sltiu        t6, sp, 205
                  c.lui        t2, 18
                  c.xor        a2, a5
                  c.srai       s1, 8
                  c.mv         s6, sp
                  c.addi       s5, -1
                  div          s8, ra, a4
                  auipc        zero, 631536
                  c.slli       a5, 14
                  andi         s6, a4, 204
                  c.addi4spn   a1, sp, 480
                  c.srai       s1, 8
                  c.slli       a5, 14
                  divu         sp, t2, s2
                  c.mv         s6, sp
                  sll          a2, t6, tp
                  c.addi16sp   sp, 384
                  mul          s11, a6, a7
                  srai         s11, a5, 6
                  addi         s11, s11, -143
                  remu         s9, a2, t1
                  sltu         t1, a6, a2
                  c.li         gp, -1
                  c.addi16sp   sp, 384
                  xori         t0, t6, -1239
                  sll          a2, t6, tp
                  add          s2, gp, s8
                  c.li         gp, -1
                  rem          s8, t3, s11
                  c.srai       s1, 8
                  slti         s6, tp, 996
                  c.andi       s0, -1
                  slli         t0, zero, 18
                  mulhu        s5, t3, zero
                  c.addi16sp   sp, 384
                  sltiu        t6, sp, 205
                  c.li         gp, -1
                  sll          a2, t6, tp
                  c.nop
                  c.addi4spn   a1, sp, 480
                  ori          s1, a7, 303
                  c.sub        s0, s0
                  mulhsu       a1, gp, a0
                  divu         sp, t2, s2
                  c.addi4spn   a1, sp, 480
                  sltiu        t6, sp, 205
                  andi         s6, a4, 204
                  c.li         gp, -1
                  mulhu        s5, t3, zero
                  or           s8, s8, t2
                  auipc        zero, 631536
                  rem          s8, t3, s11
                  lui          t4, 172841
                  mul          s11, a6, a7
                  ori          s1, a7, 303
                  srli         tp, ra, 29
                  or           s8, s8, t2
                  mulhsu       a1, gp, a0
                  c.mv         s6, sp
                  mul          s11, a6, a7
                  andi         s6, a4, 204
                  or           s8, s8, t2
                  addi         s11, s11, -143
                  c.sub        s0, s0
                  c.lui        t2, 18
                  c.li         gp, -1
                  mulhsu       a1, gp, a0
                  c.addi       s5, -1
                  c.li         gp, -1
                  c.mv         s6, sp
                  slt          s6, s6, gp
                  and          a1, s3, s0
                  srli         tp, ra, 29
                  or           s8, s8, t2
                  sltu         t1, a6, a2
                  div          s8, ra, a4
                  c.add        ra, a0
                  lui          t4, 172841
                  mul          s11, a6, a7
                  srli         tp, ra, 29
                  mulhsu       a1, gp, a0
                  andi         s6, a4, 204
                  divu         sp, t2, s2
                  addi         s11, s11, -143
                  c.lui        t2, 18
                  slli         t0, zero, 18
                  sub          t3, a0, t2
                  divu         sp, t2, s2
                  divu         sp, t2, s2
                  ori          s1, a7, 303
                  srli         tp, ra, 29
                  div          s8, ra, a4
                  lui          t4, 172841
                  addi         s11, s11, -143
                  sll          a2, t6, tp
                  srai         s11, a5, 6
                  c.srli       s1, 18
                  andi         s6, a4, 204
                  lui          t4, 172841
                  c.addi4spn   a1, sp, 480
                  c.add        ra, a0
                  c.mv         s6, sp
                  and          a1, s3, s0
                  sll          a2, t6, tp
                  slt          s6, s6, gp
                  and          a1, s3, s0
                  mulhsu       a1, gp, a0
                  nop
                  srli         tp, ra, 29
                  auipc        zero, 631536
                  sra          s1, s7, t6
                  c.srli       s1, 18
                  slli         t0, zero, 18
                  sltu         t1, a6, a2
                  c.nop
                  mul          s11, a6, a7
                  xor          s5, s7, t6
                  nop
                  or           s8, s8, t2
                  divu         sp, t2, s2
                  srli         tp, ra, 29
                  sra          s1, s7, t6
                  mulh         t4, s3, s10
                  c.add        ra, a0
                  c.and        a1, a3
                  srl          a6, s8, s9
                  srl          a6, s8, s9
                  auipc        zero, 631536
                  srli         tp, ra, 29
                  srai         s11, a5, 6
                  c.and        a1, a3
                  c.xor        a2, a5
                  andi         s6, a4, 204
                  add          s2, gp, s8
                  c.nop
                  lui          t4, 172841
                  xor          s5, s7, t6
                  divu         sp, t2, s2
                  c.sub        s0, s0
                  sll          a2, t6, tp
                  nop
                  xor          s5, s7, t6
                  andi         s6, a4, 204
                  sll          a2, t6, tp
                  div          s8, ra, a4
                  andi         s6, a4, 204
                  c.xor        a2, a5
                  sll          a2, t6, tp
                  c.xor        a2, a5
                  c.or         a2, a3
                  slti         s6, tp, 996
                  sltiu        t6, sp, 205
                  slli         t0, zero, 18
                  c.add        ra, a0
                  c.lui        t2, 18
                  c.nop
                  mul          s11, a6, a7
                  xori         t0, t6, -1239
                  div          s8, ra, a4
                  c.xor        a2, a5
                  c.or         a2, a3
                  slti         s6, tp, 996
                  add          s2, gp, s8
                  c.addi16sp   sp, 384
                  sra          s1, s7, t6
                  slti         s6, tp, 996
                  c.xor        a2, a5
                  srl          a6, s8, s9
                  c.li         gp, -1
                  sltiu        t6, sp, 205
                  xori         t0, t6, -1239
                  sub          t3, a0, t2
                  c.xor        a2, a5
                  sra          s1, s7, t6
                  c.lui        t2, 18
                  divu         sp, t2, s2
                  c.addi       s5, -1
                  c.andi       s0, -1
                  c.and        a1, a3
                  c.and        a1, a3
                  srai         s11, a5, 6
                  c.and        a1, a3
                  li           a2, 0xffffffff #start riscv_int_numeric_corner_stream_9
                  li           a5, 0xdf99a8bd
                  li           s9, 0xffffffff
                  li           t6, 0x80000000
                  li           a1, 0x80000000
                  li           gp, 0xdbf19ca3
                  li           t5, 0x80000000
                  li           sp, 0xf0e6457
                  li           s1, 0xffffffff
                  li           s3, 0xffffffff
                  add          sp, a1, t5
                  mulhsu       s9, a1, a2
                  auipc        sp, 631536
                  auipc        sp, 631536
                  addi         t5, a5, -143
                  lui          t6, 172841
                  addi         t5, a5, -143
                  mul          t5, sp, gp
                  mul          t5, sp, gp
                  add          sp, a1, t5
                  mulhu        s1, t5, sp
                  sub          t6, t6, s9
                  mulh         sp, a1, a5
                  sub          t6, t6, s9
                  divu         s1, s9, s1
                  mulhu        s1, t5, sp
                  divu         s1, s9, s1
                  mul          t5, sp, gp
                  div          a5, gp, t6 #end riscv_int_numeric_corner_stream_9
                  c.srai       s1, 8
                  mulh         t4, s3, s10
                  c.add        ra, a0
                  divu         sp, t2, s2
                  c.addi4spn   a1, sp, 480
                  auipc        zero, 631536
                  slti         s6, tp, 996
                  nop
                  c.addi16sp   sp, 384
                  sll          a2, t6, tp
                  sra          s1, s7, t6
                  c.sub        s0, s0
                  srai         s11, a5, 6
                  slli         t0, zero, 18
                  divu         sp, t2, s2
                  sll          a2, t6, tp
                  rem          s8, t3, s11
                  slti         s6, tp, 996
                  c.add        ra, a0
                  xor          s5, s7, t6
                  slti         s6, tp, 996
                  c.xor        a2, a5
                  ori          s1, a7, 303
                  ori          s1, a7, 303
                  sll          a2, t6, tp
                  c.lui        t2, 18
                  srli         tp, ra, 29
                  c.and        a1, a3
                  c.xor        a2, a5
                  slli         t0, zero, 18
                  mulhu        s5, t3, zero
                  xori         t0, t6, -1239
                  srai         s11, a5, 6
                  auipc        zero, 631536
                  andi         s6, a4, 204
                  c.lui        t2, 18
                  andi         s6, a4, 204
                  sll          a2, t6, tp
                  auipc        zero, 631536
                  mulh         t4, s3, s10
                  c.mv         s6, sp
                  c.and        a1, a3
                  c.li         gp, -1
                  c.and        a1, a3
                  c.andi       s0, -1
                  c.addi4spn   a1, sp, 480
                  remu         s9, a2, t1
                  andi         s6, a4, 204
                  c.addi16sp   sp, 384
                  remu         s9, a2, t1
                  c.add        ra, a0
                  auipc        zero, 631536
                  rem          s8, t3, s11
                  c.xor        a2, a5
                  xori         t0, t6, -1239
                  auipc        zero, 631536
                  divu         sp, t2, s2
                  lui          t4, 172841
                  andi         s6, a4, 204
                  or           s8, s8, t2
                  addi         s11, s11, -143
                  or           s8, s8, t2
                  srli         tp, ra, 29
                  and          a1, s3, s0
                  ori          s1, a7, 303
                  c.lui        t2, 18
                  and          a1, s3, s0
                  c.mv         s6, sp
                  slti         s6, tp, 996
                  sltiu        t6, sp, 205
                  srai         s11, a5, 6
                  andi         s6, a4, 204
                  mul          s11, a6, a7
                  xor          s5, s7, t6
                  and          a1, s3, s0
                  c.addi       s5, -1
                  c.mv         s6, sp
                  c.andi       s0, -1
                  ori          s1, a7, 303
                  xori         t0, t6, -1239
                  mul          s11, a6, a7
                  slt          s6, s6, gp
                  auipc        zero, 631536
                  sltiu        t6, sp, 205
                  c.sub        s0, s0
                  c.sub        s0, s0
                  c.srli       s1, 18
                  sll          a2, t6, tp
                  c.addi4spn   a1, sp, 480
                  andi         s6, a4, 204
                  mulh         t4, s3, s10
                  c.andi       s0, -1
                  srl          a6, s8, s9
                  mulh         t4, s3, s10
                  xori         t0, t6, -1239
                  lui          t4, 172841
                  c.lui        t2, 18
                  sra          s1, s7, t6
                  rem          s8, t3, s11
                  slti         s6, tp, 996
                  rem          s8, t3, s11
                  c.addi       s5, -1
                  divu         sp, t2, s2
                  rem          s8, t3, s11
                  c.nop
                  srli         tp, ra, 29
                  slli         t0, zero, 18
                  c.sub        s0, s0
                  slt          s6, s6, gp
                  divu         sp, t2, s2
                  c.addi16sp   sp, 384
                  c.srli       s1, 18
                  div          s8, ra, a4
                  divu         sp, t2, s2
                  srai         s11, a5, 6
                  srai         s11, a5, 6
                  c.li         gp, -1
                  srai         s11, a5, 6
                  mulh         t4, s3, s10
                  c.nop
                  sub          t3, a0, t2
                  remu         s9, a2, t1
                  xori         t0, t6, -1239
                  rem          s8, t3, s11
                  remu         s9, a2, t1
                  c.srai       s1, 8
                  or           s8, s8, t2
                  andi         s6, a4, 204
                  c.li         gp, -1
                  c.add        ra, a0
                  divu         sp, t2, s2
                  c.and        a1, a3
                  srl          a6, s8, s9
                  xori         t0, t6, -1239
                  mulhu        s5, t3, zero
                  sltu         t1, a6, a2
                  c.and        a1, a3
                  c.addi16sp   sp, 384
                  c.li         gp, -1
                  remu         s9, a2, t1
                  c.andi       s0, -1
                  c.li         gp, -1
                  sra          s1, s7, t6
                  rem          s8, t3, s11
                  xori         t0, t6, -1239
                  sltiu        t6, sp, 205
                  c.lui        t2, 18
                  mulhu        s5, t3, zero
                  mulhu        s5, t3, zero
                  slli         t0, zero, 18
                  c.andi       s0, -1
                  divu         sp, t2, s2
                  sll          a2, t6, tp
                  slti         s6, tp, 996
                  c.xor        a2, a5
                  srli         tp, ra, 29
                  c.add        ra, a0
                  c.xor        a2, a5
                  srl          a6, s8, s9
                  mul          s11, a6, a7
                  slti         s6, tp, 996
                  c.srli       s1, 18
                  c.srai       s1, 8
                  c.lui        t2, 18
                  xori         t0, t6, -1239
                  slli         t0, zero, 18
                  and          a1, s3, s0
                  srli         tp, ra, 29
                  c.andi       s0, -1
                  c.xor        a2, a5
                  mul          s11, a6, a7
                  c.and        a1, a3
                  c.andi       s0, -1
                  c.srai       s1, 8
                  c.addi16sp   sp, 384
                  rem          s8, t3, s11
                  mulhu        s5, t3, zero
                  ori          s1, a7, 303
                  c.and        a1, a3
                  sltiu        t6, sp, 205
                  c.srli       s1, 18
                  nop
                  nop
                  mulhu        s5, t3, zero
                  auipc        zero, 631536
                  auipc        zero, 631536
                  remu         s9, a2, t1
                  remu         s9, a2, t1
                  or           s8, s8, t2
                  and          a1, s3, s0
                  sra          s1, s7, t6
                  c.srai       s1, 8
                  c.addi       s5, -1
                  auipc        zero, 631536
                  rem          s8, t3, s11
                  ori          s1, a7, 303
                  c.srai       s1, 8
                  c.andi       s0, -1
                  mulhu        s5, t3, zero
                  slti         s6, tp, 996
                  mulh         t4, s3, s10
                  mulhsu       a1, gp, a0
                  mulhsu       a1, gp, a0
                  c.sub        s0, s0
                  c.sub        s0, s0
                  mulh         t4, s3, s10
                  add          s2, gp, s8
                  c.srli       s1, 18
                  xori         t0, t6, -1239
                  sltu         t1, a6, a2
                  c.mv         s6, sp
                  mulhu        s5, t3, zero
                  c.lui        t2, 18
                  c.mv         s6, sp
                  c.and        a1, a3
                  sltiu        t6, sp, 205
                  c.srli       s1, 18
                  c.addi       s5, -1
                  auipc        zero, 631536
                  srai         s11, a5, 6
                  add          s2, gp, s8
                  sltu         t1, a6, a2
                  xori         t0, t6, -1239
                  c.xor        a2, a5
                  srli         tp, ra, 29
                  sra          s1, s7, t6
                  sub          t3, a0, t2
                  xor          s5, s7, t6
                  slti         s6, tp, 996
                  add          s2, gp, s8
                  slli         t0, zero, 18
                  mul          s11, a6, a7
                  c.slli       a5, 14
                  mul          s11, a6, a7
                  c.addi       s5, -1
                  c.slli       a5, 14
                  c.andi       s0, -1
                  xor          s5, s7, t6
                  mulh         t4, s3, s10
                  c.add        ra, a0
                  div          s8, ra, a4
                  and          a1, s3, s0
                  c.srli       s1, 18
                  c.addi16sp   sp, 384
                  c.mv         s6, sp
                  c.nop
                  xori         t0, t6, -1239
                  c.srli       s1, 18
                  nop
                  or           s8, s8, t2
                  mulh         t4, s3, s10
                  sltiu        t6, sp, 205
                  mulh         t4, s3, s10
                  c.mv         s6, sp
                  xori         t0, t6, -1239
                  c.addi       s5, -1
                  divu         sp, t2, s2
                  c.andi       s0, -1
                  c.andi       s0, -1
                  mulhsu       a1, gp, a0
                  nop
                  addi         s11, s11, -143
                  c.add        ra, a0
                  c.srli       s1, 18
                  c.nop
                  c.xor        a2, a5
                  c.addi       s5, -1
                  c.addi       s5, -1
                  c.xor        a2, a5
                  and          a1, s3, s0
                  ori          s1, a7, 303
                  sra          s1, s7, t6
                  nop
                  c.slli       a5, 14
                  mulhu        s5, t3, zero
                  sltiu        t6, sp, 205
                  c.slli       a5, 14
                  c.addi16sp   sp, 384
                  sll          a2, t6, tp
                  c.srli       s1, 18
                  slli         t0, zero, 18
                  c.and        a1, a3
                  c.slli       a5, 14
                  remu         s9, a2, t1
                  mul          s11, a6, a7
                  divu         sp, t2, s2
                  c.add        ra, a0
                  c.addi16sp   sp, 384
                  slti         s6, tp, 996
                  c.addi16sp   sp, 384
                  c.sub        s0, s0
                  c.or         a2, a3
                  c.addi16sp   sp, 384
                  xori         t0, t6, -1239
                  c.and        a1, a3
                  add          s2, gp, s8
                  and          a1, s3, s0
                  or           s8, s8, t2
                  sltu         t1, a6, a2
                  sll          a2, t6, tp
                  c.and        a1, a3
                  mulhsu       a1, gp, a0
                  sub          t3, a0, t2
                  c.andi       s0, -1
                  c.andi       s0, -1
                  slli         t0, zero, 18
                  remu         s9, a2, t1
                  addi         s11, s11, -143
                  auipc        zero, 631536
                  c.or         a2, a3
                  div          s8, ra, a4
                  c.nop
                  c.li         gp, -1
                  c.srai       s1, 8
                  auipc        zero, 631536
                  c.nop
                  c.srli       s1, 18
                  c.li         gp, -1
                  nop
                  and          a1, s3, s0
                  ori          s1, a7, 303
                  xori         t0, t6, -1239
                  srai         s11, a5, 6
                  sll          a2, t6, tp
                  srai         s11, a5, 6
                  lui          t4, 172841
                  mulh         t4, s3, s10
                  srl          a6, s8, s9
                  c.and        a1, a3
                  mul          s11, a6, a7
                  lui          t4, 172841
                  auipc        zero, 631536
                  xor          s5, s7, t6
                  rem          s8, t3, s11
                  c.srai       s1, 8
                  slli         t0, zero, 18
                  mulhu        s5, t3, zero
                  mul          s11, a6, a7
                  c.slli       a5, 14
                  sra          s1, s7, t6
                  andi         s6, a4, 204
                  slli         t0, zero, 18
                  c.addi16sp   sp, 384
                  slt          s6, s6, gp
                  c.addi4spn   a1, sp, 480
                  lui          t4, 172841
                  mul          s11, a6, a7
                  sub          t3, a0, t2
                  sub          t3, a0, t2
                  mul          s11, a6, a7
                  rem          s8, t3, s11
                  mulhu        s5, t3, zero
                  sll          a2, t6, tp
                  c.nop
                  sltiu        t6, sp, 205
                  c.srli       s1, 18
                  xori         t0, t6, -1239
                  mulhsu       a1, gp, a0
                  lui          t4, 172841
                  c.nop
                  slli         t0, zero, 18
                  c.addi       s5, -1
                  c.srai       s1, 8
                  remu         s9, a2, t1
                  slti         s6, tp, 996
                  mulhsu       a1, gp, a0
                  slt          s6, s6, gp
                  ori          s1, a7, 303
                  andi         s6, a4, 204
                  c.sub        s0, s0
                  sltu         t1, a6, a2
                  add          s2, gp, s8
                  sltiu        t6, sp, 205
                  c.srli       s1, 18
                  mulhsu       a1, gp, a0
                  xor          s5, s7, t6
                  andi         s6, a4, 204
                  c.addi16sp   sp, 384
                  srl          a6, s8, s9
                  c.li         gp, -1
                  c.srli       s1, 18
                  andi         s6, a4, 204
                  mulhsu       a1, gp, a0
                  la x14, test_done
                  jalr x0, x14, 0
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
                  addi x20, x20, -4
                  sw  x10, (x20)
                  add x10, x20, zero
                  addi x10, x10, -128
                  sw  x1, 4(x10)
                  sw  x2, 8(x10)
                  sw  x3, 12(x10)
                  sw  x4, 16(x10)
                  sw  x5, 20(x10)
                  sw  x6, 24(x10)
                  sw  x7, 28(x10)
                  sw  x8, 32(x10)
                  sw  x9, 36(x10)
                  sw  x10, 40(x10)
                  sw  x11, 44(x10)
                  sw  x12, 48(x10)
                  sw  x13, 52(x10)
                  sw  x14, 56(x10)
                  sw  x15, 60(x10)
                  sw  x16, 64(x10)
                  sw  x17, 68(x10)
                  sw  x18, 72(x10)
                  sw  x19, 76(x10)
                  sw  x20, 80(x10)
                  sw  x21, 84(x10)
                  sw  x22, 88(x10)
                  sw  x23, 92(x10)
                  sw  x24, 96(x10)
                  sw  x25, 100(x10)
                  sw  x26, 104(x10)
                  sw  x27, 108(x10)
                  sw  x28, 112(x10)
                  sw  x29, 116(x10)
                  sw  x30, 120(x10)
                  sw  x31, 124(x10)
                  add x20, x10, zero
                  csrr x25, 0x300 # MSTATUS
                  csrr x25, 0x342 # MCAUSE
                  srli x25, x25, 31
                  bne x25, x0, mmode_intr_handler

mmode_exception_handler:
                  csrr x25, 0x341 # MEPC
                  csrr x25, 0x342 # MCAUSE
                  li x30, 0x3 # BREAKPOINT
                  beq x25, x30, ebreak_handler
                  li x30, 0x8 # ECALL_UMODE
                  beq x25, x30, ecall_handler
                  li x30, 0x9 # ECALL_SMODE
                  beq x25, x30, ecall_handler
                  li x30, 0xb # ECALL_MMODE
                  beq x25, x30, ecall_handler
                  li x30, 0x1
                  beq x25, x30, instr_fault_handler
                  li x30, 0x5
                  beq x25, x30, load_fault_handler
                  li x30, 0x7
                  beq x25, x30, store_fault_handler
                  li x30, 0xc
                  beq x25, x30, pt_fault_handler
                  li x30, 0xd
                  beq x25, x30, pt_fault_handler
                  li x30, 0xf
                  beq x25, x30, pt_fault_handler
                  li x30, 0x2 # ILLEGAL_INSTRUCTION
                  beq x25, x30, illegal_instr_handler
                  csrr x30, 0x343 # MTVAL
                  1: la x14, test_done
                  jalr x1, x14, 0

ecall_handler:    
                  la x25, _start
                  sw x0, 0(x25)
                  sw x1, 4(x25)
                  sw x2, 8(x25)
                  sw x3, 12(x25)
                  sw x4, 16(x25)
                  sw x5, 20(x25)
                  sw x6, 24(x25)
                  sw x7, 28(x25)
                  sw x8, 32(x25)
                  sw x9, 36(x25)
                  sw x10, 40(x25)
                  sw x11, 44(x25)
                  sw x12, 48(x25)
                  sw x13, 52(x25)
                  sw x14, 56(x25)
                  sw x15, 60(x25)
                  sw x16, 64(x25)
                  sw x17, 68(x25)
                  sw x18, 72(x25)
                  sw x19, 76(x25)
                  sw x20, 80(x25)
                  sw x21, 84(x25)
                  sw x22, 88(x25)
                  sw x23, 92(x25)
                  sw x24, 96(x25)
                  sw x25, 100(x25)
                  sw x26, 104(x25)
                  sw x27, 108(x25)
                  sw x28, 112(x25)
                  sw x29, 116(x25)
                  sw x30, 120(x25)
                  sw x31, 124(x25)
                  la x14, write_tohost
                  jalr x0, x14, 0

instr_fault_handler:
                  add x10, x20, zero
                  lw  x1, 4(x10)
                  lw  x2, 8(x10)
                  lw  x3, 12(x10)
                  lw  x4, 16(x10)
                  lw  x5, 20(x10)
                  lw  x6, 24(x10)
                  lw  x7, 28(x10)
                  lw  x8, 32(x10)
                  lw  x9, 36(x10)
                  lw  x10, 40(x10)
                  lw  x11, 44(x10)
                  lw  x12, 48(x10)
                  lw  x13, 52(x10)
                  lw  x14, 56(x10)
                  lw  x15, 60(x10)
                  lw  x16, 64(x10)
                  lw  x17, 68(x10)
                  lw  x18, 72(x10)
                  lw  x19, 76(x10)
                  lw  x20, 80(x10)
                  lw  x21, 84(x10)
                  lw  x22, 88(x10)
                  lw  x23, 92(x10)
                  lw  x24, 96(x10)
                  lw  x25, 100(x10)
                  lw  x26, 104(x10)
                  lw  x27, 108(x10)
                  lw  x28, 112(x10)
                  lw  x29, 116(x10)
                  lw  x30, 120(x10)
                  lw  x31, 124(x10)
                  addi x10, x10, 128
                  add x20, x10, zero
                  lw  x10, (x20)
                  addi x20, x20, 4
                  mret

load_fault_handler:
                  add x10, x20, zero
                  lw  x1, 4(x10)
                  lw  x2, 8(x10)
                  lw  x3, 12(x10)
                  lw  x4, 16(x10)
                  lw  x5, 20(x10)
                  lw  x6, 24(x10)
                  lw  x7, 28(x10)
                  lw  x8, 32(x10)
                  lw  x9, 36(x10)
                  lw  x10, 40(x10)
                  lw  x11, 44(x10)
                  lw  x12, 48(x10)
                  lw  x13, 52(x10)
                  lw  x14, 56(x10)
                  lw  x15, 60(x10)
                  lw  x16, 64(x10)
                  lw  x17, 68(x10)
                  lw  x18, 72(x10)
                  lw  x19, 76(x10)
                  lw  x20, 80(x10)
                  lw  x21, 84(x10)
                  lw  x22, 88(x10)
                  lw  x23, 92(x10)
                  lw  x24, 96(x10)
                  lw  x25, 100(x10)
                  lw  x26, 104(x10)
                  lw  x27, 108(x10)
                  lw  x28, 112(x10)
                  lw  x29, 116(x10)
                  lw  x30, 120(x10)
                  lw  x31, 124(x10)
                  addi x10, x10, 128
                  add x20, x10, zero
                  lw  x10, (x20)
                  addi x20, x20, 4
                  mret

store_fault_handler:
                  add x10, x20, zero
                  lw  x1, 4(x10)
                  lw  x2, 8(x10)
                  lw  x3, 12(x10)
                  lw  x4, 16(x10)
                  lw  x5, 20(x10)
                  lw  x6, 24(x10)
                  lw  x7, 28(x10)
                  lw  x8, 32(x10)
                  lw  x9, 36(x10)
                  lw  x10, 40(x10)
                  lw  x11, 44(x10)
                  lw  x12, 48(x10)
                  lw  x13, 52(x10)
                  lw  x14, 56(x10)
                  lw  x15, 60(x10)
                  lw  x16, 64(x10)
                  lw  x17, 68(x10)
                  lw  x18, 72(x10)
                  lw  x19, 76(x10)
                  lw  x20, 80(x10)
                  lw  x21, 84(x10)
                  lw  x22, 88(x10)
                  lw  x23, 92(x10)
                  lw  x24, 96(x10)
                  lw  x25, 100(x10)
                  lw  x26, 104(x10)
                  lw  x27, 108(x10)
                  lw  x28, 112(x10)
                  lw  x29, 116(x10)
                  lw  x30, 120(x10)
                  lw  x31, 124(x10)
                  addi x10, x10, 128
                  add x20, x10, zero
                  lw  x10, (x20)
                  addi x20, x20, 4
                  mret

ebreak_handler:   
                  csrr  x25, 0x341
                  addi  x25, x25, 4
                  csrw  0x341, x25
                  add x10, x20, zero
                  lw  x1, 4(x10)
                  lw  x2, 8(x10)
                  lw  x3, 12(x10)
                  lw  x4, 16(x10)
                  lw  x5, 20(x10)
                  lw  x6, 24(x10)
                  lw  x7, 28(x10)
                  lw  x8, 32(x10)
                  lw  x9, 36(x10)
                  lw  x10, 40(x10)
                  lw  x11, 44(x10)
                  lw  x12, 48(x10)
                  lw  x13, 52(x10)
                  lw  x14, 56(x10)
                  lw  x15, 60(x10)
                  lw  x16, 64(x10)
                  lw  x17, 68(x10)
                  lw  x18, 72(x10)
                  lw  x19, 76(x10)
                  lw  x20, 80(x10)
                  lw  x21, 84(x10)
                  lw  x22, 88(x10)
                  lw  x23, 92(x10)
                  lw  x24, 96(x10)
                  lw  x25, 100(x10)
                  lw  x26, 104(x10)
                  lw  x27, 108(x10)
                  lw  x28, 112(x10)
                  lw  x29, 116(x10)
                  lw  x30, 120(x10)
                  lw  x31, 124(x10)
                  addi x10, x10, 128
                  add x20, x10, zero
                  lw  x10, (x20)
                  addi x20, x20, 4
                  mret

illegal_instr_handler:
                  csrr  x25, 0x341
                  addi  x25, x25, 4
                  csrw  0x341, x25
                  add x10, x20, zero
                  lw  x1, 4(x10)
                  lw  x2, 8(x10)
                  lw  x3, 12(x10)
                  lw  x4, 16(x10)
                  lw  x5, 20(x10)
                  lw  x6, 24(x10)
                  lw  x7, 28(x10)
                  lw  x8, 32(x10)
                  lw  x9, 36(x10)
                  lw  x10, 40(x10)
                  lw  x11, 44(x10)
                  lw  x12, 48(x10)
                  lw  x13, 52(x10)
                  lw  x14, 56(x10)
                  lw  x15, 60(x10)
                  lw  x16, 64(x10)
                  lw  x17, 68(x10)
                  lw  x18, 72(x10)
                  lw  x19, 76(x10)
                  lw  x20, 80(x10)
                  lw  x21, 84(x10)
                  lw  x22, 88(x10)
                  lw  x23, 92(x10)
                  lw  x24, 96(x10)
                  lw  x25, 100(x10)
                  lw  x26, 104(x10)
                  lw  x27, 108(x10)
                  lw  x28, 112(x10)
                  lw  x29, 116(x10)
                  lw  x30, 120(x10)
                  lw  x31, 124(x10)
                  addi x10, x10, 128
                  add x20, x10, zero
                  lw  x10, (x20)
                  addi x20, x20, 4
                  mret

pt_fault_handler: 
                  nop

.align 2
mmode_intr_handler:
                  csrr  x25, 0x300 # MSTATUS;
                  csrr  x25, 0x304 # MIE;
                  csrr  x25, 0x344 # MIP;
                  csrrc x25, 0x344, x25 # MIP;
                  add x10, x20, zero
                  lw  x1, 4(x10)
                  lw  x2, 8(x10)
                  lw  x3, 12(x10)
                  lw  x4, 16(x10)
                  lw  x5, 20(x10)
                  lw  x6, 24(x10)
                  lw  x7, 28(x10)
                  lw  x8, 32(x10)
                  lw  x9, 36(x10)
                  lw  x10, 40(x10)
                  lw  x11, 44(x10)
                  lw  x12, 48(x10)
                  lw  x13, 52(x10)
                  lw  x14, 56(x10)
                  lw  x15, 60(x10)
                  lw  x16, 64(x10)
                  lw  x17, 68(x10)
                  lw  x18, 72(x10)
                  lw  x19, 76(x10)
                  lw  x20, 80(x10)
                  lw  x21, 84(x10)
                  lw  x22, 88(x10)
                  lw  x23, 92(x10)
                  lw  x24, 96(x10)
                  lw  x25, 100(x10)
                  lw  x26, 104(x10)
                  lw  x27, 108(x10)
                  lw  x28, 112(x10)
                  lw  x29, 116(x10)
                  lw  x30, 120(x10)
                  lw  x31, 124(x10)
                  addi x10, x10, 128
                  add x20, x10, zero
                  lw  x10, (x20)
                  addi x20, x20, 4
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
