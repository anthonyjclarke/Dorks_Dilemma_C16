; Find where the screen actually is on Plus/4
; This uses BASIC ROM call to print, which we know works

.segment "CODE"
.org $1960

start:
    ; Print a message using BASIC ROM to verify location
    lda #$93        ; CLR/HOME
    jsr $ffd2

    ; Print "TEST" using BASIC ROM calls
    lda #$54        ; 'T'
    jsr $ffd2
    lda #$45        ; 'E'
    jsr $ffd2
    lda #$53        ; 'S'
    jsr $ffd2
    lda #$54        ; 'T'
    jsr $ffd2

    ; Now try to write at various screen locations
    ; Try $0400 (C64 location)
    lda #$01        ; Screen code for 'A'
    sta $0400

    ; Try $0C00 (Plus/4 default)
    lda #$02        ; Screen code for 'B'
    sta $0c00

    ; Try $1000 (alternate)
    lda #$03        ; Screen code for 'C'
    sta $1000

    rts
