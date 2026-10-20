# Analysis Artifacts

## Reading the Codebase

Start with [Codebase Analysis](../../CODEBASE_ANALYSIS.md) for the game architecture, execution diagrams, memory map, graphics, and modification guide. The files below add searchable detail and reusable data from the same verified build.

| File                  | Contents                             |
| --------------------- | ------------------------------------ |
| `CODE_REFERENCE.md`   | Modules, provenance, state, symbols  |
| `codebase-index.json` | Source index and transfer sites      |
| `asset-data.json`     | Initial graphics, rooms, tables      |
| `room-layouts.svg`    | 25 decoded, mirrored templates       |
| `font-hires.svg`      | 256 glyphs in one-bit interpretation |
| `font-multicolor.svg` | Same bytes in two-bit interpretation |
| `game-player.svg`     | Dork's idle and movement graphics    |
| `game-aliens.svg`     | Eight alien designs, two frames each |
| `game-objects.svg`    | Bombs, scenery, jigsaw and effects   |
| `game-assembly.svg`   | Bytes, tile order and screen writes |
| `game-screen.svg`     | Annotated VICE gameplay capture      |

You can read the [code reference](CODE_REFERENCE.md), [source index](codebase-index.json), and [asset data](asset-data.json) on their own. The main analysis embeds the room and character atlases and five graphics explanation sheets.

---

## Reproduction and Inputs

Run from the repository root:

```sh
./build.sh
python3 scripts/analyze_codebase.py
```

The analyzer is plain standard-library Python. It reads the original D64, the four older text fallbacks, and the existing verified build. It checks the preserved input hashes against the recovery manifest, requires a PRG identical to the reference, and checks that the listing accounts for every byte of the 7,840-byte assembled region. Its `scripts/game_graphics.py` helper assembles the named graphics from the verified bytes and embeds the existing `docs/images/restored-gameplay.png` in the annotated screen sheet. It writes only analysis outputs, and it neither rebuilds the game nor launches an emulator.

`--build-dir` picks an existing verified build directory and `--output-dir` picks the folder for the generated files. The defaults are `build/` and `docs/analysis/`. Relative links in `CODE_REFERENCE.md` assume the usual `docs/analysis/` location.

The hand-written architecture guide and this README are maintained separately. The other eleven files in this folder are generated. To change them, change the analyzer, the graphics helper, or the verified inputs and regenerate, rather than editing the files by hand.

---

## Interpretation and Limits

### Source Index

Module order follows the original include chain. Logical source lines refer to the decoded, normalized original modules, not to line numbers in the generated combined assembly. Each module's byte count includes code and embedded data. A label can mark a constant, storage, data, or a branch target, so it doesn't tell you where a function starts or ends.

The JSON lists direct source branches and jumps with their operands and, where available, their resolved targets. It leaves out fall-through, macro-expanded transfers, interrupt-vector dispatch, and self-modified instructions. It's a navigation index, not a full call graph or execution trace. Comments are kept for reference and haven't been checked as specifications.

### Graphics and Room Data

The glyph sheets use the initial 2,048-byte character bank from the reference PRG, with eight bytes per glyph. The one-bit and two-bit sheets read the same bytes in different ways. Their preview colours separate the raw values and don't follow TED palette rules. Runtime character animation isn't shown in these static sheets.

The five `game-*.svg` sheets explain Dork, all eight two-frame alien designs, selected objects and effects, tile assembly, and the screen layout. Runtime animation frames come from assembled tables such as `BALMAN`, `DEF1`, and `DEF2`, while movement blocks and fixed objects come from the initial character bank. The object sheet rebuilds the jigsaw expansion and the death-cross pattern, and labels its example radar marker. These are deterministic reconstructions from source data, not captures of a full animation or a play session. The screen sheet embeds the existing VICE capture with labelled outlines around its regions, and the game content shown is unchanged.

The room sheet decodes `MUFF` as 25 records of 96 bytes. Each record gives 24 rows of 16 two-bit cells, mirrored to make 32 columns. The JSON keeps both the compressed bytes and the decoded indices. The original decoder turns index values 0–3 into character codes 196–199.

Layout IDs aren't fixed positions in the room grid, because `ROMNUM` assigns layouts to logical rooms at runtime. The atlas leaves out doors, cleared-room changes, jigsaw pieces, enemies, players, and bombs. Its colours mark indices, not final tile graphics.

The named tables in `asset-data.json` are limited extracts chosen for study: raster compares, doors, enemy setup, difficulty, palette-related data, and control-option glyphs. They don't cover every asset or every use of each table. If you reuse this data for a new edition, keep the provenance of the authentic input and graphics.
