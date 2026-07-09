; Lezione 055 - Stub PRG semplice
*= $0801

SCREEN = $0400
COLOR  = $D800

start:
    LDA #$48          ; 'H'
    STA SCREEN
    LDA #$01
    STA COLOR

loop:
    JMP loop
