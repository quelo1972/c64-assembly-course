* = $1000

    lda #$06   ; A = 6
    tax        ; X = 6

    lda #$0a   ; A = 10
    tay        ; Y = 10

    txa        ; A = 6
    tya        ; A = 10

    rts
