* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0
; hello.asm


    .word 0


BORDER = $D020


    .word 0

start:
    LDA #$06
    STA BORDER

    RTS
