; Lezione 010 - Registri A, X, Y in azione
*= $0801

BORDER = $D020

start:
	LDA #$01
	LDX #$02
	LDY #$03

	TXA
	ADC #$00
	TYA
	STA BORDER

loop:
	JMP loop
