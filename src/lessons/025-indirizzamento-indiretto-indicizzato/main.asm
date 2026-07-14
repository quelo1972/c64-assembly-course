* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

; Lezione 018 — Indirizzamento indiretto indicizzato
; Leggi da un array usando puntatore + offset

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

	RTS

data:
	.byte $06,$0B
