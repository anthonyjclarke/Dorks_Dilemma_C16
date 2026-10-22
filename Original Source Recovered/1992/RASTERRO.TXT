; >s:raster-routines
; put "raster-routines"
;
;
; these are the routines called
; by the raster irq programme
;
;
rast1
;
; main play area - multi colour,
; steady etc.
;
;
lda ted+7
and #%11110000
ora #%00001000
sta ted+7
;
; multi-col + 40 cols
; & reset pixel movement
;
;
jsr animat ;* animate glop chars
jsr random ;* rndy numbers
;
jmp irqend
;
;********************************
;
rast2
;
; pixel scrolling message
;
; 38 cols
;
ldx #7
;
shity
;
dex
;
bpl shity
;
lda ted+7
and #%11110000 ;*back to 38 cols
ora messx      ;*message pix. pos.
sta ted+7
;
jsr messve     ;* glop message
jsr redjos     ;* read i/p device
;
lda stop
bne miss1
;
jsr upbomb     ;* bomb code
jsr prnals     ;* print aliens
jsr movemn     ;* move blob
;
miss1
;
lda title      ;* on title page ?
beq miss2
;
jsr bdrglp     ;* scroll border
;
miss2
;
jmp irqend
;
;
.end
