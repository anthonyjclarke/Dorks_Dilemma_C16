#!/usr/bin/env python3
"""
Analyze DORKSDIL.BIN to find missing chkbmb and fillex routines
"""

import sys

def load_binary(filename, load_addr=0x1960):
    """Load binary and return as memory dict"""
    with open(filename, 'rb') as f:
        data = f.read()
    return {load_addr + i: byte for i, byte in enumerate(data)}

def disasm_6502(memory, addr):
    """Simple 6502 disassembler for single instruction"""
    opcodes = {
        0x4C: ('JMP abs', 3),
        0x20: ('JSR abs', 3),
        0x60: ('RTS impl', 1),
        0xD0: ('BNE rel', 2),
        0xF0: ('BEQ rel', 2),
        0xB0: ('BCS rel', 2),
        0x90: ('BCC rel', 2),
        0xA9: ('LDA #', 2),
        0xA5: ('LDA zp', 2),
        0x85: ('STA zp', 2),
        0xAA: ('TAX impl', 1),
        0xA8: ('TAY impl', 1),
        0xE8: ('INX impl', 1),
        0xCA: ('DEX impl', 1),
        0xC8: ('INY impl', 1),
        0x88: ('DEY impl', 1),
    }

    opcode = memory.get(addr, 0)
    if opcode in opcodes:
        mnem, size = opcodes[opcode]

        if size == 1:
            return f"{mnem}", size
        elif size == 2:
            operand = memory.get(addr + 1, 0)
            if 'rel' in mnem:  # Branch - relative addressing
                # Calculate target
                offset = operand if operand < 128 else operand - 256
                target = addr + 2 + offset
                return f"{mnem} ${target:04X}", size
            else:
                return f"{mnem} ${operand:02X}", size
        elif size == 3:
            lo = memory.get(addr + 1, 0)
            hi = memory.get(addr + 2, 0)
            target = (hi << 8) | lo
            return f"{mnem} ${target:04X}", size

    return f".byte ${opcode:02X}", 1

def find_all_jsr(memory, start, end):
    """Find all JSR instructions and their targets"""
    jsr_map = {}
    addr = start
    while addr < end:
        if memory.get(addr) == 0x20:  # JSR
            lo = memory.get(addr + 1, 0)
            hi = memory.get(addr + 2, 0)
            target = (hi << 8) | lo
            if target not in jsr_map:
                jsr_map[target] = []
            jsr_map[target].append(addr)
            addr += 3
        else:
            addr += 1
    return jsr_map

def find_routine_end(memory, start_addr, max_search=100):
    """Find RTS that ends a routine"""
    for offset in range(max_search):
        addr = start_addr + offset
        if memory.get(addr) == 0x60:  # RTS
            return addr
    return None

def analyze_binary(filename):
    """Main analysis"""
    memory = load_binary(filename)

    print("=" * 70)
    print("DORKSDIL.BIN Analysis - Finding chkbmb and fillex")
    print("=" * 70)

    # Find all JSR targets
    print("\nFinding all JSR instructions...")
    jsr_map = find_all_jsr(memory, 0x1960, 0x5000)

    # Sort by number of calls (chkbmb is called 3 times)
    targets_by_calls = {}
    for target, callers in jsr_map.items():
        count = len(callers)
        if count not in targets_by_calls:
            targets_by_calls[count] = []
        targets_by_calls[count].append((target, callers))

    # Show JSR targets called exactly 3 times (chkbmb candidate)
    print("\nJSR targets called exactly 3 times (chkbmb candidate):")
    print("-" * 70)
    if 3 in targets_by_calls:
        for target, callers in targets_by_calls[3]:
            print(f"\nTarget: ${target:04X}")
            print(f"Called from: {', '.join(f'${c:04X}' for c in callers)}")

            # Disassemble the routine
            print(f"\nDisassembly of ${target:04X}:")
            addr = target
            for i in range(20):  # Show first 20 instructions
                disasm, size = disasm_6502(memory, addr)
                print(f"  ${addr:04X}: {disasm}")
                if memory.get(addr) == 0x60:  # RTS
                    break
                addr += size

    # Show statistics
    print("\n" + "=" * 70)
    print("JSR Statistics:")
    print(f"Total unique JSR targets: {len(jsr_map)}")
    for count in sorted(targets_by_calls.keys(), reverse=True)[:10]:
        print(f"  Called {count} times: {len(targets_by_calls[count])} routines")

    # Look for common patterns near bomb code
    print("\n" + "=" * 70)
    print("Searching for bomb-related patterns...")
    print("(Looking for sequences with sta/lda #$ff/inc/dec patterns)")
    print("-" * 70)

    # Pattern: sta something, sta something, sta something, sta something
    # This matches: sta stopa, sta stopb, sta stopc, sta stopd
    for addr in range(0x1960, 0x4800):
        if (memory.get(addr) == 0x85 and      # STA zp
            memory.get(addr+2) == 0x85 and
            memory.get(addr+4) == 0x85 and
            memory.get(addr+6) == 0x85):
            print(f"\nFound 4x STA pattern at ${addr:04X}:")
            for i in range(10):
                disasm, size = disasm_6502(memory, addr + i*2)
                print(f"  ${addr + i*2:04X}: {disasm}")

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("Usage: find_missing_code.py <DORKSDIL.BIN>")
        sys.exit(1)

    analyze_binary(sys.argv[1])
