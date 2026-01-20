#!/usr/bin/env python3
"""
Convert original syntax to ca65 syntax
- *= $addr  -> .org $addr
- *=*+n     -> .res n
- .end      -> remove
"""

import re
import sys

def convert_to_ca65(input_file, output_file):
    with open(input_file, 'r') as f:
        lines = f.readlines()

    output = []

    for line in lines:
        original = line.rstrip()

        # Convert *= $addr to .org $addr
        if re.match(r'^\*=\$[0-9a-fA-F]+', original):
            addr = original.split('=')[1].strip()
            output.append('.org ' + addr)
            continue

        # Convert *=*+n to .res n
        match = re.match(r'^\*=\*\+(\d+)', original)
        if match:
            size = match.group(1)
            output.append('.res ' + size)
            continue

        # Remove .end directive (not needed in ca65)
        if original.strip() == '.end':
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
        print("Usage: convert_to_ca65.py <input> <output>")
        sys.exit(1)

    convert_to_ca65(sys.argv[1], sys.argv[2])
