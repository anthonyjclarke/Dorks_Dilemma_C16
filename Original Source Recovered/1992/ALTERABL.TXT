; >s:alterables
; put "alterables"
;
; choose k/j & q/s
;
; default values are :-
;
; keyboard    joysel = 0
;
; sound on    sndflg = 1
;
alter
;
lda #$10
ldy #$fe     ;* 'f1'
jsr keyit
;
bcc alt1     ;* not pressed
;
lda joysel
eor #1
sta joysel
;
ldx #47
;
alt2
;
lda $3c40,x  ;* existing char
pha
;
lda jkchar,x ;* new one
sta $3c40,x
;
pla
sta jkchar,x ;* replace it
;
dex
bpl alt2
;
;
alt1
;
lda #$20
ldy #$fe     ;* 'f2'
jsr keyit
;
bcc alt3
;
lda sndflg
eor #1
sta sndflg
;
ldx #47
;
alt4
;
lda $3c70,x
pha
;
lda sqchar,x
sta $3c70,x
;
pla
sta sqchar,x
;
dex
bpl alt4
;
alt3
;
rts
;
;-------------------------------
;
jkchar
;
.byte $05,$16,$1a,$1a,$16,$05,$07,$07
.byte $40,$50,$d0,$90,$50,$40,$40,$41
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $07,$05,$1f,$7f,$7f,$55,$7f,$15
.byte $46,$55,$ff,$ff,$ff,$55,$fe,$55
.byte $40,$50,$a4,$e9,$f9,$55,$a9,$54
;
;
;*****
;
sqchar
;
.byte $18,$0c,$06,$03,$01,$00,$00,$00
.byte $00,$00,$00,$01,$83,$c6,$6c,$38
.byte $30,$60,$c0,$80,$00,$00,$00,$00
.byte $00,$00,$01,$03,$06,$0c,$18,$10
.byte $6c,$c6,$83,$01,$00,$00,$00,$00
.byte $00,$00,$00,$80,$c0,$60,$30,$10
;
;
;
;
.end
