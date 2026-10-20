# Documentation Index

## Complete HTML Handbook

[Complete HTML documentation](DORKS_DILEMMA.html) puts these Markdown guides and their images into one offline document, with navigation, chapter search, diagrams, and a historical appendix. Markdown remains the source of truth, and the HTML is generated from it. [Maintaining the HTML Documentation](HTML_DOCUMENTATION.md) explains regeneration and freshness checks.

---

## Current Build and Verification

[Restoration Status](RESTORATION_STATUS.md) covers the byte-identical rebuild, source provenance, graphics dependency, emulator results, and the limits of the verification. [Source to VICE](SOURCE_TO_VICE.md) explains recovery, extraction, assembly, packaging, and running the game.

[Quick Start](../QUICKSTART.md), [PlatformIO Guide](PLATFORMIO_GUIDE.md), and [Testing](../TESTING.md) have the current commands.

[Codebase Analysis](../CODEBASE_ANALYSIS.md) explains the architecture, how the modules relate, and the memory model. It includes execution diagrams, decoded room and character atlases, and guidance for learning from the code, modifying it, and building new versions on other platforms.

The [analysis artifact guide](analysis/README.md) covers the generated [code reference](analysis/CODE_REFERENCE.md), [source index](analysis/codebase-index.json), and [asset data](analysis/asset-data.json). It also says how to regenerate them and what the static previews show.

---

## History and Recovered Material

[Development History](DEVELOPMENT_HISTORY.md) covers the Rooms of Peril development name, Gremlin Graphics' rebranding to Dork's Dilemma, my C64–1541–C16 workflow, the recovery background, the tool credits, and the disk photograph.

[Artwork, Packaging, and Reviews](PUBLICATION_ARCHIVE.md) shows the published game through selected cover art, cassette packaging, and scrapbook review pages from 1985 and 1986. The captions and an asset manifest give the supplied sources and separate printed claims from what the restored binary does.

[Recovered Disk and Folder Contents](RECOVERED_DISK_CONTENTS.md) inventories the supplied collection and gives provisional identifications of the tools. Closer research into the individual development aids is deferred to a later revision.

---

## Earlier Investigation Records

`FINAL_STATUS.md`, `REBUILD_STATUS.md`, `BUILD_SUCCESS.md`, `ASSEMBLY_FINAL_STATUS.md`, `ASSEMBLY_ERRORS.md`, and `BINARY_STRUCTURE_FIX.md` describe the earlier reconstruction. `DISASSEMBLY_REVERSE_ENGINEERING.md`, `DISASSEMBLY_PLAN.md`, and `MISSING_FUNCTIONS_FOUND.md` cover the guessed recovery of the bomb code, before the original continuation turned up.

These historical reports still carry their old completeness claims and commands, and the current status and build guides supersede them. Their guessed implementations are not inputs to the current build.

The root `STRUCTURE.txt`, `SUMMARY.txt`, and `PROJECT_SETUP.md` also describe earlier analysis. Check their technical details against the recovered source before relying on them.
