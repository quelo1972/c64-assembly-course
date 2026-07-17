; Lezione 043 - Raster IRQ minimale
*= $0801

IRQ_VECTOR_LO = $0314
IRQ_VECTOR_HI = $0315
VIC_RASTER    = $D012
VIC_IRQ_STAT  = $D019
VIC_IRQ_MASK  = $D01A
BORDER        = $D020
CIA1_ICR      = $DC0D
CIA2_ICR      = $DD0D
KERNAL_IRQ    = $EA31

setup:
    SEI

    ; disabilita IRQ CIA per evitare interferenze durante il setup
    LDA #$7F
    STA CIA1_ICR
    STA CIA2_ICR
    LDA CIA1_ICR
    LDA CIA2_ICR

    LDA #<irq_handler
    STA IRQ_VECTOR_LO
    LDA #>irq_handler
    STA IRQ_VECTOR_HI

    LDA #$64
    STA VIC_RASTER      ; linea raster 100

    LDA #%00000001
    STA VIC_IRQ_MASK    ; abilita IRQ raster

    CLI

main:
    JMP main

irq_handler:
    ; salva registri prima di modificare stato CPU
    PHA
    TXA
    PHA
    TYA
    PHA

    LDA #$05
    STA BORDER          ; segnale visivo nel punto raster

    LDA #%00000001
    STA VIC_IRQ_STAT    ; acknowledge IRQ raster

    PLA
    TAY
    PLA
    TAX
    PLA

    ; chaining al gestore KERNAL standard
    JMP KERNAL_IRQ
