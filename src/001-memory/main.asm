;========================================
; Lesson 001 - Memory example
;========================================

* = $1000

    lda #$06    ; set border color to blue
    sta $d020

    rts
