#!/usr/bin/env python3
"""
Patch the original DORKSDIL.BIN with our rebuilt code.
This keeps the original screen data and assets but uses our fixed code.
"""

def main():
    print("Creating patched binary...")

    # Read original (working) binary
    with open('Original_Files/DORKSDIL.BIN', 'rb') as f:
        original = bytearray(f.read())

    # Read our rebuilt code
    with open('build/dorks_final.bin', 'rb') as f:
        our_code = f.read()

    # Code starts at offset $1960 - $1000 + 2 (for PRG header) = $0962
    code_start = 0x1960 - 0x1000 + 2
    code_end = code_start + len(our_code)

    print(f"Original binary: {len(original)} bytes")
    print(f"Our code: {len(our_code)} bytes")
    print(f"Patching offset ${code_start:04X} to ${code_end:04X}")

    # Check if our code fits
    if code_end > len(original):
        print(f"ERROR: Our code ({len(our_code)} bytes) is too large!")
        print(f"Original code section: {len(original) - code_start} bytes")
        return

    # Patch the code section
    original[code_start:code_end] = our_code

    # Write patched version
    with open('build/dorks_patched.prg', 'wb') as f:
        f.write(original)

    print(f"✓ Created build/dorks_patched.prg ({len(original)} bytes)")
    print()
    print("This binary has:")
    print("  - Original screen data and assets (working)")
    print("  - Our rebuilt code with fixes")
    print()
    print("To test:")
    print("  xplus4 build/dorks_patched.prg")
    print("  Then type: SYS 6496")
    print()

if __name__ == '__main__':
    main()
