* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

; Lezione 037 - Lettura joystick e scrittura su border color

loop:
  LDA $DC00      ; legge CIA1 Port A (joystick porta 2)
  AND #%00000001 ; isola bit UP (0 = premuto)
  BNE not_up     ; se bit = 1, non premuto

  LDA #$05       ; verde
  STA $D020      ; bordo = verde
  RTS

not_up:
  LDA #$02       ; rosso
  STA $D020      ; bordo = rosso
  RTS
