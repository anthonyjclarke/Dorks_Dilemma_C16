# Source Navigation

## Build Inputs

The active assembly source is kept under `Original Source Recovered/`. The build reads `2026/Dorks-Dilemma-C16.d64` first and fills the four modules missing from its live directory from the 1992 export. `ROOMS OF PERIL` is the original main assembly file, and its `.LIB` directives set the module order.

The modern ca65 source is generated as `build/recovered-c16.s`. It keeps module and line markers, so converted code can be traced back to the originals. The listing, labels, map and debug file are generated next to it.

---

## Preservation Target

I don't keep a hand-consolidated copy of the game in this folder. The earlier consolidated and converted files from my first restoration attempt had conversion defects and were never inputs to the current build; I removed them on 23 October 2026, and they are still in the Git history. [History and Credits](../docs/HISTORY_AND_CREDITS.md#recovery-background-and-build-template) explains that change.

The direct build, Makefile, PlatformIO, tests and VS Code tasks all use the same source-selection and conversion path, and editing generated assembly changes nothing on the next build. [Source Inventory](../docs/SOURCE_INVENTORY.md) lists the recovered files, [Build and Run](../docs/BUILD_AND_RUN.md) covers the tooling and [Source and Validation](../docs/SOURCE_AND_VALIDATION.md) describes the byte-for-byte check. If you change the source on purpose, you also have to change the strict preservation check on purpose.
