#!/bin/sh
# Run the original or restored machine-code PRG on an emulated C16.
set -eu
project_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
exec "${PYTHON:-python3}" "$project_dir/scripts/run_vice.py" "$@"
