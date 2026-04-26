#!/bin/bash
# Build script for Dork's Dilemma C16
# Assembles source and creates executable PRG file

set -e

echo "=========================================="
echo "Dork's Dilemma C16 - Build Script"
echo "=========================================="
echo ""

mkdir -p build

echo "[1/4] Assembling source code..."
ca65 src/main_ca65.s -o build/dorks.o -t c16 -g
echo "      Assembly complete"

echo "[2/4] Linking binary..."
ld65 -C build/c16-final.cfg build/dorks.o -o build/dorks_final.bin --dbgfile build/dorks.dbg 2>&1 | grep -v "Warning.*STARTUP" || true
echo "      Linking complete"

echo "[3/4] Adding PRG header..."
python3 << 'EOF'
import struct
with open('build/dorks_final.bin', 'rb') as f:
    data = f.read()
with open('build/dorks.prg', 'wb') as f:
    f.write(struct.pack('<H', 0x1960))
    f.write(data)
print(f"      Created build/dorks.prg ({len(data)+2} bytes)")
EOF

echo "[4/4] Verifying binary..."
SIZE=$(stat -f%z build/dorks.prg 2>/dev/null || stat -c%s build/dorks.prg)
HEADER=$(xxd -l 2 -p build/dorks.prg)
if [ "$HEADER" = "6019" ]; then
    echo "      Load address correct: \$1960"
else
    echo "      ERROR: Invalid PRG header"
    exit 1
fi

echo ""
echo "=========================================="
echo "Build complete!"
echo "=========================================="
echo "Output file: build/dorks.prg ($SIZE bytes)"
echo ""
echo "To run in VICE emulator:"
echo "  xplus4 build/dorks.prg"
echo "  Then type: SYS 6496"
echo ""
