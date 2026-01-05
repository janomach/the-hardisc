OUTPUT_FORMAT("elf32-littleriscv", "elf32-littleriscv",
	      "elf32-littleriscv")
OUTPUT_ARCH(riscv)
ENTRY(_start)

MEMORY
{
  ram      (rwx) : ORIGIN = 0x00000000, LENGTH = 0x0000100
}

/* Section Definitions */
SECTIONS
{
  .init (0x0):
  {
    KEEP (*(SORT_NONE(.init)))
    KEEP (*(.text.start))
  } >ram

  /* interrupt */
  .vectors        :
  {
    PROVIDE(__interrupt = .);
    KEEP(*(.interrupt));
  } >ram
}
