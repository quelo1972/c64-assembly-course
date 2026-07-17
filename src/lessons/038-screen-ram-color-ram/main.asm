; Lezione 038 - Scrittura in Screen RAM e Color RAM
*= $0801

  LDX #$00          ; X = indice posizione

fill_line:
  LDA #$01          ; screen code 1 (tipicamente 'A' nel charset standard)
  STA $0400,X       ; scrive carattere sulla prima riga

  LDA #$0E          ; colore azzurro chiaro
  STA $D800,X       ; scrive colore cella corrispondente

  INX               ; posizione successiva
  CPX #$28          ; 40 colonne decimali = $28
  BNE fill_line     ; continua finche X != 40

  RTS
