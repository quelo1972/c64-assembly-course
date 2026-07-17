* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0
; Lezione 045 - Init minima SID voice 1


    .word 0


SID_V1_FREQ_LO = $D400
SID_V1_FREQ_HI = $D401
SID_V1_PW_LO   = $D402
SID_V1_PW_HI   = $D403
SID_V1_CTRL    = $D404
SID_V1_AD      = $D405
SID_V1_SR      = $D406
SID_VOL        = $D418

start:
    ; volume master = 15 (max)
    LDA #$0F
    STA SID_VOL

    ; frequenza iniziale (valore di prova)
    LDA #$00
    STA SID_V1_FREQ_LO
    LDA #$20
    STA SID_V1_FREQ_HI

    ; pulse width = 0x0800 (se useremo onda pulse)
    LDA #$00
    STA SID_V1_PW_LO
    LDA #$08
    STA SID_V1_PW_HI

    ; ADSR semplice
    LDA #$11          ; attack=1, decay=1
    STA SID_V1_AD
    LDA #$F2          ; sustain=15, release=2
    STA SID_V1_SR

    ; CONTROL: triangle + gate on
    LDA #%00010001
    STA SID_V1_CTRL

    RTS
