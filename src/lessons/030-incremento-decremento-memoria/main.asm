; Lezione 021 — Incremento e decremento in memoria
; Modifica variabili globali in Zero Page
*= $0801

; Variabili in Zero Page
counter = $02
accumulator = $03

; Incrementa il counter
INC counter    ; counter = counter + 1

; Se counter raggiunge 10, decrementa accumulator
LDA counter
CMP #$0A       ; confronta con 10
BNE skip

DEC accumulator ; decrementa se counter == 10
LDA #$00
STA counter    ; reset counter

skip:
  RTS
