* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

; Lezione 017 — Indirizzamento indiretto
; Usa puntatori in Zero Page per accedere a dati

; Sul 6510 l'indiretto puro e supportato da JMP ($addr)

start:
	LDA #<target
	STA $40
	LDA #>target
	STA $41
	JMP ($0040)

target:
	INC $D020
	JMP target
