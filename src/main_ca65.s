; ==============================================================================
; DORK'S DILEMMA - Consolidated Source

; ==============================================================================
; Original game: (c) 1985 Micro-Projects Ltd. for Gremlin Graphics Ltd.
; Started: 5th March 1985
; Platform: Commodore C16/Plus4
; This consolidated source file combines all original .TXT modules
; Reconstructed from 1992 archive disk
; ==============================================================================
; main system variables

ted    = $ff00
irqreg = ted+9
irqmsk = ted+10
rascom = ted+11
rasthi = ted+$1c
border = ted+$19
backgr = ted+$15
jport  = ted+8
multi1 = ted+$16
multi2 = ted+$17
sou1lo = ted+14
sou2lo = ted+15
sou1hi = ted+18
sou2hi = ted+16
vol    = ted+17

scrbuf = $0c00
; buffer (screen size) 0c00-0fbf (Plus/4 screen location)
scdata = $1000
; location of compressed screen
; data
; .end removed

; ==============================================================================
; Macros converted to ca65 syntax
.macro dpinc addr
    inc addr
    bne :+
    inc addr+1
:
.endmacro

.macro dpdec addr
    lda addr
    sec
    sbc #1
    sta addr
    lda addr+1
    sbc #0
    sta addr+1
.endmacro

; ==============================================================================
; all variables to be page zero

.segment "ZEROPAGE"
.org $02
mesl: .res 2 ;* message pointer
messx: .res 1 ;* mess. pixel
lives: .res 1 ;* # of lives
xtra: .res 1 ;* xtra life compare
jleft: .res 1 ;* left
jright: .res 1 ;* right
jup: .res 1 ;* up
jdown: .res 1 ;* down
jfire: .res 1 ;* fire
jmove: .res 1 ;* moved ?
intype: .res 1 ;* irq number
rnd: .res 4 ;* random number
tryoth: .res 1 ;* try other dir
sl: .res 2 ;* screen pointer
al: .res 2 ;* ali scrn pointer
work: .res 4 ;* screen pointer
xcount: .res 1 ;* x for decoder
ycount: .res 1 ;* y for decoder
screen: .res 1 ;* screen no# 0-24
xpos: .res 1 ;* x in maze
ypos: .res 1 ;* y in maze
temp: .res 1 ;* door temp
manx: .res 1 ;* man x pos
trx: .res 1 ;* man temp x pos
savex: .res 1 ;* x pos
many: .res 1 ;* man y pos
try: .res 1 ;* man temp y pos
savey: .res 1 ;* y pos
tx: .res 1 ;* temp x pos
ty: .res 1 ;* temp y pos
fire: .res 1 ;* fire flag
hit: .res 1 ;* free to move ?
temman: .res 1 ;* man move tempo
newrom: .res 1 ;* move to new room
stop: .res 1 ;* stop everything
cl: .res 2 ;* colour address
xpix: .res 1 ;* man x pixel
ypix: .res 1 ;* man y pixel
dir: .res 1 ;* man direction
rustic: .res 1 ;* flag
char: .res 1 ;* char on
going: .res 1 ;* moving ?
chkx: .res 1 ;* check x pos
chky: .res 1 ;* check y pos
temdir: .res 1 ;* temp dir
behind: .res 4 ;* behind char buff
dl: .res 2 ;* pointer to buffer
ol: .res 2 ;* pointer to screen
count: .res 1 ;* number to copy
copy: .res 1 ;* char to copy
colour: .res 1 ;* colour of char
alipos: .res 8 ;* alien x,y table
irqprt: .res 8 ;* irq print table
irqrub: .res 8 ;* irq clear table
alitim: .res 4 ;* time to start
move: .res 1 ;* can move ?
chekx: .res 1 ;* try x dir
cheky: .res 1 ;* try y dir
alitem: .res 1 ;* ali mve tempo
alicnt: .res 1 ;* ali count
alx: .res 1 ;* ali x pos
aly: .res 1 ;* ali y pos
prtals: .res 1 ;* print aliens ?
point: .res 1 ;* temp pointer
keyval: .res 1 ;* inkey val
bdcnt: .res 1 ;* border ani cnt.
anitem: .res 1 ;* animate tempo .
timer: .res 1 ;* bomb timer
bomsl: .res 2 ;* bomb screen
bomcl: .res 2 ;* bomb colour
bombon: .res 1 ;* bomb on ?
bombgo: .res 1 ;* go for it basic !
bready: .res 1 ;* bomb recharged ?
chtime: .res 1 ;* charge time
ax: .res 1 ;* pos
ay: .res 1 ;* pos
bx: .res 1 ;* pos
by: .res 1 ;* pos
cx: .res 1 ;* pos
cy: .res 1 ;* pos
dx: .res 1 ;* pos
dy: .res 1 ;* pos
stopa: .res 1 ;* stop direction
stopb: .res 1 ;* stop direction
stopc: .res 1 ;* stop direction
stopd: .res 1 ;* stop direction
bomx: .res 1 ;* tl bomb co-ord
xbomb: .res 1 ;* x explosion size
bomy: .res 1 ;* tl bomb co-ord
ybomb: .res 1 ;* y explosion size
bomcol: .res 1 ;* explosion colour
bmbcol: .res 1 ;* bomb colour
numb: .res 1 ;* high print
jigx: .res 1 ;* edit jigsaw x
jigy: .res 1 ;* edit jigsaw y
copyl: .res 2 ;* copy address
copych: .res 1 ;* copy char #
nocorr: .res 1 ;* # in correct pos.
jigno: .res 1 ;* # jigsaw piece
delly: .res 1 ;* time delay pass
compx: .res 1 ;* man x pos
compy: .res 1 ;* man y pos
swap: .res 1 ;* char to swap
brkcnt: .res 1 ;* brik ani count
keepon: .res 1 ;* moving ?
mancnt: .res 1 ;* man animation
gloptm: .res 1 ;* man tempo
toggle: .res 1 ;* flag
antfag: .res 1 ;* flag
deftem: .res 1 ;* alien animation
alycnt: .res 1 ;* alien tempo
moron: .res 1 ;* count
dead: .res 1 ;* dead flag
stpman: .res 1 ;* stop man ani.
aliens: .res 1 ;* alien number
duck: .res 1 ;* new alien def.?
title: .res 1 ;* on title page ?
savdir: .res 1 ;* dir saved
manl: .res 2 ;* man pos
dedbmb: .res 2 ;* died by bomb ?
scradd: .res 1 ;* score to add
hispnt: .res 1 ;* high thingie
positn: .res 1 ;* pos in table
incnt: .res 1 ;* some counter
letcnt: .res 1 ;* letter counter
bordy: .res 1 ;* y pos
notokl: .res 1 ;* # aliens to get
nokild: .res 1 ;* number killed
prcol: .res 1 ;* print colour
cly: .res 1 ;* y pos
menatw: .res 1 ;* format flag
wall: .res 1 ;* save
datax: .res 1 ;* move x pos
datay: .res 1 ;* move y pos
alkill: .res 1 ;* number to kill
cleard: .res 1 ;* done this room?
ar: .res 2 ;* alien rub out
bonus: .res 1 ;* bonus ?
dosfx: .res 1 ;* do cls snd ?
almvet: .res 1 ;*
kilhex: .res 1 ;*
kildec: .res 1 ;*
sikbuf: .res 6 ;* score buffer

; ==============================================================================
; find some room for some tables
; memory free       # of bytes
; $0200-$0300        256
; $033c-$03ff        196
; $0be8-$0bff         24
; $0fe8-$0fff         24
.segment "BSS"
.org $0200
jignum:
.res 25
; what piece of jigsaw is in each
; logical room

romnum:
.res 25
; what screen data is used to
; generate the logical room

radbuf:
.res 25
; radar buffer

alibuf:
.res 64
; 2 alien animations

gotbit:
.res 25
; 0=not got this piece
; 1=t'her

histbl:
.res 80
; hi-score table (generated)

; ==============================================================================
; Actual executable code starts here - this goes in the PRG file
.segment "CODE"
.org $1960
lda #$05
jsr $ffd2
lda #$93
jsr $ffd2
sei
; ldx #$fe
; txs
jsr clvars
lda #<messt
ldx #>messt
sta mesl
stx mesl+1
jsr inhisc ;* set up hall tbl
jmp gloppy
sndflg: .byte $01      ; sound flag (1=on)
joysel: .byte $00      ; joystick select (0=joystick, 1=keyboard)
level:  .byte $00      ; current level

; ==============================================================================
; GAME MODULES
; ==============================================================================
; ------------------------------------------------------------------------------
; MODULE: PLAYGAME
; ------------------------------------------------------------------------------
; hold all the routines together
; ------------------------------------------------------------------------------
; PLAY - Main Game Initialization and Setup
; ------------------------------------------------------------------------------
; Initializes the game state, sets up player position, configures hardware,
; and prepares all game systems before entering the main game loop.
; Called at game start.
play:
sei
jsr clvars ;* clear vars
; lda #<messt
; sta mesl
; lda #>messt
; sta mesl+1
; ------------------
; lda #0
; sta manx
; sta trx
lda #12
sta many
sta try
lda #2
sta dir ;* start direction
; ------------------
; man's start position
jsr copybm
; copy complete bomb char

jsr rooms ;* set up randomness
; lda #0
; sta xpos
; sta ypos
jsr setup
; lda #1
; sta joysel
; jsr prbder  ;* glop border
; jsr prjig   ;* print jigsaw
; jsr setwin  ;* set up window
jsr setirq ;* irq's on
lda #1
sta stop ;* no movement
sta bready ;* bomb ready
sta anitem ;*
sta alitem ;*
jsr scater ;* scatter jigsaw
jsr jmpbak
; this is calling a subroutine
; used in the game to print on
; a new screen (as if moved into a
; new room.)
lda #0
sta stop ;* all go
; lda #3
; sta lives   ;* no. of lives
; Main game loop - runs continuously during gameplay
; Checks for death, processes commands, handles bomb explosions,
; room transitions, radar updates, and alien movement
loop:
jsr deadck
; check if he died during during
; the last raster.
jsr comand
; check if you want to edit/escape
jsr basbom
; check if the irq wants this loop
; to do the bomb explosion.
lda newrom ;* move to new room?
beq norm
jsr roomon
; bring on the new room
norm:
ldx #$08
jsr delay+2
jsr radar ;* update radar
dec alitem
bne dntdit
lda almvet ;* tempo
sta alitem
jsr mveali ;* move aliens
dntdit:
jmp loop

; ------------------------------------------------------------------------------
; MODULE: JOYSTIK

; ------------------------------------------------------------------------------
; *******************
; read the joystick
; *******************
; ------------------------------------------------------------------------------
; REDJOS - Read Joystick Input
; ------------------------------------------------------------------------------
; Reads joystick input from port 0 or 1, or falls back to keyboard.
; Sets directional flags (jleft, jright, jup, jdown, jfire) and jmove.
; Auto-detects which port has an active joystick.
redjos:
lda joysel
bne tryjos
jmp key ;* use keyboard
tryjos:
lda #$fd ;* port 0
sta jport
lda #$4a
sta xtrcde ;* 'lsr a'
lda jport
eor #$ff
bne naye
; try port 1
lda #$fa ;* port 1
sta jport
lda #$ea
sta xtrcde ;* 'nop'
lda jport
eor #$ff
bne naye ;* read some data
nomove:
lda #0
ldx #5
nme1:
sta jleft,x
dex
bpl nme1
rts
; -----------
naye:
ror a
ror jup
ror a
ror jdown
ror a
ror jleft
ror a
ror jright
lsr a
lsr a
lsr a
xtrcde:
nop
ror jfire
lda #1
sta jmove
rts

; ------------------------------------------------------------------------------
; MODULE: IRQ

; ------------------------------------------------------------------------------
; *********************
; all the irq routines
; *********************
rasval:
.byte $c1,$00
; ------------------------------------------------------------------------------
; SETIRQ - Initialize Interrupt System
; ------------------------------------------------------------------------------
; Sets up raster interrupts for:
; - Screen split (play area vs message area)
; - Character animation timing
; - Alien movement timing
; - Random number generation
setirq:
; set up irq's
sei
lda #<serv
sta $0314
lda #>serv
sta $0315
lda #%00000010
sta irqmsk
; enable irq's from :-
; raster
; no hassle from timer 2 in this !
lda rasval
sta rascom
lda #0
sta intype
; set raster compare
cli
rts

; IRQ service routine - main interrupt handler
; Saves state, dispatches to rast1 or rast2 based on raster position
; Handles all time-critical operations during vertical blank
serv:
; ************************
; irq comes here - wow !!!
; ************************
lda irqreg
sta irqreg ;* reset bits
lda intype ;* raster number
eor #1
sta intype
; *************************
; raster service routine
; *************************
lda sl
pha
lda sl+1
pha
lda cl
pha
lda cl+1
pha
; save 'xy' variables
lda intype
bne noras1
jmp rast1
noras1:
jmp rast2
noras2:
; ************
; irq exit
; ************
irqend:
pla
sta cl+1
pla
sta cl
pla
sta sl+1
pla
sta sl
ldx intype
lda rasval,x
sta rascom
pla
tay
pla
tax
pla
rti

; ------------------------------------------------------------------------------
; MODULE: RASTERRO

; ------------------------------------------------------------------------------
; these are the routines called
; by the raster irq programme
; Raster interrupt 1 - Main play area (multicolor mode)
; Sets up TED chip for game graphics
; Calls animation and random number routines
rast1:
; main play area - multi colour,
; steady etc.
lda ted+7
and #%11110000
ora #%00001000
sta ted+7
; multi-col + 40 cols
; & reset pixel movement
jsr animat ;* animate glop chars
jsr random ;* rndy numbers
jmp irqend
; ********************************
; Raster interrupt 2 - Message area (38 columns)
; Scrolls message text, reads joystick/keyboard
; Updates bomb timer, prints aliens, moves player
rast2:
; pixel scrolling message
; 38 cols
ldx #7
shity:
dex
bpl shity
lda ted+7
and #%11110000 ;* back to 38 cols
ora messx ;* message pix. pos.
sta ted+7
jsr messve ;* glop message
jsr redjos ;* read i/p device
lda stop
bne miss1
jsr upbomb ;* bomb code
jsr prnals ;* print aliens
jsr movemn ;* move blob
miss1:
lda title ;* on title page ?
beq miss2
jsr bdrglp ;* scroll border
miss2:
jmp irqend

; ------------------------------------------------------------------------------
; MODULE: UTILS

; ------------------------------------------------------------------------------
; **************************
; utilities
; **************************
; ------------------------------------------------------------------------------
; RANDOM - Random Number Generator
; ------------------------------------------------------------------------------
; Generates pseudo-random numbers using TED chip timers and shift operations
; Updates 4-byte rnd buffer, used for alien AI and game randomization
random:
lda ted
and rnd+2
adc ted+2
asl a
asl a
rol rnd+3
rol rnd+2
rol rnd+1
rol rnd
; ^ acornsoft rnd#
clc
ldy #$29
ldx #$fc
ranlop:
tya
ldy rnd+4,x
adc rnd+4,x
sta rnd+4,x
inx
bne ranlop
rts
; ******************************
; Simple delay loop - waits for specified time
; X register = outer loop count
; Y register = inner loop count (256 iterations)
delay:
ldx #$20
ldy #$00
dellop:
nop
nop
nop
dey
bne dellop
dex
bne dellop
rts
; *****************************
; ------------------------------------------------------------------------------
; CLVARS - Clear Variables
; ------------------------------------------------------------------------------
; Zeros out all zero-page variables ($00-$FF)
; Called at game init and reset
clvars:
lda #$00
ldx #$07
cllop:
sta $00,x
inx
bne cllop
rts
; ****************************
; ------------------------------------------------------------------------------
; CLSWIN - Clear Game Window
; ------------------------------------------------------------------------------
; Clears the 30x22 character game play area
; Fills with base character (196) and color ($71)
clswin:
; clear the game play window
lda #22
sta cly
clrit1:
ldx #0
ldy cly
jsr xy
ldy #30
clrit2:
lda #196
sta (sl),y
lda #$71
sta (cl),y ;* colour
dey
bne clrit2
dec cly
bne clrit1
rts

; ------------------------------------------------------------------------------
; XY - Calculate Screen Position
; ------------------------------------------------------------------------------
; Converts X,Y coordinates to screen and color RAM pointers
; Input: X = column (0-39), Y = row (0-24)
; Output: sl = screen address, cl = color address
xy:
cpy #0
bpl yooke
ldy #0
yooke:
; if y<0 then y=0 !!
tya
asl a
tay
lda scrpos,y
sta sl
lda scrpos+1,y
sta sl+1
txa
clc
adc sl
sta sl
sta cl
lda sl+1
adc #0
sta sl+1
sec
sbc #4
sta cl+1
rts
scrpos:
.word $0c00,$0c28,$0c50,$0c78,$0ca0
.word $0cc8,$0cf0,$0d18,$0d40,$0d68
.word $0d90,$0db8,$0de0,$0e08,$0e30
.word $0e58,$0e80,$0ea8,$0ed0,$0ef8
.word $0f20,$0f48,$0f70,$0f98,$0fc0

; copy bomb char (used and
; required several times -
; subroutine !!!
; Copy complete bomb character data
; Copies 32 bytes from $3FA0 to $3960
; Required for bomb animation/explosion graphics
copybm:
ldx #31
gti205:
lda $3fa0,x
sta $3960,x
dex
bpl gti205 ;* soon !
rts

; ------------------------------------------------------------------------------
; MODULE: KEYSCAN

; ------------------------------------------------------------------------------
; this will be called from the
; joystick read routine if it
; finds there is no joystick
; movement,
; it will then clear or set the
; appropriate variables if keys
; are pressed
; note it will set or clear
; jmove as appropriate
; Keyboard input handler - called when no joystick detected
; Scans keyboard for cursor keys and space bar
; Sets same flags as joystick for consistent control handling
key:
lda #0
sta jmove
ldx #4
scan1:
lda btd,x
ldy rwd,x
jsr keyit
ror jleft,x
dex
bpl scan1
rts
; left  = 'z'
; right = 'x'
; up    = ';'
; down  = '/'
; fire  = 'space'
keyit:
sty $fd30
sty $ff08
and $ff08
bne rtty
lda #$01
sta jmove
sec
rts
rtty:
clc
rts
btd:
; l   r   u   d   f
.byte $10,$80,$04,$80,$10
rwd:
.byte $fd,$fb,$bf,$bf,$7f

; ------------------------------------------------------------------------------
; MODULE: MESSAGES

; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------
; MESSVE - Message Scrolling
; ------------------------------------------------------------------------------
; Scrolls the bottom message text one pixel to the left
; Fetches next character when needed, wraps to start at $FF marker
messve:
lda messx
sec
sbc #1
tay
and #7
sta messx
tya
and #8
bne meshil ;* need block scroll
rts
meshil:
ldx #0
msl1:
lda $0fc1,x
sta $0fc0,x
inx
cpx #39
bne msl1

dpinc mesl
rupert:
ldy #0
lda (mesl),y
cmp #$ff
bne ntmsed
lda #<messt
sta mesl
lda #>messt
sta mesl+1
bne rupert
ntmsed:
and #$3f
sta $fc0+39
rts

; ------------------------------------------------------------------------------
; MODULE: SETUP

; ------------------------------------------------------------------------------
; *****************************
; initialise all pointers etc.
; *****************************
; ------------------------------------------------------------------------------
; SETUP - TED Chip Initialization
; ------------------------------------------------------------------------------
; Configures TED chip for game:
; - Character set from RAM at $3800 (2KB multicolor)
; - 256 characters, multicolor mode
; - Seeds random number generator from timer values
; - Sets background colors
setup:
lda #$0c           ; Screen at $0C00
sta ted+20         ; $FF14 = video matrix base address
lda ted+18
and #%11111011 ;* chars from ram
sta ted+18
lda ted+7
ora #$90 ;* 256 chars
sta ted+7 ;* + multi colour
lda #$38
sta ted+19 ;* chars at $3800
; ;* 2k char set !
ldx #3
rnl:
lda ted,x ;* timers as rnd #
sta rnd,x
dex
bpl rnl
; *seed
lda #$11
sta backgr
sta border
lda #$00
sta multi1
lda #$46
sta multi2
rts

; ------------------------------------------------------------------------------
; MODULE: DECODER

; ------------------------------------------------------------------------------
; decodes the screen number held
; in 'screen' and leaves the
; screen in the buffer 'scrbuf'
; ready to be copied onto the
; screen.
; ------------------------------------------------------------------------------
; DECODE - Screen Decompression
; ------------------------------------------------------------------------------
; Decompresses room screen data from compressed format to screen buffer
; Input: screen = room number (0-24)
; Output: scrbuf filled with decompressed room layout
; Uses custom RLE-style compression (4 chars per byte)
; Mirrors left half to right half for symmetry
; Adds doors based on doordt table
decode:
lda #0
sta work+1 ;* clear from last time
ldx screen
lda romnum,x
sta work
; acc = 0 to 24
ldx #5
mult:
asl work
rol work+1
cpx #1
bne not32
lda work
sta work+2
lda work+1
sta work+3
not32:
dex
bpl mult
lda work
clc
adc work+2
sta selfmd+1
lda work+1
adc work+3
clc
adc #>scdata ;* screen data
sta selfmd+2
; selfmd has been set up (by
; self altering code ) to point
; to the start of the compressed
; data for that screen.
lda #<scrbuf
sta sl
lda #>scrbuf
sta sl+1
ldx #0
lda #23
sta ycount
lp1:
lda #3
sta xcount
lda sl
pha
lda sl+1
pha
lp2:
selfmd:
lda $ffff,x ;* self-modified: operand becomes actual screen data address
ldy #0
lp3:
asl a
rol work+2
asl a
rol work+2
pha
lda work+2
and #3
clc
adc #196 ;* base char
sta (sl),y
pla
iny
cpy #4
bne lp3
lda sl
clc
adc #4
sta sl
lda sl+1
adc #0
sta sl+1
inx ;* next data
dec xcount
bpl lp2
pla
sta sl+1
pla
clc
adc #40
sta sl
lda sl+1
adc #0
sta sl+1
dec ycount
bpl lp1
lda cleard ;* cleared this room?
beq tufluk ;* no !
lda #$00
tax
tone1a:
sta scrbuf,x
sta scrbuf+$100,x
sta scrbuf+$200,x
sta scrbuf+$2c0,x
inx
bne tone1a
; clear all crap
lda #<scrbuf
sta sl
lda #>scrbuf
sta sl+1
ldy #15
lda #199 ;* best char
tone1:
sta (sl),y
dey
bpl tone1 ;* roof
ldx #22 ;* no. of lines
ldy #0
tone2:
lda #199
sta (sl),y
lda sl
clc
adc #40
sta sl
lda sl+1
adc #0
sta sl+1
dex
bpl tone2
; thats the left side (remember
; that it mirror's it later !)
ldy #15
lda #199
tone3:
sta (sl),y
dey
bpl tone3
; created a blank room (i hope)
tufluk:
; now mirror it
lda #<scrbuf
sta lmirr+1
sta rmirr+1
lda #>scrbuf
sta lmirr+2
sta rmirr+2
lda #23
sta ycount
lp4:
ldx #0
ldy #31
lp5:
lmirr:
rmirr:
inx
dey
cpy #15
bne lp5
lda lmirr+1
clc
adc #40
sta lmirr+1
sta rmirr+1
lda lmirr+2
adc #0
sta lmirr+2
sta rmirr+2
dec ycount
bpl lp4
; it's done - c'est fini !
; - no !! put the doors in !
ldx screen
lda doordt,x
sta temp
ldx #200 ;* door char
and #1
beq ndr
stx scrbuf+$1b8+31
stx scrbuf+$1e0+31
ndr:
lda temp
and #2
beq ndl
stx scrbuf+$1b8
stx scrbuf+$1e0
ndl:
lda temp
and #4
beq ndu
stx scrbuf+15
stx scrbuf+16
ndu:
lda temp
and #8
beq ndd
stx scrbuf+$398+$f
stx scrbuf+$398+$10
ndd:
rts

doordt:
; data as follows :-
; bit #76543210
; dulr
.byte %00001001
.byte %00001011
.byte %00001011
.byte %00001011
.byte %00001010
.byte %00001101
.byte %00001111
.byte %00001111
.byte %00001111
.byte %00001110
.byte %00001101
.byte %00001111
.byte %00001111
.byte %00001111
.byte %00001110
.byte %00001101
.byte %00001111
.byte %00001111
.byte %00001111
.byte %00001110
.byte %00000101
.byte %00000111
.byte %00000111
.byte %00000111
.byte %00000110

; ------------------------------------------------------------------------------
; MODULE: MOVEPIXE

; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------
; MOVEMN - Move Player Character
; ------------------------------------------------------------------------------
; Main player movement handler:
; - Prints player at new position
; - Processes movement input
; - Checks collisions
; - Handles death and room transitions
; - Updates pixel-level positioning
movemn:
; move the man (in pixels !!)
jsr print ;* print new man
jsr mnmove ;* move him
ldx chkx
ldy chky
jsr check ;* check
lda hit
beq itsok ;* no hit
jsr death ;* hit alien ?
lda dead ;* died ?
bne esc
jsr chgrom ;* change room ?
lda newrom
bne esc
; are we going to change room ?
lda trx
sta manx
lda try
sta many
lda temdir
sta dir
lda #0
sta going
sta xpix
sta ypix
sta hit
itsok:
jsr uppixe ;* move pixels
esc:
rts
; ---------***********----------
; Print player character at current position
; Handles pixel-offset animation (4 positions per character)
; Erases old position, draws new position with proper facing direction
print:
ldx trx
ldy try
dey
jsr xy
jsr bugrub ;* rub him out
; ldx #13   ;* to get rid of bug!
; ruub1
; ldy yrub,x
; lda (sl),y
; cmp #148
; bcc dntrub
; cmp #148+48
; bcs dntrub
; lda #196
; sta (sl),y
; dntrub
; dex
; bpl ruub1
ldx manx
ldy many
jsr xy
lda ypix
bne noway
lda xpix
beq normpr
noway:
lda #0
sta keepon ;* moving again
sta antfag
lda dir
cmp #3
bcs prnty
ldx xpix
lda time6,x
clc
adc #148 ;* base char
sta char
ldx #0
prt1:
ldy waly,x
lda char
sta (sl),y
inc char
lda #$79
sta (cl),y
inx
cpx #6
bne prt1
rts
time6:
yrub:
.byte 0,1,39,40,41,42,43
.byte 79,80,81,82,83
.byte 120,121
normpr:
lda antfag ;* !!
bne qrump
ldx #1
stx keepon
stx antfag
dex
stx mancnt
lda #10
sta gloptm
; set up glop animation when stop.
qrump:
lda dir
and #3
beq normp
ldx manx
inx
ldy many
dey
jsr xy
normp:
ldx #3
genars:
lda achar,x
ldy ychin,x
sta (sl),y
lda #$79
sta (cl),y
dex
bpl genars
rts
achar:
ychin:
; ****************************
prnty:
ldx ypix
lda time6,x
clc
adc #148+24 ;* base char + 24
sta char
ldx #0
prt2:
ldy yval2,x
lda char
sta (sl),y
lda #$79
sta (cl),y
inc char
inx
cpx #6
bne prt2
rts
yval2:
.byte 0,1,40,41,80,81
; *********
; Process player movement input
; Reads jleft/jright/jup/jdown flags
; Updates player position (manx, many)
; Handles diagonal movement conversion
; Sets pixel offset for smooth scrolling
mnmove:
lda xpix
bne getout ;* cant go left/right
lda ypix
bne getout ;* cant go up/down
lda manx
sta trx
lda many
sta try
lda dir
sta temdir
bit jfire ;* lay a bomb !
bpl nolay
jsr bomb ;* start one if you can
nolay:
bit jleft
bpl nleft
lda dir
and #$0c
beq broun3
inc many
dec manx
broun3:
ldx #1
stx dir ;* 1 - left
stx going
dex
stx xpix
stx rustic
ldx manx
stx chkx
ldy many
sty chky
getout:
rts
nleft:
bit jright
bpl nright
inc manx
lda dir
and #$0c
beq broun4
dec manx
inc many
broun4:
ldx #3
stx xpix
dex
stx dir ;* 2 - right
dex
stx rustic
stx going
ldy many
sty chky
ldx manx
inx
stx chkx
rts
nright:
bit jup ;* up ?
bpl nup
lda dir
and #$03
beq bround
inc manx
dec many
bround:
lda #4
sta dir ;* 4 - up
ldx #1
stx going
dex
stx rustic
stx ypix
ldx manx
stx chkx
ldy many
sty chky
rts
nup:
bit jdown ;* down ?
bpl getout
lda dir
and #$03
beq broun2
dec many
inc manx
broun2:
lda #8 ;* 8 = down
sta dir
lda #3
sta ypix
lda #1
sta going
sta rustic
inc many
ldx manx
stx chkx
ldy many
iny
sty chky
rts

; Update pixel position for smooth character movement
; Increments xpix or ypix based on direction
; Wraps to next character position when reaching 4 pixels
uppixe:
lda going
beq sit
lda rustic
beq kill
lda #0
sta rustic
sit:
rts
kill:
lda #1
bit dir
bne mvelft
asl a ; acc = 2
bit dir
bne mverit
asl a ; acc = 4
bit dir
bne mveup
asl a ; acc = 8
bit dir
bne mvedwn
; should never get here !
mvelft:
inc xpix
lda xpix
tay
and #3
sta xpix
cpy #4
beq stopl
rts
stopl:
lda #0
sta xpix
sta going
dec manx
rts
mverit:
dec xpix
lda xpix
tay
and #3
sta xpix
cpy #$ff
beq stopr
rts
stopr:
lda #0
sta xpix
sta ypix
sta going
rts
mvedwn:
dec ypix
lda ypix
tay
and #3
sta ypix
cpy #$ff
beq stopr
rts
mveup:
inc ypix
lda ypix
tay
and #3
sta ypix
cpy #4
beq stopu
rts
stopu:
lda #0
sta ypix
sta going
dec many
rts

; rub out all alien (sl) must
; point to tl-2
bugrub:
ldx #13 ;* to get rid of bug!
ruub1:
ldy yrub,x
lda (sl),y
cmp #148+48
bcs dntrub
cmp #148
bcs dorbut
cmp #32
bcs dntrub
dorbut:
lda #196
sta (sl),y
dntrub:
dex
bpl ruub1
rts

; ------------------------------------------------------------------------------
; MODULE: CHECKMAN

; ------------------------------------------------------------------------------
; check mans pos.
; ------------------------------------------------------------------------------
; CHECK - Collision Detection
; ------------------------------------------------------------------------------
; Checks if player can move to specified position
; Tests for walls, doors, aliens, jigsaw pieces
; Input: X = chkx, Y = chky
; Output: hit flag (0=OK, non-zero=collision type)
check:
; called with x,y set up
jsr xy ;* convert to screen
ldx #3
rub1:
ldy yval2,x
lda (sl),y
sta behind,x ;* save to buffer
cmp #197
bcc ckok
cmp #244
bcs ckok
lda #1
sta hit
ckok:
dex
bpl rub1
rts

manded:
; called when the explosion
; is on the screen to see if
; the man died.
; *nb manl,manl+1 have been
; set up with the tl address
; of the man before the
; explosion started.
ldx #3
mnde2:
ldy yval2,x
lda (manl),y
cmp #248 ;* explosion char
bne butds ;* not died !
lda #1
sta dead
sta dedbmb ;* died by bomb
butds:
dex
bpl mnde2
rts

findtl:
lda #22
sta temp
finde1:
ldx #0
ldy temp
jsr xy
ldy #30
finde2:
lda (sl),y
cmp #28
bne nxtfnd
sty ty
lda sl
clc
adc ty
sta manl
lda sl+1
adc #0
sta manl+1
rts
nxtfnd:
dey
bne finde2
dec temp
bne finde1
findno:
inc $ff19
jmp findno

; ------------------------------------------------------------------------------
; MODULE: CHANGERO

; ------------------------------------------------------------------------------
; all the stuff related with
; moving to another room.
; ------------------------------------------------------------------------------
; CHGROM - Change Room Handler
; ------------------------------------------------------------------------------
; Detects when player reaches screen edge
; Sets up transition to adjacent room in 5x5 grid
; Updates xpos/ypos (grid position)
; Sets newrom flag for main loop to process
chgrom:
; check buffer 'behind' to see
; if there is a door there.
ldy #0
ldx #3
clk:
lda behind,x
cmp #200 ;* door char
bne nxt
iny
nxt:
dex
bpl clk
cpy #2
beq newbod
rts
newbod:
; there were two door chars so
; he must be right next to a door
; by looking at the value of
; 'dir' 0-left 1-right 2-up 4-down
; it is known which way he has
; moved
lda #1
sta newrom ;* tell basic loop
sta stop ;* to change to new
; ;* room
rts

; called by the basic loop
; to move to a new room - the
; basic loop has control.
; Bring on new room after transition
; Decodes new screen data
; Initializes aliens for new room
; Updates display
roomon:
; lda #1
; sta stop    ;* halt everything
; will already have been done
lda #1
bit dir
bne scrlft ;* going left
asl a
bit dir
bne scrrgt ;* going right
asl a
bit dir
bne scrup ;* going up
asl a
bit dir
bne scrdwn
rts
; ----------
scrrgt:
inc xpos
lda #0
sta manx
lda #11
sta many
jmp jmpbak
; ************
scrlft:
dec xpos
lda #28
sta manx
lda #11
sta many
jmp jmpbak
; ************
scrdwn:
inc ypos
lda #15
sta manx
lda #0
sta many
jmp jmpbak
; **********
scrup:
dec ypos
lda #15
sta manx
lda #20
sta many
; jmp jmpbak
jmpbak:
; all the above routines must
; jump back here to continue
ldy ypos
lda time5,y
clc
adc xpos
sta screen ;* 0 - 24
tax
lda gotbit,x ;* cleared this room?
sta cleard ;* 0 = no
jsr setlvl ;* set level vars
ldx #0
stx prtals
stx newrom
stx going
stx xpix
stx ypix
stx bombon ;* kill the bomb if
stx bombgo ;* changing rooms
; jsr inital ;* start new aliens
jsr decode ;* put new screen on
lda #$10
sta delly ;* delay for fade in
jsr fadein ;* copy it onto screen
lda cleard
bne tenson
; print jig-piece if room not
; cleared yet
jsr prpice ;* print jigsw piece
jmp drink
tenson:
jsr gotmes ;* print mess if done
lda #7
sta almvet
drink:
lda manx
sta savex
lda many
sta savey
lda dir
sta savdir
lda #14
sta chkx
lda #10
sta chky
lda duck
bne frut
jsr initkl ;* number to kill
frut:
; jsr setlvl  ;* set level vals
jsr inital ;* start aliens
lda #0
sta stop
rts ;* return to basic 'loop'


; ------------------------------------------------------------------------------
; MODULE: TABLES

; ------------------------------------------------------------------------------
; mega tables
time5:

tim32:
.byte 0,32,64,96,128
.byte 160,192,224

waly:
.byte 0,1,2,40,41,42

; ------------------------------------------------------------------------------
; MODULE: RADARSCA

; ------------------------------------------------------------------------------
; ------------------------------------------------------------------------------
; RADAR - Update Mini-Map Display
; ------------------------------------------------------------------------------
; Updates 5x5 room grid radar display
; Shows current position, visited rooms, jigsaw locations
; Updates radbuf with current state
radar:
; one call to print/update the
; radar scanner
ldy #7
lda #255
wal1:
sta $3e50,y
dey
bpl wal1
; radar char cleared
ldx manx
inx
txa
lsr a
lsr a
; /4
tay
lda bbts,y
pha
; ldx many
; ldy lookup,x
lda many
lsr a
lsr a
tay ;* rustic / 3
iny
pla
sta $3e50,y
; ldx #24
; wal2
; lda #201
; sta radbuf,x
; dex
; bpl wal2
; ldy ypos
; lda time5,y
; clc
; adc xpos
; tay
; ldy screen
; lda #202
; sta radbuf,y
; now lets print it
ldx #24
wal3:
; lda radbuf,x
ldy rady,x
lda #201
cpx screen
bne yhtfs
lda #202
yhtfs:
sta $ef2,y ;* onto screen
cmp #201
beq ods
lda #$66
bne osd
ods:
lda #$41
osd:
sta $ef2-$400,y ;* do the colour
dex
bpl wal3
rts
bbts:
.byte $7f,$bf,$df,$ef
.byte $f7,$fb,$fd,$fe
lookup:
; .byte 0,0,0,1,1,1,2,2,2
; .byte 3,3,3,4,4,4,5,5,5
; .byte 6,6,6,7,7,7,8,8,8
rady:
.byte 0,1,2,3,4
.byte 40,41,42,43,44
.byte 80,81,82,83,84
.byte 120,121,122,123,124
.byte 160,161,162,163,164

; ------------------------------------------------------------------------------
; MODULE: INITROOM

; ------------------------------------------------------------------------------
; called at the start of every
; game to set up the following
; tables :-
; jignum
; ------
; what piece number of the
; jigsaw is in this room
; romnum
; ------
; the screen data for that room.
; gotbit
; ------
; have we cleared this room ?
; Initialize room randomization
; Sets up romnum array for screen data mapping
; Prepares door configuration
rooms:
; ldx #3
; roomfl
; lda ted,x
; sta rnd,x
; dex
; bpl roomfl
jsr setup
; nice & random
jsr rndbuf ;* random buffer
ldx #24
wrd2:
lda scrbuf+25,x
sta jignum,x
dex
bpl wrd2
jsr rndbuf ;* random buffer
ldx #24
wrd3:
lda scrbuf+25,x
sta romnum,x
lda #0
sta gotbit,x
; clear that table
dex
bpl wrd3
rts

rndbuf:
; fill scrbuf+25 to (scrbuf+25)+24
; with 0-24
ldx #24
lda #0
wdr1:
sta scrbuf,x
dex
bpl wdr1
lda #0
sta xcount
wddr:
jsr random
lda rnd+2
and #31
cmp #25
bcs wddr
tay
tax
lda scrbuf,x
bne wddr
; that no. already used
lda #1
sta scrbuf,x
; used now. !
tya
ldx xcount
sta scrbuf+25,x
inc xcount
lda xcount
cmp #25
bne wddr
rts

; ------------------------------------------------------------------------------
; MODULE: DUMPER

; ------------------------------------------------------------------------------
; copies the 'scrbuf' to the
; screen - gloppily.
fadein:
lda multi1
pha
lda multi2
pha
jsr clswin
; clear window
lda sndflg
beq nsnd1
lda #%00101111 ;* chan#2
sta vol
nsnd1:
lda #3
sta count
; 4 chars to copy across
cop1:
lda #8
sta temp ;* luminence count
jsr random
lda rnd+1
and #3
sta sou2hi
; random hi-bit start
lda rnd+2
and #$80
sta sou2lo
; lo-bit start at 0 or 128
cop4:
lda sou2lo
clc
adc #16
sta sou2lo
lda sou2hi
adc #0
sta sou2hi
lda #<$c00
sta ol
lda #>$c00
sta ol+1
lda #<scrbuf
sta dl
lda #>scrbuf
sta dl+1
ldx count
lda compar,x ;* copy table
sta copy
lda coltbl,x ;* colour of blocks
ldx temp
ora lumin,x ; ora in brightness
sta colour
lda multi1 ;* aux col.1
and #$f
ora lumin,x
sta multi1
lda multi2 ;* aux col.2
and #$f
ora lumin,x
sta multi2
ldx #23
cop2:
ldy #31
cop3:
lda (dl),y ;* get buffer copy
cmp copy ;* the one to copy ?
bne wrong ;* not this one.
sta (ol),y ;* onto screen
lda ol
sta cl
lda ol+1
sec
sbc #4
sta cl+1
lda colour
sta (cl),y ;* put a colour on
wrong:
dey
bpl cop3 ;* finish line
lda ol
clc
adc #40
sta ol
lda ol+1
adc #0
sta ol+1
lda dl
clc
adc #40
sta dl
lda dl+1
adc #0
sta dl+1
dex
bpl cop2 ;* all the lines
ldx delly ;* set up before called
jsr delay+2
dec temp
bmi copo4
jmp cop4
copo4:
dec count ;* 4 chars to copy
bmi copo1
jmp cop1
copo1:
lda #0
sta vol ;* sound off
pla
sta multi2
pla
sta multi1
rts
compar:
.byte 199,198,200,197
coltbl:
lumin:
.byte $50
.byte $70,$60,$50,$40
.byte $30,$20,$10,$00
; the first byte is the luminence
; that you want left on

; ------------------------------------------------------------------------------
; MODULE: ALIENSME

; ------------------------------------------------------------------------------
; all the alien stuff
inital:
ldx #7
alpo1:
lda #$ff
sta irqprt,x
sta irqrub,x
sta alipos,x
dex
bpl alpo1
ldx #3
lda #1
alap2:
sta alitim,x
dex
bpl alap2
lda nokild ;* a check in case
cmp alkill ;* this is called when
bne mjore ;* all aliens killed
rts ;*
mjore:
; set them up
ldx #7
al11:
lda alstat,x
sta alipos,x ;* rub x,y 's
dex
bpl al11
pochin:
jsr getdef ;* char type ?
lda #1
sta alycnt
rts
alstat:
; all starting positions

; ------------------------------------------------------------------------------
; MVEALI - Move Aliens
; ------------------------------------------------------------------------------
; AI system for all active aliens in current room
; Uses pattern-based movement from variety table
; Checks collisions, updates positions
; Tempo-controlled for difficulty scaling
mveali:
; called by the basic loop
; move them
lda #0
sta prtals ;* dont print
ldx #7
alim1:
lda irqprt,x
sta irqrub,x
dex
bpl alim1
; transfer print postions to
; rub postions
ldx manx
ldy many
lda dir
and #3
beq irro1
inx
irro1:
lda dir
and #$0c
beq irro2
iny
irro2:
stx compx
sty compy
; tl of man
lda #3
sta alicnt ;* alien count
alim2:
lda alicnt
asl a
tax
lda alipos,x
cmp #$ff ;* is he dead ?
beq knaked ;* yes.
sta alx
lda alipos+1,x
sta aly
; x & y positions got
txa
pha
jsr mvehim ;* move him
pla
pha
tax
lda aly
sta alipos+1,x ;* new y pos.
tay
lda alx
sta alipos,x ;* new x pos.
tax
jsr xy
pla
tax
lda sl
sta irqprt,x
lda sl+1
sta irqprt+1,x
; screen address in irq table
jmp m25
knaked:
lda #$ff
sta irqprt,x
sta irqprt+1,x
stx point
ldx alicnt
dec alitim,x ;* start it ?
bne m25 ;* not ready yet
ldx point
lda alstat,x ;* start pos
sta alipos,x
lda alstat+1,x
sta alipos+1,x
; start him again
m25:
dec alicnt
bpl alim2
; all done
lda #1
sta prtals
rts

mvehim:
; move the aliens at alx,aly
lda alx
cmp compx ;* x pos. the same ?
beq tryyxs
lda alx
sec
sbc compx
bmi mle1
jsr alleft
lda move
bne mved
mle1:
jsr alrigt
lda move
bne mved ;* he's made a decision
tryyxs:
lda aly
sec
sbc compy
bmi mle3
jsr alup
lda move
bne mved
mle3:
jsr aldown
mved:
lda #0
sta move
rts
; ******************************
; do all the trying to move
alleft:
; try left
ldx alx
dex
ldy aly
jsr chkalx ;* check pos x axis
lda move
beq cle
dec alx
; was allowd to go left
cle:
rts

alrigt:
; try right
ldx alx
inx
inx
ldy aly
jsr chkalx ;* check pos x axis
lda move
beq cr
inc alx
; allowd to go right
cr:
rts
; ***********************
alup:
; try up
ldx alx
ldy aly
dey
jsr chkaly ;* check pos y axis
lda move
beq cu
dec aly
; allowd to go up
cu:
rts
; ***********************
aldown:
; try down
ldx alx
ldy aly
iny
iny
jsr chkaly ;* check pos y axis
lda move
beq cd
inc aly
; allowd to go down
cd:
rts

; ------------------------------------------------------------------------------
; MODULE: ALIENCHE

; ------------------------------------------------------------------------------
; print and check the aliens
chkalx:
; check in x axis
stx chekx
sty cheky
jsr xy
ldy #0
lda (sl),y
cmp #196
bne nomve ;* cant move
ldy #40
lda (sl),y
cmp #196
bne nomve ;* cant move
beq canmv
chkaly:
stx chekx
sty cheky
jsr xy
ldy #0
lda (sl),y
cmp #196
bne nomve ;* cant move
iny
lda (sl),y
cmp #196
bne nomve ;* cant.
canmv:
; we can go for it.!
lda #1
sta move
rts
nomve:
lda #0
sta move
rts

; Print all aliens at their current positions
; Uses character animation from alibuf
; Handles alien sprite cycling
prnals:
; print & rub aliens
lda prtals
bne doit
rts
doit:
lda #3 ;* print them all
sta alicnt
alilop:
lda alicnt
asl a
tax
stx point ;* save pointer
lda irqrub,x
sta al
lda irqrub+1,x
sta al+1
cmp #$ff ;* was it dead ?
beq misor
ldx #3
alilp1:
lda #196
ldy yval2,x
sta (al),y
dex
bpl alilp1
ldx point ;* get pointer
lda irqprt,x
sta al
sta cl
lda irqprt+1,x
sta al+1
sec
sbc #4
sta cl+1
; colour
ldx #3
lda #212
sta char
alilp2:
ldy yval2,x
lda char
sta (al),y
lda #$7c
sta (cl),y ;* colour
dec char
dex
bpl alilp2
misor:
dec alicnt
bpl alilop
rts
; ******************************
alihit:
; check if any aliens were killed
; by the explosion.
lda #3
sta alicnt
lda #0
sta bonus
cjpl1:
lda alicnt
asl a
tax
stx point ;* save pointer
lda irqprt,x
sta al
lda irqrub,x
sta ar
lda irqrub+1,x
sta ar+1
lda irqprt+1,x
sta al+1
cmp #$ff
beq cjpl3 ;* might be dead
; got address
ldx #3
cjpl2:
ldy yval2,x
lda (al),y
cmp #248 ;* bomb char
beq aligt ;* got the bugger !
dex
bpl cjpl2
bmi cjpl3
aligt:
ldx #3
cjpl4:
lda #196
ldy yval2,x
sta (al),y
sta (ar),y
dex
bpl cjpl4
; rub it out straight away
ldx point
lda #$ff
sta irqprt,x
sta irqrub,x
sta irqprt+1,x
sta irqrub+1,x
sta alipos,x
sta alipos+1,x
; kill it from table
inc bonus
ldx alicnt
; lda #20
lda ted+2
and #15
clc
adc #15
; random regeneration time 5-20
sta alitim,x
; time until alien regenerates
; (individual timers for each)
lda cleard
beq juytt
lda #1
ldy #4
jsr score+2
; only score 10 if you have
; cleared this screen
jmp hewq
juytt:
lda #5
jsr score
lda #2
ldy #4
jsr score+2
; aliens = 25 points
hewq:
lda bonus
cmp #4
bne nobons
; he cleared all the aliens in
; one go - wooowww
lda #1
ldy #3
jsr score+2
; bonus 100 points
nobons:
jsr killed ;* update no. killed
cjpl3:
dec alicnt
bmi cjpl5
jmp cjpl1
cjpl5:
rts

; ------------------------------------------------------------------------------
; MODULE: INKEY

; ------------------------------------------------------------------------------
; a call to this routine
; returns the acc. with :-
; 0     = no key pressed
; 1-26  = a-z
; 27    = space
; 28    = return
; 29    = delete
inkey:
lda #0
sta keyval
ink1:
lda keyval
asl a
tax
inc keyval
lda inkdat,x
tay
lda inkdat+1,x
jsr keyit ;* check it
bcc noinky ;* not pressed
lda keyval ;* return with val
rts
noinky:
lda keyval
cmp #29
bne ink1
lda #0
rts
inkdat:
.byte $fd,$04,$f7,$10,$fb,$10
.byte $fb,$04,$fd,$40,$fb,$20
.byte $f7,$04,$f7,$20,$ef,$02
.byte $ef,$04,$ef,$20,$df,$04
.byte $ef,$10,$ef,$80,$ef,$40
.byte $df,$02,$7f,$40,$fb,$02
.byte $fd,$20,$fb,$40,$f7,$40
.byte $f7,$80
.byte $fd,$02,$fb,$80,$f7,$02
.byte $fd,$10
.byte $7f,$10
.byte $fe,$02,$fe,$01

; ------------------------------------------------------------------------------
; MODULE: ANIMATEC

; ------------------------------------------------------------------------------
; animate chars for mega-
; gloppiness.
; ------------------------------------------------------------------------------
; ANIMAT - Animate Characters
; ------------------------------------------------------------------------------
; Cycles animated characters (water, fire, etc.)
; Updates character definitions in RAM
; Tempo-controlled for smooth animation
animat:
jsr aniexp ;* explosion char
lda stpman ;* stop man ani ?
bne droyt
jsr manglp ;* animate man
droyt:
jsr aliani ;* alien animation
dec anitem
beq fgre
rts
fgre:
lda #7
sta anitem
ldx bdcnt ;* border char count
inx
cpx #6
bne ntena
ldx #0
ntena:
stx bdcnt
lda aniseq,x
asl a
asl a
asl a
tax
ldy #0
ani1:
lda xdat,x
sta $3e58,y
lda ydat,x
sta $3e60,y
inx
iny
cpy #8
bne ani1
; now do the brick chars
inc brkcnt
lda brkcnt
cmp #3
bne ntlsbk
lda #0
sta brkcnt
ntlsbk:
asl a
asl a
asl a
tax
ldy #0
brklop:
lda brik1,x
sta $3e38,y
lda brik2,x ;* door char
sta $3e40,y
lda brik3,x
sta $3e30,y
inx
iny
cpy #8
bne brklop
rts

aniexp:
; explosion char data
jsr random
ldx rnd+1
ldy #0
exp1:
lda $8000,x ;* random data
sta $3fc0,y
inx
iny
cpy #8
bne exp1
lda bombgo
beq frout ;* dont do it
ldx #31
dsar:
lda $3960,x
eor ted
and $3fa0,x
sta $3960,x
dex
bpl dsar
; fizzle bomb during explosion
frout:
rts

manglp:
; comes here when stopped even
; if for only a short time
lda keepon
bne storp
ldx #0
beq geetin ;* set norm char
storp:
dec gloptm
beq grunty
rts
grunty:
lda #45
sta gloptm
ldy mancnt ;* man anicount
; set up before here.
ldx tim32,y
; *32
geetin:
ldy #0
frod:
lda balman,x
sta $38e0,y
inx
iny
cpy #32
bne frod
ldx mancnt
inx
cpx #4
bne face
ldx #2
face:
stx mancnt
; animation goes :-
; 0,1,2,3,2,3,2,3,2,3,2,3
; good eh!!
rts
; ********************************
aniseq:
xdat:
; char data for horizontal border
; character.
.byte $00,$00,$81,$ff,$ff,$81,$00,$00
.byte $00,$00,$c3,$7e,$7e,$c3,$00,$00
.byte $00,$00,$e7,$3c,$3c,$e7,$00,$00
.byte $00,$00,$ff,$18,$18,$ff,$00,$00
ydat:
; data as above but for vertical
; character
.byte $3c,$18,$18,$18,$18,$18,$18,$3c
.byte $24,$3c,$18,$18,$18,$18,$3c,$24
.byte $24,$24,$3c,$18,$18,$3c,$24,$24
.byte $24,$24,$24,$3c,$3c,$24,$24,$24
; ********************************
brik1:
; gloppy brick chars
.byte $6d,$6d,$fe,$fe,$bf,$bf,$79,$79
.byte $b6,$b6,$7f,$7f,$fd,$fd,$9e,$9e
.byte $db,$db,$bd,$bd,$7e,$7e,$e7,$e7
brik2:
; another gloppy brik char
.byte $55,$7d,$7d,$7d,$7d,$7d,$7d,$55
.byte $55,$69,$55,$7d,$7d,$55,$69,$55
.byte $55,$69,$69,$55,$55,$69,$69,$55
brik3:
; another gloppy brik char
.byte $55,$69,$55,$7d,$7d,$7d,$7d,$55
.byte $55,$69,$69,$69,$55,$7d,$7d,$55
.byte $55,$69,$69,$69,$69,$69,$55,$55

balman:
.byte $00,$05,$17,$1f,$5f,$7f,$7f,$77
.byte $00,$50,$94,$a4,$e5,$e9,$f9,$f9
.byte $77,$77,$75,$7d,$5d,$1f,$17,$05
.byte $f9,$f9,$f9,$e9,$e5,$a4,$94,$50
.byte $01,$17,$1b,$1d,$06,$17,$1f,$5f
.byte $40,$d4,$e4,$74,$90,$94,$e4,$e5
.byte $7f,$77,$75,$7d,$5f,$1f,$17,$05
.byte $e9,$f9,$f9,$f9,$e5,$e4,$94,$50
.byte $05,$17,$1f,$1f,$1e,$1f,$07,$16
.byte $50,$d0,$74,$fd,$fd,$a5,$d0,$94
.byte $1f,$5f,$7f,$77,$5f,$1f,$17,$05
.byte $e4,$e5,$f9,$f9,$e5,$e4,$94,$50
.byte $05,$07,$1d,$7f,$7f,$5a,$07,$16
.byte $50,$d4,$f4,$f4,$b4,$f4,$d0,$94
.byte $1f,$5f,$7f,$77,$5f,$1f,$17,$05
.byte $e4,$e5,$f9,$f9,$e5,$e4,$94,$50
; *****************
aliani:
dec alycnt
beq hug
rts
hug:
lda #20
sta alycnt
inc deftem
lda deftem
and #1
tay
ldx tim32,y
; pointer to char data in alibuf
ldy #0
comuni:
lda alibuf,x
sta $3e88,y
inx
iny
cpy #32
bne comuni
rts

; ------------------------------------------------------------------------------
; MODULE: BORDER

; ------------------------------------------------------------------------------
prbder:
; print the border chars on
; the window on the right.
ldx #6
prb1:
lda #203
sta $c20,x ;* glop char
sta $fb8,x ;* glop char
sta $db0,x ;* glop char
sta $ec8,x ;* glop char
lda #$71
sta $820,x
sta $bb8,x
dex
bne prb1
; now the sides
lda #22
sta ty
prb2:
ldx #32
ldy ty
jsr xy
ldy #0
lda #204
sta (sl),y
lda #$71
sta (cl),y
ldy #7
lda #204
sta (sl),y
lda #$71
sta (cl),y
dec ty
bne prb2
ldx #205
stx $c20
inx
stx $c27
inx
stx $f98+32
inx
stx $f98+31+8
; corner chars on
ldx #249
stx $db0
stx $ec8
inx
stx $db7
stx $ecf
; mid bits
rts

; ------------------------------------------------------------------------------
; MODULE: JIGSAWCO

; ------------------------------------------------------------------------------
; jigsaw stuff
prpice:
; print the piece of jigsaw
; in a box in the middle of
; the screen.
ldx screen ;* screen number
lda jignum,x ;* jig piece in room
asl a
asl a
asl a
tax
ldy #0
jig1:
lda $3eb8,x ;* char 215-
sta jigbuf,y
inx
iny
cpy #8
bne jig1
; char data now in 'jigbuf'
lda #7
sta count
jig2:
lda count
tay
asl a
tax
lda jigbuf,y
pha
lsr a
lsr a
lsr a
lsr a
jsr xpand
sta $3f80,x ;* char 240-
sta $3f81,x ;* (double height)
pla
and #$f
jsr xpand
sta $3f90,x ;* char 242-
sta $3f91,x ;* double height
dec count
bpl jig2
ldx #15
jig4:
ldy jigyvl,x
lda jigchr,x
sta $dc7-41,y
lda jigcol,x
sta $dc7-41-$400,y
dex
bpl jig4
; now in the centre of the screen
rts
jigbuf:
jigyvl:
.byte $00,$01,$02,$03
.byte $28,$29,$2a,$2b
.byte $50,$51,$52,$53
.byte $78,$79,$7a,$7b
jigchr:
.byte 205,203,203,206
.byte 204,240,242,204
.byte 204,241,243,204
.byte 207,203,203,208
jigcol:
.byte $71,$71,$71,$71
.byte $71,$42,$42,$71
.byte $71,$42,$42,$71
.byte $71,$71,$71,$71
xpand:
sta work ;* save char
ldy #3
jig3:
lsr work
php
ror work+1
plp
ror work+1
dey
bpl jig3
lda work+1
rts

gotmes:
; print the message in the empty
; room if the piece has been got
lda #6
sta tx
lda #11
sta ty
lda ted
and #7
ora #$70
sta prcol
ldx #0
gorme1:
txa
pha
lda gotms,x
jsr dubhit ;* print dbl
pla
tax
inc tx
inx
cpx #19
bne gorme1
; now print box
; nb x = 19 now
gorme2:
lda #203
sta $d6e+40,x
sta $d6e+160,x
dex
bpl gorme2
ldx #204
stx $d95+40
stx $d95+80
stx $d95+40+21
stx $d95+80+21
; sides now on
inx ;* = 205
stx $d6d+40
inx
stx $d6d+40+21
inx
stx $d6d+160
inx
stx $d6d+160+21
; corners on
ldx #40
stx $da9+40
inx
stx $da9+80
; ! on
rts
gotms:
.byte "you have this piece"

transf:
; transfer the bit in the middle
; to the jigsaw
ldx screen
lda jignum,x
clc
adc #215
sta stopa
; acc=jig char num
ldx #0
shveit:

; space
ldy rady,x
lda $e02,y
cmp #27
bne nkip
lda stopa ;* get char
sta $e02,y ;* onto screen
jmp eatyre
nkip:
inx
cpx #25
bne shveit
eatyre:
lda #32
sta $dc7
sta $dc7+40
sta $dc8
sta $dc8+40
; rub out piece on screen
jsr coljig
rts

; ------------------------------------------------------------------------------
; MODULE: BOMBCODE

; ------------------------------------------------------------------------------
; all the time-bomb stuff
; Initiate bomb placement
; Checks if bomb is ready (bready flag)
; Sets bomb position at player location
; Starts countdown timer
bomb:
; the time-bomb will work as
; follows :-
; 1> fire button drops a bomb
; & sets up a timer
; 2> timer counts down
; 3> a rustic fill
lda bombon ;* bomb already on ?
bne bm1
lda bready ;* bomb recharged ?
beq bm1 ;* not yet
ldx manx
ldy many
lda dir
and #3
beq berm1
inx
berm1:
lda dir
and #$c
beq berm2
iny
berm2:
stx bomx
sty bomy ;* tl co-ord
jsr xy
lda sl
sta bomsl
sta bomcl
lda sl+1
sta bomsl+1
lda cl+1
sta bomcl+1
; get screen and colour address
lda #55
sta timer ;* count down
ldx #1
stx bombon ;* one's on now.
dex
stx bombgo
lda sndflg
beq bm1
lda #$2f
sta vol
; chan #2,normal (noise later)
lda #0
sta sou2hi
sta sou2lo
bm1:
rts

; ------------------------------------------------------------------------------
; UPBOMB - Update Bomb Timer
; ------------------------------------------------------------------------------
; Decrements bomb timer each frame
; Triggers explosion when timer reaches zero
; Handles bomb recharge delay
upbomb:
; called under interrupt to
; count the timer down & does
; a flag to tell the basic loop
; to do the explosion.
jsr ready ;* update charger
lda bombon
beq timoot
; only do this if the bomb is on
jsr bomprt ;* print it (flash)
dec timer
beq stbomb ;* lo byte
lda #56
sec
sbc timer ;* inverse
asl a
rol moron
asl a
rol moron
asl a
rol moron
asl a
rol moron
sta sou2lo ;* sound *16
lda moron
sta sou2hi ;* sounh hi
timoot:
rts
stbomb:
lda #1
sta bombgo ;* tell basic to go!
rts

; BASIC bomb explosion handler
; Called from main loop when bombgo flag set
; Triggers actual explosion effect
basbom:
; called by the basic loop to
; do the whooppee explosion.
lda bombgo
bne gobomr
rts
gobomr:
lda antfag
beq gobomr
; wait for man to be in a char.
; (so we have no hassle detecting)
; we are in control.
lda #$ff
sta sou2lo
sta sou2hi
lda sndflg
beq stew2
lda #$4f
sta vol ;* noise now
stew2:
ldx #1
stx stop ;* no irq's
; insert mega/code here.
jsr findtl
; find the address of the tl of
; the man for use after the fill
; to see if he died
jsr filbmb
; do the bomb fill
sei
ldx #31
clbmbc:
lda #0
sta $3960,x
dex
bpl clbmbc
; clear charge char
; now stop all bomb stuff.
lda #0
sta stop
sta bombgo
sta bombon
sta bready ;* start charge
sta chtime ;* charge time
sta vol ;* sound off
cli
rts
; *****************************
bomprt:
; print it
ldx #3
lda #247
sta char
lda ted
ora #%00001000
sta bmbcol ;* multi colour
sod1:
ldy yval2,x
lda char
sta (bomsl),y
lda bmbcol
sta (bomcl),y ;* flash colour
dec char
dex
bpl sod1
rts

ready:
; do the chargeing of the bomb
; set 'bready' to 1 if ok.
lda bready
beq upchrg
; whats the use - its ready !
kwah:
rts
upchrg:
dec chtime ;* timer
bne chrge
lda #1
sta bready
jsr copybm
; copy full bomb across
rts
chrge:
; update the char
; the chars that are used as the
; recharging bomb are
; $2c,$2d
; $2e,$2f
lda chtime
and #$0f
bne kwah ;* wait for top
; ;* bit to change
; now scroll char up to make
; room for new data
lda $3970
pha
lda $3978
pha
ldx #0
scrol:
lda $3961,x
sta $3960,x
lda $3969,x
sta $3968,x
lda $3971,x
sta $3970,x
lda $3979,x
sta $3978,x
inx
cpx #7
bne scrol
pla
sta $396f
pla
sta $3967
lda chtime ;* $ff - $00
lsr a
lsr a
lsr a
lsr a
; 0-15
eor #$0f
tay
and #8
beq botbmb ;* doing top 2
tya
and #7
clc ;* x = 0 to 7
adc #16
tay
botbmb:
tya
; y holds offset to char data
lda $3fa0,y
sta $3977 ;* left char
lda $3fa0+8,y
sta $397f ;* right char
rts

; ------------------------------------------------------------------------------
; MODULE: FILLERBO

; ------------------------------------------------------------------------------
; do the bomb fill stuff
filbmb:
ldx bomx
stx ax
stx cx
inx
stx bx
stx dx
ldy bomy
sty ay
sty by
iny
sty cy
sty dy
; 4 corner addresses sussed.
lda rnd+1
and #3
clc
adc #4
; random diameter of bomb 4-7
sta ybomb
lda #0
sta stopa
sta stopb
sta stopc
sta stopd
fill1:
lda stopa
bne startb ;* a already finished
lda #$ff
sta xbomb
ldx ax
fila:
ldy ay
jsr chkbmb
bcs stfila ;* exit loop
dex
inc xbomb
lda xbomb
cmp ybomb
bne fila
stfila:
lda xbomb
cmp #$ff
bne startb
lda #1
sta stopa ;* a hit it
startb:
; start next bit
lda stopb ;* have we stopped ?
bne startc
lda #$ff
sta xbomb
ldx bx
filb:
ldy by
jsr chkbmb
bcs stfilb ;* bit the dust
inx
inc xbomb
lda xbomb
cmp ybomb
bne filb
stfilb:
lda xbomb
cmp #$ff
bne startc
lda #1
sta stopb
startc:
lda stopc
bne startd
lda #$ff
sta xbomb
ldx cx
filc:
ldy cy
jsr chkbmb
bcs stfilc ;* stop it
dex
inc xbomb
lda xbomb
cmp ybomb
bne filc
stfilc:
lda xbomb
cmp #$ff
bne startd
lda #1
sta stopc
startd:
lda stopd
bne fillex ;* exit
lda #$ff
sta xbomb
ldx dx
fild:
ldy dy
jsr chkbmb
bcs stfild
inx
inc xbomb
lda xbomb
cmp ybomb
bne fild
stfild:
lda xbomb
cmp #$ff
bne fillex
lda #1
sta stopd
; ------------------------------------------------------------------------------
; FILLEX - Fill Explosion Exit (Original Source from FILLERBO.TXT)
; ------------------------------------------------------------------------------
fillex:
dec ay
dec by
inc cy
inc dy
ldx #$10
jsr delay+2
; looks better with a delay
dec ybomb
bmi filout
jmp fill1
filout:
ldx #0
jsr delay+2
jsr manded    ; man hit ?
jsr alihit    ; any aliens hit
jsr clexp     ; clear explosion
lda dosfx    ; do cls screen sfx
beq jhuys
jsr clssnd    ; sound
jhuys:
lda #0
sta dosfx
rts

; ------------------------------------------------------------------------------
; CHKBMB - Check Bomb Collision (Original Source from FILLERBO.TXT)
; ------------------------------------------------------------------------------
chkbmb:
txa
pha
; check if co-ord out of range
cpx #0
bcc outran    ; out of range
cpx #31
bcs outran
cpy #0
bcc outran
cpy #23
bcs outran
lda #1
sta bomcol
jsr xy
ldy #0
lda (sl),y
cmp #197
bcc bmbok
cmp #209
bcs bmbok
outran:
pla
tax
sec           ; c=1 if not ok
rts
bmbok:
lda #248
sta (sl),y
lda bomcol    ; colour
sta (cl),y
pla
tax
clc
rts

; ------------------------------------------------------------------------------
; CLEXP - Clear Explosion (Original Source from FILLERBO.TXT)
; do a tidy up of the bits !
; ------------------------------------------------------------------------------
clexp:
lda #<$0c29   ; screen buffer + offset ($0c00 + $29)
sta sl
lda #>$0c29
sta sl+1
ldx #21
exclr1:
ldy #30
exclr2:
lda (sl),y
cmp #248      ; bomb char ?
bne nexp
lda #196
sta (sl),y
nexp:
dey
bpl exclr2
lda sl
clc
adc #40
sta sl
lda sl+1
adc #0
sta sl+1
dex
bpl exclr1
rts

; ------------------------------------------------------------------------------
; MODULE: EDITJIGS

; ------------------------------------------------------------------------------
; called when tha basic loop is
; in control
edit:
lda #0
sta jigx
sta jigy
sta swap
releso:
jsr chkspc ;* space status
bcs releso ;* release space
edjig1:
ldx #$30
jsr delay+2
jsr chkspc ;* space to return
bcc caryon
yesfab:
jsr chkspc ;* please release it !
bcs yesfab
jsr coljig ;* tidy up colour
rts
caryon:
jsr jiggy ;* move the cursor
bit jfire ;* fire to copy ?
bpl edjig1
lda swap ;* second time here
bne place ;* so now copy it
lda sl
sta copyl
lda sl+1
sta copyl+1
; save address
ldy #0
lda (sl),y ;* copy char
sta copych
sta $e01+80
lda #1
sta swap
bne edjig1
place:
; second time that fire is
; pressed so lets swap it
ldy #0
lda (sl),y ;* current char
sta (copyl),y ;* swop it
lda copych ;* replace char
sta (sl),y ;* put it on
lda #0
sta swap
lda #37
sta $e01+80
jmp edjig1
; -++++++++++++++++++++++++++++-
jiggy:
; move the cursor about
ldx jigx
ldy jigy
bit jleft
bpl leno
cpx #0
beq leno ;* at left
dex
leno:
bit jright
bpl rino
cpx #4
beq rino ;* at right
inx
rino:
bit jup
bpl upno
cpy #0
beq upno ;* at top
dey
upno:
bit jdown
bpl dono
cpy #4
beq dono ;* at bottom
iny
dono:
stx jigx
sty jigy
jsr jigxy
jsr coljig ;* colour the jigsaw
lda ted
and #%11110111 ;* rnd colour
ldy #0
sta (cl),y ;* colour edit square
rts

jigxy:
; add offsets
txa
clc
adc #34
tax
tya
clc
adc #12
tay
jsr xy
rts
; ********************************
coljig:
; colour the jigsaw with the
; following rules:-
; 1) if piece of jigsaw but in
; wrong place then lum=$40
; 2) if not a piece of jigsaw
; then lum=$10
; 3) if piece of jiigsaw and in
; right place then lum=$70
ldx #0
stx nocorr
lda #215
sta jigno ;* start jig char
cjig1:
ldy rady,x
lda $e02,y ;* get char
cmp #27 ;* empty jig char
bne noemp
lda #$64
bne colit
noemp:
cmp jigno ;* correcy char ?
bne nocor
inc nocorr ;* another correct
lda #$71
bne colit
nocor:
lda #$10
colit:
sta $a02,y ;* colour on
inc jigno ;* next piece
inx
cpx #25
bne cjig1 ;* do full grid
lda nocorr ;* # in correct
cmp #25
bne ntfind
; well donw he's completed this
; level
jmp uplevl
ntfind:
rts
; ********************************
prjig:
; print initial jigsaw
ldx #24
lda #239
sta char
prjig1:
ldy rady,x
lda char
sta $e02,y
dec char
dex
bpl prjig1
; jsr coljig ;* print some colour
rts


; ------------------------------------------------------------------------------
; MODULE: COMMAND

; ------------------------------------------------------------------------------
; check if you want to escape
; from game,edit jigsaw etc.
; Command/debug menu handler
; Checks for ESC key press
; Enters edit/debug mode if triggered
comand:
jsr chkspc ;* escape to edit
bcc noedit
lda #1
sta stop ;* kill irq's
lda vol
pha
lda #0
sta vol
jsr edit
; lda #0
; sta stop
dec stop
pla
sta vol
noedit:
rts

chkspc:
; check status of escape
lda #$10
ldy #$bf
jsr keyit
rts

; ------------------------------------------------------------------------------
; MODULE: SCATTER

; ------------------------------------------------------------------------------
; the mega code to scatter the
; jigsaw pieces into the rooms
; and display the rooms quickly
; and the pieces disappearing.
; ------------------------------------------------------------------------------
; SCATER - Scatter Jigsaw Pieces
; ------------------------------------------------------------------------------
; Randomizes jigsaw piece placement across 25 rooms
; Ensures no duplicates, one piece per room
; Initializes gotbit array (collection flags)
scater:
jsr prjig
; print complete jigsaw
lda #1
sta delly ;* delay
lda #0
sta screen ;* 0-24
scat1:
jsr radar ;* display pos
jsr decode ;* screen decrunch
jsr fadein ;* put it on
jsr prpice ;* print jigsaw piece
ldx #$40
jsr delay+2
jsr getrid ;* get rid of that
jsr coljig
bit jfire
bmi hunck
; fire to escape
ldx #$10
jsr delay+2
inc screen
lda screen
cmp #25
bne scat1
rts
hunck:
; carry on with no time delay
nopal:
jsr radar
jsr getrid
ldx #$20
jsr delay+2
jsr coljig
inc screen
lda screen
cmp #25
bne nopal
rts

getrid:
ldx screen
lda jignum,x
clc
adc #215
sta copy
ldx #24
scat2:
ldy rady,x
lda $e02,y
cmp copy
bne ntscat
lda #27
sta $e02,y
ntscat:
dex
bpl scat2
; jsr coljig
rts

; ------------------------------------------------------------------------------
; MODULE: HALLOFFA

; ------------------------------------------------------------------------------
hisamp:
.byte "000100  GREMLIN "
inhisc:
; init the hiscore tables
ldy #0
inh1:
ldx #0
inh2:
lda hisamp,x
sta histbl,y
iny
inx
cpx #16
bne inh2
; one line done
cpy #80
bne inh1
; wait for 5 lines
rts

; ------------------------------------------------------------------------------
; MODULE: MAGNIFIC

; ------------------------------------------------------------------------------
; as usual the bit that holds
; the whole game together.
gloppy:
sei
jsr clswin ;* clear game window
; ldx #31
; froop
; lda $3fa0,x
; sta $3960,x
; dex
; bpl froop
jsr copybm
; copy bomb char
ldx #1
stx stop ;* no move-ment
stx title ;* on title page
dex
stx manx
stx many
stx screen
jsr setup ;* init ted
jsr setirq ;* irq's on
; lda #0
; sta manx
; sta many
; sta screen
jsr radar ;* print radar
jsr prbder ;* nice border
; jsr prjig  ;* print jigsaw
jsr sludge ;* color on k/j & s/q
jsr high ;* high score ?
jsr setwin ;* print window
jsr prscrn ;* print info etc
jsr prhisc ;* print table
lda #$22
sta multi2
glloo:
jsr alter ;* alterables
ldx #$30
jsr delay+2
bit jfire
bpl glloo
lda #0
sta title
sta level
lda #3
sta lives
jmp play

; ------------------------------------------------------------------------------
; MODULE: HIGHPRIN

; ------------------------------------------------------------------------------
; *********************************
; print high-score table + screen
; *********************************
prscrn:
; print everything except the
; high-score table
ldx #<bits
ldy #>bits
jsr pwint ;* print bits
ldx #13
lda #42
poops:
sta $c81+40,x
dex
bpl poops
rts

prhisc:
; print high-score table
lda #0
sta numb
hisc1:
lda #0
sta menatw
lda numb
asl a
clc
adc #5
sta ty
lda #6
sta tx
lda numb
clc
adc #$31
pha
and #7
ora #$70
sta prcol
pla
jsr dubhit ;* print d/h
inc tx
inc tx
lda numb
asl a
asl a
asl a
asl a
tax
lda #5
sta count
walt:
txa
pha
lda histbl,x
sta wall
cmp #'0'
bne foo2
lda menatw
bne foo3
lda #32
bne foo1
foo2:
lda #1
sta menatw
foo3:
lda wall
foo1:
jsr dubhit
pla
tax
inx
inc tx
dec count
bpl walt
inc tx
lda #9
sta count
wilt:
txa
pha
lda histbl,x
jsr dubhit ;* print it
pla
tax
inx
inc tx
dec count
bpl wilt
inc numb
lda numb
cmp #5
bne hisc1
rts

pwint:
; print the buffer pointed to
; by the x,y
; table format =
; x,y,col,bytes,0
stx alter1+1
stx alter2+1
stx alter3+1
stx alter4+1
sty alter1+2
sty alter2+2
sty alter3+2
sty alter4+2
; pointer
ldx #0
alter1:
lda $ffff,x
cmp #$ff
beq nztt ;* end of table
sta tx ;* temp x
inx
alter2:
sta ty ;* temp y
inx
txa
pha
ldx tx
ldy ty
jsr xy ;* to screen
pla
tax
alter4:
sta prcol
inx
ldy #0
alter3:
lda $ffff,x
beq nzt
sta (sl),y
lda prcol
sta (cl),y
iny
inx
bne alter3
nzt:
inx
bne alter1
nztt:
rts

bits:
.byte 3,17,$66,3,$f,$e,$14,$12,$0f,$0c,0
; 'control'
.byte 5,18,$76,$3c,$26,$3e,0
; '(f1)'
.byte 5,20,$79,136,137,138,0
.byte 5,21,$79,139,140,141,0
; k/j chars
.byte 14,17,$77,74,80,98,72,0
.byte 14,18,$54,75,81,99,73,0
; fire
; fire
.byte 15,19,$77,102,92,0
.byte 15,20,$54,103,93,0
; to
; to
.byte 14,21,$77,94,86,64,112,0
.byte 14,22,$54,95,87,65,113,0
; play
; play
.byte 24,17,$66,$13,$0f,$15,$0e,$04,0
; 'sound'
.byte 25,18,$66,$3c,$27,$3e,0
; '(f2)'
.byte 25,20,$71,142,143,144,0
.byte 25,21,$71,145,146,147,0
; quiet chars
; ********
.byte 9,2,$64,70,92,98,84,100,32,32,70,80,86,72,88,88,64,0
.byte 9,3,$44,71,93,99,85,101,32,32,71,81,87,73,89,89,65,0
; dorks  dilemma
; ********
.byte $ff
; end of table

; print 'acc' (asc) to double
; height at x,y and colour prcol
dubhit:
and #$3f
cmp #32
bne ntspc
rts
ntspc:
cmp #$30 ;* '0'
bcc letter
and #$0f
asl a
clc
adc #116
bne bypass
letter:
asl a
clc
adc #62
bypass:
pha
ldx tx
ldy ty
jsr xy ;* to screen
; jason now add the x value
pla
ldy #0
sta (sl),y
pha
lda prcol
sta (cl),y
pla
clc
adc #1
ldy #40
sta (sl),y
lda prcol
and #$0f
ora #$60
sta (cl),y
rts

; ------------------------------------------------------------------------------
; MODULE: SCREENIN

; ------------------------------------------------------------------------------
; set up the window for play
setwin:
ldx #<welch
ldy #>welch
jsr pwint
lda #$79
sta $965
sta $966
sta $965+40
sta $966+40
; colour for bomb
rts
; -----------------
; print colour on hiscore table
; for the j/k and q/s chars
; and border colors
sludge:
ldx #31
queen1:
lda #37
sta $c00,x
sta $f98,x
; lda #$11
; sta $800,x
; sta $b98,x
dex
bpl queen1
lda #23
sta ty
queen2:
ldx #0
ldy ty
jsr xy
ldy #0
lda #37
sta (sl),y
lda #$11
sta (cl),y
lda #37
ldy #31
sta (sl),y
lda #$11
sta (cl),y
dec ty
bne queen2
ldx #31
ldy #0
queen3:
lda tcol,y
sta $800,y
sta $bb7-31,x
iny
dex
bpl queen3
rts
tcol:
.byte $07,$17,$27,$37
.byte $47,$57,$67,$77
.byte $06,$16,$26,$36
.byte $46,$56,$66,$76
.byte $05,$15,$25,$35
.byte $45,$55,$65,$75
.byte $02,$12,$22,$32
.byte $42,$52,$62,$72
; ********************************
welch:
.byte 33,1,$65,100,68,92,98,72,213,0
.byte 33,2,$45,101,69,93,99,73,214,0
; 'score'
.byte 33,3,$65,32,32,32,32,32,$30,0
; '    0'
.byte 33,4,$53,$c,9,$16,5,$13,$3a,0
; 'lives:'
.byte 35,5,$63,$33,0
; '  3'
.byte 33,6,$54,1,$c,9,5,$e,$13,0
; 'aliens'
.byte 35,7,$64,32,32,0
; ' 20'
.byte 33,8,$61,66,92,88,66,44,45,0
.byte 33,9,$41,67,93,89,67,46,47,0
; 'bomb'
.byte 33,11,$64,10,9,7,19,1,$17,0
; 'jigsaw'
.byte 33,19,$77,$d,0
.byte 33,20,$77,$1,0
.byte 33,21,$77,$10,0
; 'map'
.byte $ff

; ------------------------------------------------------------------------------
; MODULE: VARIETY

; ------------------------------------------------------------------------------
getdef:
; sets up chars for alien on
; this sheet.
; both chars are left in the
; screen buffer
; char#1 alibuf-alibuf+31
; char#2 alibuf+32-alibuf+63
; random nubers continually
; generated form raster
lda duck ;* same aliens as b4?
beq outduk ;* no
lda aliens ;* last type
jmp quazi
outduk:
lda ted
and #3
tax
lda rnd,x
and #7 ;* eight types
sta aliens ;* alien number
quazi:
tay
ldx tim32,y
ldy #0
defer:
lda def1,x ;* ani #1
sta alibuf,y
lda def2,x ;* ani #2
sta alibuf+32,y
inx
iny
cpy #32
bne defer
lda #1
sta deftem ;* tempo
rts
def1:
; data for animation 1
; in order chars 0-7
; gonk #1
.byte $00,$15,$6a,$7e,$7e,$76,$6a,$6b
.byte $00,$54,$a9,$bd,$bd,$9d,$a9,$e9
.byte $6b,$6f,$6a,$6f,$6d,$6f,$6a,$15
.byte $e9,$f9,$a9,$f9,$79,$f9,$a9,$54
; gonk#2
.byte $05,$07,$16,$1e,$19,$1a,$76,$6e
.byte $50,$d0,$94,$b4,$64,$a4,$9d,$b9
.byte $6a,$56,$06,$1e,$1a,$79,$69,$54
.byte $a9,$95,$90,$b4,$a4,$6d,$69,$15
; gonk #3
.byte $05,$16,$1a,$5a,$6a,$6e,$6e,$66
.byte $50,$94,$a4,$a5,$a9,$b9,$b9,$99
.byte $6a,$69,$5a,$1a,$16,$05,$00,$00
.byte $a9,$69,$a5,$a4,$94,$50,$00,$00
; gonk #4
.byte $15,$6f,$7f,$55,$7b,$55,$7f,$5f
.byte $54,$e5,$f9,$55,$b9,$55,$f9,$a5
.byte $1f,$15,$07,$07,$07,$07,$07,$05
.byte $e4,$54,$90,$90,$90,$90,$90,$50
; gonk #5
.byte $15,$7f,$6b,$7f,$7b,$7e,$1f,$05
.byte $54,$fd,$e9,$fd,$ed,$bd,$f4,$50
.byte $06,$01,$06,$01,$06,$1a,$19,$14
.byte $90,$40,$90,$40,$90,$a4,$64,$14
; gonk #6
.byte $10,$44,$01,$16,$6a,$55,$7f,$7f
.byte $04,$11,$40,$94,$a9,$55,$ad,$ad
.byte $55,$6a,$16,$01,$06,$06,$06,$01
.byte $55,$89,$94,$40,$90,$90,$d0,$40
; gonk #7
.byte $00,$15,$7e,$7e,$7f,$7f,$7f,$15
.byte $00,$00,$40,$d4,$f4,$d4,$40,$00
.byte $1b,$15,$1b,$15,$1b,$15,$7f,$15
.byte $00,$00,$00,$00,$00,$50,$f4,$50
; gonk #8
.byte $00,$00,$05,$16,$1a,$5b,$6b,$6f
.byte $00,$00,$50,$94,$a4,$e5,$e9,$f9
.byte $6f,$6f,$6f,$6b,$5b,$1a,$16,$05
.byte $f9,$f9,$f9,$e9,$e5,$a4,$94,$50
; ****************************
def2:
; second definition
; gonk #1
.byte $00,$15,$6a,$7e,$76,$6b,$6b,$6f
.byte $00,$54,$a9,$bd,$9d,$e9,$e9,$f9
.byte $6a,$6f,$6d,$6d,$6d,$6f,$6a,$15
.byte $a9,$f9,$79,$79,$79,$f9,$a9,$54
; gonk #2
.byte $05,$07,$16,$1e,$19,$1a,$16,$7e
.byte $50,$d0,$94,$b4,$64,$a4,$94,$bd
.byte $6a,$66,$56,$1e,$1a,$19,$19,$14
.byte $a9,$99,$95,$b4,$a4,$64,$64,$14
; gonk #3
.byte $00,$00,$05,$16,$1a,$5a,$66,$6e
.byte $00,$00,$50,$94,$a4,$a5,$99,$b9
.byte $6e,$6a,$69,$67,$59,$1a,$16,$05
.byte $b9,$a9,$69,$d9,$65,$a4,$94,$50
; gonk #4
.byte $00,$00,$00,$15,$5f,$7f,$55,$7b
.byte $00,$00,$00,$54,$e5,$f9,$55,$b9
.byte $55,$7f,$5f,$1f,$15,$07,$07,$05
.byte $55,$f9,$a5,$e4,$54,$90,$90,$50
; gonk #5
.byte $00,$00,$15,$7f,$6b,$67,$7f,$7e
.byte $00,$00,$54,$fd,$e9,$d9,$fd,$bd
.byte $1f,$05,$06,$01,$06,$1a,$19,$14
.byte $f4,$50,$90,$40,$90,$a4,$44,$14
; gonk #6
.byte $10,$04,$01,$16,$6a,$55,$7a,$7a
.byte $04,$10,$40,$94,$a9,$55,$fd,$fd
.byte $55,$6a,$16,$01,$07,$07,$07,$01
.byte $55,$89,$94,$40,$d0,$d0,$90,$40
; gonk #7
.byte $00,$00,$00,$00,$00,$15,$7e,$7e
.byte $00,$00,$00,$00,$00,$00,$40,$d4
.byte $7f,$7f,$7f,$15,$1b,$15,$7f,$15
.byte $f4,$d4,$40,$00,$00,$50,$f4,$50
; gonk #8
.byte $00,$00,$0f,$3d,$35,$f6,$d6,$da
.byte $00,$00,$f0,$7c,$5c,$9f,$97,$a7
.byte $da,$da,$da,$d6,$f6,$35,$3d,$0f
.byte $a7,$a7,$a7,$97,$9f,$5c,$7c,$f0

; ------------------------------------------------------------------------------
; MODULE: DEATHCOD

; ------------------------------------------------------------------------------
; Handle player death sequence
; Checks collision type, decrements lives
; Triggers death animation if killed
death:
; called whwn th bod has moved
; so we must check if he's hit
; an alien by peeking his behind
ldx #3
chkdth:
lda behind,x
cmp #209
bcc dodok
cmp #213
bcs dodok
lda #1
sta dead ;* he's dead
dodok:
dex
bpl chkdth
rts

; Check if player died during last frame
; Processes death sequence if dead flag set
; Decrements lives, resets player position
deadck:
; called by the basic loop
lda dead
bne runty
rts
runty:
ldx #1
stx stop
stx stpman ;* stop man animation
dex
stx dead
jsr doit
; (calls a label in the print
; aliens subroutine to put all
; the aliens on the screen.)
; first lets replace the man
; with our own char ie
; 33 34
; 34 36
; ( this format makes scrolling
; easier.)
ldx #7
clope:
lda $38e0,x ;* tl char
sta $3908,x
lda $38f0,x ;* bl char
sta $3910,x
lda $38e8,x ;* tr char
sta $3918,x
lda $38f8,x ;* br char
sta $3920,x
dex
bpl clope
lda dedbmb ;* died by bomb ?
beq nthyu
lda manl
sta sl
sta cl
lda manl+1
sta sl+1
sec
sbc #4
sta cl+1
; if he died by the explosion
; the use tl co-ordinates
jmp steve
nthyu:
ldx manx
ldy many
lda dir
and #3
beq chaka
inx
chaka:
lda dir
and #4
beq khan
iny
khan:
jsr xy
steve:
lda sndflg
beq stew1
lda #$2f
sta vol ;* chan #2
stew1:
lda #2
sta sou2hi
lda sl
pha
sec
sbc #40
sta sl
lda sl+1
pha
sbc #0
sta sl+1
jsr bugrub ;* rub him out
pla
sta sl+1
pla
sta sl
ldx #3
lda #36
sta char
clonet:
ldy dedy,x
lda char
sta (sl),y
lda #$7f
sta (cl),y ;* yellow
dec char
dex
bpl clonet
; our char on - i hope
ldy #15
anrt:
ldx #14
closcr:
lda $3908,x
sta $3909,x
lda $3918,x
sta $3919,x
dex
bpl closcr
tya
pha
ldx #$20
jsr delay+2
pla
tay
asl a
asl a
asl a
asl a
sta sou2lo
lda #0
sta $3908
sta $3918
dey
bpl anrt
ldx #0
scrups:
; scroll up the cross
lda crossl,x
sta $3917
lda crossr,x
sta $3927
ldy #0
meatlf:
lda $3909,y
sta $3908,y
lda $3919,y
sta $3918,y
iny
cpy #15
bne meatlf
txa
pha
ldx #$30
jsr delay+2
pla
tax
lda rnd+2
sta sou2lo
inx
cpx #15
bne scrups
lda #0
sta vol
tax
tay ;* = 0
wrath:
inc backgr
dey
bne wrath
dex
bne wrath
lda #$11
sta backgr
ldx #$00
jsr delay+2
jsr delay+2
jsr delay+2
; long delay
lda #0
sta stpman ;* animations off again
sta dedbmb ;*
dec $ceb ;* screen lives
dec lives
bne more ;* still some lives
jmp gmeovr ;* all over
more:
lda savex
sta manx
lda savey
sta many
lda savdir
sta dir ;* old dir
lda #1
sta duck ;* same alien type
jsr jmpbak ;* start screen again
lda #0
sta duck
jmp loop ;* back to game

dedy:
crossl:
; char data for cross left
.byte $05,$07,$57,$7f,$7f,$6b,$57,$07
.byte $07,$07,$07,$07,$15,$5a,$6a,$55
crossr:
; for right
.byte $50,$d0,$d5,$fd,$fd,$e9,$d5,$d0
.byte $d0,$d0,$d0,$d0,$54,$f5,$bd,$55

; ------------------------------------------------------------------------------
; MODULE: GAMEOVER

; ------------------------------------------------------------------------------
; all the game over stuff
gmeovr:
; do some gloppy bits then jmp
; to the title page
; everything should have stopped
; by now.
jsr clswin ;* clear window
ldx #<ender
ldy #>ender
jsr pwint
lda #80
sta temp
ldy #0
endlop:
ldx #10
lda rnd
and #%11110111
ora #%00110000
entit:
sta $9c2,x
sta $9c2+40,x
dex
bpl entit
dey
bne endlop
dec temp
bne endlop
ldx #5
let9:
lda scorep,x ;* score address
cmp #32 ;* a space ?
bne let8
lda #$30 ;*
let8:
sta sikbuf,x
dex
bpl let9

; and convert any spaces into '0'
jmp gloppy

ender:
.byte 11,11,$71,76,64,88,72,32,32,92,106,72,98,0
.byte 11,12,$71,77,65,89,73,32,32,93,107,73,99,0
.byte $ff

; ------------------------------------------------------------------------------
; MODULE: ALTERABL

; ------------------------------------------------------------------------------
; choose k/j & q/s
; default values are :-
; keyboard    joysel = 0
; sound on    sndflg = 1
alter:
lda #$10
ldy #$fe ;* 'f1'
jsr keyit
bcc alt1 ;* not pressed
lda joysel
eor #1
sta joysel
ldx #47
alt2:
lda $3c40,x ;* existing char
pha
lda jkchar,x ;* new one
sta $3c40,x
pla
sta jkchar,x ;* replace it
dex
bpl alt2
alt1:
lda #$20
ldy #$fe ;* 'f2'
jsr keyit
bcc alt3
lda sndflg
eor #1
sta sndflg
ldx #47
alt4:
lda $3c70,x
pha
lda sqchar,x
sta $3c70,x
pla
sta sqchar,x
dex
bpl alt4
alt3:
rts

jkchar:
.byte $05,$16,$1a,$1a,$16,$05,$07,$07
.byte $40,$50,$d0,$90,$50,$40,$40,$41
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $07,$05,$1f,$7f,$7f,$55,$7f,$15
.byte $46,$55,$ff,$ff,$ff,$55,$fe,$55
.byte $40,$50,$a4,$e9,$f9,$55,$a9,$54
; *****
sqchar:
.byte $18,$0c,$06,$03,$01,$00,$00,$00
.byte $00,$00,$00,$01,$83,$c6,$6c,$38
.byte $30,$60,$c0,$80,$00,$00,$00,$00
.byte $00,$00,$01,$03,$06,$0c,$18,$10
.byte $6c,$c6,$83,$01,$00,$00,$00,$00
.byte $00,$00,$00,$80,$c0,$60,$30,$10

; ------------------------------------------------------------------------------
; MODULE: TITLEWOR

; ------------------------------------------------------------------------------
; do the bits on the title page
bdrglp:
; scroll the border round
lda $81f
sta stopa ;* save it
lda $bb7
sta stopb
lda $b98
sta stopc
; 3 bits saved
ldx #30
qat1:
lda $800,x
sta $801,x
dex
bpl qat1
lda #22
sta bordy
qat2:
ldx #31
ldy bordy
jsr xy
ldy #0
lda (cl),y
ldy #40
sta (cl),y
dec bordy
bne qat2
lda stopa
sta $847
ldx #0
qat3:
lda $b99,x
sta $b98,x
inx
cpx #30
bne qat3
lda stopb
sta $bb6
lda #0
sta bordy
qat4:
ldx #0
ldy bordy
jsr xy
ldy #40
lda (cl),y
ldy #0
sta (cl),y
inc bordy
lda bordy
cmp #23
bne qat4
lda stopc
sta $b70
rts

; ------------------------------------------------------------------------------
; MODULE: SCOREROU

; ------------------------------------------------------------------------------
scorep = $c21+120
; called with acc holding val
; to add , why do i have to tell
; you this you've used it in so
; many games you dick head
score:
ldy #5 ;* lsb digit
; second entry point
addlop:
sta scradd
lda scorep,y
cmp #32
bne ntort
lda #$30
ntort:
clc
adc scradd
cmp #$3a
bmi scorel
sec
sbc #$a
sta scorep,y
lda #1
dey
bpl addlop
scorel:
sta scorep,y
lda scorep+2 ;* thousands
and #15 ;* 0 - 15
cmp xtra
beq xargon
sta xtra
lda lives
cmp #9
beq xargon
inc lives
inc $c00+200+35
xargon:
rts

; ------------------------------------------------------------------------------
; MODULE: WORKHIGH

; ------------------------------------------------------------------------------
; *****************************
; do all the high score stuff
; *****************************
; sikbuf .byte "000000"
; sikbuf must be filled with
; the score from the last game
; before high routine is called
high:
lda #0
sta hispnt
sta positn
hlp1:
lda hispnt
clc
adc #6
tax
sec
ldy #6
hlp2:
lda histbl-1,x
sbc sikbuf-1,y
dex
dey
bne hlp2
bcc itsin ;* got in !!!
lda hispnt
clc
adc #16
sta hispnt
inc positn
lda positn
cmp #5
bne hlp1
; not in the table - sussed
rts
; ********************************
itsin:
; in at positn  (0-4)
jsr prentr ;* print prompt
jsr mvescr ;* move scores down
jsr clswin ;* clear window
rts
; ********************************
; hofset
; .byte 0,16,32,48,64
mvescr:
lda positn
pha
; lda hofset,x
asl a
asl a
asl a
asl a
; *16
sta incnt
pla
cmp #4
beq inlast
ldx #64
movesc:
lda histbl,x
sta histbl+16,x
dex
cpx incnt
bne movesc
inlast:
ldx incnt
ldy #0
mvt1:
lda sikbuf,y
sta histbl,x
inx
iny
cpy #6
bne mvt1
; score in
; now get name
ldx #10
let0:
lda #32
sta $eb3,x
lda #$51
sta $eb3-$400,x
dex
bpl let0
ldy #0
input:
sty letcnt
lda #37
sta $eb3,y
ldx #$30
jsr delay+2
input1:
jsr inkey ;* get key
beq input1 ;* no key pressed
ldy letcnt
cmp #$1c ;* return - exit
beq letext
cmp #$1d
bne let1
; pressed delete
cpy #0
beq input ;* at extreme left
lda #32
sta $eb3,y ;* rub out
dey
jmp input ;* go back
let1:
cpy #10
beq input ;* no more !
cmp #$1b ;* space
bne let2
lda #32
let2:
sta $eb3,y
iny
jmp input
letext:
; exit - put name into table
lda incnt ;* ofset into table
clc
adc #6
tay
ldx #0
let4:
lda $eb3,x
cmp #37
bne let5
lda #32
let5:
sta histbl,y
iny
inx
cpx #10
bne let4
rts

prentr:
; print the 'congratulations bit'
ldx #<text
ldy #>text
jsr pwint
ldx #15
quincy:
lda #42 ;* under line char
sta $cd0,x
cpx #10
bcs quinc1
sta $edb,x
quinc1:
dex
bpl quincy
ldx #5
quinc3:
lda scorep,x
sta $d29,x
lda #$52
sta $929,x
dex
bpl quinc3
rts
; ----------
text:
.byte 8,3,$77,68,92,90,76,98,64,102,104,86,64,102,80,92,90,100,40,0
.byte 8,4,$67,69,93,91,77,99,65,103,105,87,65,103,81,93,91,101,41,0
; 'congratulations'
.byte 3,7,$73,25,15,21,18,32,19,3,15,18,5,32,15,6,32,48,48,48,48,48,48
.byte 32,9,19,32,9,14,0
; 'your score of 000000 is in'
.byte 10,9,$73,102,78,72,32,102,92,94,32,74,80,106,72,0
.byte 10,10,$63,103,79,73,32,103,93,95,32,75,81,107,73,0
; 'the top five'
.byte 5,13,$72,94,86,72,64,100,72,32,72,90,102,72,98,32
.byte 112,92,104,98,32,90,64,88,72,0
.byte 5,14,$62,95,87,73,65,101,73,32,73,91,103,73,99,32
.byte 113,93,105,99,32,91,65,89,73,0
; 'please enter your name'
.byte $ff

; ------------------------------------------------------------------------------
; MODULE: KILLERCO

; ------------------------------------------------------------------------------
; the logic related to the
; killing of the nasties
; notokl = no of aliens killed
; (gets zeroed at exit of room)
initkl:
; initialise # to kill
lda #0
sta nokild
lda kilhex
sta alkill ;* number to kill
lda cleard
bne killed ;* no effect
sed
lda kildec ;* num to kill
sta notokl
cld
; now fall through and print it
jmp ohshit

; this routine is called under irq
; to add one to the number killed.
; if the number killed=10
; then the routine hands over to
; basic loop
killed:
lda cleard ;* cleared this one
beq kilop
lda #$30
sta $d3b
sta $d3c
; you don't have to clear any
; if you've completed this room
; do you - gonk.
rts
kilop:
inc nokild
ohshit:
sed
lda notokl
sec
sbc #1
sta notokl
cld
; lets update the count
pha
lsr a
lsr a
lsr a
lsr a
ora #$30
sta $d3b
pla
and #15
ora #$30
sta $d3c
lda notokl
beq kilall ;* all gone
rts
; ---------------
kilall:
ldx screen
lda #1
sta gotbit,x
; we've cleared it !!!  wwooooo!
sta cleard
sta dosfx
jsr transf
; copy jig in the middle to
; the one on the right
rts
; --------------
clssnd:
lda sndflg
beq yogup
lda #%00111111
sta vol
yogup:
lda #3
sta work
lda #0
sta work+1
gaste1:
ldx #0
gasree:
inc border
dex
bne gasree
lda work+1
sta sou2lo
eor #$ff
sta sou1lo
lda work
and #3
sta sou2hi
eor #$ff
and #3
ora sou1hi
sta sou1hi
dec work+1
bne gaste1
dec work
bne gaste1
lda #0
sta vol
lda #$11
sta border
rts

; ------------------------------------------------------------------------------
; MODULE: LEVELINC

; ------------------------------------------------------------------------------
; a call to this routine sets up
; all the varaibles affected by
; 'level'
setlvl:
ldx level
lda lvalmv,x
sta almvet
; alien move tempo
lda lvnokl,x
sta kilhex
; no. to kill (hex)
lda lvnokk,x
sta kildec
; no. to kill (dec)
rts

lvalmv:
.byte 20,16,12,8,4
lvnokl:
.byte 10,15,20,25,30
lvnokk:
.byte $11,$16,$21,$26,$31

uplevl:
; a call to this ups the level
; and prints a message
inc level
lda level
cmp #5
bne mlok
lda #4
sta level
mlok:
; level never > 4
jsr clswin
ldx #<lvlovr
ldy #>lvlovr
jsr pwint
jsr clssnd
jsr clssnd
jsr clssnd
jmp play

; -------------------
lvlovr:
.byte 8,8,$76,86,72,106,72,86,32,68,92,88,94,86,72,102,72,70,40,0
.byte 8,9,$66,87,73,107,73,87,32,69,93,89,95,87,73,103,73,71,41,0
; level completed
.byte 9,12,$75,90,92,108,32,94,86,64,112,32,102,78,80,100,0
.byte 9,13,$65,91,93,109,32,95,87,65,113,32,103,79,81,101,0
; now play this
.byte $ff

; ------------------------------------------------------------------------------
; MODULE: WHOOPPEE

; ------------------------------------------------------------------------------
messt:
.byte "     DORKS DILEMMA BY MICRO PROJECTS LTD HAVE YOU PLAYED XARGON WARS"
.byte ";PETALS OF DOOM OR TYCOON TEX ?"
.byte $ff

; .end removed
