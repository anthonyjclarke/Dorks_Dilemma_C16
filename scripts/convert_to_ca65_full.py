#!/usr/bin/env python3
"""
Full conversion to ca65 syntax
"""

import re
import sys

def convert_to_ca65(input_file, output_file):
    with open(input_file, 'r') as f:
        lines = f.readlines()

    output = []

    for line in lines:
        original = line.rstrip()

        # Convert *= $addr to .org $addr (at start of line)
        if re.match(r'^\*=\$[0-9a-fA-F]+', original):
            addr = original.split('=')[1].strip()
            output.append('.org ' + addr)
            continue

        # Convert *=*+n to .res n (at start of line)
        match = re.match(r'^\*=\*\+(\d+)', original)
        if match:
            size = match.group(1)
            output.append('.res ' + size)
            continue

        # Convert label *=*+n to label: .res n (label with space allocation)
        match = re.match(r'^(\w+)\s+\*=\*\+(\d+)(.*)$', original)
        if match:
            label = match.group(1)
            size = match.group(2)
            comment = match.group(3)
            output.append(f"{label}: .res {size}{comment}")
            continue

        # Remove .end directive
        if original.strip() == '.end':
            output.append('; .end directive removed (not needed in ca65)')
            continue

        # Keep everything else
        output.append(original)

    with open(output_file, 'w') as f:
        for line in output:
            f.write(line + '\n')

    print(f"Converted {len(lines)} lines")
    print(f"Output: {output_file}")

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: convert_to_ca65_full.py <input> <output>")
        sys.exit(1)

    convert_to_ca65(sys.argv[1], sys.argv[2])
