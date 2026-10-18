# Dork's Dilemma - Build Instructions

## Overview

This project preserves the recovered source and restoration work for **Dork's Dilemma**, a Commodore C16/Plus4 game written by Anthony Clarke at Micro-Projects Ltd. in 1985. **Rooms of Peril** was the original development name. Gremlin Graphics in Sheffield rebranded it as **Dork's Dilemma** for publication and launch.

See [Development History](docs/DEVELOPMENT_HISTORY.md) for Anthony's account of editing and assembling on a C64, sharing a 1541 with the C16 for testing, and recovering the original disks. The [Recovered Disk and Folder Contents](docs/RECOVERED_DISK_CONTENTS.md) catalogues the supplied images, source, object records, and possible development aids. Detailed research into the individual tools is planned for a later revision.

These new documents record the current preservation context. The build and status reports below describe earlier restoration work; their claims of completeness have not been revalidated against the newly supplied disk images.

**Status: Restoration in progress.** The fresh C16 disk image contains source missing from the earlier conversion, including the continuation of the bomb routine. Integration and verification of that source are still pending. Static analysis also found instructions lost during modern source conversion.

Earlier work reports successful assembly after reconstructing `fillex` and `chkbmb` from the surviving binary. Successful assembly does not establish source completeness or equivalence to the original game. The later April 2026 commit reports partial title-screen rendering and an unresolved transition into gameplay; it is not yet incorporated into this checkout.

`Original_Files/DORKSDIL.BIN` is the surviving reference binary, reported by earlier project work to run in VICE. Whether it is a release or development build is unknown. No new build or emulator validation has been performed for this checkpoint.

See [docs/FINAL_STATUS.md](docs/FINAL_STATUS.md) and [docs/DISASSEMBLY_REVERSE_ENGINEERING.md](docs/DISASSEMBLY_REVERSE_ENGINEERING.md) for historical investigation reports. The current restoration will compare their inferred repairs with the recovered original C16 source and establish a reproducible build before claiming a working restoration.

## Files in This Archive

### Source Code

- **src/main.s** - Reformatted assembly source (4,831 lines, ca65-ready)
- **src/main_ca65.s** - Fully converted ca65 version (100% assembly success)
- **src/missing_routines.s** - Recovered functions from binary disassembly
- **src/macros.s** - Modern macro definitions (dpinc, dpdec)
- **Original_Files/\*.TXT** - 44 original source modules (historical reference)
- **archive/legacy_source/** - Early consolidated versions
- **CODEBASE_ANALYSIS.md** - Detailed code documentation
- **docs/DISASSEMBLY_REVERSE_ENGINEERING.md** - Function recovery process

### Binary Assets
- **DORKSDIL.BIN** - Original compiled game (12,290 bytes)
- **CHARS.BIN, CAMEL.BIN, etc.** - Graphics data
- **DATASCRE.BIN, MUFF.BIN** - Compressed screen data

### Build Tools
- **ASMC64.BAS** - Original C64-based assembler
- **HYPRALOA.BAS** - Loader system
- **INDEX** - Original disk directory listing

## Quick Start - Modern Build

### Option 1: Using ca65 (Recommended)

```bash
# Install cc65 toolchain
brew install cc65  # macOS
# or
sudo apt install cc65  # Linux

# Use the automated build script
./build.sh

# This will:
# - Assemble src/main_ca65.s with recovered missing_routines.s
# - Link to build/dorks.prg
# - Result: 7,730 byte PRG file with 100% assembly success

# Or manually:
ca65 src/main_ca65.s -o build/main.o -t c16
ca65 src/missing_routines.s -o build/missing.o -t c16
ld65 build/main.o build/missing.o -o build/dorks.prg -t c16
```

**Note:** Assembly is 100% complete with ZERO undefined symbols. The two previously missing functions (`fillex` and `chkbmb`) have been recovered from DORKSDIL.BIN through reverse engineering.

### Option 2: Using ACME Assembler

```bash
# Install ACME
brew install acme  # macOS
# or download from: https://sourceforge.net/projects/acme-crossass/

# ACME syntax is closer to the original:
# Main changes needed:
# 1. Replace .lib with !source
# 2. Replace .mac/.mnd with macro syntax
# 3. Replace *=*+n with !skip n

# Assemble
acme -f cbm -o dorks_dilemma.prg dorks_dilemma.asm
```

### Option 3: Using KickAssembler

```bash
# Download from: http://theweb.dk/KickAssembler/
# Requires Java

# Syntax conversion needed:
# 1. More extensive - see KickAssembler docs
# 2. Very powerful for adding modern features

# Assemble
java -jar KickAss.jar dorks_dilemma.asm -o dorks_dilemma.prg
```

## Testing the Game

### VICE Emulator (Recommended)

```bash
# Install VICE
brew install vice  # macOS
sudo apt install vice  # Linux

# Run the original binary
/usr/local/Cellar/vice/3.10/bin/xplus4 DORKSDIL.BIN

# Or run your newly compiled version
/usr/local/Cellar/vice/3.10/bin/xplus4 build/dorks_dilemma.prg

# Load with:
# LOAD "DORKSDIL.BIN",8,1
# SYS 6496
# (or just run it - it has auto-start)
```

**Note:** On macOS, VICE 3.10 may show a path warning. Use the full executable path shown above.

### Real Hardware

Transfer `.prg` file to C16/Plus4 via:
- SD2IEC device
- 1541 Ultimate
- Tape/disk transfer tools

## Game Controls

### Keyboard Mode
- Cursor keys - Movement
- Space - Fire/Action
- ESC - Pause/Menu

### Joystick Mode
- Port 1
- Directional movement
- Button - Fire/Action

## Source Code Modifications

### Conversion Status

The source has been reformatted and converted for modern assemblers:

- **Original source:** 7,505 lines across 44 modules
- **Reformatted:** 4,831 lines (35.5% reduction)
- **Documented:** 37 major functions with detailed headers
- **Missing functions recovered:** 2 (fillex, chkbmb) via binary disassembly
- **Assembly status:** 100% success (ZERO undefined symbols) ✅

The conversion script [scripts/convert_to_ca65_final.py](scripts/convert_to_ca65_final.py) handles:

- Macro syntax (.mac/.mnd → .macro/.endmacro)
- Memory directives (*= → .org, *=*+n → .res)
- String literals ('text' → "text")
- Constant definitions
- Label formatting

### Macro Examples

**Original syntax:**
```asm
.mac dpinc          ; Define macro
inc ?1              ; Parameter ?1
bne ?2              ; Local label ?2
inc ?1+1
?2                  ; Local label
.mnd                ; End macro
```

**Converted to ca65:**
```asm
.macro dpinc addr
    inc addr
    bne :+
    inc addr+1
:
.endmacro
```

### Converting to ACME
```asm
!macro dpinc .addr {
    inc .addr
    bne .skip
    inc .addr+1
.skip
}
```

## Memory Configuration

- **Load Address:** $1960 (6496)
- **Character Set:** $3800 (2KB)
- **Screen Buffer:** $0400-$07BF
- **Zero Page:** $02-$9F (variables)
- **System Memory:** $0200-$02FF (tables)

## Binary Assets Integration

The game requires binary data files. For a complete build:

1. **Include character set:**
```asm
.org $3800
.incbin "CHARS.BIN"
```

2. **Include screen data:**
```asm
.org $1000
.incbin "DATASCRE.BIN"
```

## Build Targets

### Minimal Build (Code Only)
Just assemble `dorks_dilemma.asm` - will need separate data loading

### Complete Build (All Assets)
Create a build script that:
1. Assembles main code
2. Includes all .BIN files at correct addresses
3. Generates single .PRG or multi-file set

### Example Complete Build Script
```bash
#!/bin/bash
# complete_build.sh

# Assemble main code
ca65 dorks_dilemma.asm -o dorks_dilemma.o

# Create charset binary
ca65 charset_data.asm -o charset.o
# (where charset_data.asm includes CHARS.BIN)

# Link everything
ld65 dorks_dilemma.o charset.o -o DORKS_DILEMMA.prg -C c16.cfg

echo "Build complete: DORKS_DILEMMA.prg"
```

## Troubleshooting

### "Syntax Error" During Assembly
- Check macro syntax conversion
- Verify all `.lib` directives removed in consolidated file
- Ensure zero page addresses don't conflict with system

### Game Crashes on Load
- Verify load address ($1960)
- Check character set at $3800
- Ensure TED registers correctly initialized

### Graphics Corruption
- Character set not loaded at $3800
- Multicolor mode not properly set
- Screen data decompression issue

### No Sound
- Sound might be disabled (`sndflg` byte at $1960+)
- TED sound registers not properly configured

## Understanding the Code

### Key Entry Points
- **$1960** - Main program start
- **play** - Game loop entry
- **loop** - Main game loop
- **setirq** - Enable interrupts

### Important Routines
- **MOVEPIXE.TXT** - Player movement (largest module)
- **ALIENSME.TXT** - Alien AI
- **DECODER.TXT** - Screen decompression
- **IRQ.TXT** - Interrupt handler

### Debug Features
- Press ESC during game for edit mode (if enabled)
- DESIGNER.TXT contains level editor

## Further Development

### Adding Features
1. Modify consolidated source
2. Rebuild and test in VICE
3. Keep backups of working versions

### Common Modifications
- Adjust difficulty: Edit ALTERABL.TXT variables
- Change levels: Modify screen data or use DESIGNER
- Add cheats: Modify lives counter, collision detection
- Improve AI: Enhance ALIENSME.TXT alien logic

### Modern Enhancements
- Add more levels
- Improve graphics (character redraw)
- Enhanced sound effects
- Save/load game state
- Plus/4 128KB RAM expansion support

## Reverse Engineering & Function Recovery

Two critical functions were missing from the 1992 source archive:
- **`chkbmb`** - Bomb placement validation (45 bytes)
- **`fillex`** - Bomb fill continuation/exit (40 bytes)

These were successfully recovered through systematic binary disassembly of the original DORKSDIL.BIN:

### Recovery Process Summary
1. **Binary Analysis** - Used da65 disassembler on DORKSDIL.BIN
2. **Pattern Matching** - Located bomb fill code by searching for 4x STA sequence
3. **Call Graph Analysis** - Identified `chkbmb` by JSR call frequency (called 3 times)
4. **Manual Disassembly** - Converted hex opcodes to 6502 assembly
5. **Verification** - Byte-level comparison with original binary
6. **Integration** - Added to [src/missing_routines.s](src/missing_routines.s)

**Complete methodology documented in:** [docs/DISASSEMBLY_REVERSE_ENGINEERING.md](docs/DISASSEMBLY_REVERSE_ENGINEERING.md)

This demonstrates:
- Preservation of 40-year-old commercial game code
- Practical reverse engineering techniques
- Value of retaining compiled binaries alongside source
- Modern tools (da65, Python, VICE) applied to retro computing

## Resources

### Project Documentation
- **[CODEBASE_ANALYSIS.md](CODEBASE_ANALYSIS.md)** - Complete code walkthrough
- **[docs/DISASSEMBLY_REVERSE_ENGINEERING.md](docs/DISASSEMBLY_REVERSE_ENGINEERING.md)** - Function recovery process
- **[docs/FINAL_STATUS.md](docs/FINAL_STATUS.md)** - Current project status
- **[SUMMARY.txt](SUMMARY.txt)** - Quick project overview
- **[STRUCTURE.txt](STRUCTURE.txt)** - Code structure and build order
- **INDEX** - Original file listing with descriptions

### Commodore C16/Plus4 Resources
- [Plus/4 World](https://plus4world.powweb.com/) - Games, docs, community
- [VICE Emulator](https://vice-emu.sourceforge.io/) - Multi-platform emulator
- [C16/Plus4 Wiki](https://plus4world.powweb.com/wiki/) - Hardware reference

### Development Tools
- [cc65](https://cc65.github.io/) - C and assembly for 6502
- [ACME](https://sourceforge.net/projects/acme-crossass/) - Cross assembler
- [KickAssembler](http://theweb.dk/KickAssembler/) - Modern assembler
- [C64 Debugger](https://github.com/sunsided/c64-debugger) - Visual debugger (works with C16)

### 6502 Assembly References
- [6502.org](http://6502.org/) - Reference and community
- [Easy 6502](https://skilldrick.github.io/easy6502/) - Interactive tutorial
- [Atari 2600 Music & Sound](http://www.atariarchives.org/dere/) - Sound programming

## Credits

**Original Game:**
- Developer: Micro-Projects Ltd.
- Publisher: Gremlin Graphics Ltd.
- Year: 1985

**Archive:**
- Preserved: October 7, 1992
- Reconstructed: 2025

## License

This is historical software preserved for educational and archival purposes.
Original copyright holders: Micro-Projects Ltd. / Gremlin Graphics Ltd.

---

For questions about the codebase structure, see **CODEBASE_ANALYSIS.md**

Happy coding! 🕹️
