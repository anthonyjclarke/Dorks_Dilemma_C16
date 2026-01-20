; >s:filler-bomb
; put "filler-bomb
;
; do the bomb fill stuff
;
filbmb
;
ldx bomx
stx ax
stx cx
;
inx
stx bx
stx dx
;
ldy bomy
sty ay
sty by
;
iny
sty cy
sty dy
;
; 4 corner addresses sussed.
;
lda rnd+1
and #3
clc
adc #4
;
; random diameter of bomb 4-7
;
sta ybomb
;
lda #0
sta stopa
sta stopb
sta stopc
sta stopd
;
fill1
;
lda stopa
bne startb ;* a already finished
;
lda #$ff
sta xbomb
;
ldx ax
;
fila
;
ldy ay
jsr chkbmb
;
bcs stfila ;* exit loop
;
dex
inc xbomb
lda xbomb
cmp ybomb
;
bne fila
;
stfila
;
lda xbomb
cmp #$ff
bne startb
;
lda #1
sta stopa ;* a hit it
;
startb
;
; start next bit
;
lda stopb  ;* have we stopped ?
bne startc
;
lda #$ff
sta xbomb
;
ldx bx
;
filb
;
ldy by
jsr chkbmb
;
bcs stfilb ;* bit the dust
;
inx
inc xbomb
lda xbomb
cmp ybomb
;
bne filb
;
stfilb
;
lda xbomb
cmp #$ff
bne startc
;
lda #1
sta stopb
;
startc
;
lda stopc
bne startd
;
lda #$ff
sta xbomb
;
ldx cx
;
filc
;
ldy cy
;
jsr chkbmb
;
bcs stfilc ;* stop it
;
dex
inc xbomb
lda xbomb
cmp ybomb
;
bne filc
;
stfilc
;
lda xbomb
cmp #$ff
bne startd
;
lda #1
sta stopc
;
startd
;
lda stopd
bne fillex ;* exit
;
lda #$ff
sta xbomb
;
ldx dx
;
fild 