#!/usr/bin/env python3
#
#  Copyright 2023 Ján Mach
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#

"""
RISC-V instruction trace profiler.

Usage:
    python3 profiler.py <trace.log> <app.elf>

Log format (hex columns):
    <cycle>  <instruction_count>  <pc_address>

Output:
    Per-function entry count and total cycles spent.
"""

import sys
import subprocess
import argparse
import bisect
from collections import defaultdict


def get_function_symbols(elf_file):
    """Return sorted list of (start_addr, size, name) for all functions in the ELF."""
    result = subprocess.run(
        ['nm', '-S', '--defined-only', elf_file],
        capture_output=True, text=True
    )
    if result.returncode != 0:
        sys.exit(f"nm failed: {result.stderr.strip()}")

    symbols = []
    for line in result.stdout.splitlines():
        parts = line.split()
        try:
            if len(parts) == 4:
                addr_s, size_s, sym_type, name = parts
                size = int(size_s, 16)
            elif len(parts) == 3:
                addr_s, sym_type, name = parts
                size = 0
            else:
                continue
            if sym_type.upper() not in ('T', 'W'):
                continue
            symbols.append((int(addr_s, 16), size, name))
        except ValueError:
            continue

    return sorted(symbols, key=lambda x: x[0])


def build_lookup_table(symbols):
    """
    Build two parallel lists for fast binary-search lookup:
      starts[i]  -> start address of symbol i
      ranges[i]  -> (end_addr, name)

    Symbols with size==0 are extended to the next symbol's start.
    """
    starts = []
    ranges = []
    for i, (addr, size, name) in enumerate(symbols):
        if size > 0:
            end = addr + size
        elif i + 1 < len(symbols):
            end = symbols[i + 1][0]
        else:
            end = addr + 0x10000  # last symbol: give it a generous extent
        starts.append(addr)
        ranges.append((end, name))
    return starts, ranges


def lookup(starts, ranges, addr):
    """Return function name for addr, or None if not in any known function."""
    idx = bisect.bisect_right(starts, addr) - 1
    if idx < 0:
        return None
    end, name = ranges[idx]
    return name if addr < end else None


def parse_log(log_file):
    """Yield (cycle, addr) pairs from the trace log."""
    with open(log_file) as f:
        for lineno, line in enumerate(f, 1):
            parts = line.split()
            if len(parts) < 3:
                continue
            try:
                yield int(parts[0], 16), int(parts[2], 16)
            except ValueError:
                sys.exit(f"Bad log line {lineno}: {line.rstrip()!r}")


def profile(log_file, elf_file):
    symbols = get_function_symbols(elf_file)
    if not symbols:
        sys.exit("No function symbols found in ELF. Was it compiled with debug info / not stripped?")

    starts, ranges = build_lookup_table(symbols)
    func_addr = {name: addr for addr, _size, name in symbols}

    entries  = defaultdict(int)   # how many times entered
    cycles   = defaultdict(int)   # total cycles spent inside

    records = list(parse_log(log_file))
    if not records:
        sys.exit("Log file is empty or has no valid records.")

    prev_func = None

    for i, (cycle, addr) in enumerate(records):
        func = lookup(starts, ranges, addr)

        # Count an entry each time we (re-)enter a function from a different one
        if func != prev_func:
            if func:
                entries[func] += 1
            prev_func = func

        # Attribute the gap to the next record to the current function
        if func and i + 1 < len(records):
            cycles[func] += records[i + 1][0] - cycle

    return entries, cycles, func_addr


def main():
    parser = argparse.ArgumentParser(description="Profile a RISC-V instruction trace against an ELF.")
    parser.add_argument('log',  help="Instruction trace log file")
    parser.add_argument('elf',  help="Application ELF / object file")
    parser.add_argument('--min-cycles', type=int, default=0,
                        help="Hide functions with fewer total cycles (default: 0)")
    parser.add_argument('--sort', choices=['cycles', 'entries', 'name'], default='cycles',
                        help="Sort output by this column (default: cycles)")
    args = parser.parse_args()

    entries, cycles, func_addr = profile(args.log, args.elf)

    all_funcs = sorted(
        set(entries) | set(cycles),
        key=lambda f: (
            -cycles.get(f, 0)   if args.sort == 'cycles'  else
            -entries.get(f, 0)  if args.sort == 'entries' else
            f
        )
    )

    total_cycles = sum(cycles.values())

    col_w = max((len(f) for f in all_funcs), default=8)
    col_w = max(col_w, 8)
    header = f"{'Function':<{col_w}}  {'Address':>10}  {'Entries':>10}  {'Cycles':>15}  {'% of total':>10}"
    print(header)
    print('-' * len(header))

    for func in all_funcs:
        c = cycles.get(func, 0)
        if c < args.min_cycles:
            continue
        e = entries.get(func, 0)
        pct = 100.0 * c / total_cycles if total_cycles else 0.0
        addr = func_addr.get(func, 0)
        print(f"{func:<{col_w}}  {addr:#010x}  {e:>10}  {c:>15}  {pct:>9.2f}%")

    print('-' * len(header))
    print(f"{'TOTAL':<{col_w}}  {'':>10}  {'':>10}  {total_cycles:>15}  {'100.00%':>10}")


if __name__ == '__main__':
    main()
