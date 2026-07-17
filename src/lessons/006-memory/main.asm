* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0
; Lezione 006 - Memoria mappata I/O: scrittura su $D020


    .word 0


BORDER = $D020

start:
	LDA #$06
	STA BORDER

	RTS
