; >s:extra-memory
; put "extra-memory"
;
; find some room for some tables
;
;  memory free       # of bytes
;
;  $0200-$0300        256
;  $033c-$03ff        196
;  $0be8-$0bff         24
;  $0fe8-$0fff         24
;
;
*=$0200
;
jignum
;
*=*+25
;
; what piece of jigsaw is in each
; logical room
;
;--------------------------------
;
romnum
;
*=*+25
;
; what screen data is used to
; generate the logical room
;
;--------------------------------
;
radbuf
;
*=*+25
;
; radar buffer
;
;--------------------------------
;
alibuf
;
*=*+64
;
; 2 alien animations
;
;--------------------------------
;
gotbit
;
*=*+25
;
; 0=not got this piece
; 1=t'her
;
;-------------------------------
;
histbl
;
*=*+80
;
; hi-score table (generated)
;
;
;
;
;
;
;
.end
