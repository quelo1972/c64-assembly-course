; Lezione 020 — Operazioni di stack avanzate
; Salva e ripristina lo stato del processore
*= $0801

; Salva i flag attuali
PHP

; Simula un'operazione che cambia i flag
LDA #$FF
ADC #$01       ; overflow, carry, ecc.

; Qui i flag sono cambiati

; Ripristina i flag originali
PLP

; I flag sono tornati allo stato prima dell'ADC

; Leggi lo Stack Pointer attuale
TSX            ; X ← SP
; X contiene ora il valore dello SP (per debug)

; Modifica lo SP (attenzione! è pericoloso)
; TXS            ; SP ← X

RTS
