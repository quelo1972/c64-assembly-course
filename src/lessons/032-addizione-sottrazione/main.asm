; Lezione 024 — Addizione e sottrazione
; Aritmetica con carry
*= $0801

; Addizione semplice
CLC            ; Azzera il carry prima di ADC
LDA #$50
ADC #$30       ; A = $50 + $30 + 0 = $80

; Addizione con overflow
CLC
LDA #$FF
ADC #$02       ; A = $FF + $02 + 0 = $101 → $01 con C=1

; Sottrazione semplice
SEC            ; Setta il carry (no borrow)
LDA #$50
SBC #$30       ; A = $50 - $30 - 0 = $20

; Addizione a 16 bit
CLC
LDA #$FF       ; byte basso
ADC #$01       ; aggiungi 1 al byte basso
STA $02        ; salva il risultato

LDA #$00       ; byte alto
ADC #$00       ; aggiungi carry (se presente)
STA $03        ; salva byte alto

RTS
