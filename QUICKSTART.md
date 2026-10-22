# Quick Start

## Build

Install Python 3.9+, cc65, and VICE. From the project folder:

```sh
./build.sh
python3 scripts/run_vice.py
```

The output is `build/dorks.prg`, and the build checks that it matches the surviving reference byte for byte. The game loads at `$1000` and enters at `$1960` (`SYS 6496`). Use the launcher, because the rebuilt PRG has no BASIC stub.

---

## PlatformIO and VS Code

Open this folder in VS Code, install the recommended PlatformIO extension and run the default build task. From a PlatformIO terminal:

```sh
pio run -e c16
pio run -e c16 -t upload
```

`pio run -e c16_debug` gives the same game bytes plus debug files. Outputs land in `build/platformio/<environment>/`.

---

## Controls and Checks

The source maps `Z`, `X`, `;`, `/` and Space to left, right, up, down and fire/start. `F1` selects keyboard or joystick and `F2` selects sound. I haven't checked the host-key mapping by hand yet.

```sh
make test
make verify
make run-original
```

See [Build and Run](docs/BUILD_AND_RUN.md) and [Testing](TESTING.md) for details.
