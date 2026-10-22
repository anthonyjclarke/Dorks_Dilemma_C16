# Dork's Dilemma – Modification and Porting Guide

## What This Guide Provides

This guide is for changing the game or building it again on another platform. The [Codebase Analysis](../CODEBASE_ANALYSIS.md) explains how the restored game works; this guide covers what to keep stable while you change it. The authentic restoration build stays the reference, and nothing here changes it.

---

## Modifying the C16 Game

### Establish a Development Source Tree

The restoration pipeline reads the image and the explicit fallback files, regenerates `build/recovered-c16.s`, and rejects any difference from the reference. It deliberately has no mode for building a modified game. Changes made only to generated files get overwritten, and the earlier consolidated source (now outside the repository) never fed this pipeline.

The next step is to create a versioned working source tree with its own target, copied from the resolved original modules and keeping their provenance. A proposed location is `versions/<name>/source/`, but neither the directory nor the target exists yet. Keep the recovered inputs and the current baseline command, so later changes can still be compared with the authentic game.

The new target should accept intentional differences and report them, while the restoration target keeps requiring equality with the reference. It also has to deal with code growth and memory layout. This is proposed work, and `restore_c16.py` doesn't offer it today.

### Choose a Focused First Change

| Intended change       | Start here                          |
| --------------------- | ----------------------------------- |
| Controls              | `KEY-SCAN`, `JOYSTIK`               |
| Title options         | `ALTERABLES`, `MAGNIFICENT`         |
| Message text          | `WHOOPPEE-MESSAGE`, `MESSAGE-STUFF` |
| Room layouts          | `MUFF`, `DECODER`, `INIT-ROOMS`     |
| Doors and transitions | `DOORDT`, `CHANGE-ROOM`             |
| Player movement       | `MOVE-PIXEL`, `CHECK-MAN`           |
| Bomb behaviour        | `BOMB-CODE`, `FILLER-BOMB`          |
| Enemy movement        | `ALIENS-MEGA/CODE`                  |
| Difficulty            | `LEVEL-INCREASE`                    |
| Jigsaw rules          | `JIGSAW-CODE`, `SCATTER`            |
| Score and names       | `SCORE-ROUTINES`, `WORK-HIGH`       |
| Animation             | `ANIMATE-CHARS`, `VARIETY`          |
| Timing and scheduling | `IRQ`, `RASTER-ROUTINES`, `UTILS`   |

Changing text or existing data is a good way to learn the assembly and packaging path, as long as you understand its encoding and the space allocated for it. A control change starts with `KEY-SCAN` and the shared input flags. A difficulty change starts with `LEVEL-INCREASE` and the routines that use its values.

Room, graphics, enemy, and bomb changes reach into more modules. Trace their state, rendering, and collision dependencies before you start, and write down the behaviour you mean to change and how you'll see it.

### Preserve Assembly Assumptions

The decoder modifies instruction operands at runtime. Register constants have to stay equates, and instructions after labels have to survive conversion. Those were the concrete causes of the earlier restoration failure.

A call such as `JSR DELAY+2` enters the middle of a routine, so changing its first instruction can break its callers. Absolute addresses, zero-page pointer pairs, character-number conventions, and interrupt-owned state need the same care. For the original target, keep checking the listing and map as well as testing behaviour.

### Validate Deliberate Changes

Keep `make test` and the authentic build as baseline checks. A modified target should add checks for the change you intended, and shouldn't expect its complete PRG to match the original. Where a comparison still makes sense, compare the unchanged routines or data.

Use VICE breakpoints and screenshots to check initialization and rendering, then exercise the affected mechanics with real input. The scripted-fire check only shows that the game reaches gameplay. It isn't enough evidence for movement, bombs, room transitions, or a new input mapping. See [Testing](../TESTING.md).

---

## Developing Versions for New Platforms

### Carry Forward Rules and Data

The parts worth carrying over are the logical room grid, the room-to-layout and jigsaw mappings, movement and collision rules, enemy state, bomb behaviour, progression, scoring, and the game-state transitions. They could form a portable model, but the original assembly mixes them with display and hardware access, and the repository has no platform-independent engine yet.

Start by writing those rules down from the working source and watching how the baseline behaves in typical situations. Decide how the new version will represent positions, timers, randomness, and object state before you pick a renderer or replace the update loop.

### Replace Hardware Responsibilities Explicitly

| Original responsibility | New-platform responsibility            |
| ----------------------- | -------------------------------------- |
| TED register writes     | Display and audio backend              |
| Raster interrupt work   | Defined update order and timing        |
| Keyboard/joystick scan  | Host input mapped to game actions      |
| Character-memory edits  | Mutable glyphs or equivalent animation |
| Screen/attribute writes | Tile and colour representation         |
| Hardware-seeded RNG     | Defined seeding and random sequence    |
| KERNAL/monitor calls    | Host startup and text facilities       |
| Busy-wait delays        | Explicit timers or scheduled updates   |

A port should keep the relationship between foreground logic and interrupt-driven work. Matching a frame rate doesn't reproduce the original order of events. A fixed clock and seed make it easier to compare room setup, movement, and enemy behaviour while you develop.

### Decide What the New Version Changes

Say which you're after: the original behaviour on a new backend, an enhanced edition, or a redesign that reuses the original rules and assets. Any change to resolution, aspect ratio, controls, difficulty, randomness, or timing should be deliberate and testable.

For a port, byte equality is no longer the right test. Compare the observable rules and state transitions, use reference captures where the presentation should match, and test the new platform's input, audio, and display on their own. Keep the original credits, and keep recovered assets distinct from newly made material.

This project hasn't picked a destination platform or started a port. The architecture above is a guide for that future work, and no port exists yet.
