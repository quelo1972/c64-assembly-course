* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

; Lezione 011 — Indirizzamento immediato
; Cambia il colore del bordo e dello sfondo del C64

; Nota: LDA #valore carica il byte nel registro A (accumulatore).
; Nota: STA indirizzo scrive il contenuto di A alla locazione di memoria indicata.

LDA #$05        ; carica il valore $05 (verde) in A
STA $D020       ; scrivi il colore del bordo  (registro VIC-II $D020)

LDA #$00        ; carica $00 (nero) in A
STA $D021       ; scrivi il colore di sfondo  (registro VIC-II $D021)

RTS             ; ritorna — fine del programma
