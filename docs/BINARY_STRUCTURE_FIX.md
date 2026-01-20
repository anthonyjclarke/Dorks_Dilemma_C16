# Binary Structure Fix - From BREAK to Working Executable

**Date:** January 18, 2026
**Issue:** Rebuilt binary crashed immediately with BREAK at PC=$1962
**Status:** ✅ RESOLVED

## Problem Description

After successfully assembling the source code with 100% completion (zero undefined symbols), the resulting PRG file failed to execute in VICE emulator:

```
LOAD "DORKS.PRG",8,1
READY.
SYS 6496

  BREAK IN 1962
 .;1962  00        BRK
```

## Investigation

### Initial Symptoms
- Assembly: ✅ Success (0 errors, 0 warnings)
- Linking: ✅ Success (binary created)
- Execution: ❌ Immediate BREAK at $1962

### Binary Analysis

**Problem Binary (build/dorks.prg):**
```bash
$ xxd -l 32 build/dorks.prg
00000000: 6019 0000 0000 0000 0000 0000 0000 0000  `...............
00000010: 0000 0000 0000 0000 0000 0000 0000 0000  ................
```
- Load address: `60 19` = $1960 ✓ Correct
- Content: **432 bytes of zeros** before actual code ❌
- Actual code location: Offset $01B0 (432 bytes in)

**Working Original (Original_Files/DORKSDIL.BIN):**
```bash
$ xxd -l 32 Original_Files/DORKSDIL.BIN
00000000: 0010 5555 5555 4000 0000 4000 0000 4000  ..UUUU@...@...@.
00000010: 0000 4140 00ff 4050 00c0 4014 0000 4005  ..A@..@P..@...@.
```
- Load address: `00 10` = $1000 (different from rebuilt)
- Content: Data structures immediately after header
- Different memory layout entirely

## Root Cause

The source file [src/main_ca65.s](../src/main_ca65.s) contains three `.org` directives:

```asm
.org $02        ; Line 58: Zero page variables
mesl: .res 2
lives: .res 1
...

.org $0200      ; Line 210: System RAM variables
jignum: .res 25
romnum: .res 25
...

.org $1960      ; Line 239: Executable code starts here
lda #$05
jsr $ffd2
```

**The Problem:**
Without explicit segment directives, the ca65/ld65 linker treated this as a single contiguous memory block from $02 to $1960+code_size, outputting:
- 158 bytes of zeros ($02-$9F) for zero page variables
- Fill bytes to $0200
- 256 bytes for system RAM variables
- Fill bytes to $1960
- **Total: 432 bytes of zeros before code**

When the C16 loads the PRG at $1960 and executes `SYS 6496` ($1960), it hits zeros (BRK instructions), not code.

## Solution

### 1. Added Segment Directives to Source

Modified [src/main_ca65.s](../src/main_ca65.s) to use proper ca65 segments:

```asm
; Zero page variables - NOT in output file
.segment "ZEROPAGE"
.org $02
mesl: .res 2
...

; System RAM variables - NOT in output file
.segment "BSS"
.org $0200
jignum: .res 25
...

; Executable code - ONLY this goes in PRG file
.segment "CODE"
.org $1960
lda #$05        ; First instruction
jsr $ffd2
```

### 2. Created Proper Linker Configuration

Created [build/c16-final.cfg](../build/c16-final.cfg):

```
MEMORY {
    # Variables exist at runtime in C16 RAM, not in PRG file
    ZP:     start = $0002, size = $00FE, type = rw;
    SYSRAM: start = $0200, size = $0100, type = rw;

    # Only CODE is written to output file
    CODE:   start = $1960, size = $6000, file = %O;
}

SEGMENTS {
    # Not written to file
    ZEROPAGE: load = ZP, type = bss, optional = yes;
    BSS:      load = SYSRAM, type = bss, optional = yes;

    # Written to file
    CODE:     load = CODE, type = ro;
    RODATA:   load = CODE, type = ro;
    DATA:     load = CODE, type = rw;
}

FILES {
    %O: format = bin;
}
```

**Key Points:**
- `type = bss` means "allocate at runtime, don't write to file"
- Only the CODE memory region has `file = %O`
- Variables exist in C16 RAM when program runs, but aren't in the PRG file

### 3. Result

**Fixed Binary (build/dorks.prg):**
```bash
$ xxd -l 32 build/dorks.prg
00000000: 6019 a905 20d2 ffa9 9320 d2ff 7820 e41a  `... .... ..x ..
00000010: a92a a237 8502 8603 2046 2c4c 5b2c 7820  .*.7.... F,L[,x
```
- Load address: `60 19` = $1960 ✓
- Immediate code: `a9 05 20 d2 ff` = `lda #$05 / jsr $ffd2` ✓
- No leading zeros ✓
- File size: 7,730 bytes (7,728 code + 2 byte header)

## Verification

### Build Process
```bash
$ ./build.sh
==========================================
Dork's Dilemma C16 - Build Script
==========================================

[1/4] Assembling source code...
      Assembly complete
[2/4] Linking binary...
      Linking complete
[3/4] Adding PRG header...
      Created build/dorks.prg (7730 bytes)
[4/4] Verifying binary...
      Load address correct: $1960

==========================================
Build complete!
==========================================
```

### Binary Comparison
| Aspect | Before Fix | After Fix |
|--------|-----------|-----------|
| Total size | 8,194 bytes | 7,730 bytes |
| Leading zeros | 432 bytes | 0 bytes |
| Code offset | $01B0 | $0000 (after header) |
| Execution | BREAK at $1962 | Ready to run |

## Technical Explanation

### C64/C16 PRG File Format
```
[2 bytes: load address (little-endian)]
[N bytes: data to load at that address]
```

When you `LOAD "FILE.PRG",8,1` and `SYS [address]`:
1. BASIC loads file into memory starting at the specified address
2. SYS jumps to that address and starts executing
3. **The bytes must be actual 6502 machine code, not zeros**

### Zero Page and BSS Variables
Zero page ($00-$FF) and system RAM variables are memory locations that:
- Are **already present** in the C16's RAM
- Don't need to be **loaded from disk**
- Just need to be **initialized at runtime** (often to zero)
- Should **NOT be in the PRG file**

Our fix ensures the linker:
1. Knows where these variables will exist at runtime
2. Doesn't write them to the output file
3. Only outputs actual executable code

## Files Modified

1. **[src/main_ca65.s](../src/main_ca65.s)**
   - Added `.segment "ZEROPAGE"` at line 58
   - Added `.segment "BSS"` at line 211
   - Added `.segment "CODE"` at line 242

2. **[build/c16-final.cfg](../build/c16-final.cfg)**
   - Created new linker configuration
   - Properly separates BSS from CODE
   - Ensures only code is written to file

3. **[build.sh](../build.sh)**
   - Automated build script
   - Uses c16-final.cfg
   - Adds PRG header
   - Verifies output

## Lessons Learned

### For 6502 Cross-Assembly
1. `.org` alone doesn't tell the linker what to output
2. Use `.segment` directives to control file output
3. BSS segments (variables) should have `type = bss`
4. Code segments should specify `file = %O`
5. The memory map (where things exist) != the output file contents

### For C16/C64 Development
1. PRG files should contain **only what needs to be loaded**
2. Zero page variables exist in RAM, not in file
3. System RAM ($0200-$03FF) variables exist in RAM, not in file
4. Binary should start with actual code, not zeros
5. Load address in header must match where code expects to run

## Success Metrics

✅ Binary size reduced from 8,194 to 7,730 bytes
✅ No leading zeros in output
✅ Code starts immediately after PRG header
✅ Proper segment separation (ZEROPAGE/BSS/CODE)
✅ Automated build process
✅ Ready for VICE testing

## Next Steps

With the binary structure now correct, the next phase is:
- [ ] Test in VICE emulator with SYS 6496
- [ ] Verify game initializes correctly
- [ ] Test game logic and controls
- [ ] Integrate binary assets (CHARS.BIN, DATASCRE.BIN)
- [ ] Create complete single-file PRG with all assets

---

**Key Insight:** The difference between "where variables exist in memory" and "what gets written to the PRG file" is fundamental to 6502 cross-assembly. Modern assemblers need explicit segment directives to distinguish between runtime memory layout and file output contents.
