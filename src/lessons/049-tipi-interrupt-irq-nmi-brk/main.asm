* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0
; Lezione 049 - Skeleton: installazione vettore IRQ RAM e handler base


    .word 0


IRQ_VEC_LO = $0314
IRQ_VEC_HI = $0315
KERNAL_IRQ = $EA31
BORDER     = $D020

start:
    SEI                     ; disabilita IRQ mascherabili durante setup

    LDA #<irq_handler
    STA IRQ_VEC_LO
    LDA #>irq_handler
    STA IRQ_VEC_HI

    CLI                     ; riabilita IRQ mascherabili

main_loop:
    JMP main_loop

irq_handler:
    ; dimostrazione: tocca bordo e poi passa a KERNAL
    INC BORDER
    JMP KERNAL_IRQ
