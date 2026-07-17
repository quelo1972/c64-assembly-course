; Lezione 005 - Sorgente minimo per pipeline make build/run
*= $0801

BORDER = $D020

start:
	LDA #$05
	STA BORDER
	RTS
