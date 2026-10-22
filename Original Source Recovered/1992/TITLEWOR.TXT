; >s:title-works
; put "title-works"
;
; do the bits on the title page
;
bdrglp
;
; scroll the border round
;
lda $81f
sta stopa  ;* save it
;
lda $bb7
sta stopb
;
lda $b98
sta stopc
;
; 3 bits saved
;
ldx #30
;
qat1
;
lda $800,x
sta $801,x
;
dex
bpl qat1
;
lda #22
sta bordy
;
qat2
;
ldx #31
ldy bordy
jsr xy
;
ldy #0
lda (cl),y
;
ldy #40
sta (cl),y
;
dec bordy
bne qat2
;
lda stopa
sta $847
;
ldx #0
;
qat3
;
lda $b99,x
sta $b98,x
;
inx
cpx #30
bne qat3
;
lda stopb
sta $bb6
;
lda #0
sta bordy
;
qat4
;
ldx #0
ldy bordy
jsr xy
;
ldy #40
lda (cl),y
;
ldy #0
sta (cl),y
;
inc bordy
lda bordy
cmp #23
bne qat4
;
lda stopc
sta $b70
;
rts
;
;
;
;
;
;
;
;
.end
