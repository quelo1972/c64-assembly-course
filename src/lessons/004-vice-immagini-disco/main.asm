; Lezione 004 - PRG minimo da caricare in VICE
*= $0801

BORDER = $D020

start:
  LDA #$02
  STA BORDER

  INC BORDER
  RTS
