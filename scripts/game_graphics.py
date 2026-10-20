"""Draw explanatory SVGs from verified game bytes, without image dependencies."""

import base64
import html


COLORS = ['#111827', '#ef4444', '#38bdf8', '#fef08a']
HIRES = ['#111827', '#e2e8f0']


class Sheet:
    def __init__(self, width, height, title, subtitle):
        self.parts = [
            f'<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" viewBox="0 0 {width} {height}" role="img">',
            f'<title>{html.escape(title)}</title>',
            f'<desc>{html.escape(subtitle)}</desc>',
            '<rect width="100%" height="100%" fill="#f8fafc"/>',
        ]
        self.text(24, 32, title, 21)
        self.text(24, 57, subtitle, 12, '#475569')

    def text(self, x, y, value, size=13, color='#0f172a'):
        self.parts.append(f'<text x="{x}" y="{y}" font-family="monospace" font-size="{size}" fill="{color}">{html.escape(str(value))}</text>')

    def rect(self, x, y, width, height, fill='none', stroke='#94a3b8'):
        self.parts.append(f'<rect x="{x}" y="{y}" width="{width}" height="{height}" fill="{fill}" stroke="{stroke}"/>')

    def glyph(self, raw, x, y, scale=4, multi=True):
        assert len(raw) == 8
        colors = COLORS if multi else HIRES
        for row, byte in enumerate(raw):
            count, bits = (4, 2) if multi else (8, 1)
            for col in range(count):
                value = (byte >> (8 - bits * (col + 1))) & ((1 << bits) - 1)
                self.rect(x + col * bits * scale, y + row * scale,
                          bits * scale, scale, colors[value], 'none')

    def block(self, raw, cols, x, y, scale=4, multi=True, grid=False):
        assert len(raw) % (cols * 8) == 0
        for tile in range(len(raw) // 8):
            tx, ty = x + tile % cols * 8 * scale, y + tile // cols * 8 * scale
            self.glyph(raw[tile * 8:tile * 8 + 8], tx, ty, scale, multi)
            if grid:
                self.rect(tx, ty, 8 * scale, 8 * scale)

    def legend(self, y):
        for i, color in enumerate(COLORS):
            self.rect(24 + i * 182, y, 18, 18, color, 'none')
            self.text(49 + i * 182, y + 14, f'{i:02b} / index {i}', 12)

    def save(self, path):
        path.write_text('\n'.join(self.parts + ['</svg>']) + '\n')


def generate_graphics(output, program, labels, screenshot):
    """Use the assembled tables, not the loose historical graphics files."""
    load = int.from_bytes(program[:2], 'little')
    payload = program[2:]

    def memory(address, count):
        offset = address - load
        assert offset >= 0 and offset + count <= len(payload)
        return payload[offset:offset + count]

    def data(name, count):
        return memory(labels[name], count)

    def glyphs(first, count=1):
        return memory(0x3800 + first * 8, count * 8)

    balman = data('BALMAN', 128)
    defs = [data('DEF1', 256), data('DEF2', 256)]
    assert list(data('WALY', 6)) == [0, 1, 2, 40, 41, 42]
    assert list(data('YVAL2', 6)) == [0, 1, 40, 41, 80, 81]
    assert list(data('ACHAR', 4)) == [28, 29, 30, 31]

    s = Sheet(1120, 720, "Dork: stationary animation and movement graphics",
              'Actual game bytes; two-bit index colours for inspection, not the TED display palette.')
    s.text(24, 96, f'Stationary: BALMAN at ${labels["BALMAN"]:04X}; four 32-byte frames copied to glyphs 28-31', 15)
    for frame in range(4):
        x = 32 + frame * 265
        s.block(balman[frame * 32:(frame + 1) * 32], 2, x, 116, 6, grid=True)
        s.text(x + 112, 143, f'Frame {frame}')
        s.text(x + 112, 164, f'+{frame * 32:02X} hex', 12)
    s.text(24, 245, 'MANGLP sequence: 0, 1, 2, 3, 2, 3...  |  16 x 16 screen dots (8 x 16 colour samples)', 13)
    s.text(24, 290, 'Horizontal movement: four 3 x 2 tile blocks, selected by XPIX', 15)
    for frame in range(4):
        x = 32 + frame * 265
        first = 148 + frame * 6
        s.block(glyphs(first, 6), 3, x, 310, 5, grid=True)
        s.text(x, 414, f'XPIX={frame}: {first}-{first + 5}', 12)
    s.text(24, 460, 'Vertical movement: four 2 x 3 tile blocks, selected by YPIX', 15)
    for frame in range(4):
        x = 32 + frame * 265
        first = 172 + frame * 6
        s.block(glyphs(first, 6), 2, x, 480, 5, grid=True)
        s.text(x + 92, 510, f'YPIX={frame}', 12)
        s.text(x + 92, 532, f'{first}-{first + 5}', 12)
    s.text(24, 636, 'Movement blocks include empty space: PRINT swaps six tile codes; it does not shift a hardware sprite.', 12)
    s.legend(672)
    s.save(output / 'game-player.svg')

    s = Sheet(1120, 690, 'Aliens: all eight GONK designs and both animation frames',
              'DEF1 / DEF2 contain 32 bytes per design; each frame is assembled as a 2 x 2 tile image.')
    for alien in range(8):
        x, y = 24 + alien % 4 * 274, 90 + alien // 4 * 250
        s.text(x, y + 12, f'GONK #{alien + 1} / type {alien}', 15)
        for frame in range(2):
            fx = x + frame * 125
            raw = defs[frame][alien * 32:(alien + 1) * 32]
            s.block(raw, 2, fx, y + 32, 6, grid=True)
            s.text(fx, y + 148, f'DEF{frame + 1} +${alien * 32:02X}', 12)
    s.text(24, 603, 'GETDEF -> ALIBUF (64 bytes) -> ALIANI -> $3E88-$3EA7 -> screen codes 209, 210 / 211, 212', 12)
    s.text(24, 625, 'Up to four aliens share these glyphs and animate together; PRNALS supplies the cell positions.', 12)
    s.legend(650)
    s.save(output / 'game-aliens.svg')

    s = Sheet(1120, 930, 'Other game graphics: bombs, scenery, jigsaw, radar and death effect',
              'MC = two-bit index preview; HR = one-bit preview. Runtime changes are labelled explicitly.')
    s.text(24, 95, 'Bomb / MC', 15)
    s.block(glyphs(244, 4), 2, 24, 112, 5, grid=True)
    s.text(124, 137, '244 245 / 246 247')
    s.text(124, 160, 'BOMPRT: flashing attribute', 12)
    s.text(124, 182, 'COPYBM -> charge glyphs 44-47', 12)
    s.text(124, 204, 'READY fills the charge upward', 12)
    s.text(580, 95, 'Death cross / MC', 15)
    left, right = data('CROSSL', 16), data('CROSSR', 16)
    cross = left[:8] + right[:8] + left[8:] + right[8:]
    s.block(cross, 2, 580, 112, 5, grid=True)
    s.text(680, 137, 'Reconstructed CROSSL / CROSSR', 12)
    s.text(680, 160, 'DEADCK scrolls into slots 33-36', 12)
    s.text(680, 182, 'Screen order: 33 35 / 34 36', 12)
    s.text(24, 253, 'Scenery / MC: initial bank (ANIMAT replaces 198-200 at runtime)', 15)
    for n, label in enumerate(['Floor', 'Brick', 'Brick', 'Wall', 'Door']):
        x = 24 + n * 215
        s.block(glyphs(196 + n), 1, x, 275, 6)
        s.text(x + 60, 295, str(196 + n))
        s.text(x + 60, 317, label, 12)
    s.text(24, 378, 'Jigsaw source / HR', 15)
    s.block(glyphs(215, 25), 5, 24, 398, 5, multi=False, grid=True)
    s.text(24, 621, '215-239: 25 eight-byte pieces', 12)
    # PRPICE expands each source bit twice horizontally and vertically.
    source = glyphs(215)
    expanded = []
    for half in (4, 0):
        rows = [sum(((byte >> (half + bit)) & 1) * (3 << (bit * 2))
                    for bit in range(4)) for byte in source]
        expanded.extend(bytes(v for row in rows[:4] for v in (row, row)))
        expanded.extend(bytes(v for row in rows[4:] for v in (row, row)))
    enlarged = [bytes(expanded[i:i + 8]) for i in range(0, 32, 8)]
    frame_codes = list(data('JIGCHR', 16))
    s.text(324, 378, 'PRPICE: piece 0 enlarged / HR', 15)
    for i, code in enumerate(frame_codes):
        raw = enlarged[code - 240] if 240 <= code <= 243 else glyphs(code)
        s.glyph(raw, 324 + i % 4 * 40, 398 + i // 4 * 40, 5, multi=False)
    s.text(324, 586, '205 203 203 206', 12)
    s.text(324, 605, '204 240 242 204', 12)
    s.text(324, 624, '204 241 243 204', 12)
    s.text(324, 643, '207 203 203 208', 12)
    s.text(700, 378, 'Radar / HR', 15)
    radar = bytearray([255] * 8)
    radar[4] = 0xEF
    s.block(glyphs(201), 1, 700, 398, 6, multi=False)
    s.block(radar, 1, 780, 398, 6, multi=False)
    s.text(700, 473, '201: room; 202: current room', 12)
    s.text(700, 495, 'RADAR rewrites 202 at $3E50', 12)
    s.text(700, 517, 'Marker shown is an example', 12)
    s.text(24, 700, 'Animated brick samples / MC: first frame of BRIK3, BRIK1 and BRIK2', 15)
    for i, name in enumerate(['BRIK3', 'BRIK1', 'BRIK2']):
        s.block(data(name, 8), 1, 24 + i * 240, 722, 6)
        s.text(84 + i * 240, 750, f'{name} -> {198 + i}', 12)
    s.text(24, 812, 'Explosion: ANIEXP rewrites glyph 248 ($3FC0) from $8000,X; its live texture is not a fixed asset.', 12)
    s.text(24, 837, 'Text, score lettering, borders and interface symbols are catalogued in the full character atlases.', 12)
    s.legend(878)
    s.save(output / 'game-objects.svg')

    s = Sheet(1120, 640, 'Assembling Dork: bytes -> four glyphs -> screen cells -> visible pixels',
              'Worked stationary-frame example. Screen location (10,6) is illustrative, not a gameplay capture.')
    s.text(24, 103, '1. BALMAN frame 0: 32 bytes', 16)
    for i, slot in enumerate(range(28, 32)):
        y = 138 + i * 32
        raw = balman[i * 8:i * 8 + 8]
        s.text(24, y, f'{slot}: ' + ' '.join(f'{b:02X}' for b in raw), 14)
    s.text(24, 290, 'Glyph n starts at $3800 + 8*n.', 13)
    s.text(24, 314, '$05 = 00 00 01 01: four colour pairs.', 13)
    s.text(24, 338, 'Each pair occupies two screen dots.', 13)
    s.text(438, 103, '2. MANGLP copies to $38E0-$38FF', 16)
    for i in range(4):
        x, y = 438 + i % 2 * 104, 124 + i // 2 * 112
        s.glyph(balman[i * 8:i * 8 + 8], x, y, 9)
        s.text(x, y + 90, f'{28 + i} / ${0x38E0 + i * 8:04X}', 12)
    s.text(815, 103, '3. NORMPR joins tiles', 16)
    s.block(balman[:32], 2, 815, 124, 12, grid=True)
    s.text(815, 341, '16 x 16 screen dots', 13)
    s.text(24, 405, '4. XY: SL = $0C00 + 40*y + x; CL = SL - $0400', 17)
    for i, text in enumerate([
        'At (10,6): screen $0CFA=28, $0CFB=29, $0D22=30, $0D23=31.',
        'Attributes: $08FA, $08FB, $0922, $0923 each receive $79.',
        'TED uses each screen code to read its eight glyph bytes from the $3800 bank.',
        'Changing glyph bytes animates every cell using those codes; moving changes screen codes.',
        'BUGRUB erases the previous player footprint with floor code 196 before PRINT redraws.',
    ]):
        s.text(24, 440 + i * 29, text, 13)
    s.legend(595)
    s.save(output / 'game-assembly.svg')

    s = Sheet(1120, 680, 'Where the graphics appear: the restored C16 gameplay display',
              'Existing VICE capture at gameplay entry, enlarged 2x without smoothing. Labels describe the screen layout.')
    image = base64.b64encode(screenshot.read_bytes()).decode('ascii')
    s.parts.append(f'<image x="16" y="76" width="768" height="576" style="image-rendering:pixelated" href="data:image/png;base64,{image}"/>')
    # The capture includes a border: the 320 x 200 display starts at (32,40).
    s.rect(80, 156, 512, 384, stroke='#38bdf8')
    s.rect(592, 156, 128, 384, stroke='#fef08a')
    s.rect(80, 540, 640, 16, stroke='#ef4444')
    lines = [
        ('Room: columns 0-31', '#0284c7'),
        ('Rows 0-23: 256 x 192 dots', '#0f172a'),
        ('MUFF -> DECODE -> SCRBUF', '#0f172a'),
        ('FADEIN -> screen + attributes', '#0f172a'),
        ('Actors overwrite room cells', '#0f172a'),
        ('Player: PRINT / NORMPR', '#0f172a'),
        ('Aliens: PRNALS', '#0f172a'),
        ('Jigsaw: PRPICE', '#0f172a'),
        ('Sidebar: columns 32-39', '#854d0e'),
        ('PRBDER / SETWIN: frame, text', '#0f172a'),
        ('READY: bomb charge icon', '#0f172a'),
        ('TRANSF: collected pieces', '#0f172a'),
        ('RADAR: 5 x 5 room map', '#0f172a'),
        ('Bottom: row 24 / 40 cells', '#dc2626'),
        ('MESSVE + raster fine scroll', '#0f172a'),
        ('Display: 40 x 25 characters', '#0f172a'),
        ('$0C00 codes / $0800 attributes', '#0f172a'),
    ]
    for i, (line, color) in enumerate(lines):
        s.text(800, 111 + i * 31, line, 12, color)
    s.save(output / 'game-screen.svg')
