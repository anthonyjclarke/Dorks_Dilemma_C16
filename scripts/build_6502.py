#!/usr/bin/env python3
"""
PlatformIO build script for 6502 assembly (C16)
Uses ca65/ld65 from cc65 toolchain
"""

import os
import subprocess
import sys
from pathlib import Path

Import("env")

def get_build_flags():
    """Extract build flags from environment"""
    flags = env.get("BUILD_FLAGS", [])
    defines = {}
    for flag in flags:
        if flag.startswith("-D"):
            parts = flag[2:].split("=")
            if len(parts) == 2:
                defines[parts[0]] = parts[1]
            else:
                defines[parts[0]] = "1"
    return defines

def run_assembler(source_file, output_file, config):
    """Run ca65 assembler"""
    cmd = [
        "ca65",
        "-t", "c16",
        "-g",  # Generate debug info
        "-l", str(output_file).replace(".o", ".lst"),  # Generate listing
        "-o", str(output_file),
        str(source_file)
    ]

    print(f"Assembling: {source_file}")
    print(f"Command: {' '.join(cmd)}")

    result = subprocess.run(cmd, capture_output=True, text=True)

    if result.returncode != 0:
        print("ASSEMBLY FAILED:")
        print(result.stderr)
        sys.exit(1)

    if result.stdout:
        print(result.stdout)

    return output_file

def run_linker(object_files, output_file, config):
    """Run ld65 linker"""
    build_dir = Path(env.subst("$BUILD_DIR"))

    cmd = [
        "ld65",
        "-t", "c16",
        "-o", str(output_file),
        "-Ln", str(build_dir / "labels.txt"),  # Label file
        "-m", str(build_dir / "map.txt"),      # Map file
    ]

    # Add all object files
    cmd.extend([str(f) for f in object_files])

    print(f"Linking: {output_file}")
    print(f"Command: {' '.join(cmd)}")

    result = subprocess.run(cmd, capture_output=True, text=True)

    if result.returncode != 0:
        print("LINKING FAILED:")
        print(result.stderr)
        sys.exit(1)

    if result.stdout:
        print(result.stdout)

    return output_file

def check_tools():
    """Verify that ca65 and ld65 are installed"""
    for tool in ["ca65", "ld65"]:
        try:
            result = subprocess.run([tool, "--version"],
                                  capture_output=True, text=True)
            if result.returncode == 0:
                print(f"Found {tool}: {result.stdout.split()[0]}")
        except FileNotFoundError:
            print(f"ERROR: {tool} not found!")
            print("Please install cc65:")
            print("  macOS: brew install cc65")
            print("  Linux: sudo apt install cc65")
            sys.exit(1)

def build_main(source, target, env):
    """Main build function called by PlatformIO"""
    check_tools()

    config = get_build_flags()
    build_dir = Path(env.subst("$BUILD_DIR"))
    source_dir = Path(env.subst("$PROJECT_SRC_DIR"))

    # Find main.s
    main_source = source_dir / "main.s"
    if not main_source.exists():
        print(f"ERROR: Source file not found: {main_source}")
        sys.exit(1)

    # Output files
    object_file = build_dir / "main.o"
    program_file = build_dir / "dorks_dilemma.prg"

    # Create build directory
    build_dir.mkdir(parents=True, exist_ok=True)

    # Assemble
    run_assembler(main_source, object_file, config)

    # Link
    run_linker([object_file], program_file, config)

    # Copy to project root for easy access
    import shutil
    output_prg = Path(env.subst("$PROJECT_DIR")) / "dorks_dilemma.prg"
    shutil.copy(program_file, output_prg)

    print(f"\n✓ Build successful!")
    print(f"  Output: {output_prg}")
    print(f"  Size: {output_prg.stat().st_size} bytes")
    print(f"  Labels: {build_dir / 'labels.txt'}")
    print(f"  Map: {build_dir / 'map.txt'}")

    return program_file

# Register the custom build
env.Replace(PROGNAME="dorks_dilemma")
env.Replace(PROGPATH=env.subst("$BUILD_DIR/dorks_dilemma.prg"))

# Override default build
env.Replace(
    BUILDERS=dict(
        Program=Builder(
            action=build_main,
            suffix=".prg"
        )
    )
)
