; Lezione 022 — Compare e BIT test operations
; Confronta valori e testa bit
*= $0801

; Variabile in Zero Page
value = $02

; Carica un valore
LDA #$50

; Confronta con una soglia
CMP #$40
BCC below    ; salta se A < $40
; A >= $40
LDA #$03     ; colore ciano
JMP set_color

below:
  LDA #$01   ; colore bianco

set_color:
  STA $D020  ; visualizza il risultato

; Testa se un bit è settato
BIT value    ; testa memoria[value]
BMI bit7set  ; salta se bit 7 è settato
; bit 7 non è settato
BVC bit6notset
; bit 6 è settato
JMP done

bit7set:
  ; bit 7 è settato
  JMP done

bit6notset:
  ; bit 6 non è settato
  JMP done

done:
  RTS
