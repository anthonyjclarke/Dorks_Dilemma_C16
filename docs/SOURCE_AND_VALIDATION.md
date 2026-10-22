# Source and Validation

## Result – 20 October 2026

The restored build produces a PRG identical to the surviving reference binary. All executable code is assembled with ca65 and linked with ld65 from source. The final character set is the one graphics dependency on the reference, as described below.

| Measurement                | Verified value            |
| -------------------------- | ------------------------- |
| Executable code            | 7,840 bytes               |
| Complete PRG               | 12,290 bytes              |
| PRG load address           | `$1000`                   |
| Entry address              | `$1960` / `SYS 6496`      |
| Differences from reference | 0 bytes                   |
| Emulator configuration     | VICE 3.10, PAL C16, 16 KB |
| Regression tests           | 7 passing                 |

The output and `Original Source Recovered/1992/DORKSDIL.BIN` share this SHA-256:

```text
3c6f6426b93862de9bd836842f1ffc0bc46f19056e2fc0706ca0da8037a7ce05
```

The copy of the game inside the 2026 disk image matches that 1992 binary too. So the build reproduces the surviving binary. Whether that binary is a release or a development build remains unknown.

The [build comparison](verification/build-comparison.json), [VICE report](verification/vice-verification.json) and [source manifest](verification/source-manifest.json) are the evidence for this checkpoint. The [tool checks](verification/tool-checks.json) record the tool versions and the build agreement. Every new build writes fresh reports to its output directory.

---

## Source Selection and Assembly

The build input is `Original Source Recovered/2026/Dorks-Dilemma-C16.d64`, which has 66 live directory entries. Its `FILLER-BOMB` has the continuation missing from the 1992 `FILLERBO.TXT`, including `FILLEX`, `CHKBMB`, and `CLEXP`, and those routines are now assembled directly from recovered source.

Four active `.LIB` references have no matching file in the image's live directory:

| Original module    | 1992 input     |
| ------------------ | -------------- |
| `RASTER-ROUTINES`  | `RASTERRO.TXT` |
| `ALIENS-MEGA/CODE` | `ALIENSME.TXT` |
| `ALIEN-CHEK/PRINT` | `ALIENCHE.TXT` |
| `WHOOPPEE-MESSAGE` | `WHOOPPEE.TXT` |

The build uses these specific older copies from `Original Source Recovered/1992/` and restores upper-case source from the earlier PC text export. Matching every executable byte checks the resulting instructions and data against the surviving game. It doesn't prove the four files were on the disk, and it doesn't recover their original file bytes.

Every extracted file and fallback input is listed with its source and hash in `build/recovery-manifest.json`. The loose files beside the image are not build inputs.

The converter keeps instructions that follow labels and keeps register definitions as equates. The earlier hand-consolidated rebuild lost both, including the decoder's `SELFMD LDA $FFFF,X`, `LMIRR LDA $FFFF,X`, and `RMIRR STA $FFFF,Y`. Because the decoder modifies itself, losing them made it overwrite the wrong bytes and left a blank screen. The original `SCRBUF = $0400` stays: it is the decoder's off-screen buffer, and the display routines also use screen memory at `$0C00`.

### Memory Layout

| Address range | Content                          |
| ------------- | -------------------------------- |
| `$0002–$00C2` | Zero-page game variables         |
| `$0200–$02F3` | Runtime tables                   |
| `$0400–$07BF` | Decoder off-screen room buffer   |
| `$0800–$0BFF` | Display attributes               |
| `$0C00–$0FE7` | Visible character screen         |
| `$1000–$195F` | `MUFF` room data                 |
| `$1960–$37FF` | Assembled code and data          |
| `$3800–$3FFF` | Character set                    |

Only `$1000–$3FFF` is PRG payload, and the code region is full, with no spare bytes. The linker configuration is `config/c16.cfg`. [Codebase Analysis](../CODEBASE_ANALYSIS.md#allocations-in-the-working-build) explains each region.

---

## Graphics Provenance

The image's `MUFF` supplies 2,400 bytes of room data at `$1000`. The standalone `CHARS` file differs from the surviving game's character set in 142 bytes, within `$3C40–$3FC7`. So the build takes only the character-set region of the reference binary, and records it as a graphics asset. All 7,840 executable bytes still come from assembly.

Generating the exact final character set from the other original assets and development utilities is future research. The original standalone `CHARS` file is kept in the generated disk extraction.

---

## Comparison with the Reference

Unlike my other restorations, Dork's Dilemma has a complete surviving game binary of the same revision as the source, so the whole PRG is compared, not just an object listing. The build stops on the first byte that differs. `build/comparison.json` records the result and the character-set dependency.

VICE's `c1541` extracted `FILLER-BOMB` and the reference PRG independently, and those bytes matched the output of the project's own disk reader.

---

## Emulator Evidence and Limits

VICE 3.10 runs the restored PRG on a PAL C16 with 16 KB RAM. The repeatable emulator check stops at the original fire-input test, sets the `JFIRE` input flag, and resumes the original code. It reaches the main `LOOP`, confirms `TITLE = 0` and `LIVES = 3`, and captures the room display. It doesn't patch any instructions or jump past the game's initialization.

![Restored title screen in VICE](images/restored-title.png)

![Restored first room in VICE](images/restored-gameplay.png)

Manual keyboard mapping, joystick input, sound, bomb mechanics, room transitions, and a full play-through haven't been verified. Byte equality shows the program bytes match the surviving reference. It doesn't mean the game has been played exhaustively, and it hasn't been tested on physical hardware.

---

## Continuous Integration

On every push and pull request, the GitHub Actions workflow builds from the preserved disk, runs the regression tests, builds both PlatformIO environments, checks that every output is identical and checks that the HTML handbook is current. It doesn't run a graphical emulator, so the VICE evidence above comes from local runs.

---

## Recovery Background

The first restoration attempt, from January to April 2026, worked from a hand-consolidated copy of the 1992 export and never got past a partly drawn title screen. [History and Credits](HISTORY_AND_CREDITS.md#recovery-background-and-build-template) explains what changed and how the current pipeline became the template for my other restorations.
