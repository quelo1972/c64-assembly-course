* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

; Lezione 059 - RLE decode minimale: [count][value]

SRC = $C200
DST = $0400

start:
    LDY #$00            ; indice sorgente
    LDX #$00            ; indice destinazione

decode_next:
    LDA SRC,Y           ; count
    BEQ done            ; 0 = fine stream
    STA count
    INY

    LDA SRC,Y           ; value
    STA value
    INY

write_loop:
    LDA value
    STA DST,X
    INX
    DEC count
    BNE write_loop
    JMP decode_next

done:
    JMP done

count:
    .byte $00
value:
    .byte $00

* = SRC
    .byte 10,$41, 5,$20, 10,$42, 0
