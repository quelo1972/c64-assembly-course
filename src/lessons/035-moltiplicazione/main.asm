* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

; Lezione 030 — Moltiplicazione
; Moltiplicazione 8x8 → 16 bit

factor_a = $C000
factor_b = $C001
result_lo = $C002
result_hi = $C003

start:
  LDA #$05
  STA factor_a
  LDA #$03
  STA factor_b

  LDA #$00
  STA result_lo
  STA result_hi

  LDX factor_b
mul_loop:
  CLC
  LDA result_lo
  ADC factor_a
  STA result_lo
  LDA result_hi
  ADC #$00
  STA result_hi
  DEX
  BNE mul_loop

  LDA result_lo
  STA $D020

  RTS
