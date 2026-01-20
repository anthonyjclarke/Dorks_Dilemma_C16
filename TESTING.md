# Testing Guide - Dork's Dilemma C16

Quick reference for testing the rebuilt binary in VICE emulator.

## Build First

```bash
./build.sh
```

Expected output:
```
Build complete!
Output file: build/dorks.prg (7730 bytes)
```

## Run in VICE Emulator

### Option 1: Direct Load and Execute
```bash
/usr/local/Cellar/vice/3.10/bin/xplus4 build/dorks.prg
```

In the emulator, type:
```basic
SYS 6496
```

### Option 2: Manual Load
```bash
/usr/local/Cellar/vice/3.10/bin/xplus4
```

In the emulator:
```basic
LOAD "build/dorks.prg",8,1
RUN
```
(Note: This will try to RUN as BASIC and fail - use SYS instead)

```basic
SYS 6496
```

## Expected Behavior

### ✅ Success Indicators
- Screen clears (clear screen character sent)
- Program initializes
- Game graphics appear (if assets loaded)
- No BREAK errors

### ❌ Failure Indicators
- `BREAK IN 1962` - Binary has zeros at start (build issue)
- `SYNTAX ERROR` - Used RUN instead of SYS
- `ILLEGAL QUANTITY ERROR` - Wrong load address

## Memory Addresses Reference

| Address | Decimal | Purpose |
|---------|---------|---------|
| $1960 | 6496 | Program entry point (SYS here) |
| $0400 | 1024 | Screen buffer start |
| $3800 | 14336 | Character set location |

## Game Controls

Once running:
- **Keyboard:** Cursor keys + Space
- **Joystick:** Port 1 + Button
- **ESC:** Pause/Debug menu (if implemented)

## Comparing to Original

Test the working original first:
```bash
/usr/local/Cellar/vice/3.10/bin/xplus4 Original_Files/DORKSDIL.BIN
SYS 6496
```

This confirms VICE is working and shows expected game behavior.

## Troubleshooting

### BREAK Error
```
BREAK IN 1962
```
**Cause:** Binary has wrong structure (zeros at start)
**Fix:** Rebuild with `./build.sh` - should use c16-final.cfg

### Wrong Load Address
```
ILLEGAL QUANTITY ERROR
```
**Cause:** File loaded at wrong address
**Fix:** Use `LOAD "FILE",8,1` (the `,1` forces load at file's address)

### Missing Graphics
**Expected:** Code-only build won't have character sets or screen data
**Solution:** This is normal - assets in separate .BIN files need integration

## Current Limitations

The rebuilt `build/dorks.prg` contains:
- ✅ All executable code
- ✅ Proper load address ($1960)
- ✅ Complete game logic
- ❌ Character set data (in CHARS.BIN)
- ❌ Screen layout data (in DATASCRE.BIN)

Without the assets, expect:
- Code will execute
- Logic will run
- Graphics will be wrong/missing
- Game will be playable but visually broken

## Next: Asset Integration

To create a complete working game, assets need to be integrated:

```bash
# Character set at $3800
# Screen data decompressed to $1000
# All in single PRG file
```

This requires:
1. Loading CHARS.BIN data
2. Loading DATASCRE.BIN data
3. Combining into single PRG with proper memory layout
4. Setting up character set pointer in TED chip

---

**Quick Test:** Does the rebuild crash? Run `./build.sh && xplus4 build/dorks.prg` and type `SYS 6496`. No BREAK = success!
