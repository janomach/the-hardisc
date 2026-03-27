/*
    RERI bridge: translates hardisc soft-SECDED fault outputs into the
    fault bus expected by reri_error_bank.

    Record mapping (N_RECORDS = 3):
      [0]  Fetch interface correctable error  (CE on instruction bus SECDED)
      [1]  LSU data CE or UCE                 (load data SECDED result)
      [2]  Pipeline unrecoverable error       (TMR/DCLS discrepancy)

    RERI error codes (Table 6 subset used here):
      0x11  instruction fetch CE
      0x21  load/store CE
      0x22  load/store UCE (double-bit, uncorrected deferred)
      0x41  internal hardware error (pipeline discrepancy)

    fault_valid is level-sensitive (held while the condition persists).
    reri_error_bank guards against duplicate capture via priority arbitration,
    so no edge-detection is required here.
*/

module ecc_monitor #(
    parameter int N_RECORDS = 3   // must match reri_error_bank N_RECORDS
)(
    input  logic        clk,
    input  logic        rst_n,

    // Fault inputs from hardisc (wired to the new hardisc fault ports)
    input  logic        fetch_ce_i,       // s_fault_fetch_ce_o
    input  logic        lsu_ce_i,         // s_fault_lsu_ce_o
    input  logic        lsu_uce_i,        // s_fault_lsu_uce_o
    input  logic        pipeline_uce_i,   // s_unrec_err_o[0]
    input  logic [31:0] fetch_addr_i,     // s_fault_fetch_addr_o  (PC)
    input  logic [31:0] lsu_addr_i,       // s_fault_lsu_addr_o    (EA)

    // RERI fault bus outputs → reri_error_bank fault_* inputs
    output logic [N_RECORDS-1:0]        fault_valid_o,
    output logic [N_RECORDS-1:0]        fault_ce_o,
    output logic [N_RECORDS-1:0]        fault_ued_o,
    output logic [N_RECORDS-1:0]        fault_uec_o,
    output logic [N_RECORDS-1:0][7:0]   fault_ec_o,
    output logic [N_RECORDS-1:0][1:0]   fault_pri_o,
    output logic [N_RECORDS-1:0]        fault_c_o,
    output logic [N_RECORDS-1:0][3:0]   fault_ait_o,
    output logic [N_RECORDS-1:0][31:0]  fault_addr_o,
    output logic [N_RECORDS-1:0][2:0]   fault_tt_o
);

    // ------------------------------------------------------------------
    // Record 0 — Fetch interface correctable error
    //   CE; single-bit SECDED correction on instruction bus
    // ------------------------------------------------------------------
    assign fault_valid_o[0] = fetch_ce_i;
    assign fault_ce_o[0]    = 1'b1;
    assign fault_ued_o[0]   = 1'b0;
    assign fault_uec_o[0]   = 1'b0;
    assign fault_ec_o[0]    = 8'h11;   // instruction fetch CE
    assign fault_pri_o[0]   = 2'b01;   // low priority
    assign fault_c_o[0]     = 1'b1;    // containable — core corrected it
    assign fault_ait_o[0]   = 4'h1;    // supervisor physical address
    assign fault_addr_o[0]  = fetch_addr_i;
    assign fault_tt_o[0]    = 3'b110;  // 6 = implicit read (instruction fetch)

    // ------------------------------------------------------------------
    // Record 1 — LSU data CE or UCE
    //   CE  : single-bit error corrected by SECDED during load
    //   UCE : double-bit error detected but not correctable (UED)
    //         mapped as uncorrected deferred (not immediately fatal)
    // ------------------------------------------------------------------
    assign fault_valid_o[1] = lsu_ce_i | lsu_uce_i;
    assign fault_ce_o[1]    = lsu_ce_i;
    assign fault_ued_o[1]   = lsu_uce_i;   // deferred: not immediately critical
    assign fault_uec_o[1]   = 1'b0;
    assign fault_ec_o[1]    = lsu_uce_i ? 8'h22 : 8'h21;  // 0x22 UCE, 0x21 CE
    assign fault_pri_o[1]   = lsu_uce_i ? 2'b10 : 2'b01;  // higher pri for UCE
    assign fault_c_o[1]     = lsu_ce_i;    // CE is containable, UCE is not
    assign fault_ait_o[1]   = 4'h1;        // supervisor physical address
    assign fault_addr_o[1]  = lsu_addr_i;
    assign fault_tt_o[1]    = 3'b100;      // 4 = explicit read (load data access)

    // ------------------------------------------------------------------
    // Record 2 — Pipeline unrecoverable error (TMR/DCLS discrepancy)
    //   Signals that the triplicated/dual pipeline voted a mismatch.
    //   This is a critical hardware error with no address information.
    // ------------------------------------------------------------------
    assign fault_valid_o[2] = pipeline_uce_i;
    assign fault_ce_o[2]    = 1'b0;
    assign fault_ued_o[2]   = 1'b0;
    assign fault_uec_o[2]   = 1'b1;   // critical — system integrity compromised
    assign fault_ec_o[2]    = 8'h41;  // internal hardware error
    assign fault_pri_o[2]   = 2'b11;  // highest priority
    assign fault_c_o[2]     = 1'b0;   // not containable
    assign fault_ait_o[2]   = 4'h0;   // no address information
    assign fault_addr_o[2]  = 32'h0;
    assign fault_tt_o[2]    = 3'b000; // no transaction

endmodule

