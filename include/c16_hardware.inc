; ==============================================================================
; C16/Plus4 Hardware Definitions
; ==============================================================================
; TED chip and system memory definitions for Commodore C16/Plus4
; Include this file in assembly projects for hardware register access
; ==============================================================================

; TED (Text Editing Device) Base Address
TED_BASE	= $FF00

; TED Sound Registers
SND1_LO		= TED_BASE + 14		; $FF0E - Sound 1 frequency low
SND2_LO		= TED_BASE + 15		; $FF0F - Sound 2 frequency low / noise control
SND2_HI		= TED_BASE + 16		; $FF10 - Sound 2 frequency high
SND_VOL		= TED_BASE + 17		; $FF11 - Volume control
SND1_HI		= TED_BASE + 18		; $FF12 - Sound 1 frequency high

; TED Video Registers
CHARSET_PTR	= TED_BASE + 19		; $FF13 - Character set pointer
SCREEN_PTR	= TED_BASE + 20		; $FF14 - Screen memory pointer
BORDER_COL	= TED_BASE + 25		; $FF19 - Border color
BACK_COL	= TED_BASE + 21		; $FF15 - Background color
MULTI1_COL	= TED_BASE + 22		; $FF16 - Multicolor 1
MULTI2_COL	= TED_BASE + 23		; $FF17 - Multicolor 2

; TED Control Registers
IRQ_REG		= TED_BASE + 9		; $FF09 - Interrupt request register
IRQ_MASK	= TED_BASE + 10		; $FF0A - Interrupt mask register
RASTER_CMP	= TED_BASE + 11		; $FF0B - Raster compare (low 8 bits)
RASTER_HI	= TED_BASE + 28		; $FF1C - Raster high bit

; Joystick Port
JOY_PORT	= TED_BASE + 8		; $FF08 - Joystick port 1/2

; Screen Memory
SCREEN_RAM	= $0400			; Default screen RAM location
SCREEN_SIZE	= 1000			; 40 x 25 characters

; Color RAM (luminance)
COLOR_RAM	= $0800			; Color RAM base (Plus/4)

; Character Set
CHARSET_RAM	= $3800			; Common charset location (2KB)

; Memory Configuration
BASIC_RAM	= $1001			; BASIC program start
USER_RAM	= $1000			; User program space

; System Zero Page
CURSOR_X	= $CA			; Cursor X position
CURSOR_Y	= $CD			; Cursor Y position

; KERNAL Routines (Jump Table)
CHROUT		= $FFD2			; Output character to current device
CHRIN		= $FFCF			; Input character from current device
GETIN		= $FFE4			; Get character from keyboard
CLRSCR		= $E544			; Clear screen
PLOT		= $FFF0			; Set/get cursor position

; Hardware Vectors
NMI_VECTOR	= $FFFA			; NMI vector
RESET_VECTOR	= $FFFC			; Reset vector
IRQ_VECTOR	= $FFFE			; IRQ/BRK vector

; Keyboard Matrix
KBD_MATRIX	= $FD30			; Keyboard matrix scan

; Common Constants
TRUE		= 1
FALSE		= 0
NULL		= 0

; Screen Codes
SCREEN_CODE_SPACE	= $20
SCREEN_CODE_CLEAR	= $93
SCREEN_CODE_HOME	= $13
SCREEN_CODE_RETURN	= $0D

; Color Codes (C16/Plus4)
COLOR_BLACK	= $00
COLOR_WHITE	= $71
COLOR_RED	= $32
COLOR_CYAN	= $63
COLOR_PURPLE	= $34
COLOR_GREEN	= $55
COLOR_BLUE	= $26
COLOR_YELLOW	= $57
COLOR_ORANGE	= $48
COLOR_BROWN	= $39
COLOR_LT_RED	= $72
COLOR_DK_GREY	= $21
COLOR_GREY	= $41
COLOR_LT_GREEN	= $75
COLOR_LT_BLUE	= $66
COLOR_LT_GREY	= $61

; ==============================================================================
; End of hardware definitions
; ==============================================================================
