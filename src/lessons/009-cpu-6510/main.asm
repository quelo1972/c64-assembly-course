* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0
; Lezione 009 - Sequenza fetch/decode/execute minimale


    .word 0


BORDER = $D020

start:
	LDA #$01
	STA BORDER

	LDA #$03
	STA BORDER

	RTS
