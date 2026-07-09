; Lezione 057 - Loop copia RAM minimale
*= $0801

SRC = $C000
DST = $0400

start:
    LDX #$00
copy_loop:
    LDA SRC,X
    STA DST,X
    INX
    BNE copy_loop

done:
    JMP done
