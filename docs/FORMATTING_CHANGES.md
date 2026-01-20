# Source Code Formatting Changes

## Summary
Reformatted [src/main.s](../src/main.s) for consistency and readability.

**Lines:** 7,496 → 7,448 (48 lines removed)

## Changes Applied

### 1. Blank Lines
- **Before:** Up to 9 consecutive blank lines in some sections
- **After:** Maximum 1 consecutive blank line
- **Impact:** Removed 48 unnecessary blank lines

### 2. Comment Formatting
**Comment-only lines:**
- Standardized to `; comment text` format
- Single space after semicolon
- Removed excessive leading semicolons

**Inline comments:**
- Preserved `;*` marker for original comments
- Format: `code ;* comment` or `code ; comment`
- Single space before and after comment marker

### 3. Section Dividers
**Preserved as-is:**
```asm
; ==============================================================================
; SECTION NAME
; ==============================================================================

; ------------------------------------------------------------------------------
; MODULE: NAME
; ------------------------------------------------------------------------------
```

### 4. Whitespace
- **Removed:** All trailing whitespace
- **Preserved:** Indentation for code (tabs/spaces as original)
- **Preserved:** Alignment in variable declarations

### 5. Code Structure
**Zero page variables:**
```asm
mesl   *=*+2 ;* message pointer
messx  *=*+1 ;* mess. pixel
lives  *=*+1 ;* # of lives
```

**Code blocks:**
```asm
play
;
sei
;
jsr clvars ;* clear vars
```

## Benefits

1. **Consistency:** All comments follow same format
2. **Readability:** Reduced visual clutter
3. **File Size:** 48 lines smaller (0.6% reduction)
4. **Maintainability:** Easier to navigate and edit
5. **Compatibility:** No functional changes, assembly logic preserved

## Files

- **Original backup:** [src/main.s.bak](../src/main.s.bak)
- **Reformatted:** [src/main.s](../src/main.s)
- **Script:** [scripts/reformat_asm.py](../scripts/reformat_asm.py)

## Script Usage

To reformat other assembly files:

```bash
python3 scripts/reformat_asm.py input.s output.s
```

## Verification

The reformatted code preserves:
- All instruction mnemonics
- All labels and addresses
- All data declarations
- All macro definitions
- Original comment content

Only formatting and whitespace changed.
