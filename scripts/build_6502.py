"""Select the custom assembly builder before PlatformIO's native builder runs."""

from pathlib import Path

Import("env")

env.Replace(BUILD_SCRIPT=str(Path(env.subst("$PROJECT_DIR")) / "scripts/platformio_build.py"))
