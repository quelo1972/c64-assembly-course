* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0
; Lezione 003 - Snippet da compilare con task VS Code


    .word 0


BACKGROUND = $D021

start:
  LDA #$0B
  STA BACKGROUND

  RTS
