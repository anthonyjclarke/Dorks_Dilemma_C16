# Build and Run

## Requirements

Python 3.9 or later and cc65 (`ca65`, `ld65`) are all you need to build. VICE (`xplus4`) is for running the game and the emulator checks. The Python build uses only the standard library.

PlatformIO Core and VS Code are optional front ends. I've validated against PlatformIO Core 6.1.19, ca65/ld65 V2.18 and VICE 3.10. The PlatformIO native platform is pinned to `platformio/native@1.2.1`. It supplies the build framework, but the custom builder calls the 6502 assembler, not a host C/C++ compiler.

On macOS:

```sh
brew install cc65 vice
python3 -m pip install platformio==6.1.19
```

If `pio` isn't on `PATH`, the installed executable on this Mac is `~/.platformio/penv/bin/pio`, and the VS Code PlatformIO extension's terminal has it too. The scripts look for `ca65`, `ld65` and `xplus4` on `PATH`, with an Apple Silicon Homebrew fallback under `/opt/homebrew/bin/`. PlatformIO doesn't supply the cc65 tools, so install them separately.

---

## Direct Build

```sh
python3 scripts/restore_c16.py
```

`./build.sh` and `make` call the same pipeline. You can also pick another output directory:

```sh
python3 scripts/restore_c16.py --build-dir build/custom
```

The build reads `Original Source Recovered/2026/Dorks-Dilemma-C16.d64` directly and never writes to it. `scripts/d64_image.py` follows the directory and file-sector chains, checks sector addresses and block counts, rejects cyclic chains, and rejects any sector flagged in an appended error map.

The main source is `ROOMS OF PERIL`. Its `.LIB` directives pull in definitions, variables, macros, and game modules in the original sequence, and `.END` returns control from each included file. Four modules the source includes are missing from the image's live directory. The explicit fallback map in `scripts/restore_c16.py` supplies them from `Original Source Recovered/1992/`. A missing or ambiguous include is an error, so the build never silently leaves a module out.

The converter adapts syntax only. It keeps instructions that follow labels, full equate expressions and literal text bytes, turns original `.MAC` definitions into equivalent ca65 macros, and places reserved storage in zero page and system RAM. It makes no gameplay changes and no guessed address corrections.

`config/c16.cfg` keeps zero-page and system-RAM allocations out of the output file and links executable code at `$1960`. The final PRG combines `MUFF` at `$1000`, the assembled code at `$1960`, and the final character set at `$3800`, which is taken from the reference game's graphics region. The output has to match the reference byte for byte before the build reports success.

### Output Files

The runnable file is `build/dorks.prg`. The generated assembly is `recovered-c16.s` with its listing in `recovered-c16.lst`, and the linker writes `labels.txt`, `map.txt` and `dorks.dbg`. `recovered-code.bin` holds the `$1960–$37FF` region.

`recovery-manifest.json` records every input with its disk name, type, size, source and hash. `comparison.json` records the reference comparison and the character-set dependency. The `disk/` folder has byte-preserving copies of the 66 disk files, with host names in lower case and `/` replaced by `-`.

---

## PlatformIO

```sh
pio run -e c16
pio run -e c16_debug
pio run -e c16 -t upload
pio run -e c16 -t clean
```

`platformio.ini` points at `scripts/build_6502.py`, which swaps the platform's build script for `scripts/platformio_build.py`. That script declares the disk image, the fallback files, the reference, the converter, the disk reader and the linker configuration as dependencies, then calls `scripts/restore_c16.py`.

Release and debug builds produce identical game bytes, and both write the listing, labels, map and debug information. Outputs are in `build/platformio/c16/` and `build/platformio/c16_debug/`. The upload target opens a PAL C16 with 16 KB RAM in VICE. It doesn't send anything to physical hardware. There's no source-level debug adapter, so debug with the VICE monitor and the generated labels and listing.

### VS Code Tasks

The default build task calls PlatformIO. The other tasks cover clean, running in VICE, the direct Python build, launching the original binary, the regression tests and the VICE gameplay check. Global save-time whitespace cleanup is turned off to protect the historical inputs.

### Makefile

`make` builds, `make run` and `make run-original` launch VICE, `make test` runs the regression tests and `make verify` runs the VICE check. `make docs`, `make docs-html`, `make docs-watch`, `make docs-check` and `make test-docs` maintain the HTML handbook.

---

## Running the Game

```sh
python3 scripts/run_vice.py
python3 scripts/run_vice.py build/platformio/c16/dorks.prg
python3 scripts/run_vice.py --original
```

`scripts/run_vice.sh` is a shell wrapper for the same launcher. It selects a PAL C16 with 16 KB RAM, waits for BASIC to finish initializing, loads the PRG at its saved address and enters at `$1960` through the monitor. The PRG has no BASIC `RUN` stub, so BASIC autostart won't work. `--original` runs the surviving 1992 `DORKSDIL.BIN`, which loads and enters the same way. The launcher doesn't save emulator settings on exit, and its logs go to `build/vice/`.

### Controls

The source uses `Z` / `X` for left / right, `;` / `/` for up / down, and Space for fire and start. `F1` switches between keyboard and joystick, and `F2` switches sound. How these map to host keys depends on the VICE keymap, and I haven't tested them by hand yet.

---

## Cleaning and Development

`make clean` removes `build/`, and leaves the original source, artwork and documentation alone. PlatformIO's clean only removes its own generated targets.

The preserved inputs are the source of truth. Read `build/recovered-c16.s` to see the expanded assembly, but editing generated files changes nothing on the next build, and any deliberate source change fails the strict comparison with the reference. The [Modification and Porting Guide](PORTING_GUIDE.md) describes how a separate development target should work. The default target of this repository stays the surviving version.

For another game, repeat the same stages: preserve the inputs, inventory the directory, trace the includes, record provenance, adapt the assembly and compare against a reference. The D64 reader works for this disk format. The fallback list, entry addresses, linker memory map, macros and assets are specific to each game.
