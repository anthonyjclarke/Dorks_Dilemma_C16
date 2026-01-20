; Simple screen test for C16
; Writes "HELLO" to screen to verify screen memory location

.org $1960

start:
    ; Write directly to screen memory
    lda #$08  ; 'H'
    sta $0400
    lda #$05  ; 'E'
    sta $0401
    lda #$0C  ; 'L'
    sta $0402
    lda #$0C  ; 'L'
    sta $0403
    lda #$0F  ; 'O'
    sta $0404

    ; Set colors
    lda #$71  ; White on blue
    sta $0800
    sta $0801
    sta $0802
    sta $0803
    sta $0804

    rts
