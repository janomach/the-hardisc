// RERI shared types package

package p_reri;

    // Control register fields (control_i)
    typedef struct packed {
        logic [3:0]  custom; // [63:60]  custom control fields
                             // [59:50]  WPRI  - Writes Preserve values, Reads Ignore values (for future use)
        logic        srdp;   // [49]     set-read-in-progress register, 1 = set rdip (always reads 0)
        logic        sinv;   // [48]     status-register-invalidate bit, 1 = causes valid bit v to be cleared if rdip=1 (always reads 0)
        logic [15:0] eid;    // [47:32]  error-injection-delay countdown, WARL field, 0 = countdown off, 1..0xFFFF = countdown in cycles to error injection (for testing), when reaches 0, valid bit v is set to 1
                             // [31:8]   WPRI  - Writes Preserve values, Reads Ignore values (for future use)
        logic [1:0]  uecs;   // [7:6]    uncorrected error critical signaling, 0 = not signaling RAS signal, 1 = low priority, 2 = high priority, 3 = platform specific
        logic [1:0]  ueds;   // [5:4]    uncorrected error deferred signaling, 0 = not signaling RAS signal, 1 = low priority, 2 = high priority, 3 = platform specific
        logic [1:0]  ces;    // [3:2]    corrected error signaling, 0 = not signaling RAS signal, 1 = low priority, 2 = high priority, 3 = platform specific
        logic        cece;   // [1]      corrected error counting enable, 1 = on, 0 = off (reset=0/1)
        logic        elase;  // [0]      error-logging-and-signaling-enable, WARL field, 1 = on, 0 = off (reset=0/1)
    } reri_control_i;

    // Status register fields (status_i)
    typedef struct packed {
        logic [15:0] cec;    // [63:48] corrected error count (WARL) field, saturating at 0xFFFF
                             // [47:32] WPRI - Writes Preserve values, Reads Ignore values (for future use)
        logic [7:0]  ec;     // [31:24] error code (WARL) field, description of the detected error
        logic        rdip;   // [23]    read-in-progress field, set on new error capture to invalid register, cleared on overwrite of valid record
                             // [22]    WPRI - Writes Preserve values, Reads Ignore values (for future use)
        logic        ceco;   // [21]    corrected error count overflow, 1 = overflow in the counter occurred
        logic        scrub;  // [20]    scrub recorded
                             // [19:18] WPRI - Writes Preserve values, Reads Ignore values (for future use)
        logic        tsv;    // [17]    timestamp-valid field, 1 = timestamp recorded in timestamp_i (not implemented, always 0)
        logic        siv;    // [16]    supplemental-information-valid field, 1 = report present in suppl_info_i (not implemented, always 0)
        logic [3:0]  ait;    // [15:12] address-or-info-type (WARL) field for addr_info_i register, 0 = unspecified, 1 = supervisor physical address, 2 = guest physical address, 3 = virtual adress, 4-15 = component-specific address or information (local bus address, DRAM adress, internal module ID, etc.)
        logic        iv;     // [11]    information-valid field, 1 = report present in info_i (not implemented, always 0)
        logic [2:0]  tt;     // [10:8]  transaction type (WARL) classification field, 0 = unspecified or not applicable, 1 = custom, 2-3 = future standard use, 4 = explicit read, 5 = explicit write, 6 = implicit read, 7 = implicit write
        logic        c;      // [7]     containable (error is not immediately fatal), 1 = containable, 0 = uncontainable (e.g. core detected an uncorrectable error)
        logic        mo;     // [6]     multiple occurrences of the error (not implemented, always 0)
        logic [1:0]  pri;    // [5:4]   priority of the error in range <0 - lowest,3 - highest>
        logic        uec;    // [3]     uncorrected error critical, 1 = error is critical and needs attention
        logic        ued;    // [2]     uncorrected error deferred, 1 = error was deferred
        logic        ce;     // [1]     corrected error, 1 = error was corrected by hardware (e.g. SECDED), 0 = uncorrected error or no error
        logic        v;      // [0]     valid bit, 1 = record contains an error (do not accept software write), 0 = record is empty
    } reri_status_i;

    typedef struct packed {
        logic        valid;  // new error present
        logic        ce;     // corrected error
        logic        ued;    // uncorrected deferred
        logic        uec;    // uncorrected critical
        logic [7:0]  ec;     // error code (Table 6)
        logic [1:0]  pri;    // priority 0..3
        logic        c;      // containable
        logic [3:0]  ait;    // address/info type
        logic [31:0] addr;   // address (addr_info)
        logic [2:0]  tt;     // transaction type
    } fault_record_t;

endpackage
