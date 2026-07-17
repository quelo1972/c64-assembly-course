* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0
; Lezione 063 - Build marker semplice


    .word 0


SCREEN = $0400

start:
    LDA #'R'
    STA SCREEN
    LDA #'1'
    STA SCREEN+1
    LDA #'0'
    STA SCREEN+2

    RTS
