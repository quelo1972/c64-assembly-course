;========================================
; Lesson 004 - CPU example
;========================================

* = $1000

    lda #$01
    ldy #$02
    tax

    ; simple observable loop using X as counter
    ldx #$08
cpu_loop:
    dex
    bne cpu_loop

    rts
