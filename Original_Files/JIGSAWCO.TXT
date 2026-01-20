; >s:jigsaw-code
; put "jigsaw-code"
;
; jigsaw stuff
;
prpice
;
; print the piece of jigsaw
; in a box in the middle of
; the screen.
;
ldx screen   ;* screen number
lda jignum,x ;* jig piece in room
;
asl a
asl a
asl a
;
tax
ldy #0
;
jig1
;
lda $3eb8,x  ;* char 215-
sta jigbuf,y
;
inx
iny
cpy #8
bne jig1
;
; char data now in 'jigbuf'
;
lda #7
sta count
;
jig2
;
lda count
tay
asl a
tax
;
lda jigbuf,y
;
pha
;
lsr a
lsr a
lsr a
lsr a
jsr xpand
;
sta $3f80,x  ;* char 240-
sta $3f81,x  ;* (double height)
;
pla
;
and #$f
jsr xpand
;
sta $3f90,x  ;* char 242-
sta $3f91,x  ;* double height
;
dec count
bpl jig2
;
ldx #15
;
jig4
;
ldy jigyvl,x
lda jigchr,x
;
sta $dc7-41,y
;
lda jigcol,x
sta $dc7-41-$400,y
;
dex
bpl jig4
;
; now in the centre of the screen
;
rts
;
jigbuf .byte '01234567'
;
jigyvl
;
.byte $00,$01,$02,$03
.byte $28,$29,$2a,$2b
.byte $50,$51,$52,$53
.byte $78,$79,$7a,$7b
;
jigchr
;
.byte 205,203,203,206
.byte 204,240,242,204
.byte 204,241,243,204
.byte 207,203,203,208
;
jigcol
;
.byte $71,$71,$71,$71
.byte $71,$42,$42,$71
.byte $71,$42,$42,$71
.byte $71,$71,$71,$71
;
xpand
;
sta work   ;* save char
;
ldy #3
;
jig3
;
lsr work
php
ror work+1
plp
ror work+1
;
dey
bpl jig3
;
lda work+1
;
rts
;
;
;-----------------------------
;
gotmes
;
; print the message in the empty
; room if the piece has been got
;
lda #6
sta tx
;
lda #11
sta ty
;
lda ted
and #7
ora #$70
sta prcol
;
ldx #0
;
gorme1
;
txa
pha
;
lda gotms,x
;
jsr dubhit   ;* print dbl
;
pla
tax
;
inc tx
;
inx
cpx #19
bne gorme1
;
; now print box
;
; nb x = 19 now
;
gorme2
;
lda #203
sta $d6e+40,x
sta $d6e+160,x
;
dex
bpl gorme2
;
ldx #204
stx $d95+40
stx $d95+80
stx $d95+40+21
stx $d95+80+21
;
; sides now on
;
inx            ;* = 205
stx $d6d+40
inx
stx $d6d+40+21
inx
stx $d6d+160
inx
stx $d6d+160+21
;
; corners on
;
ldx #40
stx $da9+40
inx
stx $da9+80
;
; ! on
;
rts
;
;
gotms
;
;
.byte 'you have this piece'
;
;
;-----------------------------
;
transf
;
; transfer the bit in the middle
; to the jigsaw
;
ldx screen
lda jignum,x
;
clc
adc #215
;
sta stopa
;
; acc=jig char num
;
ldx #0
;
shveit
;
; put it in the next avaliable
; space
;
ldy rady,x
lda $e02,y
;
cmp #27
bne nkip
;
lda stopa      ;* get char
;
sta $e02,y     ;* onto screen
;
jmp eatyre
;
nkip
;
inx
cpx #25
bne shveit
;
eatyre
;
lda #32
sta $dc7
sta $dc7+40
sta $dc8
sta $dc8+40
;
; rub out piece on screen
;
jsr coljig
;
rts
;
;
;
;
.end
