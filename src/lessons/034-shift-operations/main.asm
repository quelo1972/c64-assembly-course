* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0
; Lezione 026 — Shift operations
; Spostamento e rotazione di bit


    .word 0


; Moltiplicazione per 2 (shift left)
LDA #$50       ; 0101 0000
ASL            ; shift a sinistra → 1010 0000 = $A0 (moltiplicato per 2)

; Divisione per 2 (logical shift right)
LDA #$80       ; 1000 0000
LSR            ; shift a destra → 0100 0000 = $40 (diviso per 2)

; Estrai il bit 7 con rotate
LDA #$80       ; 1000 0000
ROL            ; ruota a sinistra → 0000 0000 con C=1
BCS bit7_set   ; salta se bit 7 era settato

; Multi-byte shift (es: 16 bit left shift)
CLC            ; azzera carry
LDA $02        ; byte basso
ASL            ; shift a sinistra
STA $02        ; salva byte basso

LDA $03        ; byte alto
ROL            ; ruota con carry dal byte basso
STA $03        ; salva byte alto

bit7_set:
  RTS
