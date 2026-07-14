* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

; Lezione 028 — Direttive e organizzazione
; Usa etichette, costanti e direttive
* = program_start

; Costanti hardware
vic2_border = $D020
vic2_bg = $D021
color_white = $01
color_black = $00
color_red = $02

; Costanti programma
max_count = $10

; Programma
init:
  LDA #color_black
  STA vic2_bg

loop:
  LDA #color_red
  STA vic2_border

  ; conta fino a max_count
  LDX #$00
count_loop:
  INX
  CPX #max_count
  BNE count_loop

  RTS

program_start = $0801
