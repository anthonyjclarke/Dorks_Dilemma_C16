#!/usr/bin/env python3
"""
Reformat 6502 assembly source for consistency
- Remove excessive blank lines (max 2 consecutive)
- Standardize comment formatting
- Remove trailing whitespace
- Ensure consistent section dividers
"""

import re
import sys

def reformat_assembly(input_file, output_file):
    with open(input_file, 'r') as f:
        lines = f.readlines()

    formatted = []
    blank_count = 0

    for line in lines:
        # Remove trailing whitespace
        line = line.rstrip() + '\n'

        # Track consecutive blank lines
        if line.strip() == '':
            blank_count += 1
            if blank_count <= 2:  # Allow max 2 consecutive blank lines
                formatted.append(line)
        else:
            blank_count = 0

            # Standardize comment-only lines
            if line.lstrip().startswith(';'):
                # Remove excessive semicolons at start
                stripped = line.lstrip(';').lstrip()
                if stripped == '':
                    # Empty comment line
                    formatted.append(';\n')
                else:
                    # Regular comment
                    formatted.append('; ' + stripped if not stripped.startswith(' ') else ';' + stripped)
            else:
                # Code line - preserve as is (already stripped trailing space)
                formatted.append(line)

    # Remove trailing blank lines
    while formatted and formatted[-1].strip() == '':
        formatted.pop()

    # Ensure file ends with single newline
    if formatted and not formatted[-1].endswith('\n'):
        formatted[-1] += '\n'

    with open(output_file, 'w') as f:
        f.writelines(formatted)

    print(f"Reformatted {len(lines)} lines -> {len(formatted)} lines")
    print(f"Removed {len(lines) - len(formatted)} lines")

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: reformat_source.py <input> <output>")
        sys.exit(1)

    reformat_assembly(sys.argv[1], sys.argv[2])
