* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

; Lezione 057 - Loop copia RAM minimale

SRC = $C000
DST = $0400

start:
    LDX #$00
copy_loop:
    LDA SRC,X
    STA DST,X
    INX
    BNE copy_loop

done:
    JMP done
