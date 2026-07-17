* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0
; Lezione 002 - Programma minimo tracciabile in Git


    .word 0


BORDER = $D020

start:
	LDA #$06
	STA BORDER

	RTS
