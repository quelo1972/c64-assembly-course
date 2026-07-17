; Lezione 006 - Memoria mappata I/O: scrittura su $D020
*= $0801

BORDER = $D020

start:
	LDA #$06
	STA BORDER

	RTS
