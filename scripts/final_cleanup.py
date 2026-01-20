#!/usr/bin/env python3
"""
Final cleanup - remove duplicate/old comments, keep new documentation
"""

import re

def final_cleanup(input_file, output_file):
    with open(input_file, 'r') as f:
        lines = f.readlines()

    output = []
    skip_until_code = False
    last_was_section = False
    in_function_doc = False

    for i, line in enumerate(lines):
        line = line.rstrip()

        # Detect new function documentation blocks
        if '----------------------------------------------------------------------' in line:
            if i + 1 < len(lines) and not lines[i+1].strip().startswith(';'):
                # This is end of header block before code
                output.append(line)
                last_was_section = True
                in_function_doc = False
                continue
            elif 'MODULE:' in line or any(word in line for word in ['PLAY', 'REDJOS', 'SETIRQ', 'RANDOM', 'CLVARS', 'CLSWIN']):
                # Start of function documentation
                in_function_doc = True
                output.append(line)
                continue
            else:
                output.append(line)
                last_was_section = True
                continue

        # Skip old comment blocks that come after new documentation
        if in_function_doc and line.strip().startswith(';'):
            # Check if this is outdated comment marker like ;****** or duplicate description
            stripped = line.strip()
            if re.match(r';[\*\-]{3,}', stripped):
                # Old separator - skip it
                continue
            # Keep the line if it's part of new documentation
            output.append(line)
            continue

        # Detect code line (function label or instruction)
        if line and not line[0].isspace() and not line.startswith(';'):
            in_function_doc = False
            skip_until_code = False

        # Skip redundant comment separators like ;------ when not part of section header
        if re.match(r';\-{10,}', line.strip()) and not last_was_section:
            continue

        # Skip old-style comment markers ;********
        if re.match(r';\*{5,}', line.strip()):
            continue

        output.append(line)
        last_was_section = False

    # Write output
    with open(output_file, 'w') as f:
        for line in output:
            f.write(line + '\n')

    print(f"Final cleanup: {len(lines)} -> {len(output)} lines")

if __name__ == '__main__':
    import sys
    if len(sys.argv) != 3:
        print("Usage: final_cleanup.py <input> <output>")
        sys.exit(1)

    final_cleanup(sys.argv[1], sys.argv[2])
