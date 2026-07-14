* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

; Lezione 055 - Stub PRG semplice

SCREEN = $0400
COLOR  = $D800

start:
    LDA #$48          ; 'H'
    STA SCREEN
    LDA #$01
    STA COLOR

    RTS
