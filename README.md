# Dork's Dilemma C16

![Release v1.2.0](docs/images/badges/release.svg)
![Platform Commodore 16 / Plus/4](docs/images/badges/platform.svg)
![Byte match 12,290 of 12,290](docs/images/badges/byte-match.svg)
![Toolchain cc65](docs/images/badges/toolchain.svg)
![PlatformIO 6.1](docs/images/badges/platformio.svg)
![Emulator VICE 3.10](docs/images/badges/emulator.svg)
![Status preservation](docs/images/badges/status.svg)

This project reassembles the surviving **Dork's Dilemma** source for the Commodore 16 and Plus/4 with PlatformIO, VS Code and the cc65 toolchain. I wrote the game at Micro-Projects Ltd. under the development name **Rooms of Peril**. Gremlin Graphics in Sheffield renamed it **Dork's Dilemma** when it published and launched the game in 1985.

Open the [complete HTML handbook](docs/DORKS_DILEMMA.html) for the history, artwork and reviews, restoration, build guides, code analysis, graphics and reference in one offline document. It's generated from the Markdown files, which stay the source of truth. Run `make docs-html` after editing the docs, or `make docs` to refresh the build and analysis as well. [Maintaining the HTML Documentation](docs/HTML_DOCUMENTATION.md) has the details.

![Dork's Dilemma cassette inlay](Original%20Artifacts/cassette-inlay.jpg)

---

## Verified Build

The restored build reproduces the surviving `DORKSDIL.BIN` **byte for byte**, all 12,290 bytes of it. Its 7,840 executable bytes are assembled from recovered source. The PRG loads at `$1000` and starts at `$1960` (`SYS 6496`).

In VICE 3.10, on a PAL C16 with 16 KB RAM, the title screen renders and the game reaches its main loop with scripted fire input. I haven't tested the keyboard by hand or played the game through yet. [Source and Validation](docs/SOURCE_AND_VALIDATION.md) has the evidence, the source dependencies and what the checks don't cover.

![Restored game running on an emulated C16](docs/images/restored-gameplay.png)

---

## Build and Run

You need Python 3.9 or later and the cc65 tools (`ca65` and `ld65`), plus VICE (`xplus4`) to run the game. On macOS with Homebrew:

```sh
brew install cc65 vice
./build.sh
python3 scripts/run_vice.py
```

The output is `build/dorks.prg`, and `./build.sh` checks it against the reference. The launcher waits for the C16 to finish resetting, loads the PRG at its saved address and enters at `$1960`. The PRG has no BASIC `RUN` stub, so the launcher drives the VICE monitor instead of using BASIC autostart. `python3 scripts/run_vice.py --original` runs the surviving 1992 binary the same way.

With PlatformIO Core installed, or from the PlatformIO terminal in VS Code:

```sh
pio run -e c16
pio run -e c16 -t upload
```

PlatformIO runs the same restoration pipeline and writes `build/platformio/c16/dorks.prg`, and the upload target launches VICE. The `c16_debug` environment produces identical game bytes, along with labels, a listing, a map and debug information. [Quick Start](QUICKSTART.md) and [Build and Run](docs/BUILD_AND_RUN.md) have the details.

In the source, the keyboard is `Z` / `X` for left / right, `;` / `/` for up / down, and Space for fire and start. `F1` switches between keyboard and joystick, and `F2` switches sound. How these map to host keys depends on the VICE keymap, and I still need to test them by hand.

---

## Preserved Inputs

`Original Source Recovered/` holds my 2026 disk capture in `2026/` and the 1992 text export in `1992/`. The build reads `2026/Dorks-Dilemma-C16.d64`, extracts its files without modifying the image, and follows the original `ROOMS OF PERIL` `.LIB` order. Four modules the source includes aren't in the image's live directory, so they come from `1992/` through an explicit list. `build/recovery-manifest.json` records where each input came from.

Screen data comes from the image's `MUFF` file. The final character set comes from the graphics region of the surviving game binary, because the standalone `CHARS` file differs in 142 bytes. **No executable code is copied from the reference binary.** The graphics still depend on it, though, and I haven't yet built the character set without it.

`Original Artifacts/` has the cover art, cassette inlay, scrapbook reviews and my photograph of the development disks. The [Artifact Catalogue](docs/ARTIFACTS.md) describes them.

Generated assembly, extracted working copies and build reports all go into `build/`, which you can delete and rebuild, and the original inputs stay byte for byte as they were. The [Source Inventory](docs/SOURCE_INVENTORY.md) catalogues the recovered material.

---

## History and Recovery Background

My development machine was a C64 with a 1541 disk drive. I edited and assembled the source on the C64, then loaded and tested it on the C16 through the shared, daisy-chained drive. Original programmer: Anthony Clarke, Micro-Projects Ltd. Publisher: Gremlin Graphics Ltd. The original source gives 5 March 1985 as the start of development.

This is where my restorations started. The first attempt, from January to April 2026, repaired a hand-consolidated copy of the 1992 export and never got the game running. In October 2026 I switched to a pipeline that reads the preserved disk directly and compares every byte with the surviving game, and that pipeline became the template for [Tycoon Tex](https://github.com/anthonyjclarke/Tycoon_Tex_C16), [Xargon Wars](https://github.com/anthonyjclarke/Xargon_Wars_C16) and [Xargon's Revenge](https://github.com/anthonyjclarke/Xargons_Revenge_C16_v2).

[History and Credits](docs/HISTORY_AND_CREDITS.md) has my recollections, the original tools, the earlier conversion, the 2026 capture, how the approach changed and the recovery-tool acknowledgements. [Gremlin Archive and the Book](docs/GREMLIN_ARCHIVE.md) covers Mark Hardisty's book and archive, and matches this project's files against the development disks I donated.

---

## Learning, Modification, and Ports

[Codebase Analysis](CODEBASE_ANALYSIS.md) explains how the restored game is put together, and [Illustrated Graphics](docs/GRAPHICS.md) shows the rooms, characters and fonts decoded from the game. The [Modification and Porting Guide](docs/PORTING_GUIDE.md) covers changing the game without losing the authentic baseline and planning a version for another platform. The [generated code reference](docs/analysis/CODE_REFERENCE.md) and [asset data](docs/analysis/asset-data.json) help with finding your way around the source. There's no modified-game build yet: the restoration target has to match the reference exactly.

---

## Tests and Sharing

```sh
make test
make verify
```

Seven regression tests cover the restored build and its inputs. The VICE check covers title rendering and gameplay entry with scripted input, and saves title and gameplay screenshots. I still haven't tested the keyboard by hand, listened to the sound, tried real hardware or played all the way through. See [Testing](TESTING.md).

[Sharing on GitHub](docs/SHARING_ON_GITHUB.md) covers branches, checks and tags. The historical notices are all still in place; see [Rights and Preservation](RIGHTS.md). Whether the surviving reference binary is a release or a development build is unknown. Changes are recorded in the [Changelog](CHANGELOG.md).
