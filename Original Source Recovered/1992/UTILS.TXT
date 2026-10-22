; >s:utils
; put "utils"
;
;**************************
;
;        utilities
;
;**************************
;
random
;
lda ted
and rnd+2
adc ted+2
asl a
asl a
rol rnd+3
rol rnd+2
rol rnd+1
rol rnd
;
; ^ acornsoft rnd#
;
clc
ldy #$29
ldx #$fc
;
ranlop
;
tya
ldy rnd+4,x
adc rnd+4,x
sta rnd+4,x
inx
bne ranlop
;
rts
;
;******************************
;
delay
;
ldx #$20
;
ldy #$00
;
dellop
;
nop
nop
nop
;
dey
bne dellop
;
dex
bne dellop
;
rts
;
;*****************************
;
clvars
;
lda #$00
ldx #$07
;
cllop
;
sta $00,x
;
inx
bne cllop
;
rts
;
;****************************
;
clswin
;
; clear the game play window
;
;
lda #22
sta cly
;
clrit1
;
ldx #0
ldy cly
jsr xy
;
ldy #30
;
clrit2
;
lda #196
sta (sl),y
;
lda #$71
sta (cl),y  ;* colour
;
dey
bne clrit2
;
dec cly
bne clrit1
;
rts
;
;------------------------------
;
xy
;
cpy #0
bpl yooke
;
ldy #0
;
yooke
;
; if y<0 then y=0 !!
;
tya
asl a
tay
;
lda scrpos,y
sta sl
lda scrpos+1,y
sta sl+1
;
txa
clc
adc sl
sta sl
sta cl
;
lda sl+1
adc #0
sta sl+1
;
sec
sbc #4
sta cl+1
;
rts
;
scrpos
;
.word $c00,$c28,$c50,$c78,$ca0
.word $cc8,$cf0,$d18,$d40,$d68
.word $d90,$db8,$de0,$e08,$e30
.word $e58,$e80,$ea8,$ed0,$ef8
.word $f20,$f48,$f70,$f98,$fc0
;
;
;-----------------------------
;
; copy bomb char (used and
; required several times -
; subroutine !!!
;
copybm
;
ldx #31
;
gti205
;
lda $3fa0,x
sta $3960,x
;
dex
bpl gti205 ;* soon !
;
rts
;
;
;
;
;
.end
