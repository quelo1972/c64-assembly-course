; Lezione 039 - Uso base di CHROUT e GETIN
*= $0801

start:
  LDA #'A'         ; carica il carattere ASCII/PETSCII da stampare
  JSR $FFD2        ; CHROUT: stampa A sullo schermo

wait_key:
  JSR $FFE4        ; GETIN: A = tasto, oppure 0 se nessun tasto
  CMP #$00         ; verifica se e arrivato input
  BEQ wait_key     ; se A=0 continua ad aspettare

  JSR $FFD2        ; stampa il tasto premuto
  JMP wait_key
