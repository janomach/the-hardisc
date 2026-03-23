#!/usr/bin/env bash
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

set -euo pipefail

if [[ $# -ne 3 ]]; then
    echo "Usage: $0 <max_memory_size_hex> <serial_port> <binary_file>"
    echo "  max_memory_size_hex  Maximum memory size in hexadecimal (e.g. 10000)"
    echo "  serial_port          Path to serial port device (e.g. /dev/ttyUSB0)"
    echo "  binary_file          Path to binary file to send"
    exit 1
fi

MEM_SIZE_HEX="$1"
SERIAL_PORT="$2"
BINARY_FILE="$3"

# Validate hex input
if ! [[ "$MEM_SIZE_HEX" =~ ^[0-9a-fA-F]+$ ]]; then
    echo "Error: memory size '$MEM_SIZE_HEX' is not a valid hexadecimal value" >&2
    exit 1
fi

# Validate serial port
if [[ ! -e "$SERIAL_PORT" ]]; then
    echo "Error: serial port '$SERIAL_PORT' does not exist" >&2
    exit 1
fi

# Validate binary file
if [[ ! -f "$BINARY_FILE" ]]; then
    echo "Error: binary file '$BINARY_FILE' does not exist" >&2
    exit 1
fi

MEM_SIZE=$(( 16#$MEM_SIZE_HEX ))
BIN_SIZE=$(stat -c '%s' "$BINARY_FILE")
BIN_SIZE_HEX=$(printf '%X' "$BIN_SIZE")
PADDING=$(( MEM_SIZE - BIN_SIZE ))

echo "Memory size : 0x${MEM_SIZE_HEX^^}"
echo "Binary size : 0x${BIN_SIZE_HEX}"

if (( PADDING < 0 )); then
    echo "Error: binary file ($BIN_SIZE bytes) exceeds memory size ($MEM_SIZE bytes)" >&2
    exit 1
fi

echo "Sending binary file to $SERIAL_PORT..."
cat "$BINARY_FILE" > "$SERIAL_PORT"

echo "Sending $PADDING random padding bytes to $SERIAL_PORT..."
dd if=/dev/urandom bs=1 count="$PADDING" 2>/dev/null > "$SERIAL_PORT"

echo "Done."
