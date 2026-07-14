* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

; Lezione 014 — Macro e organizzazione (standalone)

BORDER = $D020

set_border .macro color
  LDA #\color
  STA BORDER
.endm

start:
  set_border $02

loop:
  INC BORDER
  RTS
