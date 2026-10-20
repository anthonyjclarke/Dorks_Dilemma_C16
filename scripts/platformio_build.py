"""Use the same verified C16 restoration pipeline as build.sh and make."""

import subprocess
import sys
from pathlib import Path

from SCons.Script import Default, DefaultEnvironment

env = DefaultEnvironment()

root = Path(env.subst("$PROJECT_DIR"))
build = Path(env.subst("$BUILD_DIR"))
dependencies = [
    root / "scripts/restore_c16.py",
    root / "scripts/d64_image.py",
    root / "config/c16.cfg",
    root / "Dorks-Dilemma-C16-2026-FullDiskCopy/Dorks-Dilemma-C16.d64",
    root / "Original_Files/DORKSDIL.BIN",
] + [root / "Original_Files" / name for name in
     ("ALIENCHE.TXT", "ALIENSME.TXT", "RASTERRO.TXT", "WHOOPPEE.TXT")]


def assemble(source, target, env):
    subprocess.run([sys.executable, str(root / "scripts/restore_c16.py"),
                    "--build-dir", str(build)], check=True, cwd=str(root))


def launch(source, target, env):
    subprocess.run([sys.executable, str(root / "scripts/run_vice.py"),
                    str(build / "dorks.prg")], check=True, cwd=str(root))


program = env.Command(str(build / "dorks.prg"), [str(p) for p in dependencies],
                      env.VerboseAction(assemble, "Assembling and verifying recovered C16 source"))
env.Replace(PROGNAME="dorks", PROGPATH=str(build / "dorks.prg"))
env.Alias("buildprog", program)
env.AddCustomTarget("upload", program, env.VerboseAction(launch, "Launching C16 in VICE"),
                    title="Run in VICE", description="Run the restored PRG on an emulated C16")
Default(program)
