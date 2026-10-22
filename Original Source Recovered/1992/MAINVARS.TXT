; >s:main-vars
; put "main-vars"
;
; main system variables
;
ted    = $ff00
;
irqreg = ted+9
irqmsk = ted+10
rascom = ted+11
rasthi = ted+$1c
;
border = ted+$19
backgr = ted+$15
;
jport  = ted+8
;
multi1 = ted+$16
multi2 = ted+$17
;
sou1lo = ted+14
sou2lo = ted+15
sou1hi = ted+18
sou2hi = ted+16
;
vol    = ted+17
;
;
;
;
;
;
;-----------------------
;
scrbuf = $400
;
; buffer (screen size) 0400-07bf
;
scdata = $1000
;
; location of compressed screen
; data
;
;
;
.end
