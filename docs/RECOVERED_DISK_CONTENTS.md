# Recovered Disk and Folder Contents

## Scope of This Inventory

This is an initial catalogue of `Dorks-Dilemma-C16-2026-FullDiskCopy/`, supplied by Anthony Clarke as recovered development-disk material. It records what is present and the file roles supported by inspection so far. Detailed research into the programs, their operation, and their reuse across other game disks is planned for a later documentation revision.

The folder currently contains 75 files: three `.d64` disk images, 53 `.seq` files, and 19 `.prg` files. This is a count of the host folder, not a directory listing of one physical disk. The provenance of the loose files relative to each image still needs to be established.

Anthony recalls that many programs also occur on his other source disks and suspects that they were development aids. That recollection will guide later comparisons; repeated filenames alone will not establish identical contents or purposes.

See [Development History](DEVELOPMENT_HISTORY.md) for the original C64–1541–C16 setup and the change from the development name Rooms of Peril to the published title Dork's Dilemma.

---

## Disk Images

| File                    | Initial observation                  |
|-------------------------|--------------------------------------|
| `Dorks-Dilemma-C16.d64` | Contains C16 source and tools        |
| `Dorks-Dilemma.d64`     | Byte-identical to the image above    |
| `TycoonText-C16.d64`    | Supplied name; contents to catalogue |

The two Dork's image files have the same SHA-256 digest:

```text
26286ec4076f75c8151f3a99fe1c0b5e0bb7381a7ee64863716b56328477212c
```

Identical bytes do not establish whether the files came from separate capture attempts or from copying one image. The supplied filenames, including the spelling `TycoonText-C16.d64`, are retained here as found.

### C16 Restoration Baseline

The main source inside `Dorks-Dilemma-C16.d64` uses TED register definitions and an entry address of `$1960`. Its `FILLER-BOMB` source continues beyond the truncation in the earlier text conversion and contains the missing routines.

The C16 disk image is the starting point for recovering this game's source. Loose files still need to be checked against its directory entries and file contents before they are used in the restoration. Their presence in the folder alone does not establish that they belong to the same source revision.

---

## Sequential Files

### Main Assembly File and Module Relationships

`ROOMS OF PERIL` is the main game source file. Its `.LIB` directives specify other files to read during assembly, such as `MAIN-VARS*`, `MACROS*`, `VARS*`, `PLAY-*`, and `MOVE*`. The wildcard names select matching disk filenames. The assembler processes the modules in the encountered order and resolves their labels.

This is the relationship Anthony recalled between a main file and the rest of the source. The exact include order needs to be recorded for the recovered C16 source revision. `DESIGNER` is another apparent assembly entry point, for the screen-design tool.

### Source File Inventory

The following 51 loose `.seq` files contain source or source data. Names and source comments provide initial clues to their roles; individual functions and dependencies will be researched later.

```text
alien-chek-print.seq
aliens-mega-code.seq
alterables.seq
animate-chars.seq
bomb-code.seq
border.seq
brick-chars.seq
change-room.seq
check-man.seq
command.seq
death-code.seq
decoder.seq
des-ani.seq
des-irq.seq
designer.seq
dumper.seq
edit-jigsaw.seq
extra-memory.seq
filler-bomb.seq
game-over.seq
hall-of-fame.seq
hexer.seq
high-print.seq
init-rooms.seq
inkey.seq
irq.seq
jigsaw-code.seq
joystik.seq
killer-code.seq
level-increase.seq
macros.seq
magnificent.seq
main-vars.seq
message-stuff.seq
move-pixel.seq
play-game.seq
radar-scanner.seq
raster-routines.seq
rooms of peril.seq
scatter.seq
score-routines.seq
screen-init.seq
setup.seq
sword!.seq
tables.seq
title-works.seq
utils.seq
variety.seq
vars.seq
whooppee-message.seq
work-high.seq
```

### Object Records

`obj.seq` and `o.des.seq` contain hexadecimal object records rather than assembly source statements. These are consistent with assembler output intended for a loader. `o.des.seq` appears associated with the designer; the precise correspondence of each object file to a source revision remains unverified.

The `.seq` suffix therefore identifies a sequential file, not necessarily an unassembled source module.

---

## PRG Files and Possible Development Aids

A Commodore PRG commonly begins with a two-byte load address. Its contents may be BASIC, machine code, graphics, or other data. The suffix alone does not tell us whether a file is a runnable program or establish its target machine.

### Programs Identified from Their Contents

| File                   | Role supported by initial inspection    |
|------------------------|-----------------------------------------|
| `asm.c64.prg`          | Commodore resident assembler            |
| `editor.prg`           | Commodore source editor                 |
| `dos5.2.prg`           | Disk-command support utility            |
| `hiload.prg`           | Hexadecimal object-record loader        |
| `boot all.prg`         | Starts the editing environment          |
| `c16.prg`              | Prepares C16 monitor loading commands   |
| `double-generator.prg` | Generates doubled-height character data |

The assembler banner reads `CBM RESIDENT ASSEMBLER V080282`, the editor identifies itself as `COMMODORE 64 EDITOR V072982`, and the loader as `HILOAD.C64 V072882`. The disk utility identifies itself as `DOS V5.2 (C)BUGGA-SOFT 1984`.

The `boot all.prg` program loads `DOS5.2` and `EDITOR`, then calls the support code and editor. The C16 boot program builds a monitor command sequence referring to a loader, object records, graphics, and data. These are clues to the original development process; none of these programs was run for this catalogue.

### Other PRG Files

The remaining twelve files are listed below. Observations are deliberately provisional where the role has not been established.

| File            | Initial observation                        |
|-----------------|--------------------------------------------|
| `8zoom.prg`     | Purpose to research                        |
| `aliens1.prg`   | Possible graphics data; role to research   |
| `aliens2.prg`   | Possible graphics data; role to research   |
| `aliens3.prg`   | Possible graphics data; role to research   |
| `arrow1.prg`    | Text-like contents; format to research     |
| `arrow2.prg`    | Text-like contents; format to research     |
| `beeb-set.prg`  | Possible character data; role to research  |
| `camel.prg`     | Possible character data; role to research  |
| `camel2.prg`    | Possible character data; role to research  |
| `chars.prg`     | Character data with a `$3800` load address |
| `comp-data.prg` | Purpose to research                        |
| `muff.prg`      | Likely room data; loads at `$1000`         |

Names such as `8zoom` or `camel` should not be expanded into definitive tool descriptions without evidence from their contents, callers, or contemporary documentation.

---

## Related Folders in the Modern Project

`Original_Files/` holds the earlier converted text files, BASIC listings, binary assets, and `INDEX`. `Recovered_Source/` holds another set of named source copies. Their contents and completeness need comparison with the current images.

`src/` contains the modern consolidated and converted assembly, including reconstructed routines. `scripts/`, `platformio.ini`, `Makefile`, and `build.sh` belong to the modern build and conversion work. They are separate evidence from the original disk tools.

`disassembly/` contains analysis of the surviving binary, while `archive/` and the earlier status documents record intermediate restoration work. Existing build-success claims do not establish that the recovered files or reconstructed output match a particular historical revision.

---

## Research Planned for a Later Revision

The next version of this catalogue will map loose files to image directory entries and compare repeated programs across the other development disks. Each researched file should record its original disk name, type, size, load address where applicable, platform, purpose, dependencies, and supporting evidence.

For development aids, the aim is to explain how each tool fitted into editing, assembly, loading, graphics preparation, or testing. For game data and source, the aim is to establish which files belong together. Unknowns will remain explicit until the evidence resolves them.
