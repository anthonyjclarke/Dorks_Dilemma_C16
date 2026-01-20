; >s:setup
; put "setup"
;
;*****************************
;
; initialise all pointers etc.
;
;*****************************
;
setup
;
lda ted+18
and #%11111011 ;* chars from ram
sta ted+18
;
lda ted+7
ora #$90       ;* 256 chars
sta ted+7      ;* + multi colour
;
lda #$38
sta ted+19     ;* chars at $3800
;              ;* 2k char set !
ldx #3
;
rnl
;
lda ted,x   ;* timers as rnd #
sta rnd,x
;
dex
bpl rnl
;
;  *seed
;
lda #$11
sta backgr
sta border
;
lda #$00
sta multi1
;
lda #$46
sta multi2
;
;
;
;
rts
;
;
;
.end
