* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0
    lda #$06   ; A = 6
    tax        ; X = 6

    lda #$0a   ; A = 10
    tay        ; Y = 10

    txa        ; A = 6
    tya        ; A = 10

    rts
