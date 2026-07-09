; Lezione 018 — Indirizzamento indiretto indicizzato
; Leggi da un array usando puntatore + offset
*= $0801

; Setup puntatore base in Zero Page
	LDA #<data
	STA $40
	LDA #>data
	STA $41

start:
	LDX #$00
	LDA ($40,X)    ; indexed indirect: legge da indirizzo puntato da $40/$41
	STA $D020

	LDY #$01
	LDA ($40),Y    ; indirect indexed: legge da (puntatore + Y)
	STA $D021

loop:
	JMP loop

data:
	.byte $06,$0B
