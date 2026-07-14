* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

; Lezione 012 — Indirizzamento Zero Page
; Usa la Zero Page come area di variabili temporanee

; Variabili in Zero Page (indirizzi $02-$FF sono liberi da usare)
; $02 = colore bordo da usare

; Nota: LDA indirizzo legge il byte contenuto alla cella di memoria indicata.
; Nota: STA indirizzo scrive il contenuto di A nella cella di memoria indicata.

; Inizializza la variabile colore bordo a $05 (verde)
LDA #$05        ; carica il valore $05 in A (modalità immediata)
STA $02         ; salva $05 nella cella $0002 (Zero Page)

; Leggi la variabile e applicala al bordo VIC-II
LDA $02         ; carica in A il contenuto di $0002 (Zero Page)
STA $D020       ; scrivi nel registro colore bordo VIC-II

; Cambia la variabile e riapplica
LDA #$02        ; rosso
STA $02         ; aggiorna la variabile
LDA $02
STA $D020

RTS             ; fine del programma
