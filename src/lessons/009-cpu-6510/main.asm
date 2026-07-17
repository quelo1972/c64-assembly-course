; Lezione 009 - Sequenza fetch/decode/execute minimale
*= $0801

BORDER = $D020

start:
	LDA #$01
	STA BORDER

	LDA #$03
	STA BORDER

	RTS
