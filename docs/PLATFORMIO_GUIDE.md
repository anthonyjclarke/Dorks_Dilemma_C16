# PlatformIO Setup Guide for Dork's Dilemma

## Overview

This project is configured as a PlatformIO project for VSCode, making it easy to build, debug, and run the C16 game in a modern development environment.

## Prerequisites

### Required Software

1. **VSCode** - Visual Studio Code
   - Download: https://code.visualstudio.com/

2. **PlatformIO** - Development platform
   - Install from VSCode Extensions marketplace
   - Search for "PlatformIO IDE"

3. **cc65** - 6502 cross-assembler toolchain
   ```bash
   brew install cc65  # macOS
   sudo apt install cc65  # Linux
   ```

4. **VICE** - Commodore emulator
   ```bash
   brew install vice  # macOS
   sudo apt install vice  # Linux
   ```

### Optional Tools

- **Git** - Version control
- **Make** - Alternative build system (Makefile provided)

## Project Structure

```
Dorks Dilemma C16/
├── .vscode/              # VSCode configuration
│   ├── settings.json     # Editor settings
│   ├── tasks.json        # Build tasks
│   ├── launch.json       # Debug configurations
│   └── extensions.json   # Recommended extensions
├── src/                  # Source code
│   └── main.s           # Main assembly file (consolidated source)
├── include/             # Include files
│   └── c16_hardware.inc # Hardware definitions
├── lib/                 # Libraries (empty for now)
├── test/                # Test files (future)
├── build/               # Build output (generated)
├── scripts/             # Build scripts
│   ├── build_6502.py   # PlatformIO build script
│   └── run_vice.sh     # VICE launcher
├── docs/                # Documentation
├── platformio.ini       # PlatformIO configuration
├── Makefile            # Alternative build system
└── README.md           # Main documentation
```

## Quick Start

### 1. Open Project in VSCode

```bash
cd "Dorks Dilemma C16"
code .
```

### 2. Install Recommended Extensions

When you open the project, VSCode will prompt you to install recommended extensions. Click "Install All".

Required extensions:
- PlatformIO IDE
- Language support for assembly
- Hex editor (for viewing .BIN files)

### 3. Verify Tools Installation

Press `Cmd+Shift+P` (macOS) or `Ctrl+Shift+P` (Windows/Linux) and run:
```
Tasks: Run Task → Tools: Check cc65 Installation
```

This verifies that ca65, ld65, and VICE are installed.

### 4. Build the Project

**Option A: PlatformIO**
```bash
pio run
```

**Option B: VSCode Task**
- Press `Cmd+Shift+B` (default build task)
- Or: Terminal → Run Task → "PlatformIO: Build"

**Option C: Makefile**
```bash
make
```

### 5. Run in Emulator

**Option A: PlatformIO Upload**
```bash
pio run --target upload
```

**Option B: VSCode Task**
- Terminal → Run Task → "Run: VICE Emulator"

**Option C: Makefile**
```bash
make run
```

## VSCode Tasks

Press `Cmd+Shift+P` → `Tasks: Run Task` to access these:

### Build Tasks
- **PlatformIO: Build** - Full build via PlatformIO (default: `Cmd+Shift+B`)
- **Build: Assemble only** - Run ca65 assembler
- **Build: Link** - Run ld65 linker
- **Build: Full (Manual)** - Complete build without PlatformIO

### Run Tasks
- **Run: VICE Emulator** - Build and run in VICE
- **Run: VICE with Monitor** - Run with debugger
- **Run: Original Binary** - Test original DORKSDIL.BIN

### Utility Tasks
- **View: Build Map** - Show memory map
- **View: Labels** - Show label definitions
- **View: Listing** - Show assembly listing
- **Tools: Check cc65 Installation** - Verify tools

## Debug Configuration

### Launch Configurations

Press `F5` or use Run panel to launch:

1. **Debug in VICE (with monitor)** - Full debugging support
2. **Run in VICE** - Quick run without debugger
3. **Run Original Binary** - Compare with original

### Debug Features

- **Breakpoints** - Set in assembly source
- **Watch Variables** - Monitor memory locations
- **Step Through** - F10 (step over), F11 (step into)
- **Memory View** - Inspect RAM/registers

## Build Outputs

After building, check these files:

```
build/
├── main.o              # Assembled object file
├── main.lst            # Assembly listing with addresses
├── labels.txt          # All label definitions
└── map.txt             # Memory usage map

dorks_dilemma.prg       # Final executable (root)
```

### View Build Artifacts

```bash
# Memory map
make map
# or
cat build/map.txt

# Labels
make labels
# or
cat build/labels.txt

# Listing
make listing
# or
cat build/main.lst
```

## Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Cmd+Shift+B` | Build (default task) |
| `F5` | Start debugging |
| `Shift+F5` | Stop debugging |
| `F10` | Step over |
| `F11` | Step into |
| `Cmd+Shift+P` | Command palette |
| `Cmd+P` | Quick file open |
| `Ctrl+` ` | Toggle terminal |

## PlatformIO Configuration

### platformio.ini

```ini
[env:c16]
platform = native
extra_scripts = pre:scripts/build_6502.py
upload_command = scripts/run_vice.sh $SOURCE
```

### Build Environments

- **c16** - Release build (default)
- **c16_debug** - Debug build with symbols
- **designer** - Level designer build

Switch environments:
```bash
pio run -e c16_debug
```

## Troubleshooting

### Build Fails

**Problem:** `ca65: command not found`

**Solution:** Install cc65
```bash
brew install cc65
```

**Problem:** Syntax errors in assembly

**Solution:** The source needs macro conversion (see README.md). Main issues:
- `.mac`/`.mnd` → `.macro`/`.endmacro`
- `*=*+n` → `.res n`
- `?1`, `?2` → proper parameter names

### Emulator Issues

**Problem:** VICE won't start

**Solution:**
```bash
# Check installation
which xplus4

# Install if missing
brew install vice
```

**Problem:** Wrong emulator binary

**Solution:** Edit `scripts/run_vice.sh` and change `EMULATOR` variable

### VSCode Integration

**Problem:** PlatformIO tasks not showing

**Solution:**
1. Reload window: `Cmd+Shift+P` → "Reload Window"
2. Reinstall PlatformIO extension
3. Check `.vscode/tasks.json` exists

**Problem:** Syntax highlighting not working

**Solution:** Install recommended extensions (`.vscode/extensions.json`)

## Alternative Build Methods

### Using Make

```bash
# Build
make

# Clean
make clean

# Run
make run

# Debug
make debug

# Help
make help
```

### Manual Build

```bash
# Assemble
ca65 -t c16 -g -l build/main.lst -o build/main.o src/main.s

# Link
ld65 -t c16 -o dorks_dilemma.prg -Ln build/labels.txt -m build/map.txt build/main.o

# Run
xplus4 -autostart dorks_dilemma.prg
```

## Advanced Features

### Custom Build Flags

Edit `platformio.ini`:
```ini
build_flags =
    -D TARGET_C16
    -D DEBUG=1
    -D ENABLE_DESIGNER=1
```

### Additional Source Files

Add new files to `src/` or `include/`:

```
src/
├── main.s          # Main source
├── sound.s         # Sound routines
└── graphics.s      # Graphics routines
```

Update `src/main.s` to include:
```asm
.include "sound.s"
.include "graphics.s"
```

### Version Control

The project includes `.gitignore` for proper Git integration:

```bash
git init
git add .
git commit -m "Initial commit - Dork's Dilemma C16 project"
```

## Resources

### cc65 Documentation
- [cc65 User Guide](https://cc65.github.io/doc/)
- [ca65 Macro Assembler](https://cc65.github.io/doc/ca65.html)
- [ld65 Linker](https://cc65.github.io/doc/ld65.html)

### VICE Emulator
- [VICE Manual](https://vice-emu.sourceforge.io/vice_toc.html)
- [Monitor Commands](https://vice-emu.sourceforge.io/vice_12.html)

### C16/Plus4 Hardware
- [Plus/4 World](https://plus4world.powweb.com/)
- [TED Chip Reference](https://plus4world.powweb.com/wiki/TED)

### 6502 Assembly
- [6502.org](http://6502.org/)
- [Easy 6502](https://skilldrick.github.io/easy6502/)

## Next Steps

1. ✅ Verify all tools installed (`make check`)
2. ✅ Test original binary (`make run-original`)
3. 📝 Convert macro syntax (see README.md)
4. 🔧 Build from source (`make`)
5. 🎮 Test your build (`make run`)
6. 🚀 Start modifying!

---

Happy coding! For more details, see the main README.md and CODEBASE_ANALYSIS.md
