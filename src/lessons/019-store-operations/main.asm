; Lezione 023 — Store operations
; Scrivi dati nella memoria
*= $0801

; Scrivi il colore bianco nel bordo
LDA #$01
STA $D020

; Scrivi una sequenza di byte in Zero Page
LDA #$42       ; 'B'
STA $02
LDA #$43       ; 'C'
STA $03
LDA #$44       ; 'D'
STA $04

; Scrivi usando indicizzazione
LDX #$00
LDA #$FF
STA $0400,X    ; scrivi in schermo + 0

LDX #$01
STA $0400,X    ; scrivi in schermo + 1

RTS
