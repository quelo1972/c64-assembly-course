; Lezione 050 - Raster IRQ robusto (pattern base)
*= $0801

IRQ_VEC_LO = $0314
IRQ_VEC_HI = $0315
RASTER     = $D012
VIC_IRQ_EN = $D01A
VIC_IRQ_FL = $D019
CIA1_ICR   = $DC0D
CIA2_ICR   = $DD0D
BORDER     = $D020

start:
    SEI

    ; disabilita e pulisci CIA IRQ
    LDA #$7F
    STA CIA1_ICR
    STA CIA2_ICR
    LDA CIA1_ICR
    LDA CIA2_ICR

    ; raster line target
    LDA #$80
    STA RASTER

    ; abilita solo raster IRQ del VIC-II
    LDA #%00000001
    STA VIC_IRQ_EN

    ; installa vettore IRQ custom
    LDA #<irq_handler
    STA IRQ_VEC_LO
    LDA #>irq_handler
    STA IRQ_VEC_HI

    CLI

main_loop:
    JMP main_loop

irq_handler:
    PHA
    TXA
    PHA
    TYA
    PHA

    ; acknowledge VIC raster IRQ
    LDA #%00000001
    STA VIC_IRQ_FL

    INC BORDER

    PLA
    TAY
    PLA
    TAX
    PLA
    RTI
