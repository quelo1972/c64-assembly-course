;========================================
; Lesson 005 - Registers A, X, Y example
;========================================

* = $1000

    lda #$05
    tax
    ldx #$03
    txa

    ; loop to demonstrate register changes
    ldx #$04
reg_loop:
    dex
    txa
    bne reg_loop

    rts
