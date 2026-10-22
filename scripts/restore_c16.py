#!/usr/bin/env python3
"""Rebuild the recovered C16 source, retaining an audit trail to the disk."""

import argparse
import hashlib
import json
import re
import shutil
import subprocess
from pathlib import Path

from d64_image import D64Image


ROOT = Path(__file__).resolve().parents[1]
IMAGE = ROOT / "Original Source Recovered/2026/Dorks-Dilemma-C16.d64"
FALLBACKS = {
    "RASTER-ROUTINES": "RASTERRO.TXT",
    "ALIENS-MEGA/CODE": "ALIENSME.TXT",
    "ALIEN-CHEK/PRINT": "ALIENCHE.TXT",
    "WHOOPPEE-MESSAGE": "WHOOPPEE.TXT",
}
OPCODES = set("ADC AND ASL BCC BCS BEQ BIT BMI BNE BPL BRK BVC BVS CLC CLD CLI CLV CMP CPX CPY DEC DEX DEY EOR INC INX INY JMP JSR LDA LDX LDY LSR NOP ORA PHA PHP PLA PLP ROL ROR RTI RTS SBC SEC SED SEI STA STX STY TAX TAY TSX TXA TXS TYA".split())


def split_comment(line):
    """Keep semicolons in quoted data, including old single-character operands."""
    position = 0
    while position < len(line):
        char = line[position]
        if char == ";":
            return line[:position].rstrip(), line[position:]
        if char in "\"'":
            end = line.find(char, position + 1)
            position = end + 1 if end >= 0 else position + 2
        else:
            position += 1
    return line.rstrip(), ""


def prepare_sources(build):
    disk_files = D64Image(IMAGE).files()
    sources = {}
    provenance = []
    raw_dir = build / "disk"
    raw_dir.mkdir(parents=True, exist_ok=True)
    for file in disk_files:
        safe_name = file.name.replace("/", "-").lower()
        output = raw_dir / f"{safe_name}.{file.kind.lower()}"
        output.write_bytes(file.data)
        provenance.append({
            "name": file.name, "type": file.kind, "size": len(file.data),
            "sha256": hashlib.sha256(file.data).hexdigest(),
            "source": str(IMAGE.relative_to(ROOT)), "closed": file.closed,
        })
        if file.kind == "SEQ" and file.name not in ("OBJ", "O.DES"):
            sources[file.name] = file.data.decode("ascii").splitlines()
    for name, filename in FALLBACKS.items():
        if name not in sources:
            path = ROOT / "Original Source Recovered/1992" / filename
            # Earlier PC text exports changed source case. Restore the upper-case
            # Commodore source representation, including literal text bytes.
            sources[name] = path.read_text().upper().splitlines()
            provenance.append({"name": name, "source": str(path.relative_to(ROOT)),
                               "sha256": hashlib.sha256(path.read_bytes()).hexdigest(),
                               "normalization": "upper case; universal newlines"})
    (build / "recovery-manifest.json").write_text(json.dumps({
        "image_sha256": hashlib.sha256(IMAGE.read_bytes()).hexdigest(),
        "files": provenance,
    }, indent=2) + "\n")
    return sources, {file.name: file.data for file in disk_files}


def flatten(sources, name="ROOMS OF PERIL", stack=()):
    if name in stack:
        raise ValueError(f"Recursive include: {name}")
    result = []
    for number, line in enumerate(sources[name], 1):
        code, _ = split_comment(line)
        if code.strip().upper().startswith(".LIB "):
            pattern = code.split()[1].rstrip("*")
            matches = [key for key in sources if key.startswith(pattern)]
            if len(matches) != 1:
                raise ValueError(f"{name}:{number}: ambiguous/missing include {pattern}: {matches}")
            result.extend(flatten(sources, matches[0], stack + (name,)))
        elif code.strip().upper() == ".END":
            break
        else:
            result.append((name, number, line))
    return result


def convert(lines):
    output = ['; Generated from recovered C16 source. See recovery-manifest.json.',
              '.setcpu "6502"', '.feature force_range']
    macro = False
    previous = None
    for name, number, line in lines:
        if previous != name:
            output.append(f"; SOURCE: {name}:{number}")
            previous = name
        code, comment = split_comment(line)
        code = code.strip()
        if code.startswith(".MAC "):
            macro = True
            macro_name = code.split()[1]
            if macro_name == "DPINC":
                output.extend(['.macro DPINC addr', '    inc addr', '    bne :+',
                               '    inc addr+1', ':', '.endmacro'])
            elif macro_name == "DPDEC":
                output.extend(['.macro DPDEC addr', '    lda addr', '    sec',
                               '    sbc #1', '    sta addr', '    lda addr+1',
                               '    sbc #0', '    sta addr+1', '.endmacro'])
            else:
                raise ValueError(f"Unknown macro {macro_name}")
            continue
        if code == ".MND":
            macro = False
            continue
        if macro or code.startswith(".OPT "):
            continue
        if not code:
            output.append(comment)
            continue
        origin = re.fullmatch(r"\*=\$([0-9A-F]+)", code)
        if origin:
            address = int(origin[1], 16)
            segment = {2: "ZEROPAGE", 0x200: "BSS", 0x1960: "CODE"}.get(address)
            if segment is None:
                raise ValueError(f"Unexpected origin {code} at {name}:{number}")
            output.extend([f'.segment "{segment}"', f'.org ${address:04X}'])
            continue
        reserve = re.fullmatch(r"(?:(\w+)\s+)?\*=\*\+(.+)", code)
        if reserve:
            code = (reserve[1] + ': ' if reserve[1] else '') + '.res ' + reserve[2]
        elif re.match(r"^\w+\s*=", code):
            pass  # Equates must retain the complete expression.
        else:
            first, *rest = code.split(None, 1)
            if not first.startswith('.') and first not in OPCODES | {"DPINC", "DPDEC"}:
                code = first + ':' + (' ' + rest[0] if rest else '')
            # MOS data strings use single quotes; ca65 strings use double quotes.
            if re.search(r"\.BYT(?:E)?\b", code):
                code = re.sub(r"'([^']*)'", lambda m: json.dumps(m[1]), code)
                code = re.sub(r"\.BYT\b", '.byte', code)
            # The original assembler permits an opening quote plus one character.
            code = re.sub(r"#'([^'])(?!')(?=\s*$)", r"#'\1'", code)
        output.append(code + (' ' + comment if comment else ''))
    return '\n'.join(output) + '\n'


def tool(name):
    found = shutil.which(name)
    if found:
        return found
    homebrew = Path('/opt/homebrew/bin') / name
    if homebrew.is_file():
        return str(homebrew)
    raise FileNotFoundError(f"{name} not found; install the cc65 toolchain")


def build_game(build):
    build.mkdir(parents=True, exist_ok=True)
    sources, disk = prepare_sources(build)
    assembly = build / 'recovered-c16.s'
    assembly.write_text(convert(flatten(sources)))
    subprocess.run([tool('ca65'), '-g', '-l', str(build / 'recovered-c16.lst'),
                    '-o', str(build / 'recovered-c16.o'), str(assembly)], check=True)
    subprocess.run([tool('ld65'), '-C', str(ROOT / 'config/c16.cfg'),
                    '-o', str(build / 'recovered-code.bin'), '-m', str(build / 'map.txt'),
                    '-Ln', str(build / 'labels.txt'), '--dbgfile', str(build / 'dorks.dbg'),
                    str(build / 'recovered-c16.o')], check=True)
    code = (build / 'recovered-code.bin').read_bytes()
    reference = disk["DORK'S DILEMMA"]
    if len(reference) != 12290 or reference[:2] != b'\x00\x10':
        raise ValueError('Unexpected reference PRG layout')
    memory = bytearray(0x3000)
    # The standalone CHARS file is a different revision in 142 bytes. Retain
    # that original file in disk/, but use the reference game's graphics data.
    # Executable bytes always come from ca65/ld65, never from the reference.
    charset = reference[2 + 0x2800:2 + 0x3000]
    assets = {'MUFF': disk['MUFF'], 'CHARSET': b'\x00\x38' + charset}
    for asset, raw in assets.items():
        address = int.from_bytes(raw[:2], 'little')
        offset = address - 0x1000
        if offset < 0 or offset + len(raw) - 2 > len(memory):
            raise ValueError(f"Asset outside C16 output: {asset}")
        memory[offset:offset + len(raw) - 2] = raw[2:]
    if len(code) > 0x3800 - 0x1960:
        raise ValueError('Recovered code overlaps the character set')
    memory[0x960:0x960 + len(code)] = code
    output = build / 'dorks.prg'
    output.write_bytes(b'\x00\x10' + memory)
    changes = [i for i, (a, b) in enumerate(zip(output.read_bytes(), reference)) if a != b]
    report = {'code_bytes': len(code), 'output_bytes': output.stat().st_size,
              'code_matches_reference': code == reference[2 + 0x960:2 + 0x2800],
              'charset_source': "DORK'S DILEMMA: $3800-$3FFF (graphics data only)",
              'standalone_charset_differences': sum(a != b for a, b in zip(charset, disk['CHARS'][2:])),
              'different_bytes': len(changes),
              'first_differences': [f'${i - 2 + 0x1000:04X}' for i in changes[:20]],
              'reference_matches_earlier_copy': reference == (ROOT / 'Original Source Recovered/1992/DORKSDIL.BIN').read_bytes()}
    (build / 'comparison.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps(report, indent=2))
    if len(output.read_bytes()) != len(reference) or changes:
        raise ValueError('Rebuild differs from the reference; see comparison.json')
    return output


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--build-dir', type=Path, default=ROOT / 'build')
    args = parser.parse_args()
    build_game(args.build_dir.resolve())
