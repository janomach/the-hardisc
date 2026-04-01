import p_reri::fault_record_t;

module reri_error_bank #(
    parameter integer  N_RECORDS = 1,       // 1..63  (n_err_recs)
    parameter integer  IFP       = 0,       // integrity-field protected bus (0=off)
    parameter [31:0]   VENDOR_ID = 32'h0,
    parameter [31:0]   IMP_ID    = 32'h0,
    parameter [15:0]   INST_ID   = 16'h0,  // bank_info[15:0]  - instance ID
    parameter [1:0]    LAYOUT    = 2'b00,  // bank_info[23:22] - implementation layout
    parameter [7:0]    VERSION   = 8'h01   // bank_info[63:56] - spec version (0x01 = specification version)
) (
    input  logic        clk,
    input  logic        rst_n,

    // AHB-Lite slave interface (register access by software)
    input  logic [31:0] haddr,
    input  logic [31:0] hwdata,
    input  logic [2:0]  hburst,
    input  logic        hmastlock,
    input  logic [3:0]  hprot,
    input  logic [2:0]  hsize,
    input  logic [1:0]  htrans,
    input  logic        hwrite,
    input  logic        hsel,
    input  logic [5:0]  hparity,
    input  logic [6:0]  hwchecksum_i,
    output logic [6:0]  hrchecksum_o,
    output logic [31:0] hrdata,
    output logic        hreadyout,
    output logic        hresp,

    // Fault inputs from Hardisc (one entry per record)
    input  fault_record_t fault_in [N_RECORDS],
    
    // RAS signal outputs
    output logic        ras_lo,   // low-priority RAS
    output logic        ras_hi,   // high-priority RAS
    output logic        ras_plat  // platform-specific RAS
);

    // -------------------------------------------------------
    // Memory-mapped register layout (RERI Table 2, 32-bit AHB bus)
    
    // 64-byte HEADER  (haddr[11:6] == 6'h0):
    //   0x00  vendor_n_imp_id[63:0]: - Vendor and implementation ID
    //     [31:0]   VENDOR_ID = 32'h0 (for pre-standard implementations, otherwise OUI-based)
    //     [63:32]  IMP_ID
    
    //   0x08  bank_info[63:0]: - Error bank information
    //     [15:0]   inst_id     - unique instance ID, 0 = not implemented (for multiple banks)
    //     [21:16]  n_err_recs  - number of error records in the bank (N_RECORDS) in range <1,63>
    //     [23:22]  layout      - implementation layout, 0 = specification layout (for software to interpret the register map)
    //     [55:24]  WPRI        - Writes Preserve values, Reads Ignore values (for future use)
    //     [63:56]  version     - spec version (0x01 = specification version, 0xF0 - 0xFF = custom version)
    
    //   0x10  valid_summary[63:0]: - Summary of valid error records
    //     [0]      sv              - this bank provides a summary, 1 = summary implemented (spec requirement for reri_error_bank), 0 = no summary (for simpler implementations)
    //     [63:1]   valid_bitmap    - bit[g] = 1 if record g-1 is valid (g=1..N_RECORDS), 0 otherwise
    
    //   0x18  Reserved[255:0]  → 0 - Reserved for future standard use
    //   0x38  Custom[63:0]     = 0 - Designated for custom use
    
    // Per-record i <0,62>, base = 0x40 + 0x40*i  (haddr[11:6] == i+1):
    //   +0x00  control_i[63:0]: - Control register of error record i
    //      [0]      else  - WARL, error logging and signaling enable, 1 = on, 0 = off (reset=0/1)
    //      [1]      cece  - corrected error counting enable, 1 = on, 0 = off (reset=0/1)
    //      [3:2]    ces   - corrected error signaling, 0 = not signaling RAS signal, 1 = low priority, 2 = high priority, 3 = platform specific
    //      [5:4]    ueds  - uncorrected error deferred signaling, 0 = not signaling RAS signal, 1 = low priority, 2 = high priority, 3 = platform specific
    //      [7:6]    uecs  - uncorrected error critical signaling, 0 = not signaling RAS signal, 1 = low priority, 2 = high priority, 3 = platform specific
    //      [31:8]   WPRI  - Writes Preserve values, Reads Ignore values (for future use)
    //      [47:32]  eid   - error-injection-delay countdown, is WARL field, 0 = countdown off, 1..0xFFFF = countdown in cycles to error injection (for testing), when reaches 0, valid bit v is set to 1
    //      [48]     sinv  - status-register-invalidate bit, 1 = causes valid bit v to be cleared if rdip=1 (always reads 0)
    //      [49]     srdp  - set-read-in-progress field, 1 = set rdip (always reads 0)
    //      [59:50]  WPRI  - Writes Preserve values, Reads Ignore values (for future use)
    //      [63:60]  custom
    
    //   +0x08  status_i[63:0]: - Status register of error record i
    //      [0]      v     - valid bit, 1 = record contains an error (do not accept software write), 0 = record is empty
    //      [1]      ce    - corrected error, 1 = error was corrected by hardware (e.g. SECDED), 0 = uncorrected error or no error
    //      [2]      ued   - uncorrected error deferred, 1 = error was deferred
    //      [3]      uec   - uncorrected error critical, 1 = error is critical and needs attention
    //      [5:4]    pri   - priority of the error in range <0 - lowest,3 - highest>
    //      [6]      mo    - multiple occurrences of the error (not implemented, always 0)
    //      [7]      c     - containable (error is not immediately fatal), 1 = containable, 0 = uncontainable (e.g. core detected an uncorrectable error)
    //      [10:8]   tt    - transaction type (WARL) classification field, 0 = unspecified or not applicable, 1 = custom, 2-3 = future standard use, 4 = explicit read, 5 = explicit write, 6 = implicit read, 7 = implicit write
    //      [11]     iv    - information-valid field, 1 = report present in info_i (not implemented, always 0)
    //      [15:12]  ait   - address-or-info-type (WARL) field for addr_info_i register, 0 = unspecified, 1 = supervisor physical address, 2 = guest physical address, 3 = virtual adress, 4-15 = component-specific address or information (local bus address, DRAM adress, internal module ID, etc.)
    //      [16]     siv   - supplemental-information-valid field, 1 = report present in suppl_info_i (not implemented, always 0)
    //      [17]     tsv   - timestamp-valid field, 1 = timestamp recorded in timestamp_i (not implemented, always 0)
    //      [19:18]  WPRI  - Writes Preserve values, Reads Ignore values (for future use)
    //      [20]     scrub - scrub recorded (not implemented, always 0)
    //      [21]     ceco  - corrected error count overflow, 1 = overflow in the counter occurred (not implemented, always 0)
    //      [22]     WPRI  - Writes Preserve values, Reads Ignore values (for future use)
    //      [23]     rdip  - read-in-progress field, set on new error capture to invalid register, cleared on overwrite of valid record
    //      [31:24]  ec    - error code (WARL) field, description of the detected error
    //      [47:32]  WPRI  - Writes Preserve values, Reads Ignore values (for future use)
    //      [63:48]  cec   - corrected error count (WARL) field, saturating at 0xFFFF (not implemented, always 0)
    
    //   +0x10  addr_info_i[63:0]      - Address or information register of error record i, reports address or other information about the error, when ait != 0
    //   +0x18  info_i [63:0]          - Information register of error record i, when iv=1 (?not implemented, always 0)
    //   +0x1C  suppl_info_i[63:0]     - Supplemental information register of error record i, when siv=1 (?not implemented, always 0)
    //   +0x20  timestamp_i[63:0]      - Timestamp register of error record i, for the last recorded error, when tsv=1 (?not implemented, always 0)
    //   +0x30  Reserved[127:0] → 0    - Reserved for future standard use
    // -------------------------------------------------------

    // -------------------------------------------------------
    // Record storage registers
    logic        r_valid  [N_RECORDS];   // [0]      valid bit
    logic        r_rdip   [N_RECORDS];   // [23]     read-in-progress bit
    logic        r_ce     [N_RECORDS];   // [1]      corrected error bit
    logic        r_ued    [N_RECORDS];   // [2]      uncorrected error deferred bit
    logic        r_uec    [N_RECORDS];   // [3]      uncorrected error critical bit
    logic [7:0]  r_ec     [N_RECORDS];   // [31:24]  error code
    logic [1:0]  r_pri    [N_RECORDS];   // [5:4]    priority
    logic        r_c      [N_RECORDS];   // [7]      containable bit
    logic [3:0]  r_ait    [N_RECORDS];   // [15:12]  address/info type
    logic [2:0]  r_tt     [N_RECORDS];   // [10:8]   transaction type
    logic [15:0] r_ecount [N_RECORDS];  // [63:48]  corrected error counter (saturating at 0xFFFF)

    logic [63:0] r_addr   [N_RECORDS];   // [63:0]   address or information about the error
    // Control register fields (control_i)
    logic        r_else   [N_RECORDS];   // [0]      error logging/signaling enable
    logic        r_cece   [N_RECORDS];   // [1]      corrected error counting enable
    logic [1:0]  r_ces    [N_RECORDS];   // [3:2]    CE signaling
    logic [1:0]  r_ueds   [N_RECORDS];   // [5:4]    UED signaling
    logic [1:0]  r_uecs   [N_RECORDS];   // [7:6]    UEC signaling
    logic [15:0] r_eid    [N_RECORDS];   // [47:32]  error injection delay countdown
    logic        r_sinv   [N_RECORDS];   // [48]     status invalidate
    logic        r_srdp   [N_RECORDS];   // [49]     set read in progress

    // -------------------------------------------------------
    // AHB controller interface signals
    // -------------------------------------------------------
    logic [31:0] s_dp_address;  // registered address from ahb_controller_m
    logic        s_dp_write;    // registered write flag
    logic        s_dp_accepted; // data phase is valid (r_trans & !r_hresp)
    logic        s_ap_detected; // address phase transfer detected
    logic [1:0]  s_dp_size;     // registered transfer size
    
    // -------------------------------------------------------
    // Derived combinational signals
    // -------------------------------------------------------
    logic [N_RECORDS-1:0] s_valid_summary;
    logic [63:0] s_valid_summary64;  // zero-padded to 64 bits for AHB read
    logic [31:0] rec_status [N_RECORDS];

    generate
        for (genvar g = 0; g < N_RECORDS; g++) begin : gen_derived
            assign s_valid_summary[g]      = r_valid[g];
            assign s_valid_summary64[g+1]  = r_valid[g];  // valid_bitmap: bit[g+1] = record g
            assign rec_status[g] = {
                r_ec[g],         // [31:24] ec
                r_rdip[g],       // [23]    rdip
                1'b0,            // [22]    WPRI
                1'b0,            // [21]    ceco  (not implemented)
                1'b0,            // [20]    scrub (not implemented)
                2'b0,            // [19:18] WPRI
                1'b0,            // [17]    tsv   (not implemented)
                1'b0,            // [16]    siv   (not implemented)
                r_ait[g],        // [15:12] ait
                1'b0,            // [11]    iv    (not implemented)
                r_tt[g],         // [10:8]  tt
                r_c[g],          // [7]     c
                1'b0,            // [6]     mo    (not implemented)
                r_pri[g],        // [5:4]   pri
                r_uec[g],        // [3]     uec
                r_ued[g],        // [2]     ued
                r_ce[g],         // [1]     ce
                r_valid[g]       // [0]     v
            };
        end
        // Zero-pad unused valid_bitmap bits [N_RECORDS+1 .. 63]
        for (genvar g = N_RECORDS + 1; g < 64; g++) begin : gen_vs_pad
            assign s_valid_summary64[g] = 1'b0;
        end
    endgenerate
    // sv bit [0] = 1: this bank always provides a valid_bitmap (Figure 3)
    assign s_valid_summary64[0] = 1'b1;

    // -------------------------------------------------------
    // Address decode helpers: extract part-selects into wires so they
    // are not used directly inside always_* processes (iverilog limit).
    // -------------------------------------------------------
    wire [5:0] w_blk;   // 64-byte block: 0=header, k+1=record k
    wire [3:0] w_word;  // 32-bit word index within the 64-byte block
    assign w_blk  = s_dp_address[11:6];
    assign w_word = s_dp_address[5:2];
    // Words pre-computed outside always_* (iverilog: no constant selects inside processes)
    wire [31:0] w_bank_info_lo;
    wire [31:0] w_bank_info_hi;
    wire [31:0] w_valid_sum_lo;
    wire [31:0] w_valid_sum_hi;
    assign w_bank_info_lo = {8'h0, LAYOUT, N_RECORDS[5:0], INST_ID};
    assign w_bank_info_hi = {VERSION, 24'h0};
    assign w_valid_sum_lo = s_valid_summary64[31:0];
    assign w_valid_sum_hi = s_valid_summary64[63:32];

    // -------------------------------------------------------
    // AHB read mux - combinational, data phase
    //
    // Address decode:
    //   w_blk  → 0        = header
    //            k+1      = record k  (k < N_RECORDS)
    //   w_word → 32-bit word within the 64-byte block
    // -------------------------------------------------------
    always_comb begin : ahb_read_mux
        hrdata = 32'h0;
        if (s_dp_accepted && !s_dp_write) begin
            if (w_blk == 6'h0) begin
                // ── Header ──────────────────────────────────
                case (w_word)
                    4'd0:    hrdata = VENDOR_ID;       // vendor_n_imp_id[31:0]
                    4'd1:    hrdata = IMP_ID;          // vendor_n_imp_id[63:32]
                    4'd2:    hrdata = w_bank_info_lo;  // bank_info[31:0]
                    4'd3:    hrdata = w_bank_info_hi;  // bank_info[63:32]
                    4'd4:    hrdata = w_valid_sum_lo;  // valid_summary[31:0]
                    4'd5:    hrdata = w_valid_sum_hi;  // valid_summary[63:32]
                    // 0x18-0x37 reserved, 0x38-0x3F custom → 0
                    default: hrdata = 32'h0;
                endcase
            end else begin
                // ── Per-record ──────────────────────────────
                for (integer k = 0; k < N_RECORDS; k++) begin
                    if (w_blk == (k + 1)) begin
                        case (w_word)
                            // control_i[31:0]: else/cece/ces/ueds/uecs
                            4'd0:    hrdata = {24'b0,
                                               r_uecs[k],   // [7:6]
                                               r_ueds[k],   // [5:4]
                                               r_ces[k],    // [3:2]
                                               r_cece[k],   // [1]
                                               r_else[k]};  // [0]
                            // control_i[63:32]: eid (sinv/srdp always read 0)
                            4'd1:    hrdata = {14'b0, r_eid[k]}; // [15:0]=eid,[31:16]=0(sinv/srdp/WPRI/custom)
                            4'd2:    hrdata = rec_status[k];       // status_i[31:0]
                            4'd3:    hrdata = {r_ecount[k], 16'h0}; // status_i[63:32]: cec[31:16] (saturating CE count)
                            4'd4:    hrdata = r_addr[k];           // addr_info_i[31:0]
                            4'd5:    hrdata = 32'h0;               // addr_info_i[63:32]
                            // info_i, suppl_info_i, timestamp_i → 0
                            default: hrdata = 32'h0;
                        endcase
                    end
                end
            end
        end
    end

    // -------------------------------------------------------
    // Record update: hardware fault capture + control register writes
    //
    // Fault capture (gated by r_else[i]):
    //   New fault on slot i is written only when r_else[i]=1 and:
    //     (a) slot is empty  (r_valid[i] == 0), OR
    //     (b) incoming priority strictly exceeds stored priority.
    //   rdip is set on 0→1 valid transition; cleared on overwrite of valid record.
    //
    // eid countdown:
    //   When r_eid[i] > 0, decrements each cycle. Reaching 0 forces r_valid[i]=1
    //   and triggers the injection RAS (uses the class already in rec_status).
    //
    // Control register writes (w_word==0 or w_word==1):
    //   word 0: else, cece, ces, ueds, uecs
    //   word 1: eid written directly; sinv (bit16): if rdip=1 clears valid;
    //           srdp (bit17): sets rdip.
    //   sinv+srdp written together: rdip set then valid cleared (spec §2.3.3).
    // -------------------------------------------------------
    always_ff @(posedge clk or negedge rst_n) begin : record_update
        if (!rst_n) begin
            for (integer i = 0; i < N_RECORDS; i++) begin
                r_valid[i] <= 1'b0;
                r_rdip[i]  <= 1'b0;
                r_ce[i]    <= 1'b0;
                r_ued[i]   <= 1'b0;
                r_uec[i]   <= 1'b0;
                r_ec[i]    <= 8'h0;
                r_pri[i]   <= 2'h0;
                r_c[i]     <= 1'b0;
                r_ait[i]   <= 4'h0;
                r_addr[i]  <= 32'h0;
                r_tt[i]    <= 3'h0;
                r_else[i]  <= 1'b0;  // disabled at reset (spec recommendation)
                r_cece[i]  <= 1'b0;
                r_ces[i]   <= 2'b0;
                r_ueds[i]  <= 2'b0;
                r_uecs[i]  <= 2'b0;
                r_eid[i]   <= 16'h0;
                r_ecount[i]<= 16'h0;
            end
        end else begin
            for (integer i = 0; i < N_RECORDS; i++) begin
                // CE counter: increment when cece=1 and fault is a corrected error
                if (r_else[i] && r_cece[i] && fault_in[i].valid &&
                        fault_in[i].ce && !fault_in[i].uec && !fault_in[i].ued) begin
                    r_ecount[i] <= (r_ecount[i] == 16'hFFFF) ? 16'hFFFF
                                                              : r_ecount[i] + 16'h1;
                end
                // ── Hardware fault capture (gated by else) ──────────────────────────
                if (r_else[i] && fault_in[i].valid &&
                        (!r_valid[i] || (fault_in[i].pri > r_pri[i]))) begin
                    // rdip: set on 0→1 (new record), cleared on overwrite of valid record
                    r_rdip[i]  <= !r_valid[i];
                    r_valid[i] <= 1'b1;
                    r_ce[i]    <= fault_in[i].ce;
                    r_ued[i]   <= fault_in[i].ued;
                    r_uec[i]   <= fault_in[i].uec;
                    r_ec[i]    <= fault_in[i].ec;
                    r_pri[i]   <= fault_in[i].pri;
                    r_c[i]     <= fault_in[i].c;
                    r_ait[i]   <= fault_in[i].ait;
                    r_addr[i]  <= fault_in[i].addr;
                    r_tt[i]    <= fault_in[i].tt;
                end

                // ── eid countdown + injection ────────────────────────────
                if (r_eid[i] != 16'h0) begin
                    r_eid[i] <= r_eid[i] - 16'h1;
                    if (r_eid[i] == 16'h1) begin  // reaching 0 next cycle
                        r_valid[i] <= 1'b1;
                        r_rdip[i]  <= !r_valid[i];
                    end
                end

                // ── Control register writes ──────────────────────────────
                if (s_dp_accepted && s_dp_write && (w_blk == (i + 1))) begin
                    if (w_word == 4'd0) begin
                        // control_i[31:0]: else/cece/ces/ueds/uecs
                        r_else[i]  <= hwdata[0];
                        r_cece[i]  <= hwdata[1];
                        r_ces[i]   <= hwdata[3:2];
                        r_ueds[i]  <= hwdata[5:4];
                        r_uecs[i]  <= hwdata[7:6];
                    end
                    if (w_word == 4'd1) begin
                        // control_i[63:32]: eid[15:0] at bits[15:0]
                        r_eid[i] <= hwdata[15:0];
                        // srdp (bit17): set rdip
                        if (hwdata[17]) r_rdip[i] <= 1'b1;
                        // sinv (bit16): clear valid if rdip=1
                        // sinv+srdp together: rdip is set first, then valid cleared
                        if (hwdata[16] && (r_rdip[i] || hwdata[17]))
                            r_valid[i] <= 1'b0;
                    end
                end
            end
        end
    end

    // -------------------------------------------------------
    // RAS signal generation
    //   Each record drives ras_lo/ras_hi/ras_plat independently based on
    //   its ces/ueds/uecs signaling field (Table 3 encoding):
    //     0 = disabled, 1 = lo-priority RAS, 2 = hi-priority RAS,
    //     3 = platform-specific RAS
    //   A record only signals when r_else[i]=1 and r_valid[i]=1.
    //   CE signaling: only when cece=0 (when cece=1 only cec overflow signals;
    //                 cec/overflow not implemented, so ces unused when cece=1).
    //   ras_plat (overflow): incoming fault cannot displace the stored record.
    // -------------------------------------------------------
    always_comb begin : ras_gen
        ras_lo     = 1'b0;
        ras_hi     = 1'b0;
        ras_plat   = 1'b0;
        for (integer j = 0; j < N_RECORDS; j++) begin
            if (r_else[j] && r_valid[j]) begin
                // CE signaling (only when cece=0)
                if (r_ce[j] && !r_uec[j] && !r_ued[j] && !r_cece[j]) begin
                    if (r_ces[j] == 2'd1) ras_lo   = 1'b1;
                    if (r_ces[j] == 2'd2) ras_hi   = 1'b1;
                    if (r_ces[j] == 2'd3) ras_plat = 1'b1;
                end
                // UED signaling
                if (r_ued[j] && !r_uec[j]) begin
                    if (r_ueds[j] == 2'd1) ras_lo   = 1'b1;
                    if (r_ueds[j] == 2'd2) ras_hi   = 1'b1;
                    if (r_ueds[j] == 2'd3) ras_plat = 1'b1;
                end
                // UEC signaling
                if (r_uec[j]) begin
                    if (r_uecs[j] == 2'd1) ras_lo   = 1'b1;
                    if (r_uecs[j] == 2'd2) ras_hi   = 1'b1;
                    if (r_uecs[j] == 2'd3) ras_plat = 1'b1;
                end
            end
            // Overflow: incoming fault cannot displace the stored record
            if (fault_in[j].valid && r_valid[j] && (fault_in[j].pri <= r_pri[j]))
                ras_plat = 1'b1;
        end
    end

    // -------------------------------------------------------
    // AHB-Lite controller (address-phase pipeline + ready/resp)
    // -------------------------------------------------------
    ahb_controller_m #(.IFP(IFP)) ahb_ctrl (
        .s_clk_i        (clk),
        .s_resetn_i     (rst_n),

        .s_haddr_i      (haddr),
        .s_hburst_i     (hburst),
        .s_hmastlock_i  (hmastlock),
        .s_hprot_i      (hprot),
        .s_hsize_i      (hsize),
        .s_htrans_i     (htrans),
        .s_hwrite_i     (hwrite),
        .s_hsel_i       (hsel),

        .s_hparity_i    (hparity),

        .s_hready_o     (hreadyout),
        .s_hresp_o      (hresp),

        .s_ap_error_i   (1'b0),
        .s_dp_delay_i   (1'b0),

        .s_ap_detected_o(s_ap_detected),
        .s_dp_accepted_o(s_dp_accepted),
        .s_dp_address_o (s_dp_address),
        .s_dp_write_o   (s_dp_write),
        .s_dp_size_o    (s_dp_size)
    );
endmodule
