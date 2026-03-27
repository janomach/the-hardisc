/*
    RERI Error Bank AHB-Lite slave (legacy simple version)

    Provides a memory-mapped error record store compliant with the RERI specification.  
    It accepts single-cycle error notifications from the ECC monitor and stores them
    in a small on-chip record array that software can read via the AHB-Lite bus.

    Operation summary
    -----------------
    Hardware path (err_valid pulse from ecc_monitor):
    On every cycle where err_valid is asserted, the module scans the
    record array for the first empty slot (rec_valid[i]==0) and writes
    the err_code and err_addr fields into that slot, marking it valid.
    If all slots are occupied the new error is silently dropped.

    Software read path (AHB-Lite read):
    The record array is mapped as follows (per record, stride 0x20):
        base + 0x000  rec_status[0]  — error code word
        base + 0x004  rec_addr[0]    — faulting address
        base + 0x00C  rec_valid[0]   — {31'b0, valid}  (read-only mirror)
        base + 0x020  rec_status[1]  — record 1 …
        …
    Unmapped addresses return 32'hDEADBEEF.

    Software clear path (AHB-Lite write):
    Writing any value to rec_valid[i] (at offset +0x00C / +0x02C) clears
    the valid flag for that record, freeing the slot for new errors.

    Parameters
    ----------
    NUM_RECORDS  Number of error records in the array (default 4).
                Only records 0 and 1 have decode entries in this version.

    Interface
    ---------
    HCLK / HRESETn   Standard AHB clock and active-low reset.
    HSEL             Slave select from the AHB interconnect.
    HADDR/HWRITE/    Standard AHB-Lite address/control phase signals.
    HTRANS/HWDATA/
    HRDATA           Read data; driven combinationally from the record array.
    HREADY / HRESP   Always 1/OKAY (zero-wait-state, no error response).
    err_valid        Pulse from ecc_monitor: a new ECC error has occurred.
    err_code         Error classification / status word for the new error.
    err_addr         Address associated with the new error.
*/

module reri_ahb #(
    parameter NUM_RECORDS = 4
)(
    input  wire        HCLK,
    input  wire        HRESETn,

    // AHB-Lite interface
    input  wire        HSEL,
    input  wire [31:0] HADDR,
    input  wire        HWRITE,
    input  wire [1:0]  HTRANS,
    input  wire [31:0] HWDATA,
    output reg  [31:0] HRDATA,
    output wire        HREADY,
    output wire        HRESP,

    // Error input (from ECC monitor)
    input  wire        err_valid,
    input  wire [31:0] err_code,
    input  wire [31:0] err_addr
);

assign HREADY = 1'b1;
assign HRESP  = 1'b0; // OKAY

// ---------------------------
// RERI RECORD STORAGE
// ---------------------------

reg [31:0] rec_status [0:NUM_RECORDS-1];
reg [31:0] rec_addr   [0:NUM_RECORDS-1];
reg        rec_valid  [0:NUM_RECORDS-1];

integer i;

// ---------------------------
// ERROR CAPTURE
// ---------------------------

always @(posedge HCLK or negedge HRESETn) begin
    if (!HRESETn) begin
        for (i = 0; i < NUM_RECORDS; i = i+1) begin
            rec_valid[i]  <= 0;
            rec_status[i] <= 0;
            rec_addr[i]   <= 0;
        end
    end else begin

        // --- WRITE: Clear valid bit (higher priority) ---
        if (valid_access && HWRITE) begin
            case (HADDR[11:0])
                12'h10C: rec_valid[0] <= 0;
                12'h12C: rec_valid[1] <= 0;
            endcase
        end

        // --- ERROR CAPTURE: Fill first empty slot ---
        if (err_valid) begin
            for (i = 0; i < NUM_RECORDS; i = i+1) begin
                if (!rec_valid[i]) begin
                    rec_valid[i]  <= 1;
                    rec_status[i] <= err_code;
                    rec_addr[i]   <= err_addr;
                end
            end
        end

    end
end

// ---------------------------
// AHB READ/WRITE
// ---------------------------

wire valid_access = HSEL && HTRANS[1];

always @(*) begin
    HRDATA = 32'h0;

    if (valid_access && !HWRITE) begin
        case (HADDR[11:0])

            // Record 0
            12'h100: HRDATA = rec_status[0];
            12'h104: HRDATA = rec_addr[0];
            12'h10C: HRDATA = {31'b0, rec_valid[0]};

            // Record 1
            12'h120: HRDATA = rec_status[1];
            12'h124: HRDATA = rec_addr[1];
            12'h12C: HRDATA = {31'b0, rec_valid[1]};

            default: HRDATA = 32'hDEADBEEF;
        endcase
    end
end


endmodule
