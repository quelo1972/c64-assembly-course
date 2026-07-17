* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0
; Lezione 007 - Uso di costanti esadecimali


    .word 0


BORDER = $D020

start:
   LDA #$0A
   STA BORDER

   RTS
