; Screen test for Plus/4
; Writes "HELLO WORLD" to screen at $0C00 (Plus/4 default)

.segment "CODE"
.org $1960

start:
    ; Clear screen first
    lda #$93        ; CLR/HOME character
    jsr $ffd2       ; CHROUT

    ; Write directly to Plus/4 screen memory at $0C00
    ldx #0
loop:
    lda message,x
    beq done        ; Stop at null terminator
    sta $0c00,x     ; Write to screen
    lda #$71        ; White on blue
    sta $0800,x     ; Write to color RAM
    inx
    jmp loop

done:
    rts

message:
    .byte $08, $05, $0c, $0c, $0f  ; "HELLO"
    .byte $20                       ; Space
    .byte $17, $0f, $12, $0c, $04  ; "WORLD"
    .byte $00                       ; Null terminator
