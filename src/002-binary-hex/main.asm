;========================================
; Lesson 002 - Binary/Hex example
;========================================

* = $1000

    lda #$0A   ; load decimal 10 (hex $0A)
    sta $d020  ; write to border

    ldx #$30
wait2:
    dex
    bne wait2

    rts
