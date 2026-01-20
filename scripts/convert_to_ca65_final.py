#!/usr/bin/env python3
"""
Final complete conversion to ca65 syntax
"""

import re
import sys

INSTRUCTIONS = {
    'adc', 'and', 'asl', 'bcc', 'bcs', 'beq', 'bit', 'bmi', 'bne', 'bpl',
    'brk', 'bvc', 'bvs', 'clc', 'cld', 'cli', 'clv', 'cmp', 'cpx', 'cpy',
    'dec', 'dex', 'dey', 'eor', 'inc', 'inx', 'iny', 'jmp', 'jsr', 'lda',
    'ldx', 'ldy', 'lsr', 'nop', 'ora', 'pha', 'php', 'pla', 'plp', 'rol',
    'ror', 'rti', 'rts', 'sbc', 'sec', 'sed', 'sei', 'sta', 'stx', 'sty',
    'tax', 'tay', 'tsx', 'txa', 'txs', 'tya'
}

MACROS = set()

def find_macros(lines):
    macros = set()
    for line in lines:
        match = re.match(r'\.macro\s+(\w+)', line.strip())
        if match:
            macros.add(match.group(1))
    return macros

def is_constant_definition(line):
    return bool(re.match(r'^[a-zA-Z_]\w+\s*=\s*[\$0-9a-fA-F+\-*/<>]+', line.strip()))

def is_label(line, macros):
    stripped = line.lstrip()
    if not stripped or stripped.startswith(';') or stripped.startswith('.'):
        return False
    if is_constant_definition(line):
        return False
    first_word = stripped.split()[0] if stripped.split() else ''
    if not first_word:
        return False
    first_word = first_word.rstrip(':')
    if line[0] not in (' ', '\t'):
        if first_word.lower() not in INSTRUCTIONS and first_word not in macros:
            return True
    return False

def convert_string_quotes(line):
    if re.search(r'\.byte?\s+\'', line):
        def replace_quotes(match):
            content = match.group(0)
            if re.match(r"'[^']{2,}'", content) or re.match(r"'[^']*\s+[^']*'", content):
                return content.replace("'", '"')
            return content
        line = re.sub(r"'[^']*'", replace_quotes, line)
    return line

def convert_to_ca65(input_file, output_file):
    with open(input_file, 'r') as f:
        lines = f.readlines()

    global MACROS
    MACROS = find_macros(lines)
    print(f"Found macros: {MACROS}")

    output = []
    string_conversions = 0
    label_conversions = 0

    for line in lines:
        original = line.rstrip()
        if not original:
            output.append(original)
            continue

        converted = convert_string_quotes(original)
        if converted != original:
            string_conversions += 1
            original = converted

        if re.match(r'^\*=\$[0-9a-fA-F]+', original):
            addr = original.split('=')[1].strip()
            output.append('.org ' + addr)
            continue

        match = re.match(r'^\*=\*\+(\d+)', original)
        if match:
            size = match.group(1)
            output.append('.res ' + size)
            continue

        match = re.match(r'^(\w+)\s+\*=\*\+(\d+)(.*)$', original)
        if match:
            label = match.group(1)
            size = match.group(2)
            comment = match.group(3)
            output.append(f"{label}: .res {size}{comment}")
            continue

        if original.strip() == '.end':
            output.append('; .end removed')
            continue

        if is_constant_definition(original):
            output.append(original)
            continue

        if is_label(original, MACROS):
            label_part = original.split()[0] if original.split() else original
            if not label_part.endswith(':'):
                output.append(label_part + ':')
                label_conversions += 1
            else:
                output.append(original)
            continue

        output.append(original)

    with open(output_file, 'w') as f:
        for line in output:
            f.write(line + '\n')

    print(f"Converted {len(lines)} -> {len(output)} lines")
    print(f"String conversions: {string_conversions}")
    print(f"Label additions: {label_conversions}")

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: convert_to_ca65_final.py <input> <output>")
        sys.exit(1)
    convert_to_ca65(sys.argv[1], sys.argv[2])
