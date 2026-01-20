#!/bin/bash
# Launch VICE emulator with the compiled program

PRG_FILE="${1:-dorks_dilemma.prg}"
EMULATOR="xplus4"

# Check if VICE is installed
if ! command -v $EMULATOR &> /dev/null; then
    echo "ERROR: VICE emulator not found!"
    echo "Install with: brew install vice"
    exit 1
fi

# Check if program file exists
if [ ! -f "$PRG_FILE" ]; then
    echo "ERROR: Program file not found: $PRG_FILE"
    exit 1
fi

echo "Launching VICE emulator..."
echo "Program: $PRG_FILE"
echo ""

# Launch VICE with autostart
$EMULATOR -autostart "$PRG_FILE" &

# Optional: Enable monitor for debugging
# $EMULATOR -remotemonitor -autostart "$PRG_FILE" &

echo "VICE launched in background (PID: $!)"
