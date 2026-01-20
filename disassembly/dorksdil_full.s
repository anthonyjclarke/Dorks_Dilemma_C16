; da65 V2.18 - N/A
; Created:    2026-01-18 07:56:38
; Input file: Original_Files/DORKSDIL.BIN
; Page:       1


        .setcpu "6502"

L0000           := $0000
L0020           := $0020
L0030           := $0030
L0043           := $0043
L00A0           := $00A0
L00FF           := $00FF
L02EF           := $02EF
L0313           := $0313
L04DF           := $04DF
L04F7           := $04F7
L0800           := $0800
L0C00           := $0C00
L0C05           := $0C05
L0E09           := $0E09
L1309           := $1309
L4977           := $4977
L4D45           := $4D45
L4E49           := $4E49
L4F44           := $4F44
L4F59           := $4F59
L4F67           := $4F67
L5147           := $5147
L5250           := $5250
L544C           := $544C
L5954           := $5954
L5A48           := $5A48
L5C20           := $5C20
L5C66           := $5C66
L5C70           := $5C70
L5D45           := $5D45
L5D71           := $5D71
L5E20           := $5E20
L6040           := $6040
L6B5D           := $6B5D
LF2A4           := $F2A4
LFF3F           := $FF3F
LFFD2           := $FFD2
        brk
        bpl     L19B8
        eor     $55,x
        eor     $40,x
        brk
        brk
        brk
        rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        eor     ($40,x)
        brk
        .byte   $FF
        rti

        bvc     L1979
L1979:  cpy     #$40
        .byte   $14
L197C:  brk
L197D:  brk
L197E:  rti

L197F:  ora     L0000
        ora     ($40,x)
        ora     ($40,x)
        brk
        rti

        brk
        brk
        rti

        rti

        brk
        brk
        eor     L0043,x
        ora     $50
        rti

        .byte   $43
        brk
        brk
        rti

        .byte   $43
        brk
        brk
        rti

        .byte   $43
        ora     (L0000,x)
        rti

        rti

        ora     (L0000,x)
        rti

        rti

        ora     (L0000,x)
        cpy     #$40
        ora     ($0F,x)
        .byte   $FC
        .byte   $42
        brk
        brk
L19AD:  brk
        .byte   $42
        .byte   $80
        brk
        brk
        .byte   $42
        ldy     #$20
        .byte   $0F
        rti

        brk
L19B8:  brk
        brk
        rti

        brk
        brk
        brk
        eor     $55,x
        eor     $55,x
        eor     $55,x
        eor     $55,x
        rti

        brk
        bpl     L19CA
L19CA:  rti

        brk
        bpl     L19CE
L19CE:  .byte   $42
        brk
        brk
        .byte   $0C
        rti

L19D3:  .byte   $80
        brk
        .byte   $0C
        rti

        jsr     L0C00
        rti

        php
        brk
        .byte   $0C
        rti

        .byte   $02
        brk
        .byte   $0C
        rti

        brk
        brk
        .byte   $03
        rti

        brk
        brk
        brk
        .byte   $43
        .byte   $FF
        brk
        brk
        rti

        brk
        .byte   $C2
        brk
        rti

        brk
        .byte   $C2
        brk
        .byte   $43
        .byte   $FF
        brk
        brk
        rti

        brk
        brk
        brk
        rti

        brk
        brk
        .byte   $03
        rti

        .byte   $02
        brk
        .byte   $0C
        rti

        php
        ora     ($0C,x)
        rti

        jsr     L0C05
        rti

        .byte   $80
        ora     $0C,x
        .byte   $42
        brk
        eor     $0C,x
L1A16:  rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
L1A1E:  eor     $55,x
L1A20:  eor     $55,x
        eor     $55,x
        eor     $55,x
        rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        .byte   $42
        tax
        sta     (L0000,x)
        .byte   $42
        brk
        sta     ($50,x)
        .byte   $42
        brk
        sta     ($14,x)
        .byte   $42
        brk
        sta     ($04,x)
        .byte   $42
        brk
        sta     (L0000,x)
        .byte   $42
        .byte   $82
        sta     (L0000,x)
        rti

        brk
        sta     (L0000,x)
        rti

        brk
        sta     (L0000,x)
        rti

        brk
        sta     (L0000,x)
        rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        rti

        .byte   $14
        brk
        .byte   $FF
L1A5E:  rti

        eor     ($03,x)
        .byte   $03
        rti

        brk
        rti

        brk
        rti

        brk
        rti

        brk
        rti

        eor     (L0000,x)
        .byte   $FC
        rti

        eor     (L0000,x)
        .byte   $0C
        rti

        eor     L0000,x
        .byte   $03
        rti

        brk
L1A78:  brk
        brk
        rti

        brk
        brk
        brk
        eor     $55,x
        eor     $55,x
        eor     $6A,x
        tax
        eor     $40,x
        .byte   $1A
        lda     #$00
        rti

L1A8B:  asl     $A4
        brk
        rti

        ora     ($90,x)
        brk
        rti

        brk
        rti

        bpl     L1AD7
        brk
        brk
        bpl     L1ADB
        rti

        brk
        bpl     L1ADF
        rti

        brk
        bpl     L1AE3
        rti

        brk
        bpl     L1AE7
        rti

        brk
        bpl     L1AEB
        bvc     L1AAD
L1AAD:  bpl     L1AEF
        .byte   $54
        brk
        bpl     L1AF3
        eor     $55,x
        bvc     L1AF7
L1AB7:  .byte   $54
        brk
        bpl     L1AFB
        bvc     L1ABD
L1ABD:  bpl     L1AFF
        rti

        brk
        bpl     L1B03
        rti

        brk
        bpl     L1B07
        rti

        brk
        bpl     L1B0B
        rti

        brk
        bpl     L1B0F
        brk
        rti

        bpl     L1B13
        ora     ($D0,x)
        brk
        rti

L1AD7:  .byte   $07
        .byte   $F4
        brk
        rti

L1ADB:  .byte   $1F
        sbc     $5500,x
L1ADF:  .byte   $7F
        .byte   $FF
        eor     $55,x
L1AE3:  eor     $55,x
        eor     $40,x
L1AE7:  brk
        brk
        brk
        rti

L1AEB:  brk
        brk
        brk
        .byte   $41
L1AEF:  bvc     L1B46
L1AF1:  .byte   $54
        .byte   $41
L1AF3:  brk
        brk
        brk
        .byte   $41
L1AF7:  brk
        brk
        brk
        rti

L1AFB:  .byte   $04
        brk
        bmi     L1B3F
L1AFF:  ora     $54
        brk
        .byte   $41
L1B03:  brk
        .byte   $04
        brk
        .byte   $41
L1B07:  brk
        .byte   $04
        brk
        .byte   $41
L1B0B:  brk
        .byte   $04
        brk
L1B0E:  .byte   $41
L1B0F:  brk
        .byte   $04
        brk
        .byte   $41
L1B13:  brk
        .byte   $04
        brk
        eor     (L0000,x)
        .byte   $04
        brk
        eor     (L0000,x)
        .byte   $04
        bmi     L1B60
        brk
        .byte   $54
        brk
        rti

        brk
        rti

        brk
        rti

        brk
        rti

        tax
        eor     (L0000,x)
        brk
        brk
        eor     (L0000,x)
        brk
        brk
        eor     ($50,x)
        .byte   $55
L1B35:  .byte   $54
L1B36:  rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        .byte   $55
L1B3F:  eor     $55,x
        eor     $55,x
        eor     $55,x
        .byte   $55
L1B46:  rti

        brk
        bpl     L1B4A
L1B4A:  rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        rti

        brk
        bpl     L1B56
L1B56:  .byte   $43
        .byte   $FC
        bpl     L1B5A
L1B5A:  .byte   $43
        .byte   $FC
        ora     $54,x
        rti

        brk
L1B60:  brk
        .byte   $14
        rti

        brk
        brk
        .byte   $10
L1B66:  rti

L1B67:  brk
        brk
        bpl     L1BAB
        brk
        brk
        bpl     L1BAF
        brk
        .byte   $3C
        brk
        rti

L1B73:  brk
        .byte   $3C
        brk
        rti

        brk
        .byte   $3C
        bpl     L1BD0
        eor     ($55,x)
        bvc     L1BBF
        brk
        ora     (L0000,x)
        rti

        brk
        ora     (L0000,x)
        rti

        brk
L1B88:  brk
        brk
        rti

        .byte   $FF
        brk
        brk
        rti

        .byte   $FF
        ora     (L0000,x)
        rti

        brk
        ora     (L0000,x)
        rti

        brk
        ora     (L0000,x)
        rti

L1B9B:  brk
        ora     (L0000,x)
        eor     $55,x
L1BA0:  eor     $55,x
        eor     $55,x
        .byte   $55
L1BA5:  eor     $40,x
L1BA7:  brk
        brk
        brk
        rti

L1BAB:  brk
        brk
        brk
        rti

L1BAF:  brk
        cpy     #$00
        rti

        .byte   $03
        beq     L1BC0
        rti

        .byte   $0F
        .byte   $7C
        php
        rti

        .byte   $03
        bvs     L1BC6
        rti

L1BBF:  .byte   $03
L1BC0:  bvs     L1BEA
        eor     (L0043,x)
        bvs     L1B66
L1BC6:  rti

        .byte   $43
        bvs     L1B4A
        rti

        rti

        rti

        brk
        rti

        rti

L1BD0:  rti

        brk
        rti

        brk
        rti

        brk
        rti

        brk
        rti

        rti

        rti

        brk
        rti

        rti

        rti

        .byte   $80
L1BE0:  rti

        rti

        .byte   $42
        ldy     #$40
        .byte   $54
        rti

        .byte   $80
        brk
        rti

L1BEA:  rti

        brk
        brk
        rti

        rti

        brk
        rti

        rti

        rti

        brk
        rti

        brk
        rti

        brk
        rti

        brk
        rti

        ora     $54
        brk
        eor     $55,x
        eor     $55,x
        eor     $55,x
        eor     $55,x
        rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
L1C0E:  rti

        brk
        bmi     L1C12
L1C12:  rti

        brk
        sbc     $54,x
        rti

        .byte   $03
        bmi     L1C1E
        rti

        .byte   $0C
L1C1C:  bmi     L1C22
L1C1E:  rti

        bmi     L1C51
        .byte   $04
L1C22:  rti

        cpy     #$30
        .byte   $04
        .byte   $43
        brk
        bmi     L1C2E
        rti

        brk
        bmi     L1C32
L1C2E:  rti

        brk
        bmi     L1C32
L1C32:  rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        rti

        rol     a
        tax
        ldy     #$40
        jsr     L0800
        rti

        jsr     L0800
        rti

        jsr     L00FF
        rti

        brk
        .byte   $FF
L1C51:  brk
        rti

        brk
        brk
        php
        rti

        brk
        brk
        php
        rti

        .byte   $02
        tax
L1C5D:  tay
L1C5E:  eor     $55,x
        eor     $55,x
        eor     $55,x
        eor     $55,x
        rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        eor     ($55,x)
        bvc     L1C7E
        eor     ($AA,x)
        ldy     L0000
        eor     ($AA,x)
        bcc     L1C7A
L1C7A:  eor     ($AA,x)
        rti

        .byte   $05
L1C7E:  eor     ($A9,x)
        brk
        ora     ($41,x)
        .byte   $54
        php
        ora     ($40,x)
        brk
        php
        brk
        rti

        brk
        php
        brk
        .byte   $43
        sbc     a:$08,x
        rti

        ora     a:$08
        rti

        ora     a:$08
        rti

        ora     a:$08
        rti

        ora     $A00A
        eor     ($0D,x)
        php
        brk
        eor     ($0D,x)
        brk
        brk
        eor     ($0D,x)
        brk
        .byte   $1C
        rti

        ora     $5C55
        rti

        .byte   $0F
        .byte   $FF
        .byte   $FC
        rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        eor     $55,x
        eor     $55,x
        eor     $55,x
        eor     $55,x
        rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
L1CCE:  rti

        brk
        brk
        .byte   $04
        rti

        eor     $55,x
        bvc     L1D18
        brk
        brk
        brk
        eor     (L0000,x)
        brk
        brk
        eor     ($80,x)
        brk
        brk
        eor     (L00A0,x)
        eor     L0000,x
        eor     ($A9,x)
        brk
        rti

        rti

        .byte   $54
        brk
        rti

        rti

        brk
        brk
        rti

        rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        rti

        brk
        brk
L1CFD:  brk
L1CFE:  rti

        .byte   $F0
L1D00:  .byte   $02
L1D01:  brk
        rti

L1D03:  .byte   $3C
        brk
        tay
        rti

        .byte   $0F
        brk
        plp
        rti

        .byte   $03
        beq     L1D0E
L1D0E:  eor     (L0000,x)
        .byte   $3F
        brk
        eor     ($40,x)
        .byte   $03
        .byte   $FF
        rti

        brk
L1D18:  brk
        brk
        rti

        brk
        brk
L1D1D:  brk
        eor     $55,x
        eor     $55,x
        eor     $55,x
        eor     $55,x
        rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        .byte   $43
        ora     $54
        jsr     L0043
        brk
        php
        .byte   $43
        brk
        brk
        .byte   $0C
        .byte   $43
        .byte   $FF
        .byte   $FF
        .byte   $FC
        .byte   $43
        brk
        brk
        brk
        .byte   $43
        brk
        brk
        brk
        rti

        asl     a
        .byte   $80
        bpl     L1D8B
        brk
        jsr     L4000
        brk
        php
        brk
        rti

        rti

        .byte   $02
        brk
        rti

        brk
        brk
        .byte   $80
        rti

L1D5B:  brk
        brk
        .byte   $80
        rti

        tax
        tax
        .byte   $80
        rti

        jsr     L0000
        rti

        php
        brk
        brk
        rti

        .byte   $02
        brk
        .byte   $0F
        rti

        brk
        .byte   $83
        .byte   $FF
        rti

        brk
L1D74:  brk
        brk
        rti

        brk
        brk
        brk
        rti

        brk
        .byte   $80
        brk
        eor     $55,x
        eor     $55,x
        eor     $55,x
        eor     $55,x
        rti

        brk
        brk
        brk
        rti

L1D8B:  brk
        brk
        brk
        .byte   $43
        .byte   $FF
        .byte   $FF
        .byte   $FC
        .byte   $43
        brk
        brk
        brk
        .byte   $43
        brk
        brk
        brk
        .byte   $43
        asl     a
        tax
        tay
        .byte   $43
        php
        brk
        .byte   $04
        .byte   $43
        php
        brk
        .byte   $04
        .byte   $43
        php
        ora     $54,x
        .byte   $43
        cli
        bpl     L1DAE
L1DAE:  rti

        brk
        bpl     L1DB2
L1DB2:  rti

        brk
        bpl     L1DB6
L1DB6:  .byte   $43
        php
        bpl     L1DBA
L1DBA:  .byte   $43
        php
        ora     $54,x
        .byte   $43
        php
        brk
        brk
        .byte   $43
        php
        brk
        brk
        .byte   $43
        asl     a
        tax
        tay
        .byte   $43
        brk
        brk
        .byte   $04
        .byte   $43
        brk
        brk
        .byte   $04
        .byte   $43
        .byte   $FF
        .byte   $FF
        .byte   $FC
        rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        eor     $55,x
        eor     $55,x
        eor     $55,x
        eor     $55,x
        rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        eor     $55,x
        eor     $54,x
L1DF2:  rti

        brk
        brk
        .byte   $04
        rti

        brk
        brk
        .byte   $04
        eor     ($55,x)
        eor     $04,x
        eor     (L0000,x)
        ora     ($04,x)
        eor     (L0000,x)
        ora     ($04,x)
        eor     (L0000,x)
        ora     (L0000,x)
        eor     (L0000,x)
        ora     (L0000,x)
        eor     (L0000,x)
        ora     ($54,x)
        eor     (L0000,x)
        brk
        brk
        eor     ($55,x)
        rti

        brk
        rti

        .byte   $03
        .byte   $80
        brk
L1E1E:  rti

        .byte   $03
        .byte   $80
        brk
        eor     ($55,x)
        rti

        brk
        eor     (L0000,x)
        brk
        bvc     L1E6C
        brk
        brk
        bpl     L1E70
        brk
        brk
        bpl     L1E74
        eor     $55,x
        .byte   $50
L1E36:  rti

        brk
        brk
        brk
L1E3A:  rti

        brk
        brk
        brk
        eor     $55,x
        eor     $55,x
        eor     $55,x
        eor     $55,x
        rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        .byte   $43
        sbc     $0440,x
        rti

        .byte   $02
        bvc     L1E5A
        rti

        .byte   $02
        .byte   $54
        .byte   $04
L1E5A:  rti

        .byte   $02
        .byte   $55
L1E5D:  .byte   $04
        rti

        .byte   $02
        eor     $04,x
        rti

        .byte   $02
        .byte   $54
        ora     $40
        .byte   $02
        bvc     L1E6A
L1E6A:  .byte   $43
        .byte   $FD
L1E6C:  rti

        brk
        rti

        brk
L1E70:  brk
        brk
        rti

        brk
L1E74:  brk
        brk
        .byte   $42
L1E77:  tax
        tax
        ldy     #$41
        eor     $55,x
        rts

        .byte   $43
        .byte   $FF
        .byte   $FF
        rts

        rti

        brk
        .byte   $03
        rts

        rti

        brk
        .byte   $03
        rts

        rti

        brk
        .byte   $03
        rts

        rti

        brk
        .byte   $03
        rts

        rti

        brk
        .byte   $03
        rts

        rti

        brk
        .byte   $03
        rts

        rti

        brk
        .byte   $03
        rts

        eor     $55,x
        eor     $55,x
        eor     $55,x
        eor     $55,x
        rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        rti

        ora     ($55,x)
        .byte   $54
        rti

        brk
        brk
        .byte   $04
        eor     $40,x
        brk
        .byte   $04
        rti

        .byte   $42
        tax
        .byte   $54
        rti

        rti

        brk
        rti

        rti

        rti

        brk
        rti

        rti

        rti

        brk
        rti

        rti

        brk
        brk
        rti

L1ECE:  rti

        ora     ($55,x)
        rti

        rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        bvc     L1EDC
L1EDC:  bmi     L1EDE
L1EDE:  .byte   $64
        brk
        .byte   $3A
        brk
        adc     #$00
        brk
        brk
        ror     a
        .byte   $43
        .byte   $FF
        .byte   $FF
        adc     #$00
        brk
        .byte   $03
        .byte   $64
        brk
        brk
        .byte   $03
        bvc     L1EF4
L1EF4:  .byte   $03
        .byte   $FF
        rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        eor     $55,x
        eor     $55,x
        eor     $5A,x
        tax
        lda     $40
        asl     $AA
        ldy     $40
        ora     ($AA,x)
        ldy     $40
        brk
        eor     $54,x
L1F12:  rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        .byte   $42
        .byte   $80
        ora     L0000
L1F1E:  .byte   $42
L1F1F:  .byte   $80
        ora     L0000
        rti

        brk
        ora     $40,x
        rti

        brk
        cmp     L0030
        rti

        .byte   $0F
        cpy     #$3C
        rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        rti

        ora     $50,x
        brk
        rti

        .byte   $1F
        bne     L1F42
L1F42:  rti

        .byte   $1F
        bne     L1F4A
        rti

        .byte   $1F
        bne     L1F4E
L1F4A:  rti

        .byte   $1F
        bne     L1F53
L1F4E:  rti

        .byte   $1F
        bne     L1F57
        rti

L1F53:  ora     $0450,x
        rti

L1F57:  ora     $0400,x
        rti

        .byte   $1D
        brk
L1F5D:  brk
        eor     $5D,x
        eor     $55,x
        eor     $55,x
        eor     $55,x
        rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        eor     ($40,x)
        brk
        .byte   $04
        rti

        bpl     L1F75
L1F75:  .byte   $04
        rti

        .byte   $04
        brk
        .byte   $04
        rti

        .byte   $04
        brk
        bpl     L1FD4
        ora     (L0000,x)
        bpl     L1FC3
        brk
        rti

        rti

        rti

L1F87:  brk
        bpl     L1FCA
        rti

        brk
        .byte   $3F
        cpy     #$40
        brk
        brk
        brk
        rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        rti

        beq     L1F9D
L1F9D:  bvc     L1FE0
        .byte   $54
        ora     ($40,x)
L1FA2:  rti

        brk
        ora     L0000
        rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        rti

        ora     ($40,x)
        ldy     #$40
        ora     L0000
        ldy     #$40
        .byte   $14
        brk
        ldy     #$40
        bvc     L1FBD
L1FBD:  .byte   $A0
L1FBE:  eor     $55,x
        eor     $55,x
        .byte   $55
L1FC3:  eor     $55,x
        eor     $40,x
        brk
        brk
        brk
L1FCA:  rti

        brk
        brk
        brk
        eor     ($0A,x)
        tax
        ldy     #$41
L1FD3:  brk
L1FD4:  brk
        bmi     L2018
        brk
        brk
        .byte   $3C
        eor     ($05,x)
        .byte   $54
        .byte   $0C
        eor     ($04,x)
L1FE0:  .byte   $04
        .byte   $0F
        eor     ($04,x)
        .byte   $04
        brk
        eor     ($04,x)
        .byte   $04
        brk
        eor     ($04,x)
        .byte   $04
        brk
        eor     ($04,x)
        .byte   $04
        brk
        eor     ($04,x)
        .byte   $04
        brk
        eor     ($04,x)
        .byte   $04
        brk
        eor     (L0000,x)
        brk
L1FFD:  brk
        eor     (L0000,x)
        brk
L2001:  brk
        .byte   $41
L2003:  php
        brk
        brk
        eor     ($0A,x)
        ora     $54
        eor     (L0000,x)
        brk
        brk
        eor     (L0000,x)
        brk
        brk
        eor     ($55,x)
        eor     $54,x
        rti

        brk
L2018:  brk
        brk
        rti

        brk
        brk
L201D:  brk
        eor     $55,x
L2020:  eor     $55,x
        eor     $55,x
        eor     $55,x
        rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        rti

        brk
        brk
        .byte   $0C
        ror     a
        tax
        ldy     #$FC
        eor     $55,x
        bvc     L208E
        rti

        brk
        brk
        brk
        rti

        brk
        brk
L2041:  brk
        .byte   $42
        tax
        tax
        .byte   $80
        .byte   $42
        brk
        brk
        .byte   $80
        .byte   $42
        brk
        brk
        .byte   $80
        .byte   $42
        ldy     #$2A
        .byte   $80
        rti

        jsr     L0020
        rti

        brk
        jsr     L4000
        brk
        brk
        rti

        .byte   $41
L205F:  .byte   $54
        brk
        rti

        eor     ($01,x)
L2064:  brk
        rti

        eor     ($01,x)
        eor     $40,x
        eor     (L0000,x)
        brk
L206D:  brk
        eor     (L0000,x)
        brk
        brk
        eor     ($55,x)
        eor     $50,x
        rti

        brk
        brk
        bpl     L20BB
        brk
        brk
        bpl     L20D4
        eor     $55,x
        eor     $55,x
        eor     $55,x
        eor     $40,x
        brk
        cpy     #$00
        rti

        brk
        cpy     #$00
L208E:  rti

        brk
        cpy     #$00
        .byte   $43
        .byte   $FF
        .byte   $FF
        beq     L20D7
        brk
        cpy     #$00
        rti

        brk
        cpy     #$00
        rti

        eor     $55,x
        .byte   $42
L20A2:  rti

        eor     L0000,x
        .byte   $02
        rti

        .byte   $54
        brk
        brk
        rti

        .byte   $54
        php
        brk
        rti

        php
        plp
        brk
        rti

        php
        plp
        brk
        rti

        php
        plp
        brk
        rti

L20BB:  php
        brk
        brk
        rti

        php
        brk
        brk
        rti

        asl     a
        tax
L20C5:  brk
        rti

        brk
        .byte   $02
        brk
L20CA:  .byte   $43
        brk
        .byte   $02
        ora     (L0043,x)
        brk
        .byte   $02
        .byte   $01
L20D2:  .byte   $42
        tax
L20D4:  tax
        brk
        rti

L20D7:  brk
L20D8:  brk
        brk
        rti

        brk
        brk
        brk
        eor     $55,x
        eor     $55,x
        eor     $55,x
        eor     $55,x
        rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        rti

        brk
        .byte   $02
        brk
        rti

        ora     $42
        brk
        rti

        bpl     L213B
        .byte   $80
        rti

        bpl     L213F
        ldy     #$40
        .byte   $10
L2100:  lsr     $A8,x
        rti

        bpl     L2105
L2105:  brk
        rti

        bvc     L2109
L2109:  brk
        eor     (L0000,x)
        brk
        brk
        eor     (L0000,x)
        brk
        brk
        eor     (L00FF,x)
        .byte   $FC
        brk
        rti

        brk
L2118:  brk
        brk
        rti

        brk
        brk
        brk
        rti

        .byte   $05
L2120:  .byte   $54
        brk
        eor     ($50,x)
        brk
        brk
        rti

        brk
        brk
        bmi     L216B
        brk
        brk
        asl     $0340
        cpx     $02
        rti

        .byte   $0F
        ldy     $02
        rti

        .byte   $3E
        .byte   $90
L2139:  brk
        rti

L213B:  inc     a:$40,x
        .byte   $55
L213F:  eor     $55,x
        eor     $55,x
        eor     $55,x
        eor     $40,x
        brk
        brk
        brk
        rti

        brk
        brk
        brk
        eor     ($54,x)
        .byte   $3F
        .byte   $FC
        rti

        .byte   $04
        .byte   $3F
        .byte   $FC
        rti

L2157:  .byte   $04
        .byte   $3C
        brk
        rti

        brk
        .byte   $3C
        brk
L215E:  rti

        brk
        brk
        .byte   $3C
        .byte   $42
        brk
        brk
        .byte   $3C
        .byte   $42
        .byte   $0F
        .byte   $FF
        .byte   $FC
        .byte   $42
L216B:  asl     a
        tax
        tay
        .byte   $42
        brk
        brk
        brk
        .byte   $42
        brk
        brk
        brk
        .byte   $42
        .byte   $02
        tay
        brk
        .byte   $42
        .byte   $02
        php
        brk
        .byte   $42
        .byte   $02
        php
        brk
        .byte   $42
        tax
        php
        php
        rti

        brk
        php
        php
        rti

        brk
        php
        php
        .byte   $43
        .byte   $FF
        sed
        php
L2192:  .byte   $43
        nop
        tax
        tay
        rti

        brk
        brk
        brk
        rti

        brk
        brk
        brk
        eor     $55,x
        eor     $55,x
        eor     $55,x
        eor     $55,x
        rti

        brk
        brk
        brk
        rti

L21AB:  brk
        brk
        brk
        eor     ($40,x)
        .byte   $14
        .byte   $03
        eor     ($90,x)
        ora     $03
        eor     ($A4,x)
        ora     ($40,x)
        eor     ($A9,x)
        brk
        rti

        eor     ($AA,x)
L21C0:  rti

        brk
        eor     ($AA,x)
        bcc     L21C6
L21C6:  eor     ($AA,x)
        ldy     L0000
        eor     ($AA,x)
        ldy     L0000
        eor     ($AA,x)
        ldy     L0000
        eor     ($AA,x)
        ldy     L0000
        eor     ($AA,x)
        bcc     L21DA
L21DA:  eor     ($AA,x)
        rti

        bmi     L2220
        lda     #$00
        beq     L2224
        ldy     $03
        beq     L2228
        bcc     L21F8
        cpy     #$41
        rti

        .byte   $3F
        brk
        rti

        brk
        .byte   $0F
        cpy     #$40
        brk
        .byte   $03
        beq     L2237
        brk
L21F8:  brk
        beq     L223B
        ora     L0000
        bmi     L2254
        eor     $55,x
        eor     $55,x
        eor     $55,x
        eor     $40,x
        brk
        bpl     L220A
L220A:  rti

        brk
        bpl     L220E
L220E:  rti

        brk
        bvc     L2267
        rti

        ora     ($40,x)
        ror     a
        rti

        ora     L0000
        eor     $40,x
        .byte   $14
        brk
        brk
        rti

        .byte   $50
L2220:  brk
        brk
        eor     ($40,x)
L2224:  .byte   $3F
        beq     L2268
        brk
L2228:  beq     L222A
L222A:  rti

        .byte   $03
        cpy     #$00
        rti

        .byte   $0F
        brk
        brk
        rti

        .byte   $3C
        brk
        brk
        .byte   $43
L2237:  beq     L2239
L2239:  brk
        .byte   $43
L223B:  cpy     #$0C
        brk
        .byte   $43
        cpy     #$3F
        brk
        rti

        brk
        .byte   $FF
        cpy     #$40
        .byte   $02
        tax
        ldy     #$40
        .byte   $02
        tax
        ldy     #$40
        .byte   $02
        tax
        ldy     #$40
        .byte   $01
L2254:  eor     $50,x
        rti

        brk
        brk
        bpl     L229B
        brk
        brk
        brk
        eor     $55,x
        eor     $55,x
        eor     $55,x
L2264:  eor     $55,x
        rti

L2267:  brk
L2268:  brk
        brk
        rti

        brk
L226C:  brk
        brk
        rti

        ora     $55,x
        .byte   $54
        rti

        .byte   $1A
        tax
L2275:  ldy     $40
        .byte   $1A
        tax
        bcc     L22BB
        .byte   $1A
        tax
        ldy     $40
        .byte   $1A
        eor     $54,x
        rti

        .byte   $1A
        rti

        brk
        rti

        ror     a
        rti

        brk
        eor     ($AA,x)
        rti

        brk
        eor     ($AA,x)
        rti

        brk
        eor     ($AA,x)
        eor     (L0000,x)
        eor     ($AA,x)
        eor     (L0000,x)
        .byte   $41
L229B:  tax
        eor     (L0000,x)
        eor     ($AA,x)
        eor     (L0000,x)
        eor     ($AA,x)
L22A4:  .byte   $41
L22A5:  brk
        rti

        ror     a
        eor     ($55,x)
        rti

        .byte   $1A
L22AC:  rti

        brk
        rti

        .byte   $1A
        rti

        brk
        rti

        .byte   $1A
        eor     $50,x
        rti

        .byte   $1A
        tax
        bcc     L22FB
L22BB:  .byte   $1A
        tax
        bcc     L2314
        eor     $55,x
        eor     $A9,x
        ora     L0020
        .byte   $D2
        .byte   $FF
        lda     #$93
        jsr     LFFD2
        sei
        jsr     L1AE7
        lda     #$9C
        ldx     #$37
        sta     $02
        stx     $03
        jsr     L2CAE
        jmp     L2CC3

        ora     (L0000,x)
        brk
        sei
        jsr     L1AE7
        lda     #$0C
        sta     $24
        sta     $25
        lda     #$02
        sta     $32
        jsr     L1B67
        jsr     L2139
        jsr     L1BE0
        jsr     L1A20
L22FB:  lda     #$01
        sta     $2D
        sta     $73
        sta     $6B
        sta     $63
        jsr     L2C34
        jsr     L2064
        lda     #$00
        sta     $2D
        jsr     L31DD
        .byte   $20
        .byte   $10
L2314:  bit     $1720
        and     #$A5
        bit     $03F0
        jsr     L201D
L231F:  ldx     #$08
        jsr     L1ADB
        jsr     L20D8
        .byte   $C6
L2328:  .byte   $63
        bne     L2332
        lda     $BA
        sta     $63
        jsr     L22AC
L2332:  jmp     L19AD

        lda     L197D
        bne     L233D
        jmp     L1B73

L233D:  lda     #$FD
        sta     $FF08
        lda     #$4A
        sta     L1A16
        lda     $FF08
        eor     #$FF
        bne     L2369
        lda     #$FA
        sta     $FF08
        lda     #$EA
        sta     L1A16
        .byte   $AD
L2359:  php
        .byte   $FF
        eor     #$FF
        bne     L2369
        lda     #$00
        ldx     #$05
L2363:  sta     $07,x
        dex
        bpl     L2363
L2368:  rts

L2369:  ror     a
        ror     $09
        ror     a
        ror     $0A
        ror     a
        ror     $07
        ror     a
        ror     $08
        lsr     a
        lsr     a
        lsr     a
        nop
        ror     $0B
        lda     #$01
        sta     $0C
        rts

        cmp     (L0000,x)
        sei
        lda     #$3C
        .byte   $8D
        .byte   $14
L2387:  .byte   $03
        lda     #$1A
        sta     $0315
        lda     #$02
        sta     $FF0A
        lda     L1A1E
        .byte   $8D
        .byte   $0B
L2397:  .byte   $FF
        lda     #$00
        sta     $0D
        cli
        rts

        lda     $FF09
        sta     $FF09
        lda     $0D
        eor     #$01
        sta     $0D
        lda     $13
        pha
        lda     $14
        pha
L23B0:  lda     $2E
        pha
        lda     $2F
        pha
        lda     $0D
        bne     L23BD
        jmp     L1A78

L23BD:  jmp     L1A8B

        pla
        sta     $2F
        pla
        sta     $2E
        pla
        sta     $14
        pla
        sta     $13
        ldx     $0D
        .byte   $BD
        .byte   $1E
L23D0:  .byte   $1A
        sta     $FF0B
        pla
L23D5:  tay
        pla
        tax
        pla
        rti

        lda     $FF07
        and     #$F0
        ora     #$08
        sta     $FF07
        jsr     L250F
        jsr     L1AB7
        jmp     L1A5E

        ldx     #$07
L23EF:  dex
        bpl     L23EF
        lda     $FF07
        and     #$F0
        ora     $04
        sta     $FF07
        jsr     L1BA5
        jsr     L19D3
        lda     $2D
        bne     L240F
        jsr     L28EA
        jsr     L23D0
        jsr     L1D74
L240F:  lda     L00A0
        beq     L2416
        jsr     L3444
L2416:  jmp     L1A5E

        lda     $FF00
        and     $10
        adc     $FF02
        asl     a
        asl     a
L2423:  rol     $11
        rol     $10
        rol     $0F
        rol     $0E
L242B:  clc
        ldy     #$29
        ldx     #$FC
L2430:  tya
        ldy     $12,x
        adc     $12,x
        sta     $12,x
        inx
        bne     L2430
        rts

        ldx     #$20
        ldy     #$00
L243F:  nop
        nop
        nop
        dey
        bne     L243F
        dex
        bne     L243F
        rts

        lda     #$00
        ldx     #$07
L244D:  sta     L0000,x
        inx
        bne     L244D
        rts

        lda     #$16
        sta     $AF
L2457:  ldx     #$00
        ldy     $AF
        jsr     L1B0E
        ldy     #$1E
L2460:  lda     #$C4
        sta     ($13),y
        lda     #$71
        sta     ($2E),y
        dey
        bne     L2460
        dec     $AF
        bne     L2457
        rts

        cpy     #$00
        bpl     L2476
        ldy     #$00
L2476:  tya
        asl     a
        tay
        lda     L1B35,y
        sta     $13
        .byte   $B9
L247F:  rol     $1B,x
        sta     $14
        txa
        clc
        adc     $13
        sta     $13
        sta     $2E
        lda     $14
        adc     #$00
        sta     $14
        sec
        sbc     #$04
        sta     $2F
        rts

        brk
        .byte   $0C
        plp
        .byte   $0C
L249B:  bvc     L24A9
        sei
        .byte   $0C
        ldy     #$0C
        iny
        .byte   $0C
        beq     L24B1
        clc
        ora     $0D40
L24A9:  pla
        ora     $0D90
        clv
        ora     $0DE0
L24B1:  php
        .byte   $0E
L24B3:  bmi     $24C3
        cli
        asl     $0E80
        tay
        asl     $0ED0
        sed
        asl     $0F20
        pha
        .byte   $0F
        bvs     L24D4
        tya
        .byte   $0F
        cpy     #$0F
        ldx     #$1F
L24CB:  lda     L3FA0,x
        sta     L3960,x
        dex
        bpl     L24CB
L24D4:  rts

L24D5:  .byte   $A9
L24D6:  brk
        sta     $0C
        ldx     #$04
L24DB:  lda     L1B9B,x
        ldy     L1BA0,x
        jsr     L1B88
        ror     $07,x
        dex
        bpl     L24DB
        rts

        sty     $FD30
        sty     $FF08
        and     $FF08
        bne     L24FB
        lda     #$01
        sta     $0C
        sec
        rts

L24FB:  clc
        rts

        bpl     L247F
        .byte   $04
L2500:  .byte   $80
        bpl     L2500
        .byte   $FB
        .byte   $BF
        .byte   $BF
        .byte   $7F
        lda     $04
        sec
        sbc     #$01
        tay
        and     #$07
L250F:  sta     $04
        tya
        and     #$08
        bne     L2517
        rts

L2517:  ldx     #$00
L2519:  lda     $0FC1,x
        sta     $0FC0,x
        inx
        cpx     #$27
        bne     L2519
        inc     $02
        bne     L252A
        inc     $03
L252A:  ldy     #$00
        lda     ($02),y
        cmp     #$FF
        bne     L253C
        lda     #$9C
        sta     $02
        lda     #$37
        sta     $03
        bne     L252A
L253C:  and     #$3F
        sta     $0FE7
        rts

        lda     $FF12
        and     #$FB
        sta     $FF12
        lda     $FF07
        ora     #$90
        sta     $FF07
        lda     #$38
        sta     $FF13
        ldx     #$03
L2559:  lda     $FF00,x
        sta     $0E,x
        dex
        bpl     L2559
        lda     #$11
        sta     $FF15
        sta     $FF19
        lda     #$00
        sta     $FF16
        lda     #$46
        sta     $FF17
        rts

        lda     #$00
        sta     $18
        ldx     $1D
        lda     $0219,x
        sta     $17
        ldx     #$05
L2581:  asl     $17
        rol     $18
        cpx     #$01
        bne     L2591
        lda     $17
        sta     $19
        lda     $18
        sta     $1A
L2591:  dex
        bpl     L2581
        lda     $17
        clc
        adc     $19
        sta     L1C5D
        lda     $18
        .byte   $65
L259F:  .byte   $1A
        clc
        adc     #$10
        sta     L1C5E
        lda     #$00
        sta     $13
        lda     #$04
        sta     $14
        ldx     #$00
        lda     #$17
        sta     $1C
L25B4:  lda     #$03
        sta     $1B
        lda     $13
        pha
        lda     $14
        pha
L25BE:  lda     $FFFF,x
        ldy     #$00
L25C3:  asl     a
        rol     $19
        asl     a
        rol     $19
        pha
        lda     $19
        and     #$03
        clc
L25CF:  adc     #$C4
        sta     ($13),y
        pla
        iny
L25D5:  cpy     #$04
        bne     L25C3
        lda     $13
        clc
        adc     #$04
        sta     $13
        lda     $14
        adc     #$00
        sta     $14
        inx
        dec     $1B
        bpl     L25BE
        pla
        sta     $14
        pla
        clc
        adc     #$28
        sta     $13
        .byte   $A5
L25F5:  .byte   $14
        adc     #$00
        sta     $14
        dec     $1C
        bpl     L25B4
        lda     $B5
        beq     L2646
        lda     #$00
        tax
L2605:  sta     $0400,x
        sta     $0500,x
        sta     $0600,x
        sta     $06C0,x
        inx
        bne     L2605
        .byte   $A9
L2615:  brk
        sta     $13
        lda     #$04
        sta     $14
        ldy     #$0F
        lda     #$C7
L2620:  sta     ($13),y
        dey
        bpl     L2620
        ldx     #$16
        ldy     #$00
L2629:  lda     #$C7
        sta     ($13),y
L262D:  lda     $13
        clc
        adc     #$28
        sta     $13
        lda     $14
        adc     #$00
        sta     $14
        dex
        bpl     L2629
        ldy     #$0F
        lda     #$C7
L2641:  sta     ($13),y
        dey
        .byte   $10
L2645:  .byte   $FB
L2646:  lda     #$00
        sta     L1CFD
        sta     L1D00
        lda     #$04
        sta     L1CFE
        sta     L1D01
        lda     #$17
        sta     $1C
L265A:  ldx     #$00
        .byte   $A0
L265D:  .byte   $1F
L265E:  lda     $FFFF,x
        sta     $FFFF,y
        inx
        dey
        cpy     #$0F
        bne     L265E
        lda     L1CFD
        clc
        adc     #$28
        sta     L1CFD
        sta     L1D00
        lda     L1CFE
        adc     #$00
        sta     L1CFE
        sta     L1D01
        dec     $1C
        bpl     L265A
        ldx     $1D
        lda     L1D5B,x
        sta     L0020
        ldx     #$C8
        and     #$01
        beq     L2698
        stx     $05D7
        stx     $05FF
L2698:  lda     L0020
        and     #$02
        beq     L26A4
        stx     $05B8
        stx     $05E0
L26A4:  lda     L0020
        and     #$04
        beq     L26B0
        stx     $040F
        stx     $0410
L26B0:  lda     L0020
        and     #$08
        beq     L26BC
        stx     $07A7
        stx     $07A8
L26BC:  rts

        ora     #$0B
        .byte   $0B
        .byte   $0B
        asl     a
        ora     $0F0F
        .byte   $0F
        asl     $0F0D
        .byte   $0F
        .byte   $0F
        asl     $0F0D
        .byte   $0F
        .byte   $0F
        asl     $0705
        .byte   $07
        .byte   $07
        asl     L0020
        lda     L201D
        .byte   $63
        .byte   $1E
        .byte   $A6
L26DD:  rol     $A4,x
        .byte   $37
        jsr     L1FA2
        lda     $2A
        beq     L270B
        jsr     L31C9
        lda     $9C
        bne     L270E
        jsr     L2003
        lda     $2C
        bne     L270E
        lda     $22
        sta     $21
        lda     $25
        sta     $24
        lda     $38
L26FF:  sta     $32
        lda     #$00
        sta     $35
        sta     L0030
        sta     $31
        sta     $2A
L270B:  jsr     L1F12
L270E:  rts

        ldx     $22
        ldy     $25
        dey
        jsr     L1B0E
        jsr     L1F87
        ldx     $21
        ldy     $24
        jsr     L1B0E
        lda     $31
        bne     L2729
        lda     L0030
        beq     L2766
L2729:  lda     #$00
        sta     $94
L272D:  sta     $98
        lda     $32
        cmp     #$03
        bcs     L27A0
        ldx     L0030
        lda     L1DF2,x
        clc
        adc     #$94
        sta     $34
        ldx     #$00
L2741:  ldy     L20D2,x
        lda     $34
        sta     ($13),y
        inc     $34
        lda     #$79
        sta     ($2E),y
        inx
        cpx     #$06
        bne     L2741
        rts

        brk
        asl     $0C
        .byte   $12
        brk
        ora     ($27,x)
        plp
        and     #$2A
L275E:  .byte   $2B
        .byte   $4F
        bvc     L27B3
        .byte   $52
        .byte   $53
        sei
        .byte   $79
L2766:  lda     $98
        bne     L2777
        ldx     #$01
        stx     $94
        stx     $98
        dex
        stx     $95
        lda     #$0A
        sta     $96
L2777:  lda     $32
        and     #$03
        beq     L2786
        ldx     $21
        inx
        ldy     $24
        dey
        jsr     L1B0E
L2786:  ldx     #$03
L2788:  lda     L1E36,x
        ldy     L1E3A,x
        sta     ($13),y
        lda     #$79
        sta     ($2E),y
        dex
        bpl     L2788
        rts

L2798:  .byte   $1C
        ora     L1F1E,x
        plp
        and     #$50
        .byte   $51
L27A0:  ldx     $31
        lda     L1DF2,x
        clc
        adc     #$AC
        sta     $34
        ldx     #$00
L27AC:  ldy     L1E5D,x
        lda     $34
        sta     ($13),y
L27B3:  .byte   $A9
L27B4:  adc     $2E91,y
        inc     $34
        inx
        cpx     #$06
L27BC:  bne     L27AC
        rts

        brk
        ora     ($28,x)
        and     #$50
        eor     ($A5),y
        bmi     L2798
        sec
        lda     $31
        .byte   $D0
L27CC:  .byte   $34
        lda     $21
        sta     $22
        lda     $24
        sta     $25
        lda     $32
        sta     $38
        bit     $0B
        .byte   $10
L27DC:  .byte   $03
        jsr     L289D
L27E0:  bit     $07
        bpl     L2802
        lda     $32
        and     #$0C
        beq     L27EE
        inc     $24
L27EC:  dec     $21
L27EE:  ldx     #$01
        stx     $32
        stx     $35
        dex
        stx     L0030
        stx     $33
        ldx     $21
        stx     $36
        .byte   $A4
L27FE:  bit     $84
        .byte   $37
L2801:  rts

L2802:  bit     $08
        bpl     L2828
        inc     $21
        lda     $32
        and     #$0C
        beq     L2812
        dec     $21
        inc     $24
L2812:  ldx     #$03
        stx     L0030
        dex
        stx     $32
        dex
        stx     $33
        stx     $35
        ldy     $24
        sty     $37
        ldx     $21
        inx
        stx     $36
        rts

L2828:  bit     $09
        bpl     L284C
        lda     $32
        and     #$03
        beq     L2836
        inc     $21
        dec     $24
L2836:  lda     #$04
        sta     $32
        ldx     #$01
        stx     $35
        dex
        stx     $33
        stx     $31
        ldx     $21
        stx     $36
        ldy     $24
        sty     $37
        rts

L284C:  bit     $0A
        bpl     L2801
        lda     $32
        and     #$03
        .byte   $F0
L2855:  .byte   $04
        dec     $24
        inc     $21
L285A:  lda     #$08
        sta     $32
        lda     #$03
        sta     $31
        lda     #$01
        sta     $35
        sta     $33
L2868:  inc     $24
        ldx     $21
        stx     $36
        ldy     $24
        iny
        sty     $37
        rts

        lda     $35
        beq     L2880
        lda     $33
        beq     L2881
        lda     #$00
        sta     $33
L2880:  rts

L2881:  lda     #$01
        bit     $32
        bne     L2896
        asl     a
        bit     $32
        .byte   $D0
L288B:  and     ($0A,x)
        bit     $32
        bne     L28D2
        asl     a
        bit     $32
        bne     L28C4
L2896:  inc     L0030
        lda     L0030
        tay
        and     #$03
L289D:  sta     L0030
        cpy     #$04
        beq     L28A4
        rts

L28A4:  lda     #$00
        sta     L0030
        sta     $35
        dec     $21
        rts

L28AD:  dec     L0030
        lda     L0030
        tay
        and     #$03
        sta     L0030
        cpy     #$FF
        beq     L28BB
        rts

L28BB:  lda     #$00
        sta     L0030
        sta     $31
        sta     $35
        rts

L28C4:  dec     $31
        lda     $31
        tay
        and     #$03
        sta     $31
        cpy     #$FF
        beq     L28BB
        rts

L28D2:  inc     $31
        lda     $31
        tay
        and     #$03
        sta     $31
        cpy     #$04
        beq     L28E0
        rts

L28E0:  lda     #$00
        sta     $31
        sta     $35
        dec     $24
        rts

        .byte   $A2
L28EA:  .byte   $0D
L28EB:  ldy     $1DF6,x
        lda     ($13),y
        cmp     #$C4
        bcs     L2900
        cmp     #$94
        bcs     L28FC
        cmp     #$20
        bcs     L2900
L28FC:  lda     #$C4
        sta     ($13),y
L2900:  dex
        bpl     L28EB
        rts

        jsr     L1B0E
        ldx     #$03
L2909:  ldy     L1E5D,x
        lda     ($13),y
        sta     $39,x
        cmp     #$C5
        bcc     L291C
        cmp     #$F4
        bcs     L291C
        lda     #$01
        sta     $2A
L291C:  dex
        bpl     L2909
        rts

        ldx     #$03
L2922:  ldy     L1E5D,x
        lda     ($A2),y
        cmp     #$F8
        bne     L2931
        lda     #$01
        sta     $9C
        sta     $A4
L2931:  dex
        bpl     L2922
        rts

        lda     #$16
        sta     L0020
L2939:  ldx     #$00
        ldy     L0020
        jsr     L1B0E
        ldy     #$1E
L2942:  lda     ($13),y
        cmp     #$1C
        bne     L2958
        sty     $28
        lda     $13
        clc
        adc     $28
        sta     $A2
        lda     $14
        adc     #$00
        sta     $A3
        rts

L2958:  dey
        bne     L2942
        dec     L0020
        bne     L2939
        inc     $FF19
        jmp     L1FFD

        ldy     #$00
        ldx     #$03
L2969:  lda     $39,x
        cmp     #$C8
        bne     L2970
        iny
L2970:  dex
        bpl     L2969
        cpy     #$02
        .byte   $F0
L2976:  ora     ($60,x)
L2978:  lda     #$01
        sta     $2C
        sta     $2D
        rts

        lda     #$01
        bit     $32
        bne     L29A2
        asl     a
        bit     $32
        bne     L2995
        asl     a
        bit     $32
        bne     L29BC
        asl     a
        bit     $32
        bne     L29AF
        rts

L2995:  inc     $1E
        lda     #$00
        sta     $21
        lda     #$0B
        sta     $24
        jmp     L2064

L29A2:  dec     $1E
        lda     #$1C
        sta     $21
        lda     #$0B
        sta     $24
        jmp     L2064

L29AF:  inc     $1F
        lda     #$0F
        sta     $21
        lda     #$00
        sta     $24
        jmp     L2064

L29BC:  dec     $1F
        lda     #$0F
        sta     $21
        lda     #$14
        sta     $24
        ldy     $1F
        lda     L20C5,y
        clc
        adc     $1E
        sta     $1D
        tax
        lda     $028B,x
        sta     $B5
        jsr     L370A
        ldx     #$00
        stx     $67
        .byte   $86
L29DE:  bit     $3586
        stx     L0030
        stx     $31
        stx     $71
        stx     $72
        jsr     L1C12
        lda     #$10
        sta     $8F
        jsr     L2192
        lda     $B5
        bne     L29FD
        jsr     L275E
        jmp     L20A2

L29FD:  jsr     L27FE
        lda     #$07
        sta     $BA
        lda     $21
        .byte   $85
L2A07:  .byte   $23
        lda     $24
        sta     $26
        lda     $32
        sta     $A1
        lda     #$0E
        sta     $36
        lda     #$0A
        sta     $37
        lda     $9F
        bne     L2A1F
        jsr     L366F
L2A1F:  jsr     L2275
        lda     #$00
        sta     $2D
        rts

        brk
        ora     $0A
        .byte   $0F
        .byte   $14
        brk
        jsr     L6040
        .byte   $80
        ldy     #$C0
        cpx     #$00
        ora     ($02,x)
        plp
        and     #$2A
        ldy     #$07
        lda     #$FF
L2A3E:  sta     L3E50,y
        dey
        bpl     L2A3E
        ldx     $21
        inx
        txa
        lsr     a
        lsr     a
        tay
        lda     L2118,y
        pha
        lda     $24
        lsr     a
        lsr     a
        tay
        iny
        pla
        sta     L3E50,y
        ldx     #$18
L2A5B:  ldy     L2120,x
        lda     #$C9
        cpx     $1D
        bne     L2A66
        lda     #$CA
L2A66:  sta     $0EF2,y
        cmp     #$C9
        beq     L2A71
        lda     #$66
        bne     L2A73
L2A71:  lda     #$41
L2A73:  sta     $0AF2,y
        dex
        bpl     L2A5B
        rts

        .byte   $7F
        .byte   $BF
        .byte   $DF
        .byte   $EF
        .byte   $F7
        .byte   $FB
        sbc     a:$FE,x
        ora     ($02,x)
        .byte   $03
        .byte   $04
        plp
        and     #$2A
        .byte   $2B
        bit     $5150
        .byte   $52
        .byte   $53
        .byte   $54
        sei
        adc     $7B7A,y
        .byte   $7C
        ldy     #$A1
        ldx     #$A3
        ldy     L0020
        cpx     #$1B
        jsr     L215E
        ldx     #$18
L2AA3:  lda     $0419,x
        sta     $0200,x
        dex
        bpl     L2AA3
        jsr     L215E
        ldx     #$18
L2AB1:  lda     $0419,x
        sta     $0219,x
        lda     #$00
        sta     $028B,x
        dex
        bpl     L2AB1
        rts

        ldx     #$18
        lda     #$00
L2AC4:  .byte   $9D
L2AC5:  brk
        .byte   $04
        dex
        bpl     L2AC4
        lda     #$00
        sta     $1B
L2ACE:  jsr     L1AB7
        lda     $10
        and     #$1F
        cmp     #$19
        bcs     L2ACE
        tay
        tax
        lda     $0400,x
        bne     L2ACE
        lda     #$01
        sta     $0400,x
        tya
        ldx     $1B
        sta     $0419,x
        inc     $1B
        lda     $1B
        cmp     #$19
        bne     L2ACE
        rts

        lda     $FF16
        pha
        .byte   $AD
        .byte   $17
L2AFA:  .byte   $FF
        pha
        jsr     L1AF1
        lda     L197C
        beq     L2B09
        lda     #$2F
        sta     $FF11
L2B09:  lda     #$03
        sta     $41
        lda     #$08
        sta     L0020
        jsr     L1AB7
        lda     $0F
        and     #$03
        sta     $FF10
        lda     $10
        and     #$80
        sta     $FF0F
        .byte   $AD
        .byte   $0F
L2B24:  .byte   $FF
        clc
        adc     #$10
        sta     $FF0F
        lda     $FF10
        adc     #$00
        .byte   $8D
L2B31:  bpl     $2B32
        lda     #$00
        sta     $3F
        lda     #$0C
        sta     $40
        lda     #$00
        sta     $3D
        lda     #$04
        sta     $3E
        ldx     $41
        lda     L2264,x
        sta     $42
        lda     L2268,x
        ldx     L0020
        ora     L226C,x
        sta     L0043
        lda     $FF16
        and     #$0F
        ora     L226C,x
        sta     $FF16
        lda     $FF17
        and     #$0F
        ora     L226C,x
        sta     $FF17
        ldx     #$17
L2B6C:  ldy     #$1F
L2B6E:  lda     ($3D),y
        cmp     $42
        bne     L2B85
        sta     ($3F),y
        lda     $3F
        sta     $2E
        lda     $40
L2B7C:  sec
        sbc     #$04
        sta     $2F
        lda     L0043
        sta     ($2E),y
L2B85:  dey
        bpl     L2B6E
        lda     $3F
        clc
        adc     #$28
        sta     $3F
        lda     $40
        adc     #$00
        sta     $40
        lda     $3D
        clc
        adc     #$28
        sta     $3D
        lda     $3E
        adc     #$00
        sta     $3E
        dex
        bpl     L2B6C
        ldx     $8F
        jsr     L1ADB
        dec     L0020
        bmi     L2BB1
        jmp     L21C0

L2BB1:  dec     $41
        bmi     L2BB8
        jmp     L21AB

L2BB8:  lda     #$00
        sta     $FF11
        pla
        sta     $FF17
        pla
        sta     $FF16
        rts

L2BC6:  .byte   $C7
        dec     $C8
        cmp     $0F
        asl     a
        ora     $500C
        bvs     L2C31
        bvc     L2C13
        bmi     L2BF5
        bpl     L2BD7
L2BD7:  ldx     #$07
L2BD9:  lda     #$FF
        sta     $4C,x
        sta     $54,x
        sta     $44,x
        dex
        bpl     L2BD9
        ldx     #$03
        lda     #$01
L2BE8:  sta     $5C,x
        dex
        bpl     L2BE8
        lda     $AD
        cmp     $B4
        bne     L2BF4
        rts

L2BF4:  .byte   $A2
L2BF5:  .byte   $07
L2BF6:  lda     L22A4,x
        sta     $44,x
        dex
L2BFC:  bpl     L2BF6
        jsr     L2F97
        lda     #$01
        sta     $9A
        rts

        ora     ($01,x)
        ora     $0101,x
        ora     $1D,x
        ora     $A9,x
        brk
        sta     $67
        .byte   $A2
L2C13:  .byte   $07
L2C14:  lda     $4C,x
        sta     $54,x
        dex
        bpl     L2C14
        ldx     $21
        ldy     $24
        lda     $32
        and     #$03
        beq     L2C26
        inx
L2C26:  lda     $32
        and     #$0C
        beq     L2C2D
L2C2C:  iny
L2C2D:  stx     $90
        sty     $91
L2C31:  lda     #$03
        .byte   $85
L2C34:  .byte   $64
L2C35:  lda     $64
        asl     a
        tax
        lda     $44,x
        cmp     #$FF
        beq     L2C67
        sta     $65
        lda     $45,x
        sta     $66
        txa
        pha
        jsr     L2328
        pla
        pha
        tax
        lda     $66
        sta     $45,x
        tay
        lda     $65
        sta     $44,x
        tax
        jsr     L1B0E
        pla
        tax
        lda     $13
        sta     $4C,x
        lda     $14
        sta     $4D,x
        jmp     L231F

L2C67:  lda     #$FF
        sta     $4C,x
        sta     $4D,x
        stx     $68
        ldx     $64
        dec     $5C,x
        bne     L2C81
        ldx     $68
        lda     L22A4,x
        sta     $44,x
        lda     L22A5,x
L2C7F:  sta     $45,x
L2C81:  dec     $64
        bpl     L2C35
        lda     #$01
        sta     $67
        rts

        lda     $65
        cmp     $90
        beq     L2CA5
        lda     $65
        sec
        sbc     $90
        bmi     L2C9E
        jsr     L2359
        lda     $60
        bne     L2CB6
L2C9E:  jsr     L2368
        lda     $60
        bne     L2CB6
L2CA5:  lda     $66
        sec
        sbc     $91
        bmi     L2CB3
        .byte   $20
        sei
L2CAE:  .byte   $23
        lda     $60
        bne     L2CB6
L2CB3:  jsr     L2387
L2CB6:  lda     #$00
        sta     $60
        rts

        ldx     $65
        dex
        ldy     $66
        jsr     L2397
L2CC3:  lda     $60
        beq     L2CC9
        dec     $65
L2CC9:  rts

        ldx     $65
        inx
        inx
        ldy     $66
        jsr     L2397
        lda     $60
        beq     L2CD9
        inc     $65
L2CD9:  rts

        ldx     $65
        ldy     $66
        dey
        jsr     L23B0
        lda     $60
        beq     L2CE8
        dec     $66
L2CE8:  rts

        ldx     $65
        ldy     $66
        iny
        iny
        jsr     L23B0
        lda     $60
        beq     L2CF8
        inc     $66
L2CF8:  rts

        stx     $61
        sty     $62
        jsr     L1B0E
        ldy     #$00
        lda     ($13),y
        cmp     #$C4
        bne     L2D2D
        ldy     #$28
        lda     ($13),y
        cmp     #$C4
        bne     L2D2D
        .byte   $F0
L2D11:  asl     $86,x
        adc     ($84,x)
        .byte   $62
        jsr     L1B0E
        ldy     #$00
        lda     ($13),y
        cmp     #$C4
        bne     L2D2D
        iny
        .byte   $B1
L2D23:  .byte   $13
        cmp     #$C4
        bne     L2D2D
L2D28:  lda     #$01
        sta     $60
        rts

L2D2D:  lda     #$00
        sta     $60
        rts

        lda     $67
        bne     L2D37
        rts

L2D37:  lda     #$03
        sta     $64
L2D3B:  lda     $64
        asl     a
        tax
        stx     $68
        lda     $54,x
        sta     $15
        lda     $55,x
        sta     $16
        cmp     #$FF
        beq     L2D80
        ldx     #$03
L2D4F:  lda     #$C4
        ldy     L1E5D,x
        sta     ($15),y
        dex
        bpl     L2D4F
        ldx     $68
        lda     $4C,x
        sta     $15
        sta     $2E
        lda     $4D,x
        sta     $16
        sec
        sbc     #$04
        sta     $2F
        ldx     #$03
        lda     #$D4
        sta     $34
L2D70:  ldy     L1E5D,x
        lda     $34
        sta     ($15),y
        lda     #$7C
        sta     ($2E),y
        dec     $34
        dex
        bpl     L2D70
L2D80:  dec     $64
        bpl     L2D3B
        rts

        lda     #$03
        sta     $64
        lda     #$00
        sta     $B8
        lda     $64
        asl     a
        tax
        stx     $68
        lda     $4C,x
        sta     $15
        lda     $54,x
        sta     $B6
L2D9B:  lda     $55,x
        sta     $B7
        lda     $4D,x
        sta     $16
        cmp     #$FF
        beq     L2E0D
        ldx     #$03
L2DA9:  ldy     L1E5D,x
        lda     ($15),y
        cmp     #$F8
        beq     L2DB7
        dex
        bpl     L2DA9
        .byte   $30
L2DB6:  .byte   $56
L2DB7:  ldx     #$03
L2DB9:  lda     #$C4
        ldy     L1E5D,x
        sta     ($15),y
L2DC0:  sta     ($B6),y
        dex
        bpl     L2DB9
        ldx     $68
        lda     #$FF
        sta     $4C,x
        sta     $54,x
        sta     $4D,x
        sta     $55,x
L2DD1:  sta     $44,x
        sta     $45,x
        inc     $B8
        ldx     $64
L2DD9:  lda     $FF02
        and     #$0F
        clc
        adc     #$0F
        sta     $5C,x
        lda     $B5
        beq     L2DF1
        lda     #$01
        ldy     #$04
        jsr     L34AF
        jmp     L249B

L2DF1:  lda     #$05
        jsr     L34AD
        lda     #$02
        ldy     #$04
        jsr     L34AF
        lda     $B8
        cmp     #$04
        bne     L2E0A
        lda     #$01
        ldy     #$03
        jsr     L34AF
L2E0A:  jsr     L3684
L2E0D:  dec     $64
        bmi     L2E14
        jmp     L242B

L2E14:  rts

        lda     #$00
        sta     $69
L2E19:  lda     $69
        asl     a
        tax
        inc     $69
        lda     L24D5,x
        tay
        lda     L24D6,x
        jsr     L1B88
        bcc     L2E2E
        lda     $69
        rts

L2E2E:  lda     $69
        cmp     #$1D
        bne     L2E19
        lda     #$00
        rts

L2E37:  .byte   $FD
        .byte   $04
L2E39:  .byte   $F7
        bpl     L2E37
        bpl     L2E39
        .byte   $04
        .byte   $FD
        rti

L2E41:  .byte   $FB
        jsr     L04F7
        .byte   $F7
        jsr     L02EF
        .byte   $EF
        .byte   $04
        .byte   $EF
        jsr     L04DF
        .byte   $EF
        bpl     L2E41
        .byte   $80
        .byte   $EF
        rti

        .byte   $DF
        .byte   $02
        .byte   $7F
        rti

        .byte   $FB
        .byte   $02
        sbc     $FB20,x
        rti

        .byte   $F7
        rti

        .byte   $F7
        .byte   $80
        sbc     $FB02,x
        .byte   $80
        .byte   $F7
        .byte   $02
        sbc     $7F10,x
L2E6C:  bpl     L2E6C
        .byte   $02
        inc     L2001,x
        ror     $25,x
        lda     $9D
        bne     L2E7B
        .byte   $20
        .byte   $9F
L2E7A:  .byte   $25
L2E7B:  jsr     L26DD
        dec     $6B
        beq     L2E83
        rts

L2E83:  lda     #$07
        sta     $6B
        ldx     $6A
        inx
        cpx     #$06
        bne     L2E90
        ldx     #$00
L2E90:  stx     $6A
        lda     L25CF,x
        asl     a
        asl     a
        asl     a
        tax
        ldy     #$00
L2E9B:  lda     L25D5,x
        sta     L3E58,y
        lda     L25F5,x
        sta     L3E60,y
        inx
        iny
        cpy     #$08
        bne     L2E9B
        inc     $93
        lda     $93
        cmp     #$03
        .byte   $D0
L2EB4:  .byte   $04
        lda     #$00
        sta     $93
L2EB9:  asl     a
        asl     a
        asl     a
        tax
        ldy     #$00
L2EBF:  lda     L2615,x
        sta     L3E38,y
        lda     L262D,x
        .byte   $99
        rti

L2ECA:  rol     $45BD,x
        rol     $99
        bmi     $2F0F
        inx
        iny
        cpy     #$08
        bne     L2EBF
        rts

        jsr     L1AB7
        ldx     $0F
        ldy     #$00
L2EDF:  lda     $8000,x
        sta     L3FC0,y
        inx
        iny
        cpy     #$08
        bne     L2EDF
        lda     $72
        beq     L2F00
        ldx     #$1F
L2EF1:  lda     L3960,x
        eor     $FF00
        and     L3FA0,x
        sta     L3960,x
        dex
        bpl     L2EF1
L2F00:  rts

        lda     $94
        bne     L2F09
        ldx     #$00
        beq     L2F17
L2F09:  dec     $96
        .byte   $F0
L2F0C:  ora     ($60,x)
L2F0E:  lda     #$2D
        sta     $96
        ldy     $95
        ldx     L20CA,y
L2F17:  ldy     #$00
L2F19:  lda     L265D,x
        sta     L38E0,y
        inx
        iny
        cpy     #$20
        bne     L2F19
        ldx     $95
        inx
        cpx     #$04
        bne     L2F2E
        ldx     #$02
L2F2E:  stx     $95
        rts

        brk
        ora     ($02,x)
        .byte   $03
        .byte   $02
        ora     (L0000,x)
        brk
        sta     (L00FF,x)
        .byte   $FF
        sta     (L0000,x)
        brk
        brk
        brk
        .byte   $C3
        ror     $C37E,x
        brk
        brk
        brk
        brk
        .byte   $E7
        .byte   $3C
        .byte   $3C
        .byte   $E7
        brk
        brk
        brk
        brk
        .byte   $FF
        clc
        clc
        .byte   $FF
        brk
        brk
        .byte   $3C
        clc
        clc
        clc
        clc
        clc
        clc
L2F5E:  .byte   $3C
        bit     $3C
        clc
        clc
        clc
        clc
        .byte   $3C
        bit     $24
        bit     $3C
        clc
        clc
        .byte   $3C
        bit     $24
        bit     $24
        bit     $3C
        .byte   $3C
        bit     $24
        bit     $6D
        adc     $FEFE
        .byte   $BF
        .byte   $BF
        adc     $B679,y
        .byte   $B6
L2F81:  .byte   $7F
        .byte   $7F
        sbc     $9EFD,x
        .byte   $9E
        .byte   $DB
        .byte   $DB
        lda     $7EBD,x
        ror     $E7E7,x
        eor     $7D,x
        adc     $7D7D,x
        adc     $557D,x
L2F97:  eor     $69,x
        eor     $7D,x
        adc     $6955,x
        eor     $55,x
        adc     #$69
        .byte   $55
L2FA3:  eor     $69,x
        adc     #$55
        eor     $69,x
        eor     $7D,x
        .byte   $7D
L2FAC:  adc     $557D,x
        eor     $69,x
        adc     #$69
        eor     $7D,x
        adc     $5555,x
        adc     #$69
        adc     #$69
        adc     #$55
        eor     L0000,x
        ora     $17
        .byte   $1F
L2FC3:  .byte   $5F
        .byte   $7F
        .byte   $7F
        .byte   $77
        brk
        .byte   $50
L2FC9:  sty     $A4,x
        sbc     $E9
        sbc     $77F9,y
        .byte   $77
        adc     $7D,x
        eor     $171F,x
        ora     $F9
        sbc     $E9F9,y
        sbc     $A4
        sty     $50,x
        ora     ($17,x)
        .byte   $1B
        ora     $1706,x
        .byte   $1F
        .byte   $5F
        rti

        .byte   $D4
        cpx     $74
        bcc     L2F81
        cpx     $E5
        .byte   $7F
        .byte   $77
        adc     $7D,x
        .byte   $5F
        .byte   $1F
        .byte   $17
        ora     $E9
        sbc     $F9F9,y
        sbc     $E4
        sty     $50,x
        ora     $17
        .byte   $1F
        .byte   $1F
        asl     $071F,x
        asl     $50,x
        bne     L307E
        sbc     $A5FD,x
        bne     L2FA3
        .byte   $1F
        .byte   $5F
        .byte   $7F
        .byte   $77
        .byte   $5F
        .byte   $1F
        .byte   $17
        ora     $E4
        sbc     $F9
        sbc     $E4E5,y
        sty     $50,x
        ora     $07
        ora     $7F7F,x
        .byte   $5A
        .byte   $07
        asl     $50,x
        .byte   $D4
        .byte   $F4
        .byte   $F4
        ldy     $F4,x
        bne     L2FC3
        .byte   $1F
        .byte   $5F
        .byte   $7F
        .byte   $77
        .byte   $5F
        .byte   $1F
        .byte   $17
        ora     $E4
        sbc     $F9
        sbc     $E4E5,y
        sty     $50,x
        dec     $9A
        beq     L3044
        rts

L3044:  lda     #$14
        sta     $9A
        inc     $99
        lda     $99
        and     #$01
        tay
        ldx     L20CA,y
        ldy     #$00
L3054:  lda     $024B,x
        sta     L3E88,y
        inx
        iny
        cpy     #$20
        bne     L3054
        rts

        ldx     #$06
L3063:  lda     #$CB
        sta     $0C20,x
        sta     $0FB8,x
        sta     $0DB0,x
        sta     $0EC8,x
        lda     #$71
        sta     $0820,x
        sta     $0BB8,x
        dex
        bne     L3063
        lda     #$16
L307E:  sta     $28
L3080:  ldx     #$20
        ldy     $28
        jsr     L1B0E
        ldy     #$00
        lda     #$CC
        sta     ($13),y
        lda     #$71
        sta     ($2E),y
        ldy     #$07
        lda     #$CC
        sta     ($13),y
        lda     #$71
        sta     ($2E),y
        dec     $28
        bne     L3080
        ldx     #$CD
        stx     $0C20
        inx
        stx     $0C27
        inx
        stx     $0FB8
        inx
        stx     $0FBF
        ldx     #$F9
        stx     $0DB0
        stx     $0EC8
        inx
        stx     $0DB7
        stx     $0ECF
        rts

        ldx     $1D
        lda     $0200,x
        asl     a
        asl     a
        asl     a
        tax
L30C9:  ldy     #$00
L30CB:  lda     L3EB8,x
        sta     L27B4,y
        inx
        iny
        cpy     #$08
        bne     L30CB
        lda     #$07
        sta     $41
L30DB:  lda     $41
        tay
        asl     a
        tax
        lda     L27B4,y
        pha
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        jsr     L27EC
        sta     L3F80,x
        sta     L3F81,x
        pla
        and     #$0F
        jsr     L27EC
        sta     L3F90,x
        sta     L3F91,x
        dec     $41
        bpl     L30DB
        ldx     #$0F
L3103:  ldy     L27BC,x
        lda     L27CC,x
        sta     $0D9E,y
        lda     L27DC,x
        sta     $099E,y
        dex
        bpl     L3103
        rts

        bmi     L3149
        .byte   $32
        .byte   $33
        .byte   $34
        and     $36,x
        .byte   $37
        brk
        ora     ($02,x)
        .byte   $03
        plp
        and     #$2A
        .byte   $2B
        bvc     L3179
        .byte   $52
        .byte   $53
        sei
        adc     $7B7A,y
        cmp     $CBCB
        dec     $F0CC
        .byte   $F2
        cpy     $F1CC
        .byte   $F3
        cpy     $CBCF
        .byte   $CB
        bne     L31B0
        adc     ($71),y
        adc     ($71),y
        .byte   $42
        .byte   $42
        adc     ($71),y
        .byte   $42
        .byte   $42
L3149:  adc     ($71),y
        adc     ($71),y
        adc     ($85),y
        .byte   $17
        ldy     #$03
L3152:  lsr     $17
        php
        ror     $18
        plp
        ror     $18
        dey
        bpl     L3152
        lda     $18
        rts

        lda     #$06
        sta     $27
        lda     #$0B
        sta     $28
        lda     $FF00
        and     #$07
        ora     #$70
        sta     $AE
        ldx     #$00
L3173:  txa
        pha
        lda     L2855,x
        .byte   $20
L3179:  .byte   $7A
        rol     $AA68
        inc     $27
        inx
        cpx     #$13
        bne     L3173
L3184:  lda     #$CB
        sta     $0D96,x
        sta     $0E0E,x
        dex
        bpl     L3184
        ldx     #$CC
        stx     $0DBD
        stx     $0DE5
        stx     $0DD2
        stx     $0DFA
        inx
        stx     $0D95
        inx
        stx     $0DAA
        inx
        stx     $0E0D
        inx
        stx     $0E22
        ldx     #$28
        .byte   $8E
L31B0:  cmp     ($0D),y
        inx
        stx     $0DF9
        rts

        eor     $554F,y
        jsr     L4148
        lsr     $45,x
        jsr     L4854
        eor     #$53
        jsr     L4950
        eor     L0043
L31C9:  eor     $A6
        ora     a:$BD,x
        .byte   $02
        clc
        adc     #$D7
        sta     $7D
        ldx     #$00
L31D6:  ldy     L2120,x
        lda     $0E02,y
        .byte   $C9
L31DD:  .byte   $1B
        bne     L31E8
        lda     $7D
        sta     $0E02,y
        jmp     L288B

L31E8:  inx
        cpx     #$19
        bne     L31D6
        lda     #$20
        sta     $0DC7
        sta     $0DEF
        sta     $0DC8
        sta     $0DF0
        jsr     L2BC6
        rts

        lda     $71
        bne     L324B
        lda     $73
        beq     L324B
        ldx     $21
        ldy     $24
        lda     $32
        and     #$03
        beq     L3212
        inx
L3212:  lda     $32
        and     #$0C
        beq     L3219
        iny
L3219:  stx     $81
        sty     $83
        jsr     L1B0E
        lda     $13
        sta     $6D
        sta     $6F
        lda     $14
        sta     $6E
        lda     $2F
        sta     $70
        lda     #$37
        sta     $6C
        ldx     #$01
        stx     $71
L3236:  dex
        stx     $72
        lda     L197C
        beq     L324B
        lda     #$2F
        sta     $FF11
        lda     #$00
        sta     $FF10
        sta     $FF0F
L324B:  rts

        jsr     L2976
        lda     $71
        beq     L3273
        jsr     L2958
        dec     $6C
        beq     L3274
        lda     #$38
        sec
        sbc     $6C
        asl     a
        rol     $9B
        asl     a
        rol     $9B
        asl     a
        rol     $9B
        asl     a
        rol     $9B
        sta     $FF0F
        lda     $9B
        sta     $FF10
L3273:  rts

L3274:  lda     #$01
        sta     $72
        rts

        lda     $72
        bne     L327E
        rts

L327E:  lda     $98
        beq     L327E
        lda     #$FF
        sta     $FF0F
        sta     $FF10
        lda     L197C
        beq     L3294
        lda     #$4F
        sta     $FF11
L3294:  ldx     #$01
        stx     $2D
        jsr     L1FD3
        jsr     L29DE
        sei
        ldx     #$1F
L32A1:  lda     #$00
        sta     L3960,x
        dex
        bpl     L32A1
        lda     #$00
        sta     $2D
        sta     $72
        sta     $71
        sta     $73
        sta     $74
        sta     $FF11
        cli
        rts

        ldx     #$03
        lda     #$F7
        sta     $34
        lda     $FF00
        ora     #$08
        sta     $86
L32C7:  ldy     L1E5D,x
        lda     $34
        sta     ($6D),y
        lda     $86
        sta     ($6F),y
        dec     $34
        dex
        bpl     L32C7
        rts

        lda     $73
        beq     L32DD
L32DC:  rts

L32DD:  dec     $74
        bne     L32E9
        lda     #$01
        sta     $73
        jsr     L1B67
        rts

L32E9:  lda     $74
        and     #$0F
        bne     L32DC
        lda     L3970
        pha
        lda     L3978
        pha
        ldx     #$00
L32F9:  lda     L3961,x
        sta     L3960,x
        lda     L3969,x
        sta     L3968,x
        lda     L3971,x
        sta     L3970,x
        lda     L3979,x
        sta     L3978,x
        inx
        cpx     #$07
        bne     L32F9
        pla
        sta     L396F
        pla
        sta     L3967
        .byte   $A5
L331F:  .byte   $74
        lsr     a
        lsr     a
        lsr     a
L3323:  lsr     a
        eor     #$0F
        tay
        and     #$08
        beq     L3332
        tya
        and     #$07
        clc
        adc     #$10
        tay
L3332:  tya
L3333:  lda     L3FA0,y
        sta     L3977
        lda     L3FA8,y
        sta     L397F
        rts

        ldx     $81
        .byte   $86
L3343:  adc     $86,x
        adc     $86E8,y
        .byte   $77
        stx     $7B
        ldy     $83
        sty     $76
        sty     $78
        iny
        sty     $7A
        sty     $7C
        lda     $0F
        and     #$03
        clc
        adc     #$04
        sta     $84
        lda     #$00
        sta     $7D
        sta     $7E
        sta     $7F
        sta     $80
        lda     $7D
        bne     L338D
        lda     #$FF
        sta     $82
        ldx     $75
L3373:  ldy     $76
        jsr     L2AC5
        bcs     L3383
        dex
        inc     $82
        lda     $82
        cmp     $84
        bne     L3373
L3383:  lda     $82
        cmp     #$FF
        bne     L338D
        lda     #$01
        sta     $7D
L338D:  lda     $7E
        bne     L33B1
        lda     #$FF
        sta     $82
        ldx     $77
L3397:  ldy     $78
        .byte   $20
        .byte   $C5
L339B:  rol     a
        bcs     L33A7
        inx
        inc     $82
        lda     $82
        cmp     $84
        bne     L3397
L33A7:  lda     $82
        cmp     #$FF
        bne     L33B1
        lda     #$01
        sta     $7E
L33B1:  lda     $7F
        bne     L33D5
        lda     #$FF
        sta     $82
        ldx     $79
L33BB:  ldy     $7A
        jsr     L2AC5
        bcs     L33CB
        dex
        inc     $82
        lda     $82
        cmp     $84
        bne     L33BB
L33CB:  lda     $82
        cmp     #$FF
        bne     L33D5
        lda     #$01
        sta     $7F
L33D5:  lda     $80
        bne     L33F9
        lda     #$FF
        sta     $82
        ldx     $7B
L33DF:  ldy     $7C
        jsr     L2AC5
L33E4:  bcs     L33EF
        inx
        inc     $82
        lda     $82
        cmp     $84
        bne     L33DF
L33EF:  lda     $82
        cmp     #$FF
        bne     L33F9
        lda     #$01
        sta     $80
L33F9:  dec     $76
        dec     $78
        inc     $7A
        inc     $7C
        ldx     #$10
        jsr     L1ADB
        dec     $84
        bmi     L340D
        jmp     L2A07

L340D:  ldx     #$00
        jsr     L1ADB
        .byte   $20
        .byte   $BE
L3414:  .byte   $1F
        jsr     L2423
        jsr     L2AFA
        lda     $B9
        beq     L3422
        jsr     L36C2
L3422:  lda     #$00
        sta     $B9
        rts

        txa
        pha
        cpx     #$00
        bcc     L344C
        cpx     #$1F
        bcs     L344C
        cpy     #$00
        bcc     L344C
        cpy     #$17
        bcs     L344C
        lda     #$71
        sta     $85
        jsr     L1B0E
        ldy     #$00
        lda     ($13),y
L3444:  cmp     #$C5
        bcc     L3450
        cmp     #$D1
        bcs     L3450
L344C:  pla
        tax
        sec
        rts

L3450:  lda     #$F8
        sta     ($13),y
        lda     $85
        sta     ($2E),y
        pla
        tax
        clc
        rts

        lda     #$29
        sta     $13
        lda     #$0C
        sta     $14
        ldx     #$15
L3466:  ldy     #$1E
L3468:  lda     ($13),y
        cmp     #$F8
        bne     L3472
        lda     #$C4
        sta     ($13),y
L3472:  dey
        bpl     L3468
        lda     $13
        clc
        adc     #$28
        sta     $13
        lda     $14
        adc     #$00
        sta     $14
        dex
        bpl     L3466
        rts

        lda     #$00
        sta     $88
        sta     $89
        sta     $92
L348E:  jsr     L2C2C
        bcs     L348E
L3493:  ldx     #$30
        jsr     L1ADB
        jsr     L2C2C
        bcc     L34A6
L349D:  jsr     L2C2C
        bcs     L349D
        jsr     L2BC6
        rts

L34A6:  jsr     L2B7C
        bit     $0B
        bpl     L3493
L34AD:  lda     $92
L34AF:  bne     L34C8
        lda     $13
        sta     $8A
        lda     $14
        sta     $8B
        ldy     #$00
        lda     ($13),y
        sta     $8C
        sta     $0E51
        lda     #$01
        sta     $92
        bne     L3493
L34C8:  ldy     #$00
        lda     ($13),y
        sta     ($8A),y
        lda     $8C
        sta     ($13),y
        lda     #$00
        sta     $92
        lda     #$25
        sta     $0E51
        jmp     L2B31

        ldx     $88
        ldy     $89
        bit     $07
        bpl     L34EB
L34E6:  cpx     #$00
        beq     L34EB
        dex
L34EB:  bit     $08
        bpl     L34F4
        cpx     #$04
        beq     L34F4
        inx
L34F4:  bit     $09
        bpl     L34FD
        cpy     #$00
        beq     L34FD
        dey
L34FD:  bit     $0A
        bpl     L3506
        cpy     #$04
        beq     L3506
        iny
L3506:  stx     $88
        sty     $89
        jsr     L2BB8
        jsr     L2BC6
        lda     $FF00
        and     #$F7
        ldy     #$00
        sta     ($2E),y
        rts

        txa
L351B:  clc
        adc     #$22
        tax
        tya
        clc
        adc     #$0C
        tay
        jsr     L1B0E
        rts

        ldx     #$00
        stx     $8D
        lda     #$D7
        sta     $8E
L3530:  ldy     L2120,x
        lda     $0E02,y
        cmp     #$1B
        bne     L353E
        lda     #$64
        bne     L354A
L353E:  cmp     $8E
        bne     L3548
        inc     $8D
        lda     #$71
        bne     L354A
L3548:  lda     #$10
L354A:  sta     $0A02,y
        inc     $8E
        inx
        cpx     #$19
        bne     L3530
        lda     $8D
        .byte   $C9
L3557:  ora     $03D0,y
        jmp     L372C

L355D:  rts

        ldx     #$18
        lda     #$EF
        sta     $34
L3564:  ldy     L2120,x
        lda     $34
        sta     $0E02,y
        dec     $34
        dex
        bpl     L3564
        rts

        jsr     L2C2C
        bcc     L358D
        lda     #$01
        sta     $2D
        lda     $FF11
        pha
        lda     #$00
        sta     $FF11
        jsr     L2B24
        dec     $2D
        pla
        sta     $FF11
L358D:  rts

        lda     #$10
        ldy     #$BF
        jsr     L1B88
        rts

        jsr     L2BFC
        lda     #$01
        sta     $8F
        lda     #$00
        sta     $1D
L35A1:  jsr     L20D8
        jsr     L1C12
        jsr     L2192
        .byte   $20
L35AB:  lsr     $A227,x
        rti

        jsr     L1ADB
        jsr     L2C7F
        jsr     L2BC6
        bit     $0B
        bmi     L35CA
        ldx     #$10
        jsr     L1ADB
        inc     $1D
        lda     $1D
        cmp     #$19
        bne     L35A1
        rts

L35CA:  jsr     L20D8
        jsr     L2C7F
        ldx     #$20
        jsr     L1ADB
        jsr     L2BC6
        inc     $1D
        lda     $1D
        cmp     #$19
        bne     L35CA
        rts

        ldx     $1D
        lda     $0200,x
        clc
        adc     #$D7
        sta     $42
        ldx     #$18
L35ED:  ldy     L2120,x
        lda     $0E02,y
        cmp     $42
        bne     L35FC
        lda     #$1B
        sta     $0E02,y
L35FC:  dex
        bpl     L35ED
        rts

        bmi     L3632
        bmi     L3635
        bmi     L3636
        jsr     L4720
        .byte   $52
        eor     $4D
        jmp     L4E49

        jsr     L00A0
L3612:  ldx     #$00
L3614:  lda     L2C9E,x
        sta     $02A4,y
        iny
        inx
        cpx     #$10
        bne     L3614
        cpy     #$50
        bne     L3612
        rts

        sei
        jsr     L1AF1
        jsr     L1B67
        ldx     #$01
        stx     $2D
        stx     L00A0
L3632:  dex
        stx     $21
L3635:  .byte   $86
L3636:  bit     $86
        ora     $E020,x
        .byte   $1B
        jsr     L1A20
        jsr     L20D8
        jsr     L26FF
        jsr     L2ECA
        jsr     L34E6
        jsr     L2EB4
        jsr     L2D11
        jsr     L2D23
        lda     #$22
        sta     $FF17
L3659:  jsr     L339B
        ldx     #$30
        jsr     L1ADB
        bit     $0B
        bpl     L3659
        lda     #$00
        sta     L00A0
        sta     L197E
        lda     #$03
        .byte   $85
L366F:  ora     $4C
        .byte   $7F
        ora     $EBA2,y
        ldy     #$2D
        jsr     L2D9B
        ldx     #$0D
        lda     #$2A
L367E:  sta     $0CA9,x
        dex
        bpl     L367E
L3684:  rts

        lda     #$00
        sta     $87
L3689:  lda     #$00
        sta     $B0
        lda     $87
        asl     a
        clc
        adc     #$05
L3693:  sta     $28
        lda     #$06
        sta     $27
        lda     $87
        clc
        adc     #$31
        pha
        and     #$07
        ora     #$70
        sta     $AE
        pla
L36A6:  jsr     L2E7A
        inc     $27
        inc     $27
        lda     $87
        asl     a
        asl     a
        asl     a
        asl     a
        tax
        lda     #$05
        sta     $41
L36B8:  txa
        pha
        lda     $02A4,x
        sta     $B1
        cmp     #$30
        .byte   $D0
L36C2:  php
        lda     $B0
        bne     L36CF
        lda     #$20
        bne     L36D1
        lda     #$01
        sta     $B0
L36CF:  lda     $B1
L36D1:  jsr     L2E7A
        pla
        tax
        inx
        inc     $27
        dec     $41
        bpl     L36B8
        inc     $27
        lda     #$09
        sta     $41
L36E3:  txa
        pha
        lda     $02A4,x
        jsr     L2E7A
        pla
        tax
        inx
        inc     $27
        dec     $41
        bpl     L36E3
        inc     $87
        lda     $87
        cmp     #$05
        bne     L3689
        rts

        stx     L2DB6
        stx     L2DC0
        stx     L2DD9
        stx     L2DD1
        .byte   $8C
L370A:  .byte   $B7
        and     $C18C
        and     $DA8C
        and     $D28C
        and     a:$A2
L3717:  lda     $FFFF,x
        cmp     #$FF
        .byte   $F0
L371D:  rol     $2785
        inx
        .byte   $BD
L3722:  .byte   $FF
        .byte   $FF
        sta     $28
        inx
L3727:  txa
        pha
        ldx     $27
        .byte   $A4
L372C:  plp
        jsr     L1B0E
        pla
        tax
        lda     $FFFF,x
        sta     $AE
        inx
        ldy     #$00
L373A:  lda     $FFFF,x
        beq     L3749
        sta     ($13),y
        lda     $AE
        sta     ($2E),y
        iny
        inx
        bne     L373A
L3749:  inx
        bne     L3717
L374C:  rts

        .byte   $03
        ora     ($66),y
        .byte   $03
        .byte   $0F
        asl     $1214
        .byte   $0F
        .byte   $0C
        brk
        ora     $12
        ror     $3C,x
        rol     $3E
        brk
        ora     $14
        adc     $8988,y
        txa
        brk
        ora     $15
        adc     $8C8B,y
        sta     $0E00
        ora     ($77),y
        lsr     a
        bvc     L37D5
        pha
        brk
        asl     $5412
        .byte   $4B
        eor     ($63),y
        eor     #$00
        .byte   $0F
        .byte   $13
        .byte   $77
        ror     $5C
        brk
        .byte   $0F
        .byte   $14
        .byte   $54
        .byte   $67
        eor     $0E00,x
        ora     $77,x
        lsr     L4056,x
        bvs     L3791
L3791:  asl     $5416
        .byte   $5F
        .byte   $57
        eor     ($71,x)
        brk
        clc
        ora     ($66),y
        .byte   $13
        .byte   $0F
        ora     $0E,x
        .byte   $04
        brk
        ora     $6612,y
        .byte   $3C
        .byte   $27
        rol     $1900,x
        .byte   $14
        adc     ($8E),y
        .byte   $8F
        bcc     L37B0
L37B0:  ora     $7115,y
        sta     ($92),y
        .byte   $93
        brk
        ora     #$02
        .byte   $64
        lsr     $5C
        .byte   $62
        .byte   $54
        .byte   $64
        jsr     L4620
        bvc     L381A
        pha
        cli
        cli
        rti

        brk
        ora     #$03
        .byte   $44
        .byte   $47
        eor     $5563,x
        adc     L0020
        jsr     L5147
L37D5:  .byte   $57
        eor     #$59
        eor     $41,y
        .byte   $FF
        and     #$3F
        cmp     #$20
        bne     L37E3
        rts

L37E3:  cmp     #$30
        bcc     L37EF
        and     #$0F
        asl     a
        clc
        adc     #$74
        bne     L37F3
L37EF:  asl     a
        clc
        adc     #$3E
L37F3:  pha
        ldx     $27
        ldy     $28
        jsr     L1B0E
        pla
        ldy     #$00
        sta     ($13),y
        pha
        lda     $AE
        sta     ($2E),y
        pla
        clc
        adc     #$01
        ldy     #$28
        sta     ($13),y
        lda     $AE
        and     #$0F
        ora     #$60
        sta     ($2E),y
        rts

        ldx     #$2C
        ldy     #$2F
L381A:  .byte   $20
        .byte   $9B
L381C:  and     $79A9
        sta     $0965
        sta     $0966
        sta     $098D
        sta     $098E
        rts

        ldx     #$1F
L382E:  lda     #$25
        sta     L0C00,x
        sta     $0F98,x
        dex
        .byte   $10
L3838:  sbc     $A9,x
        .byte   $17
        sta     $28
L383D:  ldx     #$00
        ldy     $28
        jsr     L1B0E
        ldy     #$00
        lda     #$25
        sta     ($13),y
        lda     #$11
        sta     ($2E),y
        lda     #$25
        ldy     #$1F
        sta     ($13),y
        lda     #$11
        sta     ($2E),y
        dec     $28
        bne     L383D
        ldx     #$1F
        ldy     #$00
L3860:  lda     L2F0C,y
        sta     L0800,y
        sta     $0B98,x
        iny
        dex
        bpl     L3860
        rts

        .byte   $07
        .byte   $17
        .byte   $27
        .byte   $37
        .byte   $47
        .byte   $57
        .byte   $67
        .byte   $77
        asl     $16
        rol     $36
        lsr     $56
        ror     $76
        ora     $15
        and     $35
        eor     $55
        adc     $75
        .byte   $02
        .byte   $12
        .byte   $22
        .byte   $32
        .byte   $42
        .byte   $52
        .byte   $62
        .byte   $72
        and     ($01,x)
        adc     $64
        .byte   $44
        .byte   $5C
        .byte   $62
        pha
        cmp     L0000,x
        and     ($02,x)
        eor     $65
        eor     $5D
        .byte   $63
        eor     #$D6
        brk
        and     ($03,x)
        adc     L0020
        jsr     L2020
        jsr     L0030
        and     ($04,x)
        .byte   $53
        .byte   $0C
        ora     #$16
        ora     $13
        .byte   $3A
        brk
        .byte   $23
        ora     $63
        .byte   $33
        brk
        and     ($06,x)
        .byte   $54
        ora     ($0C,x)
        ora     #$05
        asl     a:$13
        .byte   $23
        .byte   $07
        .byte   $64
        jsr     L0020
        and     ($08,x)
        adc     ($42,x)
        .byte   $5C
        cli
        .byte   $42
        bit     a:$2D
        and     ($09,x)
        eor     (L0043,x)
        eor     L4359,x
        rol     a:$2F
        .byte   $21
L38E0:  .byte   $0B
        .byte   $64
        asl     a
        ora     #$07
        .byte   $13
        ora     ($17,x)
L38E8:  brk
        and     ($13,x)
        .byte   $77
        ora     L2100
        .byte   $14
L38F0:  .byte   $77
        ora     (L0000,x)
        and     ($15,x)
        .byte   $77
        bpl     L38F8
L38F8:  .byte   $FF
        lda     $9F
        beq     L3902
        .byte   $A5
L38FE:  .byte   $9E
        jmp     L2FAC

L3902:  lda     $FF00
        and     #$03
        tax
L3908:  .byte   $B5
L3909:  asl     $0729
        sta     $9E
        tay
        .byte   $BE
L3910:  dex
        jsr     L00A0
L3914:  lda     L2FC9,x
L3917:  .byte   $99
L3918:  .byte   $4B
L3919:  .byte   $02
        .byte   $BD
L391B:  cmp     #$30
        sta     $026B,y
L3920:  inx
        iny
        cpy     #$20
        bne     L3914
        .byte   $A9
L3927:  ora     ($85,x)
        sta     $60,y
        ora     $6A,x
        ror     $767E,x
        ror     a
        .byte   $6B
        brk
        .byte   $54
        lda     #$BD
L3937:  .byte   $BD
        .byte   $9D
L3939:  lda     #$E9
        .byte   $6B
        .byte   $6F
        ror     a
        .byte   $6F
        adc     $6A6F
        ora     $E9,x
        sbc     $F9A9,y
        adc     $A9F9,y
        .byte   $54
        ora     $07
        asl     $1E,x
        ora     $761A,y
        ror     $D050
        sty     $B4,x
        .byte   $64
        ldy     $9D
        lda     $566A,y
        asl     $1E
        .byte   $1A
L3960:  .byte   $79
L3961:  adc     #$54
        lda     #$95
        bcc     L391B
L3967:  .byte   $A4
L3968:  .byte   $6D
L3969:  adc     #$15
        ora     $16
L396D:  .byte   $1A
        .byte   $5A
L396F:  ror     a
L3970:  .byte   $6E
L3971:  ror     $5066
        sty     $A4,x
        .byte   $A5
L3977:  .byte   $A9
L3978:  .byte   $B9
L3979:  lda     $6A99,y
        adc     #$5A
        .byte   $1A
L397F:  asl     $05,x
        brk
        brk
        lda     #$69
        lda     $A4
        sty     $50,x
        brk
        brk
        ora     $6F,x
        .byte   $7F
        eor     $7B,x
        eor     $7F,x
        .byte   $5F
        .byte   $54
        sbc     $F9
        eor     $B9,x
        eor     $F9,x
        lda     $1F
        ora     $07,x
        .byte   $07
        .byte   $07
        .byte   $07
        .byte   $07
        ora     $E4
        .byte   $54
        bcc     L3937
        bcc     L3939
        bcc     L39FB
L39AB:  ora     $7F,x
        .byte   $6B
        .byte   $7F
        .byte   $7B
        ror     $051F,x
        .byte   $54
        sbc     $FDE9,x
        sbc     $F4BD
        bvc     L39C2
        ora     ($06,x)
        ora     ($06,x)
        .byte   $1A
        .byte   $19
L39C2:  .byte   $14
        bcc     L3A05
        bcc     L3A07
        bcc     L396D
        .byte   $64
        .byte   $14
        bpl     L3A11
        ora     ($16,x)
        ror     a
        eor     $7F,x
        .byte   $7F
        .byte   $04
        ora     ($40),y
        sty     $A9,x
        eor     $AD,x
        lda     $6A55
        asl     $01,x
        asl     $06
        asl     $01
        eor     $89,x
        sty     $40,x
        bcc     L3979
        bne     L3A2B
        brk
        ora     $7E,x
        ror     $7F7F,x
        .byte   $7F
        ora     L0000,x
        brk
        rti

        .byte   $D4
        .byte   $F4
        .byte   $D4
        rti

        brk
L39FB:  .byte   $1B
        ora     $1B,x
L39FE:  ora     $1B,x
        ora     $7F,x
        ora     L0000,x
        brk
L3A05:  brk
        brk
L3A07:  brk
        bvc     L39FE
        .byte   $50
L3A0B:  brk
L3A0C:  brk
        ora     $16
        .byte   $1A
        .byte   $5B
L3A11:  .byte   $6B
        .byte   $6F
        brk
        brk
        bvc     L39AB
        ldy     $E5
        sbc     #$F9
        .byte   $6F
        .byte   $6F
        .byte   $6F
        .byte   $6B
        .byte   $5B
        .byte   $1A
        asl     $05,x
        sbc     $F9F9,y
        sbc     #$E5
        ldy     $94
        .byte   $50
L3A2B:  brk
        ora     $6A,x
        ror     $6B76,x
        .byte   $6B
        .byte   $6F
        brk
        .byte   $54
        lda     #$BD
        sta     $E9E9,x
L3A3A:  sbc     $6F6A,y
        adc     $6D6D
        .byte   $6F
        ror     a
        ora     $A9,x
        sbc     $7979,y
        adc     $A9F9,y
        .byte   $54
        ora     $07
        asl     $1E,x
        ora     $161A,y
        ror     $D050,x
        .byte   $94
L3A56:  ldy     $64,x
        ldy     $94
        lda     $666A,x
        lsr     $1E,x
        .byte   $1A
        ora     $1419,y
        lda     #$99
        sta     $B4,x
        ldy     $64
        .byte   $64
        .byte   $14
        brk
        brk
L3A6D:  ora     $16
        .byte   $1A
        .byte   $5A
        ror     $6E
        brk
        brk
        bvc     L3A0B
        ldy     $A5
        sta     $6EB9,y
        ror     a
        adc     #$67
        eor     $161A,y
        ora     $B9
        lda     #$69
        cmp     $A465,y
        sty     $50,x
        brk
        brk
        brk
        ora     $5F,x
        .byte   $7F
        eor     $7B,x
        brk
        brk
        brk
        .byte   $54
        sbc     $F9
        eor     $B9,x
        eor     $7F,x
        .byte   $5F
        .byte   $1F
        ora     $07,x
        .byte   $07
        ora     $55
        sbc     $E4A5,y
        .byte   $54
        bcc     L3A3A
        bvc     L3AAC
L3AAC:  brk
        ora     $7F,x
        .byte   $6B
        .byte   $67
        .byte   $7F
        ror     a:L0000,x
        .byte   $54
        sbc     $D9E9,x
L3AB9:  sbc     L1FBD,x
        ora     $06
        ora     ($06,x)
        .byte   $1A
        ora     $F414,y
        bvc     L3A56
        rti

        bcc     L3A6D
        .byte   $44
        .byte   $14
        bpl     L3AD1
        ora     ($16,x)
        ror     a
        .byte   $55
L3AD1:  .byte   $7A
        .byte   $7A
        .byte   $04
        bpl     L3B16
        sty     $A9,x
        eor     $FD,x
        sbc     $6A55,x
        asl     $01,x
        .byte   $07
        .byte   $07
        .byte   $07
        ora     ($55,x)
        .byte   $89
        sty     $40,x
        bne     L3AB9
        bcc     L3B2B
        brk
        brk
        brk
        brk
        brk
        ora     $7E,x
        ror     a:L0000,x
        brk
        brk
        brk
        brk
        rti

        .byte   $D4
        .byte   $7F
        .byte   $7F
        .byte   $7F
L3AFE:  ora     $1B,x
        ora     $7F,x
        ora     $F4,x
        .byte   $D4
        rti

        brk
        brk
        bvc     L3AFE
        bvc     L3B0C
L3B0C:  brk
        .byte   $0F
        and     $F635,x
        dec     $DA,x
        brk
        brk
        .byte   $F0
L3B16:  .byte   $7C
        .byte   $5C
        .byte   $9F
        .byte   $97
        .byte   $A7
        .byte   $DA
        .byte   $DA
        .byte   $DA
        dec     $F6,x
        and     $3D,x
        .byte   $0F
        .byte   $A7
        .byte   $A7
        .byte   $A7
        .byte   $97
        .byte   $9F
        .byte   $5C
        .byte   $7C
        .byte   $F0
L3B2B:  ldx     #$03
L3B2D:  lda     $39,x
        cmp     #$D1
        bcc     L3B3B
        cmp     #$D5
        bcs     L3B3B
        lda     #$01
        sta     $9C
L3B3B:  dex
        bpl     L3B2D
        rts

        lda     $9C
        bne     L3B44
        rts

L3B44:  ldx     #$01
        stx     $2D
        stx     $9D
        dex
        stx     $9C
        jsr     L23D5
        ldx     #$07
L3B52:  lda     L38E0,x
        sta     L3908,x
        lda     L38F0,x
        sta     L3910,x
        lda     L38E8,x
        sta     L3918,x
        lda     L38F8,x
        sta     L3920,x
        dex
        bpl     L3B52
        lda     $A4
        beq     L3B83
        lda     $A2
        sta     $13
        sta     $2E
        lda     $A3
        sta     $14
        sec
        sbc     #$04
        sta     $2F
        jmp     L3236

L3B83:  ldx     $21
        ldy     $24
        lda     $32
        and     #$03
        beq     L3B8E
        inx
L3B8E:  lda     $32
        and     #$04
        beq     L3B95
        iny
L3B95:  jsr     L1B0E
        lda     L197C
        beq     L3BA2
        lda     #$2F
        sta     $FF11
L3BA2:  lda     #$02
        sta     $FF10
        lda     $13
        pha
        sec
        sbc     #$28
        sta     $13
        lda     $14
        pha
        sbc     #$00
        sta     $14
        jsr     L1F87
        pla
        sta     $14
        pla
        sta     $13
        ldx     #$03
        lda     #$24
        sta     $34
L3BC5:  ldy     L331F,x
        lda     $34
        sta     ($13),y
        lda     #$7F
        sta     ($2E),y
        dec     $34
        dex
        bpl     L3BC5
        ldy     #$0F
L3BD7:  ldx     #$0E
L3BD9:  lda     L3908,x
        sta     L3909,x
        lda     L3918,x
        sta     L3919,x
        dex
        bpl     L3BD9
        tya
        pha
        ldx     #$20
        jsr     L1ADB
        pla
        tay
        asl     a
        asl     a
        asl     a
        asl     a
        sta     $FF0F
        lda     #$00
        sta     L3908
        sta     L3918
        dey
        bpl     L3BD7
        ldx     #$00
L3C05:  lda     L3323,x
        sta     L3917
        lda     L3333,x
        sta     L3927
        ldy     #$00
L3C13:  lda     L3909,y
        .byte   $99
        php
L3C18:  and     $19B9,y
        and     $1899,y
        and     $C0C8,y
        .byte   $0F
        bne     L3C13
        txa
        pha
        ldx     #$30
        jsr     L1ADB
        pla
        tax
        lda     $10
        sta     $FF0F
        inx
        cpx     #$0F
        bne     L3C05
        lda     #$00
        sta     $FF11
        tax
        tay
L3C3E:  .byte   $EE
        .byte   $15
L3C40:  .byte   $FF
        dey
        bne     L3C3E
        dex
        bne     L3C3E
        lda     #$11
        sta     $FF15
        ldx     #$00
        jsr     L1ADB
        jsr     L1ADB
        jsr     L1ADB
        lda     #$00
        sta     $9D
        sta     $A4
        dec     $0CEB
        dec     $05
        bne     L3C67
        jmp     L3343

L3C67:  lda     $23
        sta     $21
        lda     $26
L3C6D:  sta     $24
L3C6F:  .byte   $A5
L3C70:  .byte   $A1
L3C71:  sta     $32
        lda     #$01
        sta     $9F
        jsr     L2064
        lda     #$00
        sta     $9F
        jmp     L19AD

        brk
        plp
        ora     ($29,x)
        ora     $07
        .byte   $57
        .byte   $7F
        .byte   $7F
        .byte   $6B
        .byte   $57
        .byte   $07
        .byte   $07
        .byte   $07
        .byte   $07
        .byte   $07
        ora     $5A,x
        ror     a
        eor     $50,x
        bne     L3C6D
        sbc     $E9FD,x
        cmp     $D0,x
        bne     L3C6F
        bne     L3C71
        .byte   $54
        sbc     $BD,x
        eor     L0020,x
        sbc     ($1A),y
        ldx     #$7E
        ldy     #$33
        jsr     L2D9B
        lda     #$50
        sta     L0020
        ldy     #$00
L3CB5:  ldx     #$0A
        lda     $0E
        and     #$F7
        ora     #$30
L3CBD:  sta     $09C2,x
        sta     $09EA,x
        dex
        bpl     L3CBD
        dey
        bne     L3CB5
        dec     L0020
        bne     L3CB5
        ldx     #$05
L3CCF:  lda     $0C99,x
        cmp     #$20
        bne     L3CD8
        lda     #$30
L3CD8:  sta     $BD,x
        dex
        bpl     L3CCF
        jmp     L2CC3

        .byte   $0B
        .byte   $0B
        adc     ($4C),y
        rti

        cli
        pha
        jsr     L5C20
        ror     a
        pha
        .byte   $62
        brk
        .byte   $0B
        .byte   $0C
        adc     ($4D),y
        eor     ($59,x)
        eor     #$20
        jsr     L6B5D
        eor     #$63
        brk
        .byte   $FF
        lda     #$10
        ldy     #$FE
        jsr     L1B88
        bcc     L3D21
        lda     L197D
        eor     #$01
        sta     L197D
        ldx     #$2F
L3D10:  lda     L3C40,x
        pha
        .byte   $BD
L3D15:  cpx     $33
        sta     L3C40,x
        pla
        sta     L33E4,x
        dex
        bpl     L3D10
L3D21:  lda     #$20
        ldy     #$FE
        jsr     L1B88
        bcc     L3D45
        lda     L197C
        eor     #$01
        sta     L197C
        ldx     #$2F
L3D34:  lda     L3C70,x
        pha
        lda     L3414,x
        sta     L3C70,x
        pla
        sta     L3414,x
        dex
        bpl     L3D34
L3D45:  rts

        ora     $16
        .byte   $1A
        .byte   $1A
        asl     $05,x
        .byte   $07
        .byte   $07
        rti

        bvc     L3D21
        bcc     L3DA3
        rti

        rti

        eor     (L0000,x)
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        .byte   $07
        ora     $1F
        .byte   $7F
        .byte   $7F
        eor     $7F,x
        ora     $46,x
        eor     L00FF,x
        .byte   $FF
        .byte   $FF
        eor     $FE,x
        eor     $40,x
        bvc     L3D15
        sbc     #$F9
        eor     $A9,x
        .byte   $54
        clc
        .byte   $0C
        asl     $03
        ora     (L0000,x)
        brk
        brk
        brk
        brk
        brk
        ora     ($83,x)
        dec     $6C
        sec
        bmi     L3DE8
        cpy     #$80
        brk
        brk
        brk
        brk
        brk
        brk
        ora     ($03,x)
        asl     $0C
        clc
        bpl     L3E03
        dec     $83
        ora     (L0000,x)
        brk
        brk
        brk
        brk
        brk
        brk
        .byte   $80
        .byte   $C0
L3DA3:  rts

        bmi     L3DB6
        lda     $081F
        sta     $7D
        lda     $0BB7
        sta     $7E
        lda     $0B98
        sta     $7F
        .byte   $A2
L3DB6:  .byte   $1E
L3DB7:  lda     L0800,x
        sta     $0801,x
        dex
        bpl     L3DB7
        lda     #$16
        sta     $AB
L3DC4:  ldx     #$1F
        ldy     $AB
        jsr     L1B0E
        ldy     #$00
        lda     ($2E),y
        ldy     #$28
        sta     ($2E),y
        dec     $AB
        bne     L3DC4
        lda     $7D
        sta     $0847
        ldx     #$00
        lda     $0B99,x
        sta     $0B98,x
        inx
        cpx     #$1E
        .byte   $D0
L3DE8:  sbc     $A5,x
        ror     $B68D,x
        .byte   $0B
        lda     #$00
        sta     $AB
L3DF2:  ldx     #$00
        ldy     $AB
        jsr     L1B0E
        ldy     #$28
        lda     ($2E),y
        ldy     #$00
        sta     ($2E),y
        inc     $AB
L3E03:  lda     $AB
        cmp     #$17
        bne     L3DF2
L3E09:  lda     $7F
        sta     $0B70
        rts

        ldy     #$05
L3E11:  sta     $A6
        lda     $0C99,y
        cmp     #$20
        bne     L3E1C
        lda     #$30
L3E1C:  clc
        adc     $A6
        cmp     #$3A
        bmi     L3E2E
        sec
        sbc     #$0A
        sta     $0C99,y
        lda     #$01
        dey
        bpl     L3E11
L3E2E:  .byte   $99
        .byte   $99
L3E30:  .byte   $0C
        lda     $0C9B
        and     #$0F
        cmp     $06
L3E38:  beq     L3E47
        sta     $06
        lda     $05
        cmp     #$09
L3E40:  beq     L3E47
        inc     $05
        inc     $0CEB
L3E47:  rts

        lda     #$00
        sta     $A7
        sta     $A8
L3E4E:  lda     $A7
L3E50:  clc
        adc     #$06
        tax
        sec
        ldy     #$06
        .byte   $BD
L3E58:  .byte   $A3
        .byte   $02
        sbc     $BC,y
        dex
        dey
        .byte   $D0
L3E60:  inc     $90,x
        bpl     L3E09
        .byte   $A7
        clc
        adc     #$10
        sta     $A7
        inc     $A8
        lda     $A8
        cmp     #$05
        bne     L3E4E
        rts

        jsr     L35AB
        jsr     L351B
        jsr     L1AF1
        rts

        lda     $A8
        pha
        asl     a
        asl     a
        asl     a
        asl     a
        sta     $A9
        pla
        .byte   $C9
L3E88:  .byte   $04
        beq     L3E98
        ldx     #$40
L3E8D:  lda     $02A4,x
        sta     $02B4,x
        dex
        cpx     $A9
        bne     L3E8D
L3E98:  ldx     $A9
        ldy     #$00
L3E9C:  lda     $BD,y
        sta     $02A4,x
        inx
        iny
        cpy     #$06
        bne     L3E9C
        ldx     #$0A
L3EAA:  lda     #$20
        sta     $0EB3,x
        lda     #$51
        sta     $0AB3,x
        dex
        bpl     L3EAA
        .byte   $A0
L3EB8:  brk
L3EB9:  sty     $AA
        lda     #$25
        sta     $0EB3,y
        ldx     #$30
        jsr     L1ADB
L3EC5:  jsr     L24B3
        beq     L3EC5
        ldy     $AA
        cmp     #$1C
        beq     L3EF2
        cmp     #$1D
        bne     L3EE1
        cpy     #$00
        beq     L3EB9
        lda     #$20
        sta     $0EB3,y
        dey
        jmp     L3557

L3EE1:  cpy     #$0A
        beq     L3EB9
        cmp     #$1B
        bne     L3EEB
        lda     #$20
L3EEB:  sta     $0EB3,y
        iny
        jmp     L3557

L3EF2:  lda     $A9
        clc
        adc     #$06
        tay
        ldx     #$00
L3EFA:  lda     $0EB3,x
        cmp     #$25
        bne     L3F03
        lda     #$20
L3F03:  sta     $02A4,y
        iny
        inx
        cpx     #$0A
        bne     L3EFA
        rts

        ldx     #$D4
        ldy     #$35
        jsr     L2D9B
        ldx     #$0F
L3F16:  lda     #$2A
        sta     $0CD0,x
        cpx     #$0A
        bcs     L3F22
        sta     $0EDB,x
L3F22:  dex
        bpl     L3F16
        ldx     #$05
L3F27:  lda     $0C99,x
        sta     $0D29,x
        lda     #$52
        sta     $0929,x
        dex
        bpl     L3F27
        rts

        php
        .byte   $03
        .byte   $77
        .byte   $44
        .byte   $5C
        .byte   $5A
        jmp     L4062

        ror     $68
        lsr     $40,x
        ror     $50
        .byte   $5C
        .byte   $5A
        .byte   $64
        plp
        brk
        php
        .byte   $04
        .byte   $67
        eor     $5D
        .byte   $5B
        eor     L4163
        .byte   $67
        adc     #$57
        eor     ($67,x)
        eor     ($5D),y
        .byte   $5B
        adc     $29
        brk
        .byte   $03
        .byte   $07
        .byte   $73
        ora     $150F,y
        .byte   $12
        jsr     L0313
        .byte   $0F
        .byte   $12
        ora     L0020
        .byte   $0F
        asl     L0020
        bmi     L3FA1
        bmi     L3FA3
        bmi     L3FA5
        jsr     L1309
        jsr     L0E09
        brk
        asl     a
        ora     #$73
        .byte   $66
L3F80:  .byte   $4E
L3F81:  pha
        jsr     L5C66
        lsr     $4A20,x
        bvc     L3FF4
        pha
        brk
        asl     a
        asl     a
        .byte   $63
        .byte   $67
L3F90:  .byte   $4F
L3F91:  eor     #$20
        .byte   $67
        eor     L205F,x
        .byte   $4B
        eor     ($6B),y
        eor     #$00
        ora     $0D
        .byte   $72
        .byte   $5E
L3FA0:  .byte   $56
L3FA1:  pha
        rti

L3FA3:  .byte   $64
        pha
L3FA5:  jsr     L5A48
L3FA8:  ror     $48
        .byte   $62
        jsr     L5C70
        pla
        .byte   $62
        jsr     L405A
        cli
        pha
        brk
        ora     $0E
        .byte   $62
        .byte   $5F
        .byte   $57
        eor     #$41
        adc     $49
        .byte   $20
L3FC0:  eor     #$5B
        .byte   $67
        eor     #$63
        jsr     L5D71
        adc     #$63
        jsr     L415B
        eor     $49,y
        .byte   $FF
        lda     #$00
        sta     $AD
        lda     $BB
        sta     $B4
        lda     $B5
        bne     L3FE6
        sed
        lda     $BC
        sta     $AC
        cld
        jmp     L3693

L3FE6:  lda     $B5
        beq     L3FF3
        lda     #$30
        sta     $0D3B
        sta     $0D3C
        rts

L3FF3:  .byte   $E6
L3FF4:  lda     $A5F8
        ldy     $E938
        ora     ($85,x)
        ldy     L48D8
        lsr     a
L4000:  lsr     a
        lsr     a
        lsr     a
        ora     #$30
        sta     $0D3B
        pla
        and     #$0F
        ora     #$30
        sta     $0D3C
        lda     $AC
        beq     L4015
        rts

L4015:  ldx     $1D
        lda     #$01
        sta     $028B,x
        sta     $B5
        sta     $B9
        jsr     L2868
        rts

        lda     L197C
        beq     L402E
        lda     #$3F
        sta     $FF11
L402E:  lda     #$03
        .byte   $85
L4031:  .byte   $17
        lda     #$00
        sta     $18
L4036:  ldx     #$00
L4038:  inc     $FF19
        dex
        bne     L4038
        lda     $18
        sta     $FF0F
        eor     #$FF
L4045:  sta     $FF0E
        lda     $17
        and     #$03
        sta     $FF10
        eor     #$FF
        and     #$03
        ora     $FF12
L4056:  sta     $FF12
        .byte   $C6
L405A:  clc
        bne     L4036
        dec     $17
        bne     L4036
        .byte   $A9
L4062:  brk
        sta     $FF11
        lda     #$11
        sta     $FF19
        rts

        ldx     L197E
        lda     L371D,x
        sta     $BA
        lda     L3722,x
        sta     $BB
        lda     L3727,x
        sta     $BC
        rts

        .byte   $14
        bpl     L408E
        php
        .byte   $04
        asl     a
        .byte   $0F
        .byte   $14
        ora     $111E,y
        asl     $21,x
        rol     $31
L408E:  inc     L197E
        lda     L197E
        cmp     #$05
        bne     L409D
L4098:  lda     #$04
        sta     L197E
L409D:  jsr     L1AF1
        ldx     #$51
        ldy     #$37
        jsr     L2D9B
        jsr     L36C2
        jsr     L36C2
        jsr     L36C2
        jmp     L197F

        php
        php
        ror     $56,x
        pha
        ror     a
        pha
        lsr     L0020,x
        .byte   $44
        .byte   $5C
        cli
        lsr     L4856,x
        ror     $48
        lsr     $28
        brk
        php
        ora     #$66
        .byte   $57
        eor     #$6B
        eor     #$57
        jsr     L5D45
        eor     $575F,y
        eor     #$67
        eor     #$47
        and     #$00
        ora     #$0C
        adc     $5A,x
        .byte   $5C
        jmp     (L5E20)

        lsr     $40,x
        bvs     L4107
        ror     $4E
        bvc     L414F
        brk
        ora     #$0D
        adc     $5B
        eor     L206D,x
        .byte   $5F
        .byte   $57
        eor     ($71,x)
        jsr     L4F67
        eor     ($65),y
        brk
        .byte   $FF
        jsr     L2020
        jsr     L4420
        .byte   $4F
        .byte   $52
        .byte   $4B
L4107:  .byte   $53
        jsr     L4944
        jmp     L4D45

        eor     L2041
        .byte   $42
        eor     $4D20,y
        eor     #$43
        .byte   $52
        .byte   $4F
        jsr     L5250
        .byte   $4F
        lsr     a
        eor     L0043
        .byte   $54
        .byte   $53
        jsr     L544C
        .byte   $44
        jsr     L4148
        lsr     $45,x
        jsr     L4F59
        eor     L0020,x
        bvc     L417E
        eor     ($59,x)
        eor     $44
        jsr     L4158
        .byte   $52
        .byte   $47
        .byte   $4F
        lsr     $5720
        eor     ($52,x)
        .byte   $53
        .byte   $3B
        bvc     L418A
        .byte   $54
        eor     ($4C,x)
L4148:  .byte   $53
        jsr     L464F
        jsr     L4F44
L414F:  .byte   $4F
        eor     $4F20
        .byte   $52
L4154:  jsr     L5954
        .byte   $43
L4158:  .byte   $4F
        .byte   $4F
        .byte   $4E
L415B:  jsr     L4554
        cli
        jsr     LFF3F
        .byte   $3E
L4163:  sta     ($81,x)
        sta     ($81,x)
        sta     ($3E,x)
        brk
        .byte   $7C
        inc     $FEEE,x
        inc     $EEEE
        brk
        .byte   $FC
        inc     $FCEE,x
        inc     $FCFE
        brk
        .byte   $7C
        inc     $E0EE,x
L417E:  inc     $7CFE
        brk
        .byte   $FC
        inc     $EEEE,x
        inc     $FCFE
        brk
L418A:  inc     $E0FE,x
        inc     $FEE0,x
        inc     $FE00,x
        inc     $FEE0,x
        cpx     #$E0
        cpx     #$00
        .byte   $7C
        inc     $FEE0,x
        inc     $7CFE
        brk
        inc     $EEEE
        inc     $EEEE,x
        inc     $FE00
        inc     L3838,x
        sec
        inc     a:$FE,x
        asl     $0E0E
        inc     $FEEE
        .byte   $7C
        brk
        inc     $EEEE
        .byte   $FC
        inc     $EEEE
        brk
        cpx     #$E0
        cpx     #$E0
        cpx     #$FE
        inc     $C600,x
        inc     $FEFE
        inc     $EEEE
        brk
        .byte   $FC
        inc     $EEEE,x
        inc     $EEEE
        brk
        .byte   $7C
        inc     $EEEE,x
        inc     $7CFE
L41E1:  brk
        .byte   $FC
        inc     $FCEE,x
        cpx     #$E0
        cpx     #$00
        .byte   $7C
        inc     $EEEE,x
        inc     $0E7C
        brk
        .byte   $FC
        inc     $FCEE,x
        inc     $EEEE
        brk
        .byte   $7C
        inc     $7CE0,x
        asl     $7CFE
        brk
        inc     L38FE,x
        sec
        sec
        sec
        sec
        brk
        inc     $EEEE
        inc     $FEEE
        .byte   $7C
        brk
        inc     $EEEE
        inc     $7CEE
        sec
        brk
        inc     $EEEE
        inc     $EEFE,x
        dec     L0000
        inc     $EEEE
        .byte   $7C
        inc     $EEEE
        brk
        inc     $EEEE
        .byte   $7C
        sec
        sec
        sec
        brk
        inc     $0EFE,x
        .byte   $7C
        cpx     #$FE
        inc     $FF00,x
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        brk
        ora     $17
        .byte   $1F
        .byte   $5F
        .byte   $7F
        .byte   $7F
        .byte   $77
        brk
        .byte   $50
L424C:  sty     $A4,x
        sbc     $E9
        sbc     $77F9,y
L4253:  .byte   $77
        .byte   $75
L4255:  adc     L1F5D,x
        .byte   $17
        ora     $F9
        sbc     $E9F9,y
        sbc     $A4
        sty     $50,x
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        ora     $07
        .byte   $57
        .byte   $7F
        .byte   $7F
        .byte   $6B
        .byte   $57
        .byte   $07
        .byte   $07
        .byte   $07
        .byte   $07
        .byte   $07
        ora     $5A,x
        ror     a
        ror     a
        bvc     L424C
        cmp     $FD,x
        sbc     $D5E9,x
        bne     L4253
        bne     L4255
        bne     L42DB
        sbc     $BD,x
        lda     $FFFF,x
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        brk
        .byte   $F2
        stx     $82
        .byte   $E2
        .byte   $82
        .byte   $82
        .byte   $87
        brk
        .byte   $F7
        .byte   $89
        sta     ($E2,x)
        sty     $88
        .byte   $8F
        clc
        clc
        clc
L42A5:  clc
        clc
        clc
        bmi     L42DA
        bmi     L42DC
        brk
        brk
        rts

        rts

        rts

        rts

        .byte   $FF
        .byte   $FF
        brk
        brk
        brk
        brk
        brk
        brk
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        brk
        ora     ($05,x)
        asl     $07
        ora     $17
        asl     L4154,x
        eor     ($9B),y
        .byte   $92
        bvc     L42A5
        ldy     $5E,x
        ror     $7E7E,x
        lsr     $171E,x
        .byte   $05
L42DA:  .byte   $E5
L42DB:  .byte   $ED
L42DC:  lda     $E5ED,x
        ldy     $D4,x
        bvc     L435F
        inc     $EEEE,x
        inc     $7CFE
        brk
        sec
        sec
        sei
        sei
        sec
        inc     a:$FE,x
        .byte   $7C
        inc     L1ECE,x
        sei
        inc     a:$FE,x
        .byte   $7C
        inc     L1CCE,x
        dec     $7CFE
        brk
        .byte   $1C
        .byte   $3C
        .byte   $7C
        cpx     $FEFE
        .byte   $1C
        brk
        inc     $F0FE,x
        .byte   $FC
        asl     $7CFE,x
        brk
        .byte   $7C
        inc     $FCE0,x
        inc     $7CFE
        brk
        inc     $CCFE,x
        clc
        sec
        sec
        sec
        brk
        .byte   $7C
        inc     $7CEE,x
        inc     $7CFE
        brk
        .byte   $7C
        inc     $7EEE,x
        asl     $7CFE
        brk
        brk
        brk
        sec
        sec
        brk
        sec
        sec
        brk
        brk
        brk
        brk
        brk
        clc
        clc
        bmi     L4342
L4342:  asl     L381C
        bvs     L43B7
        sec
        .byte   $1C
        asl     a:L0000
        ror     a:$7E,x
        ror     a:$7E,x
        bvs     L438C
        .byte   $1C
        asl     L1C0E
        sec
L4359:  bvs     L4399
        .byte   $7F
        .byte   $67
        .byte   $0E
        .byte   $1C
L435F:  brk
        .byte   $1C
        .byte   $1C
        .byte   $7C
        .byte   $7C
        inc     $EEFE,x
        inc     $FEFE
        inc     $EEEE
        inc     $EEEE
        brk
        brk
        .byte   $FC
        .byte   $FC
        inc     $EEFE,x
        inc     $FCFC
        inc     $FEEE
        inc     $FCFC,x
        brk
        brk
        .byte   $7C
        .byte   $7C
        inc     $EEFE,x
        inc     $E0E0
        .byte   $EE
        .byte   $EE
L438C:  inc     $7CFE,x
        .byte   $7C
        brk
        brk
        .byte   $FC
        .byte   $FC
        inc     $EEFE,x
        .byte   $EE
        .byte   $EE
L4399:  inc     $EEEE
        inc     $FCFE,x
        .byte   $FC
        brk
        brk
        inc     $FEFE,x
        inc     $E0E0,x
        inc     $E0FE,x
        cpx     #$FE
        inc     $FEFE,x
        brk
        brk
        inc     $FEFE,x
        .byte   $FE
        .byte   $E0
L43B7:  cpx     #$FE
        inc     $E0E0,x
        cpx     #$E0
        cpx     #$E0
        brk
        brk
        .byte   $7C
        .byte   $7C
        inc     $E0FE,x
        cpx     #$FE
        inc     $EEEE,x
        inc     $7CFE,x
        .byte   $7C
        brk
        brk
        inc     $EEEE
        inc     $EEEE
        inc     $EEFE,x
        inc     $EEEE
        inc     a:$EE
        brk
        inc     $FEFE,x
        inc     L3838,x
        sec
        sec
        sec
        sec
        inc     $FEFE,x
        inc     a:L0000,x
        asl     $0E0E
        asl     $0E0E
        inc     $EEEE
        inc     $FEFE
        .byte   $7C
        .byte   $7C
        brk
        brk
        inc     $EEEE
        inc     $EEEE
        .byte   $FC
        .byte   $FC
        inc     $EEEE
        inc     $EEEE
        brk
        brk
        cpx     #$E0
        cpx     #$E0
        cpx     #$E0
        cpx     #$E0
        cpx     #$E0
        inc     $FEFE,x
        .byte   $FE
L4420:  brk
        brk
        dec     $C6
        inc     $FEEE
        inc     $FEFE,x
        inc     $EEEE
        inc     $EEEE
        brk
        brk
        .byte   $FC
        .byte   $FC
        inc     $EEFE,x
        inc     $EEEE
        inc     $EEEE
        inc     $EEEE
        brk
        brk
        .byte   $7C
        .byte   $7C
        inc     $EEFE,x
        inc     $EEEE
        inc     $FEEE
        inc     $7C7C,x
        brk
        brk
        .byte   $FC
        .byte   $FC
        inc     $EEFE,x
        inc     $FCFC
        cpx     #$E0
        cpx     #$E0
        cpx     #$E0
        brk
        brk
        .byte   $7C
        .byte   $7C
        inc     $EEFE,x
        inc     $EEEE
        inc     $7CEE
        .byte   $7C
        asl     a:$0E
        brk
        .byte   $FC
        .byte   $FC
        inc     $EEFE,x
        inc     $FCFC
        inc     $EEEE
        inc     $EEEE
        brk
        brk
        .byte   $7C
        .byte   $7C
        inc     $E0FE,x
        cpx     #$7C
        .byte   $7C
        asl     $FE0E
        inc     $7C7C,x
        brk
        brk
        inc     $FEFE,x
        inc     L3838,x
        sec
        sec
        sec
        sec
        sec
        sec
        sec
        sec
        brk
        brk
        inc     $EEEE
        inc     $EEEE
        inc     $EEEE
        inc     $FEFE
        .byte   $7C
        .byte   $7C
        brk
        brk
        inc     $EEEE
        inc     $EEEE
        inc     $EEEE
        inc     $7C7C
        sec
        sec
        brk
        brk
        inc     $EEEE
        inc     $EEEE
        inc     $FEFE,x
        inc     $EEEE,x
        dec     $C6
        brk
        brk
        inc     $EEEE
        inc     $EEEE
        .byte   $7C
        .byte   $7C
        inc     $EEEE
        inc     $EEEE
        brk
        brk
        inc     $EEEE
        inc     $EEEE
        .byte   $7C
        .byte   $7C
        sec
        sec
        sec
        sec
        sec
        sec
        brk
        brk
        inc     $FEFE,x
        inc     $0E0E,x
        .byte   $7C
        .byte   $7C
        cpx     #$E0
        inc     $FEFE,x
        inc     a:L0000,x
        .byte   $7C
        .byte   $7C
        inc     $EEFE,x
        inc     $EEEE
        inc     $FEEE
        inc     $7C7C,x
        brk
        brk
        sec
        sec
        sec
        sec
        sei
        sei
        sei
        sei
        sec
        sec
        inc     $FEFE,x
        inc     a:L0000,x
        .byte   $7C
        .byte   $7C
        inc     $CEFE,x
        dec     L1E1E
        sei
        sei
        inc     $FEFE,x
        inc     a:L0000,x
        .byte   $7C
        .byte   $7C
        inc     $CEFE,x
        dec     L1C1C
        dec     $FECE
        inc     $7C7C,x
        brk
        brk
        .byte   $1C
        .byte   $1C
        .byte   $3C
        .byte   $3C
        .byte   $7C
        .byte   $7C
        cpx     $FEEC
        inc     $FEFE,x
        .byte   $1C
        .byte   $1C
        brk
        brk
        .byte   $FE
        .byte   $FE
L4554:  .byte   $FE
L4555:  inc     $F0F0,x
        .byte   $FC
        .byte   $FC
        asl     $FE1E,x
        inc     $7C7C,x
        brk
        brk
        .byte   $7C
        .byte   $7C
        inc     $E0FE,x
        cpx     #$FC
        .byte   $FC
        inc     $FEEE
        inc     $7C7C,x
        brk
        brk
        inc     $FEFE,x
        inc     $CCCC,x
        clc
        clc
        sec
        sec
        sec
        sec
        sec
        sec
        brk
        brk
        .byte   $7C
        .byte   $7C
        inc     $EEFE,x
        inc     $7C7C
        inc     $FEEE
        inc     $7C7C,x
        brk
        brk
        .byte   $7C
        .byte   $7C
        inc     $EEFE,x
        inc     $7E7E
        asl     $FE0E
        inc     $7C7C,x
        brk
L45A1:  brk
        brk
        .byte   $04
        .byte   $54
        .byte   $04
        .byte   $14
        .byte   $54
L45A8:  .byte   $04
        .byte   $04
        brk
        rol     a
        rol     a
        .byte   $27
        .byte   $27
        and     L272D
        brk
        tax
        tax
        ror     $76,x
        dec     $76DE,x
        .byte   $04
        .byte   $04
        .byte   $04
        ora     $70,x
        bvs     L4640
        ora     $27,x
        and     L272D
        .byte   $67
L45C7:  ror     a
        ror     a
        brk
        ror     $DE,x
        dec     $7676,x
        tax
        tax
        brk
        brk
        brk
        brk
        brk
L45D6:  brk
        brk
        brk
        brk
        brk
        .byte   $1F
        cpx     #$8F
        .byte   $7F
        beq     L45A1
        .byte   $80
        brk
        cpy     #$30
        bcc     L45C7
        bvs     L4619
        bpl     L45EB
L45EB:  brk
        brk
        .byte   $07
L45EE:  .byte   $0F
        .byte   $0B
        .byte   $07
        brk
        .byte   $80
        .byte   $80
        .byte   $80
        .byte   $80
        sta     ($81,x)
        brk
        brk
        bpl     L460C
        bpl     L45EE
        beq     L4670
        cpx     #$00
        brk
        brk
        brk
        brk
        brk
        brk
        brk
L4609:  brk
        ora     $17
L460C:  .byte   $1F
        .byte   $5F
        .byte   $7F
        .byte   $7F
        .byte   $77
        .byte   $77
        bvc     L45A8
        cpx     $E5
        sbc     #$F9
        .byte   $F9
L4619:  sbc     L0000,y
L461C:  brk
        brk
L461E:  brk
        brk
L4620:  brk
        brk
        .byte   $77
        adc     $7D,x
        adc     L1F5D,x
        .byte   $17
        ora     $F9
        sbc     $E9F9,y
        sbc     $E4
        sty     $50,x
        brk
        brk
        brk
        brk
        ora     ($01,x)
        ora     ($01,x)
        brk
        ora     $5E,x
        .byte   $7F
        .byte   $7F
        .byte   $FF
L4640:  .byte   $FF
        .byte   $DF
        brk
        rti

        bvc     L45D6
        sty     $A4,x
        cpx     $E4
        ora     ($01,x)
        ora     ($01,x)
        .byte   $01
L464F:  brk
        brk
        brk
        .byte   $DF
        .byte   $DF
        .byte   $D7
        .byte   $F7
        .byte   $77
        .byte   $7F
        lsr     $E415,x
        cpx     $E4
        cpx     $94
        bcc     L46B1
        rti

        brk
        brk
        brk
        ora     ($01,x)
        ora     $07
        .byte   $07
        brk
        brk
        eor     $79,x
        .byte   $FE
        .byte   $FE
L4670:  .byte   $FF
        .byte   $FF
        brk
        brk
        brk
        rti

        rti

        bvc     L4609
        bcc     L4682
        .byte   $07
        .byte   $07
        .byte   $07
        ora     $01
        ora     (L0000,x)
L4682:  .byte   $FF
        .byte   $7F
        .byte   $5F
        dec     $FADE,x
        adc     #$55
        bcc     L461C
        bcc     L461E
        bvc     L46D0
        rti

        brk
        brk
        ora     ($05,x)
        .byte   $07
        .byte   $07
        .byte   $1F
        .byte   $1F
        ora     $5400,x
        sbc     $F9
        sbc     $FEFA,y
        inc     a:L0000,x
        brk
        brk
        rti

        rti

        rti

        rti

        ora     L1D1D,x
        .byte   $1F
        .byte   $17
        .byte   $07
        .byte   $05
L46B1:  ora     ($FE,x)
        inc     $7A7E,x
        adc     $A5E9,y
        .byte   $54
        rti

        rti

        rti

        rti

        rti

        brk
        brk
        brk
        brk
        brk
        brk
        brk
L46C6:  brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
L46D0:  brk
        brk
        ora     $17
        .byte   $1F
        .byte   $5F
        .byte   $7F
        .byte   $7F
        .byte   $77
        .byte   $77
        bvc     L4670
        cpx     $E5
        sbc     #$F9
        sbc     $77F9,y
        adc     $7D,x
        adc     L1F5D,x
        .byte   $17
        ora     $F9
        sbc     $E9F9,y
        sbc     $E4
        sty     $50,x
        brk
L46F3:  brk
        brk
        brk
        brk
        brk
        brk
        ora     L0000
        brk
        brk
        brk
        brk
        brk
        brk
        bvc     L471A
        .byte   $1F
        .byte   $5F
        .byte   $7F
        .byte   $7F
        .byte   $77
        .byte   $77
        .byte   $77
        sty     $E4,x
        sbc     $E9
        sbc     $F9F9,y
        sbc     $7D75,y
        eor     $171F,x
        ora     L0000
        brk
L471A:  sbc     $E5F9,y
        cpx     $94
        .byte   $50
L4720:  brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        ora     $17
        brk
        brk
        brk
        brk
        brk
        brk
        bvc     L46C6
        .byte   $1F
        .byte   $5F
        .byte   $7F
        .byte   $7F
        .byte   $7F
        .byte   $77
        adc     $7D,x
        cpx     $E5
        sbc     $F9F9,y
        sbc     $E9F9,y
        eor     $161F,x
        ora     L0000
        brk
        brk
        brk
        sbc     $A4
        sty     $50,x
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        ora     $17
        .byte   $1F
        .byte   $5F
        .byte   $7F
        brk
        brk
        brk
        bvc     L46F3
        cpx     $E5
        sbc     #$7F
        .byte   $77
        .byte   $77
        .byte   $77
        adc     $7D,x
        eor     $F91F,x
        sbc     $F9F9,y
        sbc     $E5E9,y
        ldy     $16
        ora     L0000
        brk
        brk
        brk
        brk
        brk
        sty     $50,x
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        eor     $DF,x
        .byte   $DF
        eor     $55,x
        sbc     $55FD,x
        eor     $69,x
        adc     #$69
        adc     #$69
        eor     $55,x
        .byte   $DB
        .byte   $DB
        .byte   $BD
        .byte   $BD
L479E:  ror     $E77E,x
        .byte   $E7
L47A2:  eor     $69,x
        adc     #$55
        eor     $69,x
        adc     #$55
        .byte   $FF
        sta     ($81,x)
        sta     ($81,x)
        sta     ($81,x)
        .byte   $FF
        .byte   $FF
        .byte   $7F
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
L47B8:  .byte   $FF
        .byte   $FF
L47BA:  brk
        brk
        .byte   $C3
        ror     $C37E,x
        brk
        brk
        bit     $3C
        clc
        clc
        clc
        clc
        .byte   $3C
        bit     L0000
        brk
        ora     ($1F,x)
        .byte   $1F
        ora     L3C18,y
        brk
        brk
        .byte   $80
        sed
        sed
        tya
        clc
        .byte   $3C
        .byte   $3C
        clc
        ora     L1F1F,y
        ora     (L0000,x)
        brk
        .byte   $3C
        clc
        tya
        sed
        sed
        .byte   $80
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
L4806:  brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        clc
        clc
        brk
        brk
        brk
        brk
        clc
        clc
        brk
        brk
        brk
        brk
        .byte   $7F
        .byte   $80
        bcc     L479E
        .byte   $80
        .byte   $80
        bcc     L47A2
        .byte   $FF
        brk
        brk
        rts

        bne     L47B8
        bne     L47BA
        .byte   $FF
        brk
        brk
        rti

        brk
        brk
        bpl     L4832
L4832:  .byte   $FF
        brk
        asl     L4031
        .byte   $80
        .byte   $80
        tya
        inc     $0101,x
        sta     ($41,x)
        and     ($21,x)
        and     ($81,x)
        sta     ($81,x)
        .byte   $83
        sta     $89
        .byte   $89
        stx     $48
        dey
        pha
        sty     $894A
        sta     $F6,y
        brk
L4854:  .byte   $80
        brk
L4856:  brk
        .byte   $04
        brk
        brk
        ldy     L4098,x
        and     ($0E),y
        brk
        brk
        brk
        and     ($21,x)
        eor     ($85,x)
        ora     $0B
        ora     #$09
        .byte   $80
L486B:  .byte   $80
        .byte   $80
        dey
        .byte   $80
        .byte   $80
        cpy     #$B8
        brk
        rts

        bcc     L4806
        rts

        rti

        brk
        .byte   $E3
        brk
        rti

        .byte   $04
        asl     a
        asl     a
        .byte   $12
        and     ($21),y
        brk
        jsr     L0000
        ora     ($01,x)
        asl     $18
        ora     ($51),y
        lda     ($91),y
        ora     ($01),y
        ora     ($01,x)
        .byte   $87
        .byte   $80
        .byte   $80
        ldx     $AAAA,y
        ldx     #$B6
        .byte   $1C
        brk
        brk
        .byte   $BB
        rol     a
        ldx     #$AB
        tsx
        cpy     #$00
        brk
        clv
        tay
        tay
        plp
        clv
        ldy     #$40
        pla
        .byte   $14
        .byte   $03
        brk
        brk
        brk
        ora     ($01,x)
        ora     ($01,x)
        .byte   $89
        eor     $65,x
        ora     $80
        .byte   $BB
        tax
        tsx
        .byte   $A3
        ldx     #$80
        .byte   $7F
        brk
        .byte   $BB
        lda     #$A9
        and     #$BB
        brk
        .byte   $FF
        brk
        .byte   $BB
        .byte   $22
        .byte   $32
        .byte   $22
        .byte   $3B
        brk
        .byte   $FF
        brk
        .byte   $BB
        .byte   $92
        .byte   $13
        bcc     L486B
L48D8:  brk
        .byte   $FF
        .byte   $07
        sta     ($01,x)
        sta     ($99,x)
        sta     $FF01,y
        .byte   $FF
        .byte   $FF
        brk
L48E5:  brk
        brk
        brk
        cpy     #$C0
        bmi     L491C
        .byte   $0C
        .byte   $0C
        .byte   $0C
        .byte   $0C
        .byte   $0C
        .byte   $0C
        .byte   $FC
        .byte   $FC
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        .byte   $03
        brk
        ora     ($05,x)
        asl     $07
        ora     $17
        asl     L4154,x
        eor     ($9B),y
        .byte   $92
        bvc     L48E5
        ldy     $5E,x
        ror     $7E7E,x
        lsr     $171E,x
        ora     $E5
        .byte   $ED
L491C:  lda     $E5ED,x
        ldy     $D4,x
        bvc     L4977
        sta     $0500
        lda     #$1C
        ldy     #$99
        .byte   $3C
        clc
        ora     L1F1F,y
        ora     L3C18,y
        .byte   $3C
        clc
        tya
        sed
        sed
        tya
        clc
        .byte   $3C
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
L4944:  .byte   $FF
        .byte   $FF
        .byte   $44
        .byte   $4F
        eor     $42,x
        jmp     L4045

        .byte   $3A
        .byte   $93
        .byte   $13
L4950:  ora     ($11),y
        ora     ($11),y
        ora     ($11),y
        php
        .byte   $FF
        sta     $FF3E
        jmp     LF2A4

        inc     L00FF,x
        .byte   $FF
        .byte   $FF
