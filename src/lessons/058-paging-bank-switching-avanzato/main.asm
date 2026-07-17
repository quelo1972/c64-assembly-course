* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0
; Lezione 058 - Save/switch/restore del registro $01


    .word 0


PORT01 = $0001
BORDER = $D020

start:
    LDA PORT01
    PHA                 ; salva mappa attuale

    ; esempio: cambia temporaneamente bit mappa (dimostrativo)
    LDA PORT01
    AND #%11111000
    ORA #%00000101
    STA PORT01

    ; operazione protetta (placeholder)
    INC BORDER

    PLA
    STA PORT01          ; ripristina mappa originaria

    RTS
