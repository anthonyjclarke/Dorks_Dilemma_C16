# PlatformIO Guide

## Build the Recovered Game

Install PlatformIO Core and cc65 (`ca65`, `ld65`). Install VICE (`xplus4`) to run the game. Python 3.9 or later is required.

```sh
pio run -e c16
```

The first build installs the pinned `platformio/native@1.2.1` platform. That platform only provides the PlatformIO build context. The custom builder runs the recovered 6502 assembly pipeline instead of a native C compiler.

On this Mac, PlatformIO Core is also at `~/.platformio/penv/bin/pio` if `pio` isn't on `PATH`.

---

## Output and Debug Artifacts

The PRG is `build/platformio/c16/dorks.prg`. The same directory also holds the extracted disk files, converted assembly, listing, labels, map, debug information, source manifest, and binary comparison report.

```sh
pio run -e c16_debug
```

The debug environment writes the same game bytes under `build/platformio/c16_debug/`, along with the same inspection artifacts. It adds no unverified gameplay or designer flags.

---

## Run and Clean

```sh
pio run -e c16 --target upload
pio run -e c16 --target clean
```

Upload launches VICE as a PAL C16 with 16 KB RAM. The launcher waits for BASIC to initialize, loads at the PRG's saved address, and enters the game at `$1960`.

The VS Code tasks use the same pipeline. The old Node-based PRG launch configurations are gone, because a Commodore PRG isn't a Node program. Use the build and run tasks for VICE.

---

## Build Implementation

`platformio.ini` points at `scripts/build_6502.py`, which swaps the platform's build script for `scripts/platformio_build.py`. That script declares the disk image, archive fallbacks, reference, converter, disk reader, and linker configuration as dependencies, then calls `scripts/restore_c16.py`.

The direct build and the Makefile run the same pipeline. A stale linker configuration under a generated build directory is no longer needed, and assembler and linker errors now fail the build.

[Source to VICE](SOURCE_TO_VICE.md) and [Restoration Status](RESTORATION_STATUS.md) cover source and asset provenance.
