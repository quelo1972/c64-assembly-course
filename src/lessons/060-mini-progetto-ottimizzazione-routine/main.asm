; Lezione 060 - Baseline vs versione compatta (dimostrativa)
*= $0801

SRC = $C300
DST = $0400

start:
    ; versione compatta: copia 256 byte
    LDX #$00
copy:
    LDA SRC,X
    STA DST,X
    INX
    BNE copy

done:
    JMP done
