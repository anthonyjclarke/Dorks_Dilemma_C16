#!/usr/bin/env python3
"""
Create a complete Dork's Dilemma PRG with all assets integrated.

This combines:
1. Character set (CHARS.BIN) at $3800
2. Screen data (DATASCRE.BIN) at $1000
3. Executable code (build/dorks_final.bin) at $1960

Output: build/dorks_complete.prg
"""

import struct
import sys

def read_file(path):
    """Read file and return contents."""
    with open(path, 'rb') as f:
        return f.read()

def main():
    print("Creating complete Dork's Dilemma PRG with assets...")

    # Read all components
    print("[1/4] Reading character set...")
    chars_data = read_file('Original_Files/CHARS.BIN')
    # CHARS.BIN has 2-byte header (00 38 = $3800), strip it
    chars_load_addr = struct.unpack('<H', chars_data[:2])[0]
    chars_data = chars_data[2:]  # Remove header
    print(f"      Character set: {len(chars_data)} bytes, load address: ${chars_load_addr:04X}")

    print("[2/4] Reading screen data...")
    # Use screen data extracted from original DORKSDIL.BIN
    try:
        screen_data = read_file('build/original_screen_data.bin')
        print(f"      Screen data: {len(screen_data)} bytes (extracted from original)")
    except FileNotFoundError:
        # Fallback to DATASCRE.BIN if original extract doesn't exist
        screen_data = read_file('Original_Files/DATASCRE.BIN')
        screen_load_addr_temp = struct.unpack('<H', screen_data[:2])[0]
        if screen_load_addr_temp == 0x1000:
            screen_data = screen_data[2:]
        print(f"      Screen data: {len(screen_data)} bytes (from DATASCRE.BIN)")
    screen_load_addr = 0x1000

    print("[3/4] Reading executable code...")
    code_data = read_file('build/dorks_final.bin')
    code_load_addr = 0x1960
    print(f"      Code: {len(code_data)} bytes, load address: ${code_load_addr:04X}")

    # Calculate memory layout
    # We need to create a single PRG that loads everything
    # Option 1: Load at $1000, include screen data + gap + code + gap + chars
    # Option 2: Create multi-load PRG (complex)
    # Option 3: Load code at $1960, use separate load for assets

    print("[4/4] Creating complete PRG...")
    print("      Strategy: Load at $1000 with all data")

    # Memory layout:
    # $1000-$xxxx: Screen data (compressed)
    # $1960-$xxxx: Code
    # $3800-$3FFF: Character set (2048 bytes)

    # Calculate total size needed
    base_addr = 0x1000
    code_offset = code_load_addr - base_addr  # $1960 - $1000 = $0960 (2400 bytes)
    chars_offset = chars_load_addr - base_addr  # $3800 - $1000 = $2800 (10240 bytes)

    # Total size to chars end
    total_size = chars_offset + len(chars_data)

    # Create memory buffer
    memory = bytearray(total_size)

    # Place components
    memory[0:len(screen_data)] = screen_data
    memory[code_offset:code_offset+len(code_data)] = code_data
    memory[chars_offset:chars_offset+len(chars_data)] = chars_data

    # Write PRG with $1000 load address
    with open('build/dorks_complete.prg', 'wb') as f:
        f.write(struct.pack('<H', base_addr))  # Load at $1000
        f.write(memory)

    output_size = len(memory) + 2
    print(f"      ✓ Created build/dorks_complete.prg ({output_size} bytes)")
    print(f"      Memory layout:")
    print(f"        $1000-${0x1000+len(screen_data)-1:04X}: Screen data ({len(screen_data)} bytes)")
    print(f"        $1960-${code_load_addr+len(code_data)-1:04X}: Code ({len(code_data)} bytes)")
    print(f"        $3800-${chars_load_addr+len(chars_data)-1:04X}: Charset ({len(chars_data)} bytes)")
    print()
    print("To run:")
    print("  xplus4 build/dorks_complete.prg")
    print("  Then type: SYS 6496")
    print()

if __name__ == '__main__':
    main()
