* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0
; Lezione 025 — Operazioni logiche
; Manipolazione di bit


    .word 0


; Estrai il nibble basso (4 bit bassi)
LDA #$A5       ; 1010 0101
AND #$0F       ; AND con 0000 1111
; Risultato: 0000 0101 = $05 (nibble basso estratto)

; Setta il bit 3 (aggiungi $08)
LDA #$42       ; 0100 0010
ORA #$08       ; ORA con 0000 1000
; Risultato: 0100 1010 = $4A (bit 3 settato)

; Inverti il bit 7
LDA #$00       ; 0000 0000
EOR #$80       ; EOR con 1000 0000
; Risultato: 1000 0000 = $80 (bit 7 invertito da 0 a 1)

; Azzera i bit alti (mantieni i bassi)
LDA #$FF       ; 1111 1111
AND #$0F       ; AND con 0000 1111
; Risultato: 0000 1111 = $0F (solo nibble basso)

RTS
