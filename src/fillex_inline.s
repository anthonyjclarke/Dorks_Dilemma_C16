; ------------------------------------------------------------------------------
; FILLEX - Bomb Fill Exit Point (INLINE - goes after fild label)
; ------------------------------------------------------------------------------
; This label marks the exit point after all four bomb explosion directions
; have been processed. Must be placed immediately after fild: label.
; ------------------------------------------------------------------------------
fillex:
    dec ay                 ; Decrement direction A Y coord
    dec by                 ; Decrement direction B Y coord
    inc cy                 ; Increment direction C Y coord
    inc dy                 ; Increment direction D Y coord
    ldx #$10               ; Animation parameter
    jsr delay+2            ; Call animation/delay
    dec ybomb              ; Decrement explosion radius
    bmi fillex_done        ; If negative, explosion complete
    jmp fill1              ; Loop back to continue explosion

fillex_done:
    ; Explosion animation complete - cleanup
    ldx #$00
    jsr delay+2            ; Final animation
    jsr prnals             ; Print aliens
    jsr random             ; Random number (cleanup)
    jsr setup              ; Setup display

    ; Check if bomb animation needed
    lda bready             ; Bomb ready flag
    beq fillex_exit        ; Skip if not needed
    jsr bomban             ; Do bomb animation

fillex_exit:
    lda #$00               ; Clear bomb ready flag
    sta bready
    rts                    ; Return to caller
