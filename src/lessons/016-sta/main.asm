* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

* = $1000

    lda #$06
    sta $d020
    lda #$01
    sta $d021
    rts
