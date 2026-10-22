; >s:hall-of-fame
; put "hall-of-fame"
;
;
hisamp
;
.byte '000100  gremlin '
;
inhisc
;
; init the hiscore tables
;
;
ldy #0
;
inh1
;
ldx #0
;
inh2
;
lda hisamp,x
sta histbl,y
;
iny
inx
cpx #16
bne inh2
;
; one line done
;
cpy #80
bne inh1
;
; wait for 5 lines
;
rts
;
;
;
;
;
.end
