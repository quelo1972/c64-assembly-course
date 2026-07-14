* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

; Lezione 014 — Indirizzamento indicizzato
; Leggi una stringa da screen RAM e copia nella screen RAM sottostante

; Nota: `LDA indirizzo,X` legge da (indirizzo + X).
; Nota: `STA indirizzo,X` scrive A in (indirizzo + X).

; Inizializza X come contatore
LDX #$00       ; X = 0 (primo byte)

; Loop: leggi 10 byte da $0400, scrivili in $0500
loop:
  LDA $0400,X  ; leggi byte da schermo + offset X
  STA $0500,X  ; scrivi in seconda riga + offset X
  INX           ; incrementa X
  CPX #$0A      ; X == 10?
  BNE loop       ; se no, ripeti

RTS
