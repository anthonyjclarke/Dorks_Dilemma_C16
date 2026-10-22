# Gremlin Archive and the Book

## About This Chapter

The first five sections are written to be reused unchanged in each of my Micro Projects C16 reconstructions (Xargon Wars, Xargon's Revenge, Dork's Dilemma, Tycoon Tex). Only [In This Project](#in-this-project) is specific to Dork's Dilemma. I checked the links and the archive contents on 22 October 2026.

---

## A Gremlin in the Works

*A Gremlin in the Works* by Mark Hardisty, published by [Bitmap Books](http://www.bitmapbooks.co.uk/products/a-gremlin-in-the-works), is the officially endorsed history of Gremlin Graphics, endorsed by founder Ian Stewart. The 572-page book follows the company from Monty Mole and Thing on a Spring to its purchase by Infogrames in 1999, with interviews, letters, photographs and design documents. Mark announced it on the archive in the post [A Gremlin in the Works – The Book](https://www.gremlinarchive.com/index.php/2016/05/22/a-gremlin-in-the-works-the-book/) (22 May 2016).

I contributed to the book and to the archive. Mark's post [A Gremlin in the Works – Anthony Clarke](https://www.gremlinarchive.com/index.php/2017/07/31/a-gremlin-in-the-works-anthony-clarke/) (31 July 2017) introduces my part. In 1985 I joined Gremlin with Jason Perkins and Mark Rogers as Micro Projects Limited. Micro Projects wrote many of Gremlin's C16 games, as well as Thing on a Spring on the C64 and its port of Monty on the Run. The book tells the Micro Projects story in full.

---

## The Gremlin Graphics Archive

[The Gremlin Graphics Archive](https://www.gremlinarchive.com/) is Mark Hardisty's companion site to the book. It collects Gremlin's games, box art, adverts, letters, royalty statements, staff photographs and source code. Posts relevant to Micro Projects include:

| Post                                             | Date         |
| :----------------------------------------------- | :----------- |
| [Micro Projects Source Code][ga-src]             | 25 May 2016  |
| [Micro Projects Royalty Statements][ga-roy]      | 24 May 2016  |
| [Compliment Slip / Royalty Notes][ga-slip]       | 24 May 2016  |
| [Early Tradeshow Leaflet][ga-trade]              | 23 May 2016  |
| [Anthony Clarke Photograph][ga-photo]            | 2 June 2016  |
| [A Gremlin in the Works – Anthony Clarke][ga-me] | 31 July 2017 |

Each game also has its own post: for example [Xargon's Revenge (C16/Plus4)][ga-xr] (1 November 2016) and [Xargon Wars – Trade Promotion][ga-xw] (24 May 2016). The compilations have theirs too: [C16 Classics][ga-classics] (13 February 2021) and [C16 Omnibus][ga-omnibus] (20 December 2021).

---

## My Development Disks in the Archive

The [Micro Projects Source Code][ga-src] post holds the Oric and C16 assembler source I donated for many of the company's games, including the unreleased Ultra. Its download, [Old-Development-Disks.zip][ga-zip] (1,894,396 bytes, 846 entries), is my 1992 PC export of the original Commodore disks, re-zipped in 2014. It has two folders, `Disk 1-6/` and `Disk 7-11/`. Each disk is there both as my 1992 PKZIP file (for example `DISK9.ZIP`) and as an extracted folder, with a `READ.ME` from 1992 that names them:

| Disk     | Contents (from `READ.ME`)      |
| :------- | :----------------------------- |
| `DISK1A` | Tycoon Tex C64                 |
| `DISK1B` | Dorks Dilemma C64              |
| `DISK2`  | Utilities                      |
| `DISK3`  | Thingy                         |
| `DISK4A` | Graphics Editor                |
| `DISK4B` | Graphic2                       |
| `DISK5`  | Dorks Dilemma C16              |
| `DISK6`  | Tycoon Tex C16                 |
| `DISK7A` | Xargon Wars C16                |
| `DISK7B` | Xargon Wars C16 (Hack Version) |
| `DISK8`  | Revenge of Xargon (Xargon II)  |
| `DISK9`  | Xargon's Revenge               |
| `DISK10` | Xargon's Revenge – 5 lives     |
| `DISK11` | `LOAD "*",8,1`                 |

Each disk ZIP includes an `INDEX` listing the original Commodore directory next to the PC file names. One thing to watch: in the extracted `Disk 7-11/DISK9/` folder, `LOADER.BIN` is 0 bytes, while `DISK9.ZIP` itself holds the full file. Compare against the disk ZIPs, not the extracted folders.

---

## Plus/4 World and the Archive

[Plus/4 World](https://plus4world.powweb.com/) has entries for these games. Its [Xargon's Revenge entry](https://plus4world.powweb.com/software/Xargons_Revenge) says the early-stages and disk versions were rebuilt from source files on disks I gave to Mark Hardisty, which are the 1992 export above. Check each game's entry for similar notes. Copies labelled "early stages", "disk version" or "with loading screen" are then not independent releases. They come from my own development disks, and only the original cassettes show what was actually sold.

---

## How to Cite

> Mark Hardisty, *A Gremlin in the Works*, Bitmap Books. Officially endorsed history of Gremlin Graphics.

> Mark Hardisty, "Micro Projects Source Code", The Gremlin Graphics Archive, 25 May 2016, <https://www.gremlinarchive.com/index.php/2016/05/25/micro-projects-source-code/>. Download: `Old-Development-Disks.zip`.

> Mark Hardisty, "A Gremlin in the Works – Anthony Clarke", The Gremlin Graphics Archive, 31 July 2017, <https://www.gremlinarchive.com/index.php/2017/07/31/a-gremlin-in-the-works-anthony-clarke/>.

---


## In This Project

The archive's `READ.ME` names two disks for this game: `DISK5`, "Dorks Dilemma C16", and `DISK1B`, "Dorks Dilemma C64". I compared every file in this project against the central directories of `Disk 1-6/DISK5.ZIP` (93,852 bytes, CRC-32 `1c0dd178`, 71 entries) and `Disk 1-6/DISK1B.ZIP` (86,238 bytes, CRC-32 `b9d46dff`, 74 entries), by CRC-32 and size. The entries in both are dated 7 October 1992, the same date as `Original Source Recovered/1992/INDEX`. In this section `1992/` and `2026/` are the two folders under `Original Source Recovered/`.

The 2026 captures are raw Commodore files, so a sequential file only matches after the conversion the 1992 export applied: each carriage return becomes CR LF and PETSCII letters swap case. The export turned tokenised BASIC programs into text listings, so those can't be compared by CRC.

| Project files                      | Archive disk | Result                             |
| :--------------------------------- | :----------- | :--------------------------------- |
| `1992/` (71 files)                 | `DISK5`      | All 71 identical                   |
| `Dorks-Dilemma-C16.d64` (66 files) | `DISK5`      | 60 identical, 6 differ (see below) |
| Loose `2026/` `.seq` and `.prg`    | `DISK1B`     | 66 identical, 6 BASIC listings     |

### DISK5 and the C16 Build

`Original Source Recovered/1992/` is the archive's `DISK5`. All 71 files, including `INDEX` and `DORKSDIL.BIN` (12,290 bytes, CRC-32 `03a9a7c9`), have the same CRC-32 and size as the entries in `DISK5.ZIP`, and the archive's extracted `Disk 1-6/DISK5/` folder agrees with the ZIP for every file. Since the restored build reproduces `Original Source Recovered/1992/DORKSDIL.BIN`, it reproduces the archive's copy too.

In `Dorks-Dilemma-C16.d64`, the build input, 60 of the 66 files match `DISK5`: 12 programs byte for byte, including `DORK'S DILEMMA`, and 48 sequential files after conversion. None of them matches only `DISK1B`. The six that don't match are these:

- **`FILLER-BOMB`** converts to 2,797 bytes. `DISK5/FILLERBO.TXT` is its first 1,287 bytes and then stops at `fild`. The archive's copy is cut off at the same point as mine, so the loss happened in or before the 1992 export, not in later copying.
- **`BOOT ALL`, `C16`, `DOUBLE-GENERATOR`, `HYPRA-LOAD OBJ` and `ASM.C64`** are BASIC programs, held in `DISK5` as listings.

`DISK5` also holds `ALIEN-CHEK/PRINT`, `ALIENS-MEGA/CODE`, `RASTER-ROUTINES` and `WHOOPPEE-MESSAGE`, which aren't in the disk image's live directory. These are the four modules the build takes from `Original Source Recovered/1992/`, so its fallback files are the archive's `DISK5` files.

### DISK1B and the Loose Files

The loose files beside the disk images in `Original Source Recovered/2026/` are the C64 development disk, `DISK1B`. All 53 `.seq` files match after conversion, and 13 of the 19 `.prg` files are byte-identical, including `8ZOOM`, `ALIENS1`–`ALIENS3`, `CAMEL2` and `HILOAD`, which exist only on `DISK1B`. The other six (`ARROW1`, `ARROW2`, `ASM.C64`, `BOOT ALL`, `C16` and `DOUBLE-GENERATOR`) are BASIC programs. Of the 66 matches, 22 are files `DISK1B` shares unchanged with `DISK5`.

### Archive Posts for This Game

The archive has a short post for the C16 game, [Dorks Dilemma][ga-dd] (25 May 2016), filed under box art and inlays. [Dork's Dilemma (C64 Port)][ga-dd64] (13 June 2016) describes how Hokuto Force assembled the C64 source files from my donation into a playable preview, essentially the C16 game without hardware sprites or sound. Those files are presumably `DISK1B`, but I haven't checked the preview download against it. The game also appears in [C16 Classics][ga-classics] and in Mark's post about me, [A Gremlin in the Works – Anthony Clarke][ga-me].

[ga-src]: https://www.gremlinarchive.com/index.php/2016/05/25/micro-projects-source-code/
[ga-zip]: http://agremlinintheworks.co.uk/archive/wp-content/uploads/2016/05/Old-Development-Disks.zip
[ga-roy]: https://www.gremlinarchive.com/index.php/2016/05/24/micro-projects-royalty-statements/
[ga-slip]: https://www.gremlinarchive.com/index.php/2016/05/24/compliment-slip-royalty-notes/
[ga-trade]: https://www.gremlinarchive.com/index.php/2016/05/23/early-tradeshow-leaflet/
[ga-photo]: https://www.gremlinarchive.com/index.php/2016/06/02/anthony-clarke-photograph/
[ga-me]: https://www.gremlinarchive.com/index.php/2017/07/31/a-gremlin-in-the-works-anthony-clarke/
[ga-xr]: https://www.gremlinarchive.com/index.php/2016/11/01/xargons-revenge-c16plus4/
[ga-xw]: https://www.gremlinarchive.com/index.php/2016/05/24/xargon-wars-trade-promotion/
[ga-classics]: https://www.gremlinarchive.com/index.php/2021/02/13/c16-classics/
[ga-omnibus]: https://www.gremlinarchive.com/index.php/2021/12/20/c16-omnibus/
[ga-dd]: https://www.gremlinarchive.com/index.php/2016/05/25/dorks-dilemma/
[ga-dd64]: https://www.gremlinarchive.com/index.php/2016/06/13/dorks-dilemma-c64-port/
