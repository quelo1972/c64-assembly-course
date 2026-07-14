* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

; Lezione 051 - CIA1 Timer A in polling

CIA1_TA_LO = $DC04
CIA1_TA_HI = $DC05
CIA1_ICR   = $DC0D
CIA1_CRA   = $DC0E
BORDER     = $D020

start:
    ; stop timer A
    LDA #$00
    STA CIA1_CRA

    ; carica latch timer A
    LDA #$FF
    STA CIA1_TA_LO
    LDA #$20
    STA CIA1_TA_HI

    ; clear pending ICR by read
    LDA CIA1_ICR

    ; start timer A, continuous mode
    LDA #%00010001
    STA CIA1_CRA

main_loop:
wait_ta:
    LDA CIA1_ICR
    AND #%00000001          ; bit0: timer A underflow
    BEQ wait_ta

    INC BORDER
    JMP main_loop
