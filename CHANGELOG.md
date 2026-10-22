# Changelog

## [1.2.0] 23-10-2026

Structure and documentation release. It brings the repository layout, document set and tooling in line with my Tycoon Tex, Xargon Wars and Xargon's Revenge restorations, and moves the material from my first restoration attempt out of the repository. The game build is unchanged and still matches `DORKSDIL.BIN` byte for byte (SHA-256 `3c6f6426…a7ce05`).

### Added

- `RIGHTS.md`, `docs/SHARING_ON_GITHUB.md`, `docs/PORTING_GUIDE.md` and `docs/GRAPHICS.md`. The porting guide and graphics chapter are the "Modifying", "New Platforms" and "Game Graphics" sections moved out of `CODEBASE_ANALYSIS.md`, unchanged apart from links.
- A "Recovery Background and Build Template" section in `docs/HISTORY_AND_CREDITS.md`: how the January–April 2026 attempt worked, why it failed, and how the October pipeline replaced it and became the template for my other restorations.
- `docs/verification/` with the reviewed build comparison, source manifest, VICE result and tool versions for this checkpoint.
- GitHub Actions workflow (`.github/workflows/build.yml`) that builds, tests, builds both PlatformIO environments and checks they agree.
- `.gitattributes` that turns off text conversion for `Original Source Recovered/` and `Original Artifacts/`.
- `make verify`, and `--original` in `scripts/run_vice.py` to launch the surviving binary.

### Changed

- Folders renamed to the common layout: `Original_Files/` is now `Original Source Recovered/1992/`, `Dorks-Dilemma-C16-2026-FullDiskCopy/` is now `Original Source Recovered/2026/`, and the publication images and disk photograph moved from `docs/images/` to `Original Artifacts/`. File contents are unchanged. Scripts, tests, VS Code tasks and docs use the new paths.
- Docs renamed to the common set: `DEVELOPMENT_HISTORY` is `HISTORY_AND_CREDITS`, `PUBLICATION_ARCHIVE` is `ARTIFACTS`, `RECOVERED_DISK_CONTENTS` is `SOURCE_INVENTORY`, `RESTORATION_STATUS` is `SOURCE_AND_VALIDATION`, and `SOURCE_TO_VICE` with `PLATFORMIO_GUIDE` is `BUILD_AND_RUN`.
- README, Quick Start, Testing, `src/README.md` and the handbook chapter list follow the common structure. Release badge updated to `v1.2.0`.
- `.gitignore`, `.editorconfig`, `Makefile` and the VS Code settings and extension recommendations match the other restorations.
- The documentation test expects no link warnings, now that there are no historical reports.

### Removed

- The first restoration attempt, none of it a build input: the consolidated and converted source in `src/`, `Recovered_Source/`, `disassembly/`, `archive/`, `include/`, `lib/`, `images/`, the root `test_*.asm` files, 13 conversion scripts, 12 status reports and the old index in `docs/`, and `PROJECT_SETUP.md`, `PROJECT_STATUS.md`, `STRUCTURE.txt` and `SUMMARY.txt`. They stay in Git history up to commit `90f8739`.
- `TycoonText-C16.d64` from the 2026 disk folder. It is a byte-identical copy of the Tycoon Tex source disk, preserved in that repository.
- The empty `.vscode/launch.json`.

---

## [1.1.0] 22-10-2026

Documentation release. It brings the README, the HTML handbook and its tests in line with my Tycoon Tex and Xargon Wars restorations. The game build is unchanged and still matches `DORKSDIL.BIN` byte for byte.

### Added

- `docs/GREMLIN_ARCHIVE.md`, a chapter on Mark Hardisty's book *A Gremlin in the Works* and the Gremlin Graphics Archive, shared with my other Micro Projects reconstructions. Its project section compares this project's files with the archive's `Old-Development-Disks.zip` by CRC-32 and size: all 71 files in `Original_Files/` match `DISK5.ZIP`, 60 of the 66 files in `Dorks-Dilemma-C16.d64` match `DISK5`, and 66 of the 72 loose files in the 2026 disk copy match the C64 disk, `DISK1B.ZIP`. The others are BASIC programs, exported as listings, and the truncated `FILLER-BOMB`.
- A short section in `docs/DEVELOPMENT_HISTORY.md` linking the chapter.
- Seven local SVG badges in `docs/images/badges/` (release, platform, byte match, toolchain, PlatformIO, emulator, status), shown under the README title.
- Two documentation tests: the saved handbook is current, and the full handbook has its Mermaid diagram, JPEG images and badges, with warnings only from historical reports.

### Changed

- The README follows the same section order as my other restorations: Verified Build, Build and Run, Preserved Inputs, History and Recovery Background, Learning, Modification, and Ports, and Tests and Sharing.
- `scripts/build_docs.mjs` and `scripts/docs/handbook.css` match the Tycoon Tex generator: GIF images are embedded, and badge images render inline in a row.
- The changelog is a chapter in the HTML handbook's reference group, as in my other restorations.
- Small wording edits in `docs/HTML_DOCUMENTATION.md`, which now mentions the badge files.

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

---

## [0.1] 20-01-2026

### Added

- Initial upload of the project: the `Original_Files/` text conversion, reformatted and ca65-converted source in `src/`, conversion and build scripts in `scripts/`, the `disassembly/` and `archive/` folders, VS Code configuration, and the first documentation.
