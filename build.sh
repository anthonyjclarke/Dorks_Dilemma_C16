#!/bin/sh
# Rebuild and verify the recovered C16 game from the preserved disk image.
set -eu
cd "$(dirname "$0")"
exec "${PYTHON:-python3}" scripts/restore_c16.py "$@"
