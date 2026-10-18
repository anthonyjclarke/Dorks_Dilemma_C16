# Documentation Index - Dork's Dilemma C16

Complete documentation for the Dork's Dilemma source code reconstruction project.

---

## Quick Start

**New to this project?** Start here:

1. **[../QUICKSTART.md](../QUICKSTART.md)** - Run the game in 5 minutes
2. **[../README.md](../README.md)** - Build instructions and overview
3. **[../SUMMARY.txt](../SUMMARY.txt)** - Quick project summary

---

## Project Status & History

### Development History and Recovered Material

[Development History](DEVELOPMENT_HISTORY.md) records the Rooms of Peril development name, Gremlin Graphics' rebranding to Dork's Dilemma, Anthony Clarke's C64–1541–C16 workflow, and the disk-recovery background.

[Recovered Disk and Folder Contents](RECOVERED_DISK_CONTENTS.md) inventories the supplied disk images, sequential source and object files, and PRG files. Initial tool identifications are provisional where indicated; detailed research is planned for a later revision. Earlier status reports below describe intermediate restoration stages.

### Current Status
- **[FINAL_STATUS.md](FINAL_STATUS.md)** - Complete project status report
  - Assembly: 100% success (ZERO undefined symbols)
  - Source reconstruction: Complete
  - Missing functions: Recovered
  - Known issue: Display rendering (documented)

### Build & Assembly Documentation
- **[BUILD_SUCCESS.md](BUILD_SUCCESS.md)** - Build system achievement log
- **[REBUILD_STATUS.md](REBUILD_STATUS.md)** - Rebuild status summary
- **[ASSEMBLY_FINAL_STATUS.md](ASSEMBLY_FINAL_STATUS.md)** - Final assembly report
- **[BINARY_STRUCTURE_FIX.md](BINARY_STRUCTURE_FIX.md)** - Binary structure fixes

---

## Reverse Engineering Documentation

### ⭐ Main Process Document
- **[DISASSEMBLY_REVERSE_ENGINEERING.md](DISASSEMBLY_REVERSE_ENGINEERING.md)** - **START HERE**
  - Complete methodology for recovering missing functions
  - Step-by-step disassembly process
  - Tools and techniques used
  - Binary analysis and pattern matching
  - Verification and integration
  - **This is the comprehensive guide to the entire process**

### Supporting Documents
- **[DISASSEMBLY_PLAN.md](DISASSEMBLY_PLAN.md)** - Initial strategy and plan
- **[MISSING_FUNCTIONS_FOUND.md](MISSING_FUNCTIONS_FOUND.md)** - Discovery report
- **[CLEANUP_SUMMARY.md](CLEANUP_SUMMARY.md)** - Code cleanup summary

---

## Technical Documentation

### Code Analysis
- **[../CODEBASE_ANALYSIS.md](../CODEBASE_ANALYSIS.md)** - Deep technical dive
  - Memory map and architecture
  - 44 source modules documented
  - Zero page variables
  - Game mechanics
  - Hardware programming (TED chip)

### Code Structure
- **[../STRUCTURE.txt](../STRUCTURE.txt)** - Build order and dependencies
  - Module dependency graph
  - Assembly order
  - Memory layout
  - File organization

### Project Files
- **[../PROJECT_SETUP.md](../PROJECT_SETUP.md)** - Initial setup notes (if exists)
- **[../PROJECT_STATUS.md](../PROJECT_STATUS.md)** - Ongoing status tracking
- **[../TESTING.md](../TESTING.md)** - Testing documentation

---

## Source Code Documentation

### Main Source Files
- **[../src/main_ca65.s](../src/main_ca65.s)** - Complete ca65 source (7,505 lines)
- **[../src/missing_routines.s](../src/missing_routines.s)** - Recovered functions
- **[../src/macros.s](../src/macros.s)** - Macro definitions
- **[../src/main.s](../src/main.s)** - Reformatted source

### Original Files
- **[../Original_Files/](../Original_Files/)** - 44 original .TXT modules
- **[../Original_Files/INDEX](../Original_Files/INDEX)** - Original file catalog

---

## Scripts & Tools

### Build Scripts
- **[../build.sh](../build.sh)** - Automated build script
- **[../scripts/convert_to_ca65_final.py](../scripts/convert_to_ca65_final.py)** - Syntax converter

### Reverse Engineering Scripts
- **[../scripts/find_missing_code.py](../scripts/find_missing_code.py)** - Pattern search
- **[../scripts/extract_missing_functions.py](../scripts/extract_missing_functions.py)** - Function extraction

### Asset Integration
- **[../scripts/patch_original.py](../scripts/patch_original.py)** - Hybrid binary creation
- **[../scripts/create_complete_prg.py](../scripts/create_complete_prg.py)** - Full asset integration

---

## Key Achievements

### What Was Accomplished

✅ **Source Code Recovery (100%)**
- Reconstructed from 44 original .TXT files
- 7,505 lines consolidated into single buildable source
- Converted to modern ca65 syntax

✅ **Missing Function Recovery**
- `chkbmb` recovered from DORKSDIL.BIN (45 bytes at $2AC5)
- `fillex` recovered from DORKSDIL.BIN (40 bytes at $33F9)
- Used da65 disassembler + pattern matching + manual analysis
- Byte-perfect verification

✅ **Build System**
- Zero errors, zero undefined symbols
- Modern cc65 toolchain integration
- Automated build scripts

✅ **Documentation**
- Complete reverse engineering methodology documented
- Technical analysis of all 44 modules
- Memory map and architecture documented
- Historical context preserved

---

## Documentation by Topic

### For Preservation & History
- [FINAL_STATUS.md](FINAL_STATUS.md) - What was achieved
- [DISASSEMBLY_REVERSE_ENGINEERING.md](DISASSEMBLY_REVERSE_ENGINEERING.md) - How functions were recovered
- [../CODEBASE_ANALYSIS.md](../CODEBASE_ANALYSIS.md) - Technical details
- [../Original_Files/INDEX](../Original_Files/INDEX) - Original archive catalog

### For Building & Testing
- [../README.md](../README.md) - Build instructions
- [../QUICKSTART.md](../QUICKSTART.md) - Quick start guide
- [BUILD_SUCCESS.md](BUILD_SUCCESS.md) - Build system details
- [../build.sh](../build.sh) - Automated build

### For Understanding the Code
- [../CODEBASE_ANALYSIS.md](../CODEBASE_ANALYSIS.md) - Complete walkthrough
- [../STRUCTURE.txt](../STRUCTURE.txt) - Architecture and organization
- [../src/main_ca65.s](../src/main_ca65.s) - Annotated source

### For Reverse Engineering Students
- [DISASSEMBLY_REVERSE_ENGINEERING.md](DISASSEMBLY_REVERSE_ENGINEERING.md) - Complete process
- [DISASSEMBLY_PLAN.md](DISASSEMBLY_PLAN.md) - Strategy and planning
- [MISSING_FUNCTIONS_FOUND.md](MISSING_FUNCTIONS_FOUND.md) - Results
- [../scripts/find_missing_code.py](../scripts/find_missing_code.py) - Tool example

### For Retro Game Developers
- [../CODEBASE_ANALYSIS.md](../CODEBASE_ANALYSIS.md) - Game mechanics
- [../src/main_ca65.s](../src/main_ca65.s) - Implementation reference
- [../README.md](../README.md) - Build setup
- [FINAL_STATUS.md](FINAL_STATUS.md) - Current state

---

## Recommended Reading Order

### Path 1: "I want to understand the reverse engineering"
1. [DISASSEMBLY_REVERSE_ENGINEERING.md](DISASSEMBLY_REVERSE_ENGINEERING.md)
2. [MISSING_FUNCTIONS_FOUND.md](MISSING_FUNCTIONS_FOUND.md)
3. [../scripts/find_missing_code.py](../scripts/find_missing_code.py)
4. [../src/missing_routines.s](../src/missing_routines.s)

### Path 2: "I want to build and run it"
1. [../QUICKSTART.md](../QUICKSTART.md)
2. [../README.md](../README.md)
3. [BUILD_SUCCESS.md](BUILD_SUCCESS.md)
4. [FINAL_STATUS.md](FINAL_STATUS.md)

### Path 3: "I want to study the code"
1. [../CODEBASE_ANALYSIS.md](../CODEBASE_ANALYSIS.md)
2. [../STRUCTURE.txt](../STRUCTURE.txt)
3. [../src/main_ca65.s](../src/main_ca65.s)
4. [../Original_Files/](../Original_Files/)

### Path 4: "I want the complete story"
1. [../SUMMARY.txt](../SUMMARY.txt)
2. [FINAL_STATUS.md](FINAL_STATUS.md)
3. [DISASSEMBLY_REVERSE_ENGINEERING.md](DISASSEMBLY_REVERSE_ENGINEERING.md)
4. [../CODEBASE_ANALYSIS.md](../CODEBASE_ANALYSIS.md)

---

## Missing Something?

If you're looking for information that isn't in these documents:

1. Check [../Original_Files/INDEX](../Original_Files/INDEX) for original file descriptions
2. Review [FINAL_STATUS.md](FINAL_STATUS.md) for known issues and limitations
3. See [../CLAUDE.md](../CLAUDE.md) for AI assistant context and notes
4. Browse [../scripts/](../scripts/) for automation tools

---

## Document Status

| Document | Status | Last Updated |
|----------|--------|--------------|
| DISASSEMBLY_REVERSE_ENGINEERING.md | ✅ Complete | Jan 2026 |
| FINAL_STATUS.md | ✅ Complete | Jan 2026 |
| CODEBASE_ANALYSIS.md | ✅ Complete | Jan 2026 |
| BUILD_SUCCESS.md | ✅ Complete | Jan 2026 |
| MISSING_FUNCTIONS_FOUND.md | ✅ Complete | Jan 2026 |
| All others | ✅ Current | Jan 2026 |

---

## External Resources

### Commodore C16/Plus4
- [Plus/4 World](https://plus4world.powweb.com/) - Community and games
- [VICE Emulator](https://vice-emu.sourceforge.io/) - Multi-platform emulator

### Development Tools
- [cc65](https://cc65.github.io/) - C and assembler for 6502
- [da65](https://cc65.github.io/doc/da65.html) - 6502 disassembler

### 6502 Assembly
- [6502.org](http://6502.org/) - Reference and community
- [Easy 6502](https://skilldrick.github.io/easy6502/) - Interactive tutorial

---

**Project:** Dork's Dilemma C16 Source Reconstruction
**Status:** 100% Source Complete, Display Issue Under Investigation
**Custodian:** Anthony Clarke
**Last Updated:** January 20, 2026

*Complete reconstruction of 1985 commercial game development,*
*preserved for education, study, and retro development.*
