; Lezione 002 - Programma minimo tracciabile in Git
*= $0801

BORDER = $D020

start:
	LDA #$06
	STA BORDER

loop:
	JMP loop
