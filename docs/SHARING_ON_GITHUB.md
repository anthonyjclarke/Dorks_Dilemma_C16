# Sharing on GitHub

## Repository

The public repository is [anthonyjclarke/Dorks_Dilemma_C16](https://github.com/anthonyjclarke/Dorks_Dilemma_C16). I work on `dev` and merge verified checkpoints into `main`. The tag `v1.0-restored` marks the first byte-identical restoration, and later checkpoints use `v1.x.y` tags.

`.gitignore` leaves out generated output, PlatformIO caches, Python caches and macOS metadata. It deliberately keeps the original `.prg`, `.BIN`, `.TXT`, `.seq` and `.d64` files and the artwork. `.gitattributes` turns off text normalization for both preserved input folders, including the CRLF 1992 text export.

The README links to the build instructions, validation, history and artifact catalogue. `RIGHTS.md` records the historical notices I've kept, and I haven't assigned a new licence.

---

## Final Local Checks

Run these commands from the project root:

```sh
./build.sh
make test
pio run -e c16 -e c16_debug
make verify
make docs-check
git status --short
```

The first three checks need Python, cc65 and PlatformIO. The VICE verification also needs a graphical desktop. [Source and Validation](SOURCE_AND_VALIDATION.md) and [Testing](../TESTING.md) have the current results and the limits of the verification.

The evidence in `docs/verification/` and the screenshots in `docs/images/` belong to the documented checkpoint. If you change the source, refresh them only after reviewing any changed bytes and rerunning the relevant checks.

---

## Clone or Update

Clone the published repository with:

```sh
git clone https://github.com/anthonyjclarke/Dorks_Dilemma_C16.git
cd Dorks_Dilemma_C16
```

To check out the first restored checkpoint:

```sh
git switch --detach v1.0-restored
```

For later work, use `dev`, review the changes, run the checks above, then commit. Merge into `main` only when a checkpoint is verified:

```sh
git switch dev
git add .
git diff --cached --stat
git commit -m "docs(scope): describe the change"
git push origin dev
```

On every push and pull request, the GitHub Actions workflow runs the source build, the regression tests, both PlatformIO environments, the handbook freshness check, the documentation tests and the output agreement checks. It uploads the rebuilt PRG and reports as a workflow artifact, and it doesn't run a graphical emulator. Results are on the repository's [Actions page](https://github.com/anthonyjclarke/Dorks_Dilemma_C16/actions).

---

## Version Tags

`v1.0-restored` is the first restored checkpoint, and `v1.1.0` is the first documentation release. Later verified checkpoints get new annotated version tags on `main`. Leave published tags alone, so their source, documentation and recorded evidence can still be reproduced.
