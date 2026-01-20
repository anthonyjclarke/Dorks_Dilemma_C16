# Assembly Error Report - ca65 Compilation

## Summary

Attempted to assemble the reformatted source with ca65. Found several syntax incompatibilities that need addressing.

## Error Categories

### 1. Macro Invocation Misidentified as Label
**Error:** Line 769
```
dpinc:
```

**Issue:** The converter added a colon to `dpinc mesl`, treating the macro call as a label.

**Fix Needed:** Macro calls should not be treated as labels. Need to recognize `.macro` names.

### 2. String Literal Syntax  
**Errors:** Lines 2847, 3506, 3637, 4823-4826

**Issue:** Original uses single quotes for strings:
```asm
.byte 'you have this piece'
.byte '000100  gremlin '
```

**ca65 requires double quotes:**
```asm
.byte "you have this piece"
.byte "000100  gremlin "
```

### 3. Anonymous Label Syntax
**Error:** Line 4426

**Issue:** Anonymous labels `:+` and `:-` in macros may need adjustment.

## Current Error Count

- **Total errors:** ~24
- **Macro issues:** 2
- **String literal issues:** ~20
- **Other syntax:** ~2

## Files Generated

- `src/main_ca65.s` - Partially converted source
- `src/main_ca65.lst` - Assembly listing (partial)
- `src/assembly_errors.txt` - Full error output

## Required Fixes

### High Priority
1. ✅ Convert `*=` to `.org`
2. ✅ Convert `*=*+n` to `.res n`
3. ✅ Add colons to labels
4. ❌ **Don't add colons to macro invocations**
5. ❌ **Convert single quotes to double quotes in .byte strings**

### Medium Priority
6. Handle character constants properly
7. Verify anonymous label syntax in macros

## Next Steps

1. Update converter to recognize macro names (dpinc, dpdec)
2. Convert all single-quoted strings to double-quoted
3. Verify anonymous labels in macro expansions
4. Re-assemble and check for remaining errors

## Source Code Quality

**Good news:** Only ~24 errors in 4,829 lines (~0.5% error rate)

This indicates the original source code is syntactically sound. All errors are purely syntax format differences between the original custom assembler and ca65.

