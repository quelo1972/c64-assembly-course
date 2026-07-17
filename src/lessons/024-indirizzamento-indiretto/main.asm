; Lezione 017 — Indirizzamento indiretto
; Usa puntatori in Zero Page per accedere a dati
*= $0801

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
