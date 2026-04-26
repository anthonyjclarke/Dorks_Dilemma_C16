# Dork's Dilemma - Build Instructions

## Overview

This is the complete source code for **Dork's Dilemma** (also known as "Rooms of Peril"), a Commodore C16/Plus4 game developed by Micro-Projects Ltd. for Gremlin Graphics in 1985.

**Status:** Source reconstruction complete — assembles with zero errors — partially working in VICE (title screen renders, game loop not yet reachable)

**What Works:**
- Complete source reconstruction from 1992 archive (44 original modules → single `src/main_ca65.s`)
- Two missing functions (`fillex`, `chkbmb`) recovered through binary reverse engineering
- 100% assembly success (ZERO undefined symbols)
- Modern build system (`build.sh` + `scripts/create_complete_prg.py`)
- TED chip correctly initialised — IRQ running, raster effects visible in VICE
- Title screen partially renders: chain-link border, color bar, radar mini-map, right panel labels

**What Does Not Work Yet:**
- Pressing Space on the title screen does not advance to gameplay
- Top 3 rows of title screen show garbled/displaced character data
- Main play area stays black (room decode not running or not displaying)

**Reference Binary:**
`Original_Files/DORKSDIL.BIN` (12,290 bytes) runs perfectly in VICE and is the authoritative reference. The rebuilt binary `build/dorks_complete.prg` is the same size and load address but is not yet functionally equivalent.

## Current Screen Output

When running `xplus4 build/dorks_complete.prg` and typing `SYS 6496`, the following title screen appears and then stops (Space bar has no visible effect):

![](<images/Code 2026-04-26 14.48.12.png>)

The color bar at the bottom confirms the raster IRQ is running (messve/sludge routines active). The radar mini-map shows the player start position marker.

**Reverse Engineering Achievement:**
The missing functions were successfully recovered from DORKSDIL.BIN through systematic disassembly. See [docs/DISASSEMBLY_REVERSE_ENGINEERING.md](docs/DISASSEMBLY_REVERSE_ENGINEERING.md) for the complete process documentation.

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

## Known Bugs Fixed (April 2026)

### Bug 1 — TED Register Equates ($FF00-based)
**File:** `src/main_ca65.s` lines 14–27
**Symptom:** Blank screen, no IRQ, no display at all.
**Cause:** During source consolidation, all 14 TED hardware register aliases (`irqreg`,
`irqmsk`, `rascom`, `border`, `backgr`, `jport`, etc.) were converted from equates
(`= ted+N`) to labels (`:`). All resolved to $1960 (code start) instead of
$FF08–$FF1C. Every TED write hit game code instead of hardware.
**Fix:** Restored to `= ted+N` form.

### Bug 2 — Missing selfmd Instruction in decode
**File:** `src/main_ca65.s` ~line 898 (inside `decode` / DECODER.TXT)
**Symptom:** Pressing Space appeared to have no effect; game crashed silently back to title.
**Cause:** The `selfmd` label was attached to `ldy #0`. The original DECODER.TXT has
`selfmd lda $ffff,x` (a 3-byte instruction) immediately before `ldy #0`. The
self-modifying code (`sta selfmd+1` / `sta selfmd+2`) patched the wrong bytes —
the `ldy` operand and the next instruction's opcode — corrupting the `lp3` decode
loop on first use.
**Fix:** Inserted `lda $ffff,x` at the `selfmd:` label. Verified: opcode `BD FF FF`
in binary, with `selfmd+1`/`selfmd+2` correctly inside the operand.

## Outstanding Issues (April 2026)

1. **Space bar not advancing game** — `glloo` loop checks `bit jfire; bpl glloo`.
   Keyboard scan code is correct in binary (verified byte-by-byte). Unknown why it
   doesn't exit. Investigate: VICE keyboard focus, C16 keyboard matrix emulation,
   or alternative input (joystick mode via F1, or joystick in VICE settings).

2. **Title screen top 3 rows garbled** — Character data appearing in wrong screen
   positions. Likely a screen-RAM write address issue in `prscrn`/`welch`/`pwint`
   routines. The screen base is `$0C00` (C16/Plus4 layout) but some hardcoded
   addresses in prscrn (`$c81+40`) may be wrong for the rebuilt binary layout.

3. **Play area stays black** — Room decode only runs after Space is pressed (via
   `play` → `jmpbak` → `decode`). Once Space issue is resolved, check decode output.

4. **47-byte code offset** — Rebuilt routines land ~47 bytes earlier than in the
   original binary (`inhisc`: rebuilt $2C7F vs original $2CAE). All internal
   jumps use labels so behavior is correct, but comparison to original disassembly
   requires accounting for this offset. Unknown source of the 47 bytes.

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
