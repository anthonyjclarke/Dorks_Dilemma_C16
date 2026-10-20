# Quick Start

## Build

Install Python 3.9 or later and cc65 (`ca65` and `ld65`). On macOS:

```sh
brew install cc65 vice
./build.sh
```

The result is `build/dorks.prg`. The build checks that it matches the surviving reference byte for byte.

---

## Run

```sh
scripts/run_vice.sh build/dorks.prg
```

The launcher uses a PAL C16 with 16 KB RAM, loads the PRG, and starts at `$1960`. The source uses `Z`, `X`, `;`, `/`, and Space for controls. How those map to host keys hasn't been checked by hand.

---

## PlatformIO and Checks

```sh
pio run -e c16
pio run -e c16 --target upload
make test
python3 scripts/verify_vice.py
```

The upload target launches VICE with `build/platformio/c16/dorks.prg`. The emulator check confirms the game reaches gameplay, using scripted input. It isn't a complete play-through.

[Restoration Status](docs/RESTORATION_STATUS.md) has the evidence, and [Source to VICE](docs/SOURCE_TO_VICE.md) describes the process.
