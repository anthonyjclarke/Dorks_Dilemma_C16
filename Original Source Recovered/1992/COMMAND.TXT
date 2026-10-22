; >s:command
; put "command"
;
; check if you want to escape
; from game,edit jigsaw etc.
;
;
comand
;
;
jsr chkspc ;* escape to edit
;
bcc noedit
;
lda #1
sta stop   ;* kill irq's
;
lda vol
pha
;
lda #0
sta vol
;
jsr edit
;
; lda #0
; sta stop
;
dec stop
;
pla
sta vol
;
noedit
;
rts
;
;-------------------------------
;
chkspc
;
; check status of escape
;
lda #$10
ldy #$bf
jsr keyit
;
rts
;
;
;
.end
