* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

* = $1000

    lda #$0a
    sta $d020
    lda #$00
    sta $d021
    rts
