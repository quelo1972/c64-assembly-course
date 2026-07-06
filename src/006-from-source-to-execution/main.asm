;========================================
; Lesson 006 - Source to execution example
;========================================

* = $1000

    ; minimal program to test assembly and PRG creation
    ldx #$03
run_delay:
    dex
    bne run_delay

    rts
