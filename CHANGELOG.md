# Changelog

## [1.0] 20-10-2026

### Added

- Restoration pipeline that builds a PRG identical to the surviving `DORKSDIL.BIN` (12,290 bytes, 7,840 of them executable code assembled with ca65 and ld65): `scripts/restore_c16.py`, `scripts/d64_image.py`, `config/c16.cfg`.
- Direct D64 reader that follows directory and file-sector chains, rejects cyclic chains and flagged sectors, and never writes to the image.
- Build recovery manifest (`build/recovery-manifest.json`) and reference comparison (`build/comparison.json`) recording where each input came from.
- Seven regression tests in `test/test_restoration.py`.
- VICE launcher (`scripts/run_vice.py`, `scripts/run_vice.sh`) and a repeatable emulator check (`scripts/verify_vice.py`) that reaches the main game loop with scripted fire input and saves title and gameplay screenshots.
- PlatformIO environments `c16` and `c16_debug` that run the same pipeline (`scripts/platformio_build.py`); the debug environment also writes labels, a listing, a map, and debug information.
- Complete offline HTML handbook, `docs/DORKS_DILEMMA.html`, generated from the Markdown guides by `scripts/build_docs.mjs` with `make docs`, `make docs-html`, `make docs-watch`, `make docs-check`, and `make test-docs`. Tests are in `test/test_docs.mjs`.
- Code analysis tooling (`scripts/analyze_codebase.py`, `scripts/game_graphics.py`) and generated reference material in `docs/analysis/`: code reference, source index, asset data, and room, font, and game-graphics sheets.
- New guides: `docs/RESTORATION_STATUS.md`, `docs/SOURCE_TO_VICE.md`, `docs/PUBLICATION_ARCHIVE.md`, `docs/HTML_DOCUMENTATION.md`, and `src/README.md`.
- Cover art, cassette inlay, and scrapbook review images from my archive in `docs/images/publication/`, with a provenance manifest.
- Screenshots of the restored title screen and first room.

### Changed

- The build now reads the original `ROOMS OF PERIL` modules from the preserved C16 disk image instead of the earlier consolidated `src/` files. Four modules missing from the image's live directory come from `Original_Files/`, and the build lists them explicitly.
- `README.md`, `QUICKSTART.md`, `TESTING.md`, `PROJECT_STATUS.md`, `CODEBASE_ANALYSIS.md`, `docs/README.md`, `docs/DEVELOPMENT_HISTORY.md`, `docs/PLATFORMIO_GUIDE.md`, and `docs/RECOVERED_DISK_CONTENTS.md` rewritten for the restored build, and the prose edited to sound less machine-written and more personal, in first person.
- `Makefile`, `build.sh`, `platformio.ini`, `scripts/build_6502.py`, and the VS Code tasks and launch configurations now use the new pipeline. The old Node-based PRG launch configurations are removed.

### Fixed

- The earlier rebuild showed a blank screen. The conversion had dropped instructions placed after labels (including the decoder's `SELFMD`, `LMIRR`, and `RMIRR` lines) and had turned register equates into labels.
- The bomb routines `FILLEX`, `CHKBMB`, and `CLEXP` are now assembled from the original source in the disk image's `FILLER-BOMB`, replacing the earlier inferred versions.
- `SCRBUF = $0400` is kept as the decoder's off-screen buffer, instead of being redirected to the visible screen address.

### Known limits

Manual keyboard and joystick testing, sound, bombs, room transitions, a full play-through, and testing on physical hardware are still to do. The final character set comes from the reference binary's graphics region, because the standalone `CHARS` file differs in 142 bytes.

---

## [0.3] 19-10-2026

### Added

- Recovered development-disk collection, `Dorks-Dilemma-C16-2026-FullDiskCopy/`: three D64 images, 53 `.seq` files, and 19 `.prg` files.
- `docs/DEVELOPMENT_HISTORY.md`, with the Rooms of Peril development history, tool acknowledgements, and my photograph of the surviving disks.

---

## [0.2] 03-02-2026

### Added

- `Recovered_Source/` with a second set of named copies of the game's source modules.
- Claude Code project settings.

### Changed

- `CLAUDE.md` updated.

---

## [0.1] 20-01-2026

### Added

- Initial upload of the project: the `Original_Files/` text conversion, reformatted and ca65-converted source in `src/`, conversion and build scripts in `scripts/`, the `disassembly/` and `archive/` folders, VS Code configuration, and the first documentation.
