; Lezione 063 - Build marker semplice
*= $0801

SCREEN = $0400

start:
    LDA #'R'
    STA SCREEN
    LDA #'1'
    STA SCREEN+1
    LDA #'0'
    STA SCREEN+2

loop:
    JMP loop
