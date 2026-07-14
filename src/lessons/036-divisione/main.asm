; Lezione 031 — Divisione
; Divisione 16 ÷ 8 → quoziente + resto
*= $0801

dividend = $C010
divisor = $C011
quotient = $C012
remainder = $C013

start:
  LDA #$0F
  STA dividend
  LDA #$03
  STA divisor
  LDA #$00
  STA quotient

div_loop:
  LDA dividend
  CMP divisor
  BCC done
  SEC
  SBC divisor
  STA dividend
  INC quotient
  JMP div_loop

done:
  LDA dividend
  STA remainder

  LDA quotient
  STA $D020
  LDA remainder
  STA $D021

	RTS
