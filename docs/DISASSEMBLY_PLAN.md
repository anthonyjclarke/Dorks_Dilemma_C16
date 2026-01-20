# Plan: Locate Missing Functions via Disassembly

**Objective:** Find and reverse-engineer `fillex` and `chkbmb` from the working DORKSDIL.BIN

**Status:** Ready to execute

## Missing Functions Summary

### 1. fillex
- **Reference:** Line 3221 in src/main.s (`bne fillex`)
- **Context:** Bomb explosion fill routine
- **Type:** Branch target (local label or subroutine)
- **Expected location:** Near bomb explosion code

### 2. chkbmb
- **References:** Lines 3163, 3185, 3206 (`jsr chkbmb`)
- **Context:** Check bomb collision/placement
- **Type:** Subroutine (JSR indicates it's a callable function)
- **Expected location:** Could be anywhere in the binary

## Approach: Multi-Method Disassembly

We'll use three complementary methods to locate the functions:

### Method 1: VICE Monitor (Interactive)
**Best for:** Real-time exploration and verification

```bash
# Launch VICE with monitor
/usr/local/Cellar/vice/3.10/bin/xplus4 -moncommands monitor_init.txt DORKSDIL.BIN

# In VICE monitor:
l 1960 19ff    # Disassemble from program start
d 1960 19ff    # Hex dump to verify
```

**Advantages:**
- Interactive exploration
- Can trace execution
- Can set breakpoints to find runtime behavior
- Built-in label tracking

### Method 2: da65 Disassembler (Automated)
**Best for:** Complete code listing with labels

```bash
# Install cc65 if needed
brew install cc65

# Create info file for better disassembly
cat > dorks.info <<EOF
LABEL { NAME "START"; ADDR $1960; };
RANGE { START $1960; END $4FFF; TYPE Code; };
RANGE { START $0002; END $009F; TYPE ByteTable; COMMENT "Zero Page Variables"; };
RANGE { START $0200; END $02FF; TYPE ByteTable; COMMENT "System Tables"; };
RANGE { START $0400; END $07BF; TYPE ByteTable; COMMENT "Screen Buffer"; };
RANGE { START $3800; END $3FFF; TYPE ByteTable; COMMENT "Character Set"; };
EOF

# Disassemble with info file
da65 --cpu 6502 --start-addr 0x1960 --info dorks.info DORKSDIL.BIN > dorksdil_disasm.s

# Search for patterns
grep -n "fillex" dorksdil_disasm.s
grep -n "chkbmb" dorksdil_disasm.s
```

**Advantages:**
- Produces complete assembly listing
- Generates labels automatically
- Can specify known addresses
- Output is assembler-ready

### Method 3: Python Disassembler Script
**Best for:** Targeted search and analysis

```python
#!/usr/bin/env python3
"""
Find missing functions in DORKSDIL.BIN by analyzing branch/jump targets
"""

def load_binary(filename, load_addr=0x1960):
    with open(filename, 'rb') as f:
        data = f.read()
    return {load_addr + i: byte for i, byte in enumerate(data)}

def find_jsr_targets(memory, start, end):
    """Find all JSR targets (potential subroutines)"""
    targets = set()
    addr = start
    while addr < end:
        if memory.get(addr) == 0x20:  # JSR opcode
            # JSR is 3 bytes: opcode, low byte, high byte
            lo = memory.get(addr + 1, 0)
            hi = memory.get(addr + 2, 0)
            target = (hi << 8) | lo
            targets.add(target)
            addr += 3
        else:
            addr += 1
    return sorted(targets)

def find_branch_targets(memory, start, end):
    """Find all branch targets (BNE, BEQ, etc.)"""
    branch_ops = {0x10, 0x30, 0x50, 0x70, 0x90, 0xB0, 0xD0, 0xF0}  # BPL, BMI, BVC, BVS, BCC, BCS, BNE, BEQ
    targets = set()
    addr = start
    while addr < end:
        if memory.get(addr) in branch_ops:
            offset = memory.get(addr + 1, 0)
            # Convert to signed offset
            if offset > 127:
                offset = offset - 256
            target = addr + 2 + offset
            targets.add((addr, target))
            addr += 2
        else:
            addr += 1
    return targets

# Usage:
memory = load_binary('DORKSDIL.BIN')
jsr_targets = find_jsr_targets(memory, 0x1960, 0x5000)
branch_targets = find_branch_targets(memory, 0x1960, 0x5000)

print(f"Found {len(jsr_targets)} JSR targets")
print(f"Found {len(branch_targets)} branch targets")
```

## Step-by-Step Execution Plan

### Step 1: Identify Reference Addresses in Current Source

First, we need to know what addresses correspond to lines 3163, 3185, 3206, and 3221 in the assembled code.

```bash
# Assemble current source with listing
ca65 -l src/main.lst src/main_ca65.s -o build/main.o -t c16

# Check listing for addresses of missing references
grep -n "chkbmb" src/main.lst
grep -n "fillex" src/main.lst
```

This will show us the actual memory addresses where these calls occur.

### Step 2: Disassemble DORKSDIL.BIN

```bash
# Method A: Use da65 with smart labels
da65 --cpu 6502 --start-addr 0x1960 DORKSDIL.BIN > disasm_full.s

# Method B: Use VICE monitor commands
cat > vice_commands.txt <<EOF
l 1960 5000
quit
EOF

xplus4 -moncommands vice_commands.txt DORKSDIL.BIN > vice_disasm.txt 2>&1
```

### Step 3: Locate Functions by Cross-Reference

#### For chkbmb (JSR target):

```bash
# Find JSR instructions in disassembly around the reference addresses
# If line 3163 assembles to address $2A50, look for:
grep -A2 -B2 "2A50" disasm_full.s

# Look for the JSR target address
# Example: JSR $xxxx - we need to find what's at $xxxx
```

#### For fillex (BNE target):

```bash
# Find BNE instructions near line 3221's address
# If line 3221 is at $2B10, look for:
grep -A5 -B5 "2B10" disasm_full.s

# The BNE target will be a relative offset
# Calculate: target = current_addr + 2 + signed_offset
```

### Step 4: Extract Function Code

Once we locate the functions in the disassembly:

1. **Identify function boundaries:**
   - Start: Label or first instruction after JSR/branch
   - End: RTS (for subroutines) or next known label (for inline code)

2. **Copy the disassembled code**

3. **Add context comments:**
   - What registers are used
   - What memory locations are accessed
   - Purpose based on context

### Step 5: Integrate into Source

```bash
# Create a new file for the found routines
cat > src/missing_routines.s <<EOF
; ------------------------------------------------------------------------------
; CHKBMB - Check Bomb Collision/Placement
; ------------------------------------------------------------------------------
; Found via disassembly at address $xxxx
; Called from bomb placement logic
;
; Inputs:
;   (TBD based on analysis)
; Outputs:
;   (TBD based on analysis)
; ------------------------------------------------------------------------------
chkbmb:
    ; ... disassembled code ...
    rts

; ------------------------------------------------------------------------------
; FILLEX - Fill Explosion Area
; ------------------------------------------------------------------------------
; Found via disassembly at address $xxxx
; Used in bomb explosion routine
;
; Inputs:
;   (TBD based on analysis)
; Outputs:
;   (TBD based on analysis)
; ------------------------------------------------------------------------------
fillex:
    ; ... disassembled code ...
    ; (may not have RTS if it's inline code)
EOF
```

### Step 6: Verify Integration

```bash
# Reassemble with found functions
cat src/main.s src/missing_routines.s > src/main_complete.s
python3 scripts/convert_to_ca65_final.py src/main_complete.s build/main_complete_ca65.s

# Assemble
ca65 build/main_complete_ca65.s -o build/dorks_complete.o -t c16

# Should now have 0 undefined symbols!
ld65 build/dorks_complete.o -o build/dorks_complete.prg -t c16

# Test
/usr/local/Cellar/vice/3.10/bin/xplus4 build/dorks_complete.prg
```

## Tools We'll Use

### 1. da65 (CC65 Disassembler)
- **Purpose:** Create complete assembly listing
- **Command:** `da65 --cpu 6502 --start-addr 0x1960 DORKSDIL.BIN`
- **Output:** Full assembly source with auto-generated labels

### 2. VICE Monitor
- **Purpose:** Interactive exploration and verification
- **Commands:**
  - `l <addr> <end>` - Disassemble range
  - `d <addr> <end>` - Hex dump
  - `break <addr>` - Set breakpoint
  - `g` - Go (run)
  - `r` - Show registers

### 3. hexdump/xxd
- **Purpose:** View raw binary data
- **Command:** `xxd -s 0x1960 -l 1000 DORKSDIL.BIN`

### 4. Python Script (Custom)
- **Purpose:** Automated pattern matching and analysis
- **Features:**
  - Find all JSR targets
  - Find all branch targets
  - Identify potential subroutines
  - Cross-reference with source

## Expected Outcomes

### Scenario 1: Functions are in DORKSDIL.BIN
✅ **Best case** - We find both functions, integrate them, achieve 100% assembly

### Scenario 2: Functions are inline code
⚠️ **Likely for fillex** - The "BNE fillex" might just branch to nearby code that was already assembled but the label was lost. We rename existing code.

### Scenario 3: Functions are stubs
⚠️ **Possible** - Functions might be minimal (just RTS) if features were disabled

### Scenario 4: Functions are in separate binary
❌ **Unlikely** - All code should be in DORKSDIL.BIN since it's the complete game

## Success Criteria

1. ✅ Locate both `fillex` and `chkbmb` in disassembly
2. ✅ Understand their purpose from context
3. ✅ Extract clean assembly code
4. ✅ Integrate into source with documentation
5. ✅ Achieve 100% assembly (0 undefined symbols)
6. ✅ Verify assembled binary runs identically to original

## Next Steps

Ready to execute! We should start with:

1. **Create da65 info file** with known addresses from our source
2. **Run da65** on DORKSDIL.BIN
3. **Analyze the disassembly** to locate the missing functions
4. **Extract and document** the found code
5. **Integrate and test**

Would you like me to proceed with the disassembly?
