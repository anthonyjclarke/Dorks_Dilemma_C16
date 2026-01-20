; ==============================================================================
; MISSING ROUTINES - Extracted from DORKSDIL.BIN disassembly
; ==============================================================================
; These routines were missing from the original source file reconstruction
; but are present in the compiled binary. They were reverse-engineered from
; DORKSDIL.BIN using disassembly and analysis.
; ==============================================================================

; ------------------------------------------------------------------------------
; CHKBMB - Check Bomb Placement/Collision
; ------------------------------------------------------------------------------
; Checks if a screen position is valid for bomb placement or explosion.
; Tests bounds and screen character for obstacles.
;
; Address in binary: $2AC5
; Called from: FILLERBO.TXT bomb fill routine (3 times)
;
; Inputs:
;   X = X coordinate (screen column, 0-31)
;   Y = Y coordinate (screen row, 0-23)
;
; Outputs:
;   Carry flag:
;     SET (1) = Invalid position (out of bounds or obstacle)
;     CLEAR (0) = Valid position (can place bomb/explosion)
;
; Uses:
;   $13 = Screen pointer (low byte)
;   $85 = Temporary storage
;   A, X, Y registers
; ------------------------------------------------------------------------------
chkbmb:
    txa                    ; Save X coordinate
    pha                    ; Push to stack

    ; Check X bounds (0 <= X < 31)
    cpx #$00               ; X < 0?
    bcc chkbmb_fail        ; Yes - out of bounds
    cpx #$1F               ; X >= 31?
    bcs chkbmb_fail        ; Yes - out of bounds

    ; Check Y bounds (0 <= Y < 23)
    cpy #$00               ; Y < 0?
    bcc chkbmb_fail        ; Yes - out of bounds
    cpy #$17               ; Y >= 23?
    bcs chkbmb_fail        ; Yes - out of bounds

    ; Calculate screen position and check character
    lda #$71               ; Screen calculation constant
    sta $85                ; Store temporarily
    jsr $1B0E              ; Calculate screen address

    ldy #$00               ; Offset 0
    lda ($13),y            ; Load character at position

    ; Check if character is obstacle ($C5-$D0 are walls/obstacles)
    cmp #$C5               ; Less than $C5?
    bcc chkbmb_ok          ; Yes - not an obstacle
    cmp #$D1               ; >= $D1?
    bcs chkbmb_ok          ; Yes - not an obstacle

chkbmb_fail:
    ; Invalid position - return with carry set
    pla                    ; Restore X
    tax
    sec                    ; Set carry = fail
    rts

chkbmb_ok:
    ; Valid position - mark it and return with carry clear
    lda #$F8               ; Explosion/bomb marker character
    sta ($13),y            ; Write to screen
    lda $85                ; (appears to be some state management)
    sta $2E                ; Store state
    pla                    ; Restore X
    tax
    clc                    ; Clear carry = success
    rts

; ------------------------------------------------------------------------------
; FILLEX - Bomb Fill Exit Point
; ------------------------------------------------------------------------------
; This label marks the exit point after all four bomb explosion directions
; have been processed. It updates the corner coordinates for the next
; iteration and loops back or exits.
;
; Address in binary: $33F9
; Referenced from: FILLERBO.TXT line 146 (bne fillex)
;
; Context:
;   After checking stopd flag, if not set, continues to fild loop.
;   If stopd is set, branches here to finish up.
;
; Uses:
;   $76 = ay (direction A Y coordinate)
;   $78 = by (direction B Y coordinate)
;   $7A = cy (direction C Y coordinate)
;   $7C = dy (direction D Y coordinate)
;   $84 = ybomb (explosion radius counter)
; ------------------------------------------------------------------------------
fillex:
    dec $76                ; Decrement ay
    dec $78                ; Decrement by
    inc $7A                ; Increment cy
    inc $7C                ; Increment dy
    ldx #$10               ; Parameter for delay/animation
    jsr $1ADB              ; Call animation/delay routine
    dec $84                ; Decrement explosion radius
    bmi fillex_done        ; If negative, explosion complete
    jmp $2A07              ; Loop back to continue explosion

fillex_done:
    ; Explosion animation complete
    ldx #$00
    jsr $1ADB              ; Final animation call
    jsr $1FBE              ; Additional cleanup
    jsr $2423              ; More cleanup
    jsr $2AFA              ; Even more cleanup

    ; Check if bomb animation needed
    lda $B9                ; Bomb animation flag
    beq fillex_exit        ; Skip if not needed
    jsr $36C2              ; Do bomb animation

fillex_exit:
    lda #$00               ; Clear bomb animation flag
    sta $B9
    rts                    ; Return to caller

; ==============================================================================
; End of missing routines
; ==============================================================================
