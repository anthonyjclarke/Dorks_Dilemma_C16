# Dork's Dilemma C16

## Complete Documentation

Open the [complete HTML handbook](docs/DORKS_DILEMMA.html) for the history, artwork and reviews, restoration, build guides, code analysis, graphics, and reference in one offline document. It is generated from the Markdown files, which remain the source of truth. Run `make docs-html` after editing the docs, or `make docs` to refresh the build and analysis as well. [Maintaining the HTML Documentation](docs/HTML_DOCUMENTATION.md) covers the Node.js requirement, regenerating while you edit, and freshness checks.

---

## Status

The restored build reproduces the surviving `DORKSDIL.BIN` **byte for byte**. All 7,840 executable bytes are assembled from recovered source. The complete PRG is 12,290 bytes, loads at `$1000`, and starts at `$1960` (`SYS 6496`).

VICE 3.10 checks on a PAL C16 with 16 KB RAM confirm that the title screen renders and that the game reaches its main loop when given scripted fire input. I haven't tested the keyboard by hand or played the game through yet. Seven regression tests pass.

![Restored game running on an emulated C16](docs/images/restored-gameplay.png)

[Restoration Status](docs/RESTORATION_STATUS.md) has the evidence, the source dependencies, and what the checks don't cover. Earlier reports of an incomplete display describe the superseded reconstruction.

---

## History and Purpose

I wrote the game at Micro-Projects Ltd. under the development name **Rooms of Peril**. Gremlin Graphics in Sheffield renamed it **Dork's Dilemma** when it published and launched the game in 1985.

My development machine was a C64 with a 1541 disk drive. I edited and assembled the source on the C64, then loaded and tested it on the C16 through the shared, daisy-chained drive. This project preserves an authentic version of the game, along with a recovery process I can reuse for other surviving development disks.

[Development History](docs/DEVELOPMENT_HISTORY.md) has my recollections, the original tools, the earlier conversion, the current capture, and my photograph of the surviving disks. [Recovered Disk and Folder Contents](docs/RECOVERED_DISK_CONTENTS.md) catalogues the supplied material. Closer research into the development aids is planned for a later revision.

[Artwork, Packaging, and Reviews](docs/PUBLICATION_ARCHIVE.md) shows selected cover art, the cassette inlay and instructions, and scrapbook reviews from 1985 and 1986, with source captions and the preserved images from my personal archive.

---

## Build and Run

Install Python 3.9 or later, [cc65](https://cc65.github.io/) (`ca65` and `ld65`), and [VICE](https://vice-emu.sourceforge.io/) (`xplus4`). On macOS with Homebrew:

```sh
brew install cc65 vice
```

Build and verify the PRG:

```sh
./build.sh
```

Run it on an emulated 16 KB PAL C16:

```sh
scripts/run_vice.sh build/dorks.prg
```

The launcher waits for the machine to finish resetting, loads the PRG at its saved address, and enters at `$1960`. The PRG has no BASIC `RUN` stub, so the launcher drives the VICE monitor instead of using BASIC autostart.

The original keyboard controls are `Z` and `X` for left and right, `;` and `/` for up and down, and Space for fire/start. `F1` switches between keyboard and joystick, and `F2` switches sound. How these map to host keys depends on the VICE keymap. They come from the source and haven't been tested by hand.

### PlatformIO

```sh
pio run -e c16
pio run -e c16 --target upload
```

PlatformIO runs the same restoration pipeline and writes `build/platformio/c16/dorks.prg`. The upload target launches VICE. The `c16_debug` environment also writes labels, a listing, a map, and debug information, with identical game bytes. See the [PlatformIO Guide](docs/PLATFORMIO_GUIDE.md).

---

## What the Build Uses

The input is `Dorks-Dilemma-C16-2026-FullDiskCopy/Dorks-Dilemma-C16.d64`. The build extracts its files without modifying the image and follows the original `ROOMS OF PERIL` `.LIB` order.

Four of the modules that source references aren't in the image's live directory, so they come from the older `Original_Files/` text conversion. `build/recovery-manifest.json` says where each one came from. The bomb source, which an earlier repair had to guess at, now comes straight from the fresh image.

Screen data comes from the image's `MUFF` file. The final character set comes from the graphics region of the surviving game binary, because the standalone `CHARS` file differs in 142 bytes. **No executable code is copied from the reference binary.** The graphics are still a dependency on it, though. I haven't yet built the character set without the reference.

The generated PRG has to match the reference before the build reports success. [Source to VICE](docs/SOURCE_TO_VICE.md) walks through the process, and [Testing](TESTING.md) covers the checks.

---

## Project Contents

The recovered disk collection and `Original_Files/` hold the inputs. `scripts/restore_c16.py`, `scripts/d64_image.py`, and `config/c16.cfg` make up the current build. `build/` holds the generated extraction, converted assembly, reports, and outputs, and you can delete it and rebuild.

`src/`, `Recovered_Source/`, `disassembly/`, and `archive/` keep earlier investigation material. The old consolidated files in `src/` are not inputs to the current build.

---

## Credits and Preservation

Original programmer: Anthony Clarke, Micro-Projects Ltd. Publisher: Gremlin Graphics Ltd. The original source gives 5 March 1985 as the start of development.

Recovery uses ZoomFloppy, OpenCBM, and CBM-Transfer. The [history document](docs/DEVELOPMENT_HISTORY.md#recovery-tool-acknowledgements) credits their authors and contributors, along with the original Commodore development tools.

This is historical software, preserved for study and restoration. Existing copyright notices are retained. Whether the surviving reference binary is a release or a development build is unknown.
