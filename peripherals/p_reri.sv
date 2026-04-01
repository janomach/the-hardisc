// RERI shared types package

package p_reri;

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
