# History and Credits

## Dork's Dilemma

I wrote the game under the development name **Rooms of Peril**. Gremlin Graphics in Sheffield renamed it **Dork's Dilemma** when it published and launched the game. I gave the project this naming history in October 2026.

The surviving main source still calls itself `ROOMS OF PERIL`, credits Micro-Projects Ltd. and Gremlin Graphics Ltd., and gives a start date of 5 March 1985. That explains why source files and disk listings use a different title from the published game. The names alone don't say which revision or machine a particular file was meant for.

This project aims to preserve an authentic version of the game from the original development material, and to document a process I can reuse for other games whose source disks survive. The current build reproduces the surviving game binary byte for byte. [Source and Validation](SOURCE_AND_VALIDATION.md) lists the source and graphics dependencies and the emulator checks made so far.

The [Artifact Catalogue](ARTIFACTS.md) preserves a selection of my cover scans, cassette inlays, and review scrapbook pages, which show how the game was presented and received at the time.

---

## The Original Development Setup

I recall developing on a Commodore 64 with a Commodore 1541 disk drive. I edited and assembled the source on the C64. The 1541 was daisy-chained to the C16, so the assembled output could be loaded from the shared drive and tested on the C16.

That gives us the development host, the shared storage, and the target machine. The exact editor commands, assembler options, loader sequence, and revisions still need checking against the surviving files.

### Approach Used – To Be Validated

The recovered material suggests the sequence below. It is read from the files, not a tested reconstruction of a whole development session.

1. Start the C64 editing environment using `BOOT ALL`, the source editor, and disk-command support.
2. Edit sequential source files. Assemble the main `ROOMS OF PERIL` file, whose `.LIB` directives bring in the other modules in order.
3. Write hexadecimal object records to an `OBJ` sequential file.
4. Access the output from the C16 through the shared 1541, using a loader to place the object records in memory and to load supporting graphics and data.
5. Enter the game through the C16 monitor, test it, and go back to the C64 to make changes.

The recovered assembler calls itself `CBM RESIDENT ASSEMBLER V080282` and the editor `COMMODORE 64 EDITOR V072982`. A recovered loader calls itself `HILOAD.C64 V072882`. These fit the editor, assembler, and object-loader arrangement described in the [Commodore 64 Macro Assembler Development System manual](https://raw.githubusercontent.com/dmarlowe69/cbm_mads/master/CBM%20Documentation/assembler.txt), preserved as a Project64 transcription by David Holz. What each recovered program did exactly will be researched in a later revision.

The C16 boot program has monitor commands that mention `MEGA*`, `OBJ`, `MUFF`, and `CHARS`, followed by entry at `$1960`. They point to a loading approach, but they don't show that every similarly named file in the recovered collection belongs to the same working setup.

---

## Earlier Conversion and the 2026 Capture

I recall sending the original disks off for conversion to modern files, probably in 1992. I don't know how it was done, and I had no way to test the results at the time. The `Original Source Recovered/1992/INDEX` file carries 7 October 1992 timestamps, which fit my recollection but don't show how or when the conversion happened.

I later suspected that some source hadn't transferred completely. The 1992 `FILLERBO.TXT` stops abruptly at `fild`, and the 2026 C16 disk image has the continuation and the missing bomb routines. So the earlier files were incomplete, though it is unclear at what stage the loss happened.

The 2026 capture was done on my Windows 10 workbench computer, with a 1541 drive, ZoomFloppy, OpenCBM, and CBM-Transfer. I chose Windows because it suited the workbench setup I had and because I thought community support was better there. Exact drive and software versions are still to be recorded. OpenCBM also documents macOS support, but I haven't verified a macOS capture procedure for this project.

The files from that capture are in `Original Source Recovered/2026/`. The [Source Inventory](SOURCE_INVENTORY.md) lists them and names the C16 disk image as the starting point for the restoration.

Whether `Original Source Recovered/1992/DORKSDIL.BIN` is a release or a development build is unknown. It is the surviving reference binary, and it runs in VICE. Its exact relationship to each source revision hasn't been established.

---

## The Gremlin Archive and the Book

Mark Hardisty's book *A Gremlin in the Works* tells the Micro Projects story, and his Gremlin Graphics Archive hosts my 1992 export of the development disks. [Gremlin Archive and the Book](GREMLIN_ARCHIVE.md) covers both. It also records that `Original Source Recovered/1992/` is the archive's `DISK5`, and that the loose files in `Original Source Recovered/2026/` are its C64 disk, `DISK1B`.

---

## Recovery Background and Build Template

Dork's Dilemma is where this whole series of restorations started, and the approach changed completely partway through. I'm keeping a short record of both, because the second approach became the template for Tycoon Tex, Xargon Wars and Xargon's Revenge.

### How I Started: January to April 2026

The first attempt began on 20 January 2026 with only the 1992 text export. I consolidated its 44 modules into one large source file, reformatted it, and wrote a series of Python scripts to convert the old MOS assembler syntax for ca65. Assembly got to "99.96 %": two routines, `FILLEX` and `CHKBMB`, didn't exist anywhere in the 1992 files. I disassembled the surviving `DORKSDIL.BIN`, found the two routines in the binary and wrote reconstructed versions back into the source.

The result assembled cleanly but didn't work. The rebuilt program ran and showed a blank or partly drawn screen. Work in February and April fixed some of the causes, including a missing self-modifying instruction in the decoder and TED registers that had been turned into labels, and the title screen partly appeared. Gameplay still didn't start, and the project produced a long trail of status reports, each claiming more completeness than the build had.

### Why the Approach Changed: October 2026

Two things changed in October 2026. I captured my surviving development disks again, with ZoomFloppy and OpenCBM, and the 2026 C16 disk image turned out to hold the complete `FILLER-BOMB` source, so the "missing" bomb routines had never been lost on the disk. And I stopped repairing the hand-consolidated file and built a pipeline that starts from the preserved inputs instead:

1. Read the D64 image directly and never modify it.
2. Assemble the modules in the original `.LIB` order from the main source file, and fail on any missing or ambiguous include.
3. Take a module from the 1992 export only through an explicit, listed fallback.
4. Convert syntax without "fixing" anything, keeping instructions after labels, equates and self-modifying operands.
5. Compare every byte with a surviving reference, and stop the build on any difference.
6. Use one script for every entry point: the shell script, Make, PlatformIO and VS Code.

That pipeline reproduced `DORKSDIL.BIN` byte for byte on 20 October 2026 (tag `v1.0-restored`), and VICE reached gameplay. The lesson was that the earlier defects came from the consolidation step, not from the original source.

### What Became the Template

The same pipeline, with each game's own fallback map, memory layout and reference, rebuilt Tycoon Tex the same day, and Xargon Wars and Xargon's Revenge followed. The later games compare against the original `OBJ` object listing rather than a whole running binary, because their running copies are compressed or saved from a different revision. Dork's Dilemma is still the only one checked against a complete reference binary, and the only one that takes graphics bytes (the character set) from that reference.

The superseded material from the first approach (the consolidated and converted source, the disassembly, the conversion scripts and the old status reports) was removed from this repository on 23 October 2026. It is all still in the Git history up to commit `90f8739`, and I keep a documented copy with my local restoration notes.

---

## Tool Acknowledgements

[ZoomFloppy](https://github.com/go4retro/ZoomFloppy) connects modern USB computers to Commodore disk drives. Its project description credits designer Nate Lawson, and the [OpenCBM credits](https://opencbm.trikaliotis.net/opencbm-35.html) name Jim Brain and Nate Lawson for XUM1541/ZoomFloppy.

[OpenCBM](https://github.com/OpenCBM/OpenCBM) provides device access and transfer utilities. Its [users guide](https://opencbm.trikaliotis.net/) credits Michael Klein, Spiro Trikaliotis, Wolfgang Moser, and Arnd Menge. The transfer in this project depends on their work.

[CBM-Transfer](https://github.com/sjgray/cbm-transfer), by Steve J. Gray, gives OpenCBM and other disk and file tools a graphical interface. These tools are credited separately from the original game-development software.

The rebuild uses the [cc65](https://cc65.github.io/) assembler and linker, [VICE](https://vice-emu.sourceforge.io/) for emulation, and [PlatformIO](https://platformio.org/) as an optional build front end.

---

## Surviving Development Disks

![Surviving Micro-Projects development disks, photographed by me](../Original%20Artifacts/micro-projects-development-disks.jpg)

My photograph of the surviving Micro-Projects development disks. It gives historical context for the C16 restoration. I haven't yet matched the photographed disks to individual image files.
