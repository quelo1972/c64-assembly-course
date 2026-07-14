* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

; Lezione 019 — Salti su Carry e Overflow
; Valida operazioni aritmetiche

; Somma con validazione di carry
LDA #$FF       ; carica 255
ADC #$02       ; aggiungi 2 → risultato = $101 = 1 con C=1

BCS carry_set  ; se c'è carry, salta
JMP no_carry

carry_set:
  LDA #$05     ; colore verde (debug)
  JMP set_color

no_carry:
  LDA #$01     ; colore bianco (debug)

set_color:
  STA $D020    ; visualizza il risultato nel bordo
  RTS
