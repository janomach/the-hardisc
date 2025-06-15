.include "user_define.h"
.globl _start
.section .text
_start:           
                  .include "user_init.s"
                  csrr x5, 0xf14
                  li x6, 0
                  beq x5, x6, 0f

0: la x23, h0_start
jalr x0, x23, 0
h0_start:
                  li x8, 0x40001104
                  csrw 0x301, x8
kernel_sp:        
                  la x22, kernel_stack_end

trap_vec_init:    
                  la x8, mtvec_handler
                  ori x8, x8, 0
                  csrw 0x305, x8 # MTVEC

mepc_setup:       
                  la x8, init
                  csrw 0x341, x8

custom_csr_setup: 
                  nop

init_machine_mode:
                  li x8, 0x1800
                  csrw 0x300, x8 # MSTATUS
                  li x8, 0x0
                  csrw 0x304, x8 # MIE
                  mret
init:             
                  li x0, 0x0
                  li x1, 0x80000000
                  li x2, 0xf18992ca
                  li x3, 0x9
                  li x4, 0xf5e132fc
                  li x5, 0x4b4fb838
                  li x6, 0xfd7008d3
                  li x7, 0x0
                  li x8, 0x39e91677
                  li x9, 0x80000000
                  li x10, 0xf3d75a65
                  li x11, 0x0
                  li x12, 0x0
                  li x13, 0x9
                  li x14, 0x80000000
                  li x15, 0x912273c2
                  li x16, 0x7
                  li x17, 0x77f363da
                  li x18, 0x92f1c7c0
                  li x19, 0xfbf871c4
                  li x20, 0x0
                  li x21, 0x3
                  li x23, 0xc
                  li x24, 0x0
                  li x25, 0x80000000
                  li x26, 0xf51e8881
                  li x27, 0xca54f052
                  li x29, 0x6c29adca
                  li x30, 0xf6571d24
                  li x31, 0x0
                  la x28, user_stack_end
main:             li           a6, 0xffffffff #start riscv_int_numeric_corner_stream_5
                  li           a2, 0x80000000
                  li           t2, 0xffffffff
                  li           s4, 0xffffffff
                  li           s2, 0x3460dc97
                  li           t5, 0x80000000
                  li           s1, 0xffffffff
                  li           a4, 0x80000000
                  li           t0, 0x80000000
                  li           s8, 0x0
                  sub          s1, t2, t0
                  auipc        s4, 95018
                  div          s1, s1, a6
                  div          s1, s1, a6
                  mulhu        t0, s4, t0
                  divu         t5, a4, a2
                  rem          a2, a6, a2
                  remu         a6, s1, a6
                  lui          s1, 494335
                  nop
                  addi         a2, t0, 639
                  nop
                  mulh         a4, s4, s8
                  mulhu        t0, s4, t0
                  div          s1, s1, a6 #end riscv_int_numeric_corner_stream_5
                  li           s8, 0xffffffff #start riscv_int_numeric_corner_stream_4
                  li           s11, 0xffffffff
                  li           a4, 0xffffffff
                  li           s5, 0x80000000
                  li           t1, 0xffffffff
                  li           s10, 0x0
                  li           t5, 0xffffffff
                  li           ra, 0x0
                  li           a6, 0x5e1b42f1
                  li           s0, 0x80000000
                  mulhu        ra, s10, ra
                  add          a6, s10, s11
                  mul          s11, s5, s5
                  auipc        s10, 95018
                  mul          s11, s5, s5
                  nop
                  addi         a4, ra, 639
                  mulh         a6, s10, s11
                  mul          s11, s5, s5
                  lui          s0, 494335
                  mulhsu       a4, a6, t1
                  lui          s0, 494335
                  mulhsu       a4, a6, t1
                  nop
                  mulh         a6, s10, s11
                  mulhsu       a4, a6, t1
                  mulh         a6, s10, s11
                  lui          s0, 494335
                  mulhu        ra, s10, ra
                  mulhu        ra, s10, ra
                  rem          a4, s5, a4
                  add          a6, s10, s11
                  addi         a4, ra, 639
                  remu         s5, s0, s5
                  rem          a4, s5, a4
                  lui          s0, 494335
                  auipc        s10, 95018 #end riscv_int_numeric_corner_stream_4
                  li           s8, 0xffffffff #start riscv_int_numeric_corner_stream_18
                  li           t5, 0xea8711fa
                  li           t4, 0xffffffff
                  li           s11, 0xce9dc056
                  li           s2, 0x80000000
                  li           ra, 0xffffffff
                  li           t1, 0x80000000
                  li           a5, 0x80000000
                  li           s5, 0xab9685e8
                  li           a1, 0x80000000
                  remu         s5, a1, s5
                  div          a1, a1, s5
                  remu         s5, a1, s5
                  lui          a1, 494335
                  mulh         s2, s11, t4
                  auipc        s11, 95018
                  auipc        s11, 95018
                  add          s2, s11, t4
                  lui          a1, 494335
                  div          a1, a1, s5
                  mulh         s2, s11, t4
                  nop
                  div          a1, a1, s5
                  div          a1, a1, s5
                  divu         t5, s2, a5
                  divu         t5, s2, a5
                  rem          a5, s5, a5
                  divu         t5, s2, a5
                  mulhu        ra, s11, ra
                  rem          a5, s5, a5
                  add          s2, s11, t4
                  auipc        s11, 95018
                  sub          a1, t1, ra
                  mulhsu       a5, s2, t1
                  mul          t4, s5, s5
                  auipc        s11, 95018
                  mulhsu       a5, s2, t1
                  add          s2, s11, t4
                  add          s2, s11, t4
                  rem          a5, s5, a5 #end riscv_int_numeric_corner_stream_18
                  li           s1, 0x0 #start riscv_int_numeric_corner_stream_26
                  li           a2, 0xffffffff
                  li           a3, 0xc29558b
                  li           a1, 0xffffffff
                  li           s0, 0x1dc93f55
                  li           a0, 0xffffffff
                  li           s2, 0xffffffff
                  li           t6, 0x78f750ee
                  li           t1, 0x73537afd
                  li           sp, 0xffffffff
                  remu         a1, s0, a1
                  auipc        a3, 95018
                  rem          s1, a1, s1
                  mul          s2, a1, a1
                  sub          s0, t1, sp
                  mul          s2, a1, a1
                  remu         a1, s0, a1
                  rem          s1, a1, s1
                  mulhu        sp, a3, sp
                  add          a0, a3, s2
                  add          a0, a3, s2
                  mul          s2, a1, a1
                  addi         s1, sp, 639
                  add          a0, a3, s2
                  auipc        a3, 95018
                  lui          s0, 494335
                  mulhsu       s1, a0, t1
                  add          a0, a3, s2 #end riscv_int_numeric_corner_stream_26
                  li           s4, 0x80000000 #start riscv_int_numeric_corner_stream_7
                  li           sp, 0x8a4c91c
                  li           a7, 0x0
                  li           t1, 0xffffffff
                  li           t2, 0x80000000
                  li           a2, 0x0
                  li           s8, 0x0
                  li           a3, 0x6f25c516
                  li           s10, 0x80000000
                  li           t4, 0xffffffff
                  addi         a2, sp, 639
                  mulhsu       a2, a3, t1
                  nop
                  auipc        s8, 95018
                  lui          t2, 494335
                  mul          s10, a7, a7
                  auipc        s8, 95018
                  mulhsu       a2, a3, t1
                  mul          s10, a7, a7
                  div          t2, t2, a7
                  lui          t2, 494335
                  mul          s10, a7, a7
                  rem          a2, a7, a2
                  mulhu        sp, s8, sp
                  remu         a7, t2, a7
                  sub          t2, t1, sp
                  mul          s10, a7, a7 #end riscv_int_numeric_corner_stream_7
                  li           s1, 0x80000000 #start riscv_int_numeric_corner_stream_37
                  li           a4, 0x25786118
                  li           s2, 0xa649144e
                  li           ra, 0xd798f9e6
                  li           t2, 0x0
                  li           s4, 0x80000000
                  li           a5, 0x0
                  li           s9, 0x4beaa271
                  li           s11, 0x0
                  li           s10, 0xffffffff
                  remu         s2, s1, s2
                  rem          a4, s2, a4
                  remu         s2, s1, s2
                  mulh         a5, s9, s10
                  rem          a4, s2, a4
                  auipc        s9, 95018
                  mulhsu       a4, a5, t2
                  mulhu        ra, s9, ra
                  mul          s10, s2, s2
                  mulh         a5, s9, s10
                  divu         s11, a5, a4
                  add          a5, s9, s10
                  mulh         a5, s9, s10
                  auipc        s9, 95018
                  remu         s2, s1, s2
                  mul          s10, s2, s2
                  sub          s1, t2, ra #end riscv_int_numeric_corner_stream_37
                  li           a1, 0x80000000 #start riscv_int_numeric_corner_stream_9
                  li           s9, 0xffffffff
                  li           s0, 0x80000000
                  li           tp, 0x80000000
                  li           s4, 0x0
                  li           s8, 0x0
                  li           a2, 0x0
                  li           sp, 0xa194b9c
                  li           a4, 0xf9a899d4
                  li           gp, 0x0
                  sub          tp, gp, sp
                  mul          s8, a2, a2
                  remu         a2, tp, a2
                  nop
                  lui          tp, 494335
                  addi         s0, sp, 639
                  mul          s8, a2, a2
                  mulhsu       s0, a1, gp
                  mul          s8, a2, a2
                  nop
                  addi         s0, sp, 639
                  addi         s0, sp, 639
                  sub          tp, gp, sp
                  nop
                  remu         a2, tp, a2
                  addi         s0, sp, 639
                  lui          tp, 494335
                  mulh         a1, s4, s8
                  mul          s8, a2, a2
                  mulhsu       s0, a1, gp
                  nop
                  add          a1, s4, s8
                  mul          s8, a2, a2 #end riscv_int_numeric_corner_stream_9
                  li           t5, 0x80000000 #start riscv_int_numeric_corner_stream_32
                  li           s9, 0xffffffff
                  li           ra, 0x80000000
                  li           a0, 0x80000000
                  li           tp, 0xffffffff
                  li           s5, 0xffffffff
                  li           t1, 0xffffffff
                  li           s8, 0xb3aa486b
                  li           a2, 0x80000000
                  li           sp, 0xbbbe22f7
                  auipc        s8, 95018
                  nop
                  rem          t1, a2, t1
                  addi         t1, ra, 639
                  mulhsu       t1, a0, sp
                  rem          t1, a2, t1
                  rem          t1, a2, t1
                  divu         t5, a0, t1
                  remu         a2, tp, a2
                  auipc        s8, 95018
                  add          a0, s8, s9
                  remu         a2, tp, a2
                  lui          tp, 494335
                  rem          t1, a2, t1
                  lui          tp, 494335
                  mulhu        ra, s8, ra
                  divu         t5, a0, t1
                  add          a0, s8, s9
                  auipc        s8, 95018
                  mul          s9, a2, a2
                  sub          tp, sp, ra
                  div          tp, tp, a2
                  divu         t5, a0, t1
                  remu         a2, tp, a2
                  div          tp, tp, a2
                  mul          s9, a2, a2
                  lui          tp, 494335 #end riscv_int_numeric_corner_stream_32
                  li           a1, 0x0 #start riscv_int_numeric_corner_stream_10
                  li           a5, 0x80000000
                  li           gp, 0x80000000
                  li           s10, 0xffffffff
                  li           sp, 0x80000000
                  li           a0, 0x80000000
                  li           t0, 0x114cda53
                  li           s0, 0x0
                  li           a7, 0xffffffff
                  li           ra, 0x80000000
                  sub          gp, sp, ra
                  mulh         s0, a5, a7
                  sub          gp, sp, ra
                  mulhsu       t0, s0, sp
                  addi         t0, ra, 639
                  remu         a0, gp, a0
                  mul          a7, a0, a0
                  mulhu        ra, a5, ra
                  nop
                  nop
                  rem          t0, a0, t0
                  sub          gp, sp, ra
                  mul          a7, a0, a0
                  mulh         s0, a5, a7
                  remu         a0, gp, a0
                  auipc        a5, 95018
                  add          s0, a5, a7
                  div          gp, gp, a0
                  mulh         s0, a5, a7
                  div          gp, gp, a0
                  divu         s10, s0, t0
                  add          s0, a5, a7
                  addi         t0, ra, 639
                  mulh         s0, a5, a7
                  mulh         s0, a5, a7
                  auipc        a5, 95018
                  mulhu        ra, a5, ra #end riscv_int_numeric_corner_stream_10
                  li           gp, 0xffffffff #start riscv_int_numeric_corner_stream_17
                  li           t2, 0x80000000
                  li           a7, 0x80000000
                  li           t0, 0x80000000
                  li           a3, 0x80000000
                  li           t5, 0xbe6c71d7
                  li           s2, 0xffffffff
                  li           s5, 0xffffffff
                  li           a2, 0xae5416a2
                  li           a1, 0xffffffff
                  mulhu        gp, s2, gp
                  auipc        s2, 95018
                  nop
                  div          t2, t2, a3
                  add          a2, s2, s5
                  sub          t2, t0, gp
                  addi         a1, gp, 639
                  div          t2, t2, a3
                  sub          t2, t0, gp
                  mulhsu       a1, a2, t0
                  mulhu        gp, s2, gp
                  auipc        s2, 95018
                  add          a2, s2, s5
                  rem          a1, a3, a1
                  mulhu        gp, s2, gp
                  mulh         a2, s2, s5
                  remu         a3, t2, a3
                  div          t2, t2, a3
                  mul          s5, a3, a3
                  remu         a3, t2, a3
                  div          t2, t2, a3
                  divu         t5, a2, a1
                  sub          t2, t0, gp
                  div          t2, t2, a3
                  nop #end riscv_int_numeric_corner_stream_17
                  li           a6, 0xffffffff #start riscv_int_numeric_corner_stream_6
                  li           a0, 0xffffffff
                  li           s3, 0xffffffff
                  li           t6, 0xffffffff
                  li           ra, 0xd91517b8
                  li           s8, 0xffffffff
                  li           s11, 0x0
                  li           s2, 0x80000000
                  li           gp, 0xca8805e0
                  li           t2, 0xffffffff
                  nop
                  nop
                  rem          a0, s2, a0
                  mulh         a6, s8, s11
                  remu         s2, t2, s2
                  mulhsu       a0, a6, gp
                  addi         a0, ra, 639
                  divu         t6, a6, a0
                  addi         a0, ra, 639
                  rem          a0, s2, a0
                  lui          t2, 494335
                  remu         s2, t2, s2
                  mulhsu       a0, a6, gp
                  mulh         a6, s8, s11
                  lui          t2, 494335
                  mulh         a6, s8, s11
                  auipc        s8, 95018
                  rem          a0, s2, a0
                  mulhu        ra, s8, ra
                  lui          t2, 494335
                  sub          t2, gp, ra
                  sub          t2, gp, ra
                  remu         s2, t2, s2
                  divu         t6, a6, a0
                  nop
                  mulhu        ra, s8, ra #end riscv_int_numeric_corner_stream_6
                  li           a5, 0xb5619a31 #start riscv_int_numeric_corner_stream_29
                  li           a6, 0xffffffff
                  li           t2, 0x0
                  li           gp, 0xb5821c49
                  li           t1, 0x80000000
                  li           sp, 0xffffffff
                  li           s5, 0x202ef08b
                  li           s9, 0x0
                  li           s0, 0x0
                  li           ra, 0xffffffff
                  remu         s0, gp, s0
                  nop
                  remu         s0, gp, s0
                  mulhsu       t1, t2, sp
                  mulhsu       t1, t2, sp
                  mul          s5, s0, s0
                  addi         t1, ra, 639
                  sub          gp, sp, ra
                  sub          gp, sp, ra
                  remu         s0, gp, s0
                  auipc        a6, 95018
                  div          gp, gp, s0
                  addi         t1, ra, 639
                  divu         s9, t2, t1
                  sub          gp, sp, ra
                  div          gp, gp, s0
                  auipc        a6, 95018
                  divu         s9, t2, t1
                  sub          gp, sp, ra
                  rem          t1, s0, t1
                  lui          gp, 494335
                  mulh         t2, a6, s5
                  auipc        a6, 95018
                  nop
                  add          t2, a6, s5
                  rem          t1, s0, t1
                  divu         s9, t2, t1
                  addi         t1, ra, 639
                  add          t2, a6, s5
                  auipc        a6, 95018 #end riscv_int_numeric_corner_stream_29
                  li           s2, 0x80000000 #start riscv_int_numeric_corner_stream_30
                  li           t4, 0xffffffff
                  li           a6, 0xffffffff
                  li           a4, 0x0
                  li           s0, 0xffffffff
                  li           a2, 0x9c357c4b
                  li           t5, 0x80000000
                  li           t6, 0xffffffff
                  li           tp, 0xbbe04fea
                  li           s3, 0x80000000
                  lui          a2, 494335
                  div          a2, a2, s2
                  mulhsu       a4, a6, s0
                  lui          a2, 494335
                  mul          t5, s2, s2
                  mulhsu       a4, a6, s0
                  mul          t5, s2, s2
                  mulhsu       a4, a6, s0
                  sub          a2, s0, tp
                  lui          a2, 494335
                  divu         t6, a6, a4
                  addi         a4, tp, 639
                  lui          a2, 494335
                  mulhsu       a4, a6, s0
                  mulhsu       a4, a6, s0
                  mulhu        tp, t4, tp
                  mulh         a6, t4, t5
                  mul          t5, s2, s2
                  rem          a4, s2, a4
                  auipc        t4, 95018 #end riscv_int_numeric_corner_stream_30
                  li           a6, 0x3e413c95 #start riscv_int_numeric_corner_stream_28
                  li           s4, 0x5d5409f1
                  li           a1, 0x0
                  li           t1, 0x2e506d2c
                  li           s8, 0x80000000
                  li           a0, 0x35265466
                  li           t5, 0xd93a9cce
                  li           s5, 0xffffffff
                  li           s0, 0xffffffff
                  li           a4, 0x88fc6bf3
                  mul          s8, a6, a6
                  mulhu        t1, s5, t1
                  nop
                  mulhu        t1, s5, t1
                  mulhsu       a1, a4, s0
                  div          a0, a0, a6
                  remu         a6, a0, a6
                  mul          s8, a6, a6
                  mulh         a4, s5, s8
                  mul          s8, a6, a6
                  div          a0, a0, a6
                  add          a4, s5, s8
                  remu         a6, a0, a6
                  auipc        s5, 95018
                  mulh         a4, s5, s8
                  div          a0, a0, a6
                  add          a4, s5, s8 #end riscv_int_numeric_corner_stream_28
                  li           sp, 0x0 #start riscv_int_numeric_corner_stream_36
                  li           s9, 0xffffffff
                  li           a6, 0x80000000
                  li           ra, 0x7abf3078
                  li           a2, 0x0
                  li           a1, 0x0
                  li           t4, 0x80000000
                  li           s4, 0x636ba444
                  li           s11, 0x8ed5a30f
                  li           s1, 0xad391029
                  div          s1, s1, a6
                  add          a2, s9, s11
                  mulhsu       a1, a2, sp
                  lui          s1, 494335
                  mulhsu       a1, a2, sp
                  nop
                  sub          s1, sp, ra
                  rem          a1, a6, a1
                  addi         a1, ra, 639
                  mul          s11, a6, a6
                  sub          s1, sp, ra
                  remu         a6, s1, a6
                  mulhu        ra, s9, ra
                  mul          s11, a6, a6
                  mulh         a2, s9, s11
                  divu         t4, a2, a1
                  rem          a1, a6, a1
                  addi         a1, ra, 639
                  mulhsu       a1, a2, sp #end riscv_int_numeric_corner_stream_36
                  li           a0, 0x80000000 #start riscv_int_numeric_corner_stream_15
                  li           a3, 0xffffffff
                  li           s5, 0x0
                  li           s3, 0xffffffff
                  li           gp, 0xd87b6e4b
                  li           sp, 0x80000000
                  li           t2, 0x78b5e574
                  li           s10, 0x0
                  li           t1, 0xb4c20fb9
                  li           s1, 0x80000000
                  auipc        s3, 95018
                  mulhsu       t2, s1, gp
                  mul          s5, a0, a0
                  div          t1, t1, a0
                  auipc        s3, 95018
                  mulhsu       t2, s1, gp
                  rem          t2, a0, t2
                  rem          t2, a0, t2
                  add          s1, s3, s5
                  nop
                  addi         t2, sp, 639
                  sub          t1, gp, sp
                  rem          t2, a0, t2
                  mulh         s1, s3, s5
                  nop
                  auipc        s3, 95018
                  nop
                  mul          s5, a0, a0
                  mulhu        sp, s3, sp
                  auipc        s3, 95018
                  nop #end riscv_int_numeric_corner_stream_15
                  li           s0, 0x0 #start riscv_int_numeric_corner_stream_27
                  li           sp, 0xffffffff
                  li           s1, 0x80000000
                  li           s8, 0x42842077
                  li           s10, 0x80000000
                  li           s2, 0x0
                  li           tp, 0x1589968b
                  li           a5, 0x80000000
                  li           a4, 0xffffffff
                  li           s3, 0x80000000
                  mulhu        sp, s3, sp
                  mulhsu       s1, a4, tp
                  rem          s1, a5, s1
                  div          s0, s0, a5
                  div          s0, s0, a5
                  sub          s0, tp, sp
                  mulhu        sp, s3, sp
                  mulhsu       s1, a4, tp
                  addi         s1, sp, 639
                  rem          s1, a5, s1
                  mul          s8, a5, a5
                  add          a4, s3, s8
                  divu         s10, a4, s1
                  mulhsu       s1, a4, tp
                  addi         s1, sp, 639
                  mul          s8, a5, a5
                  remu         a5, s0, a5
                  mul          s8, a5, a5
                  remu         a5, s0, a5
                  div          s0, s0, a5 #end riscv_int_numeric_corner_stream_27
                  li           t6, 0x16a09d86 #start riscv_int_numeric_corner_stream_24
                  li           a3, 0x80000000
                  li           s2, 0xeeecacce
                  li           a7, 0xffffffff
                  li           t0, 0xffffffff
                  li           s3, 0xffffffff
                  li           t5, 0x80000000
                  li           gp, 0xffffffff
                  li           t4, 0xffffffff
                  li           sp, 0xffffffff
                  divu         t6, a7, a3
                  lui          t0, 494335
                  lui          t0, 494335
                  mul          t5, s2, s2
                  mul          t5, s2, s2
                  rem          a3, s2, a3
                  auipc        t4, 95018
                  auipc        t4, 95018
                  lui          t0, 494335
                  divu         t6, a7, a3
                  add          a7, t4, t5
                  mulhu        sp, t4, sp
                  remu         s2, t0, s2
                  sub          t0, gp, sp
                  lui          t0, 494335
                  remu         s2, t0, s2
                  nop
                  mulhu        sp, t4, sp
                  mul          t5, s2, s2
                  remu         s2, t0, s2
                  mulhsu       a3, a7, gp
                  mulhu        sp, t4, sp
                  rem          a3, s2, a3
                  remu         s2, t0, s2
                  mulhsu       a3, a7, gp
                  div          t0, t0, s2
                  auipc        t4, 95018 #end riscv_int_numeric_corner_stream_24
                  li           t5, 0x80000000 #start riscv_int_numeric_corner_stream_2
                  li           s1, 0x80000000
                  li           sp, 0x0
                  li           s0, 0x80000000
                  li           t4, 0x80000000
                  li           s3, 0x0
                  li           a6, 0x17e61179
                  li           ra, 0xf9b5c6fe
                  li           t1, 0x80000000
                  li           a5, 0x3a9a414a
                  lui          t1, 494335
                  nop
                  divu         t5, s1, s0
                  nop
                  remu         a5, t1, a5
                  divu         t5, s1, s0
                  lui          t1, 494335
                  mul          t4, a5, a5
                  rem          s0, a5, s0
                  sub          t1, sp, ra
                  auipc        s3, 95018
                  divu         t5, s1, s0
                  remu         a5, t1, a5
                  mulhu        ra, s3, ra
                  divu         t5, s1, s0
                  lui          t1, 494335
                  mulh         s1, s3, t4
                  lui          t1, 494335
                  addi         s0, ra, 639
                  nop
                  nop
                  rem          s0, a5, s0
                  auipc        s3, 95018
                  add          s1, s3, t4
                  nop
                  mulhsu       s0, s1, sp
                  mulh         s1, s3, t4
                  addi         s0, ra, 639
                  rem          s0, a5, s0
                  divu         t5, s1, s0 #end riscv_int_numeric_corner_stream_2
                  li           t4, 0x621b6ded #start riscv_int_numeric_corner_stream_23
                  li           t1, 0x0
                  li           a3, 0x0
                  li           s1, 0x0
                  li           s2, 0x80000000
                  li           sp, 0x0
                  li           s3, 0xffffffff
                  li           a2, 0x80000000
                  li           s9, 0x4807ba06
                  li           s11, 0x0
                  mulhsu       a2, a3, t1
                  addi         a2, sp, 639
                  divu         t4, a3, a2
                  div          s1, s1, s2
                  mulhsu       a2, a3, t1
                  lui          s1, 494335
                  mulhsu       a2, a3, t1
                  divu         t4, a3, a2
                  mulhu        sp, s9, sp
                  divu         t4, a3, a2
                  divu         t4, a3, a2
                  rem          a2, s2, a2
                  divu         t4, a3, a2
                  addi         a2, sp, 639
                  rem          a2, s2, a2
                  mulhu        sp, s9, sp
                  rem          a2, s2, a2 #end riscv_int_numeric_corner_stream_23
                  c.addi4spn   a3, sp, 400
                  srl          a4, ra, s8
                  rem          s3, a2, a3
                  c.add        s4, a4
                  ori          a3, t5, 1088
                  and          s9, s5, a4
                  divu         s11, a1, gp
                  or           a5, a1, t6
                  sra          s2, t6, s1
                  addi         a5, a6, 639
                  c.slli       s5, 8
                  srl          a4, ra, s8
                  lui          a2, 494335
                  nop
                  c.srai       a0, 24
                  xori         s9, a6, -2048
                  slt          s3, a4, s5
                  c.nop
                  c.lui        a4, 9
                  c.nop
                  mulhu        a0, t2, zero
                  and          s9, s5, a4
                  mul          s0, t0, a0
                  c.sub        a0, a5
                  remu         t6, s2, s5
                  sltu         s1, s6, s7
                  c.or         s1, a0
                  divu         s11, a1, gp
                  slli         gp, s11, 27
                  c.xor        a3, a0
                  c.mv         a3, s10
                  mulhsu       a5, a0, s10
                  c.xor        a3, a0
                  mul          s0, t0, a0
                  c.andi       a5, 29
                  c.xor        a3, a0
                  srl          a4, ra, s8
                  or           a5, a1, t6
                  sltu         s1, s6, s7
                  mulhu        a0, t2, zero
                  and          s9, s5, a4
                  lui          a2, 494335
                  c.slli       s5, 8
                  c.addi16sp   sp, 464
                  c.add        s4, a4
                  add          tp, a2, s8
                  c.mv         a3, s10
                  nop
                  mul          s0, t0, a0
                  mulhu        a0, t2, zero
                  srai         s0, s4, 6
                  c.srai       a0, 24
                  divu         s11, a1, gp
                  c.li         ra, 9
                  sra          s2, t6, s1
                  and          s9, s5, a4
                  srl          a4, ra, s8
                  xor          a6, s1, sp
                  c.xor        a3, a0
                  c.or         s1, a0
                  c.lui        a4, 9
                  c.slli       s5, 8
                  and          s9, s5, a4
                  div          sp, s2, s5
                  c.sub        a0, a5
                  slti         s3, s5, -238
                  c.lui        a4, 9
                  slti         s3, s5, -238
                  c.xor        a3, a0
                  auipc        t6, 95018
                  c.lui        a4, 9
                  c.and        a2, a3
                  c.or         s1, a0
                  slli         gp, s11, 27
                  c.andi       a5, 29
                  srl          a4, ra, s8
                  c.lui        a4, 9
                  xori         s9, a6, -2048
                  c.add        s4, a4
                  c.li         ra, 9
                  mulhsu       a5, a0, s10
                  addi         a5, a6, 639
                  addi         a5, a6, 639
                  c.li         ra, 9
                  slt          s3, a4, s5
                  c.andi       a5, 29
                  c.addi       s1, -1
                  mulh         s4, s7, t5
                  addi         a5, a6, 639
                  srli         zero, ra, 0
                  c.lui        a4, 9
                  srli         zero, ra, 0
                  andi         t0, a0, -564
                  sltiu        a4, t2, -709
                  mul          s0, t0, a0
                  srai         s0, s4, 6
                  rem          s3, a2, a3
                  rem          s3, a2, a3
                  auipc        t6, 95018
                  c.nop
                  c.srli       a4, 11
                  c.li         ra, 9
                  nop
                  andi         t0, a0, -564
                  sub          sp, a4, a4
                  c.nop
                  sub          sp, a4, a4
                  c.sub        a0, a5
                  add          tp, a2, s8
                  slti         s3, s5, -238
                  nop
                  sltiu        a4, t2, -709
                  sll          a1, s6, s9
                  srli         zero, ra, 0
                  ori          a3, t5, 1088
                  c.li         ra, 9
                  and          s9, s5, a4
                  sub          sp, a4, a4
                  c.addi16sp   sp, 464
                  c.addi16sp   sp, 464
                  add          tp, a2, s8
                  slti         s3, s5, -238
                  divu         s11, a1, gp
                  c.sub        a0, a5
                  addi         a5, a6, 639
                  mulhu        a0, t2, zero
                  xori         s9, a6, -2048
                  ori          a3, t5, 1088
                  rem          s3, a2, a3
                  sll          a1, s6, s9
                  rem          s3, a2, a3
                  sltu         s1, s6, s7
                  slt          s3, a4, s5
                  slt          s3, a4, s5
                  c.lui        a4, 9
                  nop
                  nop
                  rem          s3, a2, a3
                  sltiu        a4, t2, -709
                  c.addi4spn   a3, sp, 400
                  rem          s3, a2, a3
                  sra          s2, t6, s1
                  c.add        s4, a4
                  c.andi       a5, 29
                  divu         s11, a1, gp
                  c.lui        a4, 9
                  mulh         s4, s7, t5
                  c.slli       s5, 8
                  mulh         s4, s7, t5
                  nop
                  addi         a5, a6, 639
                  c.nop
                  c.xor        a3, a0
                  c.addi16sp   sp, 464
                  xori         s9, a6, -2048
                  c.nop
                  add          tp, a2, s8
                  c.mv         a3, s10
                  remu         t6, s2, s5
                  nop
                  mulh         s4, s7, t5
                  and          s9, s5, a4
                  slti         s3, s5, -238
                  c.srai       a0, 24
                  c.mv         a3, s10
                  slti         s3, s5, -238
                  c.nop
                  sltu         s1, s6, s7
                  c.add        s4, a4
                  ori          a3, t5, 1088
                  slti         s3, s5, -238
                  xor          a6, s1, sp
                  lui          a2, 494335
                  c.addi4spn   a3, sp, 400
                  xor          a6, s1, sp
                  c.addi4spn   a3, sp, 400
                  mulhu        a0, t2, zero
                  c.srli       a4, 11
                  sra          s2, t6, s1
                  div          sp, s2, s5
                  srl          a4, ra, s8
                  srli         zero, ra, 0
                  srl          a4, ra, s8
                  sltiu        a4, t2, -709
                  div          sp, s2, s5
                  slt          s3, a4, s5
                  c.srli       a4, 11
                  remu         t6, s2, s5
                  slli         gp, s11, 27
                  slli         gp, s11, 27
                  addi         a5, a6, 639
                  ori          a3, t5, 1088
                  div          sp, s2, s5
                  mulhsu       a5, a0, s10
                  c.or         s1, a0
                  c.sub        a0, a5
                  slli         gp, s11, 27
                  c.lui        a4, 9
                  mulh         s4, s7, t5
                  andi         t0, a0, -564
                  c.srai       a0, 24
                  c.lui        a4, 9
                  addi         a5, a6, 639
                  c.andi       a5, 29
                  c.addi16sp   sp, 464
                  c.or         s1, a0
                  c.mv         a3, s10
                  c.add        s4, a4
                  c.li         ra, 9
                  c.and        a2, a3
                  sll          a1, s6, s9
                  c.addi       s1, -1
                  c.sub        a0, a5
                  mulhsu       a5, a0, s10
                  sra          s2, t6, s1
                  rem          s3, a2, a3
                  c.nop
                  c.mv         a3, s10
                  srl          a4, ra, s8
                  mulhsu       a5, a0, s10
                  xor          a6, s1, sp
                  sub          sp, a4, a4
                  remu         t6, s2, s5
                  c.sub        a0, a5
                  div          sp, s2, s5
                  mul          s0, t0, a0
                  lui          a2, 494335
                  c.nop
                  srli         zero, ra, 0
                  mulhsu       a5, a0, s10
                  sub          sp, a4, a4
                  c.li         ra, 9
                  slli         gp, s11, 27
                  nop
                  srai         s0, s4, 6
                  c.lui        a4, 9
                  or           a5, a1, t6
                  mul          s0, t0, a0
                  c.lui        a4, 9
                  c.or         s1, a0
                  c.or         s1, a0
                  sub          sp, a4, a4
                  slti         s3, s5, -238
                  c.mv         a3, s10
                  c.srai       a0, 24
                  mulhsu       a5, a0, s10
                  div          sp, s2, s5
                  c.addi16sp   sp, 464
                  add          tp, a2, s8
                  sll          a1, s6, s9
                  mulhsu       a5, a0, s10
                  c.li         ra, 9
                  sra          s2, t6, s1
                  c.sub        a0, a5
                  divu         s11, a1, gp
                  c.andi       a5, 29
                  addi         a5, a6, 639
                  c.andi       a5, 29
                  sltu         s1, s6, s7
                  slli         gp, s11, 27
                  c.add        s4, a4
                  c.addi16sp   sp, 464
                  srl          a4, ra, s8
                  slli         gp, s11, 27
                  mulh         s4, s7, t5
                  andi         t0, a0, -564
                  c.srli       a4, 11
                  c.srli       a4, 11
                  c.mv         a3, s10
                  c.andi       a5, 29
                  c.slli       s5, 8
                  sub          sp, a4, a4
                  addi         a5, a6, 639
                  srai         s0, s4, 6
                  mulh         s4, s7, t5
                  rem          s3, a2, a3
                  slt          s3, a4, s5
                  xori         s9, a6, -2048
                  c.slli       s5, 8
                  sll          a1, s6, s9
                  auipc        t6, 95018
                  sra          s2, t6, s1
                  c.or         s1, a0
                  xori         s9, a6, -2048
                  slli         gp, s11, 27
                  slt          s3, a4, s5
                  ori          a3, t5, 1088
                  slti         s3, s5, -238
                  c.slli       s5, 8
                  div          sp, s2, s5
                  c.or         s1, a0
                  xori         s9, a6, -2048
                  mulhsu       a5, a0, s10
                  divu         s11, a1, gp
                  div          sp, s2, s5
                  remu         t6, s2, s5
                  xor          a6, s1, sp
                  lui          a2, 494335
                  c.mv         a3, s10
                  slt          s3, a4, s5
                  slli         gp, s11, 27
                  mulhu        a0, t2, zero
                  srl          a4, ra, s8
                  nop
                  slt          s3, a4, s5
                  c.or         s1, a0
                  slli         gp, s11, 27
                  addi         a5, a6, 639
                  c.and        a2, a3
                  c.nop
                  c.srli       a4, 11
                  srli         zero, ra, 0
                  sltiu        a4, t2, -709
                  auipc        t6, 95018
                  div          sp, s2, s5
                  sub          sp, a4, a4
                  c.slli       s5, 8
                  c.and        a2, a3
                  c.lui        a4, 9
                  c.xor        a3, a0
                  mul          s0, t0, a0
                  remu         t6, s2, s5
                  c.nop
                  c.lui        a4, 9
                  mul          s0, t0, a0
                  ori          a3, t5, 1088
                  c.mv         a3, s10
                  addi         a5, a6, 639
                  c.nop
                  auipc        t6, 95018
                  c.addi4spn   a3, sp, 400
                  andi         t0, a0, -564
                  c.addi4spn   a3, sp, 400
                  xor          a6, s1, sp
                  sltiu        a4, t2, -709
                  mulh         s4, s7, t5
                  sub          sp, a4, a4
                  remu         t6, s2, s5
                  c.addi16sp   sp, 464
                  xori         s9, a6, -2048
                  rem          s3, a2, a3
                  c.slli       s5, 8
                  c.addi       s1, -1
                  remu         t6, s2, s5
                  c.lui        a4, 9
                  c.xor        a3, a0
                  slt          s3, a4, s5
                  srai         s0, s4, 6
                  c.srai       a0, 24
                  and          s9, s5, a4
                  divu         s11, a1, gp
                  nop
                  srai         s0, s4, 6
                  sll          a1, s6, s9
                  c.srli       a4, 11
                  sll          a1, s6, s9
                  xori         s9, a6, -2048
                  lui          a2, 494335
                  addi         a5, a6, 639
                  c.slli       s5, 8
                  sub          sp, a4, a4
                  c.li         ra, 9
                  c.or         s1, a0
                  ori          a3, t5, 1088
                  c.addi16sp   sp, 464
                  c.srli       a4, 11
                  lui          a2, 494335
                  remu         t6, s2, s5
                  srli         zero, ra, 0
                  xori         s9, a6, -2048
                  c.sub        a0, a5
                  c.mv         a3, s10
                  c.add        s4, a4
                  c.li         ra, 9
                  ori          a3, t5, 1088
                  remu         t6, s2, s5
                  c.addi       s1, -1
                  div          sp, s2, s5
                  slt          s3, a4, s5
                  c.lui        a4, 9
                  sra          s2, t6, s1
                  or           a5, a1, t6
                  and          s9, s5, a4
                  c.slli       s5, 8
                  xori         s9, a6, -2048
                  srli         zero, ra, 0
                  c.slli       s5, 8
                  rem          s3, a2, a3
                  andi         t0, a0, -564
                  addi         a5, a6, 639
                  srl          a4, ra, s8
                  c.addi       s1, -1
                  c.addi       s1, -1
                  sltiu        a4, t2, -709
                  sltiu        a4, t2, -709
                  div          sp, s2, s5
                  divu         s11, a1, gp
                  c.nop
                  add          tp, a2, s8
                  slt          s3, a4, s5
                  c.addi4spn   a3, sp, 400
                  xor          a6, s1, sp
                  or           a5, a1, t6
                  c.addi4spn   a3, sp, 400
                  c.or         s1, a0
                  c.mv         a3, s10
                  c.addi16sp   sp, 464
                  mulhsu       a5, a0, s10
                  remu         t6, s2, s5
                  c.addi4spn   a3, sp, 400
                  add          tp, a2, s8
                  mulhsu       a5, a0, s10
                  slti         s3, s5, -238
                  srli         zero, ra, 0
                  c.addi4spn   a3, sp, 400
                  c.andi       a5, 29
                  add          tp, a2, s8
                  mulhsu       a5, a0, s10
                  c.add        s4, a4
                  sll          a1, s6, s9
                  slli         gp, s11, 27
                  auipc        t6, 95018
                  slt          s3, a4, s5
                  remu         t6, s2, s5
                  rem          s3, a2, a3
                  div          sp, s2, s5
                  sub          sp, a4, a4
                  or           a5, a1, t6
                  c.srai       a0, 24
                  sub          sp, a4, a4
                  c.nop
                  lui          a2, 494335
                  auipc        t6, 95018
                  lui          a2, 494335
                  c.add        s4, a4
                  srl          a4, ra, s8
                  c.and        a2, a3
                  mulhsu       a5, a0, s10
                  rem          s3, a2, a3
                  divu         s11, a1, gp
                  addi         a5, a6, 639
                  mul          s0, t0, a0
                  lui          a2, 494335
                  srli         zero, ra, 0
                  c.mv         a3, s10
                  mul          s0, t0, a0
                  xor          a6, s1, sp
                  xori         s9, a6, -2048
                  sll          a1, s6, s9
                  mulh         s4, s7, t5
                  sll          a1, s6, s9
                  divu         s11, a1, gp
                  srai         s0, s4, 6
                  addi         a5, a6, 639
                  c.xor        a3, a0
                  slt          s3, a4, s5
                  xori         s9, a6, -2048
                  srl          a4, ra, s8
                  c.and        a2, a3
                  sltu         s1, s6, s7
                  sll          a1, s6, s9
                  xor          a6, s1, sp
                  c.lui        a4, 9
                  div          sp, s2, s5
                  c.slli       s5, 8
                  c.srli       a4, 11
                  c.xor        a3, a0
                  auipc        t6, 95018
                  mul          s0, t0, a0
                  c.nop
                  nop
                  mulhsu       a5, a0, s10
                  sll          a1, s6, s9
                  sltu         s1, s6, s7
                  c.sub        a0, a5
                  mulhu        a0, t2, zero
                  srl          a4, ra, s8
                  c.li         ra, 9
                  andi         t0, a0, -564
                  c.and        a2, a3
                  or           a5, a1, t6
                  lui          a2, 494335
                  sub          sp, a4, a4
                  div          sp, s2, s5
                  sra          s2, t6, s1
                  auipc        t6, 95018
                  sltu         s1, s6, s7
                  andi         t0, a0, -564
                  mulhu        a0, t2, zero
                  c.and        a2, a3
                  li           s0, 0xe35be8a6 #start riscv_int_numeric_corner_stream_21
                  li           ra, 0xffffffff
                  li           a7, 0xffffffff
                  li           tp, 0x0
                  li           t6, 0x6293825f
                  li           t4, 0x0
                  li           t5, 0xffffffff
                  li           a3, 0xffffffff
                  li           t0, 0xddd5546f
                  li           a5, 0xffffffff
                  addi         s0, ra, 639
                  divu         t6, a3, s0
                  rem          s0, a5, s0
                  remu         a5, t0, a5
                  mul          t5, a5, a5
                  auipc        t4, 95018
                  add          a3, t4, t5
                  sub          t0, tp, ra
                  mulhu        ra, t4, ra
                  mulh         a3, t4, t5
                  sub          t0, tp, ra
                  remu         a5, t0, a5
                  rem          s0, a5, s0
                  divu         t6, a3, s0
                  auipc        t4, 95018
                  remu         a5, t0, a5
                  addi         s0, ra, 639
                  mulh         a3, t4, t5
                  add          a3, t4, t5
                  mulhu        ra, t4, ra
                  addi         s0, ra, 639
                  lui          t0, 494335 #end riscv_int_numeric_corner_stream_21
                  andi         t0, a0, -564
                  c.add        s4, a4
                  c.li         ra, 9
                  c.and        a2, a3
                  sra          s2, t6, s1
                  divu         s11, a1, gp
                  xor          a6, s1, sp
                  and          s9, s5, a4
                  and          s9, s5, a4
                  sltiu        a4, t2, -709
                  sub          sp, a4, a4
                  or           a5, a1, t6
                  lui          a2, 494335
                  c.or         s1, a0
                  srl          a4, ra, s8
                  rem          s3, a2, a3
                  c.mv         a3, s10
                  c.sub        a0, a5
                  nop
                  remu         t6, s2, s5
                  sll          a1, s6, s9
                  c.xor        a3, a0
                  slli         gp, s11, 27
                  c.lui        a4, 9
                  c.lui        a4, 9
                  nop
                  c.srli       a4, 11
                  c.or         s1, a0
                  c.addi16sp   sp, 464
                  sra          s2, t6, s1
                  sltiu        a4, t2, -709
                  c.xor        a3, a0
                  slli         gp, s11, 27
                  sltu         s1, s6, s7
                  and          s9, s5, a4
                  sltiu        a4, t2, -709
                  sra          s2, t6, s1
                  c.addi4spn   a3, sp, 400
                  sra          s2, t6, s1
                  c.li         ra, 9
                  slt          s3, a4, s5
                  add          tp, a2, s8
                  sltu         s1, s6, s7
                  c.andi       a5, 29
                  c.or         s1, a0
                  slt          s3, a4, s5
                  sltu         s1, s6, s7
                  sltiu        a4, t2, -709
                  sub          sp, a4, a4
                  div          sp, s2, s5
                  mulhu        a0, t2, zero
                  c.addi16sp   sp, 464
                  div          sp, s2, s5
                  c.nop
                  sub          sp, a4, a4
                  c.mv         a3, s10
                  addi         a5, a6, 639
                  remu         t6, s2, s5
                  c.addi16sp   sp, 464
                  divu         s11, a1, gp
                  lui          a2, 494335
                  c.addi4spn   a3, sp, 400
                  c.slli       s5, 8
                  slt          s3, a4, s5
                  c.nop
                  srai         s0, s4, 6
                  and          s9, s5, a4
                  lui          a2, 494335
                  mulhu        a0, t2, zero
                  c.srli       a4, 11
                  c.xor        a3, a0
                  rem          s3, a2, a3
                  mul          s0, t0, a0
                  srai         s0, s4, 6
                  c.slli       s5, 8
                  nop
                  xor          a6, s1, sp
                  mulhu        a0, t2, zero
                  c.srai       a0, 24
                  andi         t0, a0, -564
                  divu         s11, a1, gp
                  sub          sp, a4, a4
                  nop
                  sub          sp, a4, a4
                  c.addi       s1, -1
                  srl          a4, ra, s8
                  c.li         ra, 9
                  c.or         s1, a0
                  sra          s2, t6, s1
                  sltiu        a4, t2, -709
                  mul          s0, t0, a0
                  xori         s9, a6, -2048
                  mulhsu       a5, a0, s10
                  c.andi       a5, 29
                  c.add        s4, a4
                  c.xor        a3, a0
                  c.srai       a0, 24
                  slt          s3, a4, s5
                  sub          sp, a4, a4
                  c.addi16sp   sp, 464
                  c.xor        a3, a0
                  mulhsu       a5, a0, s10
                  mulhu        a0, t2, zero
                  slli         gp, s11, 27
                  lui          a2, 494335
                  slli         gp, s11, 27
                  slli         gp, s11, 27
                  xori         s9, a6, -2048
                  mulh         s4, s7, t5
                  addi         a5, a6, 639
                  sub          sp, a4, a4
                  c.xor        a3, a0
                  c.mv         a3, s10
                  rem          s3, a2, a3
                  xori         s9, a6, -2048
                  mul          s0, t0, a0
                  c.addi16sp   sp, 464
                  and          s9, s5, a4
                  mulh         s4, s7, t5
                  c.addi16sp   sp, 464
                  andi         t0, a0, -564
                  xor          a6, s1, sp
                  slt          s3, a4, s5
                  xor          a6, s1, sp
                  add          tp, a2, s8
                  sra          s2, t6, s1
                  slti         s3, s5, -238
                  c.addi4spn   a3, sp, 400
                  c.srli       a4, 11
                  c.mv         a3, s10
                  srli         zero, ra, 0
                  c.lui        a4, 9
                  xori         s9, a6, -2048
                  c.mv         a3, s10
                  c.addi       s1, -1
                  sltiu        a4, t2, -709
                  c.or         s1, a0
                  slti         s3, s5, -238
                  xor          a6, s1, sp
                  srl          a4, ra, s8
                  auipc        t6, 95018
                  srai         s0, s4, 6
                  srai         s0, s4, 6
                  sltiu        a4, t2, -709
                  c.srli       a4, 11
                  c.mv         a3, s10
                  mulh         s4, s7, t5
                  c.andi       a5, 29
                  slli         gp, s11, 27
                  ori          a3, t5, 1088
                  c.sub        a0, a5
                  c.and        a2, a3
                  sub          sp, a4, a4
                  slli         gp, s11, 27
                  c.li         ra, 9
                  add          tp, a2, s8
                  c.addi       s1, -1
                  c.addi       s1, -1
                  xori         s9, a6, -2048
                  lui          a2, 494335
                  addi         a5, a6, 639
                  c.andi       a5, 29
                  c.srli       a4, 11
                  c.sub        a0, a5
                  mul          s0, t0, a0
                  sltiu        a4, t2, -709
                  lui          a2, 494335
                  srai         s0, s4, 6
                  c.addi4spn   a3, sp, 400
                  lui          a2, 494335
                  c.addi16sp   sp, 464
                  c.sub        a0, a5
                  lui          a2, 494335
                  srli         zero, ra, 0
                  lui          a2, 494335
                  c.srli       a4, 11
                  c.addi       s1, -1
                  xori         s9, a6, -2048
                  c.addi4spn   a3, sp, 400
                  add          tp, a2, s8
                  c.andi       a5, 29
                  divu         s11, a1, gp
                  sra          s2, t6, s1
                  sltu         s1, s6, s7
                  mul          s0, t0, a0
                  srl          a4, ra, s8
                  mulhu        a0, t2, zero
                  lui          a2, 494335
                  c.slli       s5, 8
                  sub          sp, a4, a4
                  div          sp, s2, s5
                  and          s9, s5, a4
                  mulhu        a0, t2, zero
                  ori          a3, t5, 1088
                  c.slli       s5, 8
                  addi         a5, a6, 639
                  auipc        t6, 95018
                  c.sub        a0, a5
                  sra          s2, t6, s1
                  srli         zero, ra, 0
                  c.xor        a3, a0
                  c.xor        a3, a0
                  ori          a3, t5, 1088
                  c.and        a2, a3
                  nop
                  slt          s3, a4, s5
                  c.srli       a4, 11
                  c.xor        a3, a0
                  c.and        a2, a3
                  c.srli       a4, 11
                  c.slli       s5, 8
                  sub          sp, a4, a4
                  c.or         s1, a0
                  slti         s3, s5, -238
                  xor          a6, s1, sp
                  c.andi       a5, 29
                  sll          a1, s6, s9
                  c.nop
                  c.or         s1, a0
                  slti         s3, s5, -238
                  c.or         s1, a0
                  c.add        s4, a4
                  nop
                  xori         s9, a6, -2048
                  slli         gp, s11, 27
                  c.slli       s5, 8
                  sll          a1, s6, s9
                  c.addi       s1, -1
                  c.nop
                  c.mv         a3, s10
                  addi         a5, a6, 639
                  rem          s3, a2, a3
                  mul          s0, t0, a0
                  mulh         s4, s7, t5
                  c.andi       a5, 29
                  divu         s11, a1, gp
                  nop
                  c.or         s1, a0
                  c.xor        a3, a0
                  addi         a5, a6, 639
                  c.and        a2, a3
                  c.addi       s1, -1
                  ori          a3, t5, 1088
                  c.and        a2, a3
                  nop
                  divu         s11, a1, gp
                  xori         s9, a6, -2048
                  c.lui        a4, 9
                  c.srli       a4, 11
                  add          tp, a2, s8
                  c.srli       a4, 11
                  srl          a4, ra, s8
                  c.mv         a3, s10
                  c.or         s1, a0
                  xori         s9, a6, -2048
                  mulh         s4, s7, t5
                  c.mv         a3, s10
                  add          tp, a2, s8
                  or           a5, a1, t6
                  srai         s0, s4, 6
                  c.mv         a3, s10
                  c.srai       a0, 24
                  c.addi4spn   a3, sp, 400
                  rem          s3, a2, a3
                  c.addi       s1, -1
                  divu         s11, a1, gp
                  sll          a1, s6, s9
                  c.xor        a3, a0
                  lui          a2, 494335
                  c.add        s4, a4
                  c.or         s1, a0
                  xori         s9, a6, -2048
                  div          sp, s2, s5
                  srai         s0, s4, 6
                  slt          s3, a4, s5
                  nop
                  sll          a1, s6, s9
                  c.addi4spn   a3, sp, 400
                  c.li         ra, 9
                  srli         zero, ra, 0
                  sltu         s1, s6, s7
                  addi         a5, a6, 639
                  mulh         s4, s7, t5
                  c.srli       a4, 11
                  c.xor        a3, a0
                  c.and        a2, a3
                  sltu         s1, s6, s7
                  div          sp, s2, s5
                  remu         t6, s2, s5
                  srli         zero, ra, 0
                  c.lui        a4, 9
                  and          s9, s5, a4
                  c.or         s1, a0
                  xor          a6, s1, sp
                  slli         gp, s11, 27
                  c.addi4spn   a3, sp, 400
                  c.xor        a3, a0
                  and          s9, s5, a4
                  srai         s0, s4, 6
                  c.addi       s1, -1
                  rem          s3, a2, a3
                  xori         s9, a6, -2048
                  c.add        s4, a4
                  srai         s0, s4, 6
                  c.addi4spn   a3, sp, 400
                  divu         s11, a1, gp
                  srl          a4, ra, s8
                  addi         a5, a6, 639
                  or           a5, a1, t6
                  div          sp, s2, s5
                  addi         a5, a6, 639
                  srli         zero, ra, 0
                  slti         s3, s5, -238
                  c.addi16sp   sp, 464
                  mulh         s4, s7, t5
                  add          tp, a2, s8
                  sltiu        a4, t2, -709
                  c.lui        a4, 9
                  c.nop
                  c.and        a2, a3
                  c.slli       s5, 8
                  c.slli       s5, 8
                  c.and        a2, a3
                  and          s9, s5, a4
                  c.and        a2, a3
                  c.lui        a4, 9
                  c.and        a2, a3
                  add          tp, a2, s8
                  remu         t6, s2, s5
                  c.srli       a4, 11
                  slt          s3, a4, s5
                  xor          a6, s1, sp
                  div          sp, s2, s5
                  addi         a5, a6, 639
                  c.addi       s1, -1
                  c.and        a2, a3
                  c.addi       s1, -1
                  srl          a4, ra, s8
                  c.or         s1, a0
                  auipc        t6, 95018
                  c.xor        a3, a0
                  srl          a4, ra, s8
                  c.addi       s1, -1
                  slli         gp, s11, 27
                  mulh         s4, s7, t5
                  c.xor        a3, a0
                  divu         s11, a1, gp
                  add          tp, a2, s8
                  xori         s9, a6, -2048
                  srai         s0, s4, 6
                  c.li         ra, 9
                  c.and        a2, a3
                  srl          a4, ra, s8
                  c.slli       s5, 8
                  mul          s0, t0, a0
                  c.li         ra, 9
                  mulhsu       a5, a0, s10
                  c.addi16sp   sp, 464
                  mulh         s4, s7, t5
                  xor          a6, s1, sp
                  c.sub        a0, a5
                  sll          a1, s6, s9
                  c.andi       a5, 29
                  c.sub        a0, a5
                  srai         s0, s4, 6
                  sll          a1, s6, s9
                  auipc        t6, 95018
                  c.and        a2, a3
                  mulh         s4, s7, t5
                  addi         a5, a6, 639
                  slli         gp, s11, 27
                  c.or         s1, a0
                  lui          a2, 494335
                  c.addi       s1, -1
                  divu         s11, a1, gp
                  c.mv         a3, s10
                  c.nop
                  c.or         s1, a0
                  c.xor        a3, a0
                  and          s9, s5, a4
                  srai         s0, s4, 6
                  xor          a6, s1, sp
                  c.add        s4, a4
                  nop
                  c.srai       a0, 24
                  rem          s3, a2, a3
                  c.addi4spn   a3, sp, 400
                  c.sub        a0, a5
                  c.or         s1, a0
                  c.andi       a5, 29
                  divu         s11, a1, gp
                  c.nop
                  auipc        t6, 95018
                  mul          s0, t0, a0
                  mulh         s4, s7, t5
                  srl          a4, ra, s8
                  srai         s0, s4, 6
                  c.slli       s5, 8
                  sltu         s1, s6, s7
                  c.lui        a4, 9
                  div          sp, s2, s5
                  srli         zero, ra, 0
                  c.slli       s5, 8
                  srl          a4, ra, s8
                  c.xor        a3, a0
                  add          tp, a2, s8
                  c.srli       a4, 11
                  and          s9, s5, a4
                  add          tp, a2, s8
                  c.andi       a5, 29
                  sltiu        a4, t2, -709
                  slt          s3, a4, s5
                  ori          a3, t5, 1088
                  ori          a3, t5, 1088
                  nop
                  sra          s2, t6, s1
                  c.lui        a4, 9
                  addi         a5, a6, 639
                  and          s9, s5, a4
                  c.lui        a4, 9
                  c.mv         a3, s10
                  addi         a5, a6, 639
                  mulhsu       a5, a0, s10
                  nop
                  c.or         s1, a0
                  add          tp, a2, s8
                  and          s9, s5, a4
                  c.sub        a0, a5
                  c.slli       s5, 8
                  auipc        t6, 95018
                  xor          a6, s1, sp
                  c.or         s1, a0
                  and          s9, s5, a4
                  div          sp, s2, s5
                  c.add        s4, a4
                  slli         gp, s11, 27
                  c.mv         a3, s10
                  xori         s9, a6, -2048
                  c.li         ra, 9
                  c.srli       a4, 11
                  c.andi       a5, 29
                  sub          sp, a4, a4
                  c.nop
                  c.addi       s1, -1
                  sltiu        a4, t2, -709
                  slti         s3, s5, -238
                  mul          s0, t0, a0
                  c.slli       s5, 8
                  lui          a2, 494335
                  srli         zero, ra, 0
                  c.addi       s1, -1
                  c.slli       s5, 8
                  slt          s3, a4, s5
                  sltiu        a4, t2, -709
                  sltu         s1, s6, s7
                  mulhu        a0, t2, zero
                  auipc        t6, 95018
                  lui          a2, 494335
                  and          s9, s5, a4
                  xori         s9, a6, -2048
                  c.and        a2, a3
                  c.andi       a5, 29
                  mulh         s4, s7, t5
                  mulhsu       a5, a0, s10
                  mulhsu       a5, a0, s10
                  mulhsu       a5, a0, s10
                  rem          s3, a2, a3
                  nop
                  xori         s9, a6, -2048
                  sub          sp, a4, a4
                  mulh         s4, s7, t5
                  slt          s3, a4, s5
                  rem          s3, a2, a3
                  srli         zero, ra, 0
                  slli         gp, s11, 27
                  xori         s9, a6, -2048
                  srai         s0, s4, 6
                  lui          a2, 494335
                  c.xor        a3, a0
                  srl          a4, ra, s8
                  andi         t0, a0, -564
                  c.addi4spn   a3, sp, 400
                  c.nop
                  andi         t0, a0, -564
                  c.addi       s1, -1
                  sll          a1, s6, s9
                  srli         zero, ra, 0
                  srai         s0, s4, 6
                  sra          s2, t6, s1
                  lui          a2, 494335
                  c.addi4spn   a3, sp, 400
                  c.slli       s5, 8
                  and          s9, s5, a4
                  ori          a3, t5, 1088
                  div          sp, s2, s5
                  c.nop
                  auipc        t6, 95018
                  mulhsu       a5, a0, s10
                  c.or         s1, a0
                  add          tp, a2, s8
                  c.srai       a0, 24
                  c.mv         a3, s10
                  slt          s3, a4, s5
                  add          tp, a2, s8
                  mulhsu       a5, a0, s10
                  slt          s3, a4, s5
                  xor          a6, s1, sp
                  c.and        a2, a3
                  nop
                  c.lui        a4, 9
                  or           a5, a1, t6
                  slti         s3, s5, -238
                  lui          a2, 494335
                  sub          sp, a4, a4
                  c.xor        a3, a0
                  sll          a1, s6, s9
                  remu         t6, s2, s5
                  c.lui        a4, 9
                  c.andi       a5, 29
                  c.and        a2, a3
                  mulhu        a0, t2, zero
                  add          tp, a2, s8
                  sltu         s1, s6, s7
                  xor          a6, s1, sp
                  c.or         s1, a0
                  ori          a3, t5, 1088
                  c.addi       s1, -1
                  c.andi       a5, 29
                  srli         zero, ra, 0
                  andi         t0, a0, -564
                  rem          s3, a2, a3
                  add          tp, a2, s8
                  c.andi       a5, 29
                  addi         a5, a6, 639
                  c.lui        a4, 9
                  mulh         s4, s7, t5
                  c.mv         a3, s10
                  c.and        a2, a3
                  rem          s3, a2, a3
                  slt          s3, a4, s5
                  lui          a2, 494335
                  sll          a1, s6, s9
                  c.srai       a0, 24
                  mul          s0, t0, a0
                  addi         a5, a6, 639
                  add          tp, a2, s8
                  addi         a5, a6, 639
                  mulhu        a0, t2, zero
                  xori         s9, a6, -2048
                  ori          a3, t5, 1088
                  slt          s3, a4, s5
                  c.li         ra, 9
                  srai         s0, s4, 6
                  sra          s2, t6, s1
                  lui          a2, 494335
                  andi         t0, a0, -564
                  c.add        s4, a4
                  rem          s3, a2, a3
                  sra          s2, t6, s1
                  mulhsu       a5, a0, s10
                  c.addi16sp   sp, 464
                  slti         s3, s5, -238
                  mulhu        a0, t2, zero
                  c.addi16sp   sp, 464
                  remu         t6, s2, s5
                  add          tp, a2, s8
                  addi         a5, a6, 639
                  slti         s3, s5, -238
                  c.nop
                  c.li         ra, 9
                  c.nop
                  c.slli       s5, 8
                  nop
                  divu         s11, a1, gp
                  lui          a2, 494335
                  sltu         s1, s6, s7
                  c.andi       a5, 29
                  sub          sp, a4, a4
                  xori         s9, a6, -2048
                  mulh         s4, s7, t5
                  c.slli       s5, 8
                  c.sub        a0, a5
                  sltu         s1, s6, s7
                  c.addi       s1, -1
                  c.and        a2, a3
                  srl          a4, ra, s8
                  mul          s0, t0, a0
                  mulh         s4, s7, t5
                  and          s9, s5, a4
                  div          sp, s2, s5
                  c.and        a2, a3
                  c.srai       a0, 24
                  lui          a2, 494335
                  div          sp, s2, s5
                  ori          a3, t5, 1088
                  or           a5, a1, t6
                  remu         t6, s2, s5
                  c.srli       a4, 11
                  sltu         s1, s6, s7
                  divu         s11, a1, gp
                  c.addi       s1, -1
                  mul          s0, t0, a0
                  and          s9, s5, a4
                  c.or         s1, a0
                  sll          a1, s6, s9
                  c.or         s1, a0
                  c.and        a2, a3
                  c.srai       a0, 24
                  sll          a1, s6, s9
                  add          tp, a2, s8
                  sra          s2, t6, s1
                  add          tp, a2, s8
                  sltu         s1, s6, s7
                  c.and        a2, a3
                  slli         gp, s11, 27
                  c.add        s4, a4
                  c.add        s4, a4
                  sub          sp, a4, a4
                  andi         t0, a0, -564
                  auipc        t6, 95018
                  slt          s3, a4, s5
                  divu         s11, a1, gp
                  c.andi       a5, 29
                  xori         s9, a6, -2048
                  srl          a4, ra, s8
                  c.mv         a3, s10
                  sub          sp, a4, a4
                  c.srli       a4, 11
                  sltiu        a4, t2, -709
                  rem          s3, a2, a3
                  c.and        a2, a3
                  srl          a4, ra, s8
                  c.sub        a0, a5
                  add          tp, a2, s8
                  c.or         s1, a0
                  add          tp, a2, s8
                  c.sub        a0, a5
                  ori          a3, t5, 1088
                  c.addi       s1, -1
                  lui          a2, 494335
                  c.and        a2, a3
                  sra          s2, t6, s1
                  mulhu        a0, t2, zero
                  mul          s0, t0, a0
                  add          tp, a2, s8
                  sub          sp, a4, a4
                  slt          s3, a4, s5
                  add          tp, a2, s8
                  c.lui        a4, 9
                  xor          a6, s1, sp
                  andi         t0, a0, -564
                  c.mv         a3, s10
                  xor          a6, s1, sp
                  divu         s11, a1, gp
                  addi         a5, a6, 639
                  lui          a2, 494335
                  andi         t0, a0, -564
                  rem          s3, a2, a3
                  c.nop
                  c.nop
                  c.slli       s5, 8
                  or           a5, a1, t6
                  c.lui        a4, 9
                  addi         a5, a6, 639
                  ori          a3, t5, 1088
                  mulhsu       a5, a0, s10
                  srl          a4, ra, s8
                  c.andi       a5, 29
                  div          sp, s2, s5
                  or           a5, a1, t6
                  c.addi16sp   sp, 464
                  c.addi16sp   sp, 464
                  andi         t0, a0, -564
                  auipc        t6, 95018
                  c.sub        a0, a5
                  c.slli       s5, 8
                  slt          s3, a4, s5
                  c.addi16sp   sp, 464
                  divu         s11, a1, gp
                  and          s9, s5, a4
                  c.srai       a0, 24
                  mulhu        a0, t2, zero
                  srl          a4, ra, s8
                  divu         s11, a1, gp
                  c.addi4spn   a3, sp, 400
                  c.and        a2, a3
                  div          sp, s2, s5
                  add          tp, a2, s8
                  c.srai       a0, 24
                  auipc        t6, 95018
                  sll          a1, s6, s9
                  or           a5, a1, t6
                  c.nop
                  c.addi4spn   a3, sp, 400
                  divu         s11, a1, gp
                  slt          s3, a4, s5
                  remu         t6, s2, s5
                  xori         s9, a6, -2048
                  or           a5, a1, t6
                  divu         s11, a1, gp
                  c.add        s4, a4
                  c.mv         a3, s10
                  sra          s2, t6, s1
                  xori         s9, a6, -2048
                  slti         s3, s5, -238
                  lui          a2, 494335
                  c.addi16sp   sp, 464
                  c.srai       a0, 24
                  srli         zero, ra, 0
                  c.srli       a4, 11
                  mul          s0, t0, a0
                  c.li         ra, 9
                  rem          s3, a2, a3
                  nop
                  sra          s2, t6, s1
                  and          s9, s5, a4
                  xori         s9, a6, -2048
                  c.nop
                  c.addi16sp   sp, 464
                  c.sub        a0, a5
                  c.addi16sp   sp, 464
                  sll          a1, s6, s9
                  divu         s11, a1, gp
                  c.nop
                  xor          a6, s1, sp
                  mulh         s4, s7, t5
                  c.mv         a3, s10
                  c.srai       a0, 24
                  sltiu        a4, t2, -709
                  sub          sp, a4, a4
                  c.sub        a0, a5
                  nop
                  sltiu        a4, t2, -709
                  srl          a4, ra, s8
                  sltu         s1, s6, s7
                  auipc        t6, 95018
                  c.slli       s5, 8
                  mul          s0, t0, a0
                  c.lui        a4, 9
                  c.srai       a0, 24
                  c.or         s1, a0
                  sub          sp, a4, a4
                  slli         gp, s11, 27
                  auipc        t6, 95018
                  c.xor        a3, a0
                  slli         gp, s11, 27
                  c.andi       a5, 29
                  srl          a4, ra, s8
                  srl          a4, ra, s8
                  c.slli       s5, 8
                  auipc        t6, 95018
                  addi         a5, a6, 639
                  c.addi       s1, -1
                  andi         t0, a0, -564
                  c.lui        a4, 9
                  lui          a2, 494335
                  c.or         s1, a0
                  slt          s3, a4, s5
                  xor          a6, s1, sp
                  c.lui        a4, 9
                  c.andi       a5, 29
                  sltu         s1, s6, s7
                  sra          s2, t6, s1
                  or           a5, a1, t6
                  divu         s11, a1, gp
                  sub          sp, a4, a4
                  divu         s11, a1, gp
                  c.mv         a3, s10
                  mul          s0, t0, a0
                  c.li         ra, 9
                  div          sp, s2, s5
                  srl          a4, ra, s8
                  c.addi       s1, -1
                  c.lui        a4, 9
                  slti         s3, s5, -238
                  c.sub        a0, a5
                  xor          a6, s1, sp
                  xor          a6, s1, sp
                  xori         s9, a6, -2048
                  c.add        s4, a4
                  srai         s0, s4, 6
                  mulhsu       a5, a0, s10
                  srai         s0, s4, 6
                  c.addi4spn   a3, sp, 400
                  divu         s11, a1, gp
                  lui          a2, 494335
                  c.srli       a4, 11
                  slli         gp, s11, 27
                  nop
                  sltiu        a4, t2, -709
                  c.and        a2, a3
                  c.addi16sp   sp, 464
                  slt          s3, a4, s5
                  add          tp, a2, s8
                  srli         zero, ra, 0
                  rem          s3, a2, a3
                  or           a5, a1, t6
                  nop
                  sub          sp, a4, a4
                  sub          sp, a4, a4
                  sub          sp, a4, a4
                  c.li         ra, 9
                  mulhu        a0, t2, zero
                  sll          a1, s6, s9
                  mulhsu       a5, a0, s10
                  ori          a3, t5, 1088
                  c.andi       a5, 29
                  sltu         s1, s6, s7
                  c.add        s4, a4
                  lui          a2, 494335
                  sltu         s1, s6, s7
                  c.addi16sp   sp, 464
                  rem          s3, a2, a3
                  xori         s9, a6, -2048
                  slli         gp, s11, 27
                  ori          a3, t5, 1088
                  mulhsu       a5, a0, s10
                  lui          a2, 494335
                  nop
                  c.andi       a5, 29
                  slt          s3, a4, s5
                  c.and        a2, a3
                  div          sp, s2, s5
                  c.slli       s5, 8
                  addi         a5, a6, 639
                  c.andi       a5, 29
                  srai         s0, s4, 6
                  mulh         s4, s7, t5
                  divu         s11, a1, gp
                  c.addi4spn   a3, sp, 400
                  c.slli       s5, 8
                  c.addi       s1, -1
                  srai         s0, s4, 6
                  c.slli       s5, 8
                  c.andi       a5, 29
                  slli         gp, s11, 27
                  ori          a3, t5, 1088
                  c.srai       a0, 24
                  c.xor        a3, a0
                  xori         s9, a6, -2048
                  slti         s3, s5, -238
                  c.li         ra, 9
                  sra          s2, t6, s1
                  c.slli       s5, 8
                  mul          s0, t0, a0
                  addi         a5, a6, 639
                  c.srli       a4, 11
                  c.andi       a5, 29
                  c.xor        a3, a0
                  sll          a1, s6, s9
                  c.xor        a3, a0
                  srl          a4, ra, s8
                  div          sp, s2, s5
                  and          s9, s5, a4
                  srl          a4, ra, s8
                  ori          a3, t5, 1088
                  andi         t0, a0, -564
                  c.and        a2, a3
                  nop
                  c.or         s1, a0
                  slli         gp, s11, 27
                  mul          s0, t0, a0
                  c.add        s4, a4
                  c.andi       a5, 29
                  c.addi4spn   a3, sp, 400
                  mulh         s4, s7, t5
                  c.addi       s1, -1
                  nop
                  andi         t0, a0, -564
                  li           a6, 0xeb565b6 #start riscv_int_numeric_corner_stream_13
                  li           a2, 0x0
                  li           gp, 0xffffffff
                  li           s10, 0x1b0ce1ec
                  li           s1, 0x0
                  li           ra, 0xe39ba1ba
                  li           s2, 0x0
                  li           s5, 0xffffffff
                  li           s11, 0xffffffff
                  li           s3, 0x80000000
                  mulhu        ra, s5, ra
                  mulhsu       a2, a6, gp
                  lui          s1, 494335
                  addi         a2, ra, 639
                  div          s1, s1, s2
                  mulhu        ra, s5, ra
                  remu         s2, s1, s2
                  mulh         a6, s5, s10
                  div          s1, s1, s2
                  mulhsu       a2, a6, gp
                  divu         s11, a6, a2
                  addi         a2, ra, 639
                  mulhsu       a2, a6, gp
                  auipc        s5, 95018
                  div          s1, s1, s2
                  addi         a2, ra, 639
                  auipc        s5, 95018
                  addi         a2, ra, 639
                  sub          s1, gp, ra #end riscv_int_numeric_corner_stream_13
                  c.srai       a0, 24
                  c.srli       a4, 11
                  sltiu        a4, t2, -709
                  mulh         s4, s7, t5
                  mulh         s4, s7, t5
                  auipc        t6, 95018
                  divu         s11, a1, gp
                  lui          a2, 494335
                  c.addi16sp   sp, 464
                  nop
                  srl          a4, ra, s8
                  c.andi       a5, 29
                  slli         gp, s11, 27
                  c.and        a2, a3
                  rem          s3, a2, a3
                  srai         s0, s4, 6
                  slli         gp, s11, 27
                  c.sub        a0, a5
                  c.or         s1, a0
                  c.xor        a3, a0
                  sll          a1, s6, s9
                  sub          sp, a4, a4
                  c.srli       a4, 11
                  c.addi4spn   a3, sp, 400
                  c.or         s1, a0
                  mulhu        a0, t2, zero
                  c.li         ra, 9
                  xor          a6, s1, sp
                  sub          sp, a4, a4
                  rem          s3, a2, a3
                  slli         gp, s11, 27
                  c.or         s1, a0
                  c.srai       a0, 24
                  slt          s3, a4, s5
                  lui          a2, 494335
                  sub          sp, a4, a4
                  addi         a5, a6, 639
                  mulh         s4, s7, t5
                  sub          sp, a4, a4
                  add          tp, a2, s8
                  nop
                  add          tp, a2, s8
                  srai         s0, s4, 6
                  divu         s11, a1, gp
                  addi         a5, a6, 639
                  c.addi16sp   sp, 464
                  c.li         ra, 9
                  add          tp, a2, s8
                  remu         t6, s2, s5
                  srl          a4, ra, s8
                  sub          sp, a4, a4
                  mulhu        a0, t2, zero
                  rem          s3, a2, a3
                  c.srai       a0, 24
                  c.add        s4, a4
                  mul          s0, t0, a0
                  c.xor        a3, a0
                  mulhsu       a5, a0, s10
                  c.or         s1, a0
                  mul          s0, t0, a0
                  mulh         s4, s7, t5
                  andi         t0, a0, -564
                  c.andi       a5, 29
                  andi         t0, a0, -564
                  sra          s2, t6, s1
                  mulhsu       a5, a0, s10
                  c.or         s1, a0
                  auipc        t6, 95018
                  and          s9, s5, a4
                  c.or         s1, a0
                  ori          a3, t5, 1088
                  srli         zero, ra, 0
                  sub          sp, a4, a4
                  mul          s0, t0, a0
                  c.xor        a3, a0
                  lui          a2, 494335
                  c.li         ra, 9
                  xor          a6, s1, sp
                  srai         s0, s4, 6
                  addi         a5, a6, 639
                  c.addi4spn   a3, sp, 400
                  ori          a3, t5, 1088
                  auipc        t6, 95018
                  c.add        s4, a4
                  c.addi16sp   sp, 464
                  c.lui        a4, 9
                  auipc        t6, 95018
                  c.or         s1, a0
                  c.or         s1, a0
                  li           tp, 0x0 #start riscv_int_numeric_corner_stream_39
                  li           t2, 0x0
                  li           t4, 0x0
                  li           s2, 0x0
                  li           s9, 0x5ac883fb
                  li           t5, 0x80000000
                  li           t1, 0xffffffff
                  li           s11, 0xffffffff
                  li           s3, 0x80000000
                  li           gp, 0xffffffff
                  mulh         s2, s11, t4
                  add          s2, s11, t4
                  mulhsu       t2, s2, tp
                  mulhu        gp, s11, gp
                  mulh         s2, s11, t4
                  addi         t2, gp, 639
                  mulhsu       t2, s2, tp
                  add          s2, s11, t4
                  div          t1, t1, s3
                  mulhu        gp, s11, gp
                  mul          t4, s3, s3
                  addi         t2, gp, 639
                  mulhu        gp, s11, gp
                  nop
                  divu         t5, s2, t2
                  rem          t2, s3, t2
                  nop
                  mulhu        gp, s11, gp
                  remu         s3, t1, s3
                  addi         t2, gp, 639
                  mulhsu       t2, s2, tp
                  mulhsu       t2, s2, tp
                  nop
                  nop
                  mulhu        gp, s11, gp #end riscv_int_numeric_corner_stream_39
                  add          tp, a2, s8
                  rem          s3, a2, a3
                  auipc        t6, 95018
                  rem          s3, a2, a3
                  mul          s0, t0, a0
                  c.mv         a3, s10
                  ori          a3, t5, 1088
                  divu         s11, a1, gp
                  c.li         ra, 9
                  c.srli       a4, 11
                  c.or         s1, a0
                  and          s9, s5, a4
                  c.add        s4, a4
                  c.andi       a5, 29
                  c.addi       s1, -1
                  c.srli       a4, 11
                  c.and        a2, a3
                  remu         t6, s2, s5
                  addi         a5, a6, 639
                  c.or         s1, a0
                  lui          a2, 494335
                  mulhu        a0, t2, zero
                  c.sub        a0, a5
                  c.srli       a4, 11
                  add          tp, a2, s8
                  rem          s3, a2, a3
                  slli         gp, s11, 27
                  addi         a5, a6, 639
                  lui          a2, 494335
                  c.or         s1, a0
                  lui          a2, 494335
                  c.sub        a0, a5
                  slli         gp, s11, 27
                  c.addi       s1, -1
                  xor          a6, s1, sp
                  c.sub        a0, a5
                  lui          a2, 494335
                  mulh         s4, s7, t5
                  andi         t0, a0, -564
                  c.addi4spn   a3, sp, 400
                  c.li         ra, 9
                  srli         zero, ra, 0
                  c.mv         a3, s10
                  rem          s3, a2, a3
                  c.li         ra, 9
                  divu         s11, a1, gp
                  c.addi       s1, -1
                  srl          a4, ra, s8
                  c.add        s4, a4
                  srl          a4, ra, s8
                  c.andi       a5, 29
                  c.addi4spn   a3, sp, 400
                  mul          s0, t0, a0
                  or           a5, a1, t6
                  c.slli       s5, 8
                  sll          a1, s6, s9
                  div          sp, s2, s5
                  mulhu        a0, t2, zero
                  addi         a5, a6, 639
                  sltu         s1, s6, s7
                  c.andi       a5, 29
                  mulhsu       a5, a0, s10
                  or           a5, a1, t6
                  c.andi       a5, 29
                  c.addi16sp   sp, 464
                  sub          sp, a4, a4
                  srl          a4, ra, s8
                  slli         gp, s11, 27
                  c.addi4spn   a3, sp, 400
                  add          tp, a2, s8
                  mulh         s4, s7, t5
                  sll          a1, s6, s9
                  c.nop
                  c.srai       a0, 24
                  srli         zero, ra, 0
                  srai         s0, s4, 6
                  slti         s3, s5, -238
                  c.xor        a3, a0
                  srai         s0, s4, 6
                  and          s9, s5, a4
                  c.slli       s5, 8
                  srl          a4, ra, s8
                  c.li         ra, 9
                  remu         t6, s2, s5
                  c.lui        a4, 9
                  add          tp, a2, s8
                  slli         gp, s11, 27
                  xori         s9, a6, -2048
                  andi         t0, a0, -564
                  c.addi4spn   a3, sp, 400
                  c.nop
                  remu         t6, s2, s5
                  and          s9, s5, a4
                  srli         zero, ra, 0
                  add          tp, a2, s8
                  c.srai       a0, 24
                  c.xor        a3, a0
                  xori         s9, a6, -2048
                  c.srai       a0, 24
                  remu         t6, s2, s5
                  c.xor        a3, a0
                  slti         s3, s5, -238
                  sll          a1, s6, s9
                  rem          s3, a2, a3
                  sra          s2, t6, s1
                  andi         t0, a0, -564
                  mulh         s4, s7, t5
                  c.srai       a0, 24
                  sltu         s1, s6, s7
                  or           a5, a1, t6
                  c.srli       a4, 11
                  c.andi       a5, 29
                  c.and        a2, a3
                  remu         t6, s2, s5
                  c.andi       a5, 29
                  andi         t0, a0, -564
                  srli         zero, ra, 0
                  mulh         s4, s7, t5
                  c.srli       a4, 11
                  sll          a1, s6, s9
                  c.slli       s5, 8
                  c.addi       s1, -1
                  addi         a5, a6, 639
                  sub          sp, a4, a4
                  c.slli       s5, 8
                  div          sp, s2, s5
                  sltiu        a4, t2, -709
                  sltiu        a4, t2, -709
                  srl          a4, ra, s8
                  li           s3, 0x80000000 #start riscv_int_numeric_corner_stream_11
                  li           s4, 0xffffffff
                  li           a4, 0xffffffff
                  li           s11, 0x80000000
                  li           a5, 0x0
                  li           s9, 0xffffffff
                  li           a7, 0x0
                  li           s1, 0x0
                  li           tp, 0x1c9e520
                  li           s2, 0x80000000
                  div          a4, a4, s2
                  rem          a5, s2, a5
                  lui          a4, 494335
                  sub          a4, s1, tp
                  mulhu        tp, s4, tp
                  mulhsu       a5, a7, s1
                  rem          a5, s2, a5
                  mulh         a7, s4, s9
                  mul          s9, s2, s2
                  lui          a4, 494335
                  rem          a5, s2, a5
                  mul          s9, s2, s2
                  addi         a5, tp, 639
                  rem          a5, s2, a5
                  divu         s11, a7, a5
                  add          a7, s4, s9
                  mulhsu       a5, a7, s1
                  divu         s11, a7, a5
                  addi         a5, tp, 639
                  nop
                  divu         s11, a7, a5
                  rem          a5, s2, a5
                  lui          a4, 494335
                  lui          a4, 494335
                  rem          a5, s2, a5
                  addi         a5, tp, 639
                  nop
                  add          a7, s4, s9 #end riscv_int_numeric_corner_stream_11
                  sub          sp, a4, a4
                  c.and        a2, a3
                  xori         s9, a6, -2048
                  c.li         ra, 9
                  rem          s3, a2, a3
                  sltu         s1, s6, s7
                  c.and        a2, a3
                  or           a5, a1, t6
                  c.li         ra, 9
                  c.add        s4, a4
                  c.addi       s1, -1
                  c.mv         a3, s10
                  c.addi       s1, -1
                  mulh         s4, s7, t5
                  mul          s0, t0, a0
                  sub          sp, a4, a4
                  mulhsu       a5, a0, s10
                  c.srli       a4, 11
                  mulhsu       a5, a0, s10
                  c.addi       s1, -1
                  c.and        a2, a3
                  c.xor        a3, a0
                  mulhsu       a5, a0, s10
                  c.addi4spn   a3, sp, 400
                  nop
                  mulh         s4, s7, t5
                  c.mv         a3, s10
                  or           a5, a1, t6
                  ori          a3, t5, 1088
                  remu         t6, s2, s5
                  lui          a2, 494335
                  or           a5, a1, t6
                  sub          sp, a4, a4
                  auipc        t6, 95018
                  srli         zero, ra, 0
                  slli         gp, s11, 27
                  div          sp, s2, s5
                  nop
                  c.add        s4, a4
                  rem          s3, a2, a3
                  xori         s9, a6, -2048
                  c.addi16sp   sp, 464
                  auipc        t6, 95018
                  c.addi16sp   sp, 464
                  sra          s2, t6, s1
                  divu         s11, a1, gp
                  c.andi       a5, 29
                  nop
                  andi         t0, a0, -564
                  add          tp, a2, s8
                  and          s9, s5, a4
                  c.slli       s5, 8
                  add          tp, a2, s8
                  div          sp, s2, s5
                  mulh         s4, s7, t5
                  c.addi       s1, -1
                  c.and        a2, a3
                  sll          a1, s6, s9
                  c.lui        a4, 9
                  mulhu        a0, t2, zero
                  sra          s2, t6, s1
                  xori         s9, a6, -2048
                  c.srli       a4, 11
                  slt          s3, a4, s5
                  c.sub        a0, a5
                  c.addi4spn   a3, sp, 400
                  c.xor        a3, a0
                  c.slli       s5, 8
                  srl          a4, ra, s8
                  rem          s3, a2, a3
                  addi         a5, a6, 639
                  slli         gp, s11, 27
                  xor          a6, s1, sp
                  add          tp, a2, s8
                  c.and        a2, a3
                  divu         s11, a1, gp
                  c.andi       a5, 29
                  srli         zero, ra, 0
                  c.addi16sp   sp, 464
                  mulhsu       a5, a0, s10
                  rem          s3, a2, a3
                  and          s9, s5, a4
                  c.srai       a0, 24
                  sll          a1, s6, s9
                  c.lui        a4, 9
                  c.slli       s5, 8
                  c.nop
                  c.or         s1, a0
                  xor          a6, s1, sp
                  c.addi       s1, -1
                  c.and        a2, a3
                  xori         s9, a6, -2048
                  lui          a2, 494335
                  c.nop
                  div          sp, s2, s5
                  slti         s3, s5, -238
                  c.sub        a0, a5
                  sltu         s1, s6, s7
                  mul          s0, t0, a0
                  or           a5, a1, t6
                  srl          a4, ra, s8
                  xori         s9, a6, -2048
                  c.or         s1, a0
                  slli         gp, s11, 27
                  c.andi       a5, 29
                  xor          a6, s1, sp
                  c.nop
                  nop
                  sltiu        a4, t2, -709
                  and          s9, s5, a4
                  lui          a2, 494335
                  lui          a2, 494335
                  srl          a4, ra, s8
                  slt          s3, a4, s5
                  and          s9, s5, a4
                  c.andi       a5, 29
                  sll          a1, s6, s9
                  c.sub        a0, a5
                  add          tp, a2, s8
                  slli         gp, s11, 27
                  addi         a5, a6, 639
                  rem          s3, a2, a3
                  c.addi       s1, -1
                  sll          a1, s6, s9
                  c.or         s1, a0
                  srai         s0, s4, 6
                  auipc        t6, 95018
                  c.addi16sp   sp, 464
                  c.add        s4, a4
                  c.addi16sp   sp, 464
                  remu         t6, s2, s5
                  nop
                  mul          s0, t0, a0
                  xori         s9, a6, -2048
                  mul          s0, t0, a0
                  c.addi4spn   a3, sp, 400
                  xori         s9, a6, -2048
                  c.sub        a0, a5
                  and          s9, s5, a4
                  c.sub        a0, a5
                  andi         t0, a0, -564
                  c.add        s4, a4
                  c.addi16sp   sp, 464
                  c.srai       a0, 24
                  rem          s3, a2, a3
                  rem          s3, a2, a3
                  c.add        s4, a4
                  c.slli       s5, 8
                  c.sub        a0, a5
                  or           a5, a1, t6
                  slti         s3, s5, -238
                  c.srli       a4, 11
                  addi         a5, a6, 639
                  xori         s9, a6, -2048
                  srl          a4, ra, s8
                  rem          s3, a2, a3
                  c.add        s4, a4
                  c.srai       a0, 24
                  slt          s3, a4, s5
                  c.mv         a3, s10
                  xor          a6, s1, sp
                  srai         s0, s4, 6
                  c.nop
                  rem          s3, a2, a3
                  nop
                  srl          a4, ra, s8
                  c.nop
                  c.srli       a4, 11
                  ori          a3, t5, 1088
                  rem          s3, a2, a3
                  c.nop
                  c.addi4spn   a3, sp, 400
                  mulhsu       a5, a0, s10
                  c.sub        a0, a5
                  srli         zero, ra, 0
                  nop
                  rem          s3, a2, a3
                  mul          s0, t0, a0
                  andi         t0, a0, -564
                  srl          a4, ra, s8
                  c.slli       s5, 8
                  srli         zero, ra, 0
                  c.xor        a3, a0
                  c.nop
                  c.xor        a3, a0
                  remu         t6, s2, s5
                  sub          sp, a4, a4
                  div          sp, s2, s5
                  c.addi       s1, -1
                  c.addi4spn   a3, sp, 400
                  c.add        s4, a4
                  srli         zero, ra, 0
                  c.li         ra, 9
                  mulhsu       a5, a0, s10
                  c.or         s1, a0
                  c.nop
                  xori         s9, a6, -2048
                  c.srli       a4, 11
                  sltiu        a4, t2, -709
                  xor          a6, s1, sp
                  slt          s3, a4, s5
                  srl          a4, ra, s8
                  c.nop
                  sub          sp, a4, a4
                  c.andi       a5, 29
                  sra          s2, t6, s1
                  remu         t6, s2, s5
                  lui          a2, 494335
                  c.srli       a4, 11
                  lui          a2, 494335
                  auipc        t6, 95018
                  c.addi       s1, -1
                  mul          s0, t0, a0
                  c.li         ra, 9
                  mulh         s4, s7, t5
                  remu         t6, s2, s5
                  c.addi16sp   sp, 464
                  and          s9, s5, a4
                  c.li         ra, 9
                  c.srli       a4, 11
                  or           a5, a1, t6
                  xori         s9, a6, -2048
                  xor          a6, s1, sp
                  slli         gp, s11, 27
                  remu         t6, s2, s5
                  c.or         s1, a0
                  c.addi       s1, -1
                  mul          s0, t0, a0
                  sltiu        a4, t2, -709
                  srai         s0, s4, 6
                  c.srai       a0, 24
                  c.and        a2, a3
                  ori          a3, t5, 1088
                  divu         s11, a1, gp
                  sltiu        a4, t2, -709
                  andi         t0, a0, -564
                  c.andi       a5, 29
                  slti         s3, s5, -238
                  slt          s3, a4, s5
                  c.lui        a4, 9
                  xor          a6, s1, sp
                  c.li         ra, 9
                  slli         gp, s11, 27
                  c.sub        a0, a5
                  c.add        s4, a4
                  nop
                  mulh         s4, s7, t5
                  slti         s3, s5, -238
                  remu         t6, s2, s5
                  sra          s2, t6, s1
                  srai         s0, s4, 6
                  mul          s0, t0, a0
                  remu         t6, s2, s5
                  nop
                  c.xor        a3, a0
                  c.lui        a4, 9
                  and          s9, s5, a4
                  and          s9, s5, a4
                  divu         s11, a1, gp
                  sub          sp, a4, a4
                  srli         zero, ra, 0
                  c.add        s4, a4
                  mulhsu       a5, a0, s10
                  c.addi16sp   sp, 464
                  add          tp, a2, s8
                  slti         s3, s5, -238
                  mulhsu       a5, a0, s10
                  auipc        t6, 95018
                  c.andi       a5, 29
                  c.addi16sp   sp, 464
                  c.srli       a4, 11
                  lui          a2, 494335
                  or           a5, a1, t6
                  mulh         s4, s7, t5
                  slli         gp, s11, 27
                  srl          a4, ra, s8
                  slli         gp, s11, 27
                  sltu         s1, s6, s7
                  slli         gp, s11, 27
                  c.add        s4, a4
                  mulhu        a0, t2, zero
                  div          sp, s2, s5
                  mul          s0, t0, a0
                  srli         zero, ra, 0
                  mul          s0, t0, a0
                  li           a6, 0xffffffff #start riscv_int_numeric_corner_stream_16
                  li           s9, 0x80000000
                  li           s1, 0x80000000
                  li           s3, 0x0
                  li           t6, 0x0
                  li           t5, 0x80000000
                  li           tp, 0x0
                  li           a0, 0xffffffff
                  li           t0, 0xb4e5c7dd
                  li           t1, 0x80000000
                  lui          t1, 494335
                  addi         s1, tp, 639
                  remu         a6, t1, a6
                  mulh         a0, s9, t5
                  mulhu        tp, s9, tp
                  mulhu        tp, s9, tp
                  mul          t5, a6, a6
                  auipc        s9, 95018
                  mul          t5, a6, a6
                  div          t1, t1, a6
                  divu         t6, a0, s1
                  remu         a6, t1, a6
                  remu         a6, t1, a6
                  divu         t6, a0, s1
                  div          t1, t1, a6
                  remu         a6, t1, a6
                  lui          t1, 494335
                  divu         t6, a0, s1
                  mul          t5, a6, a6
                  auipc        s9, 95018
                  mulhu        tp, s9, tp
                  divu         t6, a0, s1
                  mulhsu       s1, a0, t0
                  lui          t1, 494335 #end riscv_int_numeric_corner_stream_16
                  srl          a4, ra, s8
                  c.slli       s5, 8
                  or           a5, a1, t6
                  slt          s3, a4, s5
                  c.srai       a0, 24
                  c.and        a2, a3
                  and          s9, s5, a4
                  slli         gp, s11, 27
                  c.li         ra, 9
                  addi         a5, a6, 639
                  sra          s2, t6, s1
                  auipc        t6, 95018
                  sltiu        a4, t2, -709
                  remu         t6, s2, s5
                  c.slli       s5, 8
                  c.andi       a5, 29
                  mulhu        a0, t2, zero
                  sltu         s1, s6, s7
                  c.and        a2, a3
                  c.srli       a4, 11
                  c.xor        a3, a0
                  mulhu        a0, t2, zero
                  nop
                  rem          s3, a2, a3
                  c.srli       a4, 11
                  c.andi       a5, 29
                  mulhsu       a5, a0, s10
                  mulhu        a0, t2, zero
                  slti         s3, s5, -238
                  lui          a2, 494335
                  ori          a3, t5, 1088
                  sll          a1, s6, s9
                  srl          a4, ra, s8
                  auipc        t6, 95018
                  c.add        s4, a4
                  c.slli       s5, 8
                  c.mv         a3, s10
                  sltiu        a4, t2, -709
                  auipc        t6, 95018
                  div          sp, s2, s5
                  c.addi4spn   a3, sp, 400
                  c.addi       s1, -1
                  c.xor        a3, a0
                  rem          s3, a2, a3
                  c.andi       a5, 29
                  or           a5, a1, t6
                  nop
                  c.addi16sp   sp, 464
                  divu         s11, a1, gp
                  and          s9, s5, a4
                  add          tp, a2, s8
                  xor          a6, s1, sp
                  rem          s3, a2, a3
                  sltiu        a4, t2, -709
                  divu         s11, a1, gp
                  c.addi16sp   sp, 464
                  remu         t6, s2, s5
                  sll          a1, s6, s9
                  c.lui        a4, 9
                  c.addi4spn   a3, sp, 400
                  mulhsu       a5, a0, s10
                  c.lui        a4, 9
                  and          s9, s5, a4
                  divu         s11, a1, gp
                  addi         a5, a6, 639
                  sra          s2, t6, s1
                  sub          sp, a4, a4
                  and          s9, s5, a4
                  srli         zero, ra, 0
                  auipc        t6, 95018
                  mulh         s4, s7, t5
                  auipc        t6, 95018
                  c.srli       a4, 11
                  sltiu        a4, t2, -709
                  c.xor        a3, a0
                  sll          a1, s6, s9
                  nop
                  slt          s3, a4, s5
                  c.lui        a4, 9
                  ori          a3, t5, 1088
                  andi         t0, a0, -564
                  nop
                  c.lui        a4, 9
                  slti         s3, s5, -238
                  c.add        s4, a4
                  c.andi       a5, 29
                  srli         zero, ra, 0
                  add          tp, a2, s8
                  remu         t6, s2, s5
                  andi         t0, a0, -564
                  c.or         s1, a0
                  xor          a6, s1, sp
                  lui          a2, 494335
                  xori         s9, a6, -2048
                  c.addi16sp   sp, 464
                  div          sp, s2, s5
                  slti         s3, s5, -238
                  nop
                  sub          sp, a4, a4
                  c.lui        a4, 9
                  addi         a5, a6, 639
                  c.lui        a4, 9
                  mul          s0, t0, a0
                  div          sp, s2, s5
                  c.addi4spn   a3, sp, 400
                  c.add        s4, a4
                  slli         gp, s11, 27
                  c.andi       a5, 29
                  c.add        s4, a4
                  c.addi       s1, -1
                  c.addi4spn   a3, sp, 400
                  auipc        t6, 95018
                  c.nop
                  slli         gp, s11, 27
                  srai         s0, s4, 6
                  slti         s3, s5, -238
                  sub          sp, a4, a4
                  xori         s9, a6, -2048
                  sll          a1, s6, s9
                  ori          a3, t5, 1088
                  sltiu        a4, t2, -709
                  mulh         s4, s7, t5
                  mul          s0, t0, a0
                  c.add        s4, a4
                  slli         gp, s11, 27
                  c.andi       a5, 29
                  auipc        t6, 95018
                  or           a5, a1, t6
                  srl          a4, ra, s8
                  and          s9, s5, a4
                  c.li         ra, 9
                  mulhu        a0, t2, zero
                  sll          a1, s6, s9
                  c.nop
                  slli         gp, s11, 27
                  and          s9, s5, a4
                  c.li         ra, 9
                  remu         t6, s2, s5
                  sltiu        a4, t2, -709
                  srl          a4, ra, s8
                  c.srli       a4, 11
                  c.slli       s5, 8
                  srl          a4, ra, s8
                  c.sub        a0, a5
                  c.add        s4, a4
                  slli         gp, s11, 27
                  mulhsu       a5, a0, s10
                  c.lui        a4, 9
                  andi         t0, a0, -564
                  srl          a4, ra, s8
                  mul          s0, t0, a0
                  lui          a2, 494335
                  ori          a3, t5, 1088
                  or           a5, a1, t6
                  c.srai       a0, 24
                  c.srai       a0, 24
                  srl          a4, ra, s8
                  and          s9, s5, a4
                  slti         s3, s5, -238
                  ori          a3, t5, 1088
                  c.addi16sp   sp, 464
                  xor          a6, s1, sp
                  c.srli       a4, 11
                  c.addi       s1, -1
                  c.li         ra, 9
                  auipc        t6, 95018
                  c.andi       a5, 29
                  c.xor        a3, a0
                  sltu         s1, s6, s7
                  ori          a3, t5, 1088
                  lui          a2, 494335
                  c.sub        a0, a5
                  srli         zero, ra, 0
                  c.srli       a4, 11
                  xor          a6, s1, sp
                  c.li         ra, 9
                  c.or         s1, a0
                  slti         s3, s5, -238
                  and          s9, s5, a4
                  sra          s2, t6, s1
                  c.addi4spn   a3, sp, 400
                  div          sp, s2, s5
                  c.sub        a0, a5
                  mulh         s4, s7, t5
                  nop
                  c.add        s4, a4
                  sll          a1, s6, s9
                  sll          a1, s6, s9
                  remu         t6, s2, s5
                  c.andi       a5, 29
                  c.or         s1, a0
                  addi         a5, a6, 639
                  xor          a6, s1, sp
                  srli         zero, ra, 0
                  sra          s2, t6, s1
                  sub          sp, a4, a4
                  c.andi       a5, 29
                  divu         s11, a1, gp
                  nop
                  nop
                  addi         a5, a6, 639
                  slti         s3, s5, -238
                  c.nop
                  c.add        s4, a4
                  add          tp, a2, s8
                  slti         s3, s5, -238
                  c.srai       a0, 24
                  add          tp, a2, s8
                  andi         t0, a0, -564
                  mulhsu       a5, a0, s10
                  c.addi       s1, -1
                  nop
                  c.slli       s5, 8
                  slti         s3, s5, -238
                  andi         t0, a0, -564
                  c.srli       a4, 11
                  or           a5, a1, t6
                  slli         gp, s11, 27
                  nop
                  mulhu        a0, t2, zero
                  c.mv         a3, s10
                  div          sp, s2, s5
                  mulh         s4, s7, t5
                  mulh         s4, s7, t5
                  ori          a3, t5, 1088
                  slti         s3, s5, -238
                  remu         t6, s2, s5
                  slli         gp, s11, 27
                  andi         t0, a0, -564
                  slt          s3, a4, s5
                  divu         s11, a1, gp
                  c.addi       s1, -1
                  sll          a1, s6, s9
                  auipc        t6, 95018
                  c.addi16sp   sp, 464
                  xor          a6, s1, sp
                  sltu         s1, s6, s7
                  c.add        s4, a4
                  xor          a6, s1, sp
                  rem          s3, a2, a3
                  ori          a3, t5, 1088
                  sltiu        a4, t2, -709
                  divu         s11, a1, gp
                  sra          s2, t6, s1
                  c.addi       s1, -1
                  andi         t0, a0, -564
                  c.and        a2, a3
                  c.lui        a4, 9
                  and          s9, s5, a4
                  srl          a4, ra, s8
                  c.slli       s5, 8
                  c.srli       a4, 11
                  sra          s2, t6, s1
                  c.addi4spn   a3, sp, 400
                  c.add        s4, a4
                  auipc        t6, 95018
                  c.mv         a3, s10
                  slt          s3, a4, s5
                  auipc        t6, 95018
                  sub          sp, a4, a4
                  c.slli       s5, 8
                  and          s9, s5, a4
                  c.or         s1, a0
                  c.srli       a4, 11
                  and          s9, s5, a4
                  remu         t6, s2, s5
                  srl          a4, ra, s8
                  slli         gp, s11, 27
                  nop
                  ori          a3, t5, 1088
                  c.nop
                  c.srli       a4, 11
                  lui          a2, 494335
                  sra          s2, t6, s1
                  add          tp, a2, s8
                  add          tp, a2, s8
                  c.addi16sp   sp, 464
                  c.sub        a0, a5
                  sltu         s1, s6, s7
                  xor          a6, s1, sp
                  andi         t0, a0, -564
                  sll          a1, s6, s9
                  c.and        a2, a3
                  auipc        t6, 95018
                  and          s9, s5, a4
                  sra          s2, t6, s1
                  mulhsu       a5, a0, s10
                  sltu         s1, s6, s7
                  auipc        t6, 95018
                  ori          a3, t5, 1088
                  c.xor        a3, a0
                  srai         s0, s4, 6
                  slli         gp, s11, 27
                  sra          s2, t6, s1
                  mulhsu       a5, a0, s10
                  c.li         ra, 9
                  addi         a5, a6, 639
                  sra          s2, t6, s1
                  sub          sp, a4, a4
                  mulhsu       a5, a0, s10
                  c.or         s1, a0
                  c.addi16sp   sp, 464
                  slli         gp, s11, 27
                  remu         t6, s2, s5
                  xor          a6, s1, sp
                  c.addi       s1, -1
                  c.addi4spn   a3, sp, 400
                  c.addi16sp   sp, 464
                  c.addi16sp   sp, 464
                  lui          a2, 494335
                  srl          a4, ra, s8
                  c.and        a2, a3
                  mul          s0, t0, a0
                  sra          s2, t6, s1
                  slli         gp, s11, 27
                  srai         s0, s4, 6
                  divu         s11, a1, gp
                  lui          a2, 494335
                  mul          s0, t0, a0
                  c.mv         a3, s10
                  remu         t6, s2, s5
                  sltu         s1, s6, s7
                  c.and        a2, a3
                  sltu         s1, s6, s7
                  lui          a2, 494335
                  slt          s3, a4, s5
                  auipc        t6, 95018
                  addi         a5, a6, 639
                  add          tp, a2, s8
                  c.slli       s5, 8
                  mulhsu       a5, a0, s10
                  srli         zero, ra, 0
                  mulhu        a0, t2, zero
                  xori         s9, a6, -2048
                  ori          a3, t5, 1088
                  div          sp, s2, s5
                  sltu         s1, s6, s7
                  c.li         ra, 9
                  sltiu        a4, t2, -709
                  sltu         s1, s6, s7
                  div          sp, s2, s5
                  c.addi       s1, -1
                  c.add        s4, a4
                  slt          s3, a4, s5
                  c.li         ra, 9
                  andi         t0, a0, -564
                  slt          s3, a4, s5
                  slt          s3, a4, s5
                  c.sub        a0, a5
                  xori         s9, a6, -2048
                  auipc        t6, 95018
                  lui          a2, 494335
                  c.andi       a5, 29
                  c.srai       a0, 24
                  c.srli       a4, 11
                  srai         s0, s4, 6
                  c.add        s4, a4
                  c.srli       a4, 11
                  xori         s9, a6, -2048
                  c.addi       s1, -1
                  c.addi16sp   sp, 464
                  srli         zero, ra, 0
                  srli         zero, ra, 0
                  sltiu        a4, t2, -709
                  srai         s0, s4, 6
                  srai         s0, s4, 6
                  xori         s9, a6, -2048
                  mulhsu       a5, a0, s10
                  xori         s9, a6, -2048
                  or           a5, a1, t6
                  c.addi4spn   a3, sp, 400
                  or           a5, a1, t6
                  c.srai       a0, 24
                  divu         s11, a1, gp
                  xor          a6, s1, sp
                  mulh         s4, s7, t5
                  c.slli       s5, 8
                  c.addi16sp   sp, 464
                  c.xor        a3, a0
                  add          tp, a2, s8
                  c.srai       a0, 24
                  c.addi       s1, -1
                  c.srli       a4, 11
                  lui          a2, 494335
                  c.slli       s5, 8
                  mulhsu       a5, a0, s10
                  c.add        s4, a4
                  sltu         s1, s6, s7
                  c.srai       a0, 24
                  c.addi16sp   sp, 464
                  c.addi16sp   sp, 464
                  mulh         s4, s7, t5
                  divu         s11, a1, gp
                  c.srai       a0, 24
                  sra          s2, t6, s1
                  c.andi       a5, 29
                  c.add        s4, a4
                  c.mv         a3, s10
                  lui          a2, 494335
                  c.srli       a4, 11
                  sub          sp, a4, a4
                  srai         s0, s4, 6
                  mulhsu       a5, a0, s10
                  auipc        t6, 95018
                  c.andi       a5, 29
                  srai         s0, s4, 6
                  srl          a4, ra, s8
                  rem          s3, a2, a3
                  mulhsu       a5, a0, s10
                  c.slli       s5, 8
                  slti         s3, s5, -238
                  lui          a2, 494335
                  lui          a2, 494335
                  c.add        s4, a4
                  slti         s3, s5, -238
                  auipc        t6, 95018
                  c.addi       s1, -1
                  c.add        s4, a4
                  auipc        t6, 95018
                  lui          a2, 494335
                  c.and        a2, a3
                  c.nop
                  sll          a1, s6, s9
                  c.or         s1, a0
                  ori          a3, t5, 1088
                  srai         s0, s4, 6
                  c.addi4spn   a3, sp, 400
                  auipc        t6, 95018
                  c.addi4spn   a3, sp, 400
                  mulhu        a0, t2, zero
                  addi         a5, a6, 639
                  sub          sp, a4, a4
                  slt          s3, a4, s5
                  c.addi4spn   a3, sp, 400
                  c.li         ra, 9
                  remu         t6, s2, s5
                  sra          s2, t6, s1
                  sltu         s1, s6, s7
                  srl          a4, ra, s8
                  c.add        s4, a4
                  mulhsu       a5, a0, s10
                  c.lui        a4, 9
                  sll          a1, s6, s9
                  c.or         s1, a0
                  c.nop
                  slti         s3, s5, -238
                  sra          s2, t6, s1
                  mulh         s4, s7, t5
                  auipc        t6, 95018
                  and          s9, s5, a4
                  slli         gp, s11, 27
                  srli         zero, ra, 0
                  sltiu        a4, t2, -709
                  rem          s3, a2, a3
                  xori         s9, a6, -2048
                  or           a5, a1, t6
                  srl          a4, ra, s8
                  mulh         s4, s7, t5
                  andi         t0, a0, -564
                  srai         s0, s4, 6
                  srli         zero, ra, 0
                  c.slli       s5, 8
                  sra          s2, t6, s1
                  c.srai       a0, 24
                  c.srai       a0, 24
                  c.addi4spn   a3, sp, 400
                  divu         s11, a1, gp
                  auipc        t6, 95018
                  c.and        a2, a3
                  sltiu        a4, t2, -709
                  srli         zero, ra, 0
                  c.xor        a3, a0
                  c.andi       a5, 29
                  xori         s9, a6, -2048
                  mul          s0, t0, a0
                  remu         t6, s2, s5
                  ori          a3, t5, 1088
                  c.addi16sp   sp, 464
                  c.nop
                  srai         s0, s4, 6
                  slt          s3, a4, s5
                  c.sub        a0, a5
                  slti         s3, s5, -238
                  c.srli       a4, 11
                  slli         gp, s11, 27
                  slli         gp, s11, 27
                  c.mv         a3, s10
                  c.xor        a3, a0
                  andi         t0, a0, -564
                  slti         s3, s5, -238
                  c.add        s4, a4
                  c.srli       a4, 11
                  addi         a5, a6, 639
                  sltiu        a4, t2, -709
                  c.or         s1, a0
                  and          s9, s5, a4
                  and          s9, s5, a4
                  slli         gp, s11, 27
                  srli         zero, ra, 0
                  remu         t6, s2, s5
                  add          tp, a2, s8
                  and          s9, s5, a4
                  and          s9, s5, a4
                  c.lui        a4, 9
                  nop
                  c.sub        a0, a5
                  mul          s0, t0, a0
                  and          s9, s5, a4
                  c.addi       s1, -1
                  srai         s0, s4, 6
                  addi         a5, a6, 639
                  c.srai       a0, 24
                  c.addi       s1, -1
                  c.mv         a3, s10
                  auipc        t6, 95018
                  c.srli       a4, 11
                  xori         s9, a6, -2048
                  remu         t6, s2, s5
                  auipc        t6, 95018
                  c.addi16sp   sp, 464
                  sltiu        a4, t2, -709
                  remu         t6, s2, s5
                  slli         gp, s11, 27
                  divu         s11, a1, gp
                  c.and        a2, a3
                  divu         s11, a1, gp
                  sltiu        a4, t2, -709
                  c.li         ra, 9
                  c.andi       a5, 29
                  srl          a4, ra, s8
                  c.and        a2, a3
                  add          tp, a2, s8
                  divu         s11, a1, gp
                  mulh         s4, s7, t5
                  sltiu        a4, t2, -709
                  xor          a6, s1, sp
                  c.nop
                  c.addi16sp   sp, 464
                  andi         t0, a0, -564
                  c.addi4spn   a3, sp, 400
                  srl          a4, ra, s8
                  srli         zero, ra, 0
                  c.and        a2, a3
                  sll          a1, s6, s9
                  c.li         ra, 9
                  ori          a3, t5, 1088
                  addi         a5, a6, 639
                  auipc        t6, 95018
                  srli         zero, ra, 0
                  c.sub        a0, a5
                  sltu         s1, s6, s7
                  srai         s0, s4, 6
                  c.lui        a4, 9
                  mulhu        a0, t2, zero
                  sub          sp, a4, a4
                  remu         t6, s2, s5
                  srl          a4, ra, s8
                  ori          a3, t5, 1088
                  srli         zero, ra, 0
                  c.or         s1, a0
                  slt          s3, a4, s5
                  rem          s3, a2, a3
                  c.addi       s1, -1
                  c.and        a2, a3
                  c.mv         a3, s10
                  sltiu        a4, t2, -709
                  rem          s3, a2, a3
                  c.addi       s1, -1
                  srli         zero, ra, 0
                  srai         s0, s4, 6
                  c.and        a2, a3
                  c.nop
                  slli         gp, s11, 27
                  c.srli       a4, 11
                  xor          a6, s1, sp
                  ori          a3, t5, 1088
                  nop
                  addi         a5, a6, 639
                  xori         s9, a6, -2048
                  srl          a4, ra, s8
                  lui          a2, 494335
                  mul          s0, t0, a0
                  c.srli       a4, 11
                  c.xor        a3, a0
                  div          sp, s2, s5
                  c.addi4spn   a3, sp, 400
                  auipc        t6, 95018
                  c.srli       a4, 11
                  xor          a6, s1, sp
                  c.addi4spn   a3, sp, 400
                  addi         a5, a6, 639
                  remu         t6, s2, s5
                  lui          a2, 494335
                  srl          a4, ra, s8
                  c.slli       s5, 8
                  slli         gp, s11, 27
                  c.sub        a0, a5
                  c.xor        a3, a0
                  slli         gp, s11, 27
                  c.sub        a0, a5
                  div          sp, s2, s5
                  c.mv         a3, s10
                  mulh         s4, s7, t5
                  c.sub        a0, a5
                  mul          s0, t0, a0
                  rem          s3, a2, a3
                  xor          a6, s1, sp
                  sltu         s1, s6, s7
                  c.xor        a3, a0
                  rem          s3, a2, a3
                  c.li         ra, 9
                  mulhsu       a5, a0, s10
                  c.mv         a3, s10
                  c.or         s1, a0
                  srli         zero, ra, 0
                  c.li         ra, 9
                  c.srli       a4, 11
                  c.andi       a5, 29
                  sra          s2, t6, s1
                  div          sp, s2, s5
                  mulhu        a0, t2, zero
                  sub          sp, a4, a4
                  mulhsu       a5, a0, s10
                  c.add        s4, a4
                  mul          s0, t0, a0
                  li           tp, 0xffffffff #start riscv_int_numeric_corner_stream_38
                  li           a4, 0x80000000
                  li           s8, 0xffffffff
                  li           s0, 0x80000000
                  li           s9, 0x80000000
                  li           t5, 0xffffffff
                  li           gp, 0x0
                  li           s2, 0x0
                  li           s11, 0x59bafbed
                  li           s5, 0x0
                  lui          s0, 494335
                  addi         a4, gp, 639
                  sub          s0, tp, gp
                  addi         a4, gp, 639
                  mulh         s2, s9, s11
                  rem          a4, s5, a4
                  mulh         s2, s9, s11
                  mulhu        gp, s9, gp
                  auipc        s9, 95018
                  auipc        s9, 95018
                  mulhu        gp, s9, gp
                  mulh         s2, s9, s11
                  auipc        s9, 95018
                  divu         t5, s2, a4
                  addi         a4, gp, 639
                  mul          s11, s5, s5
                  rem          a4, s5, a4
                  rem          a4, s5, a4
                  rem          a4, s5, a4
                  auipc        s9, 95018
                  nop
                  addi         a4, gp, 639
                  remu         s5, s0, s5
                  mulh         s2, s9, s11
                  rem          a4, s5, a4
                  div          s0, s0, s5
                  remu         s5, s0, s5 #end riscv_int_numeric_corner_stream_38
                  sltu         s1, s6, s7
                  sub          sp, a4, a4
                  c.nop
                  c.xor        a3, a0
                  c.add        s4, a4
                  lui          a2, 494335
                  mulh         s4, s7, t5
                  c.srai       a0, 24
                  c.addi16sp   sp, 464
                  c.li         ra, 9
                  c.and        a2, a3
                  or           a5, a1, t6
                  sra          s2, t6, s1
                  auipc        t6, 95018
                  c.or         s1, a0
                  remu         t6, s2, s5
                  ori          a3, t5, 1088
                  add          tp, a2, s8
                  srli         zero, ra, 0
                  c.srai       a0, 24
                  mulh         s4, s7, t5
                  nop
                  mulh         s4, s7, t5
                  c.slli       s5, 8
                  slti         s3, s5, -238
                  c.or         s1, a0
                  slli         gp, s11, 27
                  mulh         s4, s7, t5
                  c.addi16sp   sp, 464
                  srl          a4, ra, s8
                  c.addi16sp   sp, 464
                  rem          s3, a2, a3
                  c.xor        a3, a0
                  c.li         ra, 9
                  c.addi       s1, -1
                  add          tp, a2, s8
                  c.li         ra, 9
                  or           a5, a1, t6
                  c.addi4spn   a3, sp, 400
                  mulhsu       a5, a0, s10
                  xori         s9, a6, -2048
                  c.lui        a4, 9
                  mulh         s4, s7, t5
                  add          tp, a2, s8
                  nop
                  addi         a5, a6, 639
                  c.lui        a4, 9
                  add          tp, a2, s8
                  mul          s0, t0, a0
                  c.mv         a3, s10
                  sltiu        a4, t2, -709
                  c.srai       a0, 24
                  auipc        t6, 95018
                  rem          s3, a2, a3
                  mul          s0, t0, a0
                  sra          s2, t6, s1
                  ori          a3, t5, 1088
                  slt          s3, a4, s5
                  mulhsu       a5, a0, s10
                  mulhu        a0, t2, zero
                  divu         s11, a1, gp
                  sra          s2, t6, s1
                  or           a5, a1, t6
                  c.nop
                  c.and        a2, a3
                  xori         s9, a6, -2048
                  nop
                  c.sub        a0, a5
                  xor          a6, s1, sp
                  slti         s3, s5, -238
                  mul          s0, t0, a0
                  c.mv         a3, s10
                  nop
                  c.and        a2, a3
                  c.xor        a3, a0
                  c.xor        a3, a0
                  remu         t6, s2, s5
                  c.lui        a4, 9
                  auipc        t6, 95018
                  or           a5, a1, t6
                  c.mv         a3, s10
                  andi         t0, a0, -564
                  c.srai       a0, 24
                  c.or         s1, a0
                  ori          a3, t5, 1088
                  srli         zero, ra, 0
                  c.or         s1, a0
                  c.slli       s5, 8
                  c.addi16sp   sp, 464
                  c.nop
                  c.nop
                  ori          a3, t5, 1088
                  mulh         s4, s7, t5
                  andi         t0, a0, -564
                  nop
                  c.li         ra, 9
                  c.lui        a4, 9
                  c.nop
                  sltiu        a4, t2, -709
                  srli         zero, ra, 0
                  lui          a2, 494335
                  c.add        s4, a4
                  srl          a4, ra, s8
                  or           a5, a1, t6
                  mul          s0, t0, a0
                  xor          a6, s1, sp
                  xor          a6, s1, sp
                  c.lui        a4, 9
                  andi         t0, a0, -564
                  addi         a5, a6, 639
                  xori         s9, a6, -2048
                  div          sp, s2, s5
                  sub          sp, a4, a4
                  c.add        s4, a4
                  nop
                  xor          a6, s1, sp
                  srai         s0, s4, 6
                  c.srai       a0, 24
                  sub          sp, a4, a4
                  ori          a3, t5, 1088
                  sra          s2, t6, s1
                  c.slli       s5, 8
                  sltu         s1, s6, s7
                  c.andi       a5, 29
                  c.andi       a5, 29
                  c.addi4spn   a3, sp, 400
                  srli         zero, ra, 0
                  rem          s3, a2, a3
                  c.sub        a0, a5
                  auipc        t6, 95018
                  c.slli       s5, 8
                  c.nop
                  remu         t6, s2, s5
                  add          tp, a2, s8
                  srli         zero, ra, 0
                  mulhsu       a5, a0, s10
                  srl          a4, ra, s8
                  or           a5, a1, t6
                  c.sub        a0, a5
                  add          tp, a2, s8
                  sltu         s1, s6, s7
                  slti         s3, s5, -238
                  ori          a3, t5, 1088
                  addi         a5, a6, 639
                  slti         s3, s5, -238
                  mulhsu       a5, a0, s10
                  rem          s3, a2, a3
                  srl          a4, ra, s8
                  c.slli       s5, 8
                  c.or         s1, a0
                  sltiu        a4, t2, -709
                  rem          s3, a2, a3
                  divu         s11, a1, gp
                  srl          a4, ra, s8
                  sltiu        a4, t2, -709
                  c.add        s4, a4
                  lui          a2, 494335
                  rem          s3, a2, a3
                  andi         t0, a0, -564
                  divu         s11, a1, gp
                  mulhu        a0, t2, zero
                  sra          s2, t6, s1
                  mul          s0, t0, a0
                  c.nop
                  c.or         s1, a0
                  xor          a6, s1, sp
                  andi         t0, a0, -564
                  sltu         s1, s6, s7
                  srl          a4, ra, s8
                  c.srai       a0, 24
                  sltiu        a4, t2, -709
                  c.xor        a3, a0
                  c.andi       a5, 29
                  or           a5, a1, t6
                  sll          a1, s6, s9
                  andi         t0, a0, -564
                  c.addi16sp   sp, 464
                  c.sub        a0, a5
                  auipc        t6, 95018
                  c.li         ra, 9
                  srl          a4, ra, s8
                  xor          a6, s1, sp
                  c.nop
                  add          tp, a2, s8
                  srl          a4, ra, s8
                  srl          a4, ra, s8
                  andi         t0, a0, -564
                  or           a5, a1, t6
                  divu         s11, a1, gp
                  c.srli       a4, 11
                  mulh         s4, s7, t5
                  rem          s3, a2, a3
                  c.addi       s1, -1
                  sub          sp, a4, a4
                  c.xor        a3, a0
                  c.and        a2, a3
                  sltu         s1, s6, s7
                  div          sp, s2, s5
                  sub          sp, a4, a4
                  c.srli       a4, 11
                  srl          a4, ra, s8
                  c.addi       s1, -1
                  c.lui        a4, 9
                  c.xor        a3, a0
                  srli         zero, ra, 0
                  and          s9, s5, a4
                  c.lui        a4, 9
                  srli         zero, ra, 0
                  srl          a4, ra, s8
                  c.or         s1, a0
                  c.add        s4, a4
                  slt          s3, a4, s5
                  c.add        s4, a4
                  remu         t6, s2, s5
                  andi         t0, a0, -564
                  li           a5, 0xffffffff #start riscv_int_numeric_corner_stream_20
                  li           a1, 0x7a1fbe1c
                  li           a6, 0x0
                  li           t1, 0x80000000
                  li           t0, 0x13c02a35
                  li           tp, 0x1e66959c
                  li           s3, 0xffffffff
                  li           ra, 0xffffffff
                  li           a7, 0x80000000
                  li           t4, 0xf6a3bb42
                  mulh         a1, a7, s3
                  div          t0, t0, a5
                  div          t0, t0, a5
                  rem          t1, a5, t1
                  add          a1, a7, s3
                  mulhu        ra, a7, ra
                  mulhu        ra, a7, ra
                  addi         t1, ra, 639
                  auipc        a7, 95018
                  lui          t0, 494335
                  sub          t0, tp, ra
                  auipc        a7, 95018
                  sub          t0, tp, ra
                  mulhu        ra, a7, ra
                  mul          s3, a5, a5
                  add          a1, a7, s3
                  lui          t0, 494335
                  mulhsu       t1, a1, tp
                  rem          t1, a5, t1
                  lui          t0, 494335
                  div          t0, t0, a5 #end riscv_int_numeric_corner_stream_20
                  c.addi16sp   sp, 464
                  slt          s3, a4, s5
                  c.xor        a3, a0
                  mulh         s4, s7, t5
                  c.xor        a3, a0
                  sra          s2, t6, s1
                  andi         t0, a0, -564
                  mulhsu       a5, a0, s10
                  c.and        a2, a3
                  c.xor        a3, a0
                  xori         s9, a6, -2048
                  andi         t0, a0, -564
                  and          s9, s5, a4
                  lui          a2, 494335
                  srl          a4, ra, s8
                  sub          sp, a4, a4
                  divu         s11, a1, gp
                  divu         s11, a1, gp
                  nop
                  sltiu        a4, t2, -709
                  c.nop
                  c.srai       a0, 24
                  auipc        t6, 95018
                  mul          s0, t0, a0
                  sra          s2, t6, s1
                  xori         s9, a6, -2048
                  c.andi       a5, 29
                  lui          a2, 494335
                  c.srai       a0, 24
                  remu         t6, s2, s5
                  c.addi       s1, -1
                  mul          s0, t0, a0
                  div          sp, s2, s5
                  remu         t6, s2, s5
                  srl          a4, ra, s8
                  and          s9, s5, a4
                  mulhu        a0, t2, zero
                  c.slli       s5, 8
                  andi         t0, a0, -564
                  slli         gp, s11, 27
                  c.addi4spn   a3, sp, 400
                  c.addi       s1, -1
                  nop
                  remu         t6, s2, s5
                  c.addi       s1, -1
                  divu         s11, a1, gp
                  add          tp, a2, s8
                  slti         s3, s5, -238
                  lui          a2, 494335
                  nop
                  or           a5, a1, t6
                  andi         t0, a0, -564
                  xor          a6, s1, sp
                  c.nop
                  auipc        t6, 95018
                  div          sp, s2, s5
                  c.or         s1, a0
                  sltiu        a4, t2, -709
                  sltiu        a4, t2, -709
                  xori         s9, a6, -2048
                  div          sp, s2, s5
                  auipc        t6, 95018
                  srl          a4, ra, s8
                  c.mv         a3, s10
                  xor          a6, s1, sp
                  ori          a3, t5, 1088
                  lui          a2, 494335
                  c.mv         a3, s10
                  c.xor        a3, a0
                  mul          s0, t0, a0
                  div          sp, s2, s5
                  srai         s0, s4, 6
                  c.andi       a5, 29
                  c.andi       a5, 29
                  lui          a2, 494335
                  lui          a2, 494335
                  c.sub        a0, a5
                  c.addi4spn   a3, sp, 400
                  nop
                  addi         a5, a6, 639
                  c.andi       a5, 29
                  c.addi       s1, -1
                  auipc        t6, 95018
                  c.add        s4, a4
                  add          tp, a2, s8
                  c.li         ra, 9
                  nop
                  div          sp, s2, s5
                  sra          s2, t6, s1
                  c.nop
                  ori          a3, t5, 1088
                  ori          a3, t5, 1088
                  xori         s9, a6, -2048
                  slti         s3, s5, -238
                  srai         s0, s4, 6
                  ori          a3, t5, 1088
                  c.srai       a0, 24
                  or           a5, a1, t6
                  slli         gp, s11, 27
                  c.mv         a3, s10
                  c.nop
                  sra          s2, t6, s1
                  c.add        s4, a4
                  nop
                  add          tp, a2, s8
                  lui          a2, 494335
                  sub          sp, a4, a4
                  sltu         s1, s6, s7
                  nop
                  mul          s0, t0, a0
                  sub          sp, a4, a4
                  sub          sp, a4, a4
                  addi         a5, a6, 639
                  xori         s9, a6, -2048
                  div          sp, s2, s5
                  sra          s2, t6, s1
                  add          tp, a2, s8
                  mulhu        a0, t2, zero
                  sub          sp, a4, a4
                  sltu         s1, s6, s7
                  addi         a5, a6, 639
                  c.addi16sp   sp, 464
                  c.addi4spn   a3, sp, 400
                  c.srli       a4, 11
                  c.lui        a4, 9
                  rem          s3, a2, a3
                  c.and        a2, a3
                  srl          a4, ra, s8
                  srli         zero, ra, 0
                  ori          a3, t5, 1088
                  xori         s9, a6, -2048
                  remu         t6, s2, s5
                  c.add        s4, a4
                  slli         gp, s11, 27
                  c.add        s4, a4
                  srli         zero, ra, 0
                  and          s9, s5, a4
                  c.or         s1, a0
                  mulhsu       a5, a0, s10
                  c.mv         a3, s10
                  sra          s2, t6, s1
                  c.andi       a5, 29
                  c.addi       s1, -1
                  sub          sp, a4, a4
                  c.nop
                  add          tp, a2, s8
                  add          tp, a2, s8
                  c.andi       a5, 29
                  c.sub        a0, a5
                  and          s9, s5, a4
                  ori          a3, t5, 1088
                  or           a5, a1, t6
                  mulhsu       a5, a0, s10
                  div          sp, s2, s5
                  addi         a5, a6, 639
                  sub          sp, a4, a4
                  c.or         s1, a0
                  mulh         s4, s7, t5
                  remu         t6, s2, s5
                  slti         s3, s5, -238
                  rem          s3, a2, a3
                  slti         s3, s5, -238
                  xor          a6, s1, sp
                  c.sub        a0, a5
                  auipc        t6, 95018
                  c.srli       a4, 11
                  sltu         s1, s6, s7
                  c.li         ra, 9
                  sltu         s1, s6, s7
                  or           a5, a1, t6
                  andi         t0, a0, -564
                  divu         s11, a1, gp
                  addi         a5, a6, 639
                  sltu         s1, s6, s7
                  sltu         s1, s6, s7
                  sltiu        a4, t2, -709
                  c.lui        a4, 9
                  xori         s9, a6, -2048
                  srl          a4, ra, s8
                  div          sp, s2, s5
                  c.xor        a3, a0
                  auipc        t6, 95018
                  mulh         s4, s7, t5
                  c.nop
                  mul          s0, t0, a0
                  slti         s3, s5, -238
                  addi         a5, a6, 639
                  c.mv         a3, s10
                  c.li         ra, 9
                  sra          s2, t6, s1
                  c.srai       a0, 24
                  mul          s0, t0, a0
                  nop
                  auipc        t6, 95018
                  c.sub        a0, a5
                  c.addi       s1, -1
                  xor          a6, s1, sp
                  remu         t6, s2, s5
                  remu         t6, s2, s5
                  c.addi16sp   sp, 464
                  c.xor        a3, a0
                  sltiu        a4, t2, -709
                  andi         t0, a0, -564
                  sra          s2, t6, s1
                  mulh         s4, s7, t5
                  sub          sp, a4, a4
                  c.or         s1, a0
                  xor          a6, s1, sp
                  c.and        a2, a3
                  c.sub        a0, a5
                  c.srai       a0, 24
                  srl          a4, ra, s8
                  sltiu        a4, t2, -709
                  div          sp, s2, s5
                  c.and        a2, a3
                  andi         t0, a0, -564
                  srl          a4, ra, s8
                  divu         s11, a1, gp
                  c.sub        a0, a5
                  div          sp, s2, s5
                  srl          a4, ra, s8
                  c.addi16sp   sp, 464
                  srai         s0, s4, 6
                  srai         s0, s4, 6
                  mulh         s4, s7, t5
                  mulhsu       a5, a0, s10
                  xor          a6, s1, sp
                  slli         gp, s11, 27
                  c.addi       s1, -1
                  c.addi       s1, -1
                  c.and        a2, a3
                  c.lui        a4, 9
                  sra          s2, t6, s1
                  c.add        s4, a4
                  c.srli       a4, 11
                  remu         t6, s2, s5
                  c.and        a2, a3
                  c.sub        a0, a5
                  c.srli       a4, 11
                  srl          a4, ra, s8
                  slli         gp, s11, 27
                  mulhsu       a5, a0, s10
                  c.nop
                  sub          sp, a4, a4
                  c.srai       a0, 24
                  and          s9, s5, a4
                  c.xor        a3, a0
                  nop
                  nop
                  c.and        a2, a3
                  sll          a1, s6, s9
                  slt          s3, a4, s5
                  mulhsu       a5, a0, s10
                  or           a5, a1, t6
                  sltiu        a4, t2, -709
                  c.xor        a3, a0
                  and          s9, s5, a4
                  c.li         ra, 9
                  addi         a5, a6, 639
                  add          tp, a2, s8
                  addi         a5, a6, 639
                  c.addi16sp   sp, 464
                  mulh         s4, s7, t5
                  xori         s9, a6, -2048
                  or           a5, a1, t6
                  srai         s0, s4, 6
                  sub          sp, a4, a4
                  c.add        s4, a4
                  auipc        t6, 95018
                  c.slli       s5, 8
                  c.or         s1, a0
                  c.nop
                  c.addi       s1, -1
                  sltu         s1, s6, s7
                  c.add        s4, a4
                  and          s9, s5, a4
                  remu         t6, s2, s5
                  slti         s3, s5, -238
                  mulhu        a0, t2, zero
                  c.addi       s1, -1
                  srai         s0, s4, 6
                  c.nop
                  mulhsu       a5, a0, s10
                  c.srli       a4, 11
                  mulhsu       a5, a0, s10
                  slti         s3, s5, -238
                  c.addi       s1, -1
                  c.sub        a0, a5
                  c.addi16sp   sp, 464
                  auipc        t6, 95018
                  c.slli       s5, 8
                  c.xor        a3, a0
                  andi         t0, a0, -564
                  div          sp, s2, s5
                  c.addi16sp   sp, 464
                  sra          s2, t6, s1
                  ori          a3, t5, 1088
                  divu         s11, a1, gp
                  c.sub        a0, a5
                  c.and        a2, a3
                  mulhsu       a5, a0, s10
                  auipc        t6, 95018
                  srli         zero, ra, 0
                  or           a5, a1, t6
                  slti         s3, s5, -238
                  c.lui        a4, 9
                  c.lui        a4, 9
                  or           a5, a1, t6
                  sll          a1, s6, s9
                  and          s9, s5, a4
                  c.addi4spn   a3, sp, 400
                  slti         s3, s5, -238
                  c.andi       a5, 29
                  nop
                  div          sp, s2, s5
                  sltu         s1, s6, s7
                  auipc        t6, 95018
                  nop
                  slli         gp, s11, 27
                  div          sp, s2, s5
                  c.slli       s5, 8
                  srli         zero, ra, 0
                  mul          s0, t0, a0
                  c.addi       s1, -1
                  c.or         s1, a0
                  c.srai       a0, 24
                  rem          s3, a2, a3
                  add          tp, a2, s8
                  c.srli       a4, 11
                  c.and        a2, a3
                  ori          a3, t5, 1088
                  remu         t6, s2, s5
                  andi         t0, a0, -564
                  c.xor        a3, a0
                  c.slli       s5, 8
                  auipc        t6, 95018
                  c.srli       a4, 11
                  lui          a2, 494335
                  rem          s3, a2, a3
                  sll          a1, s6, s9
                  sra          s2, t6, s1
                  c.addi       s1, -1
                  c.slli       s5, 8
                  xor          a6, s1, sp
                  mulh         s4, s7, t5
                  nop
                  c.srli       a4, 11
                  divu         s11, a1, gp
                  xor          a6, s1, sp
                  srai         s0, s4, 6
                  sltu         s1, s6, s7
                  c.add        s4, a4
                  mulhu        a0, t2, zero
                  c.andi       a5, 29
                  mul          s0, t0, a0
                  c.srai       a0, 24
                  c.andi       a5, 29
                  remu         t6, s2, s5
                  or           a5, a1, t6
                  c.srai       a0, 24
                  slt          s3, a4, s5
                  c.nop
                  rem          s3, a2, a3
                  srai         s0, s4, 6
                  xori         s9, a6, -2048
                  c.addi       s1, -1
                  c.addi4spn   a3, sp, 400
                  c.add        s4, a4
                  and          s9, s5, a4
                  remu         t6, s2, s5
                  auipc        t6, 95018
                  c.lui        a4, 9
                  c.or         s1, a0
                  slti         s3, s5, -238
                  srai         s0, s4, 6
                  ori          a3, t5, 1088
                  or           a5, a1, t6
                  andi         t0, a0, -564
                  c.addi       s1, -1
                  sra          s2, t6, s1
                  c.srli       a4, 11
                  and          s9, s5, a4
                  c.add        s4, a4
                  c.nop
                  srli         zero, ra, 0
                  sltiu        a4, t2, -709
                  c.add        s4, a4
                  sll          a1, s6, s9
                  add          tp, a2, s8
                  c.lui        a4, 9
                  c.srli       a4, 11
                  sltiu        a4, t2, -709
                  srai         s0, s4, 6
                  mulhsu       a5, a0, s10
                  sll          a1, s6, s9
                  c.mv         a3, s10
                  remu         t6, s2, s5
                  srai         s0, s4, 6
                  c.addi       s1, -1
                  addi         a5, a6, 639
                  c.slli       s5, 8
                  lui          a2, 494335
                  add          tp, a2, s8
                  rem          s3, a2, a3
                  c.nop
                  nop
                  divu         s11, a1, gp
                  c.xor        a3, a0
                  remu         t6, s2, s5
                  c.sub        a0, a5
                  mulh         s4, s7, t5
                  slti         s3, s5, -238
                  ori          a3, t5, 1088
                  sra          s2, t6, s1
                  sra          s2, t6, s1
                  mulhu        a0, t2, zero
                  rem          s3, a2, a3
                  c.srli       a4, 11
                  srli         zero, ra, 0
                  srai         s0, s4, 6
                  nop
                  c.addi4spn   a3, sp, 400
                  or           a5, a1, t6
                  sltu         s1, s6, s7
                  c.mv         a3, s10
                  c.sub        a0, a5
                  c.xor        a3, a0
                  c.addi       s1, -1
                  c.addi16sp   sp, 464
                  sltu         s1, s6, s7
                  srl          a4, ra, s8
                  sra          s2, t6, s1
                  c.xor        a3, a0
                  slti         s3, s5, -238
                  c.lui        a4, 9
                  mulhu        a0, t2, zero
                  c.addi4spn   a3, sp, 400
                  xori         s9, a6, -2048
                  addi         a5, a6, 639
                  add          tp, a2, s8
                  c.lui        a4, 9
                  slli         gp, s11, 27
                  xor          a6, s1, sp
                  c.addi       s1, -1
                  sra          s2, t6, s1
                  and          s9, s5, a4
                  sub          sp, a4, a4
                  xor          a6, s1, sp
                  rem          s3, a2, a3
                  c.addi       s1, -1
                  divu         s11, a1, gp
                  c.xor        a3, a0
                  slli         gp, s11, 27
                  or           a5, a1, t6
                  auipc        t6, 95018
                  sll          a1, s6, s9
                  xori         s9, a6, -2048
                  remu         t6, s2, s5
                  c.or         s1, a0
                  lui          a2, 494335
                  rem          s3, a2, a3
                  c.add        s4, a4
                  c.addi       s1, -1
                  c.andi       a5, 29
                  or           a5, a1, t6
                  slti         s3, s5, -238
                  slt          s3, a4, s5
                  xori         s9, a6, -2048
                  c.srai       a0, 24
                  xor          a6, s1, sp
                  slti         s3, s5, -238
                  sra          s2, t6, s1
                  c.addi16sp   sp, 464
                  mul          s0, t0, a0
                  c.add        s4, a4
                  c.slli       s5, 8
                  ori          a3, t5, 1088
                  div          sp, s2, s5
                  slli         gp, s11, 27
                  srl          a4, ra, s8
                  addi         a5, a6, 639
                  and          s9, s5, a4
                  ori          a3, t5, 1088
                  remu         t6, s2, s5
                  divu         s11, a1, gp
                  c.mv         a3, s10
                  or           a5, a1, t6
                  slt          s3, a4, s5
                  c.and        a2, a3
                  c.nop
                  mul          s0, t0, a0
                  divu         s11, a1, gp
                  addi         a5, a6, 639
                  c.li         ra, 9
                  c.xor        a3, a0
                  c.add        s4, a4
                  c.sub        a0, a5
                  sra          s2, t6, s1
                  c.slli       s5, 8
                  sub          sp, a4, a4
                  add          tp, a2, s8
                  sub          sp, a4, a4
                  mulhsu       a5, a0, s10
                  c.andi       a5, 29
                  mul          s0, t0, a0
                  and          s9, s5, a4
                  divu         s11, a1, gp
                  slli         gp, s11, 27
                  srli         zero, ra, 0
                  c.lui        a4, 9
                  addi         a5, a6, 639
                  c.xor        a3, a0
                  add          tp, a2, s8
                  c.xor        a3, a0
                  c.lui        a4, 9
                  mul          s0, t0, a0
                  sub          sp, a4, a4
                  andi         t0, a0, -564
                  or           a5, a1, t6
                  div          sp, s2, s5
                  sll          a1, s6, s9
                  mulh         s4, s7, t5
                  srl          a4, ra, s8
                  lui          a2, 494335
                  mulhu        a0, t2, zero
                  nop
                  xori         s9, a6, -2048
                  c.andi       a5, 29
                  srli         zero, ra, 0
                  remu         t6, s2, s5
                  mulhsu       a5, a0, s10
                  or           a5, a1, t6
                  slt          s3, a4, s5
                  c.nop
                  mulhu        a0, t2, zero
                  srli         zero, ra, 0
                  c.xor        a3, a0
                  c.andi       a5, 29
                  nop
                  auipc        t6, 95018
                  or           a5, a1, t6
                  c.nop
                  add          tp, a2, s8
                  c.and        a2, a3
                  sltiu        a4, t2, -709
                  c.addi4spn   a3, sp, 400
                  c.sub        a0, a5
                  srai         s0, s4, 6
                  or           a5, a1, t6
                  andi         t0, a0, -564
                  c.addi16sp   sp, 464
                  auipc        t6, 95018
                  c.sub        a0, a5
                  srli         zero, ra, 0
                  or           a5, a1, t6
                  xori         s9, a6, -2048
                  remu         t6, s2, s5
                  mulhu        a0, t2, zero
                  andi         t0, a0, -564
                  c.addi4spn   a3, sp, 400
                  slti         s3, s5, -238
                  c.srli       a4, 11
                  mulhu        a0, t2, zero
                  c.li         ra, 9
                  mulhsu       a5, a0, s10
                  c.add        s4, a4
                  mul          s0, t0, a0
                  nop
                  c.andi       a5, 29
                  mulhsu       a5, a0, s10
                  c.mv         a3, s10
                  mulh         s4, s7, t5
                  auipc        t6, 95018
                  c.xor        a3, a0
                  sltu         s1, s6, s7
                  slti         s3, s5, -238
                  rem          s3, a2, a3
                  c.xor        a3, a0
                  c.and        a2, a3
                  c.addi4spn   a3, sp, 400
                  c.srai       a0, 24
                  srli         zero, ra, 0
                  sra          s2, t6, s1
                  c.srai       a0, 24
                  sra          s2, t6, s1
                  c.and        a2, a3
                  srl          a4, ra, s8
                  add          tp, a2, s8
                  c.li         ra, 9
                  c.addi16sp   sp, 464
                  sll          a1, s6, s9
                  mul          s0, t0, a0
                  div          sp, s2, s5
                  slt          s3, a4, s5
                  mulh         s4, s7, t5
                  sltu         s1, s6, s7
                  auipc        t6, 95018
                  divu         s11, a1, gp
                  mulh         s4, s7, t5
                  slt          s3, a4, s5
                  auipc        t6, 95018
                  srl          a4, ra, s8
                  sra          s2, t6, s1
                  andi         t0, a0, -564
                  srai         s0, s4, 6
                  auipc        t6, 95018
                  sub          sp, a4, a4
                  sltu         s1, s6, s7
                  mulh         s4, s7, t5
                  andi         t0, a0, -564
                  c.addi4spn   a3, sp, 400
                  c.srli       a4, 11
                  c.addi4spn   a3, sp, 400
                  srl          a4, ra, s8
                  mulhu        a0, t2, zero
                  sltu         s1, s6, s7
                  c.lui        a4, 9
                  c.sub        a0, a5
                  c.sub        a0, a5
                  c.nop
                  sra          s2, t6, s1
                  c.srli       a4, 11
                  remu         t6, s2, s5
                  slti         s3, s5, -238
                  c.xor        a3, a0
                  srai         s0, s4, 6
                  c.slli       s5, 8
                  c.addi16sp   sp, 464
                  c.nop
                  slt          s3, a4, s5
                  c.li         ra, 9
                  auipc        t6, 95018
                  xori         s9, a6, -2048
                  slti         s3, s5, -238
                  addi         a5, a6, 639
                  c.srai       a0, 24
                  c.slli       s5, 8
                  c.lui        a4, 9
                  divu         s11, a1, gp
                  andi         t0, a0, -564
                  sltiu        a4, t2, -709
                  c.or         s1, a0
                  sltiu        a4, t2, -709
                  sra          s2, t6, s1
                  sltu         s1, s6, s7
                  c.xor        a3, a0
                  c.slli       s5, 8
                  c.add        s4, a4
                  sll          a1, s6, s9
                  mulh         s4, s7, t5
                  c.addi       s1, -1
                  sltu         s1, s6, s7
                  remu         t6, s2, s5
                  divu         s11, a1, gp
                  divu         s11, a1, gp
                  srai         s0, s4, 6
                  srai         s0, s4, 6
                  and          s9, s5, a4
                  xori         s9, a6, -2048
                  c.add        s4, a4
                  slti         s3, s5, -238
                  c.addi       s1, -1
                  mulhu        a0, t2, zero
                  mulhu        a0, t2, zero
                  c.addi       s1, -1
                  ori          a3, t5, 1088
                  c.and        a2, a3
                  c.and        a2, a3
                  div          sp, s2, s5
                  sltiu        a4, t2, -709
                  rem          s3, a2, a3
                  xor          a6, s1, sp
                  mul          s0, t0, a0
                  srl          a4, ra, s8
                  c.srli       a4, 11
                  slli         gp, s11, 27
                  c.and        a2, a3
                  c.and        a2, a3
                  and          s9, s5, a4
                  slt          s3, a4, s5
                  c.li         ra, 9
                  slt          s3, a4, s5
                  mul          s0, t0, a0
                  mulhu        a0, t2, zero
                  c.addi4spn   a3, sp, 400
                  mulhsu       a5, a0, s10
                  srl          a4, ra, s8
                  li           t5, 0xed57479b #start riscv_int_numeric_corner_stream_1
                  li           s3, 0x0
                  li           a6, 0xb1cfcea
                  li           t4, 0xffffffff
                  li           t0, 0xffffffff
                  li           sp, 0x80000000
                  li           gp, 0x80000000
                  li           a0, 0x7ef35620
                  li           s1, 0xffffffff
                  li           a1, 0xffe5b32e
                  mul          t4, a1, a1
                  div          t0, t0, a1
                  mul          t4, a1, a1
                  div          t0, t0, a1
                  mulhsu       s1, a0, gp
                  auipc        s3, 95018
                  nop
                  addi         s1, sp, 639
                  sub          t0, gp, sp
                  mul          t4, a1, a1
                  sub          t0, gp, sp
                  div          t0, t0, a1
                  remu         a1, t0, a1
                  mulhsu       s1, a0, gp
                  lui          t0, 494335
                  mulhu        sp, s3, sp
                  mulhu        sp, s3, sp #end riscv_int_numeric_corner_stream_1
                  c.nop
                  divu         s11, a1, gp
                  and          s9, s5, a4
                  mul          s0, t0, a0
                  c.mv         a3, s10
                  slt          s3, a4, s5
                  c.nop
                  sra          s2, t6, s1
                  andi         t0, a0, -564
                  slt          s3, a4, s5
                  ori          a3, t5, 1088
                  remu         t6, s2, s5
                  c.mv         a3, s10
                  c.mv         a3, s10
                  or           a5, a1, t6
                  andi         t0, a0, -564
                  andi         t0, a0, -564
                  srli         zero, ra, 0
                  c.addi       s1, -1
                  c.xor        a3, a0
                  c.add        s4, a4
                  slli         gp, s11, 27
                  divu         s11, a1, gp
                  mulhsu       a5, a0, s10
                  div          sp, s2, s5
                  srai         s0, s4, 6
                  div          sp, s2, s5
                  sltu         s1, s6, s7
                  auipc        t6, 95018
                  div          sp, s2, s5
                  slt          s3, a4, s5
                  slli         gp, s11, 27
                  sll          a1, s6, s9
                  sltu         s1, s6, s7
                  c.addi4spn   a3, sp, 400
                  c.slli       s5, 8
                  mulhsu       a5, a0, s10
                  sll          a1, s6, s9
                  c.addi16sp   sp, 464
                  ori          a3, t5, 1088
                  sra          s2, t6, s1
                  lui          a2, 494335
                  c.or         s1, a0
                  sltu         s1, s6, s7
                  c.or         s1, a0
                  mulhu        a0, t2, zero
                  c.and        a2, a3
                  srl          a4, ra, s8
                  c.addi4spn   a3, sp, 400
                  c.sub        a0, a5
                  slti         s3, s5, -238
                  c.addi       s1, -1
                  c.addi16sp   sp, 464
                  mulhsu       a5, a0, s10
                  remu         t6, s2, s5
                  ori          a3, t5, 1088
                  slt          s3, a4, s5
                  add          tp, a2, s8
                  slli         gp, s11, 27
                  slt          s3, a4, s5
                  c.nop
                  srl          a4, ra, s8
                  c.li         ra, 9
                  div          sp, s2, s5
                  c.srai       a0, 24
                  c.srli       a4, 11
                  sub          sp, a4, a4
                  c.sub        a0, a5
                  sub          sp, a4, a4
                  divu         s11, a1, gp
                  ori          a3, t5, 1088
                  xor          a6, s1, sp
                  mulh         s4, s7, t5
                  addi         a5, a6, 639
                  c.mv         a3, s10
                  and          s9, s5, a4
                  c.slli       s5, 8
                  xori         s9, a6, -2048
                  mulh         s4, s7, t5
                  rem          s3, a2, a3
                  sltu         s1, s6, s7
                  mulh         s4, s7, t5
                  mulhsu       a5, a0, s10
                  c.srai       a0, 24
                  remu         t6, s2, s5
                  c.srai       a0, 24
                  nop
                  c.addi16sp   sp, 464
                  slli         gp, s11, 27
                  c.addi16sp   sp, 464
                  sra          s2, t6, s1
                  c.srli       a4, 11
                  mulhsu       a5, a0, s10
                  c.lui        a4, 9
                  c.lui        a4, 9
                  srli         zero, ra, 0
                  rem          s3, a2, a3
                  and          s9, s5, a4
                  li           t6, 0x0 #start riscv_int_numeric_corner_stream_19
                  li           t0, 0x80000000
                  li           s5, 0x8f99a2f7
                  li           a7, 0xd583d34a
                  li           s9, 0x80000000
                  li           s2, 0xffffffff
                  li           gp, 0xa057a5b7
                  li           ra, 0x80000000
                  li           s8, 0x83284be6
                  li           t2, 0x80000000
                  sub          t0, gp, ra
                  divu         t6, a7, t2
                  mulh         a7, s8, s9
                  nop
                  addi         t2, ra, 639
                  mulhsu       t2, a7, gp
                  mul          s9, s2, s2
                  div          t0, t0, s2
                  mul          s9, s2, s2
                  div          t0, t0, s2
                  remu         s2, t0, s2
                  mulhsu       t2, a7, gp
                  add          a7, s8, s9
                  mulhsu       t2, a7, gp
                  addi         t2, ra, 639
                  divu         t6, a7, t2
                  sub          t0, gp, ra
                  mul          s9, s2, s2
                  nop
                  mulhsu       t2, a7, gp
                  mulhsu       t2, a7, gp
                  lui          t0, 494335
                  add          a7, s8, s9
                  auipc        s8, 95018
                  lui          t0, 494335
                  addi         t2, ra, 639
                  divu         t6, a7, t2
                  mulhsu       t2, a7, gp
                  lui          t0, 494335 #end riscv_int_numeric_corner_stream_19
                  c.xor        a3, a0
                  lui          a2, 494335
                  div          sp, s2, s5
                  mulhu        a0, t2, zero
                  srai         s0, s4, 6
                  or           a5, a1, t6
                  sltiu        a4, t2, -709
                  mulhu        a0, t2, zero
                  srli         zero, ra, 0
                  slli         gp, s11, 27
                  c.srli       a4, 11
                  sltu         s1, s6, s7
                  addi         a5, a6, 639
                  c.and        a2, a3
                  remu         t6, s2, s5
                  remu         t6, s2, s5
                  c.slli       s5, 8
                  c.mv         a3, s10
                  c.srli       a4, 11
                  c.mv         a3, s10
                  c.addi4spn   a3, sp, 400
                  srl          a4, ra, s8
                  srai         s0, s4, 6
                  and          s9, s5, a4
                  c.slli       s5, 8
                  mulhsu       a5, a0, s10
                  auipc        t6, 95018
                  slli         gp, s11, 27
                  rem          s3, a2, a3
                  and          s9, s5, a4
                  mulhsu       a5, a0, s10
                  remu         t6, s2, s5
                  c.srli       a4, 11
                  c.addi       s1, -1
                  sll          a1, s6, s9
                  c.xor        a3, a0
                  addi         a5, a6, 639
                  c.or         s1, a0
                  srli         zero, ra, 0
                  and          s9, s5, a4
                  ori          a3, t5, 1088
                  c.addi16sp   sp, 464
                  remu         t6, s2, s5
                  mulhu        a0, t2, zero
                  rem          s3, a2, a3
                  c.addi       s1, -1
                  c.addi4spn   a3, sp, 400
                  c.xor        a3, a0
                  c.slli       s5, 8
                  c.add        s4, a4
                  srai         s0, s4, 6
                  xori         s9, a6, -2048
                  mulh         s4, s7, t5
                  c.add        s4, a4
                  sra          s2, t6, s1
                  lui          a2, 494335
                  or           a5, a1, t6
                  mulhsu       a5, a0, s10
                  c.addi16sp   sp, 464
                  sub          sp, a4, a4
                  nop
                  c.and        a2, a3
                  sltu         s1, s6, s7
                  lui          a2, 494335
                  slli         gp, s11, 27
                  auipc        t6, 95018
                  mulhsu       a5, a0, s10
                  slti         s3, s5, -238
                  or           a5, a1, t6
                  c.slli       s5, 8
                  c.nop
                  xori         s9, a6, -2048
                  c.mv         a3, s10
                  c.or         s1, a0
                  sltiu        a4, t2, -709
                  c.and        a2, a3
                  c.andi       a5, 29
                  c.addi       s1, -1
                  sltu         s1, s6, s7
                  srli         zero, ra, 0
                  and          s9, s5, a4
                  c.nop
                  remu         t6, s2, s5
                  c.addi       s1, -1
                  c.nop
                  mulhsu       a5, a0, s10
                  div          sp, s2, s5
                  addi         a5, a6, 639
                  c.addi       s1, -1
                  addi         a5, a6, 639
                  mulhsu       a5, a0, s10
                  c.mv         a3, s10
                  c.xor        a3, a0
                  c.addi16sp   sp, 464
                  sltu         s1, s6, s7
                  srli         zero, ra, 0
                  c.lui        a4, 9
                  mulh         s4, s7, t5
                  c.sub        a0, a5
                  c.addi4spn   a3, sp, 400
                  remu         t6, s2, s5
                  c.andi       a5, 29
                  lui          a2, 494335
                  c.or         s1, a0
                  xori         s9, a6, -2048
                  sltiu        a4, t2, -709
                  slti         s3, s5, -238
                  c.li         ra, 9
                  sra          s2, t6, s1
                  c.addi4spn   a3, sp, 400
                  c.addi       s1, -1
                  sub          sp, a4, a4
                  div          sp, s2, s5
                  slli         gp, s11, 27
                  c.slli       s5, 8
                  c.and        a2, a3
                  mulhsu       a5, a0, s10
                  ori          a3, t5, 1088
                  c.addi16sp   sp, 464
                  sra          s2, t6, s1
                  auipc        t6, 95018
                  c.andi       a5, 29
                  mulhsu       a5, a0, s10
                  sltiu        a4, t2, -709
                  slti         s3, s5, -238
                  c.sub        a0, a5
                  remu         t6, s2, s5
                  srai         s0, s4, 6
                  srai         s0, s4, 6
                  slti         s3, s5, -238
                  add          tp, a2, s8
                  mul          s0, t0, a0
                  rem          s3, a2, a3
                  divu         s11, a1, gp
                  lui          a2, 494335
                  c.lui        a4, 9
                  mul          s0, t0, a0
                  and          s9, s5, a4
                  c.or         s1, a0
                  rem          s3, a2, a3
                  andi         t0, a0, -564
                  c.lui        a4, 9
                  c.or         s1, a0
                  c.sub        a0, a5
                  c.andi       a5, 29
                  ori          a3, t5, 1088
                  c.addi16sp   sp, 464
                  sltiu        a4, t2, -709
                  srli         zero, ra, 0
                  slli         gp, s11, 27
                  andi         t0, a0, -564
                  mulhu        a0, t2, zero
                  c.xor        a3, a0
                  c.and        a2, a3
                  nop
                  c.lui        a4, 9
                  slti         s3, s5, -238
                  sltiu        a4, t2, -709
                  sltiu        a4, t2, -709
                  nop
                  rem          s3, a2, a3
                  c.srai       a0, 24
                  c.or         s1, a0
                  mulhsu       a5, a0, s10
                  li           t5, 0x80000000 #start riscv_int_numeric_corner_stream_22
                  li           gp, 0x80000000
                  li           t6, 0xffffffff
                  li           a6, 0xffffffff
                  li           s5, 0x80000000
                  li           sp, 0xce72e25a
                  li           a3, 0x80000000
                  li           a7, 0xede92dcf
                  li           t1, 0xffffffff
                  li           t4, 0x0
                  lui          t1, 494335
                  auipc        t4, 95018
                  mulhsu       a3, a6, gp
                  div          t1, t1, a7
                  mul          t5, a7, a7
                  sub          t1, gp, sp
                  div          t1, t1, a7
                  mulhsu       a3, a6, gp
                  sub          t1, gp, sp
                  remu         a7, t1, a7
                  add          a6, t4, t5
                  mulhsu       a3, a6, gp
                  sub          t1, gp, sp
                  mulh         a6, t4, t5
                  mul          t5, a7, a7
                  div          t1, t1, a7
                  rem          a3, a7, a3
                  add          a6, t4, t5
                  mulh         a6, t4, t5
                  nop
                  addi         a3, sp, 639
                  addi         a3, sp, 639
                  sub          t1, gp, sp
                  div          t1, t1, a7
                  addi         a3, sp, 639
                  mul          t5, a7, a7
                  nop #end riscv_int_numeric_corner_stream_22
                  ori          a3, t5, 1088
                  rem          s3, a2, a3
                  c.li         ra, 9
                  c.addi       s1, -1
                  c.xor        a3, a0
                  add          tp, a2, s8
                  mulhu        a0, t2, zero
                  addi         a5, a6, 639
                  c.srai       a0, 24
                  sll          a1, s6, s9
                  remu         t6, s2, s5
                  c.addi4spn   a3, sp, 400
                  rem          s3, a2, a3
                  slt          s3, a4, s5
                  c.and        a2, a3
                  c.addi       s1, -1
                  nop
                  sra          s2, t6, s1
                  c.addi16sp   sp, 464
                  addi         a5, a6, 639
                  srl          a4, ra, s8
                  c.mv         a3, s10
                  c.lui        a4, 9
                  addi         a5, a6, 639
                  c.lui        a4, 9
                  c.add        s4, a4
                  c.and        a2, a3
                  nop
                  srl          a4, ra, s8
                  srli         zero, ra, 0
                  mul          s0, t0, a0
                  lui          a2, 494335
                  or           a5, a1, t6
                  c.nop
                  slti         s3, s5, -238
                  c.mv         a3, s10
                  add          tp, a2, s8
                  mul          s0, t0, a0
                  lui          a2, 494335
                  andi         t0, a0, -564
                  div          sp, s2, s5
                  c.li         ra, 9
                  c.slli       s5, 8
                  mulhsu       a5, a0, s10
                  div          sp, s2, s5
                  c.andi       a5, 29
                  auipc        t6, 95018
                  andi         t0, a0, -564
                  c.or         s1, a0
                  c.li         ra, 9
                  sub          sp, a4, a4
                  mulhu        a0, t2, zero
                  sra          s2, t6, s1
                  sra          s2, t6, s1
                  xor          a6, s1, sp
                  slli         gp, s11, 27
                  sltu         s1, s6, s7
                  srl          a4, ra, s8
                  c.slli       s5, 8
                  divu         s11, a1, gp
                  lui          a2, 494335
                  c.or         s1, a0
                  slti         s3, s5, -238
                  andi         t0, a0, -564
                  sltu         s1, s6, s7
                  mulh         s4, s7, t5
                  sub          sp, a4, a4
                  andi         t0, a0, -564
                  slti         s3, s5, -238
                  add          tp, a2, s8
                  c.add        s4, a4
                  mulhu        a0, t2, zero
                  rem          s3, a2, a3
                  c.add        s4, a4
                  rem          s3, a2, a3
                  mul          s0, t0, a0
                  xori         s9, a6, -2048
                  slti         s3, s5, -238
                  sub          sp, a4, a4
                  c.addi16sp   sp, 464
                  sltu         s1, s6, s7
                  c.nop
                  mulhsu       a5, a0, s10
                  c.xor        a3, a0
                  srl          a4, ra, s8
                  c.slli       s5, 8
                  nop
                  c.slli       s5, 8
                  srl          a4, ra, s8
                  c.addi16sp   sp, 464
                  c.slli       s5, 8
                  sra          s2, t6, s1
                  andi         t0, a0, -564
                  sll          a1, s6, s9
                  sra          s2, t6, s1
                  lui          a2, 494335
                  sltu         s1, s6, s7
                  sub          sp, a4, a4
                  sub          sp, a4, a4
                  mulhu        a0, t2, zero
                  c.or         s1, a0
                  mulhu        a0, t2, zero
                  div          sp, s2, s5
                  c.nop
                  nop
                  andi         t0, a0, -564
                  or           a5, a1, t6
                  c.srai       a0, 24
                  slli         gp, s11, 27
                  andi         t0, a0, -564
                  sltiu        a4, t2, -709
                  sltu         s1, s6, s7
                  c.or         s1, a0
                  slli         gp, s11, 27
                  srl          a4, ra, s8
                  mulh         s4, s7, t5
                  sra          s2, t6, s1
                  xor          a6, s1, sp
                  c.sub        a0, a5
                  c.srai       a0, 24
                  c.li         ra, 9
                  mulh         s4, s7, t5
                  c.lui        a4, 9
                  sra          s2, t6, s1
                  xor          a6, s1, sp
                  c.mv         a3, s10
                  mulhsu       a5, a0, s10
                  ori          a3, t5, 1088
                  c.mv         a3, s10
                  c.srli       a4, 11
                  rem          s3, a2, a3
                  sltu         s1, s6, s7
                  add          tp, a2, s8
                  c.sub        a0, a5
                  and          s9, s5, a4
                  c.xor        a3, a0
                  xor          a6, s1, sp
                  xor          a6, s1, sp
                  rem          s3, a2, a3
                  divu         s11, a1, gp
                  rem          s3, a2, a3
                  c.lui        a4, 9
                  xor          a6, s1, sp
                  c.srli       a4, 11
                  c.lui        a4, 9
                  auipc        t6, 95018
                  mulhsu       a5, a0, s10
                  srai         s0, s4, 6
                  c.srli       a4, 11
                  c.mv         a3, s10
                  c.add        s4, a4
                  c.or         s1, a0
                  rem          s3, a2, a3
                  c.mv         a3, s10
                  c.sub        a0, a5
                  xori         s9, a6, -2048
                  c.add        s4, a4
                  xori         s9, a6, -2048
                  c.addi       s1, -1
                  xori         s9, a6, -2048
                  slti         s3, s5, -238
                  c.nop
                  c.addi16sp   sp, 464
                  or           a5, a1, t6
                  slt          s3, a4, s5
                  c.addi4spn   a3, sp, 400
                  srai         s0, s4, 6
                  slli         gp, s11, 27
                  mul          s0, t0, a0
                  xori         s9, a6, -2048
                  c.and        a2, a3
                  c.lui        a4, 9
                  c.xor        a3, a0
                  c.andi       a5, 29
                  c.srai       a0, 24
                  c.lui        a4, 9
                  xor          a6, s1, sp
                  mulhsu       a5, a0, s10
                  andi         t0, a0, -564
                  sltu         s1, s6, s7
                  c.addi       s1, -1
                  c.andi       a5, 29
                  ori          a3, t5, 1088
                  andi         t0, a0, -564
                  c.addi4spn   a3, sp, 400
                  nop
                  c.nop
                  ori          a3, t5, 1088
                  c.lui        a4, 9
                  xori         s9, a6, -2048
                  addi         a5, a6, 639
                  slli         gp, s11, 27
                  rem          s3, a2, a3
                  and          s9, s5, a4
                  c.sub        a0, a5
                  c.addi       s1, -1
                  c.and        a2, a3
                  srl          a4, ra, s8
                  c.lui        a4, 9
                  c.mv         a3, s10
                  c.srli       a4, 11
                  srl          a4, ra, s8
                  c.sub        a0, a5
                  ori          a3, t5, 1088
                  sll          a1, s6, s9
                  lui          a2, 494335
                  sltiu        a4, t2, -709
                  rem          s3, a2, a3
                  div          sp, s2, s5
                  c.addi       s1, -1
                  c.sub        a0, a5
                  c.nop
                  div          sp, s2, s5
                  c.lui        a4, 9
                  c.lui        a4, 9
                  lui          a2, 494335
                  c.add        s4, a4
                  c.mv         a3, s10
                  mul          s0, t0, a0
                  andi         t0, a0, -564
                  mulh         s4, s7, t5
                  c.srai       a0, 24
                  c.addi       s1, -1
                  mulh         s4, s7, t5
                  mul          s0, t0, a0
                  c.andi       a5, 29
                  ori          a3, t5, 1088
                  add          tp, a2, s8
                  xori         s9, a6, -2048
                  c.addi       s1, -1
                  or           a5, a1, t6
                  add          tp, a2, s8
                  sll          a1, s6, s9
                  c.lui        a4, 9
                  c.addi4spn   a3, sp, 400
                  c.or         s1, a0
                  slti         s3, s5, -238
                  srl          a4, ra, s8
                  c.mv         a3, s10
                  auipc        t6, 95018
                  sub          sp, a4, a4
                  mulhsu       a5, a0, s10
                  mulh         s4, s7, t5
                  c.and        a2, a3
                  c.nop
                  srl          a4, ra, s8
                  mulh         s4, s7, t5
                  slti         s3, s5, -238
                  xor          a6, s1, sp
                  mulh         s4, s7, t5
                  lui          a2, 494335
                  mulhsu       a5, a0, s10
                  sra          s2, t6, s1
                  mul          s0, t0, a0
                  srl          a4, ra, s8
                  c.slli       s5, 8
                  sltiu        a4, t2, -709
                  slti         s3, s5, -238
                  c.addi16sp   sp, 464
                  c.lui        a4, 9
                  c.or         s1, a0
                  sll          a1, s6, s9
                  c.lui        a4, 9
                  c.xor        a3, a0
                  ori          a3, t5, 1088
                  c.srli       a4, 11
                  divu         s11, a1, gp
                  c.srli       a4, 11
                  c.addi4spn   a3, sp, 400
                  c.xor        a3, a0
                  mulhu        a0, t2, zero
                  addi         a5, a6, 639
                  mulh         s4, s7, t5
                  or           a5, a1, t6
                  c.nop
                  c.addi4spn   a3, sp, 400
                  slt          s3, a4, s5
                  c.xor        a3, a0
                  andi         t0, a0, -564
                  ori          a3, t5, 1088
                  c.add        s4, a4
                  slli         gp, s11, 27
                  auipc        t6, 95018
                  lui          a2, 494335
                  c.and        a2, a3
                  add          tp, a2, s8
                  srai         s0, s4, 6
                  c.srai       a0, 24
                  srai         s0, s4, 6
                  c.srai       a0, 24
                  ori          a3, t5, 1088
                  c.xor        a3, a0
                  c.and        a2, a3
                  c.srli       a4, 11
                  div          sp, s2, s5
                  xor          a6, s1, sp
                  sltu         s1, s6, s7
                  c.addi       s1, -1
                  srai         s0, s4, 6
                  c.addi16sp   sp, 464
                  divu         s11, a1, gp
                  lui          a2, 494335
                  ori          a3, t5, 1088
                  sll          a1, s6, s9
                  c.addi       s1, -1
                  or           a5, a1, t6
                  c.lui        a4, 9
                  rem          s3, a2, a3
                  c.li         ra, 9
                  c.add        s4, a4
                  add          tp, a2, s8
                  srl          a4, ra, s8
                  sra          s2, t6, s1
                  rem          s3, a2, a3
                  remu         t6, s2, s5
                  div          sp, s2, s5
                  c.mv         a3, s10
                  mulh         s4, s7, t5
                  mulh         s4, s7, t5
                  mulhsu       a5, a0, s10
                  c.addi       s1, -1
                  remu         t6, s2, s5
                  c.xor        a3, a0
                  c.addi       s1, -1
                  c.xor        a3, a0
                  xori         s9, a6, -2048
                  or           a5, a1, t6
                  c.li         ra, 9
                  c.and        a2, a3
                  slli         gp, s11, 27
                  add          tp, a2, s8
                  rem          s3, a2, a3
                  c.slli       s5, 8
                  c.sub        a0, a5
                  mulhu        a0, t2, zero
                  slti         s3, s5, -238
                  sra          s2, t6, s1
                  srai         s0, s4, 6
                  remu         t6, s2, s5
                  mulhsu       a5, a0, s10
                  add          tp, a2, s8
                  c.li         ra, 9
                  slt          s3, a4, s5
                  ori          a3, t5, 1088
                  srli         zero, ra, 0
                  c.andi       a5, 29
                  sra          s2, t6, s1
                  sra          s2, t6, s1
                  c.srli       a4, 11
                  slti         s3, s5, -238
                  mulhu        a0, t2, zero
                  c.or         s1, a0
                  remu         t6, s2, s5
                  lui          a2, 494335
                  c.srli       a4, 11
                  mulhsu       a5, a0, s10
                  nop
                  c.srli       a4, 11
                  sra          s2, t6, s1
                  or           a5, a1, t6
                  rem          s3, a2, a3
                  srl          a4, ra, s8
                  c.addi4spn   a3, sp, 400
                  remu         t6, s2, s5
                  nop
                  c.srai       a0, 24
                  slti         s3, s5, -238
                  sltu         s1, s6, s7
                  rem          s3, a2, a3
                  c.srai       a0, 24
                  or           a5, a1, t6
                  slli         gp, s11, 27
                  remu         t6, s2, s5
                  and          s9, s5, a4
                  slti         s3, s5, -238
                  c.sub        a0, a5
                  ori          a3, t5, 1088
                  c.addi       s1, -1
                  div          sp, s2, s5
                  mul          s0, t0, a0
                  addi         a5, a6, 639
                  sub          sp, a4, a4
                  c.andi       a5, 29
                  c.andi       a5, 29
                  sll          a1, s6, s9
                  c.li         ra, 9
                  ori          a3, t5, 1088
                  lui          a2, 494335
                  slli         gp, s11, 27
                  c.and        a2, a3
                  rem          s3, a2, a3
                  sub          sp, a4, a4
                  sub          sp, a4, a4
                  c.sub        a0, a5
                  sub          sp, a4, a4
                  add          tp, a2, s8
                  mulhu        a0, t2, zero
                  divu         s11, a1, gp
                  mulh         s4, s7, t5
                  c.slli       s5, 8
                  c.li         ra, 9
                  c.srli       a4, 11
                  sltiu        a4, t2, -709
                  andi         t0, a0, -564
                  mulhsu       a5, a0, s10
                  srai         s0, s4, 6
                  ori          a3, t5, 1088
                  slti         s3, s5, -238
                  c.mv         a3, s10
                  sra          s2, t6, s1
                  c.addi4spn   a3, sp, 400
                  mul          s0, t0, a0
                  c.addi16sp   sp, 464
                  and          s9, s5, a4
                  c.sub        a0, a5
                  slli         gp, s11, 27
                  c.or         s1, a0
                  c.sub        a0, a5
                  sltu         s1, s6, s7
                  c.and        a2, a3
                  sltu         s1, s6, s7
                  sltiu        a4, t2, -709
                  auipc        t6, 95018
                  c.addi       s1, -1
                  rem          s3, a2, a3
                  srai         s0, s4, 6
                  srai         s0, s4, 6
                  mulhsu       a5, a0, s10
                  sra          s2, t6, s1
                  andi         t0, a0, -564
                  c.addi16sp   sp, 464
                  srai         s0, s4, 6
                  auipc        t6, 95018
                  c.andi       a5, 29
                  slt          s3, a4, s5
                  slt          s3, a4, s5
                  c.add        s4, a4
                  c.lui        a4, 9
                  div          sp, s2, s5
                  lui          a2, 494335
                  and          s9, s5, a4
                  srai         s0, s4, 6
                  sub          sp, a4, a4
                  c.sub        a0, a5
                  mulh         s4, s7, t5
                  slli         gp, s11, 27
                  or           a5, a1, t6
                  sra          s2, t6, s1
                  divu         s11, a1, gp
                  nop
                  mulhu        a0, t2, zero
                  c.or         s1, a0
                  c.addi       s1, -1
                  c.lui        a4, 9
                  mul          s0, t0, a0
                  sub          sp, a4, a4
                  c.addi       s1, -1
                  xor          a6, s1, sp
                  remu         t6, s2, s5
                  add          tp, a2, s8
                  c.add        s4, a4
                  or           a5, a1, t6
                  and          s9, s5, a4
                  c.xor        a3, a0
                  nop
                  div          sp, s2, s5
                  xor          a6, s1, sp
                  c.or         s1, a0
                  c.sub        a0, a5
                  add          tp, a2, s8
                  c.or         s1, a0
                  xor          a6, s1, sp
                  mulhsu       a5, a0, s10
                  auipc        t6, 95018
                  addi         a5, a6, 639
                  mulhu        a0, t2, zero
                  c.addi       s1, -1
                  srl          a4, ra, s8
                  srl          a4, ra, s8
                  xor          a6, s1, sp
                  c.mv         a3, s10
                  or           a5, a1, t6
                  c.li         ra, 9
                  c.slli       s5, 8
                  or           a5, a1, t6
                  slti         s3, s5, -238
                  slt          s3, a4, s5
                  mulhsu       a5, a0, s10
                  c.slli       s5, 8
                  slli         gp, s11, 27
                  slli         gp, s11, 27
                  mulh         s4, s7, t5
                  rem          s3, a2, a3
                  srl          a4, ra, s8
                  c.sub        a0, a5
                  ori          a3, t5, 1088
                  srl          a4, ra, s8
                  c.xor        a3, a0
                  sll          a1, s6, s9
                  sll          a1, s6, s9
                  srl          a4, ra, s8
                  sltiu        a4, t2, -709
                  addi         a5, a6, 639
                  divu         s11, a1, gp
                  c.add        s4, a4
                  mul          s0, t0, a0
                  c.add        s4, a4
                  lui          a2, 494335
                  srli         zero, ra, 0
                  rem          s3, a2, a3
                  add          tp, a2, s8
                  srli         zero, ra, 0
                  c.or         s1, a0
                  c.sub        a0, a5
                  c.slli       s5, 8
                  sub          sp, a4, a4
                  ori          a3, t5, 1088
                  sll          a1, s6, s9
                  c.addi4spn   a3, sp, 400
                  ori          a3, t5, 1088
                  c.srai       a0, 24
                  nop
                  addi         a5, a6, 639
                  sra          s2, t6, s1
                  c.addi       s1, -1
                  xor          a6, s1, sp
                  c.addi16sp   sp, 464
                  rem          s3, a2, a3
                  c.srli       a4, 11
                  slt          s3, a4, s5
                  rem          s3, a2, a3
                  mul          s0, t0, a0
                  slt          s3, a4, s5
                  c.xor        a3, a0
                  slli         gp, s11, 27
                  divu         s11, a1, gp
                  c.lui        a4, 9
                  c.srli       a4, 11
                  c.srai       a0, 24
                  andi         t0, a0, -564
                  lui          a2, 494335
                  c.xor        a3, a0
                  xori         s9, a6, -2048
                  c.srai       a0, 24
                  c.srai       a0, 24
                  mulhu        a0, t2, zero
                  lui          a2, 494335
                  c.and        a2, a3
                  c.li         ra, 9
                  c.addi       s1, -1
                  c.add        s4, a4
                  sltu         s1, s6, s7
                  divu         s11, a1, gp
                  c.addi16sp   sp, 464
                  c.or         s1, a0
                  sltiu        a4, t2, -709
                  divu         s11, a1, gp
                  c.srli       a4, 11
                  c.or         s1, a0
                  mulhu        a0, t2, zero
                  lui          a2, 494335
                  xori         s9, a6, -2048
                  c.or         s1, a0
                  or           a5, a1, t6
                  div          sp, s2, s5
                  sra          s2, t6, s1
                  sra          s2, t6, s1
                  c.xor        a3, a0
                  c.addi4spn   a3, sp, 400
                  or           a5, a1, t6
                  c.andi       a5, 29
                  sll          a1, s6, s9
                  mulhsu       a5, a0, s10
                  slt          s3, a4, s5
                  slli         gp, s11, 27
                  c.slli       s5, 8
                  nop
                  nop
                  c.li         ra, 9
                  mulhu        a0, t2, zero
                  srl          a4, ra, s8
                  c.srai       a0, 24
                  c.nop
                  c.lui        a4, 9
                  mulh         s4, s7, t5
                  mulh         s4, s7, t5
                  slt          s3, a4, s5
                  slti         s3, s5, -238
                  and          s9, s5, a4
                  sub          sp, a4, a4
                  c.nop
                  c.and        a2, a3
                  lui          a2, 494335
                  xori         s9, a6, -2048
                  ori          a3, t5, 1088
                  lui          a2, 494335
                  sltu         s1, s6, s7
                  and          s9, s5, a4
                  c.mv         a3, s10
                  add          tp, a2, s8
                  or           a5, a1, t6
                  c.li         ra, 9
                  mul          s0, t0, a0
                  remu         t6, s2, s5
                  c.andi       a5, 29
                  c.li         ra, 9
                  srai         s0, s4, 6
                  c.lui        a4, 9
                  xor          a6, s1, sp
                  c.mv         a3, s10
                  c.and        a2, a3
                  c.srai       a0, 24
                  mulhsu       a5, a0, s10
                  mul          s0, t0, a0
                  sltu         s1, s6, s7
                  c.sub        a0, a5
                  c.xor        a3, a0
                  sll          a1, s6, s9
                  c.addi16sp   sp, 464
                  c.addi4spn   a3, sp, 400
                  c.xor        a3, a0
                  c.lui        a4, 9
                  srl          a4, ra, s8
                  mulh         s4, s7, t5
                  remu         t6, s2, s5
                  or           a5, a1, t6
                  or           a5, a1, t6
                  sll          a1, s6, s9
                  c.add        s4, a4
                  c.lui        a4, 9
                  slt          s3, a4, s5
                  sltiu        a4, t2, -709
                  mul          s0, t0, a0
                  lui          a2, 494335
                  add          tp, a2, s8
                  srli         zero, ra, 0
                  c.srai       a0, 24
                  c.mv         a3, s10
                  sltiu        a4, t2, -709
                  c.nop
                  c.nop
                  slt          s3, a4, s5
                  sltiu        a4, t2, -709
                  or           a5, a1, t6
                  mulh         s4, s7, t5
                  lui          a2, 494335
                  sub          sp, a4, a4
                  sub          sp, a4, a4
                  slt          s3, a4, s5
                  remu         t6, s2, s5
                  divu         s11, a1, gp
                  sltiu        a4, t2, -709
                  srai         s0, s4, 6
                  divu         s11, a1, gp
                  slli         gp, s11, 27
                  rem          s3, a2, a3
                  ori          a3, t5, 1088
                  sub          sp, a4, a4
                  sra          s2, t6, s1
                  c.srai       a0, 24
                  xor          a6, s1, sp
                  lui          a2, 494335
                  c.addi4spn   a3, sp, 400
                  mulhsu       a5, a0, s10
                  c.addi16sp   sp, 464
                  addi         a5, a6, 639
                  srai         s0, s4, 6
                  c.xor        a3, a0
                  mul          s0, t0, a0
                  slli         gp, s11, 27
                  div          sp, s2, s5
                  remu         t6, s2, s5
                  c.and        a2, a3
                  c.mv         a3, s10
                  sltu         s1, s6, s7
                  mul          s0, t0, a0
                  ori          a3, t5, 1088
                  c.add        s4, a4
                  xor          a6, s1, sp
                  sub          sp, a4, a4
                  divu         s11, a1, gp
                  slt          s3, a4, s5
                  c.addi4spn   a3, sp, 400
                  slt          s3, a4, s5
                  slti         s3, s5, -238
                  rem          s3, a2, a3
                  slt          s3, a4, s5
                  sltu         s1, s6, s7
                  c.andi       a5, 29
                  remu         t6, s2, s5
                  mul          s0, t0, a0
                  c.addi       s1, -1
                  addi         a5, a6, 639
                  srl          a4, ra, s8
                  addi         a5, a6, 639
                  c.addi       s1, -1
                  sra          s2, t6, s1
                  mulhu        a0, t2, zero
                  and          s9, s5, a4
                  c.mv         a3, s10
                  srl          a4, ra, s8
                  lui          a2, 494335
                  slti         s3, s5, -238
                  and          s9, s5, a4
                  srl          a4, ra, s8
                  or           a5, a1, t6
                  sltu         s1, s6, s7
                  sll          a1, s6, s9
                  addi         a5, a6, 639
                  addi         a5, a6, 639
                  c.and        a2, a3
                  addi         a5, a6, 639
                  lui          a2, 494335
                  srli         zero, ra, 0
                  srai         s0, s4, 6
                  c.addi       s1, -1
                  c.or         s1, a0
                  sub          sp, a4, a4
                  srl          a4, ra, s8
                  divu         s11, a1, gp
                  div          sp, s2, s5
                  c.add        s4, a4
                  and          s9, s5, a4
                  auipc        t6, 95018
                  div          sp, s2, s5
                  sra          s2, t6, s1
                  c.addi4spn   a3, sp, 400
                  sra          s2, t6, s1
                  lui          a2, 494335
                  sltiu        a4, t2, -709
                  srl          a4, ra, s8
                  mulh         s4, s7, t5
                  xori         s9, a6, -2048
                  c.mv         a3, s10
                  slli         gp, s11, 27
                  slt          s3, a4, s5
                  andi         t0, a0, -564
                  c.slli       s5, 8
                  mulh         s4, s7, t5
                  c.li         ra, 9
                  c.add        s4, a4
                  mulh         s4, s7, t5
                  auipc        t6, 95018
                  c.sub        a0, a5
                  mul          s0, t0, a0
                  c.or         s1, a0
                  auipc        t6, 95018
                  c.srai       a0, 24
                  and          s9, s5, a4
                  mulhu        a0, t2, zero
                  sra          s2, t6, s1
                  c.sub        a0, a5
                  xor          a6, s1, sp
                  c.lui        a4, 9
                  slt          s3, a4, s5
                  and          s9, s5, a4
                  slt          s3, a4, s5
                  c.srli       a4, 11
                  sub          sp, a4, a4
                  slti         s3, s5, -238
                  xor          a6, s1, sp
                  and          s9, s5, a4
                  or           a5, a1, t6
                  mulhu        a0, t2, zero
                  sltiu        a4, t2, -709
                  sub          sp, a4, a4
                  c.and        a2, a3
                  c.nop
                  lui          a2, 494335
                  sltu         s1, s6, s7
                  c.nop
                  mulhu        a0, t2, zero
                  c.lui        a4, 9
                  c.lui        a4, 9
                  c.mv         a3, s10
                  xori         s9, a6, -2048
                  srli         zero, ra, 0
                  c.or         s1, a0
                  c.addi4spn   a3, sp, 400
                  srai         s0, s4, 6
                  c.addi4spn   a3, sp, 400
                  remu         t6, s2, s5
                  c.add        s4, a4
                  c.nop
                  c.srli       a4, 11
                  srli         zero, ra, 0
                  c.srai       a0, 24
                  divu         s11, a1, gp
                  remu         t6, s2, s5
                  mulh         s4, s7, t5
                  c.lui        a4, 9
                  c.slli       s5, 8
                  c.slli       s5, 8
                  sra          s2, t6, s1
                  addi         a5, a6, 639
                  c.mv         a3, s10
                  ori          a3, t5, 1088
                  and          s9, s5, a4
                  c.andi       a5, 29
                  auipc        t6, 95018
                  slti         s3, s5, -238
                  slt          s3, a4, s5
                  c.li         ra, 9
                  c.or         s1, a0
                  nop
                  remu         t6, s2, s5
                  slli         gp, s11, 27
                  c.xor        a3, a0
                  c.add        s4, a4
                  slli         gp, s11, 27
                  or           a5, a1, t6
                  xori         s9, a6, -2048
                  c.andi       a5, 29
                  c.addi4spn   a3, sp, 400
                  andi         t0, a0, -564
                  rem          s3, a2, a3
                  rem          s3, a2, a3
                  c.add        s4, a4
                  c.andi       a5, 29
                  c.sub        a0, a5
                  srli         zero, ra, 0
                  c.sub        a0, a5
                  srli         zero, ra, 0
                  c.andi       a5, 29
                  c.addi4spn   a3, sp, 400
                  c.and        a2, a3
                  ori          a3, t5, 1088
                  sra          s2, t6, s1
                  slli         gp, s11, 27
                  c.nop
                  c.sub        a0, a5
                  srai         s0, s4, 6
                  add          tp, a2, s8
                  slli         gp, s11, 27
                  andi         t0, a0, -564
                  mulh         s4, s7, t5
                  or           a5, a1, t6
                  c.nop
                  andi         t0, a0, -564
                  mul          s0, t0, a0
                  and          s9, s5, a4
                  c.add        s4, a4
                  lui          a2, 494335
                  nop
                  or           a5, a1, t6
                  nop
                  c.addi4spn   a3, sp, 400
                  c.nop
                  slli         gp, s11, 27
                  c.srai       a0, 24
                  srai         s0, s4, 6
                  remu         t6, s2, s5
                  auipc        t6, 95018
                  c.andi       a5, 29
                  or           a5, a1, t6
                  c.srli       a4, 11
                  andi         t0, a0, -564
                  nop
                  c.addi       s1, -1
                  mulhsu       a5, a0, s10
                  and          s9, s5, a4
                  srl          a4, ra, s8
                  c.srai       a0, 24
                  nop
                  sltu         s1, s6, s7
                  rem          s3, a2, a3
                  srl          a4, ra, s8
                  slti         s3, s5, -238
                  or           a5, a1, t6
                  ori          a3, t5, 1088
                  or           a5, a1, t6
                  sub          sp, a4, a4
                  ori          a3, t5, 1088
                  c.andi       a5, 29
                  c.mv         a3, s10
                  c.xor        a3, a0
                  sltu         s1, s6, s7
                  c.add        s4, a4
                  mulhsu       a5, a0, s10
                  c.lui        a4, 9
                  xori         s9, a6, -2048
                  addi         a5, a6, 639
                  sub          sp, a4, a4
                  remu         t6, s2, s5
                  mulhsu       a5, a0, s10
                  c.srli       a4, 11
                  rem          s3, a2, a3
                  addi         a5, a6, 639
                  c.andi       a5, 29
                  mulhu        a0, t2, zero
                  ori          a3, t5, 1088
                  slt          s3, a4, s5
                  srai         s0, s4, 6
                  nop
                  mulhsu       a5, a0, s10
                  sltiu        a4, t2, -709
                  xor          a6, s1, sp
                  remu         t6, s2, s5
                  addi         a5, a6, 639
                  add          tp, a2, s8
                  srl          a4, ra, s8
                  div          sp, s2, s5
                  mulhsu       a5, a0, s10
                  c.andi       a5, 29
                  c.nop
                  and          s9, s5, a4
                  srai         s0, s4, 6
                  auipc        t6, 95018
                  or           a5, a1, t6
                  sra          s2, t6, s1
                  mulhu        a0, t2, zero
                  mulhu        a0, t2, zero
                  mulh         s4, s7, t5
                  divu         s11, a1, gp
                  xor          a6, s1, sp
                  nop
                  c.andi       a5, 29
                  c.nop
                  sra          s2, t6, s1
                  c.nop
                  ori          a3, t5, 1088
                  xor          a6, s1, sp
                  nop
                  srl          a4, ra, s8
                  c.li         ra, 9
                  mulhu        a0, t2, zero
                  c.li         ra, 9
                  c.li         ra, 9
                  srli         zero, ra, 0
                  slli         gp, s11, 27
                  mulhu        a0, t2, zero
                  sub          sp, a4, a4
                  sra          s2, t6, s1
                  sub          sp, a4, a4
                  c.srai       a0, 24
                  c.sub        a0, a5
                  srai         s0, s4, 6
                  c.slli       s5, 8
                  divu         s11, a1, gp
                  c.nop
                  srli         zero, ra, 0
                  sra          s2, t6, s1
                  divu         s11, a1, gp
                  c.xor        a3, a0
                  c.srai       a0, 24
                  srli         zero, ra, 0
                  c.srai       a0, 24
                  divu         s11, a1, gp
                  andi         t0, a0, -564
                  srai         s0, s4, 6
                  c.li         ra, 9
                  slt          s3, a4, s5
                  mul          s0, t0, a0
                  sra          s2, t6, s1
                  andi         t0, a0, -564
                  c.slli       s5, 8
                  c.and        a2, a3
                  c.xor        a3, a0
                  add          tp, a2, s8
                  slt          s3, a4, s5
                  sub          sp, a4, a4
                  c.addi4spn   a3, sp, 400
                  c.and        a2, a3
                  mulh         s4, s7, t5
                  addi         a5, a6, 639
                  c.addi       s1, -1
                  sra          s2, t6, s1
                  or           a5, a1, t6
                  slt          s3, a4, s5
                  addi         a5, a6, 639
                  srai         s0, s4, 6
                  c.andi       a5, 29
                  c.slli       s5, 8
                  xor          a6, s1, sp
                  mulhsu       a5, a0, s10
                  xor          a6, s1, sp
                  ori          a3, t5, 1088
                  srli         zero, ra, 0
                  slli         gp, s11, 27
                  sltu         s1, s6, s7
                  and          s9, s5, a4
                  c.nop
                  srai         s0, s4, 6
                  sltiu        a4, t2, -709
                  nop
                  c.addi       s1, -1
                  andi         t0, a0, -564
                  c.add        s4, a4
                  mul          s0, t0, a0
                  c.sub        a0, a5
                  c.or         s1, a0
                  ori          a3, t5, 1088
                  slti         s3, s5, -238
                  mul          s0, t0, a0
                  xor          a6, s1, sp
                  or           a5, a1, t6
                  xor          a6, s1, sp
                  slli         gp, s11, 27
                  c.and        a2, a3
                  sll          a1, s6, s9
                  srai         s0, s4, 6
                  c.mv         a3, s10
                  xori         s9, a6, -2048
                  c.and        a2, a3
                  slt          s3, a4, s5
                  c.lui        a4, 9
                  c.slli       s5, 8
                  ori          a3, t5, 1088
                  rem          s3, a2, a3
                  mulhu        a0, t2, zero
                  c.addi       s1, -1
                  andi         t0, a0, -564
                  c.and        a2, a3
                  slti         s3, s5, -238
                  nop
                  c.nop
                  andi         t0, a0, -564
                  c.mv         a3, s10
                  rem          s3, a2, a3
                  andi         t0, a0, -564
                  slli         gp, s11, 27
                  addi         a5, a6, 639
                  remu         t6, s2, s5
                  auipc        t6, 95018
                  c.andi       a5, 29
                  addi         a5, a6, 639
                  divu         s11, a1, gp
                  c.and        a2, a3
                  nop
                  c.add        s4, a4
                  slti         s3, s5, -238
                  c.addi16sp   sp, 464
                  slti         s3, s5, -238
                  sltiu        a4, t2, -709
                  auipc        t6, 95018
                  sub          sp, a4, a4
                  auipc        t6, 95018
                  slt          s3, a4, s5
                  auipc        t6, 95018
                  div          sp, s2, s5
                  sra          s2, t6, s1
                  srli         zero, ra, 0
                  ori          a3, t5, 1088
                  andi         t0, a0, -564
                  c.or         s1, a0
                  lui          a2, 494335
                  c.srli       a4, 11
                  lui          a2, 494335
                  divu         s11, a1, gp
                  c.mv         a3, s10
                  remu         t6, s2, s5
                  c.xor        a3, a0
                  srai         s0, s4, 6
                  c.srli       a4, 11
                  sltu         s1, s6, s7
                  c.srai       a0, 24
                  srli         zero, ra, 0
                  addi         a5, a6, 639
                  c.addi       s1, -1
                  c.or         s1, a0
                  or           a5, a1, t6
                  c.andi       a5, 29
                  c.addi4spn   a3, sp, 400
                  sltu         s1, s6, s7
                  addi         a5, a6, 639
                  add          tp, a2, s8
                  c.or         s1, a0
                  ori          a3, t5, 1088
                  c.xor        a3, a0
                  c.srli       a4, 11
                  c.addi4spn   a3, sp, 400
                  div          sp, s2, s5
                  and          s9, s5, a4
                  and          s9, s5, a4
                  sll          a1, s6, s9
                  div          sp, s2, s5
                  c.nop
                  srli         zero, ra, 0
                  slli         gp, s11, 27
                  xori         s9, a6, -2048
                  slti         s3, s5, -238
                  xori         s9, a6, -2048
                  ori          a3, t5, 1088
                  andi         t0, a0, -564
                  c.addi4spn   a3, sp, 400
                  c.srai       a0, 24
                  sra          s2, t6, s1
                  andi         t0, a0, -564
                  addi         a5, a6, 639
                  and          s9, s5, a4
                  nop
                  andi         t0, a0, -564
                  slli         gp, s11, 27
                  mulhu        a0, t2, zero
                  slli         gp, s11, 27
                  rem          s3, a2, a3
                  c.srli       a4, 11
                  c.slli       s5, 8
                  slli         gp, s11, 27
                  c.lui        a4, 9
                  div          sp, s2, s5
                  div          sp, s2, s5
                  c.slli       s5, 8
                  remu         t6, s2, s5
                  sub          sp, a4, a4
                  addi         a5, a6, 639
                  c.addi       s1, -1
                  ori          a3, t5, 1088
                  c.mv         a3, s10
                  srli         zero, ra, 0
                  mulh         s4, s7, t5
                  srl          a4, ra, s8
                  sltiu        a4, t2, -709
                  c.li         ra, 9
                  nop
                  c.li         ra, 9
                  sltu         s1, s6, s7
                  rem          s3, a2, a3
                  c.slli       s5, 8
                  c.or         s1, a0
                  slti         s3, s5, -238
                  divu         s11, a1, gp
                  mulhu        a0, t2, zero
                  slli         gp, s11, 27
                  c.addi16sp   sp, 464
                  c.andi       a5, 29
                  c.li         ra, 9
                  xor          a6, s1, sp
                  c.and        a2, a3
                  c.addi4spn   a3, sp, 400
                  c.addi       s1, -1
                  remu         t6, s2, s5
                  sub          sp, a4, a4
                  sltiu        a4, t2, -709
                  c.srai       a0, 24
                  sltiu        a4, t2, -709
                  lui          a2, 494335
                  and          s9, s5, a4
                  or           a5, a1, t6
                  sltu         s1, s6, s7
                  sra          s2, t6, s1
                  rem          s3, a2, a3
                  nop
                  slti         s3, s5, -238
                  c.mv         a3, s10
                  c.nop
                  xor          a6, s1, sp
                  remu         t6, s2, s5
                  c.or         s1, a0
                  c.mv         a3, s10
                  or           a5, a1, t6
                  xori         s9, a6, -2048
                  or           a5, a1, t6
                  auipc        t6, 95018
                  c.mv         a3, s10
                  slli         gp, s11, 27
                  sub          sp, a4, a4
                  nop
                  slti         s3, s5, -238
                  sltu         s1, s6, s7
                  ori          a3, t5, 1088
                  remu         t6, s2, s5
                  srai         s0, s4, 6
                  c.slli       s5, 8
                  srli         zero, ra, 0
                  c.add        s4, a4
                  c.nop
                  c.mv         a3, s10
                  srl          a4, ra, s8
                  sub          sp, a4, a4
                  lui          a2, 494335
                  divu         s11, a1, gp
                  mulhu        a0, t2, zero
                  c.or         s1, a0
                  sltu         s1, s6, s7
                  andi         t0, a0, -564
                  c.andi       a5, 29
                  c.lui        a4, 9
                  slti         s3, s5, -238
                  c.xor        a3, a0
                  c.srli       a4, 11
                  mulh         s4, s7, t5
                  slli         gp, s11, 27
                  c.nop
                  nop
                  mulhu        a0, t2, zero
                  lui          a2, 494335
                  slti         s3, s5, -238
                  divu         s11, a1, gp
                  sltiu        a4, t2, -709
                  div          sp, s2, s5
                  c.addi       s1, -1
                  srai         s0, s4, 6
                  c.lui        a4, 9
                  addi         a5, a6, 639
                  srai         s0, s4, 6
                  mulh         s4, s7, t5
                  srai         s0, s4, 6
                  addi         a5, a6, 639
                  c.nop
                  lui          a2, 494335
                  c.or         s1, a0
                  c.xor        a3, a0
                  addi         a5, a6, 639
                  nop
                  slli         gp, s11, 27
                  c.or         s1, a0
                  ori          a3, t5, 1088
                  andi         t0, a0, -564
                  c.addi4spn   a3, sp, 400
                  divu         s11, a1, gp
                  or           a5, a1, t6
                  div          sp, s2, s5
                  xor          a6, s1, sp
                  addi         a5, a6, 639
                  sra          s2, t6, s1
                  c.xor        a3, a0
                  c.mv         a3, s10
                  srl          a4, ra, s8
                  lui          a2, 494335
                  xori         s9, a6, -2048
                  remu         t6, s2, s5
                  mul          s0, t0, a0
                  sll          a1, s6, s9
                  slt          s3, a4, s5
                  add          tp, a2, s8
                  divu         s11, a1, gp
                  div          sp, s2, s5
                  c.sub        a0, a5
                  c.or         s1, a0
                  c.srai       a0, 24
                  sra          s2, t6, s1
                  c.addi       s1, -1
                  mulhu        a0, t2, zero
                  or           a5, a1, t6
                  c.li         ra, 9
                  xori         s9, a6, -2048
                  c.addi16sp   sp, 464
                  xor          a6, s1, sp
                  mulh         s4, s7, t5
                  c.xor        a3, a0
                  and          s9, s5, a4
                  c.addi       s1, -1
                  xor          a6, s1, sp
                  mul          s0, t0, a0
                  c.slli       s5, 8
                  c.mv         a3, s10
                  add          tp, a2, s8
                  srai         s0, s4, 6
                  c.addi4spn   a3, sp, 400
                  mulhsu       a5, a0, s10
                  divu         s11, a1, gp
                  c.addi4spn   a3, sp, 400
                  sltiu        a4, t2, -709
                  rem          s3, a2, a3
                  c.andi       a5, 29
                  c.andi       a5, 29
                  slti         s3, s5, -238
                  c.xor        a3, a0
                  sub          sp, a4, a4
                  li           t4, 0x0 #start riscv_int_numeric_corner_stream_34
                  li           a0, 0x30045de3
                  li           t0, 0x56b6d408
                  li           sp, 0x8dc8facb
                  li           t2, 0xffffffff
                  li           t1, 0xffffffff
                  li           a3, 0xffffffff
                  li           tp, 0x0
                  li           ra, 0x80000000
                  li           s9, 0xffffffff
                  mulh         t1, a3, s9
                  mulh         t1, a3, s9
                  lui          tp, 494335
                  auipc        a3, 95018
                  sub          tp, sp, ra
                  mulhsu       t0, t1, sp
                  divu         t4, t1, t0
                  add          t1, a3, s9
                  addi         t0, ra, 639
                  div          tp, tp, t2
                  remu         t2, tp, t2
                  addi         t0, ra, 639
                  mulhsu       t0, t1, sp
                  remu         t2, tp, t2
                  divu         t4, t1, t0
                  mulh         t1, a3, s9
                  divu         t4, t1, t0
                  rem          t0, t2, t0
                  lui          tp, 494335
                  sub          tp, sp, ra #end riscv_int_numeric_corner_stream_34
                  rem          s3, a2, a3
                  c.sub        a0, a5
                  c.add        s4, a4
                  lui          a2, 494335
                  srli         zero, ra, 0
                  slti         s3, s5, -238
                  sra          s2, t6, s1
                  or           a5, a1, t6
                  c.srli       a4, 11
                  rem          s3, a2, a3
                  c.and        a2, a3
                  auipc        t6, 95018
                  xori         s9, a6, -2048
                  c.sub        a0, a5
                  mul          s0, t0, a0
                  c.or         s1, a0
                  c.andi       a5, 29
                  mulhu        a0, t2, zero
                  nop
                  c.mv         a3, s10
                  mul          s0, t0, a0
                  sltiu        a4, t2, -709
                  xor          a6, s1, sp
                  slt          s3, a4, s5
                  and          s9, s5, a4
                  auipc        t6, 95018
                  mulhsu       a5, a0, s10
                  c.addi4spn   a3, sp, 400
                  mulh         s4, s7, t5
                  c.lui        a4, 9
                  c.srli       a4, 11
                  sll          a1, s6, s9
                  c.addi4spn   a3, sp, 400
                  c.addi16sp   sp, 464
                  slt          s3, a4, s5
                  rem          s3, a2, a3
                  xori         s9, a6, -2048
                  c.li         ra, 9
                  remu         t6, s2, s5
                  c.srli       a4, 11
                  c.slli       s5, 8
                  xori         s9, a6, -2048
                  xori         s9, a6, -2048
                  c.add        s4, a4
                  addi         a5, a6, 639
                  c.srai       a0, 24
                  sltu         s1, s6, s7
                  c.nop
                  c.and        a2, a3
                  c.andi       a5, 29
                  remu         t6, s2, s5
                  c.or         s1, a0
                  srai         s0, s4, 6
                  xor          a6, s1, sp
                  mul          s0, t0, a0
                  slti         s3, s5, -238
                  divu         s11, a1, gp
                  remu         t6, s2, s5
                  srai         s0, s4, 6
                  and          s9, s5, a4
                  c.addi       s1, -1
                  c.addi16sp   sp, 464
                  sltiu        a4, t2, -709
                  c.sub        a0, a5
                  c.nop
                  and          s9, s5, a4
                  mul          s0, t0, a0
                  or           a5, a1, t6
                  c.addi16sp   sp, 464
                  mulhu        a0, t2, zero
                  mulhu        a0, t2, zero
                  remu         t6, s2, s5
                  c.andi       a5, 29
                  remu         t6, s2, s5
                  c.srli       a4, 11
                  xor          a6, s1, sp
                  ori          a3, t5, 1088
                  sra          s2, t6, s1
                  div          sp, s2, s5
                  mulhu        a0, t2, zero
                  c.nop
                  c.andi       a5, 29
                  slt          s3, a4, s5
                  or           a5, a1, t6
                  c.lui        a4, 9
                  c.slli       s5, 8
                  nop
                  c.li         ra, 9
                  andi         t0, a0, -564
                  slti         s3, s5, -238
                  c.sub        a0, a5
                  nop
                  lui          a2, 494335
                  lui          a2, 494335
                  nop
                  andi         t0, a0, -564
                  and          s9, s5, a4
                  add          tp, a2, s8
                  c.add        s4, a4
                  srai         s0, s4, 6
                  c.andi       a5, 29
                  c.andi       a5, 29
                  and          s9, s5, a4
                  c.lui        a4, 9
                  c.addi16sp   sp, 464
                  c.srli       a4, 11
                  c.srli       a4, 11
                  lui          a2, 494335
                  c.andi       a5, 29
                  c.andi       a5, 29
                  c.mv         a3, s10
                  sub          sp, a4, a4
                  c.srli       a4, 11
                  sll          a1, s6, s9
                  sltiu        a4, t2, -709
                  c.slli       s5, 8
                  srl          a4, ra, s8
                  mul          s0, t0, a0
                  c.addi       s1, -1
                  xor          a6, s1, sp
                  mul          s0, t0, a0
                  andi         t0, a0, -564
                  c.xor        a3, a0
                  remu         t6, s2, s5
                  mulhsu       a5, a0, s10
                  lui          a2, 494335
                  c.srai       a0, 24
                  c.lui        a4, 9
                  sltu         s1, s6, s7
                  c.slli       s5, 8
                  c.srli       a4, 11
                  c.lui        a4, 9
                  rem          s3, a2, a3
                  div          sp, s2, s5
                  sll          a1, s6, s9
                  addi         a5, a6, 639
                  or           a5, a1, t6
                  c.srli       a4, 11
                  srl          a4, ra, s8
                  add          tp, a2, s8
                  xori         s9, a6, -2048
                  c.and        a2, a3
                  c.and        a2, a3
                  xor          a6, s1, sp
                  sub          sp, a4, a4
                  c.srai       a0, 24
                  sltiu        a4, t2, -709
                  c.srai       a0, 24
                  xor          a6, s1, sp
                  addi         a5, a6, 639
                  xor          a6, s1, sp
                  slli         gp, s11, 27
                  slli         gp, s11, 27
                  c.sub        a0, a5
                  c.addi16sp   sp, 464
                  srli         zero, ra, 0
                  mul          s0, t0, a0
                  lui          a2, 494335
                  c.srli       a4, 11
                  c.li         ra, 9
                  sll          a1, s6, s9
                  c.nop
                  c.srai       a0, 24
                  add          tp, a2, s8
                  c.xor        a3, a0
                  nop
                  xori         s9, a6, -2048
                  c.addi4spn   a3, sp, 400
                  c.or         s1, a0
                  c.li         ra, 9
                  xori         s9, a6, -2048
                  mulhsu       a5, a0, s10
                  divu         s11, a1, gp
                  addi         a5, a6, 639
                  c.addi4spn   a3, sp, 400
                  mulhsu       a5, a0, s10
                  sltu         s1, s6, s7
                  xor          a6, s1, sp
                  c.addi       s1, -1
                  div          sp, s2, s5
                  lui          a2, 494335
                  lui          a2, 494335
                  sltiu        a4, t2, -709
                  c.andi       a5, 29
                  c.lui        a4, 9
                  c.addi       s1, -1
                  c.or         s1, a0
                  andi         t0, a0, -564
                  c.mv         a3, s10
                  mulhu        a0, t2, zero
                  lui          a2, 494335
                  c.li         ra, 9
                  c.srai       a0, 24
                  div          sp, s2, s5
                  c.and        a2, a3
                  slli         gp, s11, 27
                  ori          a3, t5, 1088
                  c.lui        a4, 9
                  c.mv         a3, s10
                  c.lui        a4, 9
                  c.or         s1, a0
                  c.or         s1, a0
                  c.nop
                  add          tp, a2, s8
                  lui          a2, 494335
                  remu         t6, s2, s5
                  c.lui        a4, 9
                  add          tp, a2, s8
                  c.slli       s5, 8
                  c.sub        a0, a5
                  and          s9, s5, a4
                  c.or         s1, a0
                  srai         s0, s4, 6
                  c.sub        a0, a5
                  slti         s3, s5, -238
                  or           a5, a1, t6
                  srl          a4, ra, s8
                  srai         s0, s4, 6
                  c.lui        a4, 9
                  sll          a1, s6, s9
                  mul          s0, t0, a0
                  c.andi       a5, 29
                  lui          a2, 494335
                  c.srai       a0, 24
                  srl          a4, ra, s8
                  c.addi       s1, -1
                  add          tp, a2, s8
                  add          tp, a2, s8
                  c.lui        a4, 9
                  xori         s9, a6, -2048
                  srl          a4, ra, s8
                  c.slli       s5, 8
                  slt          s3, a4, s5
                  c.srli       a4, 11
                  c.nop
                  auipc        t6, 95018
                  sltu         s1, s6, s7
                  div          sp, s2, s5
                  c.sub        a0, a5
                  c.sub        a0, a5
                  mulhsu       a5, a0, s10
                  c.slli       s5, 8
                  srli         zero, ra, 0
                  addi         a5, a6, 639
                  srli         zero, ra, 0
                  add          tp, a2, s8
                  xori         s9, a6, -2048
                  c.xor        a3, a0
                  slt          s3, a4, s5
                  sra          s2, t6, s1
                  c.mv         a3, s10
                  lui          a2, 494335
                  remu         t6, s2, s5
                  sub          sp, a4, a4
                  c.addi16sp   sp, 464
                  slti         s3, s5, -238
                  c.addi       s1, -1
                  sltu         s1, s6, s7
                  add          tp, a2, s8
                  c.or         s1, a0
                  c.add        s4, a4
                  div          sp, s2, s5
                  srl          a4, ra, s8
                  c.li         ra, 9
                  sra          s2, t6, s1
                  mulh         s4, s7, t5
                  mulhsu       a5, a0, s10
                  c.andi       a5, 29
                  sub          sp, a4, a4
                  mulh         s4, s7, t5
                  addi         a5, a6, 639
                  c.li         ra, 9
                  c.or         s1, a0
                  andi         t0, a0, -564
                  divu         s11, a1, gp
                  sltu         s1, s6, s7
                  srl          a4, ra, s8
                  sll          a1, s6, s9
                  c.xor        a3, a0
                  srai         s0, s4, 6
                  sltu         s1, s6, s7
                  sll          a1, s6, s9
                  c.addi4spn   a3, sp, 400
                  c.add        s4, a4
                  c.addi       s1, -1
                  c.lui        a4, 9
                  sltiu        a4, t2, -709
                  rem          s3, a2, a3
                  nop
                  c.srli       a4, 11
                  c.srli       a4, 11
                  c.addi16sp   sp, 464
                  sra          s2, t6, s1
                  c.nop
                  c.add        s4, a4
                  mulhu        a0, t2, zero
                  mulh         s4, s7, t5
                  c.and        a2, a3
                  mulh         s4, s7, t5
                  c.or         s1, a0
                  div          sp, s2, s5
                  c.li         ra, 9
                  addi         a5, a6, 639
                  divu         s11, a1, gp
                  divu         s11, a1, gp
                  divu         s11, a1, gp
                  c.srli       a4, 11
                  c.addi       s1, -1
                  xor          a6, s1, sp
                  rem          s3, a2, a3
                  c.xor        a3, a0
                  sll          a1, s6, s9
                  c.srai       a0, 24
                  xori         s9, a6, -2048
                  mulh         s4, s7, t5
                  c.sub        a0, a5
                  c.addi16sp   sp, 464
                  c.and        a2, a3
                  c.nop
                  mulhsu       a5, a0, s10
                  xori         s9, a6, -2048
                  c.sub        a0, a5
                  and          s9, s5, a4
                  auipc        t6, 95018
                  c.addi16sp   sp, 464
                  c.addi4spn   a3, sp, 400
                  addi         a5, a6, 639
                  c.andi       a5, 29
                  mulhu        a0, t2, zero
                  sltiu        a4, t2, -709
                  c.srai       a0, 24
                  c.xor        a3, a0
                  mul          s0, t0, a0
                  slt          s3, a4, s5
                  lui          a2, 494335
                  c.addi16sp   sp, 464
                  addi         a5, a6, 639
                  lui          a2, 494335
                  c.nop
                  c.li         ra, 9
                  c.or         s1, a0
                  and          s9, s5, a4
                  c.add        s4, a4
                  c.slli       s5, 8
                  c.nop
                  div          sp, s2, s5
                  slt          s3, a4, s5
                  add          tp, a2, s8
                  div          sp, s2, s5
                  c.xor        a3, a0
                  c.andi       a5, 29
                  mulh         s4, s7, t5
                  mulh         s4, s7, t5
                  xor          a6, s1, sp
                  mulhu        a0, t2, zero
                  auipc        t6, 95018
                  slli         gp, s11, 27
                  xor          a6, s1, sp
                  c.andi       a5, 29
                  srl          a4, ra, s8
                  c.addi       s1, -1
                  div          sp, s2, s5
                  lui          a2, 494335
                  srli         zero, ra, 0
                  c.addi16sp   sp, 464
                  c.srai       a0, 24
                  c.sub        a0, a5
                  xor          a6, s1, sp
                  xor          a6, s1, sp
                  sltiu        a4, t2, -709
                  c.andi       a5, 29
                  c.add        s4, a4
                  auipc        t6, 95018
                  div          sp, s2, s5
                  and          s9, s5, a4
                  c.add        s4, a4
                  xor          a6, s1, sp
                  add          tp, a2, s8
                  sub          sp, a4, a4
                  lui          a2, 494335
                  c.and        a2, a3
                  c.addi4spn   a3, sp, 400
                  c.and        a2, a3
                  rem          s3, a2, a3
                  c.mv         a3, s10
                  ori          a3, t5, 1088
                  rem          s3, a2, a3
                  sll          a1, s6, s9
                  sltu         s1, s6, s7
                  sub          sp, a4, a4
                  c.srli       a4, 11
                  xori         s9, a6, -2048
                  mul          s0, t0, a0
                  c.addi4spn   a3, sp, 400
                  c.and        a2, a3
                  xori         s9, a6, -2048
                  add          tp, a2, s8
                  c.nop
                  sltu         s1, s6, s7
                  mulhsu       a5, a0, s10
                  auipc        t6, 95018
                  c.and        a2, a3
                  c.nop
                  mulhsu       a5, a0, s10
                  c.or         s1, a0
                  add          tp, a2, s8
                  slti         s3, s5, -238
                  mul          s0, t0, a0
                  c.sub        a0, a5
                  auipc        t6, 95018
                  mulhsu       a5, a0, s10
                  srli         zero, ra, 0
                  nop
                  andi         t0, a0, -564
                  sra          s2, t6, s1
                  c.addi16sp   sp, 464
                  addi         a5, a6, 639
                  c.addi       s1, -1
                  or           a5, a1, t6
                  sltu         s1, s6, s7
                  slti         s3, s5, -238
                  remu         t6, s2, s5
                  c.add        s4, a4
                  rem          s3, a2, a3
                  mulh         s4, s7, t5
                  c.mv         a3, s10
                  sra          s2, t6, s1
                  srli         zero, ra, 0
                  or           a5, a1, t6
                  lui          a2, 494335
                  c.sub        a0, a5
                  c.addi16sp   sp, 464
                  lui          a2, 494335
                  c.andi       a5, 29
                  lui          a2, 494335
                  div          sp, s2, s5
                  c.addi4spn   a3, sp, 400
                  sub          sp, a4, a4
                  or           a5, a1, t6
                  mulhu        a0, t2, zero
                  remu         t6, s2, s5
                  c.lui        a4, 9
                  addi         a5, a6, 639
                  c.sub        a0, a5
                  srli         zero, ra, 0
                  or           a5, a1, t6
                  divu         s11, a1, gp
                  c.addi4spn   a3, sp, 400
                  c.add        s4, a4
                  slt          s3, a4, s5
                  c.srai       a0, 24
                  or           a5, a1, t6
                  ori          a3, t5, 1088
                  c.addi       s1, -1
                  div          sp, s2, s5
                  mulhsu       a5, a0, s10
                  c.nop
                  c.addi       s1, -1
                  c.addi4spn   a3, sp, 400
                  c.slli       s5, 8
                  sltu         s1, s6, s7
                  slli         gp, s11, 27
                  remu         t6, s2, s5
                  c.mv         a3, s10
                  slt          s3, a4, s5
                  c.srai       a0, 24
                  andi         t0, a0, -564
                  c.nop
                  srai         s0, s4, 6
                  c.addi16sp   sp, 464
                  mulh         s4, s7, t5
                  xori         s9, a6, -2048
                  c.slli       s5, 8
                  sll          a1, s6, s9
                  divu         s11, a1, gp
                  rem          s3, a2, a3
                  sra          s2, t6, s1
                  rem          s3, a2, a3
                  c.or         s1, a0
                  lui          a2, 494335
                  mul          s0, t0, a0
                  sltiu        a4, t2, -709
                  c.slli       s5, 8
                  c.and        a2, a3
                  c.slli       s5, 8
                  auipc        t6, 95018
                  ori          a3, t5, 1088
                  c.or         s1, a0
                  sltiu        a4, t2, -709
                  c.or         s1, a0
                  c.addi16sp   sp, 464
                  c.andi       a5, 29
                  sltu         s1, s6, s7
                  divu         s11, a1, gp
                  c.srli       a4, 11
                  sll          a1, s6, s9
                  mulhsu       a5, a0, s10
                  sll          a1, s6, s9
                  c.xor        a3, a0
                  c.li         ra, 9
                  mulhu        a0, t2, zero
                  addi         a5, a6, 639
                  sll          a1, s6, s9
                  sub          sp, a4, a4
                  mul          s0, t0, a0
                  c.andi       a5, 29
                  c.addi4spn   a3, sp, 400
                  c.xor        a3, a0
                  slli         gp, s11, 27
                  c.xor        a3, a0
                  c.lui        a4, 9
                  c.srai       a0, 24
                  add          tp, a2, s8
                  c.add        s4, a4
                  srai         s0, s4, 6
                  c.and        a2, a3
                  srli         zero, ra, 0
                  c.slli       s5, 8
                  c.sub        a0, a5
                  mulhsu       a5, a0, s10
                  ori          a3, t5, 1088
                  c.slli       s5, 8
                  or           a5, a1, t6
                  mulhu        a0, t2, zero
                  c.lui        a4, 9
                  c.lui        a4, 9
                  addi         a5, a6, 639
                  nop
                  xori         s9, a6, -2048
                  c.or         s1, a0
                  auipc        t6, 95018
                  addi         a5, a6, 639
                  slt          s3, a4, s5
                  c.addi       s1, -1
                  sltu         s1, s6, s7
                  nop
                  sltiu        a4, t2, -709
                  lui          a2, 494335
                  c.or         s1, a0
                  addi         a5, a6, 639
                  c.li         ra, 9
                  c.addi       s1, -1
                  c.addi16sp   sp, 464
                  srl          a4, ra, s8
                  c.addi16sp   sp, 464
                  and          s9, s5, a4
                  remu         t6, s2, s5
                  srli         zero, ra, 0
                  mulhsu       a5, a0, s10
                  c.srai       a0, 24
                  c.lui        a4, 9
                  remu         t6, s2, s5
                  mulhu        a0, t2, zero
                  sltu         s1, s6, s7
                  sll          a1, s6, s9
                  sub          sp, a4, a4
                  c.mv         a3, s10
                  mul          s0, t0, a0
                  slti         s3, s5, -238
                  c.addi4spn   a3, sp, 400
                  slt          s3, a4, s5
                  c.andi       a5, 29
                  auipc        t6, 95018
                  c.nop
                  rem          s3, a2, a3
                  lui          a2, 494335
                  slt          s3, a4, s5
                  srli         zero, ra, 0
                  c.lui        a4, 9
                  c.mv         a3, s10
                  lui          a2, 494335
                  c.addi       s1, -1
                  c.slli       s5, 8
                  c.or         s1, a0
                  add          tp, a2, s8
                  mul          s0, t0, a0
                  and          s9, s5, a4
                  add          tp, a2, s8
                  c.slli       s5, 8
                  or           a5, a1, t6
                  c.add        s4, a4
                  slli         gp, s11, 27
                  srli         zero, ra, 0
                  add          tp, a2, s8
                  c.slli       s5, 8
                  addi         a5, a6, 639
                  slt          s3, a4, s5
                  addi         a5, a6, 639
                  addi         a5, a6, 639
                  c.lui        a4, 9
                  sll          a1, s6, s9
                  ori          a3, t5, 1088
                  lui          a2, 494335
                  c.li         ra, 9
                  c.add        s4, a4
                  mulhu        a0, t2, zero
                  divu         s11, a1, gp
                  c.lui        a4, 9
                  sll          a1, s6, s9
                  slt          s3, a4, s5
                  srli         zero, ra, 0
                  div          sp, s2, s5
                  c.addi       s1, -1
                  c.or         s1, a0
                  c.andi       a5, 29
                  c.srai       a0, 24
                  xori         s9, a6, -2048
                  nop
                  rem          s3, a2, a3
                  nop
                  sltu         s1, s6, s7
                  mul          s0, t0, a0
                  c.addi       s1, -1
                  srl          a4, ra, s8
                  div          sp, s2, s5
                  rem          s3, a2, a3
                  sltu         s1, s6, s7
                  nop
                  c.andi       a5, 29
                  add          tp, a2, s8
                  remu         t6, s2, s5
                  andi         t0, a0, -564
                  li           s1, 0x0 #start riscv_int_numeric_corner_stream_3
                  li           a6, 0x80000000
                  li           s0, 0x3038ee75
                  li           t1, 0x0
                  li           gp, 0x0
                  li           t4, 0xffffffff
                  li           a7, 0xffffffff
                  li           s9, 0xffffffff
                  li           ra, 0x8398a07e
                  li           a5, 0x0
                  sub          t1, gp, ra
                  auipc        a7, 95018
                  rem          s0, a5, s0
                  lui          t1, 494335
                  rem          s0, a5, s0
                  sub          t1, gp, ra
                  addi         s0, ra, 639
                  auipc        a7, 95018
                  addi         s0, ra, 639
                  rem          s0, a5, s0
                  mulhsu       s0, s1, gp
                  remu         a5, t1, a5
                  divu         t4, s1, s0
                  rem          s0, a5, s0
                  divu         t4, s1, s0
                  sub          t1, gp, ra
                  lui          t1, 494335
                  mul          s9, a5, a5
                  lui          t1, 494335
                  mulhsu       s0, s1, gp
                  auipc        a7, 95018
                  mulh         s1, a7, s9
                  lui          t1, 494335
                  mulh         s1, a7, s9 #end riscv_int_numeric_corner_stream_3
                  sub          sp, a4, a4
                  c.addi16sp   sp, 464
                  sltu         s1, s6, s7
                  srl          a4, ra, s8
                  c.sub        a0, a5
                  srli         zero, ra, 0
                  or           a5, a1, t6
                  c.addi16sp   sp, 464
                  remu         t6, s2, s5
                  auipc        t6, 95018
                  divu         s11, a1, gp
                  mulh         s4, s7, t5
                  srl          a4, ra, s8
                  rem          s3, a2, a3
                  lui          a2, 494335
                  c.mv         a3, s10
                  nop
                  mulh         s4, s7, t5
                  xori         s9, a6, -2048
                  and          s9, s5, a4
                  c.mv         a3, s10
                  div          sp, s2, s5
                  sltiu        a4, t2, -709
                  lui          a2, 494335
                  sll          a1, s6, s9
                  div          sp, s2, s5
                  c.addi4spn   a3, sp, 400
                  c.addi       s1, -1
                  c.andi       a5, 29
                  li           s1, 0x61d5c4da #start riscv_int_numeric_corner_stream_12
                  li           a6, 0x80000000
                  li           a1, 0x80000000
                  li           t6, 0xffffffff
                  li           a7, 0x0
                  li           a0, 0x80000000
                  li           s5, 0x68c6a527
                  li           s3, 0x0
                  li           t1, 0x0
                  li           t5, 0xf694618a
                  div          a0, a0, a7
                  lui          a0, 494335
                  mulhsu       a1, a6, s1
                  divu         t6, a6, a1
                  mulhu        t1, s5, t1
                  mul          t5, a7, a7
                  divu         t6, a6, a1
                  add          a6, s5, t5
                  div          a0, a0, a7
                  add          a6, s5, t5
                  auipc        s5, 95018
                  auipc        s5, 95018
                  divu         t6, a6, a1
                  remu         a7, a0, a7
                  lui          a0, 494335
                  mulhu        t1, s5, t1
                  mulhsu       a1, a6, s1
                  mulhsu       a1, a6, s1
                  lui          a0, 494335
                  mulhsu       a1, a6, s1
                  remu         a7, a0, a7
                  divu         t6, a6, a1
                  divu         t6, a6, a1
                  addi         a1, t1, 639
                  sub          a0, s1, t1
                  addi         a1, t1, 639
                  add          a6, s5, t5
                  add          a6, s5, t5 #end riscv_int_numeric_corner_stream_12
                  andi         t0, a0, -564
                  slli         gp, s11, 27
                  c.addi       s1, -1
                  sra          s2, t6, s1
                  mulh         s4, s7, t5
                  or           a5, a1, t6
                  mulh         s4, s7, t5
                  or           a5, a1, t6
                  mulhu        a0, t2, zero
                  c.srli       a4, 11
                  div          sp, s2, s5
                  srai         s0, s4, 6
                  mulhsu       a5, a0, s10
                  c.addi       s1, -1
                  xori         s9, a6, -2048
                  c.mv         a3, s10
                  xori         s9, a6, -2048
                  auipc        t6, 95018
                  sra          s2, t6, s1
                  c.addi       s1, -1
                  sltu         s1, s6, s7
                  sra          s2, t6, s1
                  andi         t0, a0, -564
                  c.nop
                  c.addi16sp   sp, 464
                  rem          s3, a2, a3
                  add          tp, a2, s8
                  c.li         ra, 9
                  c.add        s4, a4
                  remu         t6, s2, s5
                  mul          s0, t0, a0
                  slti         s3, s5, -238
                  c.addi16sp   sp, 464
                  ori          a3, t5, 1088
                  div          sp, s2, s5
                  c.addi16sp   sp, 464
                  srl          a4, ra, s8
                  c.srli       a4, 11
                  c.andi       a5, 29
                  mul          s0, t0, a0
                  c.addi4spn   a3, sp, 400
                  mulhu        a0, t2, zero
                  c.li         ra, 9
                  c.nop
                  remu         t6, s2, s5
                  or           a5, a1, t6
                  sll          a1, s6, s9
                  andi         t0, a0, -564
                  sltiu        a4, t2, -709
                  c.andi       a5, 29
                  remu         t6, s2, s5
                  mulh         s4, s7, t5
                  c.andi       a5, 29
                  sll          a1, s6, s9
                  nop
                  div          sp, s2, s5
                  mulh         s4, s7, t5
                  c.srai       a0, 24
                  divu         s11, a1, gp
                  srai         s0, s4, 6
                  c.xor        a3, a0
                  add          tp, a2, s8
                  auipc        t6, 95018
                  c.addi4spn   a3, sp, 400
                  c.mv         a3, s10
                  c.li         ra, 9
                  c.lui        a4, 9
                  c.addi       s1, -1
                  xor          a6, s1, sp
                  xor          a6, s1, sp
                  sra          s2, t6, s1
                  c.lui        a4, 9
                  c.srli       a4, 11
                  slti         s3, s5, -238
                  addi         a5, a6, 639
                  xor          a6, s1, sp
                  add          tp, a2, s8
                  c.andi       a5, 29
                  mulh         s4, s7, t5
                  c.nop
                  c.li         ra, 9
                  c.srai       a0, 24
                  c.sub        a0, a5
                  c.or         s1, a0
                  sltu         s1, s6, s7
                  c.xor        a3, a0
                  divu         s11, a1, gp
                  c.lui        a4, 9
                  sll          a1, s6, s9
                  c.and        a2, a3
                  c.xor        a3, a0
                  mul          s0, t0, a0
                  srli         zero, ra, 0
                  slti         s3, s5, -238
                  c.sub        a0, a5
                  mulh         s4, s7, t5
                  and          s9, s5, a4
                  c.or         s1, a0
                  mulh         s4, s7, t5
                  sltiu        a4, t2, -709
                  sra          s2, t6, s1
                  srl          a4, ra, s8
                  c.sub        a0, a5
                  srli         zero, ra, 0
                  srai         s0, s4, 6
                  slli         gp, s11, 27
                  xor          a6, s1, sp
                  c.addi       s1, -1
                  rem          s3, a2, a3
                  addi         a5, a6, 639
                  c.add        s4, a4
                  slt          s3, a4, s5
                  c.lui        a4, 9
                  mulhsu       a5, a0, s10
                  mulh         s4, s7, t5
                  andi         t0, a0, -564
                  remu         t6, s2, s5
                  nop
                  c.li         ra, 9
                  sltiu        a4, t2, -709
                  xori         s9, a6, -2048
                  xori         s9, a6, -2048
                  mulhu        a0, t2, zero
                  srl          a4, ra, s8
                  slli         gp, s11, 27
                  c.and        a2, a3
                  divu         s11, a1, gp
                  sltu         s1, s6, s7
                  xor          a6, s1, sp
                  mulhu        a0, t2, zero
                  div          sp, s2, s5
                  add          tp, a2, s8
                  slli         gp, s11, 27
                  c.add        s4, a4
                  slt          s3, a4, s5
                  nop
                  xor          a6, s1, sp
                  div          sp, s2, s5
                  c.addi4spn   a3, sp, 400
                  sra          s2, t6, s1
                  c.addi       s1, -1
                  c.sub        a0, a5
                  add          tp, a2, s8
                  c.and        a2, a3
                  slli         gp, s11, 27
                  sub          sp, a4, a4
                  divu         s11, a1, gp
                  add          tp, a2, s8
                  xor          a6, s1, sp
                  xori         s9, a6, -2048
                  and          s9, s5, a4
                  c.nop
                  c.li         ra, 9
                  ori          a3, t5, 1088
                  sltiu        a4, t2, -709
                  srai         s0, s4, 6
                  add          tp, a2, s8
                  ori          a3, t5, 1088
                  divu         s11, a1, gp
                  srai         s0, s4, 6
                  c.slli       s5, 8
                  ori          a3, t5, 1088
                  c.addi4spn   a3, sp, 400
                  srl          a4, ra, s8
                  auipc        t6, 95018
                  c.slli       s5, 8
                  mulhu        a0, t2, zero
                  rem          s3, a2, a3
                  c.sub        a0, a5
                  c.or         s1, a0
                  c.xor        a3, a0
                  mulhsu       a5, a0, s10
                  c.lui        a4, 9
                  c.slli       s5, 8
                  srl          a4, ra, s8
                  ori          a3, t5, 1088
                  slli         gp, s11, 27
                  srl          a4, ra, s8
                  xori         s9, a6, -2048
                  c.add        s4, a4
                  lui          a2, 494335
                  slt          s3, a4, s5
                  andi         t0, a0, -564
                  remu         t6, s2, s5
                  nop
                  add          tp, a2, s8
                  divu         s11, a1, gp
                  sra          s2, t6, s1
                  mulh         s4, s7, t5
                  c.mv         a3, s10
                  c.mv         a3, s10
                  c.nop
                  c.add        s4, a4
                  mulh         s4, s7, t5
                  ori          a3, t5, 1088
                  rem          s3, a2, a3
                  mulh         s4, s7, t5
                  c.slli       s5, 8
                  addi         a5, a6, 639
                  remu         t6, s2, s5
                  c.addi4spn   a3, sp, 400
                  c.mv         a3, s10
                  c.addi       s1, -1
                  div          sp, s2, s5
                  remu         t6, s2, s5
                  c.srli       a4, 11
                  divu         s11, a1, gp
                  c.srai       a0, 24
                  srai         s0, s4, 6
                  or           a5, a1, t6
                  c.andi       a5, 29
                  xori         s9, a6, -2048
                  xori         s9, a6, -2048
                  srl          a4, ra, s8
                  slt          s3, a4, s5
                  srli         zero, ra, 0
                  c.addi       s1, -1
                  auipc        t6, 95018
                  and          s9, s5, a4
                  c.sub        a0, a5
                  c.addi       s1, -1
                  and          s9, s5, a4
                  sll          a1, s6, s9
                  slt          s3, a4, s5
                  sra          s2, t6, s1
                  rem          s3, a2, a3
                  add          tp, a2, s8
                  c.srli       a4, 11
                  mul          s0, t0, a0
                  srl          a4, ra, s8
                  xori         s9, a6, -2048
                  slti         s3, s5, -238
                  lui          a2, 494335
                  sra          s2, t6, s1
                  xor          a6, s1, sp
                  xori         s9, a6, -2048
                  srl          a4, ra, s8
                  lui          a2, 494335
                  c.xor        a3, a0
                  div          sp, s2, s5
                  or           a5, a1, t6
                  srli         zero, ra, 0
                  c.addi16sp   sp, 464
                  div          sp, s2, s5
                  lui          a2, 494335
                  auipc        t6, 95018
                  slt          s3, a4, s5
                  sltiu        a4, t2, -709
                  andi         t0, a0, -564
                  srai         s0, s4, 6
                  srai         s0, s4, 6
                  or           a5, a1, t6
                  c.lui        a4, 9
                  rem          s3, a2, a3
                  c.addi16sp   sp, 464
                  xori         s9, a6, -2048
                  c.srai       a0, 24
                  c.nop
                  mulh         s4, s7, t5
                  c.slli       s5, 8
                  sltu         s1, s6, s7
                  sll          a1, s6, s9
                  c.li         ra, 9
                  c.addi4spn   a3, sp, 400
                  c.andi       a5, 29
                  or           a5, a1, t6
                  mul          s0, t0, a0
                  nop
                  sub          sp, a4, a4
                  c.srai       a0, 24
                  sltu         s1, s6, s7
                  rem          s3, a2, a3
                  slt          s3, a4, s5
                  or           a5, a1, t6
                  mul          s0, t0, a0
                  or           a5, a1, t6
                  c.addi4spn   a3, sp, 400
                  or           a5, a1, t6
                  mulhu        a0, t2, zero
                  c.xor        a3, a0
                  mulhu        a0, t2, zero
                  c.nop
                  xori         s9, a6, -2048
                  rem          s3, a2, a3
                  slt          s3, a4, s5
                  lui          a2, 494335
                  srl          a4, ra, s8
                  sub          sp, a4, a4
                  sltiu        a4, t2, -709
                  auipc        t6, 95018
                  c.addi16sp   sp, 464
                  c.add        s4, a4
                  c.addi16sp   sp, 464
                  c.addi       s1, -1
                  srl          a4, ra, s8
                  divu         s11, a1, gp
                  sltiu        a4, t2, -709
                  mulhsu       a5, a0, s10
                  div          sp, s2, s5
                  mulhsu       a5, a0, s10
                  c.addi       s1, -1
                  c.and        a2, a3
                  c.nop
                  c.mv         a3, s10
                  addi         a5, a6, 639
                  rem          s3, a2, a3
                  c.sub        a0, a5
                  mul          s0, t0, a0
                  mulh         s4, s7, t5
                  c.srai       a0, 24
                  divu         s11, a1, gp
                  sub          sp, a4, a4
                  sll          a1, s6, s9
                  div          sp, s2, s5
                  srai         s0, s4, 6
                  c.srai       a0, 24
                  c.or         s1, a0
                  c.srai       a0, 24
                  sub          sp, a4, a4
                  srli         zero, ra, 0
                  auipc        t6, 95018
                  c.mv         a3, s10
                  c.xor        a3, a0
                  mulhu        a0, t2, zero
                  c.li         ra, 9
                  andi         t0, a0, -564
                  sltiu        a4, t2, -709
                  c.and        a2, a3
                  divu         s11, a1, gp
                  andi         t0, a0, -564
                  mulh         s4, s7, t5
                  li           a2, 0x80000000 #start riscv_int_numeric_corner_stream_14
                  li           ra, 0x2c323eab
                  li           t1, 0x11b89184
                  li           a1, 0x80000000
                  li           a3, 0x0
                  li           s1, 0x5726f6e2
                  li           a7, 0x0
                  li           a0, 0x80000000
                  li           s11, 0xffffffff
                  li           s5, 0xffffffff
                  mul          s5, a2, a2
                  divu         s11, a1, a0
                  auipc        a7, 95018
                  mul          s5, a2, a2
                  sub          s1, t1, ra
                  mul          s5, a2, a2
                  rem          a0, a2, a0
                  auipc        a7, 95018
                  addi         a0, ra, 639
                  rem          a0, a2, a0
                  mul          s5, a2, a2
                  mulhsu       a0, a1, t1
                  rem          a0, a2, a0
                  rem          a0, a2, a0
                  remu         a2, s1, a2
                  div          s1, s1, a2
                  nop
                  lui          s1, 494335
                  add          a1, a7, s5
                  divu         s11, a1, a0
                  lui          s1, 494335 #end riscv_int_numeric_corner_stream_14
                  c.srli       a4, 11
                  and          s9, s5, a4
                  andi         t0, a0, -564
                  c.and        a2, a3
                  c.srai       a0, 24
                  auipc        t6, 95018
                  c.and        a2, a3
                  c.nop
                  sra          s2, t6, s1
                  slti         s3, s5, -238
                  and          s9, s5, a4
                  or           a5, a1, t6
                  mulh         s4, s7, t5
                  slt          s3, a4, s5
                  div          sp, s2, s5
                  remu         t6, s2, s5
                  rem          s3, a2, a3
                  rem          s3, a2, a3
                  c.sub        a0, a5
                  c.srli       a4, 11
                  xori         s9, a6, -2048
                  andi         t0, a0, -564
                  add          tp, a2, s8
                  c.sub        a0, a5
                  xori         s9, a6, -2048
                  srl          a4, ra, s8
                  c.and        a2, a3
                  divu         s11, a1, gp
                  c.addi4spn   a3, sp, 400
                  c.xor        a3, a0
                  mulh         s4, s7, t5
                  rem          s3, a2, a3
                  c.andi       a5, 29
                  c.sub        a0, a5
                  c.nop
                  and          s9, s5, a4
                  or           a5, a1, t6
                  nop
                  c.addi16sp   sp, 464
                  slti         s3, s5, -238
                  c.srli       a4, 11
                  c.or         s1, a0
                  mulhsu       a5, a0, s10
                  and          s9, s5, a4
                  lui          a2, 494335
                  c.srli       a4, 11
                  slti         s3, s5, -238
                  andi         t0, a0, -564
                  ori          a3, t5, 1088
                  xori         s9, a6, -2048
                  mulhsu       a5, a0, s10
                  c.li         ra, 9
                  c.mv         a3, s10
                  divu         s11, a1, gp
                  auipc        t6, 95018
                  c.addi4spn   a3, sp, 400
                  slti         s3, s5, -238
                  c.or         s1, a0
                  c.or         s1, a0
                  remu         t6, s2, s5
                  slt          s3, a4, s5
                  c.addi       s1, -1
                  c.slli       s5, 8
                  slli         gp, s11, 27
                  c.addi       s1, -1
                  mulhsu       a5, a0, s10
                  divu         s11, a1, gp
                  sltiu        a4, t2, -709
                  xor          a6, s1, sp
                  auipc        t6, 95018
                  and          s9, s5, a4
                  c.addi16sp   sp, 464
                  sra          s2, t6, s1
                  c.slli       s5, 8
                  c.nop
                  slli         gp, s11, 27
                  c.add        s4, a4
                  srai         s0, s4, 6
                  div          sp, s2, s5
                  remu         t6, s2, s5
                  xori         s9, a6, -2048
                  c.addi4spn   a3, sp, 400
                  c.srai       a0, 24
                  c.mv         a3, s10
                  c.lui        a4, 9
                  c.sub        a0, a5
                  sll          a1, s6, s9
                  c.add        s4, a4
                  andi         t0, a0, -564
                  addi         a5, a6, 639
                  lui          a2, 494335
                  slt          s3, a4, s5
                  mulhu        a0, t2, zero
                  add          tp, a2, s8
                  addi         a5, a6, 639
                  xori         s9, a6, -2048
                  slti         s3, s5, -238
                  srli         zero, ra, 0
                  and          s9, s5, a4
                  slt          s3, a4, s5
                  c.srai       a0, 24
                  mulhsu       a5, a0, s10
                  sub          sp, a4, a4
                  sltu         s1, s6, s7
                  div          sp, s2, s5
                  div          sp, s2, s5
                  andi         t0, a0, -564
                  divu         s11, a1, gp
                  remu         t6, s2, s5
                  c.li         ra, 9
                  mulhu        a0, t2, zero
                  auipc        t6, 95018
                  sub          sp, a4, a4
                  c.add        s4, a4
                  sltu         s1, s6, s7
                  srai         s0, s4, 6
                  ori          a3, t5, 1088
                  lui          a2, 494335
                  c.srli       a4, 11
                  srai         s0, s4, 6
                  auipc        t6, 95018
                  c.or         s1, a0
                  mulhsu       a5, a0, s10
                  sub          sp, a4, a4
                  lui          a2, 494335
                  sub          sp, a4, a4
                  mul          s0, t0, a0
                  sll          a1, s6, s9
                  c.srai       a0, 24
                  c.add        s4, a4
                  c.lui        a4, 9
                  slti         s3, s5, -238
                  addi         a5, a6, 639
                  c.andi       a5, 29
                  sub          sp, a4, a4
                  and          s9, s5, a4
                  c.sub        a0, a5
                  or           a5, a1, t6
                  rem          s3, a2, a3
                  slt          s3, a4, s5
                  mulhu        a0, t2, zero
                  sll          a1, s6, s9
                  ori          a3, t5, 1088
                  div          sp, s2, s5
                  andi         t0, a0, -564
                  c.addi4spn   a3, sp, 400
                  c.addi16sp   sp, 464
                  addi         a5, a6, 639
                  mulhu        a0, t2, zero
                  div          sp, s2, s5
                  c.xor        a3, a0
                  sltu         s1, s6, s7
                  sll          a1, s6, s9
                  xori         s9, a6, -2048
                  slt          s3, a4, s5
                  c.and        a2, a3
                  c.srai       a0, 24
                  c.addi4spn   a3, sp, 400
                  srli         zero, ra, 0
                  c.slli       s5, 8
                  c.andi       a5, 29
                  or           a5, a1, t6
                  c.slli       s5, 8
                  c.li         ra, 9
                  slli         gp, s11, 27
                  c.add        s4, a4
                  c.add        s4, a4
                  c.srli       a4, 11
                  c.sub        a0, a5
                  mulh         s4, s7, t5
                  sltu         s1, s6, s7
                  sltu         s1, s6, s7
                  nop
                  addi         a5, a6, 639
                  ori          a3, t5, 1088
                  c.sub        a0, a5
                  mul          s0, t0, a0
                  c.li         ra, 9
                  c.and        a2, a3
                  c.sub        a0, a5
                  mul          s0, t0, a0
                  or           a5, a1, t6
                  and          s9, s5, a4
                  c.sub        a0, a5
                  c.slli       s5, 8
                  ori          a3, t5, 1088
                  mul          s0, t0, a0
                  sltu         s1, s6, s7
                  slli         gp, s11, 27
                  auipc        t6, 95018
                  c.and        a2, a3
                  c.addi4spn   a3, sp, 400
                  c.srai       a0, 24
                  sltiu        a4, t2, -709
                  srli         zero, ra, 0
                  c.nop
                  sra          s2, t6, s1
                  xor          a6, s1, sp
                  c.add        s4, a4
                  nop
                  c.addi16sp   sp, 464
                  addi         a5, a6, 639
                  c.srli       a4, 11
                  slti         s3, s5, -238
                  sub          sp, a4, a4
                  c.mv         a3, s10
                  sll          a1, s6, s9
                  add          tp, a2, s8
                  c.addi       s1, -1
                  remu         t6, s2, s5
                  mulhu        a0, t2, zero
                  c.srai       a0, 24
                  addi         a5, a6, 639
                  remu         t6, s2, s5
                  ori          a3, t5, 1088
                  srai         s0, s4, 6
                  sltu         s1, s6, s7
                  c.slli       s5, 8
                  c.srai       a0, 24
                  rem          s3, a2, a3
                  sltiu        a4, t2, -709
                  c.srli       a4, 11
                  c.lui        a4, 9
                  mulhu        a0, t2, zero
                  mul          s0, t0, a0
                  c.srli       a4, 11
                  xori         s9, a6, -2048
                  c.nop
                  remu         t6, s2, s5
                  auipc        t6, 95018
                  mulh         s4, s7, t5
                  or           a5, a1, t6
                  c.nop
                  slt          s3, a4, s5
                  sltiu        a4, t2, -709
                  sub          sp, a4, a4
                  srl          a4, ra, s8
                  sltu         s1, s6, s7
                  c.li         ra, 9
                  srl          a4, ra, s8
                  nop
                  or           a5, a1, t6
                  srai         s0, s4, 6
                  c.lui        a4, 9
                  sltiu        a4, t2, -709
                  slt          s3, a4, s5
                  sll          a1, s6, s9
                  sra          s2, t6, s1
                  c.slli       s5, 8
                  c.addi       s1, -1
                  c.addi16sp   sp, 464
                  sub          sp, a4, a4
                  rem          s3, a2, a3
                  srli         zero, ra, 0
                  mulhsu       a5, a0, s10
                  andi         t0, a0, -564
                  and          s9, s5, a4
                  lui          a2, 494335
                  c.and        a2, a3
                  c.xor        a3, a0
                  c.li         ra, 9
                  srai         s0, s4, 6
                  c.srai       a0, 24
                  sltu         s1, s6, s7
                  c.li         ra, 9
                  c.addi       s1, -1
                  c.and        a2, a3
                  and          s9, s5, a4
                  sltiu        a4, t2, -709
                  add          tp, a2, s8
                  c.lui        a4, 9
                  c.srli       a4, 11
                  sltu         s1, s6, s7
                  c.mv         a3, s10
                  auipc        t6, 95018
                  srli         zero, ra, 0
                  c.nop
                  c.srai       a0, 24
                  add          tp, a2, s8
                  sll          a1, s6, s9
                  c.srai       a0, 24
                  rem          s3, a2, a3
                  c.li         ra, 9
                  c.and        a2, a3
                  c.srli       a4, 11
                  remu         t6, s2, s5
                  sub          sp, a4, a4
                  or           a5, a1, t6
                  sltu         s1, s6, s7
                  slt          s3, a4, s5
                  c.andi       a5, 29
                  slli         gp, s11, 27
                  srli         zero, ra, 0
                  c.xor        a3, a0
                  c.andi       a5, 29
                  div          sp, s2, s5
                  c.xor        a3, a0
                  c.li         ra, 9
                  andi         t0, a0, -564
                  c.srai       a0, 24
                  c.nop
                  mul          s0, t0, a0
                  c.xor        a3, a0
                  c.xor        a3, a0
                  divu         s11, a1, gp
                  remu         t6, s2, s5
                  add          tp, a2, s8
                  c.add        s4, a4
                  c.add        s4, a4
                  c.lui        a4, 9
                  srl          a4, ra, s8
                  c.nop
                  slti         s3, s5, -238
                  sra          s2, t6, s1
                  nop
                  c.andi       a5, 29
                  sltiu        a4, t2, -709
                  sra          s2, t6, s1
                  or           a5, a1, t6
                  sltiu        a4, t2, -709
                  c.lui        a4, 9
                  lui          a2, 494335
                  srli         zero, ra, 0
                  c.sub        a0, a5
                  c.andi       a5, 29
                  sra          s2, t6, s1
                  c.lui        a4, 9
                  c.xor        a3, a0
                  ori          a3, t5, 1088
                  srli         zero, ra, 0
                  c.addi4spn   a3, sp, 400
                  rem          s3, a2, a3
                  mulhsu       a5, a0, s10
                  sltiu        a4, t2, -709
                  add          tp, a2, s8
                  add          tp, a2, s8
                  lui          a2, 494335
                  slli         gp, s11, 27
                  c.xor        a3, a0
                  rem          s3, a2, a3
                  mul          s0, t0, a0
                  addi         a5, a6, 639
                  auipc        t6, 95018
                  sra          s2, t6, s1
                  c.addi16sp   sp, 464
                  c.and        a2, a3
                  sltiu        a4, t2, -709
                  divu         s11, a1, gp
                  c.sub        a0, a5
                  sub          sp, a4, a4
                  c.addi4spn   a3, sp, 400
                  c.li         ra, 9
                  andi         t0, a0, -564
                  c.srai       a0, 24
                  c.nop
                  rem          s3, a2, a3
                  and          s9, s5, a4
                  mul          s0, t0, a0
                  c.srai       a0, 24
                  sltu         s1, s6, s7
                  c.srai       a0, 24
                  c.add        s4, a4
                  c.xor        a3, a0
                  mul          s0, t0, a0
                  xori         s9, a6, -2048
                  auipc        t6, 95018
                  c.nop
                  sub          sp, a4, a4
                  c.addi16sp   sp, 464
                  divu         s11, a1, gp
                  auipc        t6, 95018
                  c.li         ra, 9
                  addi         a5, a6, 639
                  divu         s11, a1, gp
                  mulhsu       a5, a0, s10
                  c.lui        a4, 9
                  c.nop
                  slti         s3, s5, -238
                  c.addi       s1, -1
                  c.slli       s5, 8
                  c.li         ra, 9
                  xor          a6, s1, sp
                  c.sub        a0, a5
                  sltu         s1, s6, s7
                  c.nop
                  c.or         s1, a0
                  divu         s11, a1, gp
                  slli         gp, s11, 27
                  c.mv         a3, s10
                  div          sp, s2, s5
                  c.nop
                  ori          a3, t5, 1088
                  c.slli       s5, 8
                  xori         s9, a6, -2048
                  ori          a3, t5, 1088
                  c.mv         a3, s10
                  mulh         s4, s7, t5
                  remu         t6, s2, s5
                  mulhsu       a5, a0, s10
                  c.add        s4, a4
                  c.srli       a4, 11
                  c.srli       a4, 11
                  c.addi16sp   sp, 464
                  and          s9, s5, a4
                  sra          s2, t6, s1
                  sra          s2, t6, s1
                  rem          s3, a2, a3
                  mulh         s4, s7, t5
                  lui          a2, 494335
                  slli         gp, s11, 27
                  xori         s9, a6, -2048
                  mul          s0, t0, a0
                  c.sub        a0, a5
                  slti         s3, s5, -238
                  c.andi       a5, 29
                  c.andi       a5, 29
                  divu         s11, a1, gp
                  auipc        t6, 95018
                  c.or         s1, a0
                  c.and        a2, a3
                  ori          a3, t5, 1088
                  mul          s0, t0, a0
                  remu         t6, s2, s5
                  mul          s0, t0, a0
                  slli         gp, s11, 27
                  srli         zero, ra, 0
                  xor          a6, s1, sp
                  sll          a1, s6, s9
                  add          tp, a2, s8
                  c.sub        a0, a5
                  c.lui        a4, 9
                  addi         a5, a6, 639
                  or           a5, a1, t6
                  sub          sp, a4, a4
                  srli         zero, ra, 0
                  c.srai       a0, 24
                  addi         a5, a6, 639
                  srl          a4, ra, s8
                  mul          s0, t0, a0
                  and          s9, s5, a4
                  ori          a3, t5, 1088
                  srli         zero, ra, 0
                  c.and        a2, a3
                  c.li         ra, 9
                  mulhsu       a5, a0, s10
                  divu         s11, a1, gp
                  and          s9, s5, a4
                  c.andi       a5, 29
                  mulhu        a0, t2, zero
                  mulhsu       a5, a0, s10
                  sll          a1, s6, s9
                  lui          a2, 494335
                  remu         t6, s2, s5
                  andi         t0, a0, -564
                  c.andi       a5, 29
                  c.slli       s5, 8
                  c.addi       s1, -1
                  c.or         s1, a0
                  srli         zero, ra, 0
                  c.add        s4, a4
                  c.lui        a4, 9
                  nop
                  slti         s3, s5, -238
                  slt          s3, a4, s5
                  c.andi       a5, 29
                  srli         zero, ra, 0
                  c.xor        a3, a0
                  slt          s3, a4, s5
                  addi         a5, a6, 639
                  mulh         s4, s7, t5
                  divu         s11, a1, gp
                  sltu         s1, s6, s7
                  srai         s0, s4, 6
                  rem          s3, a2, a3
                  lui          a2, 494335
                  add          tp, a2, s8
                  auipc        t6, 95018
                  c.sub        a0, a5
                  div          sp, s2, s5
                  sub          sp, a4, a4
                  mulh         s4, s7, t5
                  xor          a6, s1, sp
                  xori         s9, a6, -2048
                  or           a5, a1, t6
                  c.andi       a5, 29
                  mulh         s4, s7, t5
                  c.li         ra, 9
                  c.sub        a0, a5
                  addi         a5, a6, 639
                  slti         s3, s5, -238
                  div          sp, s2, s5
                  c.srli       a4, 11
                  sltu         s1, s6, s7
                  slli         gp, s11, 27
                  c.addi16sp   sp, 464
                  lui          a2, 494335
                  auipc        t6, 95018
                  remu         t6, s2, s5
                  c.nop
                  add          tp, a2, s8
                  slt          s3, a4, s5
                  c.srai       a0, 24
                  div          sp, s2, s5
                  and          s9, s5, a4
                  mul          s0, t0, a0
                  c.and        a2, a3
                  nop
                  c.add        s4, a4
                  srli         zero, ra, 0
                  ori          a3, t5, 1088
                  addi         a5, a6, 639
                  add          tp, a2, s8
                  c.or         s1, a0
                  c.addi       s1, -1
                  divu         s11, a1, gp
                  c.or         s1, a0
                  c.addi       s1, -1
                  and          s9, s5, a4
                  xor          a6, s1, sp
                  xori         s9, a6, -2048
                  c.srai       a0, 24
                  rem          s3, a2, a3
                  c.mv         a3, s10
                  srli         zero, ra, 0
                  c.addi16sp   sp, 464
                  xori         s9, a6, -2048
                  add          tp, a2, s8
                  c.srai       a0, 24
                  nop
                  c.slli       s5, 8
                  c.sub        a0, a5
                  c.xor        a3, a0
                  mulhu        a0, t2, zero
                  sltu         s1, s6, s7
                  slti         s3, s5, -238
                  c.addi4spn   a3, sp, 400
                  sltiu        a4, t2, -709
                  c.nop
                  c.mv         a3, s10
                  slti         s3, s5, -238
                  mulhsu       a5, a0, s10
                  c.srai       a0, 24
                  lui          a2, 494335
                  or           a5, a1, t6
                  ori          a3, t5, 1088
                  c.or         s1, a0
                  c.andi       a5, 29
                  sltiu        a4, t2, -709
                  sub          sp, a4, a4
                  slli         gp, s11, 27
                  c.addi       s1, -1
                  c.or         s1, a0
                  andi         t0, a0, -564
                  mulh         s4, s7, t5
                  slli         gp, s11, 27
                  addi         a5, a6, 639
                  srl          a4, ra, s8
                  xor          a6, s1, sp
                  rem          s3, a2, a3
                  divu         s11, a1, gp
                  slti         s3, s5, -238
                  lui          a2, 494335
                  addi         a5, a6, 639
                  mulhu        a0, t2, zero
                  mulh         s4, s7, t5
                  srli         zero, ra, 0
                  remu         t6, s2, s5
                  c.slli       s5, 8
                  sltu         s1, s6, s7
                  c.sub        a0, a5
                  c.addi4spn   a3, sp, 400
                  remu         t6, s2, s5
                  sltiu        a4, t2, -709
                  sra          s2, t6, s1
                  slti         s3, s5, -238
                  c.or         s1, a0
                  c.li         ra, 9
                  srli         zero, ra, 0
                  c.nop
                  srli         zero, ra, 0
                  xori         s9, a6, -2048
                  auipc        t6, 95018
                  slti         s3, s5, -238
                  mulhsu       a5, a0, s10
                  xori         s9, a6, -2048
                  mulh         s4, s7, t5
                  slti         s3, s5, -238
                  srli         zero, ra, 0
                  sll          a1, s6, s9
                  srai         s0, s4, 6
                  srai         s0, s4, 6
                  c.srai       a0, 24
                  c.srli       a4, 11
                  sra          s2, t6, s1
                  slti         s3, s5, -238
                  mul          s0, t0, a0
                  c.add        s4, a4
                  c.add        s4, a4
                  c.nop
                  lui          a2, 494335
                  srai         s0, s4, 6
                  ori          a3, t5, 1088
                  c.li         ra, 9
                  rem          s3, a2, a3
                  c.addi4spn   a3, sp, 400
                  slti         s3, s5, -238
                  sltu         s1, s6, s7
                  sltu         s1, s6, s7
                  add          tp, a2, s8
                  remu         t6, s2, s5
                  sra          s2, t6, s1
                  mulhu        a0, t2, zero
                  c.nop
                  li           a4, 0xfab0fbd1 #start riscv_int_numeric_corner_stream_33
                  li           t2, 0x0
                  li           a0, 0x0
                  li           t0, 0x80000000
                  li           t5, 0xf0f628d1
                  li           s2, 0xac1f3ac4
                  li           a7, 0xffffffff
                  li           s1, 0x80000000
                  li           s0, 0x590aac94
                  li           s9, 0x80000000
                  mulhu        t0, s2, t0
                  add          a0, s2, s9
                  addi         s1, t0, 639
                  add          a0, s2, s9
                  lui          s0, 494335
                  add          a0, s2, s9
                  auipc        s2, 95018
                  mulhsu       s1, a0, t2
                  divu         t5, a0, s1
                  nop
                  nop
                  nop
                  mul          s9, a4, a4
                  mulhsu       s1, a0, t2
                  mulhsu       s1, a0, t2
                  mulh         a0, s2, s9
                  remu         a4, s0, a4 #end riscv_int_numeric_corner_stream_33
                  rem          s3, a2, a3
                  add          tp, a2, s8
                  nop
                  divu         s11, a1, gp
                  srl          a4, ra, s8
                  c.and        a2, a3
                  c.or         s1, a0
                  sub          sp, a4, a4
                  rem          s3, a2, a3
                  sra          s2, t6, s1
                  c.andi       a5, 29
                  c.addi4spn   a3, sp, 400
                  mulhu        a0, t2, zero
                  c.srai       a0, 24
                  c.add        s4, a4
                  srli         zero, ra, 0
                  mulhu        a0, t2, zero
                  c.slli       s5, 8
                  sra          s2, t6, s1
                  c.sub        a0, a5
                  mulh         s4, s7, t5
                  srai         s0, s4, 6
                  mul          s0, t0, a0
                  c.slli       s5, 8
                  sra          s2, t6, s1
                  srl          a4, ra, s8
                  and          s9, s5, a4
                  xor          a6, s1, sp
                  c.srai       a0, 24
                  addi         a5, a6, 639
                  ori          a3, t5, 1088
                  sltu         s1, s6, s7
                  div          sp, s2, s5
                  slt          s3, a4, s5
                  c.add        s4, a4
                  c.addi16sp   sp, 464
                  div          sp, s2, s5
                  slti         s3, s5, -238
                  c.slli       s5, 8
                  sub          sp, a4, a4
                  c.slli       s5, 8
                  lui          a2, 494335
                  slli         gp, s11, 27
                  sub          sp, a4, a4
                  xor          a6, s1, sp
                  div          sp, s2, s5
                  div          sp, s2, s5
                  srl          a4, ra, s8
                  ori          a3, t5, 1088
                  add          tp, a2, s8
                  auipc        t6, 95018
                  c.xor        a3, a0
                  remu         t6, s2, s5
                  mulh         s4, s7, t5
                  c.addi       s1, -1
                  nop
                  mul          s0, t0, a0
                  remu         t6, s2, s5
                  andi         t0, a0, -564
                  add          tp, a2, s8
                  div          sp, s2, s5
                  c.lui        a4, 9
                  c.xor        a3, a0
                  c.or         s1, a0
                  c.andi       a5, 29
                  sltiu        a4, t2, -709
                  auipc        t6, 95018
                  c.nop
                  addi         a5, a6, 639
                  div          sp, s2, s5
                  c.and        a2, a3
                  mulh         s4, s7, t5
                  auipc        t6, 95018
                  mul          s0, t0, a0
                  lui          a2, 494335
                  divu         s11, a1, gp
                  c.nop
                  srli         zero, ra, 0
                  or           a5, a1, t6
                  div          sp, s2, s5
                  rem          s3, a2, a3
                  srai         s0, s4, 6
                  srl          a4, ra, s8
                  xor          a6, s1, sp
                  c.mv         a3, s10
                  divu         s11, a1, gp
                  sltu         s1, s6, s7
                  c.li         ra, 9
                  c.lui        a4, 9
                  slti         s3, s5, -238
                  andi         t0, a0, -564
                  divu         s11, a1, gp
                  sll          a1, s6, s9
                  c.add        s4, a4
                  c.li         ra, 9
                  srai         s0, s4, 6
                  c.addi4spn   a3, sp, 400
                  mulhu        a0, t2, zero
                  c.addi4spn   a3, sp, 400
                  sra          s2, t6, s1
                  nop
                  andi         t0, a0, -564
                  divu         s11, a1, gp
                  c.lui        a4, 9
                  c.andi       a5, 29
                  mulhu        a0, t2, zero
                  sra          s2, t6, s1
                  sra          s2, t6, s1
                  nop
                  c.and        a2, a3
                  c.xor        a3, a0
                  sltu         s1, s6, s7
                  or           a5, a1, t6
                  c.and        a2, a3
                  srai         s0, s4, 6
                  c.srli       a4, 11
                  mulhsu       a5, a0, s10
                  srai         s0, s4, 6
                  ori          a3, t5, 1088
                  srli         zero, ra, 0
                  c.xor        a3, a0
                  c.and        a2, a3
                  sra          s2, t6, s1
                  c.xor        a3, a0
                  sub          sp, a4, a4
                  slt          s3, a4, s5
                  c.add        s4, a4
                  c.add        s4, a4
                  slt          s3, a4, s5
                  srli         zero, ra, 0
                  mul          s0, t0, a0
                  c.slli       s5, 8
                  c.addi       s1, -1
                  sll          a1, s6, s9
                  xor          a6, s1, sp
                  xor          a6, s1, sp
                  mul          s0, t0, a0
                  srl          a4, ra, s8
                  xori         s9, a6, -2048
                  c.srli       a4, 11
                  c.srli       a4, 11
                  sra          s2, t6, s1
                  divu         s11, a1, gp
                  sltu         s1, s6, s7
                  nop
                  c.li         ra, 9
                  c.srli       a4, 11
                  c.srli       a4, 11
                  add          tp, a2, s8
                  div          sp, s2, s5
                  ori          a3, t5, 1088
                  mul          s0, t0, a0
                  lui          a2, 494335
                  sll          a1, s6, s9
                  remu         t6, s2, s5
                  c.srli       a4, 11
                  or           a5, a1, t6
                  c.andi       a5, 29
                  c.and        a2, a3
                  c.addi16sp   sp, 464
                  divu         s11, a1, gp
                  slt          s3, a4, s5
                  nop
                  sra          s2, t6, s1
                  c.nop
                  srai         s0, s4, 6
                  c.and        a2, a3
                  xori         s9, a6, -2048
                  slt          s3, a4, s5
                  auipc        t6, 95018
                  mulhsu       a5, a0, s10
                  slt          s3, a4, s5
                  c.li         ra, 9
                  sra          s2, t6, s1
                  and          s9, s5, a4
                  and          s9, s5, a4
                  srai         s0, s4, 6
                  c.li         ra, 9
                  mulh         s4, s7, t5
                  srli         zero, ra, 0
                  divu         s11, a1, gp
                  sra          s2, t6, s1
                  sra          s2, t6, s1
                  mulh         s4, s7, t5
                  c.li         ra, 9
                  or           a5, a1, t6
                  slti         s3, s5, -238
                  sub          sp, a4, a4
                  c.sub        a0, a5
                  lui          a2, 494335
                  mulhsu       a5, a0, s10
                  c.or         s1, a0
                  c.srai       a0, 24
                  c.addi       s1, -1
                  c.lui        a4, 9
                  div          sp, s2, s5
                  sub          sp, a4, a4
                  c.sub        a0, a5
                  c.li         ra, 9
                  mulhsu       a5, a0, s10
                  c.slli       s5, 8
                  c.lui        a4, 9
                  c.srli       a4, 11
                  div          sp, s2, s5
                  divu         s11, a1, gp
                  sll          a1, s6, s9
                  remu         t6, s2, s5
                  c.xor        a3, a0
                  c.or         s1, a0
                  xor          a6, s1, sp
                  c.nop
                  c.li         ra, 9
                  remu         t6, s2, s5
                  c.andi       a5, 29
                  mulhu        a0, t2, zero
                  c.li         ra, 9
                  c.and        a2, a3
                  slti         s3, s5, -238
                  c.srli       a4, 11
                  c.sub        a0, a5
                  c.addi4spn   a3, sp, 400
                  xori         s9, a6, -2048
                  nop
                  or           a5, a1, t6
                  c.addi16sp   sp, 464
                  add          tp, a2, s8
                  addi         a5, a6, 639
                  c.mv         a3, s10
                  lui          a2, 494335
                  c.mv         a3, s10
                  addi         a5, a6, 639
                  slli         gp, s11, 27
                  sltiu        a4, t2, -709
                  c.xor        a3, a0
                  c.addi4spn   a3, sp, 400
                  c.sub        a0, a5
                  ori          a3, t5, 1088
                  xori         s9, a6, -2048
                  sll          a1, s6, s9
                  c.nop
                  add          tp, a2, s8
                  slt          s3, a4, s5
                  c.and        a2, a3
                  c.li         ra, 9
                  c.mv         a3, s10
                  sltu         s1, s6, s7
                  srli         zero, ra, 0
                  c.add        s4, a4
                  nop
                  auipc        t6, 95018
                  slt          s3, a4, s5
                  c.slli       s5, 8
                  xori         s9, a6, -2048
                  mulhu        a0, t2, zero
                  sltiu        a4, t2, -709
                  ori          a3, t5, 1088
                  srli         zero, ra, 0
                  ori          a3, t5, 1088
                  nop
                  divu         s11, a1, gp
                  mulhu        a0, t2, zero
                  nop
                  ori          a3, t5, 1088
                  mulhu        a0, t2, zero
                  xor          a6, s1, sp
                  srai         s0, s4, 6
                  nop
                  c.slli       s5, 8
                  lui          a2, 494335
                  c.mv         a3, s10
                  c.srai       a0, 24
                  sltiu        a4, t2, -709
                  c.mv         a3, s10
                  srli         zero, ra, 0
                  xor          a6, s1, sp
                  c.xor        a3, a0
                  xor          a6, s1, sp
                  addi         a5, a6, 639
                  mulh         s4, s7, t5
                  c.li         ra, 9
                  srli         zero, ra, 0
                  c.addi       s1, -1
                  addi         a5, a6, 639
                  xor          a6, s1, sp
                  c.nop
                  or           a5, a1, t6
                  c.or         s1, a0
                  c.srli       a4, 11
                  remu         t6, s2, s5
                  slti         s3, s5, -238
                  c.li         ra, 9
                  slli         gp, s11, 27
                  auipc        t6, 95018
                  auipc        t6, 95018
                  srai         s0, s4, 6
                  c.xor        a3, a0
                  c.addi16sp   sp, 464
                  divu         s11, a1, gp
                  c.li         ra, 9
                  c.srli       a4, 11
                  srl          a4, ra, s8
                  xori         s9, a6, -2048
                  andi         t0, a0, -564
                  srli         zero, ra, 0
                  c.slli       s5, 8
                  slti         s3, s5, -238
                  c.slli       s5, 8
                  sub          sp, a4, a4
                  c.slli       s5, 8
                  rem          s3, a2, a3
                  c.or         s1, a0
                  mulh         s4, s7, t5
                  sltu         s1, s6, s7
                  divu         s11, a1, gp
                  c.addi       s1, -1
                  c.mv         a3, s10
                  c.nop
                  mulhu        a0, t2, zero
                  srli         zero, ra, 0
                  slli         gp, s11, 27
                  mulh         s4, s7, t5
                  addi         a5, a6, 639
                  nop
                  div          sp, s2, s5
                  mul          s0, t0, a0
                  xori         s9, a6, -2048
                  sll          a1, s6, s9
                  sll          a1, s6, s9
                  addi         a5, a6, 639
                  slt          s3, a4, s5
                  srai         s0, s4, 6
                  sltu         s1, s6, s7
                  xori         s9, a6, -2048
                  slt          s3, a4, s5
                  mul          s0, t0, a0
                  c.addi       s1, -1
                  sub          sp, a4, a4
                  add          tp, a2, s8
                  sltiu        a4, t2, -709
                  c.sub        a0, a5
                  c.addi4spn   a3, sp, 400
                  c.srli       a4, 11
                  mulhu        a0, t2, zero
                  srai         s0, s4, 6
                  srai         s0, s4, 6
                  c.or         s1, a0
                  c.add        s4, a4
                  div          sp, s2, s5
                  or           a5, a1, t6
                  sltu         s1, s6, s7
                  xori         s9, a6, -2048
                  c.add        s4, a4
                  mulh         s4, s7, t5
                  c.mv         a3, s10
                  c.xor        a3, a0
                  auipc        t6, 95018
                  c.srai       a0, 24
                  ori          a3, t5, 1088
                  c.srai       a0, 24
                  srl          a4, ra, s8
                  mulh         s4, s7, t5
                  andi         t0, a0, -564
                  c.and        a2, a3
                  c.or         s1, a0
                  nop
                  div          sp, s2, s5
                  c.li         ra, 9
                  add          tp, a2, s8
                  srl          a4, ra, s8
                  c.addi16sp   sp, 464
                  sll          a1, s6, s9
                  mulhsu       a5, a0, s10
                  sra          s2, t6, s1
                  slt          s3, a4, s5
                  c.slli       s5, 8
                  c.mv         a3, s10
                  mulhu        a0, t2, zero
                  c.add        s4, a4
                  sra          s2, t6, s1
                  mulhu        a0, t2, zero
                  c.mv         a3, s10
                  sra          s2, t6, s1
                  c.sub        a0, a5
                  remu         t6, s2, s5
                  mulhsu       a5, a0, s10
                  or           a5, a1, t6
                  sra          s2, t6, s1
                  c.sub        a0, a5
                  c.li         ra, 9
                  xori         s9, a6, -2048
                  srli         zero, ra, 0
                  or           a5, a1, t6
                  slti         s3, s5, -238
                  slt          s3, a4, s5
                  divu         s11, a1, gp
                  sra          s2, t6, s1
                  slti         s3, s5, -238
                  c.andi       a5, 29
                  c.li         ra, 9
                  sub          sp, a4, a4
                  mulhsu       a5, a0, s10
                  srai         s0, s4, 6
                  andi         t0, a0, -564
                  divu         s11, a1, gp
                  slti         s3, s5, -238
                  c.andi       a5, 29
                  c.addi16sp   sp, 464
                  xor          a6, s1, sp
                  and          s9, s5, a4
                  ori          a3, t5, 1088
                  ori          a3, t5, 1088
                  c.sub        a0, a5
                  srli         zero, ra, 0
                  sltiu        a4, t2, -709
                  c.li         ra, 9
                  andi         t0, a0, -564
                  auipc        t6, 95018
                  c.lui        a4, 9
                  srai         s0, s4, 6
                  c.lui        a4, 9
                  srai         s0, s4, 6
                  nop
                  add          tp, a2, s8
                  andi         t0, a0, -564
                  slti         s3, s5, -238
                  slti         s3, s5, -238
                  c.sub        a0, a5
                  rem          s3, a2, a3
                  sll          a1, s6, s9
                  sltu         s1, s6, s7
                  srl          a4, ra, s8
                  c.add        s4, a4
                  c.or         s1, a0
                  c.srai       a0, 24
                  slt          s3, a4, s5
                  slti         s3, s5, -238
                  c.li         ra, 9
                  c.addi16sp   sp, 464
                  add          tp, a2, s8
                  sll          a1, s6, s9
                  srai         s0, s4, 6
                  mulhu        a0, t2, zero
                  divu         s11, a1, gp
                  slli         gp, s11, 27
                  srli         zero, ra, 0
                  sll          a1, s6, s9
                  xori         s9, a6, -2048
                  c.addi4spn   a3, sp, 400
                  andi         t0, a0, -564
                  mulh         s4, s7, t5
                  sll          a1, s6, s9
                  slt          s3, a4, s5
                  nop
                  lui          a2, 494335
                  xori         s9, a6, -2048
                  and          s9, s5, a4
                  mul          s0, t0, a0
                  c.slli       s5, 8
                  srl          a4, ra, s8
                  mulh         s4, s7, t5
                  slli         gp, s11, 27
                  div          sp, s2, s5
                  xor          a6, s1, sp
                  xori         s9, a6, -2048
                  sub          sp, a4, a4
                  c.lui        a4, 9
                  remu         t6, s2, s5
                  c.add        s4, a4
                  andi         t0, a0, -564
                  c.nop
                  rem          s3, a2, a3
                  nop
                  mulhu        a0, t2, zero
                  c.addi       s1, -1
                  c.nop
                  auipc        t6, 95018
                  c.addi4spn   a3, sp, 400
                  c.li         ra, 9
                  and          s9, s5, a4
                  xor          a6, s1, sp
                  xori         s9, a6, -2048
                  and          s9, s5, a4
                  xor          a6, s1, sp
                  c.sub        a0, a5
                  c.addi16sp   sp, 464
                  slli         gp, s11, 27
                  sra          s2, t6, s1
                  c.nop
                  c.srai       a0, 24
                  c.mv         a3, s10
                  srli         zero, ra, 0
                  c.andi       a5, 29
                  c.mv         a3, s10
                  c.nop
                  mulhsu       a5, a0, s10
                  rem          s3, a2, a3
                  andi         t0, a0, -564
                  c.andi       a5, 29
                  mul          s0, t0, a0
                  slli         gp, s11, 27
                  xori         s9, a6, -2048
                  c.andi       a5, 29
                  add          tp, a2, s8
                  ori          a3, t5, 1088
                  c.lui        a4, 9
                  auipc        t6, 95018
                  slli         gp, s11, 27
                  c.addi4spn   a3, sp, 400
                  c.lui        a4, 9
                  c.or         s1, a0
                  rem          s3, a2, a3
                  mulhu        a0, t2, zero
                  c.addi16sp   sp, 464
                  addi         a5, a6, 639
                  xor          a6, s1, sp
                  c.add        s4, a4
                  and          s9, s5, a4
                  slt          s3, a4, s5
                  srli         zero, ra, 0
                  mulhsu       a5, a0, s10
                  addi         a5, a6, 639
                  srl          a4, ra, s8
                  c.srli       a4, 11
                  c.and        a2, a3
                  slt          s3, a4, s5
                  c.lui        a4, 9
                  xor          a6, s1, sp
                  sub          sp, a4, a4
                  rem          s3, a2, a3
                  c.lui        a4, 9
                  rem          s3, a2, a3
                  c.addi4spn   a3, sp, 400
                  c.sub        a0, a5
                  sltu         s1, s6, s7
                  srl          a4, ra, s8
                  c.add        s4, a4
                  c.or         s1, a0
                  mulhu        a0, t2, zero
                  c.xor        a3, a0
                  div          sp, s2, s5
                  c.slli       s5, 8
                  mulhu        a0, t2, zero
                  c.srai       a0, 24
                  c.lui        a4, 9
                  c.sub        a0, a5
                  slli         gp, s11, 27
                  c.slli       s5, 8
                  sub          sp, a4, a4
                  c.xor        a3, a0
                  remu         t6, s2, s5
                  divu         s11, a1, gp
                  slt          s3, a4, s5
                  add          tp, a2, s8
                  c.addi4spn   a3, sp, 400
                  slti         s3, s5, -238
                  c.add        s4, a4
                  c.add        s4, a4
                  mulhsu       a5, a0, s10
                  add          tp, a2, s8
                  andi         t0, a0, -564
                  mulhsu       a5, a0, s10
                  c.and        a2, a3
                  remu         t6, s2, s5
                  rem          s3, a2, a3
                  andi         t0, a0, -564
                  slti         s3, s5, -238
                  or           a5, a1, t6
                  c.and        a2, a3
                  srai         s0, s4, 6
                  c.mv         a3, s10
                  c.andi       a5, 29
                  c.xor        a3, a0
                  divu         s11, a1, gp
                  srl          a4, ra, s8
                  srli         zero, ra, 0
                  nop
                  srli         zero, ra, 0
                  lui          a2, 494335
                  c.add        s4, a4
                  xor          a6, s1, sp
                  c.addi16sp   sp, 464
                  mulhsu       a5, a0, s10
                  srai         s0, s4, 6
                  rem          s3, a2, a3
                  mul          s0, t0, a0
                  ori          a3, t5, 1088
                  add          tp, a2, s8
                  add          tp, a2, s8
                  or           a5, a1, t6
                  nop
                  c.addi4spn   a3, sp, 400
                  mul          s0, t0, a0
                  nop
                  or           a5, a1, t6
                  c.mv         a3, s10
                  or           a5, a1, t6
                  c.addi16sp   sp, 464
                  divu         s11, a1, gp
                  c.mv         a3, s10
                  c.addi4spn   a3, sp, 400
                  rem          s3, a2, a3
                  add          tp, a2, s8
                  andi         t0, a0, -564
                  auipc        t6, 95018
                  c.srli       a4, 11
                  c.sub        a0, a5
                  auipc        t6, 95018
                  slt          s3, a4, s5
                  c.li         ra, 9
                  div          sp, s2, s5
                  sltu         s1, s6, s7
                  c.xor        a3, a0
                  c.or         s1, a0
                  sltu         s1, s6, s7
                  sub          sp, a4, a4
                  c.mv         a3, s10
                  c.addi16sp   sp, 464
                  c.srli       a4, 11
                  slti         s3, s5, -238
                  sltu         s1, s6, s7
                  xori         s9, a6, -2048
                  remu         t6, s2, s5
                  sltu         s1, s6, s7
                  xor          a6, s1, sp
                  slti         s3, s5, -238
                  divu         s11, a1, gp
                  auipc        t6, 95018
                  mulhsu       a5, a0, s10
                  xori         s9, a6, -2048
                  c.add        s4, a4
                  c.lui        a4, 9
                  c.addi       s1, -1
                  slli         gp, s11, 27
                  remu         t6, s2, s5
                  mulhsu       a5, a0, s10
                  c.add        s4, a4
                  slli         gp, s11, 27
                  c.andi       a5, 29
                  rem          s3, a2, a3
                  mul          s0, t0, a0
                  slli         gp, s11, 27
                  c.andi       a5, 29
                  c.add        s4, a4
                  c.andi       a5, 29
                  auipc        t6, 95018
                  c.slli       s5, 8
                  mulhu        a0, t2, zero
                  slt          s3, a4, s5
                  or           a5, a1, t6
                  c.slli       s5, 8
                  rem          s3, a2, a3
                  c.addi       s1, -1
                  srai         s0, s4, 6
                  ori          a3, t5, 1088
                  c.addi       s1, -1
                  c.nop
                  c.srai       a0, 24
                  c.addi       s1, -1
                  srli         zero, ra, 0
                  sltiu        a4, t2, -709
                  slt          s3, a4, s5
                  srai         s0, s4, 6
                  slli         gp, s11, 27
                  srl          a4, ra, s8
                  srli         zero, ra, 0
                  c.mv         a3, s10
                  sra          s2, t6, s1
                  c.mv         a3, s10
                  sub          sp, a4, a4
                  srai         s0, s4, 6
                  addi         a5, a6, 639
                  c.andi       a5, 29
                  nop
                  mul          s0, t0, a0
                  remu         t6, s2, s5
                  remu         t6, s2, s5
                  c.addi       s1, -1
                  sltiu        a4, t2, -709
                  c.addi16sp   sp, 464
                  rem          s3, a2, a3
                  c.addi4spn   a3, sp, 400
                  addi         a5, a6, 639
                  c.addi4spn   a3, sp, 400
                  remu         t6, s2, s5
                  xor          a6, s1, sp
                  c.addi       s1, -1
                  c.andi       a5, 29
                  c.addi16sp   sp, 464
                  c.andi       a5, 29
                  c.lui        a4, 9
                  srl          a4, ra, s8
                  c.lui        a4, 9
                  sra          s2, t6, s1
                  xor          a6, s1, sp
                  add          tp, a2, s8
                  rem          s3, a2, a3
                  and          s9, s5, a4
                  mulh         s4, s7, t5
                  remu         t6, s2, s5
                  xor          a6, s1, sp
                  c.li         ra, 9
                  rem          s3, a2, a3
                  c.srli       a4, 11
                  sra          s2, t6, s1
                  or           a5, a1, t6
                  addi         a5, a6, 639
                  c.add        s4, a4
                  c.srli       a4, 11
                  addi         a5, a6, 639
                  c.slli       s5, 8
                  c.addi       s1, -1
                  sltiu        a4, t2, -709
                  div          sp, s2, s5
                  c.lui        a4, 9
                  c.andi       a5, 29
                  c.sub        a0, a5
                  or           a5, a1, t6
                  srli         zero, ra, 0
                  slli         gp, s11, 27
                  and          s9, s5, a4
                  c.addi16sp   sp, 464
                  slt          s3, a4, s5
                  mulhsu       a5, a0, s10
                  srl          a4, ra, s8
                  and          s9, s5, a4
                  c.xor        a3, a0
                  addi         a5, a6, 639
                  mulhsu       a5, a0, s10
                  c.add        s4, a4
                  c.srai       a0, 24
                  c.slli       s5, 8
                  slti         s3, s5, -238
                  nop
                  c.add        s4, a4
                  sltiu        a4, t2, -709
                  c.addi16sp   sp, 464
                  remu         t6, s2, s5
                  c.nop
                  c.or         s1, a0
                  sub          sp, a4, a4
                  slli         gp, s11, 27
                  sltiu        a4, t2, -709
                  c.add        s4, a4
                  slti         s3, s5, -238
                  sra          s2, t6, s1
                  andi         t0, a0, -564
                  c.add        s4, a4
                  sltu         s1, s6, s7
                  c.slli       s5, 8
                  srli         zero, ra, 0
                  addi         a5, a6, 639
                  rem          s3, a2, a3
                  c.nop
                  mulhsu       a5, a0, s10
                  c.lui        a4, 9
                  andi         t0, a0, -564
                  auipc        t6, 95018
                  ori          a3, t5, 1088
                  rem          s3, a2, a3
                  slti         s3, s5, -238
                  or           a5, a1, t6
                  sll          a1, s6, s9
                  c.or         s1, a0
                  c.addi16sp   sp, 464
                  mulhsu       a5, a0, s10
                  add          tp, a2, s8
                  mul          s0, t0, a0
                  addi         a5, a6, 639
                  c.add        s4, a4
                  slli         gp, s11, 27
                  c.andi       a5, 29
                  rem          s3, a2, a3
                  or           a5, a1, t6
                  or           a5, a1, t6
                  mul          s0, t0, a0
                  c.add        s4, a4
                  c.srli       a4, 11
                  ori          a3, t5, 1088
                  srl          a4, ra, s8
                  sll          a1, s6, s9
                  mulh         s4, s7, t5
                  div          sp, s2, s5
                  xor          a6, s1, sp
                  sltiu        a4, t2, -709
                  xori         s9, a6, -2048
                  c.srli       a4, 11
                  nop
                  srl          a4, ra, s8
                  addi         a5, a6, 639
                  c.lui        a4, 9
                  divu         s11, a1, gp
                  c.li         ra, 9
                  c.or         s1, a0
                  divu         s11, a1, gp
                  c.add        s4, a4
                  mulhsu       a5, a0, s10
                  srli         zero, ra, 0
                  xori         s9, a6, -2048
                  xor          a6, s1, sp
                  andi         t0, a0, -564
                  c.andi       a5, 29
                  sra          s2, t6, s1
                  div          sp, s2, s5
                  c.xor        a3, a0
                  add          tp, a2, s8
                  remu         t6, s2, s5
                  srai         s0, s4, 6
                  div          sp, s2, s5
                  and          s9, s5, a4
                  slti         s3, s5, -238
                  add          tp, a2, s8
                  c.or         s1, a0
                  mulhsu       a5, a0, s10
                  c.or         s1, a0
                  sltiu        a4, t2, -709
                  c.andi       a5, 29
                  c.add        s4, a4
                  addi         a5, a6, 639
                  sll          a1, s6, s9
                  c.and        a2, a3
                  srl          a4, ra, s8
                  nop
                  c.nop
                  c.slli       s5, 8
                  srli         zero, ra, 0
                  c.and        a2, a3
                  c.addi       s1, -1
                  c.mv         a3, s10
                  mulhsu       a5, a0, s10
                  mulhu        a0, t2, zero
                  li           s5, 0x818b6ce3 #start riscv_int_numeric_corner_stream_25
                  li           a7, 0x80000000
                  li           s4, 0xffffffff
                  li           t4, 0x80000000
                  li           a3, 0xca5d0a03
                  li           t5, 0x0
                  li           t1, 0x0
                  li           s11, 0x80000000
                  li           s3, 0x0
                  li           s1, 0x0
                  div          a3, a3, s4
                  rem          a7, s4, a7
                  mulh         s3, s11, t4
                  add          s3, s11, t4
                  addi         a7, t1, 639
                  divu         t5, s3, a7
                  rem          a7, s4, a7
                  lui          a3, 494335
                  mulh         s3, s11, t4
                  rem          a7, s4, a7
                  mulh         s3, s11, t4
                  sub          a3, s1, t1
                  sub          a3, s1, t1
                  mul          t4, s4, s4
                  lui          a3, 494335
                  add          s3, s11, t4
                  rem          a7, s4, a7
                  div          a3, a3, s4
                  auipc        s11, 95018
                  mul          t4, s4, s4 #end riscv_int_numeric_corner_stream_25
                  c.lui        a4, 9
                  c.andi       a5, 29
                  c.xor        a3, a0
                  mulh         s4, s7, t5
                  srl          a4, ra, s8
                  c.nop
                  c.lui        a4, 9
                  sltiu        a4, t2, -709
                  c.sub        a0, a5
                  mul          s0, t0, a0
                  c.mv         a3, s10
                  auipc        t6, 95018
                  and          s9, s5, a4
                  c.add        s4, a4
                  c.nop
                  c.add        s4, a4
                  sltiu        a4, t2, -709
                  c.xor        a3, a0
                  c.add        s4, a4
                  sltu         s1, s6, s7
                  c.addi4spn   a3, sp, 400
                  slti         s3, s5, -238
                  mulhsu       a5, a0, s10
                  mulhsu       a5, a0, s10
                  c.nop
                  sll          a1, s6, s9
                  sltiu        a4, t2, -709
                  c.mv         a3, s10
                  c.addi       s1, -1
                  xor          a6, s1, sp
                  c.addi16sp   sp, 464
                  mulh         s4, s7, t5
                  slti         s3, s5, -238
                  mulhsu       a5, a0, s10
                  c.or         s1, a0
                  mul          s0, t0, a0
                  divu         s11, a1, gp
                  sltiu        a4, t2, -709
                  andi         t0, a0, -564
                  mulhsu       a5, a0, s10
                  srli         zero, ra, 0
                  ori          a3, t5, 1088
                  slli         gp, s11, 27
                  and          s9, s5, a4
                  c.li         ra, 9
                  srai         s0, s4, 6
                  c.li         ra, 9
                  auipc        t6, 95018
                  mulh         s4, s7, t5
                  addi         a5, a6, 639
                  ori          a3, t5, 1088
                  c.slli       s5, 8
                  ori          a3, t5, 1088
                  srli         zero, ra, 0
                  srl          a4, ra, s8
                  slt          s3, a4, s5
                  srli         zero, ra, 0
                  ori          a3, t5, 1088
                  c.slli       s5, 8
                  sra          s2, t6, s1
                  c.srli       a4, 11
                  c.and        a2, a3
                  addi         a5, a6, 639
                  sltu         s1, s6, s7
                  c.xor        a3, a0
                  rem          s3, a2, a3
                  c.mv         a3, s10
                  auipc        t6, 95018
                  c.xor        a3, a0
                  c.sub        a0, a5
                  xori         s9, a6, -2048
                  nop
                  addi         a5, a6, 639
                  auipc        t6, 95018
                  c.srli       a4, 11
                  mul          s0, t0, a0
                  slli         gp, s11, 27
                  sub          sp, a4, a4
                  xor          a6, s1, sp
                  srl          a4, ra, s8
                  srli         zero, ra, 0
                  slli         gp, s11, 27
                  add          tp, a2, s8
                  mul          s0, t0, a0
                  slti         s3, s5, -238
                  add          tp, a2, s8
                  sub          sp, a4, a4
                  srai         s0, s4, 6
                  remu         t6, s2, s5
                  c.add        s4, a4
                  c.addi16sp   sp, 464
                  c.slli       s5, 8
                  c.addi       s1, -1
                  srl          a4, ra, s8
                  c.li         ra, 9
                  sll          a1, s6, s9
                  c.addi       s1, -1
                  srl          a4, ra, s8
                  addi         a5, a6, 639
                  c.add        s4, a4
                  sub          sp, a4, a4
                  nop
                  lui          a2, 494335
                  slti         s3, s5, -238
                  c.andi       a5, 29
                  c.addi16sp   sp, 464
                  slti         s3, s5, -238
                  c.addi16sp   sp, 464
                  slti         s3, s5, -238
                  andi         t0, a0, -564
                  xori         s9, a6, -2048
                  rem          s3, a2, a3
                  slti         s3, s5, -238
                  c.sub        a0, a5
                  divu         s11, a1, gp
                  add          tp, a2, s8
                  xori         s9, a6, -2048
                  auipc        t6, 95018
                  nop
                  c.srli       a4, 11
                  auipc        t6, 95018
                  c.addi       s1, -1
                  mulhu        a0, t2, zero
                  ori          a3, t5, 1088
                  remu         t6, s2, s5
                  xor          a6, s1, sp
                  c.lui        a4, 9
                  ori          a3, t5, 1088
                  divu         s11, a1, gp
                  nop
                  c.nop
                  c.addi4spn   a3, sp, 400
                  slti         s3, s5, -238
                  xori         s9, a6, -2048
                  mulhsu       a5, a0, s10
                  mul          s0, t0, a0
                  div          sp, s2, s5
                  sub          sp, a4, a4
                  mulhsu       a5, a0, s10
                  c.xor        a3, a0
                  c.lui        a4, 9
                  c.nop
                  sub          sp, a4, a4
                  mul          s0, t0, a0
                  c.or         s1, a0
                  c.add        s4, a4
                  nop
                  nop
                  c.or         s1, a0
                  xor          a6, s1, sp
                  c.or         s1, a0
                  c.lui        a4, 9
                  add          tp, a2, s8
                  c.addi16sp   sp, 464
                  c.add        s4, a4
                  sltu         s1, s6, s7
                  sltiu        a4, t2, -709
                  c.and        a2, a3
                  c.nop
                  c.and        a2, a3
                  c.sub        a0, a5
                  rem          s3, a2, a3
                  c.and        a2, a3
                  auipc        t6, 95018
                  c.or         s1, a0
                  c.srai       a0, 24
                  slt          s3, a4, s5
                  xori         s9, a6, -2048
                  ori          a3, t5, 1088
                  c.or         s1, a0
                  c.li         ra, 9
                  and          s9, s5, a4
                  slti         s3, s5, -238
                  c.mv         a3, s10
                  xor          a6, s1, sp
                  c.andi       a5, 29
                  slli         gp, s11, 27
                  or           a5, a1, t6
                  nop
                  remu         t6, s2, s5
                  nop
                  addi         a5, a6, 639
                  sltu         s1, s6, s7
                  sra          s2, t6, s1
                  sub          sp, a4, a4
                  mulhsu       a5, a0, s10
                  mulhu        a0, t2, zero
                  srai         s0, s4, 6
                  c.andi       a5, 29
                  nop
                  c.addi16sp   sp, 464
                  addi         a5, a6, 639
                  nop
                  srl          a4, ra, s8
                  c.li         ra, 9
                  c.srai       a0, 24
                  c.nop
                  c.lui        a4, 9
                  c.sub        a0, a5
                  and          s9, s5, a4
                  mulh         s4, s7, t5
                  divu         s11, a1, gp
                  c.or         s1, a0
                  andi         t0, a0, -564
                  div          sp, s2, s5
                  div          sp, s2, s5
                  mul          s0, t0, a0
                  or           a5, a1, t6
                  sra          s2, t6, s1
                  c.li         ra, 9
                  mul          s0, t0, a0
                  srl          a4, ra, s8
                  c.nop
                  auipc        t6, 95018
                  c.or         s1, a0
                  xori         s9, a6, -2048
                  and          s9, s5, a4
                  srl          a4, ra, s8
                  ori          a3, t5, 1088
                  nop
                  slti         s3, s5, -238
                  c.addi4spn   a3, sp, 400
                  srai         s0, s4, 6
                  mulh         s4, s7, t5
                  srli         zero, ra, 0
                  c.add        s4, a4
                  c.xor        a3, a0
                  andi         t0, a0, -564
                  sll          a1, s6, s9
                  xori         s9, a6, -2048
                  divu         s11, a1, gp
                  auipc        t6, 95018
                  and          s9, s5, a4
                  sra          s2, t6, s1
                  c.andi       a5, 29
                  mulh         s4, s7, t5
                  srli         zero, ra, 0
                  c.nop
                  mulh         s4, s7, t5
                  c.nop
                  sll          a1, s6, s9
                  c.li         ra, 9
                  slt          s3, a4, s5
                  nop
                  c.andi       a5, 29
                  rem          s3, a2, a3
                  mul          s0, t0, a0
                  sub          sp, a4, a4
                  divu         s11, a1, gp
                  mulh         s4, s7, t5
                  mulhsu       a5, a0, s10
                  auipc        t6, 95018
                  c.addi4spn   a3, sp, 400
                  mulhsu       a5, a0, s10
                  srai         s0, s4, 6
                  c.addi       s1, -1
                  c.lui        a4, 9
                  ori          a3, t5, 1088
                  c.xor        a3, a0
                  c.slli       s5, 8
                  or           a5, a1, t6
                  andi         t0, a0, -564
                  mul          s0, t0, a0
                  divu         s11, a1, gp
                  c.and        a2, a3
                  c.srli       a4, 11
                  remu         t6, s2, s5
                  auipc        t6, 95018
                  remu         t6, s2, s5
                  srai         s0, s4, 6
                  c.addi       s1, -1
                  addi         a5, a6, 639
                  sra          s2, t6, s1
                  slti         s3, s5, -238
                  addi         a5, a6, 639
                  c.addi       s1, -1
                  addi         a5, a6, 639
                  c.addi16sp   sp, 464
                  c.xor        a3, a0
                  mulh         s4, s7, t5
                  xor          a6, s1, sp
                  mul          s0, t0, a0
                  sra          s2, t6, s1
                  mulhsu       a5, a0, s10
                  mulhu        a0, t2, zero
                  c.addi       s1, -1
                  c.addi16sp   sp, 464
                  c.xor        a3, a0
                  lui          a2, 494335
                  add          tp, a2, s8
                  c.srai       a0, 24
                  rem          s3, a2, a3
                  srli         zero, ra, 0
                  c.or         s1, a0
                  srai         s0, s4, 6
                  slli         gp, s11, 27
                  sub          sp, a4, a4
                  divu         s11, a1, gp
                  c.mv         a3, s10
                  add          tp, a2, s8
                  c.sub        a0, a5
                  sltu         s1, s6, s7
                  srai         s0, s4, 6
                  c.addi4spn   a3, sp, 400
                  andi         t0, a0, -564
                  c.addi4spn   a3, sp, 400
                  slli         gp, s11, 27
                  srl          a4, ra, s8
                  srai         s0, s4, 6
                  c.xor        a3, a0
                  c.mv         a3, s10
                  c.addi16sp   sp, 464
                  divu         s11, a1, gp
                  ori          a3, t5, 1088
                  nop
                  mulhu        a0, t2, zero
                  srai         s0, s4, 6
                  c.or         s1, a0
                  addi         a5, a6, 639
                  mulhsu       a5, a0, s10
                  c.sub        a0, a5
                  div          sp, s2, s5
                  srai         s0, s4, 6
                  nop
                  c.slli       s5, 8
                  c.or         s1, a0
                  c.addi       s1, -1
                  remu         t6, s2, s5
                  xor          a6, s1, sp
                  c.xor        a3, a0
                  c.or         s1, a0
                  c.mv         a3, s10
                  lui          a2, 494335
                  slti         s3, s5, -238
                  mul          s0, t0, a0
                  add          tp, a2, s8
                  addi         a5, a6, 639
                  sub          sp, a4, a4
                  sra          s2, t6, s1
                  rem          s3, a2, a3
                  mulhsu       a5, a0, s10
                  c.addi       s1, -1
                  xori         s9, a6, -2048
                  c.lui        a4, 9
                  c.li         ra, 9
                  c.addi4spn   a3, sp, 400
                  c.li         ra, 9
                  c.addi       s1, -1
                  slti         s3, s5, -238
                  mul          s0, t0, a0
                  xor          a6, s1, sp
                  mulhsu       a5, a0, s10
                  c.sub        a0, a5
                  slli         gp, s11, 27
                  rem          s3, a2, a3
                  c.lui        a4, 9
                  divu         s11, a1, gp
                  c.sub        a0, a5
                  sll          a1, s6, s9
                  srl          a4, ra, s8
                  c.add        s4, a4
                  rem          s3, a2, a3
                  srl          a4, ra, s8
                  c.addi16sp   sp, 464
                  sll          a1, s6, s9
                  c.or         s1, a0
                  nop
                  divu         s11, a1, gp
                  c.addi16sp   sp, 464
                  c.slli       s5, 8
                  sub          sp, a4, a4
                  addi         a5, a6, 639
                  mulhu        a0, t2, zero
                  c.srai       a0, 24
                  xori         s9, a6, -2048
                  c.and        a2, a3
                  sltiu        a4, t2, -709
                  xori         s9, a6, -2048
                  c.xor        a3, a0
                  c.sub        a0, a5
                  xor          a6, s1, sp
                  c.and        a2, a3
                  nop
                  srl          a4, ra, s8
                  sltu         s1, s6, s7
                  addi         a5, a6, 639
                  c.add        s4, a4
                  c.add        s4, a4
                  c.or         s1, a0
                  c.li         ra, 9
                  mulh         s4, s7, t5
                  auipc        t6, 95018
                  slt          s3, a4, s5
                  div          sp, s2, s5
                  c.sub        a0, a5
                  slt          s3, a4, s5
                  sltu         s1, s6, s7
                  lui          a2, 494335
                  slti         s3, s5, -238
                  lui          a2, 494335
                  srai         s0, s4, 6
                  srai         s0, s4, 6
                  c.li         ra, 9
                  c.or         s1, a0
                  c.andi       a5, 29
                  c.xor        a3, a0
                  c.sub        a0, a5
                  c.li         ra, 9
                  c.sub        a0, a5
                  or           a5, a1, t6
                  sltu         s1, s6, s7
                  xori         s9, a6, -2048
                  lui          a2, 494335
                  mulh         s4, s7, t5
                  rem          s3, a2, a3
                  lui          a2, 494335
                  srli         zero, ra, 0
                  nop
                  sub          sp, a4, a4
                  add          tp, a2, s8
                  c.nop
                  mulhsu       a5, a0, s10
                  sub          sp, a4, a4
                  c.addi       s1, -1
                  c.srai       a0, 24
                  divu         s11, a1, gp
                  c.andi       a5, 29
                  addi         a5, a6, 639
                  srl          a4, ra, s8
                  sll          a1, s6, s9
                  c.srli       a4, 11
                  srl          a4, ra, s8
                  ori          a3, t5, 1088
                  rem          s3, a2, a3
                  auipc        t6, 95018
                  c.lui        a4, 9
                  sll          a1, s6, s9
                  mulh         s4, s7, t5
                  mul          s0, t0, a0
                  slt          s3, a4, s5
                  c.and        a2, a3
                  c.mv         a3, s10
                  remu         t6, s2, s5
                  c.and        a2, a3
                  c.srai       a0, 24
                  c.or         s1, a0
                  slti         s3, s5, -238
                  c.slli       s5, 8
                  rem          s3, a2, a3
                  or           a5, a1, t6
                  rem          s3, a2, a3
                  or           a5, a1, t6
                  mulhu        a0, t2, zero
                  c.sub        a0, a5
                  c.addi4spn   a3, sp, 400
                  c.li         ra, 9
                  remu         t6, s2, s5
                  mulhsu       a5, a0, s10
                  sltiu        a4, t2, -709
                  xor          a6, s1, sp
                  srli         zero, ra, 0
                  srl          a4, ra, s8
                  mulh         s4, s7, t5
                  c.srai       a0, 24
                  c.li         ra, 9
                  c.and        a2, a3
                  mul          s0, t0, a0
                  c.li         ra, 9
                  c.addi16sp   sp, 464
                  remu         t6, s2, s5
                  ori          a3, t5, 1088
                  sll          a1, s6, s9
                  sltiu        a4, t2, -709
                  mulh         s4, s7, t5
                  sub          sp, a4, a4
                  auipc        t6, 95018
                  addi         a5, a6, 639
                  c.li         ra, 9
                  c.sub        a0, a5
                  mul          s0, t0, a0
                  divu         s11, a1, gp
                  remu         t6, s2, s5
                  c.add        s4, a4
                  slti         s3, s5, -238
                  remu         t6, s2, s5
                  lui          a2, 494335
                  c.lui        a4, 9
                  c.lui        a4, 9
                  c.and        a2, a3
                  c.lui        a4, 9
                  nop
                  lui          a2, 494335
                  c.add        s4, a4
                  andi         t0, a0, -564
                  or           a5, a1, t6
                  mulh         s4, s7, t5
                  srai         s0, s4, 6
                  c.and        a2, a3
                  sll          a1, s6, s9
                  auipc        t6, 95018
                  c.nop
                  sltiu        a4, t2, -709
                  c.add        s4, a4
                  lui          a2, 494335
                  remu         t6, s2, s5
                  sra          s2, t6, s1
                  addi         a5, a6, 639
                  addi         a5, a6, 639
                  ori          a3, t5, 1088
                  srli         zero, ra, 0
                  sltiu        a4, t2, -709
                  c.andi       a5, 29
                  remu         t6, s2, s5
                  mulh         s4, s7, t5
                  c.andi       a5, 29
                  nop
                  c.sub        a0, a5
                  remu         t6, s2, s5
                  c.mv         a3, s10
                  srl          a4, ra, s8
                  c.srli       a4, 11
                  sra          s2, t6, s1
                  slti         s3, s5, -238
                  mulhu        a0, t2, zero
                  mulhu        a0, t2, zero
                  nop
                  c.mv         a3, s10
                  c.srli       a4, 11
                  c.slli       s5, 8
                  sll          a1, s6, s9
                  remu         t6, s2, s5
                  nop
                  div          sp, s2, s5
                  c.or         s1, a0
                  c.and        a2, a3
                  xori         s9, a6, -2048
                  xor          a6, s1, sp
                  and          s9, s5, a4
                  sltiu        a4, t2, -709
                  mulh         s4, s7, t5
                  c.andi       a5, 29
                  c.addi4spn   a3, sp, 400
                  add          tp, a2, s8
                  c.slli       s5, 8
                  mulhu        a0, t2, zero
                  or           a5, a1, t6
                  slti         s3, s5, -238
                  mul          s0, t0, a0
                  slt          s3, a4, s5
                  xor          a6, s1, sp
                  c.srli       a4, 11
                  xor          a6, s1, sp
                  srai         s0, s4, 6
                  c.andi       a5, 29
                  or           a5, a1, t6
                  mul          s0, t0, a0
                  mulh         s4, s7, t5
                  xor          a6, s1, sp
                  slt          s3, a4, s5
                  c.li         ra, 9
                  c.add        s4, a4
                  remu         t6, s2, s5
                  sll          a1, s6, s9
                  srli         zero, ra, 0
                  div          sp, s2, s5
                  lui          a2, 494335
                  c.srai       a0, 24
                  or           a5, a1, t6
                  sra          s2, t6, s1
                  c.lui        a4, 9
                  auipc        t6, 95018
                  c.mv         a3, s10
                  srl          a4, ra, s8
                  c.srli       a4, 11
                  mulh         s4, s7, t5
                  mulhu        a0, t2, zero
                  mulhsu       a5, a0, s10
                  slli         gp, s11, 27
                  c.sub        a0, a5
                  slli         gp, s11, 27
                  auipc        t6, 95018
                  mulh         s4, s7, t5
                  c.or         s1, a0
                  div          sp, s2, s5
                  slt          s3, a4, s5
                  c.srli       a4, 11
                  andi         t0, a0, -564
                  sltiu        a4, t2, -709
                  c.addi16sp   sp, 464
                  srai         s0, s4, 6
                  srl          a4, ra, s8
                  sll          a1, s6, s9
                  c.xor        a3, a0
                  slti         s3, s5, -238
                  remu         t6, s2, s5
                  c.add        s4, a4
                  sltu         s1, s6, s7
                  c.addi       s1, -1
                  sub          sp, a4, a4
                  slli         gp, s11, 27
                  add          tp, a2, s8
                  slli         gp, s11, 27
                  div          sp, s2, s5
                  srl          a4, ra, s8
                  c.srai       a0, 24
                  lui          a2, 494335
                  c.addi16sp   sp, 464
                  divu         s11, a1, gp
                  slt          s3, a4, s5
                  c.srli       a4, 11
                  and          s9, s5, a4
                  c.addi       s1, -1
                  c.addi       s1, -1
                  sra          s2, t6, s1
                  sub          sp, a4, a4
                  div          sp, s2, s5
                  c.lui        a4, 9
                  lui          a2, 494335
                  and          s9, s5, a4
                  c.nop
                  remu         t6, s2, s5
                  c.addi4spn   a3, sp, 400
                  srli         zero, ra, 0
                  c.and        a2, a3
                  c.or         s1, a0
                  c.slli       s5, 8
                  and          s9, s5, a4
                  c.or         s1, a0
                  slli         gp, s11, 27
                  c.slli       s5, 8
                  slt          s3, a4, s5
                  divu         s11, a1, gp
                  div          sp, s2, s5
                  c.srli       a4, 11
                  remu         t6, s2, s5
                  nop
                  sub          sp, a4, a4
                  or           a5, a1, t6
                  c.addi4spn   a3, sp, 400
                  nop
                  slli         gp, s11, 27
                  mulh         s4, s7, t5
                  slti         s3, s5, -238
                  slli         gp, s11, 27
                  div          sp, s2, s5
                  srl          a4, ra, s8
                  mulh         s4, s7, t5
                  mulhsu       a5, a0, s10
                  divu         s11, a1, gp
                  srl          a4, ra, s8
                  c.or         s1, a0
                  add          tp, a2, s8
                  srl          a4, ra, s8
                  c.andi       a5, 29
                  sll          a1, s6, s9
                  mulhsu       a5, a0, s10
                  addi         a5, a6, 639
                  divu         s11, a1, gp
                  c.andi       a5, 29
                  c.andi       a5, 29
                  c.xor        a3, a0
                  c.nop
                  srai         s0, s4, 6
                  remu         t6, s2, s5
                  addi         a5, a6, 639
                  lui          a2, 494335
                  c.srai       a0, 24
                  nop
                  c.srli       a4, 11
                  c.addi4spn   a3, sp, 400
                  mulhsu       a5, a0, s10
                  c.nop
                  xori         s9, a6, -2048
                  addi         a5, a6, 639
                  rem          s3, a2, a3
                  andi         t0, a0, -564
                  rem          s3, a2, a3
                  xor          a6, s1, sp
                  c.add        s4, a4
                  srl          a4, ra, s8
                  andi         t0, a0, -564
                  c.srli       a4, 11
                  c.slli       s5, 8
                  c.srli       a4, 11
                  mulhu        a0, t2, zero
                  c.li         ra, 9
                  c.and        a2, a3
                  div          sp, s2, s5
                  c.xor        a3, a0
                  c.srli       a4, 11
                  add          tp, a2, s8
                  c.addi4spn   a3, sp, 400
                  xor          a6, s1, sp
                  xor          a6, s1, sp
                  andi         t0, a0, -564
                  c.slli       s5, 8
                  andi         t0, a0, -564
                  sub          sp, a4, a4
                  c.nop
                  mulhsu       a5, a0, s10
                  mulh         s4, s7, t5
                  sltu         s1, s6, s7
                  c.srai       a0, 24
                  mulhu        a0, t2, zero
                  div          sp, s2, s5
                  srai         s0, s4, 6
                  lui          a2, 494335
                  sltiu        a4, t2, -709
                  ori          a3, t5, 1088
                  c.mv         a3, s10
                  c.li         ra, 9
                  remu         t6, s2, s5
                  c.and        a2, a3
                  c.addi4spn   a3, sp, 400
                  mulhu        a0, t2, zero
                  c.sub        a0, a5
                  slt          s3, a4, s5
                  slli         gp, s11, 27
                  c.sub        a0, a5
                  remu         t6, s2, s5
                  c.srli       a4, 11
                  c.srai       a0, 24
                  c.nop
                  xori         s9, a6, -2048
                  c.sub        a0, a5
                  xori         s9, a6, -2048
                  and          s9, s5, a4
                  sltu         s1, s6, s7
                  auipc        t6, 95018
                  srl          a4, ra, s8
                  c.and        a2, a3
                  c.srai       a0, 24
                  lui          a2, 494335
                  auipc        t6, 95018
                  div          sp, s2, s5
                  mulhsu       a5, a0, s10
                  c.mv         a3, s10
                  c.xor        a3, a0
                  sub          sp, a4, a4
                  rem          s3, a2, a3
                  c.or         s1, a0
                  or           a5, a1, t6
                  ori          a3, t5, 1088
                  slli         gp, s11, 27
                  c.andi       a5, 29
                  c.lui        a4, 9
                  srli         zero, ra, 0
                  c.add        s4, a4
                  c.slli       s5, 8
                  sll          a1, s6, s9
                  xor          a6, s1, sp
                  srli         zero, ra, 0
                  c.mv         a3, s10
                  slt          s3, a4, s5
                  c.and        a2, a3
                  slti         s3, s5, -238
                  addi         a5, a6, 639
                  c.srli       a4, 11
                  sltu         s1, s6, s7
                  c.addi       s1, -1
                  sra          s2, t6, s1
                  sub          sp, a4, a4
                  ori          a3, t5, 1088
                  slti         s3, s5, -238
                  c.li         ra, 9
                  mul          s0, t0, a0
                  c.lui        a4, 9
                  and          s9, s5, a4
                  sltiu        a4, t2, -709
                  srl          a4, ra, s8
                  addi         a5, a6, 639
                  mul          s0, t0, a0
                  c.srli       a4, 11
                  c.and        a2, a3
                  slli         gp, s11, 27
                  slti         s3, s5, -238
                  c.lui        a4, 9
                  xori         s9, a6, -2048
                  sub          sp, a4, a4
                  c.lui        a4, 9
                  sra          s2, t6, s1
                  auipc        t6, 95018
                  slti         s3, s5, -238
                  rem          s3, a2, a3
                  c.addi4spn   a3, sp, 400
                  auipc        t6, 95018
                  c.lui        a4, 9
                  remu         t6, s2, s5
                  lui          a2, 494335
                  addi         a5, a6, 639
                  sltu         s1, s6, s7
                  auipc        t6, 95018
                  auipc        t6, 95018
                  c.andi       a5, 29
                  sra          s2, t6, s1
                  addi         a5, a6, 639
                  sra          s2, t6, s1
                  sll          a1, s6, s9
                  c.sub        a0, a5
                  slti         s3, s5, -238
                  c.andi       a5, 29
                  div          sp, s2, s5
                  sll          a1, s6, s9
                  add          tp, a2, s8
                  mulhsu       a5, a0, s10
                  srli         zero, ra, 0
                  c.addi16sp   sp, 464
                  addi         a5, a6, 639
                  andi         t0, a0, -564
                  c.srli       a4, 11
                  xor          a6, s1, sp
                  c.or         s1, a0
                  c.or         s1, a0
                  or           a5, a1, t6
                  slti         s3, s5, -238
                  c.addi4spn   a3, sp, 400
                  divu         s11, a1, gp
                  nop
                  mulh         s4, s7, t5
                  c.andi       a5, 29
                  c.srai       a0, 24
                  c.mv         a3, s10
                  remu         t6, s2, s5
                  c.xor        a3, a0
                  c.li         ra, 9
                  slli         gp, s11, 27
                  c.addi16sp   sp, 464
                  and          s9, s5, a4
                  nop
                  slti         s3, s5, -238
                  xori         s9, a6, -2048
                  mul          s0, t0, a0
                  srl          a4, ra, s8
                  mul          s0, t0, a0
                  add          tp, a2, s8
                  sub          sp, a4, a4
                  and          s9, s5, a4
                  sltiu        a4, t2, -709
                  slt          s3, a4, s5
                  mulh         s4, s7, t5
                  xori         s9, a6, -2048
                  c.andi       a5, 29
                  and          s9, s5, a4
                  c.and        a2, a3
                  li           a7, 0xdfe5d5f3 #start riscv_int_numeric_corner_stream_8
                  li           a5, 0x80000000
                  li           s2, 0x0
                  li           a0, 0x80000000
                  li           t0, 0xffffffff
                  li           s8, 0x80000000
                  li           s4, 0xffffffff
                  li           a3, 0x80000000
                  li           a6, 0x80000000
                  li           s10, 0x80000000
                  rem          a5, a7, a5
                  rem          a5, a7, a5
                  mulhsu       a5, a6, a0
                  mul          s8, a7, a7
                  sub          a3, a0, t0
                  div          a3, a3, a7
                  lui          a3, 494335
                  div          a3, a3, a7
                  add          a6, s4, s8
                  nop
                  add          a6, s4, s8
                  lui          a3, 494335
                  mulh         a6, s4, s8
                  divu         s10, a6, a5
                  divu         s10, a6, a5
                  divu         s10, a6, a5
                  lui          a3, 494335
                  div          a3, a3, a7
                  nop
                  mulhu        t0, s4, t0
                  nop
                  div          a3, a3, a7
                  lui          a3, 494335
                  mulhu        t0, s4, t0
                  div          a3, a3, a7
                  sub          a3, a0, t0 #end riscv_int_numeric_corner_stream_8
                  c.srai       a0, 24
                  srl          a4, ra, s8
                  rem          s3, a2, a3
                  sll          a1, s6, s9
                  srli         zero, ra, 0
                  c.xor        a3, a0
                  rem          s3, a2, a3
                  add          tp, a2, s8
                  add          tp, a2, s8
                  and          s9, s5, a4
                  c.andi       a5, 29
                  addi         a5, a6, 639
                  c.li         ra, 9
                  ori          a3, t5, 1088
                  c.lui        a4, 9
                  c.sub        a0, a5
                  divu         s11, a1, gp
                  c.slli       s5, 8
                  sltiu        a4, t2, -709
                  remu         t6, s2, s5
                  sltiu        a4, t2, -709
                  sra          s2, t6, s1
                  c.add        s4, a4
                  slti         s3, s5, -238
                  slt          s3, a4, s5
                  xori         s9, a6, -2048
                  c.nop
                  c.or         s1, a0
                  rem          s3, a2, a3
                  mulh         s4, s7, t5
                  sltiu        a4, t2, -709
                  mulh         s4, s7, t5
                  sltiu        a4, t2, -709
                  rem          s3, a2, a3
                  c.mv         a3, s10
                  c.srli       a4, 11
                  sub          sp, a4, a4
                  c.add        s4, a4
                  div          sp, s2, s5
                  c.li         ra, 9
                  slt          s3, a4, s5
                  c.sub        a0, a5
                  c.nop
                  or           a5, a1, t6
                  c.xor        a3, a0
                  or           a5, a1, t6
                  c.slli       s5, 8
                  c.addi4spn   a3, sp, 400
                  c.xor        a3, a0
                  c.lui        a4, 9
                  c.addi16sp   sp, 464
                  c.or         s1, a0
                  slti         s3, s5, -238
                  c.xor        a3, a0
                  sltiu        a4, t2, -709
                  sub          sp, a4, a4
                  sra          s2, t6, s1
                  ori          a3, t5, 1088
                  ori          a3, t5, 1088
                  c.nop
                  slti         s3, s5, -238
                  divu         s11, a1, gp
                  mulhsu       a5, a0, s10
                  div          sp, s2, s5
                  rem          s3, a2, a3
                  c.xor        a3, a0
                  divu         s11, a1, gp
                  c.addi4spn   a3, sp, 400
                  rem          s3, a2, a3
                  c.srli       a4, 11
                  andi         t0, a0, -564
                  lui          a2, 494335
                  srl          a4, ra, s8
                  and          s9, s5, a4
                  mulhsu       a5, a0, s10
                  c.and        a2, a3
                  c.nop
                  c.srai       a0, 24
                  slt          s3, a4, s5
                  sub          sp, a4, a4
                  divu         s11, a1, gp
                  nop
                  addi         a5, a6, 639
                  or           a5, a1, t6
                  sll          a1, s6, s9
                  mul          s0, t0, a0
                  sltiu        a4, t2, -709
                  c.srli       a4, 11
                  slli         gp, s11, 27
                  c.add        s4, a4
                  sltiu        a4, t2, -709
                  c.srli       a4, 11
                  and          s9, s5, a4
                  c.xor        a3, a0
                  c.and        a2, a3
                  or           a5, a1, t6
                  slt          s3, a4, s5
                  mulh         s4, s7, t5
                  srl          a4, ra, s8
                  srli         zero, ra, 0
                  mulhsu       a5, a0, s10
                  c.addi4spn   a3, sp, 400
                  andi         t0, a0, -564
                  c.addi4spn   a3, sp, 400
                  c.andi       a5, 29
                  or           a5, a1, t6
                  rem          s3, a2, a3
                  slt          s3, a4, s5
                  c.andi       a5, 29
                  c.addi       s1, -1
                  c.or         s1, a0
                  slli         gp, s11, 27
                  sltiu        a4, t2, -709
                  slt          s3, a4, s5
                  andi         t0, a0, -564
                  c.add        s4, a4
                  or           a5, a1, t6
                  sub          sp, a4, a4
                  xor          a6, s1, sp
                  sltu         s1, s6, s7
                  c.xor        a3, a0
                  auipc        t6, 95018
                  c.nop
                  or           a5, a1, t6
                  c.addi       s1, -1
                  rem          s3, a2, a3
                  c.mv         a3, s10
                  c.addi16sp   sp, 464
                  add          tp, a2, s8
                  c.addi16sp   sp, 464
                  sub          sp, a4, a4
                  c.nop
                  c.slli       s5, 8
                  sltiu        a4, t2, -709
                  srai         s0, s4, 6
                  sltu         s1, s6, s7
                  divu         s11, a1, gp
                  c.lui        a4, 9
                  or           a5, a1, t6
                  c.andi       a5, 29
                  c.li         ra, 9
                  srli         zero, ra, 0
                  mulh         s4, s7, t5
                  sll          a1, s6, s9
                  c.srli       a4, 11
                  c.srai       a0, 24
                  rem          s3, a2, a3
                  srl          a4, ra, s8
                  c.or         s1, a0
                  c.srai       a0, 24
                  slti         s3, s5, -238
                  add          tp, a2, s8
                  nop
                  and          s9, s5, a4
                  slli         gp, s11, 27
                  c.and        a2, a3
                  xor          a6, s1, sp
                  mulhsu       a5, a0, s10
                  sltiu        a4, t2, -709
                  slt          s3, a4, s5
                  c.and        a2, a3
                  srli         zero, ra, 0
                  mulh         s4, s7, t5
                  div          sp, s2, s5
                  addi         a5, a6, 639
                  c.addi       s1, -1
                  c.li         ra, 9
                  slt          s3, a4, s5
                  c.addi16sp   sp, 464
                  rem          s3, a2, a3
                  slt          s3, a4, s5
                  c.addi4spn   a3, sp, 400
                  c.li         ra, 9
                  divu         s11, a1, gp
                  rem          s3, a2, a3
                  and          s9, s5, a4
                  rem          s3, a2, a3
                  srl          a4, ra, s8
                  divu         s11, a1, gp
                  auipc        t6, 95018
                  c.nop
                  c.addi4spn   a3, sp, 400
                  xori         s9, a6, -2048
                  ori          a3, t5, 1088
                  sltu         s1, s6, s7
                  divu         s11, a1, gp
                  c.mv         a3, s10
                  xor          a6, s1, sp
                  div          sp, s2, s5
                  slti         s3, s5, -238
                  c.and        a2, a3
                  or           a5, a1, t6
                  c.sub        a0, a5
                  and          s9, s5, a4
                  mulh         s4, s7, t5
                  c.and        a2, a3
                  sra          s2, t6, s1
                  rem          s3, a2, a3
                  mulhsu       a5, a0, s10
                  remu         t6, s2, s5
                  mulhsu       a5, a0, s10
                  c.nop
                  c.andi       a5, 29
                  c.slli       s5, 8
                  c.or         s1, a0
                  and          s9, s5, a4
                  add          tp, a2, s8
                  c.li         ra, 9
                  slti         s3, s5, -238
                  rem          s3, a2, a3
                  lui          a2, 494335
                  c.addi       s1, -1
                  sll          a1, s6, s9
                  sub          sp, a4, a4
                  mul          s0, t0, a0
                  and          s9, s5, a4
                  c.sub        a0, a5
                  srli         zero, ra, 0
                  c.xor        a3, a0
                  c.lui        a4, 9
                  sltiu        a4, t2, -709
                  xori         s9, a6, -2048
                  srai         s0, s4, 6
                  srai         s0, s4, 6
                  rem          s3, a2, a3
                  mul          s0, t0, a0
                  c.srli       a4, 11
                  c.addi4spn   a3, sp, 400
                  c.nop
                  rem          s3, a2, a3
                  mulhsu       a5, a0, s10
                  c.add        s4, a4
                  c.mv         a3, s10
                  xori         s9, a6, -2048
                  mul          s0, t0, a0
                  sra          s2, t6, s1
                  add          tp, a2, s8
                  divu         s11, a1, gp
                  mulh         s4, s7, t5
                  c.xor        a3, a0
                  sra          s2, t6, s1
                  sll          a1, s6, s9
                  mulh         s4, s7, t5
                  sra          s2, t6, s1
                  sll          a1, s6, s9
                  c.addi16sp   sp, 464
                  and          s9, s5, a4
                  c.or         s1, a0
                  c.add        s4, a4
                  remu         t6, s2, s5
                  sub          sp, a4, a4
                  c.addi16sp   sp, 464
                  slti         s3, s5, -238
                  c.nop
                  ori          a3, t5, 1088
                  c.addi16sp   sp, 464
                  mulhsu       a5, a0, s10
                  andi         t0, a0, -564
                  c.li         ra, 9
                  lui          a2, 494335
                  srai         s0, s4, 6
                  mulh         s4, s7, t5
                  mulhsu       a5, a0, s10
                  mulhsu       a5, a0, s10
                  lui          a2, 494335
                  lui          a2, 494335
                  c.xor        a3, a0
                  c.addi16sp   sp, 464
                  auipc        t6, 95018
                  mulh         s4, s7, t5
                  nop
                  c.lui        a4, 9
                  add          tp, a2, s8
                  srai         s0, s4, 6
                  slti         s3, s5, -238
                  c.or         s1, a0
                  div          sp, s2, s5
                  c.sub        a0, a5
                  c.sub        a0, a5
                  mulhu        a0, t2, zero
                  c.and        a2, a3
                  ori          a3, t5, 1088
                  or           a5, a1, t6
                  slt          s3, a4, s5
                  c.srli       a4, 11
                  c.slli       s5, 8
                  mulhu        a0, t2, zero
                  sltu         s1, s6, s7
                  srai         s0, s4, 6
                  srl          a4, ra, s8
                  auipc        t6, 95018
                  c.addi       s1, -1
                  mulhsu       a5, a0, s10
                  mulh         s4, s7, t5
                  sltu         s1, s6, s7
                  or           a5, a1, t6
                  sltu         s1, s6, s7
                  c.addi       s1, -1
                  srli         zero, ra, 0
                  mulhu        a0, t2, zero
                  c.sub        a0, a5
                  mulh         s4, s7, t5
                  c.sub        a0, a5
                  div          sp, s2, s5
                  c.srli       a4, 11
                  c.lui        a4, 9
                  add          tp, a2, s8
                  c.addi4spn   a3, sp, 400
                  nop
                  sra          s2, t6, s1
                  xor          a6, s1, sp
                  c.add        s4, a4
                  c.addi       s1, -1
                  c.nop
                  c.srli       a4, 11
                  slli         gp, s11, 27
                  divu         s11, a1, gp
                  auipc        t6, 95018
                  mulhsu       a5, a0, s10
                  ori          a3, t5, 1088
                  or           a5, a1, t6
                  and          s9, s5, a4
                  and          s9, s5, a4
                  c.li         ra, 9
                  slli         gp, s11, 27
                  c.nop
                  rem          s3, a2, a3
                  c.add        s4, a4
                  c.lui        a4, 9
                  sltiu        a4, t2, -709
                  slli         gp, s11, 27
                  mulhu        a0, t2, zero
                  c.slli       s5, 8
                  add          tp, a2, s8
                  slli         gp, s11, 27
                  c.addi4spn   a3, sp, 400
                  c.andi       a5, 29
                  nop
                  slt          s3, a4, s5
                  xori         s9, a6, -2048
                  slli         gp, s11, 27
                  c.sub        a0, a5
                  slli         gp, s11, 27
                  slt          s3, a4, s5
                  or           a5, a1, t6
                  lui          a2, 494335
                  addi         a5, a6, 639
                  slti         s3, s5, -238
                  rem          s3, a2, a3
                  c.slli       s5, 8
                  c.nop
                  c.slli       s5, 8
                  c.and        a2, a3
                  xor          a6, s1, sp
                  sltu         s1, s6, s7
                  sltu         s1, s6, s7
                  remu         t6, s2, s5
                  mul          s0, t0, a0
                  nop
                  mulhsu       a5, a0, s10
                  sll          a1, s6, s9
                  c.addi       s1, -1
                  sra          s2, t6, s1
                  sub          sp, a4, a4
                  c.slli       s5, 8
                  andi         t0, a0, -564
                  mulh         s4, s7, t5
                  remu         t6, s2, s5
                  mulhu        a0, t2, zero
                  c.lui        a4, 9
                  slt          s3, a4, s5
                  add          tp, a2, s8
                  sra          s2, t6, s1
                  srli         zero, ra, 0
                  mulhsu       a5, a0, s10
                  remu         t6, s2, s5
                  mulhu        a0, t2, zero
                  c.sub        a0, a5
                  div          sp, s2, s5
                  c.li         ra, 9
                  add          tp, a2, s8
                  slli         gp, s11, 27
                  sltu         s1, s6, s7
                  srl          a4, ra, s8
                  sll          a1, s6, s9
                  srai         s0, s4, 6
                  ori          a3, t5, 1088
                  c.nop
                  rem          s3, a2, a3
                  div          sp, s2, s5
                  c.srli       a4, 11
                  c.srli       a4, 11
                  c.or         s1, a0
                  mul          s0, t0, a0
                  lui          a2, 494335
                  c.addi4spn   a3, sp, 400
                  c.or         s1, a0
                  ori          a3, t5, 1088
                  addi         a5, a6, 639
                  c.srai       a0, 24
                  c.addi       s1, -1
                  xori         s9, a6, -2048
                  and          s9, s5, a4
                  mulhu        a0, t2, zero
                  sra          s2, t6, s1
                  c.lui        a4, 9
                  c.addi16sp   sp, 464
                  ori          a3, t5, 1088
                  mulh         s4, s7, t5
                  ori          a3, t5, 1088
                  sltu         s1, s6, s7
                  addi         a5, a6, 639
                  slli         gp, s11, 27
                  srli         zero, ra, 0
                  xori         s9, a6, -2048
                  c.srai       a0, 24
                  lui          a2, 494335
                  c.addi       s1, -1
                  mulh         s4, s7, t5
                  c.and        a2, a3
                  sltu         s1, s6, s7
                  sub          sp, a4, a4
                  rem          s3, a2, a3
                  mul          s0, t0, a0
                  c.andi       a5, 29
                  sltu         s1, s6, s7
                  xor          a6, s1, sp
                  mul          s0, t0, a0
                  sub          sp, a4, a4
                  slti         s3, s5, -238
                  c.nop
                  mulh         s4, s7, t5
                  c.add        s4, a4
                  mulhu        a0, t2, zero
                  ori          a3, t5, 1088
                  auipc        t6, 95018
                  c.slli       s5, 8
                  rem          s3, a2, a3
                  sra          s2, t6, s1
                  c.and        a2, a3
                  sra          s2, t6, s1
                  and          s9, s5, a4
                  c.andi       a5, 29
                  c.lui        a4, 9
                  auipc        t6, 95018
                  slt          s3, a4, s5
                  mulhsu       a5, a0, s10
                  srli         zero, ra, 0
                  c.slli       s5, 8
                  slli         gp, s11, 27
                  slti         s3, s5, -238
                  c.lui        a4, 9
                  c.slli       s5, 8
                  c.sub        a0, a5
                  rem          s3, a2, a3
                  c.and        a2, a3
                  auipc        t6, 95018
                  div          sp, s2, s5
                  rem          s3, a2, a3
                  mulh         s4, s7, t5
                  sub          sp, a4, a4
                  slli         gp, s11, 27
                  or           a5, a1, t6
                  srl          a4, ra, s8
                  c.li         ra, 9
                  slli         gp, s11, 27
                  c.xor        a3, a0
                  ori          a3, t5, 1088
                  ori          a3, t5, 1088
                  slti         s3, s5, -238
                  divu         s11, a1, gp
                  c.add        s4, a4
                  xor          a6, s1, sp
                  c.addi       s1, -1
                  c.sub        a0, a5
                  c.srli       a4, 11
                  or           a5, a1, t6
                  divu         s11, a1, gp
                  sltiu        a4, t2, -709
                  remu         t6, s2, s5
                  c.srli       a4, 11
                  c.addi4spn   a3, sp, 400
                  xor          a6, s1, sp
                  rem          s3, a2, a3
                  div          sp, s2, s5
                  sltu         s1, s6, s7
                  srl          a4, ra, s8
                  c.sub        a0, a5
                  mulh         s4, s7, t5
                  c.add        s4, a4
                  xor          a6, s1, sp
                  mulhu        a0, t2, zero
                  slti         s3, s5, -238
                  srl          a4, ra, s8
                  c.add        s4, a4
                  sll          a1, s6, s9
                  c.li         ra, 9
                  remu         t6, s2, s5
                  xori         s9, a6, -2048
                  c.andi       a5, 29
                  addi         a5, a6, 639
                  and          s9, s5, a4
                  sub          sp, a4, a4
                  lui          a2, 494335
                  auipc        t6, 95018
                  c.sub        a0, a5
                  mulhu        a0, t2, zero
                  slti         s3, s5, -238
                  c.andi       a5, 29
                  c.addi       s1, -1
                  mulhu        a0, t2, zero
                  mulhsu       a5, a0, s10
                  c.mv         a3, s10
                  mulhsu       a5, a0, s10
                  slti         s3, s5, -238
                  c.slli       s5, 8
                  c.xor        a3, a0
                  auipc        t6, 95018
                  rem          s3, a2, a3
                  c.srli       a4, 11
                  ori          a3, t5, 1088
                  c.xor        a3, a0
                  andi         t0, a0, -564
                  addi         a5, a6, 639
                  auipc        t6, 95018
                  divu         s11, a1, gp
                  c.addi       s1, -1
                  c.nop
                  slt          s3, a4, s5
                  sltu         s1, s6, s7
                  c.li         ra, 9
                  mulh         s4, s7, t5
                  andi         t0, a0, -564
                  mulhu        a0, t2, zero
                  c.sub        a0, a5
                  or           a5, a1, t6
                  add          tp, a2, s8
                  c.and        a2, a3
                  remu         t6, s2, s5
                  ori          a3, t5, 1088
                  c.srai       a0, 24
                  srli         zero, ra, 0
                  c.or         s1, a0
                  rem          s3, a2, a3
                  xor          a6, s1, sp
                  remu         t6, s2, s5
                  addi         a5, a6, 639
                  lui          a2, 494335
                  c.addi       s1, -1
                  xor          a6, s1, sp
                  srai         s0, s4, 6
                  c.nop
                  c.addi16sp   sp, 464
                  srli         zero, ra, 0
                  rem          s3, a2, a3
                  c.mv         a3, s10
                  and          s9, s5, a4
                  c.sub        a0, a5
                  c.or         s1, a0
                  lui          a2, 494335
                  c.sub        a0, a5
                  sra          s2, t6, s1
                  slli         gp, s11, 27
                  mul          s0, t0, a0
                  remu         t6, s2, s5
                  mulhu        a0, t2, zero
                  xor          a6, s1, sp
                  c.addi4spn   a3, sp, 400
                  slt          s3, a4, s5
                  c.addi4spn   a3, sp, 400
                  c.mv         a3, s10
                  c.srai       a0, 24
                  sub          sp, a4, a4
                  c.srai       a0, 24
                  div          sp, s2, s5
                  c.srli       a4, 11
                  c.mv         a3, s10
                  mulhu        a0, t2, zero
                  remu         t6, s2, s5
                  xor          a6, s1, sp
                  c.add        s4, a4
                  mulhsu       a5, a0, s10
                  sll          a1, s6, s9
                  div          sp, s2, s5
                  srli         zero, ra, 0
                  c.addi       s1, -1
                  mul          s0, t0, a0
                  xori         s9, a6, -2048
                  mulhu        a0, t2, zero
                  c.and        a2, a3
                  srli         zero, ra, 0
                  divu         s11, a1, gp
                  div          sp, s2, s5
                  c.add        s4, a4
                  mulh         s4, s7, t5
                  and          s9, s5, a4
                  xori         s9, a6, -2048
                  c.slli       s5, 8
                  and          s9, s5, a4
                  ori          a3, t5, 1088
                  mul          s0, t0, a0
                  mul          s0, t0, a0
                  slli         gp, s11, 27
                  and          s9, s5, a4
                  c.addi       s1, -1
                  xor          a6, s1, sp
                  srl          a4, ra, s8
                  mulhu        a0, t2, zero
                  addi         a5, a6, 639
                  ori          a3, t5, 1088
                  add          tp, a2, s8
                  c.mv         a3, s10
                  slli         gp, s11, 27
                  mulh         s4, s7, t5
                  c.lui        a4, 9
                  sra          s2, t6, s1
                  add          tp, a2, s8
                  c.slli       s5, 8
                  c.addi4spn   a3, sp, 400
                  c.lui        a4, 9
                  mulh         s4, s7, t5
                  mulh         s4, s7, t5
                  lui          a2, 494335
                  nop
                  c.addi16sp   sp, 464
                  mulhsu       a5, a0, s10
                  slli         gp, s11, 27
                  lui          a2, 494335
                  nop
                  sll          a1, s6, s9
                  c.srai       a0, 24
                  or           a5, a1, t6
                  c.xor        a3, a0
                  div          sp, s2, s5
                  c.addi16sp   sp, 464
                  c.slli       s5, 8
                  srl          a4, ra, s8
                  c.nop
                  c.srli       a4, 11
                  or           a5, a1, t6
                  c.sub        a0, a5
                  c.add        s4, a4
                  c.nop
                  li           a6, 0x80000000 #start riscv_int_numeric_corner_stream_31
                  li           a1, 0x0
                  li           t4, 0xffffffff
                  li           s4, 0x5fc56548
                  li           s0, 0x4e504c05
                  li           a2, 0x0
                  li           s11, 0x0
                  li           s8, 0xffffffff
                  li           t6, 0x0
                  li           t1, 0x80000000
                  sub          a1, s0, t1
                  mul          t4, s4, s4
                  addi         a2, t1, 639
                  div          a1, a1, s4
                  addi         a2, t1, 639
                  mulh         a6, s11, t4
                  auipc        s11, 95018
                  mul          t4, s4, s4
                  divu         t6, a6, a2
                  mulh         a6, s11, t4
                  mulhsu       a2, a6, s0
                  remu         s4, a1, s4
                  div          a1, a1, s4
                  rem          a2, s4, a2
                  lui          a1, 494335
                  sub          a1, s0, t1
                  divu         t6, a6, a2
                  sub          a1, s0, t1
                  divu         t6, a6, a2
                  mulh         a6, s11, t4 #end riscv_int_numeric_corner_stream_31
                  mul          s0, t0, a0
                  c.srai       a0, 24
                  sltu         s1, s6, s7
                  sltiu        a4, t2, -709
                  c.lui        a4, 9
                  mulhu        a0, t2, zero
                  c.addi       s1, -1
                  xor          a6, s1, sp
                  c.add        s4, a4
                  c.and        a2, a3
                  mulh         s4, s7, t5
                  c.sub        a0, a5
                  c.mv         a3, s10
                  add          tp, a2, s8
                  addi         a5, a6, 639
                  nop
                  mulhu        a0, t2, zero
                  mulhsu       a5, a0, s10
                  c.mv         a3, s10
                  srli         zero, ra, 0
                  rem          s3, a2, a3
                  c.and        a2, a3
                  nop
                  srl          a4, ra, s8
                  c.andi       a5, 29
                  c.addi16sp   sp, 464
                  mul          s0, t0, a0
                  divu         s11, a1, gp
                  c.srli       a4, 11
                  sll          a1, s6, s9
                  srl          a4, ra, s8
                  mulh         s4, s7, t5
                  lui          a2, 494335
                  srl          a4, ra, s8
                  c.lui        a4, 9
                  add          tp, a2, s8
                  remu         t6, s2, s5
                  sub          sp, a4, a4
                  srli         zero, ra, 0
                  rem          s3, a2, a3
                  c.xor        a3, a0
                  andi         t0, a0, -564
                  srli         zero, ra, 0
                  addi         a5, a6, 639
                  sub          sp, a4, a4
                  c.lui        a4, 9
                  or           a5, a1, t6
                  srli         zero, ra, 0
                  sub          sp, a4, a4
                  c.addi16sp   sp, 464
                  srai         s0, s4, 6
                  sra          s2, t6, s1
                  sltiu        a4, t2, -709
                  add          tp, a2, s8
                  srli         zero, ra, 0
                  andi         t0, a0, -564
                  div          sp, s2, s5
                  c.slli       s5, 8
                  sub          sp, a4, a4
                  c.or         s1, a0
                  xori         s9, a6, -2048
                  slti         s3, s5, -238
                  nop
                  nop
                  divu         s11, a1, gp
                  sub          sp, a4, a4
                  srai         s0, s4, 6
                  div          sp, s2, s5
                  xor          a6, s1, sp
                  and          s9, s5, a4
                  andi         t0, a0, -564
                  c.lui        a4, 9
                  c.li         ra, 9
                  andi         t0, a0, -564
                  c.lui        a4, 9
                  sub          sp, a4, a4
                  c.slli       s5, 8
                  andi         t0, a0, -564
                  or           a5, a1, t6
                  mulh         s4, s7, t5
                  srl          a4, ra, s8
                  andi         t0, a0, -564
                  lui          a2, 494335
                  c.li         ra, 9
                  nop
                  sltiu        a4, t2, -709
                  sltiu        a4, t2, -709
                  li           a3, 0x80000000 #start riscv_int_numeric_corner_stream_35
                  li           s8, 0x80000000
                  li           s9, 0x80000000
                  li           s0, 0x828fdd7c
                  li           t6, 0x0
                  li           s3, 0x80000000
                  li           t0, 0xffffffff
                  li           s2, 0x669ae85a
                  li           t5, 0x0
                  li           a6, 0x0
                  div          a3, a3, s3
                  rem          a6, s3, a6
                  nop
                  add          s2, s9, t5
                  auipc        s9, 95018
                  sub          a3, s0, t0
                  auipc        s9, 95018
                  divu         t6, s2, a6
                  rem          a6, s3, a6
                  divu         t6, s2, a6
                  sub          a3, s0, t0
                  remu         s3, a3, s3
                  divu         t6, s2, a6
                  mulhsu       a6, s2, s0
                  rem          a6, s3, a6
                  auipc        s9, 95018
                  addi         a6, t0, 639
                  mulh         s2, s9, t5
                  nop
                  mulhsu       a6, s2, s0
                  mul          t5, s3, s3
                  rem          a6, s3, a6
                  mul          t5, s3, s3
                  add          s2, s9, t5
                  sub          a3, s0, t0
                  mul          t5, s3, s3 #end riscv_int_numeric_corner_stream_35
                  srl          a4, ra, s8
                  add          tp, a2, s8
                  srli         zero, ra, 0
                  sll          a1, s6, s9
                  and          s9, s5, a4
                  xor          a6, s1, sp
                  c.sub        a0, a5
                  auipc        t6, 95018
                  lui          a2, 494335
                  c.srai       a0, 24
                  c.xor        a3, a0
                  sll          a1, s6, s9
                  sra          s2, t6, s1
                  c.and        a2, a3
                  c.srai       a0, 24
                  c.xor        a3, a0
                  mul          s0, t0, a0
                  slli         gp, s11, 27
                  mulhu        a0, t2, zero
                  c.mv         a3, s10
                  c.mv         a3, s10
                  sltiu        a4, t2, -709
                  c.sub        a0, a5
                  c.addi4spn   a3, sp, 400
                  c.or         s1, a0
                  c.slli       s5, 8
                  sub          sp, a4, a4
                  slli         gp, s11, 27
                  mulhsu       a5, a0, s10
                  srli         zero, ra, 0
                  c.or         s1, a0
                  c.xor        a3, a0
                  c.slli       s5, 8
                  c.addi16sp   sp, 464
                  c.slli       s5, 8
                  sub          sp, a4, a4
                  c.andi       a5, 29
                  c.or         s1, a0
                  mulhsu       a5, a0, s10
                  srli         zero, ra, 0
                  div          sp, s2, s5
                  c.srli       a4, 11
                  mulhsu       a5, a0, s10
                  sltu         s1, s6, s7
                  or           a5, a1, t6
                  mulhsu       a5, a0, s10
                  c.mv         a3, s10
                  sra          s2, t6, s1
                  andi         t0, a0, -564
                  c.addi4spn   a3, sp, 400
                  divu         s11, a1, gp
                  rem          s3, a2, a3
                  div          sp, s2, s5
                  sra          s2, t6, s1
                  c.srai       a0, 24
                  and          s9, s5, a4
                  c.li         ra, 9
                  c.addi       s1, -1
                  addi         a5, a6, 639
                  c.mv         a3, s10
                  c.xor        a3, a0
                  addi         a5, a6, 639
                  c.or         s1, a0
                  c.srli       a4, 11
                  c.addi       s1, -1
                  slli         gp, s11, 27
                  c.add        s4, a4
                  mulhu        a0, t2, zero
                  slli         gp, s11, 27
                  rem          s3, a2, a3
                  nop
                  c.addi4spn   a3, sp, 400
                  c.li         ra, 9
                  c.li         ra, 9
                  srai         s0, s4, 6
                  c.lui        a4, 9
                  nop
                  c.add        s4, a4
                  mulhsu       a5, a0, s10
                  sll          a1, s6, s9
                  slt          s3, a4, s5
                  xor          a6, s1, sp
                  auipc        t6, 95018
                  addi         a5, a6, 639
                  srli         zero, ra, 0
                  addi         a5, a6, 639
                  sra          s2, t6, s1
                  divu         s11, a1, gp
                  sll          a1, s6, s9
                  c.add        s4, a4
                  ori          a3, t5, 1088
                  remu         t6, s2, s5
                  c.andi       a5, 29
                  mulhu        a0, t2, zero
                  sub          sp, a4, a4
                  nop
                  mulh         s4, s7, t5
                  c.sub        a0, a5
                  slt          s3, a4, s5
                  slt          s3, a4, s5
                  srai         s0, s4, 6
                  slli         gp, s11, 27
                  divu         s11, a1, gp
                  slti         s3, s5, -238
                  slli         gp, s11, 27
                  mulhsu       a5, a0, s10
                  c.srai       a0, 24
                  slti         s3, s5, -238
                  mulhu        a0, t2, zero
                  c.mv         a3, s10
                  and          s9, s5, a4
                  nop
                  srl          a4, ra, s8
                  xor          a6, s1, sp
                  divu         s11, a1, gp
                  c.sub        a0, a5
                  c.addi       s1, -1
                  sra          s2, t6, s1
                  divu         s11, a1, gp
                  c.slli       s5, 8
                  sltu         s1, s6, s7
                  sltiu        a4, t2, -709
                  c.nop
                  c.sub        a0, a5
                  c.andi       a5, 29
                  c.addi4spn   a3, sp, 400
                  divu         s11, a1, gp
                  or           a5, a1, t6
                  c.addi4spn   a3, sp, 400
                  or           a5, a1, t6
                  rem          s3, a2, a3
                  slt          s3, a4, s5
                  and          s9, s5, a4
                  c.andi       a5, 29
                  c.addi       s1, -1
                  andi         t0, a0, -564
                  nop
                  slt          s3, a4, s5
                  mulh         s4, s7, t5
                  slt          s3, a4, s5
                  c.sub        a0, a5
                  sra          s2, t6, s1
                  lui          a2, 494335
                  c.addi4spn   a3, sp, 400
                  xori         s9, a6, -2048
                  sll          a1, s6, s9
                  sltiu        a4, t2, -709
                  slti         s3, s5, -238
                  and          s9, s5, a4
                  ori          a3, t5, 1088
                  c.lui        a4, 9
                  c.lui        a4, 9
                  xori         s9, a6, -2048
                  srl          a4, ra, s8
                  xor          a6, s1, sp
                  srai         s0, s4, 6
                  srli         zero, ra, 0
                  c.srli       a4, 11
                  c.addi16sp   sp, 464
                  or           a5, a1, t6
                  xor          a6, s1, sp
                  c.nop
                  c.andi       a5, 29
                  srl          a4, ra, s8
                  divu         s11, a1, gp
                  c.and        a2, a3
                  xori         s9, a6, -2048
                  c.xor        a3, a0
                  srai         s0, s4, 6
                  c.xor        a3, a0
                  xor          a6, s1, sp
                  div          sp, s2, s5
                  c.and        a2, a3
                  remu         t6, s2, s5
                  and          s9, s5, a4
                  addi         a5, a6, 639
                  sll          a1, s6, s9
                  sll          a1, s6, s9
                  c.sub        a0, a5
                  c.or         s1, a0
                  divu         s11, a1, gp
                  c.addi       s1, -1
                  div          sp, s2, s5
                  srli         zero, ra, 0
                  c.xor        a3, a0
                  c.xor        a3, a0
                  c.lui        a4, 9
                  sll          a1, s6, s9
                  add          tp, a2, s8
                  mulhsu       a5, a0, s10
                  srai         s0, s4, 6
                  sltiu        a4, t2, -709
                  mul          s0, t0, a0
                  slli         gp, s11, 27
                  sra          s2, t6, s1
                  srai         s0, s4, 6
                  c.addi       s1, -1
                  and          s9, s5, a4
                  sll          a1, s6, s9
                  nop
                  c.addi16sp   sp, 464
                  c.addi4spn   a3, sp, 400
                  and          s9, s5, a4
                  c.addi       s1, -1
                  c.slli       s5, 8
                  c.add        s4, a4
                  xor          a6, s1, sp
                  auipc        t6, 95018
                  remu         t6, s2, s5
                  c.lui        a4, 9
                  c.addi16sp   sp, 464
                  xori         s9, a6, -2048
                  sltu         s1, s6, s7
                  c.slli       s5, 8
                  andi         t0, a0, -564
                  c.slli       s5, 8
                  div          sp, s2, s5
                  sra          s2, t6, s1
                  c.addi16sp   sp, 464
                  ori          a3, t5, 1088
                  c.srai       a0, 24
                  remu         t6, s2, s5
                  auipc        t6, 95018
                  c.slli       s5, 8
                  sub          sp, a4, a4
                  mulhu        a0, t2, zero
                  andi         t0, a0, -564
                  c.add        s4, a4
                  mulhu        a0, t2, zero
                  slli         gp, s11, 27
                  xor          a6, s1, sp
                  or           a5, a1, t6
                  c.lui        a4, 9
                  c.lui        a4, 9
                  slt          s3, a4, s5
                  c.li         ra, 9
                  c.lui        a4, 9
                  addi         a5, a6, 639
                  remu         t6, s2, s5
                  c.addi16sp   sp, 464
                  srl          a4, ra, s8
                  srli         zero, ra, 0
                  slti         s3, s5, -238
                  c.li         ra, 9
                  c.srai       a0, 24
                  and          s9, s5, a4
                  mulhu        a0, t2, zero
                  c.andi       a5, 29
                  xori         s9, a6, -2048
                  slti         s3, s5, -238
                  and          s9, s5, a4
                  add          tp, a2, s8
                  c.or         s1, a0
                  mul          s0, t0, a0
                  divu         s11, a1, gp
                  sra          s2, t6, s1
                  c.add        s4, a4
                  sll          a1, s6, s9
                  auipc        t6, 95018
                  nop
                  c.or         s1, a0
                  c.mv         a3, s10
                  xor          a6, s1, sp
                  c.or         s1, a0
                  andi         t0, a0, -564
                  c.mv         a3, s10
                  add          tp, a2, s8
                  c.slli       s5, 8
                  c.lui        a4, 9
                  ori          a3, t5, 1088
                  sltu         s1, s6, s7
                  c.addi4spn   a3, sp, 400
                  c.addi       s1, -1
                  c.xor        a3, a0
                  xor          a6, s1, sp
                  sll          a1, s6, s9
                  c.mv         a3, s10
                  auipc        t6, 95018
                  c.srli       a4, 11
                  srli         zero, ra, 0
                  sra          s2, t6, s1
                  c.srli       a4, 11
                  c.srli       a4, 11
                  andi         t0, a0, -564
                  mulh         s4, s7, t5
                  divu         s11, a1, gp
                  slli         gp, s11, 27
                  addi         a5, a6, 639
                  slli         gp, s11, 27
                  c.add        s4, a4
                  mulh         s4, s7, t5
                  c.andi       a5, 29
                  srl          a4, ra, s8
                  c.and        a2, a3
                  c.sub        a0, a5
                  c.srai       a0, 24
                  c.add        s4, a4
                  sll          a1, s6, s9
                  srai         s0, s4, 6
                  slt          s3, a4, s5
                  ori          a3, t5, 1088
                  c.andi       a5, 29
                  c.li         ra, 9
                  c.addi       s1, -1
                  c.li         ra, 9
                  c.sub        a0, a5
                  div          sp, s2, s5
                  srl          a4, ra, s8
                  addi         a5, a6, 639
                  slt          s3, a4, s5
                  c.addi       s1, -1
                  c.sub        a0, a5
                  slli         gp, s11, 27
                  nop
                  srl          a4, ra, s8
                  add          tp, a2, s8
                  mulhsu       a5, a0, s10
                  c.srai       a0, 24
                  c.li         ra, 9
                  divu         s11, a1, gp
                  ori          a3, t5, 1088
                  xor          a6, s1, sp
                  xor          a6, s1, sp
                  c.addi4spn   a3, sp, 400
                  ori          a3, t5, 1088
                  sub          sp, a4, a4
                  add          tp, a2, s8
                  c.addi16sp   sp, 464
                  c.addi4spn   a3, sp, 400
                  auipc        t6, 95018
                  mul          s0, t0, a0
                  mul          s0, t0, a0
                  c.mv         a3, s10
                  slt          s3, a4, s5
                  xor          a6, s1, sp
                  c.and        a2, a3
                  nop
                  sltiu        a4, t2, -709
                  c.addi4spn   a3, sp, 400
                  add          tp, a2, s8
                  auipc        t6, 95018
                  c.addi4spn   a3, sp, 400
                  c.srli       a4, 11
                  c.slli       s5, 8
                  slli         gp, s11, 27
                  c.addi16sp   sp, 464
                  mulhu        a0, t2, zero
                  and          s9, s5, a4
                  c.sub        a0, a5
                  addi         a5, a6, 639
                  xori         s9, a6, -2048
                  nop
                  c.li         ra, 9
                  c.srli       a4, 11
                  andi         t0, a0, -564
                  c.add        s4, a4
                  mul          s0, t0, a0
                  c.addi       s1, -1
                  divu         s11, a1, gp
                  srli         zero, ra, 0
                  mulhsu       a5, a0, s10
                  or           a5, a1, t6
                  sltiu        a4, t2, -709
                  slt          s3, a4, s5
                  c.lui        a4, 9
                  sll          a1, s6, s9
                  c.addi16sp   sp, 464
                  c.andi       a5, 29
                  mul          s0, t0, a0
                  c.and        a2, a3
                  remu         t6, s2, s5
                  sltu         s1, s6, s7
                  srl          a4, ra, s8
                  mul          s0, t0, a0
                  slli         gp, s11, 27
                  xori         s9, a6, -2048
                  c.add        s4, a4
                  auipc        t6, 95018
                  c.or         s1, a0
                  slli         gp, s11, 27
                  srl          a4, ra, s8
                  divu         s11, a1, gp
                  slti         s3, s5, -238
                  c.andi       a5, 29
                  slt          s3, a4, s5
                  c.addi4spn   a3, sp, 400
                  c.nop
                  mul          s0, t0, a0
                  sra          s2, t6, s1
                  sll          a1, s6, s9
                  c.srai       a0, 24
                  c.and        a2, a3
                  mulh         s4, s7, t5
                  slli         gp, s11, 27
                  c.and        a2, a3
                  c.addi16sp   sp, 464
                  sltu         s1, s6, s7
                  c.sub        a0, a5
                  sll          a1, s6, s9
                  auipc        t6, 95018
                  addi         a5, a6, 639
                  c.srai       a0, 24
                  c.sub        a0, a5
                  lui          a2, 494335
                  c.add        s4, a4
                  c.mv         a3, s10
                  and          s9, s5, a4
                  and          s9, s5, a4
                  c.andi       a5, 29
                  rem          s3, a2, a3
                  mulh         s4, s7, t5
                  addi         a5, a6, 639
                  xori         s9, a6, -2048
                  sltiu        a4, t2, -709
                  srai         s0, s4, 6
                  mulhu        a0, t2, zero
                  nop
                  andi         t0, a0, -564
                  sra          s2, t6, s1
                  divu         s11, a1, gp
                  srl          a4, ra, s8
                  c.and        a2, a3
                  c.srai       a0, 24
                  c.andi       a5, 29
                  c.mv         a3, s10
                  c.addi16sp   sp, 464
                  xor          a6, s1, sp
                  or           a5, a1, t6
                  sub          sp, a4, a4
                  slt          s3, a4, s5
                  c.lui        a4, 9
                  c.srli       a4, 11
                  remu         t6, s2, s5
                  andi         t0, a0, -564
                  mul          s0, t0, a0
                  add          tp, a2, s8
                  c.li         ra, 9
                  xori         s9, a6, -2048
                  slt          s3, a4, s5
                  srli         zero, ra, 0
                  or           a5, a1, t6
                  c.nop
                  andi         t0, a0, -564
                  add          tp, a2, s8
                  rem          s3, a2, a3
                  c.sub        a0, a5
                  c.or         s1, a0
                  mulhu        a0, t2, zero
                  mulhu        a0, t2, zero
                  addi         a5, a6, 639
                  c.addi       s1, -1
                  c.xor        a3, a0
                  mulh         s4, s7, t5
                  or           a5, a1, t6
                  ori          a3, t5, 1088
                  mulh         s4, s7, t5
                  auipc        t6, 95018
                  c.addi       s1, -1
                  c.or         s1, a0
                  c.slli       s5, 8
                  c.addi       s1, -1
                  c.slli       s5, 8
                  c.mv         a3, s10
                  c.or         s1, a0
                  c.lui        a4, 9
                  sub          sp, a4, a4
                  mul          s0, t0, a0
                  c.li         ra, 9
                  slli         gp, s11, 27
                  add          tp, a2, s8
                  div          sp, s2, s5
                  add          tp, a2, s8
                  c.addi       s1, -1
                  c.li         ra, 9
                  auipc        t6, 95018
                  slli         gp, s11, 27
                  c.and        a2, a3
                  or           a5, a1, t6
                  divu         s11, a1, gp
                  mulhu        a0, t2, zero
                  c.srli       a4, 11
                  sra          s2, t6, s1
                  c.addi4spn   a3, sp, 400
                  addi         a5, a6, 639
                  nop
                  ori          a3, t5, 1088
                  divu         s11, a1, gp
                  c.and        a2, a3
                  and          s9, s5, a4
                  sub          sp, a4, a4
                  sltiu        a4, t2, -709
                  mulhsu       a5, a0, s10
                  c.addi4spn   a3, sp, 400
                  mulh         s4, s7, t5
                  sub          sp, a4, a4
                  mulhsu       a5, a0, s10
                  mulh         s4, s7, t5
                  xor          a6, s1, sp
                  add          tp, a2, s8
                  c.andi       a5, 29
                  mulhsu       a5, a0, s10
                  c.nop
                  srai         s0, s4, 6
                  c.and        a2, a3
                  add          tp, a2, s8
                  c.mv         a3, s10
                  sltiu        a4, t2, -709
                  mul          s0, t0, a0
                  c.xor        a3, a0
                  c.li         ra, 9
                  divu         s11, a1, gp
                  mulh         s4, s7, t5
                  c.andi       a5, 29
                  c.addi       s1, -1
                  andi         t0, a0, -564
                  c.addi16sp   sp, 464
                  c.and        a2, a3
                  lui          a2, 494335
                  c.addi16sp   sp, 464
                  mulhu        a0, t2, zero
                  c.srai       a0, 24
                  c.andi       a5, 29
                  c.nop
                  mulhsu       a5, a0, s10
                  xori         s9, a6, -2048
                  nop
                  sltiu        a4, t2, -709
                  slt          s3, a4, s5
                  c.nop
                  sltiu        a4, t2, -709
                  ori          a3, t5, 1088
                  c.xor        a3, a0
                  sub          sp, a4, a4
                  auipc        t6, 95018
                  c.mv         a3, s10
                  sra          s2, t6, s1
                  c.and        a2, a3
                  div          sp, s2, s5
                  and          s9, s5, a4
                  c.addi4spn   a3, sp, 400
                  andi         t0, a0, -564
                  srli         zero, ra, 0
                  xori         s9, a6, -2048
                  lui          a2, 494335
                  c.slli       s5, 8
                  c.nop
                  sltiu        a4, t2, -709
                  c.lui        a4, 9
                  xor          a6, s1, sp
                  ori          a3, t5, 1088
                  c.or         s1, a0
                  ori          a3, t5, 1088
                  c.lui        a4, 9
                  remu         t6, s2, s5
                  ori          a3, t5, 1088
                  c.lui        a4, 9
                  sltu         s1, s6, s7
                  c.mv         a3, s10
                  c.xor        a3, a0
                  and          s9, s5, a4
                  c.add        s4, a4
                  c.slli       s5, 8
                  or           a5, a1, t6
                  c.xor        a3, a0
                  c.addi16sp   sp, 464
                  c.addi16sp   sp, 464
                  and          s9, s5, a4
                  srli         zero, ra, 0
                  mulh         s4, s7, t5
                  srli         zero, ra, 0
                  srl          a4, ra, s8
                  xor          a6, s1, sp
                  nop
                  c.add        s4, a4
                  c.sub        a0, a5
                  remu         t6, s2, s5
                  nop
                  or           a5, a1, t6
                  c.andi       a5, 29
                  sltiu        a4, t2, -709
                  c.add        s4, a4
                  c.addi16sp   sp, 464
                  nop
                  xori         s9, a6, -2048
                  div          sp, s2, s5
                  c.andi       a5, 29
                  mulh         s4, s7, t5
                  srli         zero, ra, 0
                  or           a5, a1, t6
                  c.addi16sp   sp, 464
                  c.addi       s1, -1
                  xori         s9, a6, -2048
                  c.mv         a3, s10
                  mulhsu       a5, a0, s10
                  c.srai       a0, 24
                  add          tp, a2, s8
                  c.addi4spn   a3, sp, 400
                  c.addi4spn   a3, sp, 400
                  srli         zero, ra, 0
                  c.addi16sp   sp, 464
                  sub          sp, a4, a4
                  nop
                  c.li         ra, 9
                  c.or         s1, a0
                  mulh         s4, s7, t5
                  xor          a6, s1, sp
                  div          sp, s2, s5
                  rem          s3, a2, a3
                  c.addi16sp   sp, 464
                  auipc        t6, 95018
                  c.srai       a0, 24
                  auipc        t6, 95018
                  and          s9, s5, a4
                  remu         t6, s2, s5
                  divu         s11, a1, gp
                  mulhu        a0, t2, zero
                  xori         s9, a6, -2048
                  c.lui        a4, 9
                  srl          a4, ra, s8
                  sll          a1, s6, s9
                  srl          a4, ra, s8
                  sra          s2, t6, s1
                  sra          s2, t6, s1
                  addi         a5, a6, 639
                  sub          sp, a4, a4
                  sra          s2, t6, s1
                  add          tp, a2, s8
                  c.andi       a5, 29
                  c.srai       a0, 24
                  c.sub        a0, a5
                  c.mv         a3, s10
                  xori         s9, a6, -2048
                  c.srai       a0, 24
                  c.addi       s1, -1
                  c.srli       a4, 11
                  ori          a3, t5, 1088
                  srli         zero, ra, 0
                  srli         zero, ra, 0
                  c.sub        a0, a5
                  xori         s9, a6, -2048
                  c.nop
                  and          s9, s5, a4
                  mulhsu       a5, a0, s10
                  c.li         ra, 9
                  ori          a3, t5, 1088
                  mulhu        a0, t2, zero
                  c.addi       s1, -1
                  slt          s3, a4, s5
                  c.li         ra, 9
                  addi         a5, a6, 639
                  andi         t0, a0, -564
                  mulhu        a0, t2, zero
                  nop
                  auipc        t6, 95018
                  andi         t0, a0, -564
                  remu         t6, s2, s5
                  slli         gp, s11, 27
                  auipc        t6, 95018
                  sll          a1, s6, s9
                  c.xor        a3, a0
                  c.sub        a0, a5
                  ori          a3, t5, 1088
                  c.nop
                  sll          a1, s6, s9
                  div          sp, s2, s5
                  mul          s0, t0, a0
                  c.srai       a0, 24
                  addi         a5, a6, 639
                  rem          s3, a2, a3
                  sub          sp, a4, a4
                  sltu         s1, s6, s7
                  slti         s3, s5, -238
                  nop
                  or           a5, a1, t6
                  slti         s3, s5, -238
                  xor          a6, s1, sp
                  mul          s0, t0, a0
                  sub          sp, a4, a4
                  xor          a6, s1, sp
                  sltiu        a4, t2, -709
                  srli         zero, ra, 0
                  and          s9, s5, a4
                  div          sp, s2, s5
                  mulh         s4, s7, t5
                  nop
                  xori         s9, a6, -2048
                  rem          s3, a2, a3
                  mulhu        a0, t2, zero
                  c.srli       a4, 11
                  slli         gp, s11, 27
                  lui          a2, 494335
                  srli         zero, ra, 0
                  c.sub        a0, a5
                  andi         t0, a0, -564
                  c.or         s1, a0
                  mulhsu       a5, a0, s10
                  srl          a4, ra, s8
                  c.nop
                  c.andi       a5, 29
                  sltu         s1, s6, s7
                  c.nop
                  or           a5, a1, t6
                  c.andi       a5, 29
                  mulhu        a0, t2, zero
                  mulhu        a0, t2, zero
                  mulh         s4, s7, t5
                  c.nop
                  c.nop
                  remu         t6, s2, s5
                  addi         a5, a6, 639
                  srl          a4, ra, s8
                  or           a5, a1, t6
                  auipc        t6, 95018
                  c.li         ra, 9
                  or           a5, a1, t6
                  sra          s2, t6, s1
                  add          tp, a2, s8
                  c.addi       s1, -1
                  c.mv         a3, s10
                  c.andi       a5, 29
                  c.add        s4, a4
                  remu         t6, s2, s5
                  c.slli       s5, 8
                  mulhu        a0, t2, zero
                  mulhsu       a5, a0, s10
                  c.add        s4, a4
                  mulh         s4, s7, t5
                  c.srli       a4, 11
                  lui          a2, 494335
                  lui          a2, 494335
                  and          s9, s5, a4
                  nop
                  and          s9, s5, a4
                  mulhu        a0, t2, zero
                  auipc        t6, 95018
                  c.andi       a5, 29
                  mulhsu       a5, a0, s10
                  andi         t0, a0, -564
                  slti         s3, s5, -238
                  sll          a1, s6, s9
                  c.andi       a5, 29
                  divu         s11, a1, gp
                  sra          s2, t6, s1
                  c.and        a2, a3
                  slti         s3, s5, -238
                  c.addi       s1, -1
                  addi         a5, a6, 639
                  divu         s11, a1, gp
                  c.addi       s1, -1
                  c.add        s4, a4
                  rem          s3, a2, a3
                  and          s9, s5, a4
                  auipc        t6, 95018
                  slli         gp, s11, 27
                  slt          s3, a4, s5
                  nop
                  c.or         s1, a0
                  c.lui        a4, 9
                  c.addi       s1, -1
                  auipc        t6, 95018
                  c.and        a2, a3
                  addi         a5, a6, 639
                  sub          sp, a4, a4
                  c.slli       s5, 8
                  addi         a5, a6, 639
                  ori          a3, t5, 1088
                  srl          a4, ra, s8
                  divu         s11, a1, gp
                  div          sp, s2, s5
                  nop
                  div          sp, s2, s5
                  addi         a5, a6, 639
                  auipc        t6, 95018
                  mulhu        a0, t2, zero
                  mul          s0, t0, a0
                  auipc        t6, 95018
                  c.li         ra, 9
                  rem          s3, a2, a3
                  c.add        s4, a4
                  c.xor        a3, a0
                  lui          a2, 494335
                  c.sub        a0, a5
                  c.add        s4, a4
                  sra          s2, t6, s1
                  lui          a2, 494335
                  c.nop
                  ori          a3, t5, 1088
                  slt          s3, a4, s5
                  mul          s0, t0, a0
                  c.nop
                  slti         s3, s5, -238
                  xori         s9, a6, -2048
                  mulhsu       a5, a0, s10
                  c.srai       a0, 24
                  c.nop
                  slti         s3, s5, -238
                  c.xor        a3, a0
                  add          tp, a2, s8
                  c.andi       a5, 29
                  sll          a1, s6, s9
                  sub          sp, a4, a4
                  c.addi16sp   sp, 464
                  c.srli       a4, 11
                  slt          s3, a4, s5
                  sltiu        a4, t2, -709
                  mulh         s4, s7, t5
                  srai         s0, s4, 6
                  mulhu        a0, t2, zero
                  mulh         s4, s7, t5
                  c.addi16sp   sp, 464
                  c.sub        a0, a5
                  c.add        s4, a4
                  xori         s9, a6, -2048
                  c.or         s1, a0
                  sltu         s1, s6, s7
                  c.xor        a3, a0
                  lui          a2, 494335
                  slti         s3, s5, -238
                  div          sp, s2, s5
                  c.mv         a3, s10
                  slt          s3, a4, s5
                  sll          a1, s6, s9
                  mulh         s4, s7, t5
                  slli         gp, s11, 27
                  divu         s11, a1, gp
                  mul          s0, t0, a0
                  c.mv         a3, s10
                  divu         s11, a1, gp
                  rem          s3, a2, a3
                  slti         s3, s5, -238
                  c.srli       a4, 11
                  c.and        a2, a3
                  sltiu        a4, t2, -709
                  slli         gp, s11, 27
                  c.xor        a3, a0
                  mulhu        a0, t2, zero
                  c.sub        a0, a5
                  c.addi4spn   a3, sp, 400
                  c.and        a2, a3
                  srl          a4, ra, s8
                  ori          a3, t5, 1088
                  or           a5, a1, t6
                  c.mv         a3, s10
                  c.add        s4, a4
                  sll          a1, s6, s9
                  addi         a5, a6, 639
                  srli         zero, ra, 0
                  div          sp, s2, s5
                  divu         s11, a1, gp
                  c.slli       s5, 8
                  c.or         s1, a0
                  ori          a3, t5, 1088
                  and          s9, s5, a4
                  srai         s0, s4, 6
                  c.srli       a4, 11
                  slli         gp, s11, 27
                  slti         s3, s5, -238
                  and          s9, s5, a4
                  mulhsu       a5, a0, s10
                  ori          a3, t5, 1088
                  c.addi16sp   sp, 464
                  c.addi       s1, -1
                  remu         t6, s2, s5
                  mul          s0, t0, a0
                  c.add        s4, a4
                  div          sp, s2, s5
                  c.and        a2, a3
                  sra          s2, t6, s1
                  divu         s11, a1, gp
                  sltiu        a4, t2, -709
                  and          s9, s5, a4
                  addi         a5, a6, 639
                  auipc        t6, 95018
                  c.addi4spn   a3, sp, 400
                  auipc        t6, 95018
                  add          tp, a2, s8
                  c.addi       s1, -1
                  remu         t6, s2, s5
                  slli         gp, s11, 27
                  sll          a1, s6, s9
                  div          sp, s2, s5
                  lui          a2, 494335
                  ori          a3, t5, 1088
                  rem          s3, a2, a3
                  c.and        a2, a3
                  xor          a6, s1, sp
                  xor          a6, s1, sp
                  sltiu        a4, t2, -709
                  c.andi       a5, 29
                  c.li         ra, 9
                  c.addi       s1, -1
                  rem          s3, a2, a3
                  or           a5, a1, t6
                  slti         s3, s5, -238
                  c.lui        a4, 9
                  xori         s9, a6, -2048
                  div          sp, s2, s5
                  slli         gp, s11, 27
                  srl          a4, ra, s8
                  c.xor        a3, a0
                  add          tp, a2, s8
                  addi         a5, a6, 639
                  c.li         ra, 9
                  xori         s9, a6, -2048
                  xori         s9, a6, -2048
                  c.srai       a0, 24
                  mulhu        a0, t2, zero
                  sub          sp, a4, a4
                  and          s9, s5, a4
                  mulhu        a0, t2, zero
                  c.and        a2, a3
                  c.lui        a4, 9
                  c.addi16sp   sp, 464
                  c.nop
                  or           a5, a1, t6
                  remu         t6, s2, s5
                  c.srli       a4, 11
                  c.andi       a5, 29
                  addi         a5, a6, 639
                  c.or         s1, a0
                  c.li         ra, 9
                  auipc        t6, 95018
                  andi         t0, a0, -564
                  sub          sp, a4, a4
                  rem          s3, a2, a3
                  c.sub        a0, a5
                  srai         s0, s4, 6
                  nop
                  lui          a2, 494335
                  add          tp, a2, s8
                  mulhu        a0, t2, zero
                  div          sp, s2, s5
                  andi         t0, a0, -564
                  c.addi16sp   sp, 464
                  slt          s3, a4, s5
                  andi         t0, a0, -564
                  div          sp, s2, s5
                  srai         s0, s4, 6
                  c.srli       a4, 11
                  andi         t0, a0, -564
                  xor          a6, s1, sp
                  c.slli       s5, 8
                  slli         gp, s11, 27
                  sra          s2, t6, s1
                  ori          a3, t5, 1088
                  andi         t0, a0, -564
                  nop
                  auipc        t6, 95018
                  c.mv         a3, s10
                  mulhu        a0, t2, zero
                  c.nop
                  slli         gp, s11, 27
                  c.mv         a3, s10
                  mulh         s4, s7, t5
                  or           a5, a1, t6
                  xori         s9, a6, -2048
                  c.li         ra, 9
                  c.mv         a3, s10
                  mulhsu       a5, a0, s10
                  c.sub        a0, a5
                  sub          sp, a4, a4
                  c.addi       s1, -1
                  c.add        s4, a4
                  sll          a1, s6, s9
                  c.addi       s1, -1
                  lui          a2, 494335
                  srl          a4, ra, s8
                  div          sp, s2, s5
                  c.and        a2, a3
                  xor          a6, s1, sp
                  c.addi16sp   sp, 464
                  c.slli       s5, 8
                  slli         gp, s11, 27
                  c.add        s4, a4
                  remu         t6, s2, s5
                  xori         s9, a6, -2048
                  srai         s0, s4, 6
                  slt          s3, a4, s5
                  srl          a4, ra, s8
                  xori         s9, a6, -2048
                  sub          sp, a4, a4
                  c.xor        a3, a0
                  c.andi       a5, 29
                  add          tp, a2, s8
                  slti         s3, s5, -238
                  mul          s0, t0, a0
                  sltiu        a4, t2, -709
                  c.add        s4, a4
                  srai         s0, s4, 6
                  c.xor        a3, a0
                  sltu         s1, s6, s7
                  ori          a3, t5, 1088
                  sltu         s1, s6, s7
                  sltiu        a4, t2, -709
                  slli         gp, s11, 27
                  srli         zero, ra, 0
                  mulh         s4, s7, t5
                  sra          s2, t6, s1
                  sltu         s1, s6, s7
                  mulhu        a0, t2, zero
                  c.lui        a4, 9
                  c.xor        a3, a0
                  srai         s0, s4, 6
                  rem          s3, a2, a3
                  xor          a6, s1, sp
                  slt          s3, a4, s5
                  c.and        a2, a3
                  c.mv         a3, s10
                  divu         s11, a1, gp
                  c.addi4spn   a3, sp, 400
                  c.mv         a3, s10
                  srli         zero, ra, 0
                  srl          a4, ra, s8
                  c.xor        a3, a0
                  sltiu        a4, t2, -709
                  mul          s0, t0, a0
                  sra          s2, t6, s1
                  c.srli       a4, 11
                  srai         s0, s4, 6
                  sltiu        a4, t2, -709
                  c.addi4spn   a3, sp, 400
                  xori         s9, a6, -2048
                  c.xor        a3, a0
                  sltu         s1, s6, s7
                  addi         a5, a6, 639
                  c.srli       a4, 11
                  lui          a2, 494335
                  c.srai       a0, 24
                  c.addi16sp   sp, 464
                  add          tp, a2, s8
                  mulh         s4, s7, t5
                  c.add        s4, a4
                  c.slli       s5, 8
                  addi         a5, a6, 639
                  rem          s3, a2, a3
                  sltiu        a4, t2, -709
                  mulhsu       a5, a0, s10
                  addi         a5, a6, 639
                  srl          a4, ra, s8
                  andi         t0, a0, -564
                  c.add        s4, a4
                  c.lui        a4, 9
                  xori         s9, a6, -2048
                  ori          a3, t5, 1088
                  sll          a1, s6, s9
                  add          tp, a2, s8
                  mulhsu       a5, a0, s10
                  xor          a6, s1, sp
                  sub          sp, a4, a4
                  slt          s3, a4, s5
                  or           a5, a1, t6
                  srai         s0, s4, 6
                  add          tp, a2, s8
                  srai         s0, s4, 6
                  mul          s0, t0, a0
                  srli         zero, ra, 0
                  sltu         s1, s6, s7
                  sltu         s1, s6, s7
                  c.slli       s5, 8
                  c.srai       a0, 24
                  ori          a3, t5, 1088
                  remu         t6, s2, s5
                  li           t2, 0x80000000 #start riscv_int_numeric_corner_stream_0
                  li           s4, 0x80000000
                  li           a4, 0x0
                  li           s10, 0xffffffff
                  li           a5, 0x4859ff33
                  li           sp, 0xffffffff
                  li           s1, 0x0
                  li           a3, 0x5adc56e
                  li           s5, 0x80000000
                  li           a1, 0x80000000
                  sub          s1, t2, sp
                  lui          s1, 494335
                  mul          s5, a4, a4
                  mul          s5, a4, a4
                  lui          s1, 494335
                  add          a3, s4, s5
                  mulh         a3, s4, s5
                  rem          a1, a4, a1
                  remu         a4, s1, a4
                  add          a3, s4, s5
                  mulh         a3, s4, s5
                  remu         a4, s1, a4
                  div          s1, s1, a4
                  mulh         a3, s4, s5
                  addi         a1, sp, 639
                  mulhsu       a1, a3, t2
                  mul          s5, a4, a4
                  rem          a1, a4, a1
                  sub          s1, t2, sp
                  addi         a1, sp, 639
                  div          s1, s1, a4
                  lui          s1, 494335
                  rem          a1, a4, a1
                  mulh         a3, s4, s5
                  rem          a1, a4, a1
                  sub          s1, t2, sp
                  mul          s5, a4, a4
                  nop #end riscv_int_numeric_corner_stream_0
                  c.srli       a4, 11
                  slt          s3, a4, s5
                  lui          a2, 494335
                  andi         t0, a0, -564
                  or           a5, a1, t6
                  c.or         s1, a0
                  div          sp, s2, s5
                  c.slli       s5, 8
                  c.nop
                  xor          a6, s1, sp
                  or           a5, a1, t6
                  rem          s3, a2, a3
                  slti         s3, s5, -238
                  or           a5, a1, t6
                  c.or         s1, a0
                  srai         s0, s4, 6
                  c.srli       a4, 11
                  mulhsu       a5, a0, s10
                  slt          s3, a4, s5
                  add          tp, a2, s8
                  c.srli       a4, 11
                  mulhsu       a5, a0, s10
                  c.sub        a0, a5
                  slt          s3, a4, s5
                  c.lui        a4, 9
                  andi         t0, a0, -564
                  sra          s2, t6, s1
                  sll          a1, s6, s9
                  la x23, test_done
                  jalr x0, x23, 0
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
                  addi x22, x22, -4
                  sw  x28, (x22)
                  add x28, x22, zero
                  addi x28, x28, -128
                  sw  x1, 4(x28)
                  sw  x2, 8(x28)
                  sw  x3, 12(x28)
                  sw  x4, 16(x28)
                  sw  x5, 20(x28)
                  sw  x6, 24(x28)
                  sw  x7, 28(x28)
                  sw  x8, 32(x28)
                  sw  x9, 36(x28)
                  sw  x10, 40(x28)
                  sw  x11, 44(x28)
                  sw  x12, 48(x28)
                  sw  x13, 52(x28)
                  sw  x14, 56(x28)
                  sw  x15, 60(x28)
                  sw  x16, 64(x28)
                  sw  x17, 68(x28)
                  sw  x18, 72(x28)
                  sw  x19, 76(x28)
                  sw  x20, 80(x28)
                  sw  x21, 84(x28)
                  sw  x22, 88(x28)
                  sw  x23, 92(x28)
                  sw  x24, 96(x28)
                  sw  x25, 100(x28)
                  sw  x26, 104(x28)
                  sw  x27, 108(x28)
                  sw  x28, 112(x28)
                  sw  x29, 116(x28)
                  sw  x30, 120(x28)
                  sw  x31, 124(x28)
                  add x22, x28, zero
                  csrr x8, 0x300 # MSTATUS
                  csrr x8, 0x342 # MCAUSE
                  srli x8, x8, 31
                  bne x8, x0, mmode_intr_handler

mmode_exception_handler:
                  csrr x8, 0x341 # MEPC
                  csrr x8, 0x342 # MCAUSE
                  li x25, 0x3 # BREAKPOINT
                  beq x8, x25, ebreak_handler
                  li x25, 0x8 # ECALL_UMODE
                  beq x8, x25, ecall_handler
                  li x25, 0x9 # ECALL_SMODE
                  beq x8, x25, ecall_handler
                  li x25, 0xb # ECALL_MMODE
                  beq x8, x25, ecall_handler
                  li x25, 0x1
                  beq x8, x25, instr_fault_handler
                  li x25, 0x5
                  beq x8, x25, load_fault_handler
                  li x25, 0x7
                  beq x8, x25, store_fault_handler
                  li x25, 0xc
                  beq x8, x25, pt_fault_handler
                  li x25, 0xd
                  beq x8, x25, pt_fault_handler
                  li x25, 0xf
                  beq x8, x25, pt_fault_handler
                  li x25, 0x2 # ILLEGAL_INSTRUCTION
                  beq x8, x25, illegal_instr_handler
                  csrr x25, 0x343 # MTVAL
                  1: la x23, test_done
                  jalr x1, x23, 0

ecall_handler:    
                  la x8, _start
                  sw x0, 0(x8)
                  sw x1, 4(x8)
                  sw x2, 8(x8)
                  sw x3, 12(x8)
                  sw x4, 16(x8)
                  sw x5, 20(x8)
                  sw x6, 24(x8)
                  sw x7, 28(x8)
                  sw x8, 32(x8)
                  sw x9, 36(x8)
                  sw x10, 40(x8)
                  sw x11, 44(x8)
                  sw x12, 48(x8)
                  sw x13, 52(x8)
                  sw x14, 56(x8)
                  sw x15, 60(x8)
                  sw x16, 64(x8)
                  sw x17, 68(x8)
                  sw x18, 72(x8)
                  sw x19, 76(x8)
                  sw x20, 80(x8)
                  sw x21, 84(x8)
                  sw x22, 88(x8)
                  sw x23, 92(x8)
                  sw x24, 96(x8)
                  sw x25, 100(x8)
                  sw x26, 104(x8)
                  sw x27, 108(x8)
                  sw x28, 112(x8)
                  sw x29, 116(x8)
                  sw x30, 120(x8)
                  sw x31, 124(x8)
                  la x23, write_tohost
                  jalr x0, x23, 0

instr_fault_handler:
                  add x28, x22, zero
                  lw  x1, 4(x28)
                  lw  x2, 8(x28)
                  lw  x3, 12(x28)
                  lw  x4, 16(x28)
                  lw  x5, 20(x28)
                  lw  x6, 24(x28)
                  lw  x7, 28(x28)
                  lw  x8, 32(x28)
                  lw  x9, 36(x28)
                  lw  x10, 40(x28)
                  lw  x11, 44(x28)
                  lw  x12, 48(x28)
                  lw  x13, 52(x28)
                  lw  x14, 56(x28)
                  lw  x15, 60(x28)
                  lw  x16, 64(x28)
                  lw  x17, 68(x28)
                  lw  x18, 72(x28)
                  lw  x19, 76(x28)
                  lw  x20, 80(x28)
                  lw  x21, 84(x28)
                  lw  x22, 88(x28)
                  lw  x23, 92(x28)
                  lw  x24, 96(x28)
                  lw  x25, 100(x28)
                  lw  x26, 104(x28)
                  lw  x27, 108(x28)
                  lw  x28, 112(x28)
                  lw  x29, 116(x28)
                  lw  x30, 120(x28)
                  lw  x31, 124(x28)
                  addi x28, x28, 128
                  add x22, x28, zero
                  lw  x28, (x22)
                  addi x22, x22, 4
                  mret

load_fault_handler:
                  add x28, x22, zero
                  lw  x1, 4(x28)
                  lw  x2, 8(x28)
                  lw  x3, 12(x28)
                  lw  x4, 16(x28)
                  lw  x5, 20(x28)
                  lw  x6, 24(x28)
                  lw  x7, 28(x28)
                  lw  x8, 32(x28)
                  lw  x9, 36(x28)
                  lw  x10, 40(x28)
                  lw  x11, 44(x28)
                  lw  x12, 48(x28)
                  lw  x13, 52(x28)
                  lw  x14, 56(x28)
                  lw  x15, 60(x28)
                  lw  x16, 64(x28)
                  lw  x17, 68(x28)
                  lw  x18, 72(x28)
                  lw  x19, 76(x28)
                  lw  x20, 80(x28)
                  lw  x21, 84(x28)
                  lw  x22, 88(x28)
                  lw  x23, 92(x28)
                  lw  x24, 96(x28)
                  lw  x25, 100(x28)
                  lw  x26, 104(x28)
                  lw  x27, 108(x28)
                  lw  x28, 112(x28)
                  lw  x29, 116(x28)
                  lw  x30, 120(x28)
                  lw  x31, 124(x28)
                  addi x28, x28, 128
                  add x22, x28, zero
                  lw  x28, (x22)
                  addi x22, x22, 4
                  mret

store_fault_handler:
                  add x28, x22, zero
                  lw  x1, 4(x28)
                  lw  x2, 8(x28)
                  lw  x3, 12(x28)
                  lw  x4, 16(x28)
                  lw  x5, 20(x28)
                  lw  x6, 24(x28)
                  lw  x7, 28(x28)
                  lw  x8, 32(x28)
                  lw  x9, 36(x28)
                  lw  x10, 40(x28)
                  lw  x11, 44(x28)
                  lw  x12, 48(x28)
                  lw  x13, 52(x28)
                  lw  x14, 56(x28)
                  lw  x15, 60(x28)
                  lw  x16, 64(x28)
                  lw  x17, 68(x28)
                  lw  x18, 72(x28)
                  lw  x19, 76(x28)
                  lw  x20, 80(x28)
                  lw  x21, 84(x28)
                  lw  x22, 88(x28)
                  lw  x23, 92(x28)
                  lw  x24, 96(x28)
                  lw  x25, 100(x28)
                  lw  x26, 104(x28)
                  lw  x27, 108(x28)
                  lw  x28, 112(x28)
                  lw  x29, 116(x28)
                  lw  x30, 120(x28)
                  lw  x31, 124(x28)
                  addi x28, x28, 128
                  add x22, x28, zero
                  lw  x28, (x22)
                  addi x22, x22, 4
                  mret

ebreak_handler:   
                  csrr  x8, 0x341
                  addi  x8, x8, 4
                  csrw  0x341, x8
                  add x28, x22, zero
                  lw  x1, 4(x28)
                  lw  x2, 8(x28)
                  lw  x3, 12(x28)
                  lw  x4, 16(x28)
                  lw  x5, 20(x28)
                  lw  x6, 24(x28)
                  lw  x7, 28(x28)
                  lw  x8, 32(x28)
                  lw  x9, 36(x28)
                  lw  x10, 40(x28)
                  lw  x11, 44(x28)
                  lw  x12, 48(x28)
                  lw  x13, 52(x28)
                  lw  x14, 56(x28)
                  lw  x15, 60(x28)
                  lw  x16, 64(x28)
                  lw  x17, 68(x28)
                  lw  x18, 72(x28)
                  lw  x19, 76(x28)
                  lw  x20, 80(x28)
                  lw  x21, 84(x28)
                  lw  x22, 88(x28)
                  lw  x23, 92(x28)
                  lw  x24, 96(x28)
                  lw  x25, 100(x28)
                  lw  x26, 104(x28)
                  lw  x27, 108(x28)
                  lw  x28, 112(x28)
                  lw  x29, 116(x28)
                  lw  x30, 120(x28)
                  lw  x31, 124(x28)
                  addi x28, x28, 128
                  add x22, x28, zero
                  lw  x28, (x22)
                  addi x22, x22, 4
                  mret

illegal_instr_handler:
                  csrr  x8, 0x341
                  addi  x8, x8, 4
                  csrw  0x341, x8
                  add x28, x22, zero
                  lw  x1, 4(x28)
                  lw  x2, 8(x28)
                  lw  x3, 12(x28)
                  lw  x4, 16(x28)
                  lw  x5, 20(x28)
                  lw  x6, 24(x28)
                  lw  x7, 28(x28)
                  lw  x8, 32(x28)
                  lw  x9, 36(x28)
                  lw  x10, 40(x28)
                  lw  x11, 44(x28)
                  lw  x12, 48(x28)
                  lw  x13, 52(x28)
                  lw  x14, 56(x28)
                  lw  x15, 60(x28)
                  lw  x16, 64(x28)
                  lw  x17, 68(x28)
                  lw  x18, 72(x28)
                  lw  x19, 76(x28)
                  lw  x20, 80(x28)
                  lw  x21, 84(x28)
                  lw  x22, 88(x28)
                  lw  x23, 92(x28)
                  lw  x24, 96(x28)
                  lw  x25, 100(x28)
                  lw  x26, 104(x28)
                  lw  x27, 108(x28)
                  lw  x28, 112(x28)
                  lw  x29, 116(x28)
                  lw  x30, 120(x28)
                  lw  x31, 124(x28)
                  addi x28, x28, 128
                  add x22, x28, zero
                  lw  x28, (x22)
                  addi x22, x22, 4
                  mret

pt_fault_handler: 
                  nop

.align 2
mmode_intr_handler:
                  csrr  x8, 0x300 # MSTATUS;
                  csrr  x8, 0x304 # MIE;
                  csrr  x8, 0x344 # MIP;
                  csrrc x8, 0x344, x8 # MIP;
                  add x28, x22, zero
                  lw  x1, 4(x28)
                  lw  x2, 8(x28)
                  lw  x3, 12(x28)
                  lw  x4, 16(x28)
                  lw  x5, 20(x28)
                  lw  x6, 24(x28)
                  lw  x7, 28(x28)
                  lw  x8, 32(x28)
                  lw  x9, 36(x28)
                  lw  x10, 40(x28)
                  lw  x11, 44(x28)
                  lw  x12, 48(x28)
                  lw  x13, 52(x28)
                  lw  x14, 56(x28)
                  lw  x15, 60(x28)
                  lw  x16, 64(x28)
                  lw  x17, 68(x28)
                  lw  x18, 72(x28)
                  lw  x19, 76(x28)
                  lw  x20, 80(x28)
                  lw  x21, 84(x28)
                  lw  x22, 88(x28)
                  lw  x23, 92(x28)
                  lw  x24, 96(x28)
                  lw  x25, 100(x28)
                  lw  x26, 104(x28)
                  lw  x27, 108(x28)
                  lw  x28, 112(x28)
                  lw  x29, 116(x28)
                  lw  x30, 120(x28)
                  lw  x31, 124(x28)
                  addi x28, x28, 128
                  add x22, x28, zero
                  lw  x28, (x22)
                  addi x22, x22, 4
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
