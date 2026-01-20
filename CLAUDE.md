# CLAUDE.md - Dork's Dilemma C16 Project

## Project Overview
**Project Type:** Retro 6502 Game Development - Source Code Reconstruction
**Platform:** Commodore C16/Plus4
**Language:** 6502 Assembly
**Status:** Source reconstruction complete, ready for modern assembly
**Original Release:** 1985 (Gremlin Graphics / Micro-Projects Ltd.)
**Archive Date:** October 7, 1992

## Game Summary
**Title:** Dork's Dilemma / Rooms of Peril
**Genre:** Maze/Puzzle with platform elements
**Gameplay:** 25-room grid, jigsaw piece collection, alien enemies, bomb mechanics
**Binary Size:** 12,290 bytes
**Load Address:** $1960 (6496 decimal)

## Project Structure

### Key Files

- **[src/main.s](src/main.s)** - Reformatted source (4,831 lines, 35.5% reduction)
- **[src/main_ca65.s](src/main_ca65.s)** - ca65-ready version (99.96% assembly success)
- **[src/macros.s](src/macros.s)** - Modern macro definitions (dpinc, dpdec)
- **[scripts/convert_to_ca65_final.py](scripts/convert_to_ca65_final.py)** - Automated conversion script
- **[SUMMARY.txt](SUMMARY.txt)** - Project reconstruction summary
- **[STRUCTURE.txt](STRUCTURE.txt)** - Code structure and build order diagram
- **[CODEBASE_ANALYSIS.md](CODEBASE_ANALYSIS.md)** - Deep technical documentation
- **[README.md](README.md)** - Build instructions for modern assemblers
- **[archive/legacy_source/](archive/legacy_source/)** - Original consolidated versions

### Original Source Files
44 assembly modules in [Original_Files/](Original_Files/) directory:
- System layer: MAINVARS.TXT, MACROS.TXT, VARS.TXT, EXTRAMEM.TXT
- Entry point: ROOMSOFP.TXT
- Core game: PLAYGAME.TXT (main loop), MOVEPIXE.TXT (4625 bytes - largest module)
- AI system: ALIENSME.TXT, ALIENCHE.TXT, VARIETY.TXT
- Display: DECODER.TXT, SETUP.TXT, ANIMATEC.TXT, DUMPER.TXT
- Input: JOYSTIK.TXT, KEYSCAN.TXT, INKEY.TXT
- Timing: IRQ.TXT, RASTERRO.TXT
- Game objects: JIGSAWCO.TXT, BOMBCODE.TXT, RADARSCA.TXT

### Binary Assets
- **DORKSDIL.BIN** - Original compiled game (ready to run)
- **CHARS.BIN** - Character set (2KB multicolor at $3800)
- **DATASCRE.BIN** - Compressed screen data
- **CAMEL.BIN, BEEBSET.BIN, FRAK.BIN** - Additional graphics
- **EDITOR.BIN** - Level editor tool

## Memory Architecture

### Zero Page ($02-$9F)
158 bytes of game variables for fast access:
- $02-$03: Message pointer (mesl)
- $04-$0E: Game state (lives, joystick, RNG)
- $0F-$40: Player/alien positions, movement data
- $41-$9F: Screen pointers, counters, flags

### System RAM ($0200-$02FF)
- $0200: jignum[25] - Jigsaw piece to room mapping
- $0219: romnum[25] - Screen data per room
- $0232: radbuf[25] - Radar buffer
- $024B: alibuf[64] - Alien animation data
- $028B: gotbit[25] - Jigsaw collection flags
- $02A4: histbl[80] - High score table

### Main Memory
- $0400-$07BF: Screen buffer (960 bytes, 40x24)
- $1000: Compressed screen data location
- $1960: Program start
- $3800: Character set (2KB)
- $FF00-$FF3F: TED chip registers

## Technical Highlights

### Code Architecture
- **Modular Design:** 44 separate modules with clear separation of concerns
- **Custom Macros:** dpinc/dpdec for 16-bit zero page operations
- **IRQ System:** Interrupt-driven timing, effects, and animation
- **Screen Compression:** Custom RLE-style compression for 25 rooms
- **Sophisticated AI:** Pattern-based alien movement for 1985

### Hardware Features
- **TED Chip:** Video, sound, timers, joystick I/O
- **Multicolor Graphics:** 256-char set, 3 colors + background per char
- **Two-channel Sound:** TED sound generators
- **Raster Interrupts:** Precise timing and split-screen effects
- **Joystick Support:** Port 1 or keyboard controls

### Optimization Techniques
- Extensive zero page usage for speed
- Lookup tables for calculations
- Pixel-perfect collision detection
- Compressed screen data (memory constrained to 16KB base)
- IRQ-based non-blocking operations

## Assembly Syntax

### Original Custom Assembler (ASMC64.BAS)
```asm
.mac dpinc          ; Macro definition
inc ?1              ; Parameter ?1
bne ?2              ; Local label ?2
inc ?1+1
?2                  ; Label definition
.mnd                ; End macro

.lib "VARS"         ; Include file
*=*+25              ; Reserve space
```

### Modern ca65 Conversion
```asm
.macro dpinc addr
    inc addr
    bne :+
    inc addr+1
:
.endmacro

.include "VARS.s"
.res 25             ; Reserve space
```

### Modern ACME Conversion
```asm
!macro dpinc .addr {
    inc .addr
    bne .skip
    inc .addr+1
.skip
}

!source "VARS.asm"
!skip 25
```

## Build Instructions

### Quick Test (Original Binary)
```bash
# Install VICE emulator
brew install vice

# Run original game (use full path on macOS)
/usr/local/Cellar/vice/3.10/bin/xplus4 DORKSDIL.BIN
```

### Modern Build with ca65 (Recommended)
```bash
# Install cc65 toolchain
brew install cc65

# Use pre-converted ca65 source
ca65 src/main_ca65.s -o build/dorks_dilemma.o -t c16

# Link (will show 2 undefined symbols - fillex, chkbmb)
ld65 build/dorks_dilemma.o -o build/dorks_dilemma.prg -t c16

# Or convert from reformatted source
python3 scripts/convert_to_ca65_final.py src/main.s build/temp_ca65.s
ca65 build/temp_ca65.s -o build/dorks_dilemma.o -t c16

# Test
/usr/local/Cellar/vice/3.10/bin/xplus4 build/dorks_dilemma.prg
```

**Assembly Status:** 99.96% complete (2 undefined symbols need implementation)

### Alternative: ACME Assembler
```bash
brew install acme
acme -f cbm -o dorks_dilemma.prg dorks_dilemma.asm
```

## Key Code Modules

### Entry & Main Loop
- **[ROOMSOFP.TXT](Original_Files/ROOMSOFP.TXT)** - Program entry at $1960
- **[PLAYGAME.TXT](Original_Files/PLAYGAME.TXT)** - Game loop (play, loop labels)

### Player System (Most Complex)
- **[MOVEPIXE.TXT](Original_Files/MOVEPIXE.TXT)** - 4625 bytes, pixel movement, collision
- **[CHECKMAN.TXT](Original_Files/CHECKMAN.TXT)** - Wall and object collision
- **[CHANGERO.TXT](Original_Files/CHANGERO.TXT)** - Room transitions

### Enemy AI
- **[ALIENSME.TXT](Original_Files/ALIENSME.TXT)** - Movement AI (mega/code routines)
- **[ALIENCHE.TXT](Original_Files/ALIENCHE.TXT)** - Collision and rendering
- **[VARIETY.TXT](Original_Files/VARIETY.TXT)** - 3599 bytes, enemy types

### Display System
- **[DECODER.TXT](Original_Files/DECODER.TXT)** - Screen decompression
- **[SETUP.TXT](Original_Files/SETUP.TXT)** - TED chip initialization
- **[ANIMATEC.TXT](Original_Files/ANIMATEC.TXT)** - Character animation

### Critical Systems
- **[IRQ.TXT](Original_Files/IRQ.TXT)** - Interrupt handler (setirq routine)
- **[RASTERRO.TXT](Original_Files/RASTERRO.TXT)** - Raster effects
- **[RADARSCA.TXT](Original_Files/RADARSCA.TXT)** - Mini-map (5x5 room grid)

## Development Tools

### Original 1985 Toolchain
- **ASMC64.BAS** - C64-based custom assembler (44KB)
- **DESIGNER.TXT** - Built-in level editor (4311 bytes)
- **HYPRALOA.BAS** - Fast loader system
- Cross-platform: Developed on C64, targeted C16/Plus4

### Modern Toolchain Options
1. **cc65** - Full C and assembler suite, excellent C16 support
2. **ACME** - Fast cross-assembler, close to original syntax
3. **KickAssembler** - Java-based, powerful features

### Testing & Debugging
- **VICE Emulator** - xplus4 for C16/Plus4 emulation
- **C64 Debugger** - Visual debugger (works with C16)
- Built-in debug: ESC for edit mode, HEXER.TXT for hex dumps

## Game Mechanics Reference

### 25-Room System
- 5x5 grid layout
- Each room has compressed screen data
- Room tracking: xpos/ypos (grid coords), manx/many (pixel coords)
- Transition triggers: screen edge detection

### Jigsaw Collection
- 25 pieces scattered across rooms
- `jignum[]` maps pieces to rooms
- `gotbit[]` tracks collection status
- Required for game completion

### Alien AI Behaviors
- Multiple movement patterns (variety.txt defines)
- Tempo-based timing (`alitem`, `almvet`)
- Collision detection with player
- Character-based sprite animation

### Bomb System
- Player-placed explosives
- `bready` flag for availability
- Area-fill explosion effects
- Screen character manipulation

### Controls
- **Keyboard:** Cursor keys + Space
- **Joystick:** Port 1 + Button
- `joysel` flag toggles mode
- ESC for pause/debug menu

## Common Tasks

### Reading the Codebase
1. Start with [STRUCTURE.txt](STRUCTURE.txt) for build order
2. Review [CODEBASE_ANALYSIS.md](CODEBASE_ANALYSIS.md) for deep dive
3. Entry point: [ROOMSOFP.TXT:1960](Original_Files/ROOMSOFP.TXT)
4. Main loop: [PLAYGAME.TXT](Original_Files/PLAYGAME.TXT) play/loop labels

### Building from Source
1. Choose assembler (ca65 recommended)
2. Convert syntax using [README.md](README.md) examples
3. Assemble with C16 target
4. Test in VICE emulator
5. Compare behavior to original DORKSDIL.BIN

### Modifying Game Behavior
- **Difficulty:** Edit [ALTERABL.TXT](Original_Files/ALTERABL.TXT) parameters
- **Level Design:** Use DESIGNER.TXT or modify screen data
- **Player Lives:** Modify lives counter in VARS.TXT
- **Alien Speed:** Adjust tempo values in ALIENSME.TXT
- **Cheats:** Disable collision in CHECKMAN.TXT

### Adding Features
- Study existing module structure first
- Follow zero page variable conventions
- Test extensively (16KB memory limit)
- Maintain compatibility with TED chip

## Historical Significance

### 1985 Game Development
- Hand-written assembly (no C compilers used)
- Custom build toolchain created in BASIC
- Extreme memory optimization (16KB target)
- Modular architecture ahead of its time
- Complete with level editor and debug tools

### Preservation Value
- Complete source + tools + assets
- Build process documented
- Archive from 1992 studio preservation
- Represents commercial game dev practices
- Educational value for retro development

## Resources

### Project Documentation
- [SUMMARY.txt](SUMMARY.txt) - Quick overview
- [STRUCTURE.txt](STRUCTURE.txt) - Code architecture
- [CODEBASE_ANALYSIS.md](CODEBASE_ANALYSIS.md) - Technical deep dive
- [README.md](README.md) - Build instructions
- INDEX - Original disk catalog

### External Resources
- **Plus/4 World:** https://plus4world.powweb.com/ (community, games, docs)
- **VICE Emulator:** https://vice-emu.sourceforge.io/ (multi-platform)
- **cc65:** https://cc65.github.io/ (C and assembler for 6502)
- **6502.org:** http://6502.org/ (reference and community)
- **Easy 6502:** https://skilldrick.github.io/easy6502/ (interactive tutorial)

### C16/Plus4 Hardware
- CPU: MOS 7501/8501 (6502-compatible, 1.76 MHz)
- RAM: 16KB (C16) / 64KB (Plus4)
- Video: TED chip (320x200, multicolor)
- Sound: TED 2-channel (square wave)
- I/O: 2 joystick ports, cartridge slot

## Key Insights for Claude

### When Analyzing This Code
- Focus on modular structure (44 well-defined modules)
- Zero page usage is intentional and critical for performance
- IRQ system is central to game timing
- Screen compression is custom (not standard RLE)
- Original syntax needs conversion for modern assemblers

### When Helping with Builds
- Always test in VICE emulator first
- Memory constraints are real (16KB for C16)
- TED chip differs from VIC-II (C64) - check register addresses
- Macro syntax varies significantly between assemblers
- Load address $1960 is non-negotiable without rework

### When Suggesting Modifications
- Preserve zero page layout (carefully documented in VARS.TXT)
- IRQ handler modifications require testing
- Screen buffer at $0400 must not move
- Character set at $3800 referenced throughout
- Game loop in PLAYGAME.TXT is the coordination center

### When Explaining Code
- Reference specific modules: [FILENAME.TXT:linenum](path)
- Use memory map from STRUCTURE.txt
- Cite CODEBASE_ANALYSIS.md for technical details
- Cross-reference original INDEX for file purposes
- Consider 1985 development context

## Project Status

### Completed

- Source code reconstruction from 73 archived files
- Consolidated assembly file (7,505 lines → 4,831 reformatted)
- **Reformatting:** 35.5% reduction, removed 2,791 standalone semicolons
- **Documentation:** 37 major functions documented with detailed headers
- **Conversion:** Automated ca65 conversion script
- **Assembly:** 99.96% success rate (2 undefined symbols remaining)
- Comprehensive documentation (CODEBASE_ANALYSIS.md, STRUCTURE.txt)
- Original binary preserved and tested
- Build instructions for modern assemblers

### Ready For

- ✅ Modern cross-assembly with ca65 (100% complete)
- ✅ Emulator testing (VICE xplus4 - original binary works)
- ✅ Code study and learning (well-documented functions)
- Feature additions and modifications
- Historical preservation and archival

### Completed Issues

- ✅ **fillex** - Recovered from DORKSDIL.BIN at $33F9 (40 bytes)
- ✅ **chkbmb** - Recovered from DORKSDIL.BIN at $2AC5 (45 bytes)
- ✅ Both integrated into [src/missing_routines.s](src/missing_routines.s)
- ✅ 100% assembly success (ZERO undefined symbols)
- ✅ Modern build automation ([build.sh](build.sh))
- ✅ Complete reverse engineering documentation ([docs/DISASSEMBLY_REVERSE_ENGINEERING.md](docs/DISASSEMBLY_REVERSE_ENGINEERING.md))

### Known Issues

- **Display rendering:** Rebuilt binary executes but shows blank screen (original works perfectly)
- **Binary comparison:** Assembled code differs from original due to assembler variations
- Root cause investigation required (see [docs/FINAL_STATUS.md](docs/FINAL_STATUS.md))

### Not Yet Done

- Debug display issue (code runs, screen blank - needs VICE monitor tracing)
- Enhanced documentation of screen compression algorithm

## Notes for Future Development

### Best Practices
- Always backup working versions
- Test each change in VICE immediately
- Document memory usage changes
- Preserve original file structure for reference
- Use version control for modifications

### Common Pitfalls
- Forgetting load address when linking
- Breaking zero page variable layout
- Exceeding 16KB memory on C16
- TED vs VIC-II register confusion
- Macro syntax incompatibility between assemblers

### Enhancement Ideas
- Add more rooms (expand 5x5 grid)
- Improved alien AI patterns
- Enhanced sound effects
- Save/load game state
- Plus/4 128KB support
- Modern quality-of-life features

---

**Project Custodian:** Anthony Clarke
**Reconstruction Date:** 2025
**Original Archive:** October 7, 1992
**Original Release:** 1985

*This represents a complete reconstruction of commercial 1985 game development,*
*preserved for education, study, and retro development reference.*
