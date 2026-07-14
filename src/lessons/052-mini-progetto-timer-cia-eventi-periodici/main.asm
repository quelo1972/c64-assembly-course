* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

; Lezione 052 - CIA Timer A IRQ mini scheduler

IRQ_VEC_LO = $0314
IRQ_VEC_HI = $0315
CIA1_TA_LO = $DC04
CIA1_TA_HI = $DC05
CIA1_ICR   = $DC0D
CIA1_CRA   = $DC0E
BORDER     = $D020

TICK      = $02
DIVIDER   = $03

start:
    SEI

    ; setup IRQ vector
    LDA #<irq_handler
    STA IRQ_VEC_LO
    LDA #>irq_handler
    STA IRQ_VEC_HI

    ; stop timer A
    LDA #$00
    STA CIA1_CRA

    ; timer period (valore demo)
    LDA #$FF
    STA CIA1_TA_LO
    LDA #$30
    STA CIA1_TA_HI

    ; clear pending CIA interrupts
    LDA CIA1_ICR

    ; enable CIA1 timer A IRQ (bit7=1 set mask, bit0=timer A)
    LDA #%10000001
    STA CIA1_ICR

    ; start timer A continuous
    LDA #%00010001
    STA CIA1_CRA

    LDA #$00
    STA TICK
    STA DIVIDER

    CLI

main_loop:
    ; qui andrebbe la logica principale (input, update, render)
    JMP main_loop

irq_handler:
    PHA
    TXA
    PHA
    TYA
    PHA

    ; acknowledge CIA1 interrupt source
    LDA CIA1_ICR

    INC TICK
    INC DIVIDER

    LDA DIVIDER
    CMP #$10
    BNE irq_exit

    LDA #$00
    STA DIVIDER
    INC BORDER

irq_exit:
    PLA
    TAY
    PLA
    TAX
    PLA
    RTI
