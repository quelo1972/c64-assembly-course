* = $1000

    lda #$00   ; A = 0
    tax        ; X = 0

loop:
    inx        ; X++
    txa        ; A = X
    sta $d020  ; mostra X come colore del bordo (per vedere il cambiamento)
    cpx #$05   ; confronta X con 5
    bne loop   ; ripeti finché X != 5

    rts
