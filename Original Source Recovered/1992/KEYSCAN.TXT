; >s:key-scan
; put "key-scan"
;
; this will be called from the
; joystick read routine if it
; finds there is no joystick
; movement,
; it will then clear or set the
; appropriate variables if keys
; are pressed
;
; note it will set or clear
; jmove as appropriate
;
;
;
key
;
lda #0
sta jmove
;
ldx #4
;
scan1
;
lda btd,x
ldy rwd,x
;
jsr keyit
;
ror jleft,x
;
dex
bpl scan1
;
rts
;
; left  = 'z'
; right = 'x'
; up    = ';'
; down  = '/'
; fire  = 'space'
;
keyit
;
sty $fd30
sty $ff08
and $ff08
;
bne rtty
;
lda #$01
sta jmove
sec
;
rts
;
rtty
;
clc
;
rts
;
;
btd
;
;      l   r   u   d   f
;
.byte $10,$80,$04,$80,$10
;
rwd
;
.byte $fd,$fb,$bf,$bf,$7f
;
.end
