# RERI Peripheral

A synthesisable SystemVerilog implementation of the **RISC-V RAS Error Record Register Interface (RERI)** specification v1.0 (ratified 2024-05-24).

## Overview

RERI provides a standard memory-mapped register interface for hardware components to report Reliability, Availability, and Serviceability (RAS) errors to a software RAS handler. Each detected error is logged in an *error record*, which records the error class, priority, location, and other diagnostic information. The RAS handler can poll or be interrupted via configurable RAS signals.

This peripheral consists of two files:

| File | Description |
|---|---|
| `p_reri.sv` | Shared SystemVerilog package — defines the `reri_control_i`, `reri_status_i`, and `fault_record_t` types used throughout the design |
| `reri_error_bank.sv` | Parameterised error bank module — implements one full RERI error bank with up to 63 error records, an AHB-Lite slave interface, and three RAS signal outputs |

## Module: `reri_error_bank`

### Parameters

| Parameter | Default | Description |
|---|---|---|
| `N_RECORDS` | `1` | Number of error records in this bank (1–63) |
| `IFP` | `0` | Enable integrity-field protection on the AHB bus (EDAC checksum on read data) |
| `VENDOR_ID` | `32'h0` | JEDEC vendor ID (follows `mvendorid` CSR encoding); 0 = non-commercial |
| `IMP_ID` | `32'h0` | Implementation ID defined by the vendor |
| `INST_ID` | `16'h0` | Unique instance identifier for this bank within the SoC |
| `LAYOUT` | `2'b00` | Register layout selector (`0` = standard spec layout) |
| `VERSION` | `8'h01` | Spec version reported in `bank_info` (`0x01` = v1.0) |

### Ports

```
clk          – system clock
rst_n        – active-low synchronous reset

// AHB-Lite slave
haddr        – 32-bit byte address
hwdata       – 32-bit write data
hburst/hmastlock/hprot/hsize/htrans/hwrite/hsel – standard AHB control
hparity      – 6-bit address-phase parity  (used when IFP=1)
hwchecksum_i – 7-bit write-data EDAC checksum (used when IFP=1)
hrchecksum_o – 7-bit read-data EDAC checksum (driven when IFP=1)
hrdata       – 32-bit read data
hreadyout    – AHB ready
hresp        – AHB error response

// Hardware fault inputs (one per record)
fault_in[N_RECORDS]   – fault_record_t array from Hardisc

// Scrub acknowledgement (one bit per record)
scrub_ack_i[N_RECORDS] – pulsed by hardware scrubber when error location is corrected

// RAS signal outputs
ras_lo   – low-priority RAS signal
ras_hi   – high-priority RAS signal
ras_plat – platform-specific RAS signal
```

### `fault_record_t` Input Type

Hardware components drive `fault_in[i]` to report a new error into record `i`. All fields are presented for one clock cycle while `valid` is asserted.

| Field | Width | Description |
|---|---|---|
| `valid` | 1 | New error present this cycle |
| `ce` | 1 | Corrected error |
| `ued` | 1 | Uncorrected error deferred |
| `uec` | 1 | Uncorrected error critical |
| `ec` | 8 | Error code (see Table 6 of specification) |
| `pri` | 2 | Priority 0 (lowest) – 3 (highest) |
| `c` | 1 | Error is containable (not immediately fatal) |
| `ait` | 4 | Address/info type: 0=none, 1=SPA, 2=GPA, 3=VA, 4-15=component-specific |
| `addr` | 32 | Address or component-specific information |
| `tt` | 3 | Transaction type: 0=unspecified, 4=explicit read, 5=explicit write, 6=implicit read, 7=implicit write |

## Memory-Mapped Register Layout

Each error bank occupies a naturally aligned 4 KiB page (or at minimum 128 bytes for a single-record bank). Registers are 64-bit wide; each 64-bit register maps to two consecutive 32-bit AHB word accesses. All registers use little-endian byte order.

### Header (offset 0x000–0x03F)

| Offset | Name | Description |
|---|---|---|
| `0x00` | `vendor_n_imp_id` | Read-only: `[31:0]` = `VENDOR_ID`, `[63:32]` = `IMP_ID` |
| `0x08` | `bank_info` | Read-only: `[15:0]` = `INST_ID`, `[21:16]` = `N_RECORDS`, `[23:22]` = `LAYOUT`, `[63:56]` = `VERSION` |
| `0x10` | `valid_summary` | Read-only: `[0]` = `sv` (always 1), `[N:1]` = one bit per record indicating `v` |
| `0x18` | *(reserved)* | Always 0 |
| `0x38` | *(custom)* | Always 0 |

### Per-Record Registers (record `i`, base = `0x40 + 0x40*i`)

| Offset | Name | Description |
|---|---|---|
| `+0x00` | `control_i` | Read/write: error-logging enable, signaling enables, CE counter enable, error injection delay |
| `+0x08` | `status_i` | Read/write (locked when `v=1`): error class, error code, priority, address type, RAS metadata |
| `+0x10` | `addr_info_i` | Address or component-specific information for the recorded error |
| `+0x18` | `info_i` | Additional information (hardwired to 0 in this implementation) |
| `+0x20` | `suppl_info_i` | Supplemental information (hardwired to 0 in this implementation) |
| `+0x28` | `timestamp_i` | Timestamp (hardwired to 0 in this implementation) |
| `+0x30` | *(reserved)* | Always 0 |

## Register Field Details

### `control_i`

| Bits | Field | Description |
|---|---|---|
| `[0]` | `else` | Error-logging-and-signaling enable. `1` = hardware captures and signals errors. Reset to `0`. |
| `[1]` | `cece` | Corrected-error-counting enable. When `1`, the `cec` counter in `status_i` increments on each CE. |
| `[3:2]` | `ces` | CE signaling: `0`=off, `1`=`ras_lo`, `2`=`ras_hi`, `3`=`ras_plat` |
| `[5:4]` | `ueds` | UED signaling (same encoding as `ces`) |
| `[7:6]` | `uecs` | UEC signaling (same encoding as `ces`) |
| `[47:32]` | `eid` | Error-injection-delay countdown. Write a non-zero value to count down each cycle; forces `status_i.v=1` when it reaches 0. Write `0` to disable. |
| `[48]` | `sinv` | Write-only. Writing `1` clears `status_i.v` if `status_i.rdip=1`. If written together with `srdp`, `rdip` is set first and then `v` is cleared. Always reads 0. |
| `[49]` | `srdp` | Write-only. Writing `1` sets `status_i.rdip`. Always reads 0. |
| `[63:60]` | `custom` | Custom control bits (preserved across writes to other fields). |

### `status_i`

| Bits | Field | Description |
|---|---|---|
| `[0]` | `v` | Valid. `1` = record holds an unprocessed error. Register rejects software writes when `v=1`. |
| `[1]` | `ce` | Corrected error (sticky). |
| `[2]` | `ued` | Uncorrected error deferred (sticky). |
| `[3]` | `uec` | Uncorrected error critical (sticky). |
| `[5:4]` | `pri` | Priority of the recorded error. |
| `[6]` | `mo` | Multiple occurrences of same-severity error (hardwired to 0). |
| `[7]` | `c` | Error is containable. |
| `[10:8]` | `tt` | Transaction type. |
| `[11]` | `iv` | `info_i` is valid (hardwired to 0). |
| `[15:12]` | `ait` | Address/info type for `addr_info_i`. |
| `[16]` | `siv` | `suppl_info_i` is valid (hardwired to 0). |
| `[17]` | `tsv` | `timestamp_i` is valid (hardwired to 0). |
| `[20]` | `scrub` | Set to `1` by `scrub_ack_i` pulse while record is valid. |
| `[21]` | `ceco` | CE counter overflow. |
| `[23]` | `rdip` | Read-in-progress. Set on new error written to an empty record; cleared on overwrite of a valid record. Used with `sinv` to perform atomic read-invalidate. |
| `[31:24]` | `ec` | Error code (see spec Table 6). |
| `[63:48]` | `cec` | Corrected-error counter. Saturates at `0xFFFF`; sets `ceco` on overflow. |

## Error Capture and Overwrite Rules

A new fault on slot `i` is captured when `control_i.else=1` and either:
- the slot is empty (`v=0`), **or**
- the incoming `fault_in[i].pri` strictly exceeds the currently stored `pri`.

This implements the RERI overwrite policy: higher-severity errors always overwrite lower-severity ones; errors of the same severity overwrite only if they carry strictly higher priority. The `ce`, `ued`, and `uec` bits are **sticky** — when a higher-severity error overwrites a lower-severity record, the old severity bits are ORed in and retained.

`rdip` is set to `1` when a new error is written into an empty record (0→1 transition of `v`), and cleared to `0` when a new error overwrites a valid record.

## RAS Signal Generation

Three combinational output signals reflect the live state of all records:

- **`ras_lo`** — asserted when any enabled record holds a valid error configured for low-priority signaling.
- **`ras_hi`** — asserted when any enabled record holds a valid error configured for high-priority signaling.
- **`ras_plat`** — asserted when any enabled record holds a valid error configured for platform-specific signaling, **or** when an incoming fault cannot displace a stored record (overflow condition).

CE signaling behaviour depends on `cece`:
- `cece=0`: `ces` signal is asserted immediately on any valid CE record.
- `cece=1`: `ces` signal is asserted only on CE counter overflow (`ceco=1`).

## Error Injection

To test RAS handler software without injecting real hardware faults:

1. Write the desired error fields into `status_i` (while `v=0`).
2. Write a non-zero countdown value to `control_i.eid`.
3. The countdown decrements each clock cycle. When it reaches `0`, `status_i.v` is forced to `1` and the appropriate RAS signal is asserted.

## Implemented vs. Not Implemented

| Feature | Implemented |
|---|---|
| Error record capture with priority overwrite | Yes |
| Sticky error-class bits on overwrite | Yes |
| `rdip` / `sinv` atomic read-invalidate protocol | Yes |
| `valid_summary` bitmap (`sv=1`) | Yes |
| CE counter (`cec`) and overflow (`ceco`) | Yes |
| Scrub acknowledgement (`scrub`) | Yes |
| Error injection via `eid` countdown | Yes |
| RAS signals (`ras_lo`, `ras_hi`, `ras_plat`) | Yes |
| AHB-Lite bus interface with optional EDAC | Yes |
| `info_i` / `suppl_info_i` registers | No (hardwired 0) |
| `timestamp_i` register | No (hardwired 0) |
| `multiple-occurrence` (`mo`) bit | No (hardwired 0) |

## Integration Example

```systemverilog
reri_error_bank #(
    .N_RECORDS (4),
    .VENDOR_ID (32'h0000_0001),
    .IMP_ID    (32'h0000_0001),
    .INST_ID   (16'h0001)
) u_reri (
    .clk         (clk),
    .rst_n       (rst_n),
    // AHB-Lite slave signals ...
    .fault_in    (fault_bus),         // fault_record_t [3:0]
    .scrub_ack_i (4'b0),
    .ras_lo      (ras_lo),
    .ras_hi      (ras_hi),
    .ras_plat    (ras_plat)
);
```

## References

- RISC-V RERI Architecture Specification v1.0, RERI Task Group, 2024-05-24 (Ratified). Available at [link](https://riscv.atlassian.net/wiki/spaces/HOME/pages/809697310/RISC-V+RERI+Architecture) (accessed 2026-02-27).
