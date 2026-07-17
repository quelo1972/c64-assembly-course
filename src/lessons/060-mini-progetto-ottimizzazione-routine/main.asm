* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0
; Lezione 060 - Baseline vs versione compatta (dimostrativa)


    .word 0


SRC = $C300
DST = $0400

start:
    ; versione compatta: copia 256 byte
    LDX #$00
copy:
    LDA SRC,X
    STA DST,X
    INX
    BNE copy

done:
    JMP done
