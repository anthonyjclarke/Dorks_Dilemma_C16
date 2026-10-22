# Dork's Dilemma – Codebase Analysis

## Purpose, Scope, and Evidence

This document explains how the working game fits together, for anyone who wants to **modify it, learn from it, or build new versions on other platforms**. It ties the original modules, game state, data, and hardware dependencies together so that changes can be made with a clear idea of how the game works.

The authentic C16 restoration is the reference. A new version can change the rules, presentation, controls, or platform, as long as it's clear which behaviour came from the original and which was changed on purpose. The current restoration build stays as the reproducible baseline. There is no separate development source tree or build target for modified versions yet.

This analysis was updated on 20 October 2026 against the recovered source, the generated assembly, the linker map, and the current restoration scripts. [Source and Validation](docs/SOURCE_AND_VALIDATION.md) has the verification evidence and [Build and Run](docs/BUILD_AND_RUN.md) has the build instructions.

Read it alongside the [generated code reference](docs/analysis/CODE_REFERENCE.md), the [machine-readable index](docs/analysis/codebase-index.json), and the [extracted asset data](docs/analysis/asset-data.json). The reference lists every active module, where it came from, the zero-page allocations, and the symbols with their addresses and logical source-line numbers. Treat these as navigation aids: a label isn't necessarily a function, and static transfers don't cover every path the game can take at runtime.

The diagrams describe the working source, and the room and character atlases decode real game bytes. Proposed changes and port architecture are marked as future work. The emulator evidence covers startup and entry into gameplay, not a full play-through.

---

## Game and Verified Baseline

Dork's Dilemma is a room-based action game built around a 5 × 5 room grid, jigsaw pieces, enemies, and bombs. The code keeps a room's logical position separate from its assigned layout and jigsaw data, so a room is game state as well as a picture.

![Restored C16 gameplay captured in VICE](docs/images/restored-gameplay.png)

*The restored build entering gameplay in VICE. The room-layout atlas below isolates the stored scenery from the live display.*

I wrote the game at Micro-Projects Ltd. under the development name **Rooms of Peril**. Gremlin Graphics in Sheffield renamed it **Dork's Dilemma** when it published and launched the game in 1985. The main source gives 5 March 1985 as the start of development.

The development machine was a C64 with a 1541 drive. Source was edited and assembled on that machine, then loaded and tested on the C16 through the shared, daisy-chained drive. The recovered assembler calls itself Commodore's resident assembler. It has a BASIC startup stub, but that doesn't make it an assembler written in BASIC. Parts of the historical workflow are still pieced together from the files. See [History and Credits](docs/HISTORY_AND_CREDITS.md).

The earlier text conversion probably dates from 1992, going by my recollection and the surviving index timestamps. It shouldn't be called a confirmed studio archival process. Whether the surviving reference binary is a release or a development build is unknown.

### Current Result

| Property                | Verified baseline              |
| ----------------------- | ------------------------------ |
| Target configuration    | PAL C16, 16 KB RAM             |
| Assembled program bytes | 7,840                          |
| Complete PRG bytes      | 12,290                         |
| PRG load address        | `$1000`                        |
| Program entry           | `$1960` / `SYS 6496`           |
| Reference comparison    | Byte-identical complete PRG    |
| Active assembly inputs  | 46, including the main file    |
| Build checks            | Seven regression tests passing |

All program bytes are assembled from source. The final character graphics come from the reference binary's graphics region, because the standalone character file differs in 142 bytes. Four source modules come from the older text conversion, as described below.

VICE checks have confirmed that the title screen renders and that the game reaches its main loop on a 16 KB PAL C16, using a scripted fire-input flag. Those automated checks stop at startup and gameplay entry. [Testing](TESTING.md) lists the manual checks still to do.

---

## Repository and Source Organization

The active build starts from `Original Source Recovered/2026/Dorks-Dilemma-C16.d64`, whose live directory has 66 files. It follows the original `ROOMS OF PERIL` `.LIB` directives and doesn't assemble the loose files beside the image or the earlier consolidated source, which now lives outside the repository.

The image has the full continuation of `FILLER-BOMB`, including `FILLEX`, `CHKBMB`, and `CLEXP`, so the build now uses original source for these routines instead of the earlier guessed versions.

Four active include references have no matching live directory entry. The build supplies their surviving older copies explicitly from `Original Source Recovered/1992/`:

| Original disk module | Earlier source input (`1992/`) |
| -------------------- | ------------------------------ |
| `RASTER-ROUTINES`    | `RASTERRO.TXT`                 |
| `ALIENS-MEGA/CODE`   | `ALIENSME.TXT`                 |
| `ALIEN-CHEK/PRINT`   | `ALIENCHE.TXT`                 |
| `WHOOPPEE-MESSAGE`   | `WHOOPPEE.TXT`                 |

Those text exports are converted to upper case for assembly. Matching the full program region checks the resulting instructions and embedded data against the reference, but it doesn't recover the missing modules' original disk-file bytes.

### Module Responsibilities

| Concern                | Main module examples                 |
| ---------------------- | ------------------------------------ |
| Entry and definitions  | `ROOMS OF PERIL`, `VARS`             |
| Hardware and storage   | `MAIN-VARS`, `EXTRA-MEMORY`          |
| Foreground loop        | `PLAY-GAME`                          |
| Raster scheduling      | `IRQ`, `RASTER-ROUTINES`             |
| Title and choices      | `MAGNIFICENT`, `ALTERABLES`          |
| Input                  | `JOYSTIK`, `KEY-SCAN`, `INKEY`       |
| Player and collision   | `MOVE-PIXEL`, `CHECK-MAN`            |
| Room transitions       | `CHANGE-ROOM`                        |
| Room setup and display | `INIT-ROOMS`, `DECODER`, `DUMPER`    |
| Jigsaw logic           | `SCATTER`, `JIGSAW-CODE`             |
| In-game editing        | `COMMAND`, `EDIT-JIGSAW`             |
| Bombs and explosions   | `BOMB-CODE`, `FILLER-BOMB`           |
| Enemy movement         | `ALIENS-MEGA/CODE`                   |
| Enemy drawing and hits | `ALIEN-CHEK/PRINT`, `KILLER-CODE`    |
| Death and game over    | `DEATH-CODE`, `GAME-OVER`            |
| Difficulty             | `LEVEL-INCREASE`                     |
| Scoring                | `SCORE-ROUTINES`, `WORK-HIGH`        |
| High-score display     | `HIGH-PRINT`, `HALL-OF-FAME`         |
| Interface and radar    | `SCREEN-INIT`, `RADAR-SCANNER`       |
| Character effects      | `ANIMATE-CHARS`, `VARIETY`           |
| Presentation           | `BORDER`, `TITLE-WORKS`              |
| Scrolling message      | `MESSAGE-STUFF`, `WHOOPPEE-MESSAGE`  |
| Shared helpers         | `UTILS`, `TABLES`, `MACROS`, `SETUP` |

The [generated reference](docs/analysis/CODE_REFERENCE.md#modules-in-assembly-order) lists the full 46-module assembly order and how many bytes each module adds to the program region. Definitions and macros can add no bytes themselves and still be essential inputs.

### Files to Read During Analysis

`build/disk/` holds the extracted disk files with their original contents. `build/recovered-c16.s` is the generated assembly in include order, with source-module comments, and `build/recovered-c16.lst` shows the assembled instructions and addresses.

`build/labels.txt`, `build/map.txt`, and `build/dorks.dbg` tie labels to memory. `build/recovery-manifest.json` has the input provenance and hashes, and `build/comparison.json` has the reference comparison and the graphics dependency. All of these are generated, and `./build.sh` recreates them.

The earlier hand-consolidated source (`main.s`, `main_ca65.s` and the guessed repair routines) has known conversion defects and was never a build input. I moved it out of the repository on 23-10-2026; it stays in Git history, and [History and Credits](docs/HISTORY_AND_CREDITS.md#recovery-background-and-build-template) explains how that first approach led to the current one. See [the source-folder note](src/README.md).

---

## Build Architecture

`build.sh`, the Makefile, and PlatformIO all use `scripts/restore_c16.py`. The disk reader is `scripts/d64_image.py`; the linker layout is `config/c16.cfg`.

The pipeline reads the preserved image, resolves the original includes, converts the assembler syntax, assembles and links the program, adds the screen and character data, and compares the complete PRG with the reference. A missing or ambiguous include, an assembler or linker failure, code that overlaps the character set, and any difference from the reference all stop the build.

```mermaid
flowchart LR
    Disk["Preserved D64<br/>ROOMS OF PERIL and .LIB chain"] --> Resolve["Resolve original modules"]
    Archive["Four older text exports"] --> Resolve
    Resolve --> Convert["Convert assembler syntax"]
    Convert --> Assemble["ca65 and ld65<br/>$1960–$37FF"]
    Assemble --> Package["Package loadable PRG"]
    Rooms["MUFF<br/>room data at $1000"] --> Package
    Chars["Reference graphics<br/>character bank at $3800"] --> Package
    Package --> Compare["Compare complete reference PRG"]
    Compare --> VICE["Load at $1000<br/>enter at $1960"]
```

PlatformIO's `c16` and `c16_debug` environments produce the same game bytes under their own `build/platformio/` directories, and the debug information doesn't change the program. PlatformIO only uses the native platform as a build context for the custom assembly pipeline, so the game doesn't become a native host executable.

The VICE launcher waits for initialization, loads the PRG at its saved address, and enters at `$1960`. The PRG has no BASIC `RUN` stub. [Build and Run](docs/BUILD_AND_RUN.md) has the current commands.

---

## Runtime Architecture

The foreground loop and the raster interrupt services share writable memory, and input, movement, bomb effects, and enemy logic are spread across both. A port has to keep that relationship as well as the rules inside each routine.

```mermaid
flowchart TD
    Entry["Entry $1960<br/>message and high-score initialization"] --> Title["GLOPPY / GLLOO<br/>title and options"]
    Title -->|Fire: three lives, level zero| Init["PLAY<br/>initialize rooms and draw start"]
    Init --> Loop["LOOP<br/>death, commands, bombs, radar, enemies"]
    Loop -->|NEWROM| Room["ROOMON<br/>decode and show next room"]
    Room --> Loop
    Loop -->|Death, lives remain| Respawn["DEADCK / MORE<br/>restore saved player state"]
    Respawn --> Loop
    Loop -->|No lives remain| Over["GMEOVR<br/>game-over presentation"]
    Over --> Title
    Loop -->|Progression path| Level["UPLEVL<br/>advance difficulty, capped at index 4"]
    Level --> Init
    IRQ["SERV<br/>two alternating raster services"] -.-> Title
    IRQ -.-> Init
    IRQ -.-> Loop
```

*This is a control-flow overview. It groups helper calls and presentation sequences instead of treating every branch label as its own game state.*

### Startup, Title, and Foreground Loop

`ROOMS OF PERIL` defines constants, variables, macros, initialization, and include order. Entry at `$1960` initializes the message pointer and high-score data, then transfers to `GLOPPY` in `MAGNIFICENT`.

`GLOPPY` configures the title presentation and interrupts. `GLLOO` handles title options and waits for fire. The fire path clears the title and level flags, sets three lives, and enters `PLAY`.

`PLAY` initializes a game, prepares rooms and jigsaw placement, and draws the starting room. Its foreground `LOOP` handles death, commands, bomb processing, requested room changes, radar updates, and tempo-controlled alien movement. It delegates frequent animation and input work to the interrupt path.

### Interrupt Work and Shared State

`IRQ` installs the interrupt handler and alternates between two raster services. `RASTER-ROUTINES` supplies `RAST1` and `RAST2`: one updates character animation and randomness, while the other handles the scrolling message, input, and selected gameplay updates.

When `STOP` permits gameplay work, the raster service also updates bombs, prints aliens, and moves the player. `TITLE` controls title-specific work. The handler saves and restores shared screen pointers around interrupt processing.

```mermaid
flowchart LR
    Compare["Raster compare interrupt"] --> Save["SERV<br/>acknowledge; toggle INTYPE<br/>save SL and CL"]
    Save -->|INTYPE = 0| First["RAST1<br/>display control<br/>ANIMAT and RANDOM"]
    Save -->|INTYPE = 1| Second["RAST2<br/>message and REDJOS"]
    Second --> Gate{"STOP = 0?"}
    Gate -->|Yes| Active["UPBOMB → PRNALS → MOVEMN"]
    Gate -->|No| TitleGate{"TITLE set?"}
    Active --> TitleGate
    TitleGate -->|Yes| Border["BDRGLP<br/>title border"]
    TitleGate -->|No| Exit["IRQEND<br/>restore pointers<br/>schedule next raster; RTI"]
    Border --> Exit
    First --> Exit
    Exit -.-> Compare
```

`RASVAL` stores `$C1, $00`. Setup schedules `$C1` with `INTYPE = 0`. The handler toggles the index before dispatch, so that first interrupt runs `RAST2` and schedules `$00`, and the next runs `RAST1` and schedules `$C1`. These are raster compare values, not millisecond timers, and busy waits and foreground work also affect the game's tempo.

`CLVARS` clears `$0007–$00FF` and leaves the message pointer, message pixel offset, lives, and extra-life state at `$0002–$0006` alone. Choices stored elsewhere, such as `JOYSEL`, `SNDFLG`, and `LEVEL`, sit outside that clearing range. A new engine should define session, level, and life resets separately.

A port should make this split explicit. If everything moves into a host application's frame callback without regard for order, update rates, and shared state, collision behaviour, movement tempo, and the order of events can change even when every routine is translated correctly.

---

## Memory and Data Model

### Allocations in the Working Build

These addresses come from the current linker map, labels, original definitions, and packaged assets. They fix the earlier analysis, which cut the zero-page range short and mixed up the load and entry addresses.

| Address range     | Role                                  |
| ----------------- | ------------------------------------- |
| `$0002–$00C2`     | Game zero-page variables, 193 bytes   |
| `$0200–$02F3`     | Runtime tables, 244 bytes             |
| `$0400–$07BF`     | Room decode buffer, 960 bytes         |
| `$0800–$0BFF`     | Display attributes and related space  |
| `$0C00–$0FE7`     | Visible character screen, 1,000 bytes |
| `$1000–$195F`     | `MUFF` screen data, 2,400 bytes       |
| `$1960–$37FF`     | Assembled program, 7,840 bytes        |
| `$3800–$3FFF`     | Character graphics, 2,048 bytes       |
| `$FF00` and above | TED hardware register definitions     |

`SCRBUF = $0400` is the off-screen room buffer, not a display address entered by mistake. `DECODER` builds room data there, and `DUMPER` copies it to the visible screen with an effect. The screen-address table in `UTILS` starts at `$0C00`.

The program fills its whole configured region up to the character set, with no unused space at the end. Adding code or embedded tables means changing the memory layout or freeing space elsewhere. A larger-memory edition or a port has to work out its own layout.

### Important State

| Symbol or table | Address      | Meaning                            |
| --------------- | ------------ | ---------------------------------- |
| `MESL`          | `$02–$03`    | Scrolling-message pointer          |
| `LIVES`         | `$05`        | Remaining lives                    |
| `RND`           | `$0E–$11`    | Four-byte random state             |
| `SL`            | `$13–$14`    | Screen/work pointer                |
| `SCREEN`        | `$1D`        | Current logical room               |
| `XPOS`, `YPOS`  | `$1E`, `$1F` | Position within the room grid      |
| `MANX`, `MANY`  | `$21`, `$24` | Player cell position within a room |
| `CL`            | `$2E–$2F`    | Display-attribute pointer          |
| `XPIX`, `YPIX`  | `$30`, `$31` | Fine movement offsets              |
| `JIGNUM`        | `$0200`      | 25 room-to-jigsaw mappings         |
| `ROMNUM`        | `$0219`      | 25 room-to-layout mappings         |
| `RADBUF`        | `$0232`      | 25 radar entries                   |
| `ALIBUF`        | `$024B`      | 64-byte alien animation buffer     |
| `GOTBIT`        | `$028B`      | 25 room-clear flags                |
| `HISTBL`        | `$02A4`      | 80-byte high-score table           |

Room-grid coordinates, player cell coordinates, and fine pixel offsets are three different things. Keep them apart if you add a higher-resolution renderer or a different movement system. The source describes `GOTBIT` as tracking cleared rooms, but trace collection and completion through the jigsaw routines instead of guessing from the table's name.

---

## Guide to the Game Modules

The names here are the original disk-module names. The source comments in the generated assembly make them searchable, so you don't have to rely on the older shortened PC filenames.

### Definitions and Utilities

`MAIN-VARS`, `VARS`, and `EXTRA-MEMORY` define hardware addresses and storage. `MACROS` supplies double-precision increment/decrement operations. `UTILS` includes randomness, delay, clearing, coordinate-to-screen calculation, and bomb-character copying; `TABLES` holds shared lookup data.

As a learning exercise, trace `XY` from coordinates to `SL` and `CL`, then look at its callers. You'll see how rendering, attributes, and collision checks all share the original character-screen representation.

### Input and Movement

`JOYSTIK`, `KEY-SCAN`, and `INKEY` provide controller and keyboard scanning. `ALTERABLES` changes input and sound selection. Direction and fire state are communicated through `JLEFT`, `JRIGHT`, `JUP`, `JDOWN`, and `JFIRE`.

`MOVE-PIXEL` combines drawing, movement candidates, fine animation, and accepted positions. `CHECK-MAN` validates the player's surroundings; `CHANGE-ROOM` recognizes doors and performs room transitions. `COMMAND` invokes in-game editing through the original command path.

The source uses `Z`/`X` for left/right, `;`/`/` for up/down, and Space for fire/start. Keyboard is the default, and the joystick routine can check both controller ports. How VICE maps these to host keys is a separate matter.

| Action              | Source keyboard control |
| ------------------- | ----------------------- |
| Left / right        | `Z` / `X`               |
| Up / down           | `;` / `/`               |
| Fire / start        | Space                   |
| Keyboard / joystick | `F1`                    |
| Sound selection     | `F2`                    |

`REDJOS` picks keyboard or joystick scanning from `JOYSEL`. The joystick path tries two port-select patterns and doesn't fall back to the keyboard on its own. Direction and fire tests read the high bit of their flags, so replacing those bytes with a boolean `1` would change what instructions such as `BIT JFIRE` do.

### Rooms and Graphics

`SETUP` configures TED. `DECODER` expands a room selected through `ROMNUM` into `SCRBUF`, including a mirroring stage. `DUMPER` transfers the decoded buffer to the visible screen with a fade effect; it is not a screen-memory dump utility.

`SCREEN-INIT`, `BORDER`, and `TITLE-WORKS` handle the interface, borders, and title effects. `ANIMATE-CHARS` and `VARIETY` do the character animation and alien graphics. `RADAR-SCANNER` draws the room overview, and `MESSAGE-STUFF` scrolls the text, with the message data coming from `WHOOPPEE-MESSAGE`.

Some graphics change by rewriting character memory, and a new renderer has to allow for that. If it treats every glyph as a fixed texture, it will miss part of the original animation system.

### Rooms, Jigsaw, and Bombs

`INIT-ROOMS` prepares the logical room tables. `SCATTER` distributes jigsaw pieces, `JIGSAW-CODE` handles their game logic, and `EDIT-JIGSAW` provides the original jigsaw-editing functionality.

`BOMB-CODE` handles bomb state, timing, and effects. `FILLER-BOMB` does the expanding fill, `CHKBMB` validates positions, and `CLEXP` clears the explosion characters. A change to the bomb rules therefore touches both the logical state and the screen-character tests.

The room count is baked into several places, including 25-entry tables and initialization loops. Adding rooms is a structural change, and appending more compressed screen data isn't enough.

### Enemies, Progression, and Scores

`ALIENS-MEGA/CODE` moves enemies; `ALIEN-CHEK/PRINT` handles checking and printing them. `KILLER-CODE` manages enemy-kill logic. `DEATH-CODE` and `GAME-OVER` handle failure and end-of-game flow.

`LEVEL-INCREASE` supplies level-dependent values such as enemy movement tempo and kill requirements. `SCORE-ROUTINES`, `HIGH-PRINT`, `HALL-OF-FAME`, and `WORK-HIGH` cover scoring, table data, display, and high-score entry.

When tuning difficulty, follow the values into their counters and comparisons. A lower delay or tempo value can mean more activity, so changing a table without knowing how it's read can give the opposite of what you intended.

### Separate Tools and Inactive Code

`DESIGNER`, `DES-IRQ`, and `DES-ANI` belong to the separate screen-design tool and aren't in the main game's active include chain. `HEXER` is commented out in the main source. These programs need their own build and testing before anyone treats them as working modern editing tools.

The disk's `EDITOR` program is the Commodore source editor, not the game's level editor. `OBJ` and `O.DES` are hexadecimal object records, not assembly source. PRG files can hold tools, BASIC, or data, and [Source Inventory](docs/SOURCE_INVENTORY.md) catalogues their roles separately.

---

## Rooms, Layouts, and Display Construction

`INIT-ROOMS` fills `ROMNUM` and `JIGNUM` with permutations. `SCREEN` is the current logical room, and `ROMNUM[SCREEN]` picks its stored layout. `GOTBIT` tracks cleared rooms, and `DOORDT[SCREEN]` gives the door mask for that grid position. Each of these tables has 25 entries, but they do different jobs.

```mermaid
flowchart LR
    Logical["SCREEN<br/>logical room 0–24"] --> Mapping["ROMNUM<br/>layout assignment"]
    Mapping --> Data["MUFF at $1000<br/>96 bytes per layout"]
    Data --> Decode["DECODER<br/>24 rows × 16 cells<br/>mirror to 32 columns"]
    Cleared["CLEARD<br/>cleared-room state"] --> Decode
    Decode --> Buffer["SCRBUF at $0400<br/>40-byte row stride"]
    Doors["DOORDT indexed by SCREEN<br/>door overlays"] --> Buffer
    Buffer --> Display["DUMPER / FADEIN<br/>visible screen and attributes"]
    Display --> Actors["Player, enemies, jigsaw<br/>and bomb effects"]
```

Each packed byte supplies four two-bit indices. `DECODER` adds 196 to produce character codes 196–199, writes the left half, and mirrors it. The 32-cell room occupies rows with a 40-byte stride in the 960-byte buffer. Cleared rooms are rebuilt before mirroring; doors are inserted afterwards.

### Stored Room Atlas

![All 25 stored room layouts, labelled with layout IDs and source addresses](docs/analysis/room-layouts.svg)

*These are layout templates, not a fixed map of the 5 × 5 room grid. Colours distinguish raw indices 0–3, corresponding to character codes 196–199. Runtime doors, cleared-room edits, actors, and the game's actual glyph shapes and colours are omitted.*

The [asset data](docs/analysis/asset-data.json) keeps each layout's 96 source bytes and its decoded 32 × 24 index grid, along with the door table. A room editor or port can start from that without touching the original image.

The room count feeds into initialization, navigation, the radar, jigsaw assignment, and saved room state. Expanding the grid means tracing every one of those as well as adding layout data.

---

## Game Graphics

[Illustrated Graphics](docs/GRAPHICS.md) decodes the game's character graphics from the original bytes: Dork, the eight alien designs, bombs, scenery, jigsaw pieces and radar, how bitmap bytes become screen cells, how the whole screen is composed, and both character-set atlases.

---

## Routine Contracts and Assembly Assumptions

These are good places to start when reading the listing. The addresses are for the current authentic build and can change in a modified edition.

| Entry    | Address | Contract or caution                   |
| -------- | ------- | ------------------------------------- |
| `REDJOS` | `$19D3` | Updates input flags via selected mode |
| `SERV`   | `$1A3C` | IRQ entry; exits through `IRQEND`     |
| `DELAY`  | `$1AD9` | Some callers enter at `DELAY+2`       |
| `CLVARS` | `$1AE7` | Clears `$0007–$00FF`                  |
| `XY`     | `$1B0E` | X/Y cells → `SL` and `CL` pointers    |
| `DECODE` | `$1C12` | Room state → `SCRBUF`; patches code   |
| `CHECK`  | `$1FA2` | Candidate cells → collision state     |
| `FADEIN` | `$2192` | Buffer → display with effects         |
| `FILLEX` | `$2A97` | Expanding bomb-fill work              |
| `CHKBMB` | `$2AC5` | Bomb-position validation              |
| `CLEXP`  | `$2AFA` | Clears explosion characters           |

`XY` takes the column in X and the row in Y and computes the character-screen pointer `SL` and the attribute pointer `CL`. Callers use that screen representation for drawing and collision. `YVAL2` holds six offsets, but `CHECK`'s loop uses only four: 0, 1, 40, and 41. A table's length doesn't tell you how much of it each caller uses.

`DECODER` patches the operands at `SELFMD`, `LMIRR`, and `RMIRR`. `JOYSTIK` switches `XTRCDE` between `LSR A` and `NOP` to normalize fire input for the selected port. A direct translation to a platform with read-only code should replace those tricks with explicit pointers and branches.

Register constants have to stay equates, and instructions after labels have to survive conversion. Both caused defects in the earlier reconstruction. Be careful too with calls into the middle of routines, fixed character numbers, zero-page pointer pairs, and state owned by the interrupt when you refactor.

---

## Generated Analysis Statistics

| Measure                   | Value |
| ------------------------- | ----- |
| Active modules            | 46    |
| Logical source lines      | 7,598 |
| Instruction-like lines    | 2,949 |
| Symbol definitions        | 627   |
| Direct transfer sites     | 536   |
| Allocated zero-page bytes | 193   |
| Assembled program bytes   | 7,840 |

`scripts/analyze_codebase.py` produces these counts. Logical lines include comments and blanks in the normalized source modules. Instruction-like lines leave out macro expansion. Symbols include constants, storage, tables, and branch targets. Direct transfers count source `JSR`, `JMP`, and conditional branches, and skip fall-through, vector dispatch, and runtime patches. Program bytes include embedded data, so none of these figures is a function count or a performance profile.

---

## Modification and Porting

The [Modification and Porting Guide](docs/PORTING_GUIDE.md) covers how to change the C16 game without losing the authentic baseline, where to start for common changes, the assembly assumptions to keep, and how to plan a version for another platform.

---

## Suggested Learning Sequence

1. Build the baseline and inspect `comparison.json`, the manifest, and the linker map.
2. Follow `ROOMS OF PERIL` into `GLOPPY`, the title fire test, `PLAY`, and `LOOP`.
3. Trace one frame's interrupt work and its interaction with the foreground loop.
4. Follow a room from `ROMNUM` through `DECODER`, `SCRBUF`, and `DUMPER` to the display.
5. Trace a control action through input flags, movement, collision, and a room transition.
6. Examine one enemy update and one bomb expansion, including their screen-data dependencies.
7. Create the separate development target, make a focused change, and document its verification before expanding the scope.

The point is to turn a reproducible historical program into something you understand well enough to build on, while the authentic version stays available as a dependable reference.

---

## Open Questions and Regenerating the Reference

Three questions are still open: where the final character bank came from, whether the reference binary is a release build, and exactly what the separate design tools did. Manual testing of movement, bombs, room transitions, progression, sound, and high-score entry also hasn't been done, and the automated startup checks don't cover it. [Testing](TESTING.md) sets out that scope.

Once you have a verified baseline build, regenerate the references and SVG atlases with:

```sh
./build.sh
python3 scripts/analyze_codebase.py
```

The analyzer reads the preserved inputs, manifest, program, labels, and listing. Before it generates anything, it checks the input hashes, exact equality with the reference, and allocation coverage. It never changes game bytes or starts VICE. The [analysis artifact guide](docs/analysis/README.md) covers the output formats and their limits.
