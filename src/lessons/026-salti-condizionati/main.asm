; Lezione 015 — Salti condizionati
; Loop che azzera 16 byte
*= $0801

; Nota: BEQ label salta se Z=1 (risultato zero).
; Nota: BNE label salta se Z=0 (risultato non-zero).
; Nota: INX incrementa X e setta il flag Z.

LDX #$10       ; carica 16 in X

loop:
  ; azzera la cella
  LDA #$00
  STA $0400,X
  
  DEX            ; decrementa X, setta Z se X = 0
  BNE loop       ; se X non è zero, ripeti

RTS
