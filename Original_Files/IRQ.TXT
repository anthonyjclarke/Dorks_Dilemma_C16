; >s:irq
; put "irq"
;
;*********************
;
; all the irq routines
;
;*********************
;
;
rasval
;
.byte $c1,$00
;
setirq
;
; set up irq's
;
sei
;
lda #<serv
sta $0314
lda #>serv
sta $0315
;
lda #%00000010
sta irqmsk
;
; enable irq's from :-
;
; raster
;
; no hassle from timer 2 in this !
;
lda rasval
sta rascom
;
lda #0
sta intype
;
; set raster compare
;
cli
;
rts
;
;-------------------------------
;
serv
;
;************************
;
;irq comes here - wow !!!
;
;************************
;
lda irqreg
sta irqreg ;* reset bits
;
lda intype ;* raster number
eor #1
sta intype
;
;*************************
;
; raster service routine
;
;*************************
;
lda sl
pha
lda sl+1
pha
lda cl
pha
lda cl+1
pha
;
; save 'xy' variables
;
lda intype
bne noras1
;
jmp rast1
;
noras1
;
jmp rast2
;
noras2
;
;
;
;
;
;************
;
;  irq exit
;
;************
;
irqend
;
pla
sta cl+1
pla
sta cl
pla
sta sl+1
pla
sta sl
;
ldx intype
lda rasval,x
sta rascom
;
pla
tay
pla
tax
pla
rti
;
;
;
;
;
.end 
