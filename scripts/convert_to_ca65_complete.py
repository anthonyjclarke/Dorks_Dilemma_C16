#!/usr/bin/env python3
"""
Complete conversion to ca65 syntax with colon-added labels
"""

import re
import sys

# Known 6502 instructions (must be complete list)
INSTRUCTIONS = {
    'adc', 'and', 'asl', 'bcc', 'bcs', 'beq', 'bit', 'bmi', 'bne', 'bpl',
    'brk', 'bvc', 'bvs', 'clc', 'cld', 'cli', 'clv', 'cmp', 'cpx', 'cpy',
    'dec', 'dex', 'dey', 'eor', 'inc', 'inx', 'iny', 'jmp', 'jsr', 'lda',
    'ldx', 'ldy', 'lsr', 'nop', 'ora', 'pha', 'php', 'pla', 'plp', 'rol',
    'ror', 'rti', 'rts', 'sbc', 'sec', 'sed', 'sei', 'sta', 'stx', 'sty',
    'tax', 'tay', 'tsx', 'txa', 'txs', 'tya'
}

def is_label(line):
    """Check if line is a label (starts column 1, not an instruction)"""
    stripped = line.lstrip()
    if not stripped or stripped.startswith(';') or stripped.startswith('.'):
        return False

    # Get first word
    first_word = stripped.split()[0] if stripped.split() else ''
    if not first_word:
        return False

    # Remove trailing colon if exists
    first_word = first_word.rstrip(':')

    # Check if it starts at column 1 and is not an instruction
    if line[0] not in (' ', '\t') and first_word.lower() not in INSTRUCTIONS:
        return True

    return False

def convert_to_ca65(input_file, output_file):
    with open(input_file, 'r') as f:
        lines = f.readlines()

    output = []

    for line in lines:
        original = line.rstrip()

        # Skip empty lines
        if not original:
            output.append(original)
            continue

        # Convert *= $addr to .org $addr
        if re.match(r'^\*=\$[0-9a-fA-F]+', original):
            addr = original.split('=')[1].strip()
            output.append('.org ' + addr)
            continue

        # Convert *=*+n to .res n (standalone)
        match = re.match(r'^\*=\*\+(\d+)', original)
        if match:
            size = match.group(1)
            output.append('.res ' + size)
            continue

        # Convert label *=*+n to label: .res n
        match = re.match(r'^(\w+)\s+\*=\*\+(\d+)(.*)$', original)
        if match:
            label = match.group(1)
            size = match.group(2)
            comment = match.group(3)
            output.append(f"{label}: .res {size}{comment}")
            continue

        # Remove .end directive
        if original.strip() == '.end':
            output.append('; .end removed (not needed in ca65)')
            continue

        # Add colon to labels that don't have one
        if is_label(original):
            label_part = original.split()[0] if original.split() else original
            if not label_part.endswith(':'):
                output.append(label_part + ':')
            else:
                output.append(original)
            continue

        # Keep everything else
        output.append(original)

    with open(output_file, 'w') as f:
        for line in output:
            f.write(line + '\n')

    print(f"Converted {len(lines)} lines -> {len(output)} lines")

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: convert_to_ca65_complete.py <input> <output>")
        sys.exit(1)

    convert_to_ca65(sys.argv[1], sys.argv[2])
