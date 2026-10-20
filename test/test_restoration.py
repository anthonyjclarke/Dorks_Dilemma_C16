"""Regression checks against the surviving game, including prior conversion bugs."""

import contextlib
import io
import json
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'scripts'))
from d64_image import D64Image
from restore_c16 import FALLBACKS, IMAGE, ROOT, build_game, convert, flatten


class OriginalGameRegression(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temporary = tempfile.TemporaryDirectory()
        cls.build = Path(cls.temporary.name)
        with contextlib.redirect_stdout(io.StringIO()):
            cls.program = build_game(cls.build)

    @classmethod
    def tearDownClass(cls):
        cls.temporary.cleanup()

    def test_complete_prg_matches_surviving_reference(self):
        self.assertEqual(self.program.read_bytes(), (ROOT / 'Original_Files/DORKSDIL.BIN').read_bytes())

    def test_executable_is_assembled_from_source(self):
        reference = self.program.read_bytes()
        code = (self.build / 'recovered-code.bin').read_bytes()
        self.assertEqual(len(code), 7840)
        self.assertEqual(code, reference[2 + 0x960:2 + 0x2800])

    def test_earlier_archive_dependencies_are_explicit(self):
        manifest = json.loads((self.build / 'recovery-manifest.json').read_text())
        fallbacks = {entry['name'] for entry in manifest['files']
                     if entry['source'].startswith('Original_Files/')}
        self.assertEqual(fallbacks, set(FALLBACKS))

    def test_image_contains_the_untruncated_bomb_routines(self):
        files = {file.name: file for file in D64Image(IMAGE).files()}
        self.assertEqual(len(files), 66)
        source = files['FILLER-BOMB'].data.decode('ascii').splitlines()
        self.assertIn('CHKBMB', source)
        self.assertIn('FILLEX', source)
        self.assertIn('CLEXP', source)
        self.assertEqual(source[-1], '.END')


class ConversionFailureRegression(unittest.TestCase):
    def test_labelled_instructions_and_register_equates_survive(self):
        result = convert([('DECODER', 81, 'SELFMD LDA $FFFF,X'),
                          ('DECODER', 225, 'LMIRR LDA $FFFF,X'),
                          ('MAIN-VARS', 8, 'IRQREG = TED+9')])
        self.assertIn('SELFMD: LDA $FFFF,X', result)
        self.assertIn('LMIRR: LDA $FFFF,X', result)
        self.assertIn('IRQREG = TED+9', result)

    def test_missing_include_is_an_error(self):
        with self.assertRaisesRegex(ValueError, 'ambiguous/missing include'):
            flatten({'ROOMS OF PERIL': ['.LIB NOT-HERE*']})

    def test_damaged_disk_chain_is_an_error(self):
        image = D64Image(IMAGE)
        damaged = bytearray(image.data)
        # First directory sector points to itself instead of its next sector.
        offset = sum((21,) * 17) * 256 + 256
        damaged[offset:offset + 2] = bytes((18, 1))
        image.data = bytes(damaged)
        with self.assertRaisesRegex(ValueError, 'Cyclic sector chain'):
            image.files()


if __name__ == '__main__':
    unittest.main()
