; macros.s - ca65 converted macros for Dork's Dilemma
; Original: MACROS.TXT (custom ASMC64 assembler)
; Converted for cc65/ca65 toolchain
;
; dpinc - 16-bit increment of zero page pointer
; dpdec - 16-bit decrement of zero page pointer

.macro dpinc addr
    inc addr
    bne :+
    inc addr+1
:
.endmacro

.macro dpdec addr
    lda addr
    sec
    sbc #1
    sta addr
    lda addr+1
    sbc #0
    sta addr+1
.endmacro
