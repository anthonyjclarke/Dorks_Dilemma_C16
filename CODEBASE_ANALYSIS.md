# Dork's Dilemma - Codebase Analysis

## Overview
**Game Title:** Dork's Dilemma / Rooms of Peril
**Platform:** Commodore C16 / Plus/4
**Developer:** Micro-Projects Ltd. for Gremlin Graphics Ltd.
**Development Period:** Started March 5, 1985
**Archive Date:** October 7, 1992
**Binary Size:** 12,290 bytes
**Load Address:** $1960 (6496 decimal)

## Game Description
Dork's Dilemma is a maze/puzzle game featuring:
- Multi-screen room-based gameplay (25 rooms arranged in 5x5 grid)
- Character animation system
- Alien enemies with movement AI
- Jigsaw puzzle collection mechanic
- Bomb/explosion mechanics
- Radar/mini-map system
- Joystick and keyboard controls
- Hall of fame (high score table)
- Multiple difficulty levels
- Lives/scoring system
- IRQ-based raster effects

## Memory Map

### Zero Page Variables ($02-$9F)
The game uses extensive zero page storage for fast access:
- `$02-$03`: Message pointer (mesl)
- `$04-$0E`: Game state (lives, joystick inputs, random number generator)
- `$0F-$40`: Player position, alien positions, movement data
- `$41-$9F`: Screen pointers, counters, flags, temporary variables

### System Memory ($0200-$03FF)
- `$0200`: jignum (25 bytes) - Jigsaw piece locations per room
- `$0219`: romnum (25 bytes) - Screen data mapping for each room
- `$0232`: radbuf (25 bytes) - Radar buffer
- `$024B`: alibuf (64 bytes) - Alien animation data
- `$028B`: gotbit (25 bytes) - Jigsaw collection flags
- `$02A4`: histbl (80 bytes) - High score table

### Main Program Memory
- `$0400-$07BF`: scrbuf - Screen buffer (960 bytes)
- `$1000`: scdata - Compressed screen data location
- `$1960`: Program start address
- `$3800`: Character set location (2KB multicolor charset)

### TED Chip Registers ($FF00-$FF3F)
Hardware registers for the C16's TED chip:
- Sound generators (2 channels)
- Color registers (border, background, multicolor)
- Timers (used for random number generation)
- Raster/IRQ control
- Joystick port

## Source File Structure

### Core System Files
1. **MAINVARS.TXT** - TED chip register definitions and system constants
2. **MACROS.TXT** - Assembly macros (dpinc, dpdec for 16-bit operations)
3. **VARS.TXT** - Zero page variable definitions ($02-$9F)
4. **EXTRAMEM.TXT** - Memory tables and buffers ($0200-$02F3)

### Main Entry Point
5. **ROOMSOFP.TXT** - Main program entry, initialization, module includes

### Game Loop & Control
6. **PLAYGAME.TXT** - Main game loop (play, loop)
7. **COMMAND.TXT** - Escape/edit command handling
8. **JOYSTIK.TXT** - Joystick input reading
9. **KEYSCAN.TXT** - Keyboard input scanning
10. **INKEY.TXT** - Key scanning routines

### Display & Graphics
11. **SETUP.TXT** - TED chip initialization, character set setup
12. **DECODER.TXT** - Screen decompression routines
13. **SCREENIN.TXT** - Screen initialization
14. **BORDER.TXT** - Border printing routines
15. **ANIMATEC.TXT** - Character animation system
16. **DUMPER.TXT** - Screen fade-in effects
17. **TITLEWOR.TXT** - Title screen border scroll

### IRQ & Timing
18. **IRQ.TXT** - Interrupt request handler
19. **RASTERRO.TXT** - Raster interrupt service routines

### Player Movement
20. **MOVEPIXE.TXT** - Pixel-level player movement (4625 bytes - largest module)
21. **CHECKMAN.TXT** - Collision detection for player
22. **CHANGERO.TXT** - Room transition handling

### Enemy AI
23. **ALIENSME.TXT** - Alien movement logic (mega/code)
24. **ALIENCHE.TXT** - Alien collision checking and printing
25. **VARIETY.TXT** - Alien character variations
26. **KILLERCO.TXT** - Alien kill logic

### Game Objects
27. **JIGSAWCO.TXT** - Jigsaw puzzle mechanics
28. **EDITJIGS.TXT** - Jigsaw editing (debug feature?)
29. **SCATTER.TXT** - Jigsaw piece scattering
30. **BOMBCODE.TXT** - Bomb mechanics
31. **FILLERBO.TXT** - Bomb fill/explosion effects

### UI & Feedback
32. **RADARSCA.TXT** - Radar/mini-map display
33. **MESSAGES.TXT** - Message scrolling system
34. **SCOREROU.TXT** - Score display routines
35. **HALLOFFA.TXT** - Hall of fame data
36. **HIGHPRIN.TXT** - High score printing (3305 bytes)
37. **WORKHIGH.TXT** - High score table management
38. **MAGNIFIC.TXT** - Title screen loop

### Game State
39. **INITROOM.TXT** - Room initialization
40. **DEATHCOD.TXT** - Player death handling
41. **GAMEOVER.TXT** - Game over sequence
42. **LEVELINC.TXT** - Level increase logic
43. **ALTERABL.TXT** - Configurable game parameters (joy/kbd selection, etc.)
44. **WHOOPPEE.TXT** - Victory/completion messages

### Utilities
45. **UTILS.TXT** - General utility routines
46. **TABLES.TXT** - Lookup tables
47. **HEXER.TXT** - Hex conversion (commented out in build)

## Key Game Mechanics

### Room System
- 25 logical rooms in 5x5 grid
- Each room has associated screen data (compressed)
- Room transitions trigger screen decompression and redraw
- Position tracking: xpos/ypos (maze coordinates), manx/many (pixel coordinates)

### Jigsaw Puzzle
- 25 jigsaw pieces scattered across rooms
- `gotbit` array tracks collection status
- `jignum` maps pieces to room locations
- Collection affects game completion

### Alien AI
- Multiple alien types with different movement patterns
- Tempo-based movement (`alitem`, `almvet` counters)
- Collision detection with player
- Character animation for aliens

### Bomb Mechanic
- Player can place bombs
- `bready` flag indicates bomb availability
- Explosion fills screen areas
- Bomb character animation

### Control System
- Dual input: joystick (port 1) or keyboard
- `joysel` flag switches between modes
- Direction tracking: jleft, jright, jup, jdown, jfire
- Movement validation against screen data

### IRQ System
- Custom interrupt handler for:
  - Raster effects
  - Timing control
  - Animation updates
  - Sound generation

## Build System (Original 1980s)

### Original Toolchain
1. **Assembler:** ASMC64.BAS (44,844 bytes)
   - BASIC-based 6502 assembler running on C64
   - Supports `.lib` includes with wildcards
   - Macro support (`.mac`/`.mnd`)
   - Custom directives (`.opt nol` = no listing)

2. **Build Process:**
   - Load ASMC64.BAS on Commodore 64
   - Load source files sequentially from disk
   - Assemble to memory
   - Save as OBJ.TXT (hex-encoded object code)
   - Transfer to C16 as DORKSDIL.BIN

3. **Helper Programs:**
   - HYPRALOA.BAS - Hypra-load system (6429 bytes)
   - SUPERLOA.BIN - Super-load routine (946 bytes)
   - BOOTALL.BAS - Boot loader (259 bytes)

### Source File Conventions
- `.TXT` extension for assembly source
- `.BIN` for binary data (character sets, screen data)
- `.PRG` for executable programs
- `.BAS` for BASIC programs

## Graphics Assets

### Character Sets
- **CHARS.BIN** (2050 bytes) - Main character set
- **CAMEL.BIN** (2050 bytes) - Additional graphics
- **BEEBSET.BIN** (2050 bytes) - Character set variant
- **FRAK.BIN** (2050 bytes) - Graphics data

### Screen Data
- **DATASCRE.BIN** (2402 bytes) - Compressed screen data
- **MUFF.BIN** (2402 bytes) - Screen data

### Other Assets
- **EDITOR.BIN** (1626 bytes) - Level editor
- **COMPDATA.BIN** (98 bytes) - Compression data
- **MEGASUPE.BIN** (1026 bytes) - Additional data

## Code Statistics

### Module Sizes (Largest)
1. OBJ.TXT - 19,944 bytes (assembled hex output)
2. MOVEPIXE.TXT - 4,625 bytes (player movement)
3. VARS.TXT - 4,472 bytes (variable definitions)
4. DESIGNER.TXT - 4,311 bytes (level designer tool)
5. VARIETY.TXT - 3,599 bytes (alien variations)

### Total Source Lines
- Consolidated source: 7,505 lines
- Approximately 44 separate modules
- Extensive commenting throughout

## Notable Technical Features

### Multi-Color Graphics
- TED chip configured for 256-character multicolor mode
- Character RAM at $3800 (2KB set)
- Three colors plus background per character

### Screen Compression
- Custom compression for room data
- Decoder routine expands to screen buffer
- Saves memory for 25 unique rooms

### Raster Interrupts
- Precise timing for effects
- TED raster register manipulation
- Split-screen potential

### Random Number Generation
- Seeds from TED timer registers
- 4-byte RNG state in zero page
- Used for alien movement, room setup

### Sound System
- Two-channel TED sound
- Volume control
- Optional sound enable/disable (`sndflg`)

## Development Tools Included

### DESIGNER.TXT (4311 bytes)
- Level editor for creating rooms
- Separate IRQ system (des-irq, des-ani)
- Loads at $2000 instead of $1960
- Interactive editing interface

### Debug Features
- HEXER.TXT - Hex dump utility
- DUMPER.TXT - Screen memory dumper
- COMMAND.TXT - Escape to edit mode

## Historical Context

This codebase represents mid-1980s commercial game development:
- Hand-written 6502 assembly
- Extreme memory optimization (16KB C16 base model)
- Custom build toolchain
- Modular code organization
- Extensive use of zero page
- Hardware-specific optimizations

The 1992 archive date suggests this was preserved during a studio archival process, possibly as Gremlin Graphics moved to newer platforms.

## Modernization Notes

To rebuild this game today:
1. Convert to modern assembler syntax (ca65, ACME, or KickAssembler)
2. Resolve `.lib` includes to actual files
3. Convert macro syntax if needed
4. Include binary data assets
5. Generate C16 .PRG format with correct load address
6. Test in VICE emulator or real hardware

The consolidated `dorks_dilemma.asm` file contains all source code in correct build order, ready for modern cross-assembly.
