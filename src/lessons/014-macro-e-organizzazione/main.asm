; Lezione 014 — Macro e organizzazione (standalone)
*= $0801

BORDER = $D020

set_border .macro color
  LDA #\color
  STA BORDER
.endm

start:
  set_border $02

loop:
  INC BORDER
  JMP loop
