#!/usr/bin/env python3
"""
Extract chkbmb and fillex from disassembly by matching code patterns
"""

import re

def find_bomb_fill_in_disasm(disasm_file):
    """Find the bomb fill code that calls chkbmb"""
    with open(disasm_file, 'r') as f:
        lines = f.readlines()

    # Pattern: 4x "sta $7D/7E/7F/80" followed by bomb fill logic
    for i, line in enumerate(lines):
        if ('sta     $7D' in line and
            i+1 < len(lines) and 'sta     $7E' in lines[i+1] and
            i+2 < len(lines) and 'sta     $7F' in lines[i+2] and
            i+3 < len(lines) and 'sta     $80' in lines[i+3]):

            print("=" * 70)
            print(f"Found bomb fill code at line {i+1}:")
            print("=" * 70)

            # Extract surrounding context (50 lines after)
            for j in range(max(0, i-5), min(len(lines), i+100)):
                print(f"{j+1:5}: {lines[j]}", end='')

            # Look for JSR calls in this section
            print("\n" + "=" * 70)
            print("JSR calls in bomb fill section:")
            print("=" * 70)
            jsr_targets = set()
            for j in range(i, min(len(lines), i+100)):
                if 'jsr' in lines[j].lower():
                    match = re.search(r'jsr\s+(L[0-9A-F]+)', lines[j])
                    if match:
                        target = match.group(1)
                        jsr_targets.add(target)
                        print(f"Line {j+1}: {lines[j]}", end='')

            return jsr_targets

    return set()

def extract_routine(disasm_file, label):
    """Extract a routine from disassembly by label"""
    with open(disasm_file, 'r') as f:
        lines = f.readlines()

    # Find the label
    for i, line in enumerate(lines):
        if line.strip().startswith(f'{label}:'):
            print("=" * 70)
            print(f"Found {label} at line {i+1}:")
            print("=" * 70)

            # Extract until RTS or JMP
            for j in range(i, min(len(lines), i+100)):
                print(f"{j+1:5}: {lines[j]}", end='')
                if ('rts' in lines[j].lower() or
                    'jmp' in lines[j].lower() or
                    (j > i+5 and lines[j][0] not in ' \t' and ':' in lines[j])):
                    break

            return True

    print(f"Label {label} not found")
    return False

if __name__ == '__main__':
    disasm_file = 'disassembly/dorksdil_full.s'

    print("\n" + "#" * 70)
    print("# STEP 1: Find chkbmb by locating bomb fill code")
    print("#" * 70 + "\n")

    jsr_targets = find_bomb_fill_in_disasm(disasm_file)

    if jsr_targets:
        print("\n" + "#" * 70)
        print("# STEP 2: Extract the JSR targets (chkbmb candidates)")
        print("#" * 70 + "\n")

        for target in sorted(jsr_targets):
            extract_routine(disasm_file, target)
            print("\n")
