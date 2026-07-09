; hello.asm
* = $0801        ; indirizzo di caricamento

BORDER = $D020

start:
    LDA #$06
    STA BORDER

loop:
    JMP loop
