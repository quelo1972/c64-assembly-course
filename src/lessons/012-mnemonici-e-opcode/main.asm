; Lezione 027 — Mnemonici e opcode
; Caricamento e scrittura tramite mnemonici
*= $0801

; Mnemonico: LDA #$0B
; Tradotto a: $A9 $0B
LDA #$0B       ; opcode A9, dato 0B

; Mnemonico: STA $D020
; Tradotto a: $8D $20 $D0
STA $D020      ; opcode 8D, indirizzo D020

; Mnemonico: RTS
; Tradotto a: $60
RTS            ; opcode 60
