* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0
; Lezione 004 - PRG minimo da caricare in VICE


    .word 0


BORDER = $D020

start:
  LDA #$02
  STA BORDER

  INC BORDER
  RTS
