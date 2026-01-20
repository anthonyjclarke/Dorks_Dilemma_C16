; >s:screen-init
; put "screen-init"
;
; set up the window for play
;
setwin
;
;
ldx #<welch
ldy #>welch
;
jsr pwint
;
lda #$79
sta $965
sta $966
sta $965+40
sta $966+40
;
; colour for bomb
;
rts
;
;-----------------
;
; print colour on hiscore table
; for the j/k and q/s chars
; and border colors
;
sludge
;
ldx #31
;
queen1
;
lda #37
sta $c00,x
sta $f98,x
;
; lda #$11
; sta $800,x
; sta $b98,x
;
dex
bpl queen1
;
lda #23
sta ty
;
queen2
;
ldx #0
ldy ty
jsr xy
;
ldy #0
lda #37
sta (sl),y
;
lda #$11
sta (cl),y
;
lda #37
ldy #31
sta (sl),y
;
lda #$11
sta (cl),y
;
dec ty
bne queen2
;
ldx #31
ldy #0
;
queen3
;
lda tcol,y
;
sta $800,y
sta $bb7-31,x
;
iny
dex
bpl queen3
;
;
;
;
rts
;
tcol
;
.byte $07,$17,$27,$37
.byte $47,$57,$67,$77
.byte $06,$16,$26,$36
.byte $46,$56,$66,$76
.byte $05,$15,$25,$35
.byte $45,$55,$65,$75
.byte $02,$12,$22,$32
.byte $42,$52,$62,$72
;
;
;
;
;********************************
;
welch
;
.byte 33,1,$65,100,68,92,98,72,213,0
.byte 33,2,$45,101,69,93,99,73,214,0
;
; 'score'
;
.byte 33,3,$65,32,32,32,32,32,$30,0
;
; '    0'
;
.byte 33,4,$53,$c,9,$16,5,$13,$3a,0
;
; 'lives:'
;
.byte 35,5,$63,$33,0
;
; '  3'
;
.byte 33,6,$54,1,$c,9,5,$e,$13,0
;
; 'aliens'
;
.byte 35,7,$64,32,32,0
;
; ' 20'
;
.byte 33,8,$61,66,92,88,66,44,45,0
.byte 33,9,$41,67,93,89,67,46,47,0
;
; 'bomb'
;
.byte 33,11,$64,10,9,7,19,1,$17,0
;
; 'jigsaw'
;
.byte 33,19,$77,$d,0
.byte 33,20,$77,$1,0
.byte 33,21,$77,$10,0
;
; 'map'
;
.byte $ff
;
;
;
.end
