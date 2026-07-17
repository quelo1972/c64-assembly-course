; Lezione 013 — Indirizzamento assoluto
; Controlla registri VIC-II e SID
*= $0801

; Nota: LDA indirizzo (assoluto) legge il byte da quell'indirizzo a 16 bit.
; Nota: STA indirizzo (assoluto) scrive A in quell'indirizzo a 16 bit.

; Cambia colore bordo (VIC-II $D020)
LDA #$0B           ; carica il colore marrone
STA $D020          ; scrivi nel registro colore bordo (assoluto)

; Leggi il registro SID di controllo (SID $D404)
LDA $D404          ; leggi il registro SID Control Voice 1
STA $D020          ; rifletti il valore nel bordo (per debug)

RTS
