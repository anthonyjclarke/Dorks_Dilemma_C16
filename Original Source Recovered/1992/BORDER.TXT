; >s:border
; put "border"
;
prbder
;
; print the border chars on
; the window on the right.
;
;
;
ldx #6
;
prb1
;
lda #203
sta $c20,x          ;* glop char
sta $fb8,x          ;* glop char
sta $db0,x          ;* glop char
sta $ec8,x          ;* glop char
;
lda #$71
sta $820,x
sta $bb8,x
;
dex
bne prb1
;
; now the sides
;
lda #22
sta ty
;
prb2
;
ldx #32
ldy ty
;
jsr xy
;
ldy #0
lda #204
sta (sl),y
;
lda #$71
sta (cl),y
;
ldy #7
lda #204
sta (sl),y
;
lda #$71
sta (cl),y
;
dec ty
bne prb2
;
ldx #205
stx $c20
;
inx
stx $c27
;
inx
stx $f98+32
;
inx
stx $f98+31+8
;
; corner chars on
;
ldx #249
stx $db0
stx $ec8
;
inx
stx $db7
stx $ecf
;
; mid bits
;
rts
;
;
.end
