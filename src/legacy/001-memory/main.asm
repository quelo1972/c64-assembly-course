;========================================
; Lesson 001 - Memory example
;========================================

* = $1000

    lda #$06    ; set border color to blue
    sta $d020

    ldx #$20    ; short delay so the change is visible
delay1:
    dex
    bne delay1

    rts
