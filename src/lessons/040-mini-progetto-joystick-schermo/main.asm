* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0
; Lezione 040 - Mini progetto joystick + schermo


    .word 0


cursor_x = $02

start:
  LDA #$00
  STA cursor_x

main_loop:
  JSR erase_cursor
  JSR read_input
  JSR draw_cursor
  JMP main_loop

erase_cursor:
  LDX cursor_x
  LDA #$20        ; spazio
  STA $0400,X
  RTS

read_input:
  LDA $DC00

  AND #%00000100  ; LEFT (0 = premuto)
  BNE check_right

  LDX cursor_x
  CPX #$00
  BEQ check_right
  DEX
  STX cursor_x

check_right:
  LDA $DC00
  AND #%00001000  ; RIGHT (0 = premuto)
  BNE done_input

  LDX cursor_x
  CPX #$27        ; 39 decimale
  BEQ done_input
  INX
  STX cursor_x

done_input:
  RTS

draw_cursor:
  LDX cursor_x
  LDA #$51        ; codice simbolo cursore (esempio)
  STA $0400,X
  LDA #$01        ; bianco
  STA $D800,X
  RTS
