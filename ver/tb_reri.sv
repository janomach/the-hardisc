/*
    Testbench for:
        - ecc_monitor   (hardisc soft-SECDED at
 RERI fault bus bridge)
        - reri_error_bank (RERI register bank, AHB-Lite slave)

    Test plan
    ========================================================================
    TC01  Reset clears all records; RAS outputs deasserted; control_i.else=0
    TC02  Fault capture: else=0 at no capture; else=1 at fetch CE captured (rec 0)
    TC03  LSU CE captured (record 1): status_i, addr_info_i, ras_lo
    TC04  LSU UED captured (record 1 overwrite): priority upgrade, ras_lo
    TC05  Pipeline UEC captured (record 2): ras_lo asserted
    TC06  AHB identification registers: vendor_n_imp_id, bank_info, valid_summary
    TC07  AHB read of unmapped address returns 0
    TC08  Software clear via sinv+srdp: valid cleared, ras_lo still asserted
    TC09  Priority arbitration: lower/equal priority fault cannot overwrite
    TC10  Overflow detection: ras_plat asserted when fault cannot be stored
    TC11  sinv alone (without rdip=1) does NOT clear valid
    TC12  Re-inject after sinv+srdp clear; verify re-capture
    TC13  valid_summary tracks record state changes (sv bit[0] always 1)
    TC14  else=0 disables fault capture; else=1 re-enables it
    TC15  ECOUNT: CE counter increments only when cece=1; no RAS-CE when cece=1
    TC16  rdip set on first capture; readable in status_i[23]
    TC17  RAS level selection: ces=10->ras_hi, ces=11->ras_plat for CE faults
    TC18  RAS level selection: ueds=10->ras_hi, uecs=11->ras_plat for UED/UEC
    TC19  eid countdown injection: r_valid set after N cycles, rdip set
    TC20  ecount saturation: counter stays at 0xFFFF on overflow
    TC21  valid_summary[63:32] high word reads 0 (unused bits)
    TC22  addr_info_i[63:32] (word 5 of record block) reads 0
    TC23  control_i[63:32] sinv/srdp bits always read 0
    TC24  Simultaneous multi-record fault capture (fetch_ce + lsu_ce same cycle)

    Coding conventions
    ========================================================================
    - All checks use `CHECK macro prints PASS/FAIL with test name.
    - AHB helper tasks: ahb_read, ahb_write.
    - Clock period: 10 ns.  Reset held for 4 cycles.
    - enable_record(k) must be called before any fault capture; r_else=0 at reset.
    - sinv_clear(k) issues srdp+sinv to clear a valid record.

*/

`timescale 1ns/1ns

import p_reri::fault_record_t;

module tb_reri;

// ========================================================================
// Parameters matching the instantiation
// ========================================================================
localparam N_REC     = 3;
localparam VENDOR_ID = 32'hDEAD_C0DE;
localparam IMP_ID    = 32'h0000_0001;
localparam INST_ID   = 16'h0001;  // bank_info[15:0]
localparam LAYOUT    = 2'b00;     // bank_info[23:22]
localparam VERSION   = 8'h01;     // bank_info[63:56] (0x01 = spec version)
// Expected bank_info words (RERI Figure 2):
localparam BANK_INFO_LO_EXP = {8'h0, LAYOUT, 6'(N_REC), INST_ID};  // {WPRI,layout,n_err_recs,inst_id}
localparam BANK_INFO_HI_EXP = {VERSION, 24'h0};                      // {version,WPRI}

// status_i field bit positions (RERI spec):
localparam VALID_BIT  = 0;   // status_i[0]  – valid
localparam CE_BIT     = 1;   // status_i[1]  – corrected error
localparam UED_BIT    = 2;   // status_i[2]  – uncorrected error deferred
localparam UEC_BIT    = 3;   // status_i[3]  – uncorrected error critical
localparam PRI_LO     = 4;   // status_i[5:4] – priority (low  bit)
localparam PRI_HI     = 5;   // status_i[5:4] – priority (high bit)
localparam C_BIT      = 7;   // status_i[7]  – containable
localparam TT_LO      = 8;   // status_i[10:8] – transaction type (low  bit)
localparam TT_HI      = 10;  // status_i[10:8] – transaction type (high bit)
localparam AIT_LO     = 12;  // status_i[15:12] – address/info type (low  bit)
localparam AIT_HI     = 15;  // status_i[15:12] – address/info type (high bit)
localparam RDIP_BIT   = 23;  // status_i[23] – read-in-progress
localparam EC_LO      = 24;  // status_i[31:24] – error code (low  bit)
localparam EC_HI      = 31;  // status_i[31:24] – error code (high bit)

// ========= AHB register addresses (RERI Table 2) =========
// Header
localparam AHB_VENDOR    = 32'h0000_0000;  // vendor_n_imp_id[31:0]
localparam AHB_IMP       = 32'h0000_0004;  // vendor_n_imp_id[63:32]
localparam BANK_INFO_ADDR = 32'h0000_0008; // bank_info[31:0]
localparam BANK_INFO_HI   = 32'h0000_000C; // bank_info[63:32]
localparam VALID_SUM_ADDR = 32'h0000_0010; // valid_summary[31:0]  (sv at bit0, recs at bits[N+1:1])
localparam VALID_SUM_HI   = 32'h0000_0014; // valid_summary[63:32]

// Per-record i: base = 0x40 + 0x40*i
//   control_i[31:0]  at base+0x00  (else/cece/ces/ueds/uecs)
//   control_i[63:32] at base+0x04  (eid; sinv/srdp WO)
//   status_i[31:0]   at base+0x08
//   status_i[63:32]  at base+0x0C  (cec at [31:16], saturating CE count)
//   addr_info_i[31:0] at base+0x10
function automatic [31:0] CONTROL_ADDR(input integer k);
    return 32'h40 + (k * 64);           // base + 0x00
endfunction
function automatic [31:0] CONTROL_HI_ADDR(input integer k);
    return 32'h44 + (k * 64);           // base + 0x04 (eid/sinv/srdp)
endfunction
function automatic [31:0] STATUS_ADDR(input integer k);
    return 32'h48 + (k * 64);           // base + 0x08
endfunction
function automatic [31:0] STATUS_HI_ADDR(input integer k);
    return 32'h4C + (k * 64);           // base + 0x0C (rdip)
endfunction
function automatic [31:0] ADDRINFO_ADDR(input integer k);
    return 32'h50 + (k * 64);           // base + 0x10
endfunction
// cec (CE count) is at status_i[63:32] bits[31:16] = STATUS_HI_ADDR, rdata[31:16]
// ========================================================================

logic        clk, rst_n;

// ecc_monitor inputs
logic        fetch_ce;
logic        lsu_ce;
logic        lsu_uce;
logic        pipe_uce;
logic [31:0] fetch_addr;
logic [31:0] lsu_addr;

// ecc_monitor flat outputs (match ecc_monitor port list)
logic [N_REC-1:0]        fault_valid;
logic [N_REC-1:0]        fault_ce_bus;
logic [N_REC-1:0]        fault_ued_bus;
logic [N_REC-1:0]        fault_uec_bus;
logic [N_REC-1:0][7:0]   fault_ec_bus;
logic [N_REC-1:0][1:0]   fault_pri_bus;
logic [N_REC-1:0]        fault_c_bus;
logic [N_REC-1:0][3:0]   fault_ait_bus;
logic [N_REC-1:0][31:0]  fault_addr_bus;
logic [N_REC-1:0][2:0]   fault_tt_bus;

// Packed struct array connecting ecc_monitor outputs to reri_error_bank
// Assigned as a single packed concatenation (MSB→LSB order matches struct declaration):
//   valid, ce, ued, uec, ec[7:0], pri[1:0], c, ait[3:0], addr[31:0], tt[2:0]
fault_record_t fault_in_arr [N_REC];
generate
    for (genvar g = 0; g < N_REC; g++) begin : gen_fault_pack
        assign fault_in_arr[g] = {
            fault_valid[g],
            fault_ce_bus[g],
            fault_ued_bus[g],
            fault_uec_bus[g],
            fault_ec_bus[g],
            fault_pri_bus[g],
            fault_c_bus[g],
            fault_ait_bus[g],
            fault_addr_bus[g],
            fault_tt_bus[g]
        };
    end
endgenerate

// AHB-Lite signals to reri_error_bank
logic [31:0] haddr;
logic [2:0]  hsize;
logic [1:0]  htrans;
logic        hwrite;
logic        hsel;
logic [2:0]  hburst;
logic        hmastlock;
logic [3:0]  hprot;
logic [5:0]  hparity;
logic [31:0] hwdata;
logic [31:0] hrdata;
logic        hreadyout;
logic        hresp;

// RAS outputs
logic ras_lo, ras_hi, ras_plat;

// ========================================================================
// DUT instantiation
// ========================================================================
ecc_monitor #(.N_RECORDS(N_REC)) dut_mon (
    .clk             (clk),
    .rst_n           (rst_n),
    .fetch_ce_i      (fetch_ce),
    .lsu_ce_i        (lsu_ce),
    .lsu_uce_i       (lsu_uce),
    .pipeline_uce_i  (pipe_uce),
    .fetch_addr_i    (fetch_addr),
    .lsu_addr_i      (lsu_addr),
    .fault_valid_o   (fault_valid),
    .fault_ce_o      (fault_ce_bus),
    .fault_ued_o     (fault_ued_bus),
    .fault_uec_o     (fault_uec_bus),
    .fault_ec_o      (fault_ec_bus),
    .fault_pri_o     (fault_pri_bus),
    .fault_c_o       (fault_c_bus),
    .fault_ait_o     (fault_ait_bus),
    .fault_addr_o    (fault_addr_bus),
    .fault_tt_o      (fault_tt_bus)
);

reri_error_bank #(
    .N_RECORDS  (N_REC),
    .IFP        (0),
    .VENDOR_ID  (VENDOR_ID),
    .IMP_ID     (IMP_ID),
    .INST_ID    (INST_ID),
    .LAYOUT     (LAYOUT),
    .VERSION    (VERSION)
) dut_bank (
    .clk         (clk),
    .rst_n       (rst_n),
    .haddr       (haddr),
    .hsize       (hsize),
    .htrans      (htrans),
    .hwrite      (hwrite),
    .hsel        (hsel),
    .hburst      (hburst),
    .hmastlock   (hmastlock),
    .hprot       (hprot),
    .hparity     (hparity),
    .hwdata      (hwdata),
    .hrdata      (hrdata),
    .hreadyout   (hreadyout),
    .hresp       (hresp),
    .fault_in    (fault_in_arr),
    .ras_lo      (ras_lo),
    .ras_hi      (ras_hi),
    .ras_plat    (ras_plat)
);

// ========================================================================
// Clock
// ========================================================================
initial clk = 1'b0;
always  #5 clk = ~clk;

// ========================================================================
// Scoreboard / pass-fail counter
// ========================================================================
integer pass_cnt, fail_cnt;

// Check macro: compare got vs. exp; print result
`define CHECK(NAME, GOT, EXP) \
    begin \
        if ((GOT) === (EXP)) begin \
            $display("[PASS] %0t  %-35s  got=%0h", $time, NAME, GOT); \
            pass_cnt++; \
        end else begin \
            $display("[FAIL] %0t  %-35s  got=%0h  exp=%0h", $time, NAME, GOT, EXP); \
            fail_cnt++; \
        end \
    end

// ========================================================================
// AHB helper tasks
// AHB-Lite: address phase on cycle N, data sampled on cycle N+1.
// hreadyout is always 1 here so no stall loop needed.
// ========================================================================

// Drive AHB address phase on next rising edge, wait for data phase
task automatic ahb_read(input logic [31:0] addr, output logic [31:0] data);
    begin
        @(negedge clk);
        haddr  = addr;
        htrans = 2'b10;  // NONSEQ
        hwrite = 1'b0;
        hsize  = 3'b010; // 32-bit
        hsel   = 1'b1;
        @(posedge clk);  // address phase registered inside DUT
        @(negedge clk);
        htrans = 2'b00;  // IDLE
        hsel   = 1'b0;
        haddr  = 32'h0;
        @(posedge clk);  // data phase combinational output valid
        data = hrdata;
    end
endtask

task automatic ahb_write(input logic [31:0] addr, input logic [31:0] data);
    begin
        @(negedge clk);
        haddr  = addr;
        htrans = 2'b10;  // NONSEQ
        hwrite = 1'b1;
        hsize  = 3'b010;
        hsel   = 1'b1;
        @(posedge clk);  // address phase registered
        @(negedge clk);
        hwdata = data;
        htrans = 2'b00;
        hsel   = 1'b0;
        haddr  = 32'h0;
        hwrite = 1'b0;
        @(posedge clk);  // data phase DUT registers write on this edge
    end
endtask

// Clear all fault stimulus
task automatic clear_faults();
    begin
        fetch_ce   = 1'b0;
        lsu_ce     = 1'b0;
        lsu_uce    = 1'b0;
        pipe_uce   = 1'b0;
        fetch_addr = 32'h0;
        lsu_addr   = 32'h0;
    end
endtask

// Enable record k for logging+signaling:
//   control_i[0]:else=1, ces=01(lo), ueds=01(lo), uecs=01(lo), cece=0
//   Written value: {24'b0, 01(uecs), 01(ueds), 01(ces), 0(cece), 1(else)} = 0x55
task automatic enable_record(input integer k);
    ahb_write(CONTROL_ADDR(k), 32'h0000_0055);
endtask

// Enable record k with cece=1 (CE counter enabled):
//   {24'b0, 01(uecs), 01(ueds), 01(ces), 1(cece), 1(else)} = 0x57
task automatic enable_record_cece(input integer k);
    ahb_write(CONTROL_ADDR(k), 32'h0000_0057);
endtask

// Enable record k with all signaling at hi-priority (ces=10, ueds=10, uecs=10):
//   {24'b0, 10(uecs), 10(ueds), 10(ces), 0(cece), 1(else)} = 0xA9
task automatic enable_record_hi(input integer k);
    ahb_write(CONTROL_ADDR(k), 32'h0000_00A9);
endtask

// Enable record k with all signaling at platform-specific (ces=11, ueds=11, uecs=11):
//   {24'b0, 11(uecs), 11(ueds), 11(ces), 0(cece), 1(else)} = 0xFD
task automatic enable_record_plat(input integer k);
    ahb_write(CONTROL_ADDR(k), 32'h0000_00FD);
endtask

// addr_info_i[63:32]: word 5 of per-record block (base+0x14)
function automatic [31:0] ADDRINFO_HI_ADDR(input integer k);
    return 32'h54 + (k * 64);           // base + 0x14
endfunction

// info_i[31:0]: word 6 of per-record block (base+0x18) — always 0
function automatic [31:0] INFO_ADDR(input integer k);
    return 32'h58 + (k * 64);
endfunction

// Clear a record via sinv: write srdp+sinv simultaneously to control_i[63:32]
//   srdp = bit17, sinv = bit16 a 0x0003_0000
//   rdip is set by srdp, then valid is cleared by sinv (spec Â§2.3.3)
task automatic sinv_clear(input integer k);
    ahb_write(CONTROL_HI_ADDR(k), 32'h0003_0000);
endtask

// Pulse a single clock with all faults cleared
task automatic idle(input integer n);
    repeat (n) @(posedge clk);
endtask

// ========================================================================
// Main test sequence
// ========================================================================
logic [31:0] rdata;
logic [31:0] estatus;
integer tc20_before, tc20_after, tc20_remaining;

initial begin
    pass_cnt = 0;
    fail_cnt = 0;

    // Initialise AHB and fault signals
    haddr     = 32'h0;
    hsize     = 3'b010;
    htrans    = 2'b00;
    hwrite    = 1'b0;
    hsel      = 1'b0;
    hburst    = 3'b000;
    hmastlock = 1'b0;
    hprot     = 4'b0000;
    hparity   = 6'b0;
    hwdata    = 32'h0;
    clear_faults();

    // Reset 
    rst_n = 1'b0;
    repeat (4) @(posedge clk);
    @(negedge clk);
    rst_n = 1'b1;
    idle(2);

    // ================================================================
    // TC01: After reset all RAS deasserted, all records invalid,
    //       control_i.else=0 (fault capture disabled by default)
    // ================================================================
    $display("\n------ TC01: Reset state ------");
    `CHECK("TC01 ras_lo==0",            ras_lo,   1'b0)
    `CHECK("TC01 ras_hi==0",            ras_hi,   1'b0)
    `CHECK("TC01 ras_plat==0",          ras_plat, 1'b0)
    ahb_read(STATUS_ADDR(0), rdata);
    `CHECK("TC01 rec0 valid==0",        rdata[VALID_BIT], 1'b0)
    ahb_read(STATUS_ADDR(1), rdata);
    `CHECK("TC01 rec1 valid==0",        rdata[VALID_BIT], 1'b0)
    ahb_read(STATUS_ADDR(2), rdata);
    `CHECK("TC01 rec2 valid==0",        rdata[VALID_BIT], 1'b0)
    ahb_read(CONTROL_ADDR(0), rdata);
    `CHECK("TC01 rec0 else==0 at reset", rdata[0], 1'b0)

    // ================================================================
    // TC02: Fault capture requires else=1
    //   (a) else=0: fetch CE presented at NOT captured
    //   (b) enable_record(0) at else=1 at same fault captured, ras_lo asserted
    // ================================================================
    $display("\n------ TC02: else gate and fetch CE capture ------");

    // (a) else=0 present fault, nothing should be captured
    @(negedge clk);
    fetch_ce   = 1'b1;
    fetch_addr = 32'hDEAD_0100;
    @(posedge clk);
    @(negedge clk);
    fetch_ce   = 1'b0;
    fetch_addr = 32'h0;
    idle(1);

    ahb_read(STATUS_ADDR(0), rdata);
    `CHECK("TC02a rec0 not captured when else=0",  rdata[VALID_BIT], 1'b0)
    `CHECK("TC02a ras_lo==0 (else=0)",             ras_lo,           1'b0)

    // (b) enable record 0 then inject fetch CE
    // enable_record: else=1, cece=0, ces=01(lo), ueds=01(lo), uecs=01(lo) = 0x55
    enable_record(0);
    @(negedge clk);
    fetch_ce   = 1'b1;
    fetch_addr = 32'hDEAD_0100;
    @(posedge clk);
    @(negedge clk);
    fetch_ce   = 1'b0;
    fetch_addr = 32'h0;
    idle(1);

    `CHECK("TC02b ras_lo==1 (CE via ces=01)",  ras_lo,   1'b1)
    `CHECK("TC02b ras_hi==0",                  ras_hi,   1'b0)
    `CHECK("TC02b ras_plat==0",                ras_plat, 1'b0)

    ahb_read(STATUS_ADDR(0), estatus);
    `CHECK("TC02b rec0 valid",              estatus[VALID_BIT],     1'b1)
    `CHECK("TC02b rec0 ce",                 estatus[CE_BIT],        1'b1)
    `CHECK("TC02b rec0 uec==0",             estatus[UEC_BIT],       1'b0)
    `CHECK("TC02b rec0 ec==0x11",           estatus[EC_HI:EC_LO],   8'h11)
    `CHECK("TC02b rec0 pri==1",             estatus[PRI_HI:PRI_LO], 2'b01)
    `CHECK("TC02b rec0 tt==110(ifetch)",    estatus[TT_HI:TT_LO],   3'b110)
    `CHECK("TC02b rec0 containable",        estatus[C_BIT],         1'b1)

    ahb_read(ADDRINFO_ADDR(0), rdata);
    `CHECK("TC02b rec0 addr",               rdata, 32'hDEAD_0100)

    // control_i[0] reads else back (=1); ces field reads back 01
    ahb_read(CONTROL_ADDR(0), rdata);
    `CHECK("TC02b rec0 control else==1",    rdata[0],   1'b1)
    `CHECK("TC02b rec0 control ces==01",    rdata[3:2], 2'b01)

    // ================================================================
    // TC03: LSU CE at record 1 captured, ras_lo stays asserted
    // ================================================================
    $display("\n------ TC03: LSU CE capture ------");
    enable_record(1);
    @(negedge clk);
    lsu_ce   = 1'b1;
    lsu_addr = 32'hCAFE_0200;
    @(posedge clk);
    @(negedge clk);
    lsu_ce   = 1'b0;
    lsu_addr = 32'h0;
    idle(1);

    `CHECK("TC03 ras_lo==1",            ras_lo, 1'b1)
    `CHECK("TC03 ras_hi==0",            ras_hi, 1'b0)

    ahb_read(STATUS_ADDR(1), estatus);
    `CHECK("TC03 rec1 valid",           estatus[VALID_BIT],     1'b1)
    `CHECK("TC03 rec1 ce",              estatus[CE_BIT],        1'b1)
    `CHECK("TC03 rec1 ec==0x21",        estatus[EC_HI:EC_LO],   8'h21)
    `CHECK("TC03 rec1 tt==100(ls)",     estatus[TT_HI:TT_LO],   3'b100)

    ahb_read(ADDRINFO_ADDR(1), rdata);
    `CHECK("TC03 rec1 addr",            rdata, 32'hCAFE_0200)

    // ================================================================
    // TC04: LSU UED on record 1 priority 2 > stored 1 at overwrite
    //   After overwrite: rdip=0  (overwrite sets rdip = !r_valid = 0)
    // ================================================================
    $display("\n------ TC04: LSU UED overwrites LSU CE (priority upgrade) ------");
    @(negedge clk);
    lsu_uce  = 1'b1;
    lsu_addr = 32'hBEEF_0300;
    @(posedge clk);
    @(negedge clk);
    lsu_uce  = 1'b0;
    lsu_addr = 32'h0;
    idle(1);

    // UED with ueds=01 at ras_lo
    `CHECK("TC04 ras_lo==1 (UED via ueds=01)", ras_lo, 1'b1)
    `CHECK("TC04 ras_hi==0",                   ras_hi, 1'b0)

    ahb_read(STATUS_ADDR(1), estatus);
    `CHECK("TC04 rec1 valid",           estatus[VALID_BIT],     1'b1)
    `CHECK("TC04 rec1 ued==1",          estatus[UED_BIT],       1'b1)
    `CHECK("TC04 rec1 ce==0",           estatus[CE_BIT],        1'b0)
    `CHECK("TC04 rec1 ec==0x22",        estatus[EC_HI:EC_LO],   8'h22)
    `CHECK("TC04 rec1 pri==2",          estatus[PRI_HI:PRI_LO], 2'b10)
    `CHECK("TC04 rec1 containable==0",  estatus[C_BIT],         1'b0)

    ahb_read(ADDRINFO_ADDR(1), rdata);
    `CHECK("TC04 rec1 addr updated",    rdata, 32'hBEEF_0300)

    // ================================================================
    // TC05: Pipeline UEC at record 2 captured, ras_lo asserted (uecs=01)
    // ================================================================
    $display("\n------ TC05: Pipeline UEC capture ------");
    enable_record(2);
    @(negedge clk);
    pipe_uce = 1'b1;
    @(posedge clk);
    @(negedge clk);
    pipe_uce = 1'b0;
    idle(1);

    // UEC with uecs=01 at ras_lo
    `CHECK("TC05 ras_lo==1 (UEC via uecs=01)", ras_lo, 1'b1)
    `CHECK("TC05 ras_hi==0",                   ras_hi, 1'b0)

    ahb_read(STATUS_ADDR(2), estatus);
    `CHECK("TC05 rec2 valid",           estatus[VALID_BIT],     1'b1)
    `CHECK("TC05 rec2 uec==1",          estatus[UEC_BIT],       1'b1)
    `CHECK("TC05 rec2 ec==0x41",        estatus[EC_HI:EC_LO],   8'h41)
    `CHECK("TC05 rec2 pri==3",          estatus[PRI_HI:PRI_LO], 2'b11)
    `CHECK("TC05 rec2 containable==0",  estatus[C_BIT],         1'b0)

    ahb_read(ADDRINFO_ADDR(2), rdata);
    `CHECK("TC05 rec2 addr==0 (no addr)",  rdata, 32'h0)

    // ================================================================
    // TC06: AHB identification registers (RERI Table 2 header)
    //   All 3 records now valid; valid_summary sv=bit[0]=1, rec[k]=bit[k+1]
    // ================================================================
    $display("\n------ TC06: AHB header registers ------");
    ahb_read(AHB_VENDOR, rdata);
    `CHECK("TC06 VENDOR_ID",                   rdata,      VENDOR_ID)
    ahb_read(AHB_IMP, rdata);
    `CHECK("TC06 IMP_ID",                      rdata,      IMP_ID)
    ahb_read(BANK_INFO_ADDR, rdata);
    `CHECK("TC06 bank_info[31:0]",             rdata,      BANK_INFO_LO_EXP)
    ahb_read(BANK_INFO_HI, rdata);
    `CHECK("TC06 bank_info[63:32]",            rdata,      BANK_INFO_HI_EXP)

    // sv=bit[0]=1, rec0=bit[1]=1, rec1=bit[2]=1, rec2=bit[3]=1 at [3:0]=4'hF
    ahb_read(VALID_SUM_ADDR, rdata);
    `CHECK("TC06 valid_summary sv==1",         rdata[0],   1'b1)
    `CHECK("TC06 valid_summary recs[2:0]==111", rdata[3:1], 3'b111)
    `CHECK("TC06 valid_summary[31:4]==0",      rdata[31:4], 28'h0)

    // ================================================================
    // TC07: AHB read of unmapped address returns 0
    // ================================================================
    $display("\n------ TC07: AHB unmapped address returns 0 ------");
    ahb_read(32'hFFFF_FF00, rdata);
    `CHECK("TC07 unmapped==0", rdata, 32'h0)

    // ================================================================
    // TC08: Software clear via sinv+srdp
    //   Record 0 rdip=1 from TC02b first capture.
    //   sinv_clear(0): srdp ensures rdip=1; sinv sees rdip=1 at clears valid.
    //   Control fields (else, ces, etc.) are preserved.
    // ================================================================
    $display("\n------ TC08: sinv+srdp clears record 0 ------");
    sinv_clear(0);
    idle(2);

    ahb_read(STATUS_ADDR(0), estatus);
    `CHECK("TC08 rec0 valid==0 after clear",    estatus[VALID_BIT], 1'b0)
    // Records 1 (UED) and 2 (UEC) still valid at ras_lo stays
    `CHECK("TC08 ras_lo still==1",              ras_lo,   1'b1)
    `CHECK("TC08 ras_hi==0",                    ras_hi,   1'b0)
    // else field on record 0 preserved (sinv_clear only writes word 1)
    ahb_read(CONTROL_ADDR(0), rdata);
    `CHECK("TC08 rec0 else still==1 after clear", rdata[0], 1'b1)

    // ================================================================
    // TC09: Priority arbitration lower/equal priority fault cannot overwrite
    // ================================================================
    $display("\n------ TC09: Priority arbitration ------");
    // Record 0 is now empty at fetch CE captures there
    @(negedge clk);
    fetch_ce   = 1'b1;
    fetch_addr = 32'hAAAA_BBBB;
    @(posedge clk);
    @(negedge clk);
    fetch_ce   = 1'b0;
    fetch_addr = 32'h0;
    idle(1);

    ahb_read(STATUS_ADDR(0), estatus);
    `CHECK("TC09 rec0 re-captured",        estatus[VALID_BIT],     1'b1)
    `CHECK("TC09 rec0 ec==0x11",           estatus[EC_HI:EC_LO],   8'h11)
    ahb_read(ADDRINFO_ADDR(0), rdata);
    `CHECK("TC09 rec0 addr==AAAA_BBBB",    rdata, 32'hAAAA_BBBB)

    // Record 2 still holds pipeline UEC (pri=3), unaffected
    ahb_read(STATUS_ADDR(2), estatus);
    `CHECK("TC09 rec2 uec unchanged",      estatus[UEC_BIT],       1'b1)
    `CHECK("TC09 rec2 pri==3",             estatus[PRI_HI:PRI_LO], 2'b11)

    // Same-priority fetch CE (pri=1) while rec0 occupied at pri=1 at no overwrite
    @(negedge clk);
    fetch_ce   = 1'b1;
    fetch_addr = 32'hDEAD_BEEF;
    @(posedge clk);
    @(negedge clk);
    fetch_ce   = 1'b0;
    idle(1);

    ahb_read(ADDRINFO_ADDR(0), rdata);
    `CHECK("TC09 rec0 addr NOT overwritten (same pri)", rdata, 32'hAAAA_BBBB)

    // ================================================================
    // TC10: Overflow ras_plat asserted while a fault cannot be stored
    //   All 3 records valid; fetch CE (pri=1) to rec0 (pri=1): pri not > stored
    //   at no capture at combinational ras_plat
    // ================================================================
    $display("\n------ TC10: Overflow at ras_plat ------");
    @(negedge clk);
    fetch_ce = 1'b1;        // rec0 full at same priority at overflow
    @(posedge clk);
    #1;                     // wait for combinational to settle
    `CHECK("TC10 ras_plat==1 on overflow",        ras_plat, 1'b1)
    @(negedge clk);
    fetch_ce = 1'b0;
    idle(1);
    `CHECK("TC10 ras_plat==0 when fault removed", ras_plat, 1'b0)

    // ================================================================
    // TC11: sinv alone (hwdata[16]=1, hwdata[17]=0) with rdip=0 does NOT clear
    //   Record 1 rdip=0 after TC04 overwrite
    //   (overwrite sets rdip = !r_valid = !1 = 0)
    // ================================================================
    $display("\n------ TC11: sinv alone with rdip=0 does not clear ------");
    // Write only sinv (bit16=1), no srdp (bit17=0) at 0x0001_0000
    ahb_write(CONTROL_HI_ADDR(1), 32'h0001_0000);
    idle(2);

    ahb_read(STATUS_ADDR(1), estatus);
    `CHECK("TC11 rec1 still valid (sinv needs rdip=1)", estatus[VALID_BIT], 1'b1)

    // ================================================================
    // TC12: sinv+srdp (sinv_clear) clears record 1; then re-inject
    // ================================================================
    $display("\n------ TC12: sinv+srdp clear then re-inject record 1 ------");
    sinv_clear(1);
    idle(2);

    ahb_read(STATUS_ADDR(1), estatus);
    `CHECK("TC12 rec1 valid==0 after sinv_clear",  estatus[VALID_BIT], 1'b0)

    // Re-inject LSU CE into cleared slot
    @(negedge clk);
    lsu_ce   = 1'b1;
    lsu_addr = 32'hFEED_FACE;
    @(posedge clk);
    @(negedge clk);
    lsu_ce   = 1'b0;
    lsu_addr = 32'h0;
    idle(1);

    ahb_read(STATUS_ADDR(1), estatus);
    `CHECK("TC12 rec1 re-valid",        estatus[VALID_BIT],   1'b1)
    `CHECK("TC12 rec1 ce==1",           estatus[CE_BIT],      1'b1)
    `CHECK("TC12 rec1 ec==0x21",        estatus[EC_HI:EC_LO], 8'h21)
    ahb_read(ADDRINFO_ADDR(1), rdata);
    `CHECK("TC12 rec1 addr re-captured", rdata, 32'hFEED_FACE)

    // ================================================================
    // TC13: valid_summary tracks record state changes
    //   State: rec0=valid, rec1=valid, rec2=valid at [3:0]=4'hF
    //   sv (bit[0]) is always 1; rec k at bit[k+1]
    // ================================================================
    $display("\n------ TC13: valid_summary tracking ------");
    ahb_read(VALID_SUM_ADDR, rdata);
    `CHECK("TC13 valid_summary[3:0]==4hF (all valid)", rdata[3:0], 4'hF)
    `CHECK("TC13 valid_summary[31:4]==0",              rdata[31:4], 28'h0)

    sinv_clear(2);  // clear rec2
    idle(2);
    ahb_read(VALID_SUM_ADDR, rdata);
    // rec2(bit3)=0, rec1(bit2)=1, rec0(bit1)=1, sv(bit0)=1 at 4'h7
    `CHECK("TC13 valid_summary==4h7 after rec2 clear", rdata[3:0], 4'h7)
    `CHECK("TC13 ras_lo still==1 (recs 0,1 valid)",    ras_lo,     1'b1)

    sinv_clear(0);  // clear rec0
    idle(2);
    ahb_read(VALID_SUM_ADDR, rdata);
    // rec2(bit3)=0, rec1(bit2)=1, rec0(bit1)=0, sv(bit0)=1 at 4'h5
    `CHECK("TC13 valid_summary==4h5 after rec0 clear", rdata[3:0], 4'h5)

    // ================================================================
    // TC14: else=0 disables fault capture; else=1 re-enables it
    //   State: rec0=invalid, rec1=valid(ce), rec2=invalid
    // ================================================================
    $display("\n------ TC14: else gate disable/re-enable ------");
    // Disable record 0: write 0 at else=0, all signaling fields zeroed
    ahb_write(CONTROL_ADDR(0), 32'h0000_0000);
    @(negedge clk);
    fetch_ce   = 1'b1;
    fetch_addr = 32'hBBAA_0001;
    @(posedge clk);
    @(negedge clk);
    fetch_ce   = 1'b0;
    fetch_addr = 32'h0;
    idle(1);

    ahb_read(STATUS_ADDR(0), rdata);
    `CHECK("TC14 rec0 not captured when else=0", rdata[VALID_BIT], 1'b0)

    // Re-enable: else=1
    ahb_write(CONTROL_ADDR(0), 32'h0000_0055);
    @(negedge clk);
    fetch_ce   = 1'b1;
    fetch_addr = 32'hBBAA_0002;
    @(posedge clk);
    @(negedge clk);
    fetch_ce   = 1'b0;
    fetch_addr = 32'h0;
    idle(1);

    ahb_read(STATUS_ADDR(0), rdata);
    `CHECK("TC14 rec0 captured after else=1 re-enable", rdata[VALID_BIT], 1'b1)
    ahb_read(ADDRINFO_ADDR(0), rdata);
    `CHECK("TC14 rec0 addr from enabled inject",         rdata, 32'hBBAA_0002)

    // ================================================================
    // TC15: ECOUNT CE counter increments only when cece=1
    //   Also verifies CE does NOT fire RAS via ces when cece=1.
    //   Clear rec0 and rec1 first so ras_lo is fully isolated.
    //   (ecount[0] is 0: cece was 0 for all prior rec0 captures)
    // ================================================================
    $display("\n------ TC15: ECOUNT with cece=1 ------");
    sinv_clear(0);  // rec0 invalid; r_ecount[0] persists but was 0 (cece=0 before)
    sinv_clear(1);  // rec1 invalid; now no valid records at ras_lo baseline=0
    idle(2);

    ahb_read(STATUS_HI_ADDR(0), rdata);
    `CHECK("TC15 cec[0]==0 before first cece capture", rdata[31:16], 16'h0)

    // Enable with cece=1: else=1, cece=1, ces=01, ueds=01, uecs=01 = 0x57
    enable_record_cece(0);

    // First CE injection
    @(negedge clk);
    fetch_ce   = 1'b1;
    fetch_addr = 32'hEC00_0001;
    @(posedge clk);
    @(negedge clk);
    fetch_ce   = 1'b0;
    fetch_addr = 32'h0;
    idle(1);

    // With cece=1, CE does NOT fire RAS via ces (only counted, not signalled)
    // (rec1 and rec2 are both invalid so no other source of ras_lo)
    `CHECK("TC15 ras_lo==0 (cece=1 suppresses CE RAS)", ras_lo, 1'b0)
    ahb_read(STATUS_HI_ADDR(0), rdata);
    `CHECK("TC15 cec[0]==1 after first CE",              rdata[31:16], 16'h1)

    // Second CE: clear valid (preserves cece=1), re-inject at counter++
    sinv_clear(0);  // clears only r_valid; r_cece[0]=1 and r_ecount[0]=1 preserved
    idle(1);
    @(negedge clk);
    fetch_ce   = 1'b1;
    fetch_addr = 32'hEC00_0002;
    @(posedge clk);
    @(negedge clk);
    fetch_ce   = 1'b0;
    fetch_addr = 32'h0;
    idle(1);

    ahb_read(STATUS_HI_ADDR(0), rdata);
    `CHECK("TC15 cec[0]==2 after second CE",             rdata[31:16], 16'h2)

    // Disable cece (write 0x55 = cece=0): CE fires RAS but counter does NOT increment
    sinv_clear(0);
    enable_record(0);   // cece=0 now
    @(negedge clk);
    fetch_ce = 1'b1;
    @(posedge clk);
    @(negedge clk);
    fetch_ce = 1'b0;
    idle(1);

    `CHECK("TC15 ras_lo==1 when cece=0 (CE fires RAS)",     ras_lo, 1'b1)
    ahb_read(STATUS_HI_ADDR(0), rdata);
    `CHECK("TC15 cec[0] unchanged==2 when cece=0",          rdata[31:16], 16'h2)

    // ================================================================
    // TC16: rdip set on first capture, readable via status_i[63:32] bit[24]
    //   rec0 was just first-captured in TC15 (cece=0 segment above)
    // ================================================================
    $display("\n------ TC16: rdip tracking ------");
    ahb_read(STATUS_ADDR(0), rdata);
    `CHECK("TC16 rec0 rdip==1 after first capture", rdata[RDIP_BIT], 1'b1)

    // After sinv_clear + re-inject at rdip=1 again (new first-capture)
    sinv_clear(0);
    idle(1);
    @(negedge clk);
    fetch_ce = 1'b1;
    @(posedge clk);
    @(negedge clk);
    fetch_ce = 1'b0;
    idle(1);

    ahb_read(STATUS_ADDR(0), rdata);
    `CHECK("TC16 rec0 rdip==1 after new first-capture", rdata[RDIP_BIT], 1'b1)

    // sinv_clear sets rdip=1 via srdp; no-capture (else=0) leaves rdip unchanged
    sinv_clear(0);
    ahb_write(CONTROL_ADDR(0), 32'h0000_0000); // else=0
    @(negedge clk);
    fetch_ce = 1'b1;
    @(posedge clk);
    @(negedge clk);
    fetch_ce = 1'b0;
    idle(1);

    ahb_read(STATUS_ADDR(0), rdata);
    // rdip was set by srdp in sinv_clear and is NOT cleared by a no-capture event
    `CHECK("TC16 rdip==1 stays (no-capture leaves rdip from srdp)", rdata[RDIP_BIT], 1'b1)

    // ================================================================
    // TC17: RAS level selection for CE via ces field
    //   ces=10 (hi-priority) -> ras_hi=1, ras_lo=0, ras_plat=0
    //   ces=11 (platform)    -> ras_plat=1, ras_lo=0, ras_hi=0
    // ================================================================
    $display("\n------ TC17: RAS level via ces=10 and ces=11 ------");
    // Clear all valid records first
    sinv_clear(0); sinv_clear(1); sinv_clear(2);
    idle(2);
    `CHECK("TC17 baseline ras_lo==0",   ras_lo,   1'b0)
    `CHECK("TC17 baseline ras_hi==0",   ras_hi,   1'b0)
    `CHECK("TC17 baseline ras_plat==0", ras_plat, 1'b0)

    // ces=10 (hi): enable_record_hi sets ces=2'b10
    enable_record_hi(0);
    @(negedge clk);
    fetch_ce   = 1'b1;
    fetch_addr = 32'hCE17_0001;
    @(posedge clk);
    @(negedge clk);
    fetch_ce   = 1'b0; fetch_addr = 32'h0;
    idle(1);

    `CHECK("TC17 ces=10 ras_hi==1",   ras_hi,   1'b1)
    `CHECK("TC17 ces=10 ras_lo==0",   ras_lo,   1'b0)
    `CHECK("TC17 ces=10 ras_plat==0", ras_plat, 1'b0)

    sinv_clear(0); idle(1);
    `CHECK("TC17 ras_hi==0 after clear", ras_hi, 1'b0)

    // ces=11 (plat): enable_record_plat sets ces=2'b11
    enable_record_plat(0);
    @(negedge clk);
    fetch_ce   = 1'b1;
    fetch_addr = 32'hCE17_0002;
    @(posedge clk);
    @(negedge clk);
    fetch_ce   = 1'b0; fetch_addr = 32'h0;
    idle(1);

    `CHECK("TC17 ces=11 ras_plat==1", ras_plat, 1'b1)
    `CHECK("TC17 ces=11 ras_lo==0",   ras_lo,   1'b0)
    `CHECK("TC17 ces=11 ras_hi==0",   ras_hi,   1'b0)

    sinv_clear(0); idle(1);

    // ================================================================
    // TC18: RAS level selection for UED/UEC via ueds/uecs fields
    //   ueds=10 -> ras_hi=1; uecs=11 -> ras_plat=1
    // ================================================================
    $display("\n------ TC18: RAS level via ueds=10 and uecs=11 ------");
    // Enable rec1: ueds=10, uecs=10, ces=10, cece=0, else=1 = 0xA9
    enable_record_hi(1);
    @(negedge clk);
    lsu_uce  = 1'b1;         // LSU UCE -> UED on record 1
    lsu_addr = 32'hED18_0001;
    @(posedge clk);
    @(negedge clk);
    lsu_uce  = 1'b0; lsu_addr = 32'h0;
    idle(1);

    ahb_read(STATUS_ADDR(1), estatus);
    `CHECK("TC18 rec1 ued==1",        estatus[UED_BIT], 1'b1)
    `CHECK("TC18 ueds=10 ras_hi==1",  ras_hi,           1'b1)
    `CHECK("TC18 ueds=10 ras_lo==0",  ras_lo,           1'b0)
    `CHECK("TC18 ueds=10 ras_plat==0",ras_plat,         1'b0)

    sinv_clear(1); idle(1);

    // Enable rec2: uecs=11, ueds=11, ces=11, cece=0, else=1 = 0xFD
    enable_record_plat(2);
    @(negedge clk);
    pipe_uce = 1'b1;         // pipeline UCE -> UEC on record 2
    @(posedge clk);
    @(negedge clk);
    pipe_uce = 1'b0;
    idle(1);

    ahb_read(STATUS_ADDR(2), estatus);
    `CHECK("TC18 rec2 uec==1",         estatus[UEC_BIT], 1'b1)
    `CHECK("TC18 uecs=11 ras_plat==1", ras_plat,         1'b1)
    `CHECK("TC18 uecs=11 ras_lo==0",   ras_lo,           1'b0)
    `CHECK("TC18 uecs=11 ras_hi==0",   ras_hi,           1'b0)

    sinv_clear(2); idle(1);

    // ================================================================
    // TC19: eid countdown injection
    //   Write eid=3 to a fresh record; after 3 decrements r_valid forces to 1.
    //   RAS is generated once valid is set (record 1, ces=01 -> ras_lo)
    // ================================================================
    $display("\n------ TC19: eid countdown injection ------");
    enable_record(1);  // else=1, ces=01(lo)
    // Write eid=10 to control_i[63:32] bits[15:0].
    // eid starts decrementing the cycle the write is registered;
    // read back after AHB pipeline latency to confirm it is nonzero (i.e. counting).
    ahb_write(CONTROL_HI_ADDR(1), 32'h0000_000A);
    ahb_read(CONTROL_HI_ADDR(1), rdata);
    `CHECK("TC19 eid nonzero (decrement active)", (rdata[15:0] != 16'h0), 1'b1)

    // Wait for eid to reach 0 (was 10 - ~3 clocks of pipeline = ~7 remaining)
    idle(10);

    ahb_read(STATUS_ADDR(1), rdata);
    `CHECK("TC19 rec1 valid==1 after eid countdown", rdata[VALID_BIT], 1'b1)
    `CHECK("TC19 ras_lo==1 after eid injection",      ras_lo,           1'b1)

    // eid itself should now read 0 (countdown finished)
    ahb_read(CONTROL_HI_ADDR(1), rdata);
    `CHECK("TC19 eid==0 after countdown", rdata[15:0], 16'h0)

    sinv_clear(1); idle(1);

    // ================================================================
    // TC20: ecount saturation at 0xFFFF
    //   Pre-load r_ecount[0] to 0xFFFE by enabling cece and injecting
    //   two CEs. Then inject one more to reach 0xFFFF, then one more
    //   to confirm it stays at 0xFFFF (no wrap).
    //   We do this by directly writing eid to get multiple captures.
    // ================================================================
    $display("\n------ TC20: ecount saturation at 0xFFFF ------");
    // Clear rec0 state; reset ecount by re-enabling with cece=1 after full reset
    // ecount is never reset except by hardware reset, so we drive it to
    // 0xFFFE by issuing many CE pulses with cece=1.
    // Current r_ecount[0] = 2 from TC15. We need 0xFFFF - 2 = 65533 more.
    // Instead: use a fast loop with eid injection (1 cycle each) to increment.
    // Practical approach: just verify saturation from current value.
    // Set up: rec0 cleared, cece=1, then hammer 65534 - current_count CEs.
    // Since that is too slow in simulation, we test the boundary directly:
    //   Inject (0xFFFF - current) - 1 pulses via eid=1 (1-cycle injection),
    //   keeping the record cleared between each.
    // Simpler: pre-set via a small for-loop using direct fault pulses.

    // First clear rec0 and ensure cece=1
    sinv_clear(0); idle(1);
    enable_record_cece(0); // cece=1

    // Inject enough CEs to bring ecount to 0xFFFE.
    // r_ecount[0] is currently 2 (from TC15 last 0x55 segment did not count,
    // then the cece=1 segment added 2). Need 0xFFFE - 2 = 65532 more pulses.
    // That is too expensive for simulation. Instead, test that ecount starts
    // at its current value and saturates: inject until overshoot.
    //
    // Fast approach: use only a handful of CEs and verify the
    // arithmetic; keep this TC focused on the code path, not the exact count.
    // Specifically: clear rec0 100 times with a CE each time and confirm the
    // counter is monotonically increasing and never wraps below its value.

    ahb_read(STATUS_HI_ADDR(0), rdata);
    tc20_before = rdata[31:16];

    // Inject 5 CEs (clear + inject each time so cece=1 increments counter)
    repeat (5) begin
        sinv_clear(0); idle(1);
        @(negedge clk);
        fetch_ce   = 1'b1;
        fetch_addr = 32'hEC20_0001;
        @(posedge clk);
        @(negedge clk);
        fetch_ce   = 1'b0; fetch_addr = 32'h0;
        idle(1);
    end

    ahb_read(STATUS_HI_ADDR(0), rdata);
    tc20_after = rdata[31:16];
    `CHECK("TC20 ecount incremented by 5", tc20_after, tc20_before + 5)

    // Saturate: inject (0xFFFF - current) + 2 CEs.
    // Use minimal 3-cycle loop (sinv write + fault pulse + 1 idle) to stay
    // within the watchdog. Each clear+capture: 2 AHB cycles for sinv_clear
    // (write addr phase + data phase) + 1 posedge for fault + 1 negedge idle
    // = ~4 clocks = 40 ns. At most 0xFFFF = 65535 iterations, any start
    // point means <=65535 x 40ns ~= 2.6ms. Raise watchdog to 10ms.
    ahb_read(STATUS_HI_ADDR(0), rdata);
    tc20_remaining = 16'hFFFF - rdata[31:16];

    repeat (tc20_remaining + 2) begin
        // Minimal clear: write srdp+sinv directly (1 AHB write)
        ahb_write(CONTROL_HI_ADDR(0), 32'h0003_0000);
        @(negedge clk);
        fetch_ce   = 1'b1;
        fetch_addr = 32'hEC20_FFFF;
        @(posedge clk);
        @(negedge clk);
        fetch_ce   = 1'b0; fetch_addr = 32'h0;
    end
    idle(1);

    ahb_read(STATUS_HI_ADDR(0), rdata);
    `CHECK("TC20 ecount saturated at 0xFFFF", rdata[31:16], 16'hFFFF)

    sinv_clear(0); idle(1);

    // ================================================================
    // TC21: valid_summary[63:32] high word reads 0
    //   N_REC=3 so valid_bitmap entirely fits in [31:0]; upper word is 0.
    // ================================================================
    $display("\n------ TC21: valid_summary[63:32] reads 0 ------");
    // Ensure at least one record is valid so [31:0] is non-zero
    enable_record(0);
    @(negedge clk);
    fetch_ce   = 1'b1;
    fetch_addr = 32'hAA21_0001;
    @(posedge clk);
    @(negedge clk);
    fetch_ce   = 1'b0; fetch_addr = 32'h0;
    idle(1);

    ahb_read(VALID_SUM_ADDR, rdata);
    `CHECK("TC21 valid_summary[31:0] nonzero (rec0 valid)", rdata[1], 1'b1)
    ahb_read(VALID_SUM_HI, rdata);
    `CHECK("TC21 valid_summary[63:32]==0", rdata, 32'h0)

    sinv_clear(0); idle(1);

    // ================================================================
    // TC22: addr_info_i[63:32] (word 5 of record block) always reads 0
    // ================================================================
    $display("\n------ TC22: addr_info_i[63:32] reads 0 ------");
    enable_record(1);
    @(negedge clk);
    lsu_ce   = 1'b1;
    lsu_addr = 32'hAD22_0001;
    @(posedge clk);
    @(negedge clk);
    lsu_ce   = 1'b0; lsu_addr = 32'h0;
    idle(1);

    ahb_read(ADDRINFO_ADDR(1), rdata);
    `CHECK("TC22 addr_info_i[31:0] captured", rdata, 32'hAD22_0001)
    ahb_read(ADDRINFO_HI_ADDR(1), rdata);
    `CHECK("TC22 addr_info_i[63:32]==0",      rdata, 32'h0)

    sinv_clear(1); idle(1);

    // ================================================================
    // TC23: control_i[63:32] sinv/srdp bits always read 0
    //   Write srdp+sinv (0x0003_0000), then read back control_i[63:32].
    //   Bits [17:16] (srdp/sinv) must read as 0 (write-only).
    //   eid bits [15:0] should reflect last written value if no countdown.
    // ================================================================
    $display("\n------ TC23: sinv/srdp bits read 0 ------");
    enable_record(2);
    // Write eid=5 and srdp+sinv together at control_i[63:32]
    ahb_write(CONTROL_HI_ADDR(2), 32'h0003_0005);
    idle(1);
    ahb_read(CONTROL_HI_ADDR(2), rdata);
    `CHECK("TC23 sinv bit[16] reads 0",  rdata[16], 1'b0)
    `CHECK("TC23 srdp bit[17] reads 0",  rdata[17], 1'b0)
    // eid[15:0] was written 5; decrement has started but after 1 idle it is 4
    // Just confirm bits [17:16] are 0 regardless of eid value:
    `CHECK("TC23 bits[31:18] read 0",    rdata[31:18], 14'h0)

    // Disarm the eid countdown before it fires
    ahb_write(CONTROL_HI_ADDR(2), 32'h0000_0000); // eid=0 stops countdown
    sinv_clear(2); idle(1);

    // ================================================================
    // TC24: Simultaneous multi-record fault capture
    //   fetch_ce (rec0) and lsu_ce (rec1) both asserted in the same cycle.
    //   Both records must be captured independently.
    // ================================================================
    $display("\n------ TC24: Simultaneous multi-record fault capture ------");
    enable_record(0);
    enable_record(1);

    @(negedge clk);
    fetch_ce   = 1'b1;
    fetch_addr = 32'hAA24_0001;
    lsu_ce     = 1'b1;
    lsu_addr   = 32'hBB24_0002;
    @(posedge clk);
    @(negedge clk);
    fetch_ce   = 1'b0; fetch_addr = 32'h0;
    lsu_ce     = 1'b0; lsu_addr   = 32'h0;
    idle(1);

    ahb_read(STATUS_ADDR(0), estatus);
    `CHECK("TC24 rec0 valid",         estatus[VALID_BIT],   1'b1)
    `CHECK("TC24 rec0 ce",            estatus[CE_BIT],      1'b1)
    `CHECK("TC24 rec0 ec==0x11",      estatus[EC_HI:EC_LO], 8'h11)
    ahb_read(ADDRINFO_ADDR(0), rdata);
    `CHECK("TC24 rec0 addr",          rdata, 32'hAA24_0001)

    ahb_read(STATUS_ADDR(1), estatus);
    `CHECK("TC24 rec1 valid",         estatus[VALID_BIT],   1'b1)
    `CHECK("TC24 rec1 ce",            estatus[CE_BIT],      1'b1)
    `CHECK("TC24 rec1 ec==0x21",      estatus[EC_HI:EC_LO], 8'h21)
    ahb_read(ADDRINFO_ADDR(1), rdata);
    `CHECK("TC24 rec1 addr",          rdata, 32'hBB24_0002)

    `CHECK("TC24 ras_lo==1 (both CEs)", ras_lo, 1'b1)

    sinv_clear(0); sinv_clear(1); idle(1);

    // ================================================================
    // Summary
    // ================================================================
    $display("\===============================================================");
    $display("  RESULTS:  %0d PASS  /  %0d FAIL", pass_cnt, fail_cnt);
    $display("===============================================================");
    if (fail_cnt == 0)
        $display("ALL TESTS PASSED");
    else
        $display("SOME TESTS FAILED see FAIL lines above");

    $finish;
end

// =================================
// Timeout watchdog: 10 ms (generous for TC20 saturation loop ~2.6 ms)
// ==================================
initial begin
    #10_000_000;
    $display("[FATAL] Simulation timeout");
    $finish;
end

// ========================================================================
// VCD dump
// ========================================================================
initial begin
    $dumpfile("tb_reri.vcd");
    $dumpvars(0, tb_reri);
end

endmodule
