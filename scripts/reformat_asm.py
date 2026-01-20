#!/usr/bin/env python3
"""
Comprehensive 6502 assembly source reformatter
"""

import re

def reformat_assembly(input_file, output_file):
    with open(input_file, 'r') as f:
        lines = f.readlines()

    formatted = []
    blank_count = 0

    for i, line in enumerate(lines):
        # Remove trailing whitespace
        line = line.rstrip()

        # Handle blank lines - allow max 1 consecutive
        if not line:
            blank_count += 1
            if blank_count <= 1:
                formatted.append('')
            continue
        else:
            blank_count = 0

        # Process comment-only lines
        if line.lstrip().startswith(';'):
            # Handle different comment styles
            stripped = line.lstrip()

            # Section dividers (keep as-is)
            if re.match(r';[\s=\-]{20,}', stripped):
                formatted.append(stripped)
            # Empty comment separator
            elif stripped == ';':
                formatted.append(';')
            # Comment with content
            else:
                # Remove extra semicolons and spaces, keep one space after semicolon
                comment_text = stripped.lstrip(';').lstrip()
                if comment_text:
                    formatted.append('; ' + comment_text)
                else:
                    formatted.append(';')
        else:
            # Code line with possible inline comment
            if ';' in line:
                # Split code and comment
                parts = line.split(';', 1)
                code = parts[0].rstrip()
                comment = parts[1].lstrip()

                # Standardize inline comments with ;* marker or regular ;
                if comment.startswith('*'):
                    formatted.append(code + ' ;* ' + comment[1:].lstrip())
                else:
                    formatted.append(code + ' ; ' + comment)
            else:
                # Pure code line
                formatted.append(line)

    # Remove trailing blank lines
    while formatted and formatted[-1] == '':
        formatted.pop()

    # Write output with newlines
    with open(output_file, 'w') as f:
        for line in formatted:
            f.write(line + '\n')

    original_lines = len(lines)
    new_lines = len(formatted)
    print(f"Reformatted: {original_lines} -> {new_lines} lines ({original_lines - new_lines} removed)")

if __name__ == '__main__':
    import sys
    if len(sys.argv) != 3:
        print("Usage: reformat_asm.py <input> <output>")
        sys.exit(1)

    reformat_assembly(sys.argv[1], sys.argv[2])
