; >s:variety
; put "variety"
;
;
getdef
;
; sets up chars for alien on
; this sheet.
;
; both chars are left in the
; screen buffer
;
; char#1 alibuf-alibuf+31
; char#2 alibuf+32-alibuf+63
;
; random nubers continually
; generated form raster
;
lda duck   ;* same aliens as b4?
beq outduk ;* no
;
lda aliens ;* last type
jmp quazi
;
outduk
;
lda ted
and #3
tax
;
lda rnd,x
;
and #7     ;* eight types
sta aliens ;* alien number
;
quazi
;
tay
;
ldx tim32,y
;
ldy #0
;
defer
;
lda def1,x   ;* ani #1
sta alibuf,y
;
lda def2,x   ;* ani #2
sta alibuf+32,y
;
inx
iny
cpy #32
;
bne defer
;
lda #1
sta deftem   ;* tempo
;
rts
;
;
def1
;
; data for animation 1
; in order chars 0-7
;
; gonk #1
;
.byte $00,$15,$6a,$7e,$7e,$76,$6a,$6b
.byte $00,$54,$a9,$bd,$bd,$9d,$a9,$e9
.byte $6b,$6f,$6a,$6f,$6d,$6f,$6a,$15
.byte $e9,$f9,$a9,$f9,$79,$f9,$a9,$54
;
; gonk#2
;
.byte $05,$07,$16,$1e,$19,$1a,$76,$6e
.byte $50,$d0,$94,$b4,$64,$a4,$9d,$b9
.byte $6a,$56,$06,$1e,$1a,$79,$69,$54
.byte $a9,$95,$90,$b4,$a4,$6d,$69,$15
;
; gonk #3
;
.byte $05,$16,$1a,$5a,$6a,$6e,$6e,$66
.byte $50,$94,$a4,$a5,$a9,$b9,$b9,$99
.byte $6a,$69,$5a,$1a,$16,$05,$00,$00
.byte $a9,$69,$a5,$a4,$94,$50,$00,$00
;
; gonk #4
;
.byte $15,$6f,$7f,$55,$7b,$55,$7f,$5f
.byte $54,$e5,$f9,$55,$b9,$55,$f9,$a5
.byte $1f,$15,$07,$07,$07,$07,$07,$05
.byte $e4,$54,$90,$90,$90,$90,$90,$50
;
; gonk #5
;
.byte $15,$7f,$6b,$7f,$7b,$7e,$1f,$05
.byte $54,$fd,$e9,$fd,$ed,$bd,$f4,$50
.byte $06,$01,$06,$01,$06,$1a,$19,$14
.byte $90,$40,$90,$40,$90,$a4,$64,$14
;
; gonk #6
;
.byte $10,$44,$01,$16,$6a,$55,$7f,$7f
.byte $04,$11,$40,$94,$a9,$55,$ad,$ad
.byte $55,$6a,$16,$01,$06,$06,$06,$01
.byte $55,$89,$94,$40,$90,$90,$d0,$40
;
; gonk #7
;
.byte $00,$15,$7e,$7e,$7f,$7f,$7f,$15
.byte $00,$00,$40,$d4,$f4,$d4,$40,$00
.byte $1b,$15,$1b,$15,$1b,$15,$7f,$15
.byte $00,$00,$00,$00,$00,$50,$f4,$50
;
; gonk #8
;
.byte $00,$00,$05,$16,$1a,$5b,$6b,$6f
.byte $00,$00,$50,$94,$a4,$e5,$e9,$f9
.byte $6f,$6f,$6f,$6b,$5b,$1a,$16,$05
.byte $f9,$f9,$f9,$e9,$e5,$a4,$94,$50
;
;
;****************************
;
def2
;
; second definition
;
; gonk #1
;
.byte $00,$15,$6a,$7e,$76,$6b,$6b,$6f
.byte $00,$54,$a9,$bd,$9d,$e9,$e9,$f9
.byte $6a,$6f,$6d,$6d,$6d,$6f,$6a,$15
.byte $a9,$f9,$79,$79,$79,$f9,$a9,$54
;
; gonk #2
;
.byte $05,$07,$16,$1e,$19,$1a,$16,$7e
.byte $50,$d0,$94,$b4,$64,$a4,$94,$bd
.byte $6a,$66,$56,$1e,$1a,$19,$19,$14
.byte $a9,$99,$95,$b4,$a4,$64,$64,$14
;
; gonk #3
;
.byte $00,$00,$05,$16,$1a,$5a,$66,$6e
.byte $00,$00,$50,$94,$a4,$a5,$99,$b9
.byte $6e,$6a,$69,$67,$59,$1a,$16,$05
.byte $b9,$a9,$69,$d9,$65,$a4,$94,$50
;
; gonk #4
;
.byte $00,$00,$00,$15,$5f,$7f,$55,$7b
.byte $00,$00,$00,$54,$e5,$f9,$55,$b9
.byte $55,$7f,$5f,$1f,$15,$07,$07,$05
.byte $55,$f9,$a5,$e4,$54,$90,$90,$50
;
; gonk #5
;
.byte $00,$00,$15,$7f,$6b,$67,$7f,$7e
.byte $00,$00,$54,$fd,$e9,$d9,$fd,$bd
.byte $1f,$05,$06,$01,$06,$1a,$19,$14
.byte $f4,$50,$90,$40,$90,$a4,$44,$14
;
; gonk #6
;
.byte $10,$04,$01,$16,$6a,$55,$7a,$7a
.byte $04,$10,$40,$94,$a9,$55,$fd,$fd
.byte $55,$6a,$16,$01,$07,$07,$07,$01
.byte $55,$89,$94,$40,$d0,$d0,$90,$40
;
; gonk #7
;
.byte $00,$00,$00,$00,$00,$15,$7e,$7e
.byte $00,$00,$00,$00,$00,$00,$40,$d4
.byte $7f,$7f,$7f,$15,$1b,$15,$7f,$15
.byte $f4,$d4,$40,$00,$00,$50,$f4,$50
;
; gonk #8
;
.byte $00,$00,$0f,$3d,$35,$f6,$d6,$da
.byte $00,$00,$f0,$7c,$5c,$9f,$97,$a7
.byte $da,$da,$da,$d6,$f6,$35,$3d,$0f
.byte $a7,$a7,$a7,$97,$9f,$5c,$7c,$f0
;
;
;
;
;
.end
