# Recovered Disk and Folder Contents

## Scope of This Inventory

This is a first catalogue of `Dorks-Dilemma-C16-2026-FullDiskCopy/`, which I supplied as recovered development-disk material. It lists what is there and the file roles that inspection supports so far. Closer research into the programs, how they work, and whether they turn up on other game disks is planned for a later revision.

The folder holds 75 files: three `.d64` disk images, 53 `.seq` files, and 19 `.prg` files. That is a count of the host folder, not a directory listing of one physical disk. The loose files match the C64 development disk, `DISK1B` in my 1992 export, by CRC-32 and size, apart from six BASIC programs that the export holds as listings. [Gremlin Archive and the Book](GREMLIN_ARCHIVE.md#in-this-project) has the comparison.

I recall that many of these programs also appear on my other source disks, and I suspect they were development aids. That will guide later comparisons, but a repeated filename alone doesn't show that two files have the same contents or purpose.

[Development History](DEVELOPMENT_HISTORY.md) describes the original C64–1541–C16 setup and the change from the development name Rooms of Peril to the published title Dork's Dilemma.

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

Identical bytes can't tell us whether the two files came from separate capture attempts or from copying one image. The supplied filenames, including the spelling `TycoonText-C16.d64`, are kept as found.

### C16 Restoration Baseline

The main source inside `Dorks-Dilemma-C16.d64` uses TED register definitions and an entry address of `$1960`. Its `FILLER-BOMB` source carries on past the point where the earlier text conversion was cut off, and it contains the missing routines.

The current build reads the C16 disk image directly. Where an active include has no matching live directory entry, it uses one of four explicit source modules from the earlier archive. Loose files beside the image are not build inputs. [Restoration Status](RESTORATION_STATUS.md) lists the exact dependencies and the verified result.

---

## Sequential Files

### Main Assembly File and Module Relationships

`ROOMS OF PERIL` is the main game source file. Its `.LIB` directives name other files to read during assembly, such as `MAIN-VARS*`, `MACROS*`, `VARS*`, `PLAY-*`, and `MOVE*`. The wildcard names match disk filenames. The assembler works through the modules in the order it meets them and resolves their labels.

This is the relationship I remember between a main file and the rest of the source. The exact include order for the recovered C16 revision still needs writing down. `DESIGNER` looks like another assembly entry point, for the screen-design tool.

### Source File Inventory

These 51 loose `.seq` files hold source or source data. The names and source comments give first clues to what each one does. Individual functions and dependencies will be researched later.

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

`obj.seq` and `o.des.seq` hold hexadecimal object records, not assembly source. They look like assembler output meant for a loader. `o.des.seq` seems to go with the designer, but I haven't checked which source revision each object file matches.

So a `.seq` suffix only means a sequential file. It isn't necessarily an unassembled source module.

---

## PRG Files and Possible Development Aids

A Commodore PRG usually begins with a two-byte load address, and what follows may be BASIC, machine code, graphics, or other data. The suffix alone doesn't say whether a file is a runnable program or which machine it targets.

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

The assembler banner reads `CBM RESIDENT ASSEMBLER V080282`, the editor calls itself `COMMODORE 64 EDITOR V072982`, and the loader calls itself `HILOAD.C64 V072882`. The disk utility's banner is `DOS V5.2 (C)BUGGA-SOFT 1984`.

`boot all.prg` loads `DOS5.2` and `EDITOR`, then calls the support code and the editor. The C16 boot program builds a sequence of monitor commands that mention a loader, object records, graphics, and data. These are clues to how development worked. None of the programs was run for this catalogue.

### Other PRG Files

The remaining twelve files are listed below. Where a file's role isn't established, the notes are provisional on purpose.

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

Names such as `8zoom` or `camel` shouldn't be turned into firm tool descriptions without evidence from the files' contents, their callers, or documentation from the time.

---

## Related Folders in the Modern Project

`Original_Files/` holds the earlier converted text files, BASIC listings, binary assets, and `INDEX`. `Recovered_Source/` holds another set of named source copies. Both still need comparing with the current images for contents and completeness.

`src/` keeps earlier consolidated and converted assembly, including reconstructed routines, and none of it is an input to the current build. `scripts/restore_c16.py`, `scripts/d64_image.py`, and `config/c16.cfg` make up the current restoration pipeline, which `platformio.ini`, `Makefile`, and `build.sh` all share.

`disassembly/` holds analysis of the surviving binary, and `archive/` and the earlier status documents record intermediate restoration work. Their build-success claims don't show that the recovered files or the reconstructed output match any particular historical revision.

---

## Research Planned for a Later Revision

The next version of this catalogue will match loose files to image directory entries and compare repeated programs across the other development disks. For each file it should give the original disk name, type, size, load address where there is one, platform, purpose, dependencies, and the evidence behind them.

For development aids, the aim is to explain where each tool fitted: editing, assembly, loading, graphics preparation, or testing. For game data and source, the aim is to work out which files belong together. Unknowns stay marked as unknown until the evidence settles them.
