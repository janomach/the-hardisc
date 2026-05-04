import p_reri::*;
import edac::*;

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

    // Scrub acknowledge inputs (one bit per record; pulsed by HW scrubber
    // when the error location has been successfully scrubbed)
    input  logic [N_RECORDS-1:0] scrub_ack_i,

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
    //   +0x00  control_i[63:0]     - Control register of error record i
    //   +0x08  status_i[63:0]      - Status register of error record i 
    //   +0x10  addr_info_i[63:0]   - Address or information register of error record i, reports address or other information about the error, when ait != 0
    //   +0x18  info_i[63:0]        - Information register of error record i, when iv=1 (?not implemented, always 0)
    //   +0x20  suppl_info_i[63:0]  - Supplemental information register of error record i, when siv=1 (?not implemented, always 0)
    //   +0x28  timestamp_i[63:0]   - Timestamp register of error record i, for the last recorded error, when tsv=1 (?not implemented, always 0)
    //   +0x30  Reserved[127:0] → 0 - Reserved for future standard use
    // -------------------------------------------------------

    // -------------------------------------------------------
    // Parameter validation
    // -------------------------------------------------------
    initial begin
        if (N_RECORDS < 1 || N_RECORDS > 63)
            $fatal(1, "reri_error_bank: N_RECORDS must be in range [1,63], got %0d", N_RECORDS);
    end

    // -------------------------------------------------------
    // Control and status struct arrays (p_reri)
    reri_control_i r_ctrl [N_RECORDS];  // control register per record (see p_reri::reri_control_i)
    reri_status_i  r_stat [N_RECORDS];  // status register per record  (see p_reri::reri_status_i)
    logic [63:0] r_addr_info[N_RECORDS]; // [63:0] address or information about the error

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
    logic [63:0] s_valid_summary;  // valid_summary register, [0]=sv, [N_RECORDS:1]=valid_bitmap
    logic [63:0] rec_status [N_RECORDS];

    generate
        for (genvar g = 0; g < N_RECORDS; g++) begin : gen_derived
            assign s_valid_summary[g+1]  = r_stat[g].v;  // valid_bitmap: bit[g+1] = record g
            assign rec_status[g] = {
                r_stat[g].cec,   // [63:48] cec
                16'b0,           // [47:32] WPRI
                r_stat[g].ec,    // [31:24] ec
                r_stat[g].rdip,  // [23]    rdip
                1'b0,            // [22]    WPRI
                r_stat[g].ceco,  // [21]    ceco
                r_stat[g].scrub, // [20]    scrub
                2'b0,            // [19:18] WPRI
                1'b0,            // [17]    tsv   (not implemented)
                1'b0,            // [16]    siv   (not implemented)
                r_stat[g].ait,   // [15:12] ait
                1'b0,            // [11]    iv    (not implemented)
                r_stat[g].tt,    // [10:8]  tt
                r_stat[g].c,     // [7]     c
                1'b0,            // [6]     mo    (not implemented)
                r_stat[g].pri,   // [5:4]   pri
                r_stat[g].uec,   // [3]     uec
                r_stat[g].ued,   // [2]     ued
                r_stat[g].ce,    // [1]     ce
                r_stat[g].v      // [0]     v
            };
        end
        // Zero-pad unused valid_bitmap bits [N_RECORDS+1 .. 63]
        for (genvar g = N_RECORDS + 1; g < 64; g++) begin : gen_vs_pad
            assign s_valid_summary[g] = 1'b0;
        end
    endgenerate
    // sv bit [0] = 1: this bank signals a valid_bitmap
    assign s_valid_summary[0] = 1'b1;

    // -------------------------------------------------------
    // AHB read mux - combinational, data phase
    //
    // Address decode:
    //   s_dp_address[11:6] → 0   = header
    //                        k+1 = record k  (k < N_RECORDS)
    //   s_dp_address[5:2]  → 32-bit word index within the 64-byte block
    // -------------------------------------------------------
    always_comb begin : ahb_read_mux
        hrdata = 32'h0;
        if (s_dp_accepted && !s_dp_write) begin
            if (s_dp_address[11:6] == 6'h0) begin
                // ── Header ──────────────────────────────────
                case (s_dp_address[5:2])
                    4'd0:    hrdata = VENDOR_ID;                               // vendor_n_imp_id[31:0]
                    4'd1:    hrdata = IMP_ID;                                  // vendor_n_imp_id[63:32]
                    4'd2:    hrdata = {8'h0, LAYOUT, N_RECORDS[5:0], INST_ID}; // bank_info[31:0]
                    4'd3:    hrdata = {VERSION, 24'h0};                        // bank_info[63:32]
                    4'd4:    hrdata = s_valid_summary[31:0];                   // valid_summary[31:0]
                    4'd5:    hrdata = s_valid_summary[63:32];                  // valid_summary[63:32]
                    // 0x18-0x37 reserved, 0x38-0x3F custom → 0
                    default: hrdata = 32'h0;
                endcase
            end else begin
                // ── Per-record ──────────────────────────────
                for (integer k = 0; k < N_RECORDS; k++) begin
                    if (s_dp_address[11:6] == (k + 1)) begin
                        case (s_dp_address[5:2])
                            // control_i[31:0]: elase/cece/ces/ueds/uecs
                            4'd0:    hrdata = {24'b0,
                                               r_ctrl[k].uecs,   // [7:6]
                                               r_ctrl[k].ueds,   // [5:4]
                                               r_ctrl[k].ces,    // [3:2]
                                               r_ctrl[k].cece,   // [1]
                                               r_ctrl[k].elase}; // [0]
                            // control_i[63:32]: eid (sinv/srdp always read 0)
                            4'd1:    hrdata = {14'b0, r_ctrl[k].eid}; // [15:0]=eid,[31:16]=0(sinv/srdp/WPRI/custom)
                            4'd2:    hrdata = rec_status[k];           // status_i[31:0]
                            4'd3:    hrdata = {r_stat[k].cec, 16'h0}; // status_i[63:32]: cec[31:16] (saturating CE count)
                            4'd4:    hrdata = r_addr_info[k];    // addr_info_i[31:0]
                            4'd5:    hrdata = 32'h0;             // addr_info_i[63:32]
                            // info_i, suppl_info_i, timestamp_i → 0
                            default: hrdata = 32'h0;
                        endcase
                    end
                end
            end
        end
        if (IFP == 1) begin
            hrchecksum_o = edac_checksum(hrdata);
        end else begin
            hrchecksum_o = 7'b0;
        end
    end

    // -------------------------------------------------------
    // Record update: hardware fault capture + control register writes
    //
    // Fault capture (gated by r_ctrl[i].elase):
    //   New fault on slot i is written only when r_ctrl[i].elase=1 and:
    //     (a) slot is empty  (r_stat[i].v == 0), OR
    //     (b) incoming priority strictly exceeds stored priority.
    //   rdip is set on 0→1 valid transition; cleared on overwrite of valid record.
    //
    // eid countdown:
    //   When r_ctrl[i].eid > 0, decrements each cycle. Reaching 0 forces r_stat[i].v=1
    //   and triggers the injection RAS (uses the class already in rec_status).
    //
    // Control register writes (w_word==0 or w_word==1):
    //   s_dp_address[5:2]==0: elase, cece, ces, ueds, uecs
    //   s_dp_address[5:2]==1: eid written directly; sinv (bit16): if rdip=1 clears valid;
    //                         srdp (bit17): sets rdip.
    //   sinv+srdp written together: rdip set then valid cleared (spec §2.3.3).
    // -------------------------------------------------------
    always_ff @(posedge clk or negedge rst_n) begin : record_update
        if (!rst_n) begin
            for (integer i = 0; i < N_RECORDS; i++) begin
                r_ctrl[i]      <= '0;  // elase=0: disabled at reset (spec recommendation)
                r_stat[i]      <= '0;
                r_addr_info[i] <= '0;
            end
        end else begin
            for (integer i = 0; i < N_RECORDS; i++) begin
                // ── Hardware fault capture (gated by elase) ─────────────────────────
                if (r_ctrl[i].elase && fault_in[i].valid && (!r_stat[i].v || (fault_in[i].pri > r_stat[i].pri))) begin
                    // rdip: set on 0→1 (new record), cleared on overwrite of valid record
                    r_stat[i].rdip  <= !r_stat[i].v;
                    r_stat[i].v     <= 1'b1;
                    r_stat[i].ce    <= fault_in[i].ce;
                    r_stat[i].ued   <= fault_in[i].ued;
                    r_stat[i].uec   <= fault_in[i].uec;
                    r_stat[i].ec    <= fault_in[i].ec;
                    r_stat[i].pri   <= fault_in[i].pri;
                    r_stat[i].c     <= fault_in[i].c;
                    r_stat[i].ait   <= fault_in[i].ait;
                    r_addr_info[i]  <= fault_in[i].addr;
                    r_stat[i].tt    <= fault_in[i].tt;
                    r_stat[i].scrub <= 1'b0;  // new capture resets scrub
                    r_stat[i].ceco  <= 1'b0;  // new capture resets overflow flag
                end
                // CE counter: increment when cece=1 and fault is a corrected error;
                // set ceco when counter is already at 0xFFFF (overflow).
                // Placed AFTER fault capture so r_stat[i].ceco<=1 wins when both fire together.
                if (r_ctrl[i].elase && r_ctrl[i].cece && fault_in[i].valid &&
                        fault_in[i].ce && !fault_in[i].uec && !fault_in[i].ued) begin
                    if (r_stat[i].cec == 16'hFFFF)
                        r_stat[i].ceco <= 1'b1;
                    else
                        r_stat[i].cec <= r_stat[i].cec + 16'h1;
                end

                // ── scrub_ack: mark a valid record as scrubbed ───────────────
                if (scrub_ack_i[i] && r_stat[i].v)
                    r_stat[i].scrub <= 1'b1;

                // ── eid countdown + injection ────────────────────────────
                if (r_ctrl[i].eid != 16'h0) begin
                    r_ctrl[i].eid <= r_ctrl[i].eid - 16'h1;
                    if (r_ctrl[i].eid == 16'h1) begin  // reaching 0 next cycle
                        r_stat[i].v    <= 1'b1;
                        r_stat[i].rdip <= !r_stat[i].v;
                    end
                end

                // ── Control register writes ──────────────────────────────
                if (s_dp_accepted && s_dp_write && (s_dp_address[11:6] == (i + 1))) begin
                    if (s_dp_address[5:2] == 4'd0) begin
                        // control_i[31:0]: elase/cece/ces/ueds/uecs
                        r_ctrl[i].elase <= hwdata[0];
                        r_ctrl[i].cece  <= hwdata[1];
                        r_ctrl[i].ces   <= hwdata[3:2];
                        r_ctrl[i].ueds  <= hwdata[5:4];
                        r_ctrl[i].uecs  <= hwdata[7:6];
                    end
                    if (s_dp_address[5:2] == 4'd1) begin
                        // control_i[63:32]: eid[15:0] at bits[15:0]
                        r_ctrl[i].eid <= hwdata[15:0];
                        // srdp (bit17): set rdip
                        if (hwdata[17]) r_stat[i].rdip <= 1'b1;
                        // sinv (bit16): clear valid if rdip=1
                        // sinv+srdp together: rdip is set first, then valid cleared
                        if (hwdata[16] && (r_stat[i].rdip || hwdata[17])) begin
                            r_stat[i].v     <= 1'b0;
                            r_stat[i].scrub <= 1'b0;
                            r_stat[i].ceco  <= 1'b0;
                        end
                    end
                end
            end
        end
    end

    // -------------------------------------------------------
    // RAS signal generation
    //   Each record drives ras_lo/ras_hi/ras_plat independently based on
    //   its ces/ueds/uecs signaling field:
    //     0 = disabled, 1 = lo-priority RAS, 2 = hi-priority RAS, 3 = platform-specific RAS
    //   A record only signals when r_ctrl[i].elase=1 and r_stat[i].v=1.
    //   CE signaling: cece=0 → signal via ces on any CE; cece=1 → signal via ces
    //                 only on count overflow (ceco=1).
    //   ras_plat (overflow): incoming fault cannot displace the stored record.
    // -------------------------------------------------------
    always_comb begin : ras_gen
        ras_lo     = 1'b0;
        ras_hi     = 1'b0;
        ras_plat   = 1'b0;
        for (integer j = 0; j < N_RECORDS; j++) begin
            if (r_ctrl[j].elase && r_stat[j].v) begin
                // CE signaling:
                //   cece=0 → signal via ces on any CE record
                //   cece=1 → signal via ces only on count overflow (ceco=1)
                if (r_stat[j].ce && !r_stat[j].uec && !r_stat[j].ued) begin
                    if (!r_ctrl[j].cece || r_stat[j].ceco) begin
                        if (r_ctrl[j].ces == 2'd1) ras_lo   = 1'b1;
                        if (r_ctrl[j].ces == 2'd2) ras_hi   = 1'b1;
                        if (r_ctrl[j].ces == 2'd3) ras_plat = 1'b1;
                    end
                end
                // UED signaling
                if (r_stat[j].ued && !r_stat[j].uec) begin
                    if (r_ctrl[j].ueds == 2'd1) ras_lo   = 1'b1;
                    if (r_ctrl[j].ueds == 2'd2) ras_hi   = 1'b1;
                    if (r_ctrl[j].ueds == 2'd3) ras_plat = 1'b1;
                end
                // UEC signaling
                if (r_stat[j].uec) begin
                    if (r_ctrl[j].uecs == 2'd1) ras_lo   = 1'b1;
                    if (r_ctrl[j].uecs == 2'd2) ras_hi   = 1'b1;
                    if (r_ctrl[j].uecs == 2'd3) ras_plat = 1'b1;
                end
            end
            // Overflow: incoming fault cannot displace the stored record
            if (fault_in[j].valid && r_stat[j].v && (fault_in[j].pri <= r_stat[j].pri))
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
