# Testing

## Regression Tests

```sh
./build.sh
make test
```

The seven tests cover complete PRG equality, independently assembled executable bytes, the four explicit 1992 fallbacks, the recovered bomb routines, preservation of labelled instructions and register equates, failure on a missing include, and rejection of a cyclic disk-sector chain.

The expected complete PRG SHA-256 is:

```text
3c6f6426b93862de9bd836842f1ffc0bc46f19056e2fc0706ca0da8037a7ce05
```

---

## PlatformIO Agreement

```sh
pio run -e c16 -e c16_debug
```

Both outputs must match the direct build. The build script fails if the PRG differs from the reference, and it writes the details to the environment's `comparison.json`. The GitHub Actions workflow runs the same build, the regression tests and this agreement check on every push.

---

## VICE Verification

```sh
make verify
```

This needs VICE with its C16 ROMs and PNG screenshot support. It boots a PAL C16 with 16 KB RAM, loads the rebuilt PRG, and stops at the original title-screen fire test. It then sets the `JFIRE` input flag, resumes the original instructions, and checks that the game reaches the main loop with the title flag cleared and three lives.

The check writes `build/vice-verification.json`, the monitor and console logs, and `build/restored-title.png` and `build/restored-gameplay.png`. It has a 45-second timeout and a cycle limit, so a regression can't leave an unattended test running forever. The reviewed result for this checkpoint is in `docs/verification/vice-verification.json`.

---

## Documentation Tests

```sh
make docs-check
make test-docs
```

The first checks that the saved HTML handbook matches its Markdown sources. The second covers the handbook's navigation, embedded assets and failure handling.

---

## Verification Limits

Launch the game with `make run` and check the host-key mapping for the original controls: `Z` and `X` for left/right, `;` and `/` for up/down, and Space for fire/start. `F1` selects keyboard or joystick, and `F2` selects sound. These mappings come from the original source.

Manual keyboard and joystick input, sound, movement between rooms, bombs, death and restart, and a complete play-through are all still unverified, and so is testing on real hardware. The repeatable emulator check feeds in an input flag directly, so it says nothing about these behaviours.
