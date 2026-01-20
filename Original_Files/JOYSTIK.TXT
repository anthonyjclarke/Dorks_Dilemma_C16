; >s:joystik
; put "joystik"
;
;*******************
;
; read the joystick
;
;*******************
;
;
redjos
;
lda joysel
bne tryjos
;
jmp key         ;* use keyboard
;
tryjos
;
lda #$fd        ;* port 0
sta jport
;
lda #$4a
sta xtrcde      ;* 'lsr a'
;
lda jport
eor #$ff
bne naye
;
; try port 1
;
lda #$fa        ;* port 1
sta jport
;
lda #$ea
sta xtrcde      ;* 'nop'
;
lda jport
eor #$ff
;
bne naye        ;* read some data
;
nomove
;
lda #0
ldx #5
;
nme1
;
sta jleft,x
;
dex
bpl nme1
;
rts
;
;-----------
;
naye
;
ror a
ror jup
;
ror a
ror jdown
;
ror a
ror jleft
;
ror a
ror jright
;
lsr a
lsr a
lsr a
;
xtrcde
;
nop
;
ror jfire
;
lda #1
sta jmove
;
rts
;
;
.end
