module reri_error_bank #(
    parameter int N_RECORDS  = 1,    // 1..63
    parameter logic [31:0] VENDOR_ID = 32'h0,
    parameter logic [31:0] IMP_ID    = 32'h0
) (
    input  logic        clk,
    input  logic        rst_n,

    // AHB-Lite slave interface (register access by software)
    input  logic [31:0] haddr,
    input  logic [2:0]  hsize,
    input  logic [1:0]  htrans,
    input  logic        hwrite,
    input  logic [31:0] hwdata,
    output logic [31:0] hrdata,
    output logic        hreadyout,
    output logic        hresp,

    // Fault inputs from Hardisc (one entry per record)
    input  logic [N_RECORDS-1:0]        fault_valid,  // new error present
    input  logic [N_RECORDS-1:0]        fault_ce,     // corrected error
    input  logic [N_RECORDS-1:0]        fault_ued,    // uncorrected deferred
    input  logic [N_RECORDS-1:0]        fault_uec,    // uncorrected critical
    input  logic [N_RECORDS-1:0][7:0]   fault_ec,     // error code (Table 6)
    input  logic [N_RECORDS-1:0][1:0]   fault_pri,    // priority 0..3
    input  logic [N_RECORDS-1:0]        fault_c,      // containable
    input  logic [N_RECORDS-1:0][3:0]   fault_ait,    // address/info type
    input  logic [N_RECORDS-1:0][31:0]  fault_addr,   // address (addr_info)
    input  logic [N_RECORDS-1:0][2:0]   fault_tt,     // transaction type

    // RAS signal outputs
    output logic        ras_lo,   // low-priority RAS
    output logic        ras_hi,   // high-priority RAS
    output logic        ras_plat  // platform-specific RAS
);

    // -------------------------------------------------------
    // Record storage registers
    // -------------------------------------------------------
    logic        r_valid [N_RECORDS];
    logic        r_ce    [N_RECORDS];
    logic        r_ued   [N_RECORDS];
    logic        r_uec   [N_RECORDS];
    logic [7:0]  r_ec    [N_RECORDS];
    logic [1:0]  r_pri   [N_RECORDS];
    logic        r_c     [N_RECORDS];
    logic [3:0]  r_ait   [N_RECORDS];
    logic [31:0] r_addr  [N_RECORDS];
    logic [2:0]  r_tt    [N_RECORDS];
    logic [15:0] r_ecount[N_RECORDS];  // saturating CE counter (ECOUNT)

    // -------------------------------------------------------
    // AHB-Lite address-phase pipeline register
    // Register the address phase; respond combinationally in the data phase.
    // -------------------------------------------------------
    logic [11:0] r_haddr_q;   // lower 12 bits cover the full RERI register map
    logic        r_hwrite_q;
    logic        r_active_q;  // valid non-idle transfer in address phase

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            r_haddr_q  <= 12'h0;
            r_hwrite_q <= 1'b0;
            r_active_q <= 1'b0;
        end else begin
            r_haddr_q  <= haddr[11:0];
            r_hwrite_q <= hwrite;
            r_active_q <= htrans[1];   // NONSEQ (2) or SEQ (3)
        end
    end

    // Zero wait-state: always ready, always OKAY
    assign hreadyout = 1'b1;
    assign hresp     = 1'b0;

    // -------------------------------------------------------
    // ESTATUS register assembly per record
    // Bit layout:
    //   [31]    valid
    //   [30]    uec   – uncorrected critical
    //   [29]    ued   – uncorrected deferred
    //   [28]    ce    – corrected error
    //   [27]    c     – containable
    //   [26:25] pri   – priority (0=lowest … 3=highest)
    //   [24:22] tt    – transaction type
    //   [21:18] ait   – address/info type
    //   [17:8]  reserved
    //   [7:0]   ec    – error code (RERI Table 6)
    // -------------------------------------------------------
    logic [31:0] rec_estatus [N_RECORDS];

    generate
        for (genvar g = 0; g < N_RECORDS; g++) begin : gen_estatus
            assign rec_estatus[g] = {
                r_valid[g],   // [31]
                r_uec[g],     // [30]
                r_ued[g],     // [29]
                r_ce[g],      // [28]
                r_c[g],       // [27]
                r_pri[g],     // [26:25]
                r_tt[g],      // [24:22]
                r_ait[g],     // [21:18]
                10'b0,        // [17:8]  reserved
                r_ec[g]       // [7:0]
            };
        end
    endgenerate

    // -------------------------------------------------------
    // AHB read mux — combinational, data phase
    //   0x000        VENDOR_ID   (RO)
    //   0x004        IMP_ID      (RO)
    //   0x008        NREC        (RO)  number of records
    //   0x010+k*0x10 ESTATUS[k]  (RW) read / inject error record
    //   0x014+k*0x10 EADDR[k]    (RW) read / inject error address
    //   0x018+k*0x10 ECOUNT[k]   (RO) saturating CE counter
    //   0x01C+k*0x10 ECLR[k]     (WO) any write clears entire record
    // -------------------------------------------------------
    always_comb begin : ahb_read_mux
        hrdata = 32'h0;
        if (r_active_q && !r_hwrite_q) begin
            if      (r_haddr_q == 12'h000) hrdata = VENDOR_ID;
            else if (r_haddr_q == 12'h004) hrdata = IMP_ID;
            else if (r_haddr_q == 12'h008) hrdata = 32'(N_RECORDS);
            else begin
                for (int k = 0; k < N_RECORDS; k++) begin
                    if (r_haddr_q == 12'h010 + 12'(k * 16))
                        hrdata = rec_estatus[k];
                    if (r_haddr_q == 12'h014 + 12'(k * 16))
                        hrdata = r_addr[k];
                    if (r_haddr_q == 12'h018 + 12'(k * 16))
                        hrdata = 32'(r_ecount[k]);
                end
            end
        end
    end

    // -------------------------------------------------------
    // Record update: hardware fault capture + software injection + clear
    //
    // Priority arbitration (hardware capture):
    //   A new fault on slot k overwrites the stored record only if:
    //     (a) the slot is currently empty (r_valid[k] == 0), OR
    //     (b) the incoming priority is strictly higher than stored.
    //
    // CE counter:
    //   r_ecount[k] increments (saturating at 0xFFFF) on every incoming
    //   CE event regardless of whether the record itself is overwritten.
    //
    // Software injection (ESTATUS/EADDR write):
    //   Writes to 0x010/0x014 + k*0x10 override all record fields,
    //   enabling RAS handler testing without real hardware faults.
    //
    // Software clear (ECLR write) takes precedence in the same cycle:
    //   The entire record including r_ecount is reset to zero.
    // -------------------------------------------------------
    always_ff @(posedge clk or negedge rst_n) begin : record_update
        if (!rst_n) begin
            for (int i = 0; i < N_RECORDS; i++) begin
                r_valid[i] <= 1'b0;
                r_ce[i]    <= 1'b0;
                r_ued[i]   <= 1'b0;
                r_uec[i]   <= 1'b0;
                r_ec[i]    <= 8'h0;
                r_pri[i]   <= 2'h0;
                r_c[i]     <= 1'b0;
                r_ait[i]   <= 4'h0;
                r_addr[i]  <= 32'h0;
                r_tt[i]    <= 3'h0;
                r_ecount[i] <= 16'h0;
            end
        end else begin
            for (int i = 0; i < N_RECORDS; i++) begin
                // Hardware fault capture
                if (fault_valid[i] && (!r_valid[i] || (fault_pri[i] > r_pri[i]))) begin
                    r_valid[i] <= 1'b1;
                    r_ce[i]    <= fault_ce[i];
                    r_ued[i]   <= fault_ued[i];
                    r_uec[i]   <= fault_uec[i];
                    r_ec[i]    <= fault_ec[i];
                    r_pri[i]   <= fault_pri[i];
                    r_c[i]     <= fault_c[i];
                    r_ait[i]   <= fault_ait[i];
                    r_addr[i]  <= fault_addr[i];
                    r_tt[i]    <= fault_tt[i];
                end
                // CE counter: saturating increment on every incoming CE event,
                // independent of whether the error record itself is overwritten.
                if (fault_valid[i] && fault_ce[i] && (r_ecount[i] != 16'hFFFF))
                    r_ecount[i] <= r_ecount[i] + 16'h1;
                // Software injection: write to ESTATUS (0x010 + i*0x10).
                // Allows RAS handlers to inject test error records.
                if (r_active_q && r_hwrite_q &&
                    (r_haddr_q == 12'h010 + 12'(i * 16))) begin
                    r_valid[i] <= hwdata[31];
                    r_uec[i]   <= hwdata[30];
                    r_ued[i]   <= hwdata[29];
                    r_ce[i]    <= hwdata[28];
                    r_c[i]     <= hwdata[27];
                    r_pri[i]   <= hwdata[26:25];
                    r_tt[i]    <= hwdata[24:22];
                    r_ait[i]   <= hwdata[21:18];
                    r_ec[i]    <= hwdata[7:0];
                end
                // Software injection: write to EADDR (0x014 + i*0x10).
                if (r_active_q && r_hwrite_q &&
                    (r_haddr_q == 12'h014 + 12'(i * 16)))
                    r_addr[i] <= hwdata;
                // Software clear: write to ECLR (0x01C + i*0x10) resets the
                // entire record including the CE counter. Last assignment wins.
                if (r_active_q && r_hwrite_q &&
                    (r_haddr_q == 12'h01C + 12'(i * 16))) begin
                    r_valid[i]  <= 1'b0;
                    r_ce[i]     <= 1'b0;
                    r_ued[i]    <= 1'b0;
                    r_uec[i]    <= 1'b0;
                    r_ec[i]     <= 8'h0;
                    r_pri[i]    <= 2'h0;
                    r_c[i]      <= 1'b0;
                    r_ait[i]    <= 4'h0;
                    r_addr[i]   <= 32'h0;
                    r_tt[i]     <= 3'h0;
                    r_ecount[i] <= 16'h0;
                end
            end
        end
    end

    // -------------------------------------------------------
    // RAS signal generation
    //   ras_lo   – at least one stored CE (correctable only)
    //   ras_hi   – at least one stored UE (critical or deferred)
    //   ras_plat – overflow: a new fault cannot be stored because its
    //              slot is occupied by an equal- or higher-priority record
    // -------------------------------------------------------
    logic s_overflow;

    always_comb begin : ras_gen
        ras_lo     = 1'b0;
        ras_hi     = 1'b0;
        s_overflow = 1'b0;
        for (int j = 0; j < N_RECORDS; j++) begin
            if (r_valid[j] && r_ce[j] && !r_uec[j] && !r_ued[j])
                ras_lo = 1'b1;
            if (r_valid[j] && (r_uec[j] || r_ued[j]))
                ras_hi = 1'b1;
            // overflow: incoming fault cannot displace the stored record
            if (fault_valid[j] && r_valid[j] && (fault_pri[j] <= r_pri[j]))
                s_overflow = 1'b1;
        end
        ras_plat = s_overflow;
    end

endmodule
