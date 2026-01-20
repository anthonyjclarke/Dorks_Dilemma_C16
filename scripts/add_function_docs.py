#!/usr/bin/env python3
"""
Add meaningful documentation headers to major subroutines
Based on code analysis and original comments
"""

import re

# Function documentation based on code analysis
FUNCTION_DOCS = {
    'play': '''
; ------------------------------------------------------------------------------
; PLAY - Main Game Initialization and Setup
; ------------------------------------------------------------------------------
; Initializes the game state, sets up player position, configures hardware,
; and prepares all game systems before entering the main game loop.
; Called at game start.
''',
    'loop': '''
; Main game loop - runs continuously during gameplay
; Checks for death, processes commands, handles bomb explosions,
; room transitions, radar updates, and alien movement
''',
    'redjos': '''
; ------------------------------------------------------------------------------
; REDJOS - Read Joystick Input
; ------------------------------------------------------------------------------
; Reads joystick input from port 0 or 1, or falls back to keyboard.
; Sets directional flags (jleft, jright, jup, jdown, jfire) and jmove.
; Auto-detects which port has an active joystick.
''',
    'key': '''
; Keyboard input handler - called when no joystick detected
; Scans keyboard for cursor keys and space bar
; Sets same flags as joystick for consistent control handling
''',
    'setirq': '''
; ------------------------------------------------------------------------------
; SETIRQ - Initialize Interrupt System
; ------------------------------------------------------------------------------
; Sets up raster interrupts for:
; - Screen split (play area vs message area)
; - Character animation timing
; - Alien movement timing
; - Random number generation
''',
    'serv': '''
; IRQ service routine - main interrupt handler
; Saves state, dispatches to rast1 or rast2 based on raster position
; Handles all time-critical operations during vertical blank
''',
    'rast1': '''
; Raster interrupt 1 - Main play area (multicolor mode)
; Sets up TED chip for game graphics
; Calls animation and random number routines
''',
    'rast2': '''
; Raster interrupt 2 - Message area (38 columns)
; Scrolls message text, reads joystick/keyboard
; Updates bomb timer, prints aliens, moves player
''',
    'random': '''
; ------------------------------------------------------------------------------
; RANDOM - Random Number Generator
; ------------------------------------------------------------------------------
; Generates pseudo-random numbers using TED chip timers and shift operations
; Updates 4-byte rnd buffer, used for alien AI and game randomization
''',
    'delay': '''
; Simple delay loop - waits for specified time
; X register = outer loop count
; Y register = inner loop count (256 iterations)
''',
    'clvars': '''
; ------------------------------------------------------------------------------
; CLVARS - Clear Variables
; ------------------------------------------------------------------------------
; Zeros out all zero-page variables ($00-$FF)
; Called at game init and reset
''',
    'clswin': '''
; ------------------------------------------------------------------------------
; CLSWIN - Clear Game Window
; ------------------------------------------------------------------------------
; Clears the 30x22 character game play area
; Fills with base character (196) and color ($71)
''',
    'xy': '''
; ------------------------------------------------------------------------------
; XY - Calculate Screen Position
; ------------------------------------------------------------------------------
; Converts X,Y coordinates to screen and color RAM pointers
; Input: X = column (0-39), Y = row (0-24)
; Output: sl = screen address, cl = color address
''',
    'copybm': '''
; Copy complete bomb character data
; Copies 32 bytes from $3FA0 to $3960
; Required for bomb animation/explosion graphics
''',
    'messve': '''
; ------------------------------------------------------------------------------
; MESSVE - Message Scrolling
; ------------------------------------------------------------------------------
; Scrolls the bottom message text one pixel to the left
; Fetches next character when needed, wraps to start at $FF marker
''',
    'setup': '''
; ------------------------------------------------------------------------------
; SETUP - TED Chip Initialization
; ------------------------------------------------------------------------------
; Configures TED chip for game:
; - Character set from RAM at $3800 (2KB multicolor)
; - 256 characters, multicolor mode
; - Seeds random number generator from timer values
; - Sets background colors
''',
    'decode': '''
; ------------------------------------------------------------------------------
; DECODE - Screen Decompression
; ------------------------------------------------------------------------------
; Decompresses room screen data from compressed format to screen buffer
; Input: screen = room number (0-24)
; Output: scrbuf filled with decompressed room layout
; Uses custom RLE-style compression (4 chars per byte)
; Mirrors left half to right half for symmetry
; Adds doors based on doordt table
''',
    'movemn': '''
; ------------------------------------------------------------------------------
; MOVEMN - Move Player Character
; ------------------------------------------------------------------------------
; Main player movement handler:
; - Prints player at new position
; - Processes movement input
; - Checks collisions
; - Handles death and room transitions
; - Updates pixel-level positioning
''',
    'print': '''
; Print player character at current position
; Handles pixel-offset animation (4 positions per character)
; Erases old position, draws new position with proper facing direction
''',
    'mnmove': '''
; Process player movement input
; Reads jleft/jright/jup/jdown flags
; Updates player position (manx, many)
; Handles diagonal movement conversion
; Sets pixel offset for smooth scrolling
''',
    'uppixe': '''
; Update pixel position for smooth character movement
; Increments xpix or ypix based on direction
; Wraps to next character position when reaching 4 pixels
''',
    'check': '''
; ------------------------------------------------------------------------------
; CHECK - Collision Detection
; ------------------------------------------------------------------------------
; Checks if player can move to specified position
; Tests for walls, doors, aliens, jigsaw pieces
; Input: X = chkx, Y = chky
; Output: hit flag (0=OK, non-zero=collision type)
''',
    'death': '''
; Handle player death sequence
; Checks collision type, decrements lives
; Triggers death animation if killed
''',
    'chgrom': '''
; ------------------------------------------------------------------------------
; CHGROM - Change Room Handler
; ------------------------------------------------------------------------------
; Detects when player reaches screen edge
; Sets up transition to adjacent room in 5x5 grid
; Updates xpos/ypos (grid position)
; Sets newrom flag for main loop to process
''',
    'mveali': '''
; ------------------------------------------------------------------------------
; MVEALI - Move Aliens
; ------------------------------------------------------------------------------
; AI system for all active aliens in current room
; Uses pattern-based movement from variety table
; Checks collisions, updates positions
; Tempo-controlled for difficulty scaling
''',
    'prnals': '''
; Print all aliens at their current positions
; Uses character animation from alibuf
; Handles alien sprite cycling
''',
    'upbomb': '''
; ------------------------------------------------------------------------------
; UPBOMB - Update Bomb Timer
; ------------------------------------------------------------------------------
; Decrements bomb timer each frame
; Triggers explosion when timer reaches zero
; Handles bomb recharge delay
''',
    'bomb': '''
; Initiate bomb placement
; Checks if bomb is ready (bready flag)
; Sets bomb position at player location
; Starts countdown timer
''',
    'basbom': '''
; BASIC bomb explosion handler
; Called from main loop when bombgo flag set
; Triggers actual explosion effect
''',
    'explod': '''
; Bomb explosion effect
; Area-fill from bomb position
; Changes characters to explosion pattern
; Damages player if in blast radius
''',
    'radar': '''
; ------------------------------------------------------------------------------
; RADAR - Update Mini-Map Display
; ------------------------------------------------------------------------------
; Updates 5x5 room grid radar display
; Shows current position, visited rooms, jigsaw locations
; Updates radbuf with current state
''',
    'scater': '''
; ------------------------------------------------------------------------------
; SCATER - Scatter Jigsaw Pieces
; ------------------------------------------------------------------------------
; Randomizes jigsaw piece placement across 25 rooms
; Ensures no duplicates, one piece per room
; Initializes gotbit array (collection flags)
''',
    'rooms': '''
; Initialize room randomization
; Sets up romnum array for screen data mapping
; Prepares door configuration
''',
    'animat': '''
; ------------------------------------------------------------------------------
; ANIMAT - Animate Characters
; ------------------------------------------------------------------------------
; Cycles animated characters (water, fire, etc.)
; Updates character definitions in RAM
; Tempo-controlled for smooth animation
''',
    'deadck': '''
; Check if player died during last frame
; Processes death sequence if dead flag set
; Decrements lives, resets player position
''',
    'comand': '''
; Command/debug menu handler
; Checks for ESC key press
; Enters edit/debug mode if triggered
''',
    'roomon': '''
; Bring on new room after transition
; Decodes new screen data
; Initializes aliens for new room
; Updates display
''',
}

def add_function_docs(input_file, output_file):
    with open(input_file, 'r') as f:
        lines = f.readlines()

    output = []
    i = 0

    while i < len(lines):
        line = lines[i].rstrip()

        # Check if this line is a function label (starts at column 0, ends with nothing)
        if line and not line[0].isspace() and line.strip() in FUNCTION_DOCS:
            func_name = line.strip()
            doc = FUNCTION_DOCS[func_name].strip()

            # Add documentation before the function
            for doc_line in doc.split('\n'):
                output.append(doc_line)

        output.append(line)
        i += 1

    # Write output
    with open(output_file, 'w') as f:
        for line in output:
            f.write(line + '\n')

    print(f"Added documentation for {len(FUNCTION_DOCS)} functions")
    print(f"Output: {len(output)} lines")

if __name__ == '__main__':
    import sys
    if len(sys.argv) != 3:
        print("Usage: add_function_docs.py <input> <output>")
        sys.exit(1)

    add_function_docs(sys.argv[1], sys.argv[2])
