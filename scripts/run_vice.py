#!/usr/bin/env python3
"""Load a PRG at its saved address and enter the game on a PAL C16."""

import argparse
import subprocess
from pathlib import Path

from restore_c16 import ROOT, tool


def launch(program):
    program = program.resolve(strict=True)
    build = ROOT / 'build/vice'
    build.mkdir(parents=True, exist_ok=True)
    commands = build / 'start.mon'
    commands.write_text(f'load "{program.as_posix()}" 0\ng 1960\n')
    # Wait for the KERNAL/BASIC reset to finish before loading. A raw machine
    # code PRG has no BASIC RUN stub; -autostart is not the entry mechanism.
    with (build / 'console.log').open('w') as log:
        process = subprocess.Popen([
            tool('xplus4'), '-default', '+saveres', '-model', 'c16pal', '-ramsize', '16',
            '-initbreak', 'ready', '-moncommands', str(commands),
            '-logfile', str(build / 'vice.log'),
        ], cwd=str(ROOT), stdout=log, stderr=subprocess.STDOUT, start_new_session=True)
    print(f'VICE started (PID {process.pid}): {program}')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('program', nargs='?', type=Path, default=ROOT / 'build/dorks.prg')
    parser.add_argument('--original', action='store_true',
                        help='run the surviving 1992 DORKSDIL.BIN instead of the rebuild')
    args = parser.parse_args()
    launch(ROOT / 'Original Source Recovered/1992/DORKSDIL.BIN' if args.original else args.program)
