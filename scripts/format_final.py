#!/usr/bin/env python3
"""
Final comprehensive 6502 assembly formatter
- Remove standalone semicolon lines
- Standardize section separators
- Remove completely empty lines between code sections
- Preserve only meaningful blank lines
"""

import re

def is_section_divider(line):
    """Check if line is a section divider"""
    return bool(re.match(r';[\s=\-]{20,}', line.strip()))

def is_empty_comment(line):
    """Check if line is just a semicolon with nothing else"""
    stripped = line.strip()
    return stripped == ';' or stripped == ''

def reformat_final(input_file, output_file):
    with open(input_file, 'r') as f:
        lines = f.readlines()

    formatted = []
    prev_was_empty = False
    in_section_header = False

    for i, line in enumerate(lines):
        line = line.rstrip()

        # Check if this is a section divider
        if is_section_divider(line):
            # Add blank line before divider if previous wasn't empty
            if formatted and not prev_was_empty:
                formatted.append('')
            formatted.append(line)
            in_section_header = True
            prev_was_empty = False
            continue

        # Handle empty lines and standalone semicolons
        if is_empty_comment(line):
            # Skip standalone semicolons completely
            if line.strip() == ';':
                continue
            # Allow one blank line for spacing, but not after dividers
            if not prev_was_empty and not in_section_header:
                formatted.append('')
                prev_was_empty = True
            continue

        # We have content
        in_section_header = False
        prev_was_empty = False

        # Process comment-only lines
        if line.lstrip().startswith(';'):
            stripped = line.lstrip()

            # Section dividers already handled above
            if is_section_divider(stripped):
                formatted.append(stripped)
            else:
                # Regular comment with content
                comment_text = stripped.lstrip(';').lstrip()
                if comment_text:
                    formatted.append('; ' + comment_text)
                else:
                    # Empty comment - skip it
                    continue
        else:
            # Code line with possible inline comment
            if ';' in line:
                parts = line.split(';', 1)
                code = parts[0].rstrip()
                comment = parts[1].lstrip()

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

    # Write output
    with open(output_file, 'w') as f:
        for line in formatted:
            f.write(line + '\n')

    print(f"Reformatted: {len(lines)} -> {len(formatted)} lines ({len(lines) - len(formatted)} removed)")

    # Count standalone semicolons removed
    standalone_semicolons = sum(1 for line in lines if line.strip() == ';')
    print(f"Removed {standalone_semicolons} standalone semicolon lines")

if __name__ == '__main__':
    import sys
    if len(sys.argv) != 3:
        print("Usage: format_final.py <input> <output>")
        sys.exit(1)

    reformat_final(sys.argv[1], sys.argv[2])
