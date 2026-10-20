# From Recovered Source to VICE

## Inputs and Preservation

Keep the supplied disk images and older converted files unchanged. The current build reads `Dorks-Dilemma-C16-2026-FullDiskCopy/Dorks-Dilemma-C16.d64` directly and doesn't assemble the loose files beside it.

The image is a standard 35-track D64. `scripts/d64_image.py` follows its directory and file-sector chains, checks sector addresses and block counts, and rejects cyclic chains. If the image has an appended disk-error map, it rejects any flagged sectors. It never writes to the input image.

The original capture was made on Windows 10 with ZoomFloppy, OpenCBM, and CBM-Transfer. [Development History](DEVELOPMENT_HISTORY.md) has the context and acknowledgements. The capture commands, exact versions, and a tested macOS capture procedure are a separate documentation task.

---

## Extraction and Provenance

Run:

```sh
python3 scripts/restore_c16.py
```

The build writes the image's 66 files under `build/disk/`, keeping each file's bytes. Host filenames use lower case and replace `/` with `-`. The original disk names, types, sizes, and hashes go into `build/recovery-manifest.json`.

Four modules that the main source references are missing from the live directory. The explicit fallback map in `scripts/restore_c16.py` supplies the surviving earlier copies from `Original_Files/`, and the manifest lists those inputs separately. A missing or ambiguous include is an error. The build never silently leaves a module out.

---

## Assembly Order and Conversion

The main source is `ROOMS OF PERIL`. Its `.LIB` directives pull in definitions, variables, macros, and game modules in the original sequence, and `.END` returns control from each included file.

The build converts this stream into `build/recovered-c16.s`. It keeps the original instructions that follow labels, full equate expressions, and literal text bytes. Original `.MAC` definitions become equivalent ca65 macros, and reserved storage goes into zero page and system RAM segments. The conversion only adapts syntax. It makes no gameplay changes and no guessed screen-address corrections.

The earlier consolidated `src/main.s`, `src/main_ca65.s`, and repair routines are kept for reference and are not inputs to this build.

---

## Assembly, Linking, and Assets

Install Python 3.9 or later and the cc65 toolchain. On macOS:

```sh
brew install cc65
./build.sh
```

The script looks for `ca65` and `ld65` on `PATH`, with an Apple Silicon Homebrew fallback under `/opt/homebrew/bin/`. Install both tools separately, because PlatformIO doesn't supply them.

`config/c16.cfg` keeps zero-page and system-RAM allocations out of the output file and links executable code at `$1960`. The build writes the listing, labels, map, and debug information next to the binary.

The final PRG combines `MUFF` at `$1000`, assembled code at `$1960`, and the final character set at `$3800`. The character set is extracted from the reference game's graphics region because the standalone `CHARS` file is a different revision. No executable code is copied from the reference.

The output has to match the reference byte for byte before the build reports success. `build/comparison.json` holds the comparison and the asset dependency, and the raw inputs stay in `build/disk/`.

---

## PlatformIO

```sh
pio run -e c16
pio run -e c16_debug
```

The pinned native platform runs the same external Python pipeline instead of its C compiler. Output goes to `build/platformio/c16/` and `build/platformio/c16_debug/`. Both environments have identical game bytes and generate debug artifacts.

If `pio` isn't on `PATH` on this Mac, the installed executable is `~/.platformio/penv/bin/pio`. The IDE's PlatformIO extension can also run its installed Core.

---

## Run on a C16 in VICE

Install VICE, then run:

```sh
scripts/run_vice.sh build/dorks.prg
```

The launcher selects a PAL C16 with 16 KB RAM, waits for BASIC to initialize, loads the PRG at its embedded address, and enters at `$1960` through the monitor. It doesn't save emulator settings on exit. Logs go to `build/vice/`.

Or:

```sh
pio run -e c16 --target upload
```

The source uses `Z`, `X`, `;`, `/`, and Space for movement and fire/start, with `F1` for keyboard/joystick and `F2` for sound. Check the actual host-key mapping in VICE. I haven't tested the keyboard by hand yet.

---

## Verification and Reuse

```sh
make test
python3 scripts/verify_vice.py
```

The emulator check supplies a scripted fire flag at the existing input test, confirms the game reaches the gameplay loop, and saves title and gameplay screenshots under `build/`. [Testing](../TESTING.md) covers its limits.

For other games, repeat the same stages: preserve the inputs, inventory the directory, trace the includes, record provenance, adapt the assembly, and compare against a reference. The D64 reader works for this disk format. The fallback list, entry addresses, linker memory map, macros, and assets are specific to this game, and each new title needs its own analysis.
