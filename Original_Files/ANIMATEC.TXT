; >s:animate-chars
; put "animate-chars"
;
; animate chars for mega-
; gloppiness.
;
animat
;
jsr aniexp   ;* explosion char
;
lda stpman   ;* stop man ani ?
bne droyt
;
jsr manglp   ;* animate man
;
droyt
;
jsr aliani   ;* alien animation
;
dec anitem
beq fgre
;
rts
;
fgre
;
lda #7
sta anitem
;
ldx bdcnt  ;* border char count
inx
cpx #6
;
bne ntena
;
ldx #0
;
ntena
;
stx bdcnt
;
lda aniseq,x
;
asl a
asl a
asl a
;
tax
;
ldy #0
;
ani1
;
lda xdat,x
sta $3e58,y
;
lda ydat,x
sta $3e60,y
;
inx
iny
cpy #8
bne ani1
;
; now do the brick chars
;
inc brkcnt
lda brkcnt
cmp #3
bne ntlsbk
;
lda #0
sta brkcnt
;
ntlsbk
;
asl a
asl a
asl a
;
tax
;
ldy #0
;
brklop
;
lda brik1,x
sta $3e38,y
;
lda brik2,x ;* door char
sta $3e40,y
;
lda brik3,x
sta $3e30,y
;
inx
iny
cpy #8
bne brklop
;
;
;
;
;
;
rts
;
;--------------------------------
;
aniexp
;
; explosion char data
;
jsr random
;
ldx rnd+1
;
ldy #0
;
exp1
;
lda $8000,x ;* random data
sta $3fc0,y
;
inx
iny
cpy #8
bne exp1
;
lda bombgo
beq frout  ;* dont do it
;
ldx #31
;
dsar
;
lda $3960,x
;
eor ted
and $3fa0,x
;
sta $3960,x
;
dex
bpl dsar
;
; fizzle bomb during explosion
;
frout
;
rts
;
;-------------------------------
;
manglp
;
; comes here when stopped even
; if for only a short time
;
lda keepon
bne storp
;
ldx #0
beq geetin ;* set norm char
;
storp
;
dec gloptm
beq grunty
;
rts
;
grunty
;
lda #45
sta gloptm
;
ldy mancnt ;* man anicount
;
; set up before here.
;
ldx tim32,y
;
; *32
;
geetin
;
ldy #0
;
frod
;
lda balman,x
sta $38e0,y
;
inx
iny
cpy #32
bne frod
;
ldx mancnt
inx
cpx #4
bne face
;
ldx #2
;
face
;
stx mancnt
;
; animation goes :-
;
; 0,1,2,3,2,3,2,3,2,3,2,3
;
; good eh!!
;
rts
;
;********************************
;
aniseq .byte 0,1,2,3,2,1
;
xdat
;
; char data for horizontal border
; character.
;
.byte $00,$00,$81,$ff,$ff,$81,$00,$00
.byte $00,$00,$c3,$7e,$7e,$c3,$00,$00
.byte $00,$00,$e7,$3c,$3c,$e7,$00,$00
.byte $00,$00,$ff,$18,$18,$ff,$00,$00
;
ydat
;
; data as above but for vertical
; character
;
.byte $3c,$18,$18,$18,$18,$18,$18,$3c
.byte $24,$3c,$18,$18,$18,$18,$3c,$24
.byte $24,$24,$3c,$18,$18,$3c,$24,$24
.byte $24,$24,$24,$3c,$3c,$24,$24,$24
;
;********************************
;
brik1
;
; gloppy brick chars
;
.byte $6d,$6d,$fe,$fe,$bf,$bf,$79,$79
.byte $b6,$b6,$7f,$7f,$fd,$fd,$9e,$9e
.byte $db,$db,$bd,$bd,$7e,$7e,$e7,$e7
;
brik2
;
; another gloppy brik char
;
.byte $55,$7d,$7d,$7d,$7d,$7d,$7d,$55
.byte $55,$69,$55,$7d,$7d,$55,$69,$55
.byte $55,$69,$69,$55,$55,$69,$69,$55
;
brik3
;
; another gloppy brik char
;
.byte $55,$69,$55,$7d,$7d,$7d,$7d,$55
.byte $55,$69,$69,$69,$55,$7d,$7d,$55
.byte $55,$69,$69,$69,$69,$69,$55,$55
;
;--------------------------------
;
balman
;
.byte $00,$05,$17,$1f,$5f,$7f,$7f,$77
.byte $00,$50,$94,$a4,$e5,$e9,$f9,$f9
.byte $77,$77,$75,$7d,$5d,$1f,$17,$05
.byte $f9,$f9,$f9,$e9,$e5,$a4,$94,$50
;
.byte $01,$17,$1b,$1d,$06,$17,$1f,$5f
.byte $40,$d4,$e4,$74,$90,$94,$e4,$e5
.byte $7f,$77,$75,$7d,$5f,$1f,$17,$05
.byte $e9,$f9,$f9,$f9,$e5,$e4,$94,$50
;
.byte $05,$17,$1f,$1f,$1e,$1f,$07,$16
.byte $50,$d0,$74,$fd,$fd,$a5,$d0,$94
.byte $1f,$5f,$7f,$77,$5f,$1f,$17,$05
.byte $e4,$e5,$f9,$f9,$e5,$e4,$94,$50
;
.byte $05,$07,$1d,$7f,$7f,$5a,$07,$16
.byte $50,$d4,$f4,$f4,$b4,$f4,$d0,$94
.byte $1f,$5f,$7f,$77,$5f,$1f,$17,$05
.byte $e4,$e5,$f9,$f9,$e5,$e4,$94,$50
;
;
;*****************
;
aliani
;
dec alycnt
beq hug
;
rts
;
hug
;
lda #20
sta alycnt
;
inc deftem
lda deftem
;
and #1
tay
;
ldx tim32,y
;
; pointer to char data in alibuf
;
ldy #0
;
comuni
;
lda alibuf,x
sta $3e88,y
;
inx
iny
cpy #32
bne comuni
;
rts
;
;
;
;
;
.end
