/*
    reri_sim/test.c

    Reads and prints all valid error records from the RERI error bank.
    Designed to run on hardisc in simulation via sim_system.do.

    Memory map (from tb_mh_wrapper.sv):
        BOOTADD             = 0x10000000  (RAM, executable)
        STDOUT_REG          = 0x80000000  (control: char output, tracer display)
        HALT_REG            = 0x80000004  (control: write any value to halt sim)
        RERI_BASE           = 0x80002000  (RERI error bank, 4 KB)

    RERI register layout (RERI spec Table 2, 32-bit word accesses):
        HEADER (base + 0x00):
          +0x00  vendor_id      [31:0]
          +0x04  imp_id         [63:32]
          +0x08  bank_info_lo   [31:0]   inst_id[15:0], n_err_recs[21:16], layout[23:22]
          +0x0C  bank_info_hi   [63:32]  version[63:56]
          +0x10  valid_summary_lo [31:0] sv[0], valid_bitmap[31:1]
          +0x14  valid_summary_hi [63:32] valid_bitmap[63:32]

        Per-record i (0..N_RECORDS-1), base = RERI_BASE + 0x40 + 0x40*i:
          +0x00  control_lo     [31:0]   elase[0], cece[1], ces[3:2], ueds[5:4], uecs[7:6]
          +0x04  control_hi     [63:32]  eid[47:32], sinv[48], srdp[49]
          +0x08  status_lo      [31:0]   v[0], ce[1], ued[2], uec[3], pri[5:4], c[7], tt[10:8], ait[15:12], ec[31:24]
          +0x0C  status_hi      [63:32]  cec[63:48]
          +0x10  addr_info_lo   [31:0]   address (when ait != 0)
          +0x14  addr_info_hi   [63:32]  (upper 32 bits, always 0 on 32-bit hardisc)

    Software clear sequence for a valid record:
        Write control_hi with srdp[49]=1  (bit 17 of word at +0x04)
        Write control_hi with sinv[48]=1  (bit 16 of word at +0x04)
        → valid bit v clears on next read of status_lo
*/

/* bare-metal build: no C library, types and functions from stubs.c */
typedef unsigned char  uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int   uint32_t;

int  printf(const char *fmt, ...);
void exit(int status);

/* ── Memory-mapped addresses ─────────────────────────────────────── */
#define RERI_BASE       0x80002000u
#define N_RECORDS       4

/* ── RERI header offsets ─────────────────────────────────────────── */
#define RERI_VENDOR_ID          (*(volatile uint32_t *)(RERI_BASE + 0x00))
#define RERI_IMP_ID             (*(volatile uint32_t *)(RERI_BASE + 0x04))
#define RERI_BANK_INFO_LO       (*(volatile uint32_t *)(RERI_BASE + 0x08))
#define RERI_BANK_INFO_HI       (*(volatile uint32_t *)(RERI_BASE + 0x0C))
#define RERI_VALID_SUMMARY_LO   (*(volatile uint32_t *)(RERI_BASE + 0x10))
#define RERI_VALID_SUMMARY_HI   (*(volatile uint32_t *)(RERI_BASE + 0x14))

/* ── Per-record register accessors ──────────────────────────────── */
#define RERI_REC_BASE(i)        (RERI_BASE + 0x40u + 0x40u * (i))
#define RERI_CTRL_LO(i)         (*(volatile uint32_t *)(RERI_REC_BASE(i) + 0x00))
#define RERI_CTRL_HI(i)         (*(volatile uint32_t *)(RERI_REC_BASE(i) + 0x04))
#define RERI_STAT_LO(i)         (*(volatile uint32_t *)(RERI_REC_BASE(i) + 0x08))
#define RERI_STAT_HI(i)         (*(volatile uint32_t *)(RERI_REC_BASE(i) + 0x0C))
#define RERI_ADDR_LO(i)         (*(volatile uint32_t *)(RERI_REC_BASE(i) + 0x10))

/* ── status_lo bit fields ────────────────────────────────────────── */
#define STAT_V          (1u << 0)   /* valid */
#define STAT_CE         (1u << 1)   /* corrected error */
#define STAT_UED        (1u << 2)   /* uncorrected deferred */
#define STAT_UEC        (1u << 3)   /* uncorrected critical */
#define STAT_PRI(s)     (((s) >> 4) & 0x3u)
#define STAT_C          (1u << 7)   /* containable */
#define STAT_TT(s)      (((s) >> 8) & 0x7u)
#define STAT_AIT(s)     (((s) >> 12) & 0xFu)
#define STAT_EC(s)      (((s) >> 24) & 0xFFu)
#define STAT_RDIP       (1u << 23)

/* ── control_hi bits (written as 32-bit word to offset +0x0C) ───── */
#define CTRL_HI_SRDP    (1u << 17)  /* bit 49 of 64-bit register → bit 17 of hi word */
#define CTRL_HI_SINV    (1u << 16)  /* bit 48 of 64-bit register → bit 16 of hi word */

/* ── control_lo bit 0: elase (error logging and signaling enable) ─ */
#define CTRL_LO_ELASE   (1u << 0)

/* ── enable error logging on all records ────────────────────────── */
static void reri_enable_all(void)
{
    for (int i = 0; i < N_RECORDS; i++)
        RERI_CTRL_LO(i) = CTRL_LO_ELASE;
}

/* ── clear a valid record (sinv + srdp sequence) ────────────────── */
static void reri_clear_record(int i)
{
    RERI_CTRL_HI(i) = CTRL_HI_SRDP;
    RERI_CTRL_HI(i) = CTRL_HI_SINV;
}

/* ── main ────────────────────────────────────────────────────────── */
int main(void)
{
    printf("=== reri_sim started ===\n");

    /* Step 1: enable error logging on all records so faults get captured */
    reri_enable_all();

    /* Step 2: read bank identification */
    uint32_t bank_info = RERI_BANK_INFO_LO;
    uint32_t n_recs    = (bank_info >> 16) & 0x3Fu;
    uint32_t inst_id   = bank_info & 0xFFFFu;

    printf("RERI bank: inst_id=0x%04X n_records=%u\n", inst_id, n_recs);

    /* Step 3: poll valid_summary until at least one error appears or timeout */
    printf("Waiting for errors...\n");
    uint32_t timeout = 2000u;
    uint32_t summary = 0;
    while (timeout--) {
        summary = RERI_VALID_SUMMARY_LO;
        /* Bit 0 is the sv bit, always 1. Valid records are in bits [31:1]. */
        if (summary & ~1u)
            break;
    }

    printf("valid_summary=0x%08X\n", summary);

    if (!(summary & ~1u)) {
        printf("No errors captured (timeout).\n");
        exit(0);
    }

    /* Step 4: iterate records, report and clear each valid one */
    for (int i = 0; i < N_RECORDS; i++) {
        uint32_t stat = RERI_STAT_LO(i);
        if (!(stat & STAT_V))
            continue;

        uint32_t addr = (STAT_AIT(stat) != 0) ? RERI_ADDR_LO(i) : 0u;

        printf("  Record %d: ec=0x%02X pri=%u [%s%s%s%s] addr=0x%08X\n",
            i,
            STAT_EC(stat),
            STAT_PRI(stat),
            (stat & STAT_CE)  ? "CE "          : "",
            (stat & STAT_UED) ? "UED "         : "",
            (stat & STAT_UEC) ? "UEC "         : "",
            (stat & STAT_C)   ? "containable " : "",
            addr);

        reri_clear_record(i);
    }

    printf("Done.\n");

    exit(0);
}
