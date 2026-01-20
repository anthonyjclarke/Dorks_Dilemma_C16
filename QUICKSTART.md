# Dork's Dilemma - Quick Start Guide

## Test the Original Game (Right Now!)

```bash
# Install VICE emulator
brew install vice

# Run the original binary (use full path on macOS)
/usr/local/Cellar/vice/3.10/bin/xplus4 DORKSDIL.BIN
```

The game should start immediately!

## Files You Need

### To Play

- **DORKSDIL.BIN** - The compiled game (ready to run)

### To Build

- **src/main_ca65.s** - ca65-ready source (99.96% complete)
- **src/macros.s** - Modern macro definitions
- Binary data files (CHARS.BIN, DATASCRE.BIN, etc.)
- **cc65 toolchain** (ca65 assembler, ld65 linker)

### To Understand

- **[PROJECT_STATUS.md](PROJECT_STATUS.md)** - Current project status (start here!)
- **[README.md](README.md)** - Complete build instructions
- **[CLAUDE.md](CLAUDE.md)** - Comprehensive project reference
- **[CODEBASE_ANALYSIS.md](CODEBASE_ANALYSIS.md)** - Deep dive into the code

## Three-Minute Modern Build

### Step 1: Install Tools
```bash
brew install cc65 vice
```

### Step 2: Prepare Source
The consolidated source needs minor syntax tweaks for ca65. Here are the key changes:

**Change macro definitions:**
```asm
# Original:
.mac dpinc
inc ?1
bne ?2
inc ?1+1
?2
.mnd

# Convert to:
.macro dpinc addr
    inc addr
    bne :+
    inc addr+1
:
.endmacro
```

**Change space allocation:**
```asm
# Original:
*=*+25

# Convert to:
.res 25
```

### Step 3: Assemble
```bash
# Use pre-converted ca65 source
ca65 src/main_ca65.s -o build/dorks_dilemma.o -t c16

# Link (will show 2 undefined symbols - see PROJECT_STATUS.md)
ld65 build/dorks_dilemma.o -o build/dorks_dilemma.prg -t c16

# Or convert from reformatted source
python3 scripts/convert_to_ca65_final.py src/main.s build/temp_ca65.s
ca65 build/temp_ca65.s -o build/dorks_dilemma.o -t c16
```

### Step 4: Test
```bash
/usr/local/Cellar/vice/3.10/bin/xplus4 build/dorks_dilemma.prg
```

## What Each File Does

| File | Purpose | Lines | Load Address |
|------|---------|-------|--------------|
| MAINVARS.TXT | TED chip registers | 46 | N/A (constants) |
| VARS.TXT | Game variables | 185 | $02 (zero page) |
| ROOMSOFP.TXT | Main program | 97 | $1960 |
| PLAYGAME.TXT | Game loop | 126 | Part of main |
| MOVEPIXE.TXT | Player movement | 217 | Part of main |
| ALIENSME.TXT | Enemy AI | 159 | Part of main |
| IRQ.TXT | Interrupts | 52 | Part of main |
| ...and 37 more modules... | Various systems | 6,623 | Part of main |

## Game Features

- **25 interconnected rooms** (5×5 maze grid)
- **Jigsaw puzzle collection** (25 pieces to find)
- **Alien enemies** with AI movement
- **Bomb mechanics** for obstacles
- **Radar mini-map** showing your position
- **High score table** (hall of fame)
- **Multiple lives** and scoring
- **Joystick or keyboard** control

## Memory Layout

```
$0002-$009F : Zero page variables (game state)
$0200-$02FF : System memory (tables, buffers)
$0400-$07BF : Screen buffer (960 bytes)
$1000       : Compressed screen data
$1960       : Program start ← YOU ARE HERE
$3800       : Character set (2KB multicolor)
$FF00-$FF3F : TED chip registers
```

## Original Development (1985)

**How this was built in 1985:**
1. Write assembly in 44 separate .TXT files
2. Load ASMC64.BAS assembler on C64
3. Assemble to memory
4. Save hex output to OBJ.TXT
5. Transfer to C16
6. Load and run at $1960

**Total development time:** Started March 5, 1985
**Archive preservation:** October 7, 1992
**Your rebuild:** 2025! 🚀

## Common Issues

**Q: Game crashes on start**
A: Check load address is $1960 and character set is at $3800

**Q: Graphics look wrong**
A: Character data not loaded or multicolor mode not set

**Q: No sound**
A: Sound flag may be off, check sndflg byte

**Q: Can't assemble - syntax errors**
A: Macro syntax needs conversion for modern assemblers

## Next Steps

1. ✅ **Test original** - Run DORKSDIL.BIN in VICE
2. 📖 **Read docs** - Check CODEBASE_ANALYSIS.md for code walkthrough
3. 🔧 **Convert syntax** - Adapt macros for your chosen assembler
4. 🏗️ **Build** - Assemble your first .PRG
5. 🎮 **Modify** - Add features, tweak difficulty, experiment!

## Get Help

**Syntax conversion examples:**
- See README.md sections for ca65, ACME, KickAssembler

**Understanding the code:**
- CODEBASE_ANALYSIS.md has detailed module descriptions
- Comments in dorks_dilemma.asm explain logic
- Original .TXT files have developer notes

**6502 Assembly resources:**
- http://6502.org/ - Reference documentation
- https://skilldrick.github.io/easy6502/ - Interactive tutorial
- VICE built-in monitor for debugging

## Modernization Roadmap

**Phase 1: Get it building** ✓
- [x] Consolidate source files
- [x] Document structure
- [x] Convert macro syntax
- [x] Test assembly (99.96% success)

**Phase 2: Verify functionality**
- [ ] Assemble successfully
- [ ] Run in emulator
- [ ] Verify all features work
- [ ] Match original binary behavior

**Phase 3: Enhancements**
- [ ] Add more levels
- [ ] Improve graphics
- [ ] Enhanced sound
- [ ] Modern quality-of-life features

---

**You now have everything needed to rebuild a 40-year-old game! 🎉**

Start with testing DORKSDIL.BIN, then dive into the source when ready.
