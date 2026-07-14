* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

; Lezione 010 - Registri A, X, Y in azione

BORDER = $D020

start:
	LDA #$01
	LDX #$02
	LDY #$03

	TXA
	ADC #$00
	TYA
	STA BORDER

	RTS
