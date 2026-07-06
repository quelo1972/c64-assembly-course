;========================================
; Lesson 003 - Byte/Word example
;========================================

* = $1000

    clc
    lda #$FF
    adc #$01   ; 255 + 1 -> overflow
    sta $d020  ; show result in border (will be $00)

    rts
