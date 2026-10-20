#!/usr/bin/env python3
"""Verify title rendering and gameplay entry with scripted input in VICE."""

import json
import re
import subprocess
from pathlib import Path

from restore_c16 import ROOT, tool


def verify(build):
    build = build.resolve()
    labels = dict((name, int(address, 16)) for address, name in
                  re.findall(r'^al ([0-9A-Fa-f]+) \.(\w+)$',
                             (build / 'labels.txt').read_text(), re.MULTILINE))
    code = (build / 'recovered-code.bin').read_bytes()
    start = labels['GLLOO'] - 0x1960
    # Stop immediately before the original BIT JFIRE/BPL test. Inject only
    # the fire input flag; do not change executable code or bypass game setup.
    candidates = [i for i in range(start, start + 24)
                  if code[i:i + 3] == bytes((0x24, labels['JFIRE'], 0x10))]
    if len(candidates) != 1:
        raise ValueError('Cannot locate the original title-screen fire test')
    check = candidates[0] + 0x1960
    commands = build / 'gameplay.mon'
    commands.write_text(
        f'load "{(build / "dorks.prg").as_posix()}" 0\n'
        f'break {check:x}\ng 1960\n'
        f'screenshot "{(build / "restored-title.png").as_posix()}" 2\n'
        f'> {labels["JFIRE"]:x} 80\ndelete 1\n'
        f'break {labels["LOOP"]:x}\nx\n'
        f'screenshot "{(build / "restored-gameplay.png").as_posix()}" 2\n'
        f'm {labels["TITLE"]:x} {labels["TITLE"]:x}\n'
        f'm {labels["LIVES"]:x} {labels["LIVES"]:x}\nquit\n')
    monitor_log = build / 'vice-gameplay-monitor.log'
    monitor_log.unlink(missing_ok=True)
    command = [tool('xplus4'), '-default', '+saveres', '-model', 'c16pal',
               '-ramsize', '16', '+sound', '-logfile', str(build / 'vice-gameplay.log'),
               '-monlogname', str(monitor_log), '-monlog', '-initbreak', 'ready',
               '-moncommands', str(commands), '-warp', '-limitcycles', '100000000']
    result = subprocess.run(command, cwd=str(ROOT), capture_output=True, timeout=45)
    (build / 'vice-console.log').write_bytes(result.stdout + result.stderr)
    result.check_returncode()
    log = monitor_log.read_text()
    expected = [f'C:${labels["LOOP"]:04x}',
                f'>C:{labels["TITLE"]:04x}  00',
                f'>C:{labels["LIVES"]:04x}  03']
    if not all(value.lower() in log.lower() for value in expected):
        raise ValueError('Gameplay verification failed; see vice-gameplay-monitor.log')
    for name in ('restored-title.png', 'restored-gameplay.png'):
        if not (build / name).read_bytes().startswith(b'\x89PNG\r\n\x1a\n'):
            raise ValueError(f'VICE did not create {name}')
    report = {'emulator': 'VICE xplus4', 'model': 'c16pal', 'ram_kib': 16,
              'gameplay_loop_reached': True, 'title_flag': 0, 'lives': 3,
              'input': 'scripted JFIRE flag at the original fire test',
              'manual_keyboard_and_full_playthrough': 'not verified'}
    (build / 'vice-verification.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps(report, indent=2))


if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--build-dir', type=Path, default=ROOT / 'build')
    verify(parser.parse_args().build_dir)
