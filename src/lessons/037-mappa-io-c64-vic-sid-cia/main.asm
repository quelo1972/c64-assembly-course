; Lezione 037 - Lettura joystick e scrittura su border color
*= $0801

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
