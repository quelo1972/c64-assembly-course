; hello.asm
* = $0801        ; indirizzo di caricamento

BORDER = $D020

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

start:
    LDA #$06
    STA BORDER

    RTS
