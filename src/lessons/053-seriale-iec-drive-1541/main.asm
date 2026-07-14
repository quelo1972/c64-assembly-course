* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

; Lezione 053 - Apertura logica del canale verso device 8 (dimostrativo)

SETLFS = $FFBA
SETNAM = $FFBD
OPEN   = $FFC0
CLOSE  = $FFC3
CLRCHN = $FFCC

start:
    ; Nome file "TEST"
    LDA #$04
    LDX #<filename
    LDY #>filename
    JSR SETNAM

    ; LFN=1, device=8, SA=2
    LDA #$01
    LDX #$08
    LDY #$02
    JSR SETLFS

    ; OPEN channel
    JSR OPEN

    ; cleanup canali
    LDA #$01
    JSR CLOSE
    JSR CLRCHN

    RTS

filename:
    .text "TEST"
