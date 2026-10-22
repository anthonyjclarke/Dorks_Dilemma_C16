#!/usr/bin/env python3
"""Generate developer references and original-data SVG previews.

Reads the preserved inputs and an existing verified build. Does not modify the
restoration builder, source image, executable, or emulator state.
"""

import argparse
import ast
import collections
import hashlib
import html
import json
import re
from pathlib import Path
from urllib.parse import quote

from d64_image import D64Image
from game_graphics import generate_graphics
from restore_c16 import FALLBACKS, IMAGE, OPCODES, ROOT, flatten, split_comment


def table(headers, rows):
    rows = [[str(cell).replace('|', '/') for cell in row] for row in [headers] + rows]
    widths = [max(3, max(len(row[i]) for row in rows)) for i in range(len(headers))]
    if max(widths) > 45:
        raise ValueError('Markdown table cell exceeds 45 characters')
    def row_text(row):
        return '| ' + ' | '.join(cell.ljust(width) for cell, width in zip(row, widths)) + ' |'
    return '\n'.join([row_text(rows[0]), row_text(['-' * w for w in widths])] +
                     [row_text(row) for row in rows[1:]])


def parse_line(line):
    body, comment = split_comment(line)
    body = body.strip()
    equate = re.match(r'^([A-Z][A-Z0-9_]*)\s*=', body)
    if equate:
        return equate[1], body[len(equate[1]):].strip(), comment.lstrip(';* ')
    parts = body.split(None, 1)
    if parts and re.fullmatch(r'[A-Z][A-Z0-9_]*', parts[0]):
        if parts[0] not in OPCODES | {'DPINC', 'DPDEC'}:
            return parts[0], parts[1] if len(parts) > 1 else '', comment.lstrip(';* ')
    return None, body, comment.lstrip(';* ')


def listing_owners(path):
    """Attribute printed PC advances, including abbreviated long data rows."""
    owners = {}
    owner = pending = address = None
    for line in path.read_text().splitlines():
        match = re.match(r'^([0-9A-F]{6})[ r]', line)
        if not match:
            continue
        current = int(match[1], 16)
        if address is not None and current != address:
            if pending and 0 < current - address <= 0x1EA0:
                for value in range(max(address, 0x1960), min(current, 0x3800)):
                    owners[value] = pending
            pending = None
        address = current
        source = re.search(r'; SOURCE: (.+):\d+$', line)
        if source:
            owner = source[1]
        if re.fullmatch(r'(?:(?:[0-9A-F]{2}|xx)\s*)+', line[11:23].strip()):
            pending = owner
    return owners


def svg_header(width, height, title, subtitle):
    return [f'<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" viewBox="0 0 {width} {height}" role="img">',
            f'<title>{html.escape(title)}</title>', f'<desc>{html.escape(subtitle)}</desc>',
            '<rect width="100%" height="100%" fill="#f8fafc"/>',
            f'<text x="16" y="26" font-family="monospace" font-size="17" fill="#0f172a">{html.escape(title)}</text>',
            f'<text x="16" y="48" font-family="monospace" font-size="11" fill="#475569">{html.escape(subtitle)}</text>']


def pixel_runs(out, values, x, y, width, height, colors):
    """Merge adjacent pixels of the same index without changing their values."""
    start = 0
    while start < len(values):
        end = start + 1
        while end < len(values) and values[end] == values[start]:
            end += 1
        out.append(f'<rect x="{x + start * width}" y="{y}" width="{(end - start) * width}" height="{height}" fill="{colors[values[start]]}"/>')
        start = end


def atlas(path, data, mode):
    title = f"Dork's Dilemma: 256 glyphs, {'two-bit' if mode == 'multicolor' else 'one-bit'} view"
    out = svg_header(960, 1190, title, 'Initial $3800 bank; decimal code / hex address. Preview colors identify raw indices.')
    colors = ['#111827', '#ef4444', '#38bdf8', '#fef08a'] if mode == 'multicolor' else ['#111827', '#e2e8f0']
    for index in range(256):
        x, y = (index % 16) * 60 + 10, (index // 16) * 70 + 65
        for row, byte in enumerate(data[index * 8:index * 8 + 8]):
            values = [(byte >> (6 - col * 2)) & 3 for col in range(4)] if mode == 'multicolor' else [(byte >> (7 - col)) & 1 for col in range(8)]
            pixel_runs(out, values, x, y + row * 5, 10 if mode == 'multicolor' else 5, 5, colors)
        out.append(f'<text x="{x}" y="{y + 54}" font-family="monospace" font-size="10" fill="#334155">{index:03d} {0x3800 + index * 8:04X}</text>')
    path.write_text('\n'.join(out + ['</svg>']) + '\n')


def room_layouts(data):
    if len(data) != 25 * 96:
        raise ValueError('Expected 25 layouts of 96 bytes')
    layouts = []
    for index in range(25):
        raw = data[index * 96:(index + 1) * 96]
        rows = []
        for row in range(24):
            left = [(byte >> shift) & 3 for byte in raw[row * 4:row * 4 + 4]
                    for shift in (6, 4, 2, 0)]
            rows.append(left + left[::-1])
        layouts.append({'layout': index, 'address': 0x1000 + index * 96,
                        'compressed_hex': raw.hex(), 'mirrored_indices': rows})
    return layouts


def rooms_atlas(path, layouts):
    colors = ['#e2e8f0', '#334155', '#38bdf8', '#a78bfa']
    out = svg_header(900, 800, "Dork's Dilemma: 25 stored room layouts",
                     'Two-bit cells mirrored to 32 columns. Doors, cleared-room edits, and actors are not included.')
    for index, color in enumerate(colors):
        x = 18 + index * 185
        out.append(f'<rect x="{x}" y="64" width="13" height="13" fill="{color}"/>')
        out.append(f'<text x="{x + 20}" y="75" font-family="monospace" font-size="11" fill="#334155">Index {index} / code {196 + index}</text>')
    for item in layouts:
        x, y = (item['layout'] % 5) * 180 + 18, (item['layout'] // 5) * 138 + 108
        out.append(f'<text x="{x}" y="{y - 8}" font-family="monospace" font-size="12" fill="#0f172a">Layout {item["layout"]:02d} / ${item["address"]:04X}</text>')
        for row, values in enumerate(item['mirrored_indices']):
            pixel_runs(out, values, x, y + row * 4, 4, 4, colors)
        out.append(f'<rect x="{x}" y="{y}" width="128" height="96" fill="none" stroke="#94a3b8"/>')
    path.write_text('\n'.join(out + ['</svg>']) + '\n')


def analyze(build, output):
    disk = {file.name: file for file in D64Image(IMAGE).files()}
    manifest = json.loads((build / 'recovery-manifest.json').read_text())
    provenance = {entry['name']: entry for entry in manifest['files']}
    if manifest['image_sha256'] != hashlib.sha256(IMAGE.read_bytes()).hexdigest():
        raise ValueError('Build manifest is stale; rebuild first')
    for entry in manifest['files']:
        raw = (ROOT / entry['source']).read_bytes() if entry['source'].startswith('Original Source Recovered/1992/') else disk[entry['name']].data
        if hashlib.sha256(raw).hexdigest() != entry['sha256']:
            raise ValueError(f'Stale input: {entry["name"]}; rebuild first')
    sources = {name: file.data.decode('ascii').splitlines() for name, file in disk.items()
               if file.kind == 'SEQ' and name not in ('OBJ', 'O.DES')}
    for name, filename in FALLBACKS.items():
        sources.setdefault(name, (ROOT / 'Original Source Recovered/1992' / filename).read_text().upper().splitlines())
    active = list(dict.fromkeys(name for name, _, _ in flatten(sources)))
    program = (build / 'dorks.prg').read_bytes()
    code = (build / 'recovered-code.bin').read_bytes()
    if program != disk["DORK'S DILEMMA"].data or code != program[0x962:0x2802]:
        raise ValueError('Analysis requires the verified reference-matching build')
    labels = {name: int(address, 16) for address, name in re.findall(
        r'^al ([0-9A-Fa-f]+) \.(\w+)$', (build / 'labels.txt').read_text(), re.MULTILINE)}
    owners = listing_owners(build / 'recovered-c16.lst')
    if set(owners) != set(range(0x1960, 0x1960 + len(code))):
        raise ValueError('Listing ownership must cover all assembled program bytes')
    sizes = collections.Counter(owners.values())
    symbols, transfers, variables, modules = {}, [], [], []
    for name in active:
        instruction_lines = 0
        for number, line in enumerate(sources[name], 1):
            symbol, body, comment = parse_line(line)
            if symbol:
                if symbol in symbols:
                    raise ValueError(f'Duplicate source symbol: {symbol}')
                kind = 'equate' if body.startswith('=') else 'label'
                if '*=*+' in body:
                    kind = 'reserved'
                elif body.startswith(('.BYTE', '.WORD')):
                    kind = 'data'
                symbols[symbol] = {'symbol': symbol, 'module': name, 'line': number,
                                   'kind': kind, 'address': labels.get(symbol), 'comment': comment,
                                   'expression': body[1:].strip() if kind == 'equate' else None}
                if name == 'VARS' and kind == 'reserved':
                    size = body.split('*=*+', 1)[1].strip()
                    variables.append({'symbol': symbol, 'address': labels[symbol],
                                      'bytes': int(size[1:], 16) if size.startswith('$') else int(size),
                                      'source_line': number, 'comment': comment})
            parts = body.split(None, 1)
            if parts and parts[0] in OPCODES:
                instruction_lines += 1
            if parts and parts[0] in {'JSR', 'JMP', 'BCC', 'BCS', 'BEQ', 'BMI', 'BNE', 'BPL', 'BVC', 'BVS'} and len(parts) == 2:
                transfers.append({'module': name, 'line': number,
                                  'operation': parts[0], 'operand': parts[1]})
        entry = provenance[name]
        modules.append({'name': name, 'source': entry['source'],
                        'fallback': entry['source'].startswith('Original Source Recovered/1992/'),
                        'raw_bytes': len(disk[name].data) if name in disk else (ROOT / entry['source']).stat().st_size,
                        'logical_lines': len(sources[name]), 'instruction_lines': instruction_lines,
                        'program_region_bytes': sizes[name]})

    def constant(expression):
        expression = re.sub(r'\$([0-9A-F]+)', r'0x\1', expression)
        expression = re.sub(r'%([01]+)', r'0b\1', expression)
        def walk(node):
            if isinstance(node, ast.Constant) and type(node.value) is int:
                return node.value
            if isinstance(node, ast.Name):
                value = symbols[node.id]['address']
                if value is None:
                    raise ValueError(node.id)
                return value
            if isinstance(node, ast.BinOp):
                left, right = walk(node.left), walk(node.right)
                if isinstance(node.op, ast.Add):
                    return left + right
                if isinstance(node.op, ast.Sub):
                    return left - right
                if isinstance(node.op, ast.Mult):
                    return left * right
            raise ValueError('Unsupported expression')
        return walk(ast.parse(expression, mode='eval').body)

    for _ in range(4):
        for symbol in symbols.values():
            if symbol['kind'] == 'equate' and symbol['address'] is None:
                try:
                    symbol['address'] = constant(symbol['expression'])
                except (KeyError, ValueError, SyntaxError):
                    pass
    for item in transfers:
        match = re.match(r'^([A-Z][A-Z0-9_]*)', item['operand'])
        definition = symbols.get(match[1]) if match else None
        item['target_module'] = definition['module'] if definition else None
        try:
            item['target_address'] = constant(item['operand'])
        except (KeyError, ValueError, SyntaxError):
            item['target_address'] = None
    counts = {'active_modules': len(active), 'logical_source_lines': sum(len(sources[n]) for n in active),
              'instruction_like_lines': sum(m['instruction_lines'] for m in modules),
              'symbol_definitions': len(symbols), 'direct_transfers': len(transfers),
              'zero_page_bytes': sum(v['bytes'] for v in variables),
              'program_region_bytes': sum(sizes.values())}
    output.mkdir(parents=True, exist_ok=True)
    index = {'method': 'Static source/label/listing catalogue; not a complete call graph or timing profile.',
             'source_image_sha256': manifest['image_sha256'], 'prg_sha256': hashlib.sha256(program).hexdigest(),
             'assembly_root': 'ROOMS OF PERIL', 'assembly_order': active, 'modules': modules,
             'symbols': sorted(symbols.values(), key=lambda s: s['symbol']),
             'zero_page_variables': variables, 'direct_transfers': transfers, 'counts': counts}
    (output / 'codebase-index.json').write_text(json.dumps(index, indent=2) + '\n')
    payload = program[2:]
    assets = {'note': 'Initial bytes and static layout decoding. Preview colors are indices, not final TED colors.',
              'charset': {'address': 0x3800, 'glyphs': 256, 'source': 'Reference PRG graphics region', 'hex': payload[0x2800:].hex()},
              'screen_data': {'address': 0x1000, 'source': 'MUFF', 'hex': payload[:2400].hex()},
              'room_layouts': room_layouts(payload[:2400]), 'tables': {}}
    for name, length in [('RASVAL', 2), ('BTD', 5), ('RWD', 5), ('INKDAT', 58),
                         ('DOORDT', 25), ('YVAL2', 6), ('ALSTAT', 8), ('TIME5', 5),
                         ('TIM32', 8), ('WALY', 6), ('LVALMV', 5), ('LVNOKL', 5),
                         ('LVNOKK', 5), ('JKCHAR', 48), ('SQCHAR', 48)]:
        address = labels[name]
        raw = payload[address - 0x1000:address - 0x1000 + length]
        if len(raw) != length:
            raise ValueError(f'Table outside PRG: {name}')
        assets['tables'][name] = {'address': address, 'bytes': length, 'hex': raw.hex()}
    (output / 'asset-data.json').write_text(json.dumps(assets, indent=2) + '\n')
    atlas(output / 'font-hires.svg', payload[0x2800:], 'hires')
    atlas(output / 'font-multicolor.svg', payload[0x2800:], 'multicolor')
    rooms_atlas(output / 'room-layouts.svg', assets['room_layouts'])
    generate_graphics(output, program, labels, ROOT / 'docs/images/restored-gameplay.png')
    reference = '# Generated Code Reference\n\n## Scope and Method\n\nGenerated by `scripts/analyze_codebase.py` from the preserved source and verified build. Lines refer to normalized original modules. Byte allocations include instructions and embedded data; they are not function sizes. Symbols may name branch targets, variables, or data. Direct transfers omit fall-through, IRQ-vector dispatch, macro expansion, and runtime patches.\n\n---\n\n## Modules in Assembly Order\n\n'
    reference += table(['Module', 'Bytes', 'Lines', 'Input'], [(f'`{m["name"]}`', m['program_region_bytes'], m['logical_lines'], 'Archive' if m['fallback'] else 'Disk') for m in modules])
    reference += '\n\n---\n\n## Source Provenance\n\n'
    for module in modules:
        source = module['source']
        reference += f'`{module["name"]}` – [preserved input](../../{quote(source, safe="/")}); '
        reference += ('older text file' if module['fallback'] else f'disk entry `{module["name"]}`')
        reference += f'; {module["raw_bytes"]} raw bytes, {module["logical_lines"]} logical lines.\n\n'
    reference += '---\n\n## Zero-Page Variables\n\n'
    reference += table(['Symbol', 'Address', 'Bytes', 'Line'], [(f'`{v["symbol"]}`', f'`${v["address"]:04X}`', v['bytes'], v['source_line']) for v in variables]) + '\n\n---\n\n## Symbols by Module\n\n'
    for module in active:
        definitions = [symbol for symbol in symbols.values() if symbol['module'] == module]
        if definitions:
            reference += f'### {module}\n\n' + table(['Symbol', 'Address', 'Line', 'Kind'], [
                (f'`{s["symbol"]}`', f'`${s["address"]:04X}`' if s['address'] is not None else 'Unresolved', s['line'], s['kind'])
                for s in definitions]) + '\n\n'
    (output / 'CODE_REFERENCE.md').write_text(reference)
    print(json.dumps(counts, indent=2))
    print(f'Generated developer references in {output.relative_to(ROOT) if output.is_relative_to(ROOT) else output}')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--build-dir', type=Path, default=ROOT / 'build')
    parser.add_argument('--output-dir', type=Path, default=ROOT / 'docs/analysis')
    args = parser.parse_args()
    analyze(args.build_dir.resolve(), args.output_dir.resolve())
