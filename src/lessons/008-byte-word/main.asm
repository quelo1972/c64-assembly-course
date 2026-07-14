* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

; Lezione 008 - Overflow di un contatore a 8 bit

COUNTER = $C000

start:
   LDA #$FF
   STA COUNTER

   INC COUNTER     ; $FF -> $00 (wrap a 8 bit)

   RTS
