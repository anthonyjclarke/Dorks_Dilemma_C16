#!/usr/bin/env python3
"""Read a standard 1541 D64 image without modifying the disk image."""

from dataclasses import dataclass
from pathlib import Path


SECTORS = (0,) + (21,) * 17 + (19,) * 7 + (18,) * 6 + (17,) * 5
FILE_TYPES = {0: "DEL", 1: "SEQ", 2: "PRG", 3: "USR", 4: "REL"}


@dataclass(frozen=True)
class DiskFile:
    name: str
    kind: str
    data: bytes
    blocks: int
    closed: bool


class D64Image:
    def __init__(self, path):
        self.path = Path(path)
        self.data = self.path.read_bytes()
        if len(self.data) not in (174848, 175531):
            raise ValueError("Expected a 35-track D64, optionally with an error map")

    def sector(self, track, sector):
        if not 1 <= track <= 35 or not 0 <= sector < SECTORS[track]:
            raise ValueError(f"Invalid sector {track}/{sector}")
        index = sum(SECTORS[:track]) + sector
        if len(self.data) == 175531 and self.data[174848 + index] != 1:
            raise ValueError(f"Disk error map flags sector {track}/{sector}")
        offset = index * 256
        return self.data[offset:offset + 256]

    def chain(self, track, sector):
        visited = set()
        while track:
            address = (track, sector)
            if address in visited:
                raise ValueError(f"Cyclic sector chain at {track}/{sector}")
            visited.add(address)
            block = self.sector(track, sector)
            yield block
            track, sector = block[:2]

    def files(self):
        files = []
        for directory in self.chain(18, 1):
            for offset in range(0, 256, 32):
                entry = directory[offset:offset + 32]
                file_type = entry[2]
                if not file_type or not entry[3]:
                    continue
                name = entry[5:21].rstrip(b"\xa0").decode("ascii")
                kind = FILE_TYPES.get(file_type & 7)
                if kind not in ("SEQ", "PRG"):
                    raise ValueError(f"Unsupported file type {file_type}: {name}")
                data = bytearray()
                count = 0
                for block in self.chain(entry[3], entry[4]):
                    count += 1
                    if block[0]:
                        data.extend(block[2:])
                    else:
                        if not 1 <= block[1] <= 255:
                            raise ValueError(f"Invalid final sector length for {name}")
                        data.extend(block[2:1 + block[1]])
                blocks = int.from_bytes(entry[30:32], "little")
                if blocks != count:
                    raise ValueError(f"Block count mismatch for {name}: {blocks} != {count}")
                if any(file.name == name for file in files):
                    raise ValueError(f"Duplicate disk filename: {name}")
                files.append(DiskFile(name, kind, bytes(data), blocks, bool(file_type & 128)))
        return files
