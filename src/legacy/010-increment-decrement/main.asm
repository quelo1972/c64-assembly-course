;========================================
; Lesson 010
; Increment and decrement
;========================================

* = $1000

    lda #$00   ; A = 0
    tax        ; X = 0

loop:
    inx        ; X++
    txa        ; A = X
    sta $d020  ; show X as border color
    cpx #$05   ; compare X with 5
    bne loop   ; loop until X == 5

    rts
