# Testing the Restoration

## Build and Regression Tests

```sh
./build.sh
make test
```

The seven tests cover complete PRG equality, independently assembled executable bytes, the four explicit archive fallbacks, the recovered bomb routines, preservation of labelled instructions and register equates, failure on a missing include, and rejection of a cyclic disk-sector chain.

The expected complete PRG SHA-256 is:

```text
3c6f6426b93862de9bd836842f1ffc0bc46f19056e2fc0706ca0da8037a7ce05
```

---

## PlatformIO

```sh
pio run -e c16 -e c16_debug
```

Both outputs must match the direct build. The build script fails if the PRG differs from the reference, and it writes the details to the environment's `comparison.json`.

---

## Repeatable VICE Check

```sh
python3 scripts/verify_vice.py
```

This needs VICE with its C16 ROMs and PNG screenshot support. It boots a PAL C16 with 16 KB RAM, loads the rebuilt PRG, and stops at the original title-screen fire test. It then sets the `JFIRE` input flag, resumes the original instructions, and checks that the game reaches the main loop with the title flag cleared and three lives.

The check writes `build/vice-verification.json`, the monitor and console logs, and `build/restored-title.png` and `build/restored-gameplay.png`. It has a 45-second timeout and a cycle limit, so a regression can't leave an unattended test running forever.

---

## Manual Checks Still Needed

Launch the game:

```sh
scripts/run_vice.sh build/dorks.prg
```

Check the host-key mapping for the original controls: `Z` and `X` for left/right, `;` and `/` for up/down, and Space for fire/start. `F1` selects keyboard or joystick, and `F2` selects sound. These mappings come from the original source.

Manual keyboard and joystick input, sound, movement between rooms, bombs, death and restart, and a complete play-through are all still unverified in this session, and so is testing on real hardware. The repeatable emulator check feeds in an input flag directly, so it says nothing about these behaviours.
