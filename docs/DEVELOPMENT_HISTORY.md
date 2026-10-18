# Development History

## From Rooms of Peril to Dork's Dilemma

Anthony Clarke wrote the game under the development name **Rooms of Peril**. When Gremlin Graphics in Sheffield published and launched it, the game was rebranded as **Dork's Dilemma**. This naming history was supplied by Anthony for this project in October 2026.

The surviving main source retains the name `ROOMS OF PERIL`, credits Micro-Projects Ltd. and Gremlin Graphics Ltd., and records a start date of 5 March 1985. The development name explains why source files and disk listings use a different title from the published game. The names alone do not identify the revision or intended machine of a particular file.

The purpose of this project is to preserve an authentic version of the game from the original development material and document a process Anthony can reuse for other games whose source disks survive. A successful assembly is one milestone; the rebuilt game's equivalence to the surviving reference still needs verification.

---

## The Original Development Setup

Anthony recalls that the development machine was a Commodore 64 with a Commodore 1541 disk drive. Source code was edited and assembled on the C64. The 1541 was daisy-chained to the C16, allowing the assembled output to be loaded from the shared drive and tested on the C16.

This recollection establishes the development host, shared storage, and target machine. The exact editor commands, assembler options, loader sequence, and revisions used during development remain to be validated from the surviving files.

### Approach Used – To Be Validated

The recovered material suggests the following working sequence. This is an interpretation of the files, rather than a tested reconstruction of a complete development session.

1. Start the C64 editing environment using `BOOT ALL`, the source editor, and disk-command support.
2. Edit sequential source files. Assemble the main `ROOMS OF PERIL` file, whose `.LIB` directives bring in the other modules in order.
3. Write hexadecimal object records to an `OBJ` sequential file.
4. Access the output from the C16 through the shared 1541, using a loader to place the object records in memory and loading supporting graphics and data.
5. Enter the game through the C16 monitor, test it, and return to the C64 to make changes.

The recovered assembler identifies itself as `CBM RESIDENT ASSEMBLER V080282`; the editor as `COMMODORE 64 EDITOR V072982`. A recovered loader identifies itself as `HILOAD.C64 V072882`. These identities fit the editor, assembler, and object-loader arrangement described in the [Commodore 64 Macro Assembler Development System manual](https://raw.githubusercontent.com/dmarlowe69/cbm_mads/master/CBM%20Documentation/assembler.txt), preserved as a Project64 transcription by David Holz. The precise role of each recovered program will be researched in a later documentation revision.

The C16 boot program contains monitor commands referring to `MEGA*`, `OBJ`, `MUFF`, and `CHARS`, followed by entry at `$1960`. Those commands are evidence for a loading approach; they do not establish that every similarly named file in the recovered collection belongs to the same working configuration.

---

## Earlier Conversion and the Current Recovery

Anthony recalls sending the original disks to someone for conversion to modern files, probably in 1992. He does not know how the conversion was performed and had no way to test the results at the time. The earlier `Original_Files/INDEX` contains 7 October 1992 timestamps, which are consistent with that recollection but do not independently establish the conversion method or date.

Anthony later suspected that some source had not transferred completely. The earlier `Original_Files/FILLERBO.TXT` ends abruptly at `fild`. The supplied C16 disk image contains the continuation and missing bomb routines. This supports incomplete recovery in the earlier files, while leaving the stage at which the loss occurred uncertain.

The current capture was performed on Anthony's Windows 10 workbench computer, using a 1541 drive, ZoomFloppy, OpenCBM, and CBM-Transfer. Windows was his practical choice for the available workbench setup and perceived community support. Exact drive and software versions have been deferred. OpenCBM also documents macOS support; a macOS capture procedure has not been verified for this project.

The files supplied for this recovery are held in `Dorks-Dilemma-C16-2026-FullDiskCopy/`. The [recovered disk and folder contents](RECOVERED_DISK_CONTENTS.md) document records the current inventory and identifies the C16 disk image as the starting point for the restoration.

### Recovery Tool Acknowledgements

[ZoomFloppy](https://github.com/go4retro/ZoomFloppy) bridges modern USB computers and Commodore disk drives. Its project description credits designer Nate Lawson; the [OpenCBM credits](https://opencbm.trikaliotis.net/opencbm-35.html) credit Jim Brain and Nate Lawson for XUM1541/ZoomFloppy.

[OpenCBM](https://github.com/OpenCBM/OpenCBM) provides device access and transfer utilities. Its [users guide](https://opencbm.trikaliotis.net/) credits Michael Klein, Spiro Trikaliotis, Wolfgang Moser, and Arnd Menge. The project and its contributors make the modern transfer process possible.

[CBM-Transfer](https://github.com/sjgray/cbm-transfer), by Steve J. Gray, provides a graphical interface to OpenCBM and other disk and file tools. These tools are acknowledged separately from the original game-development software.

---

## Modern Restoration Record

The locally available Git history records an initial upload on 20 January 2026, further work on 3 February, and a later commit on 26 April. At the time of this documentation update, the checkout is at `d2079d2`; the locally recorded `origin/dev` points to `d1007a5`. No branch update or build was performed for this documentation work.

The April record describes fixes to TED register definitions and a missing decoder instruction, followed by partial title-screen rendering and an unresolved transition into gameplay. Earlier status reports describe earlier stages and sometimes claim complete reconstruction; those claims should be read as historical reports rather than proof of an authentic, fully working rebuild.

The status of `Original_Files/DORKSDIL.BIN` as a release build or development build is unknown. It is a surviving reference binary, reported by earlier project work to run in VICE. Its exact relationship to each source revision remains to be established.

---

## Surviving Development Disks

![Surviving Micro-Projects development disks photographed by Anthony Clarke](images/micro-projects-development-disks.jpg)

Photograph supplied by Anthony Clarke, showing surviving Micro-Projects development disks. It provides historical context for the C16 restoration; a mapping between photographed disks and individual image files has not yet been established.
