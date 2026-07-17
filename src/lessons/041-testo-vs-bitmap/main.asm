* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0
; Lezione 041 - Confronto pratico: testo -> bitmap


    .word 0


SCREEN_RAM = $0400
COLOR_RAM  = $D800
BORDER     = $D020
BG0        = $D021
VIC_CTRL1  = $D011
VIC_MPTR   = $D018

start:
    ; fase 1: modalita testo (riempie la prima riga)
    LDA #$00
    STA BG0          ; sfondo nero
    LDA #$06
    STA BORDER       ; bordo blu

    LDX #$00
fill_row:
    LDA #$01         ; codice carattere
    STA SCREEN_RAM,X ; scrive in screen RAM
    LDA #$0E
    STA COLOR_RAM,X  ; colore cella
    INX
    CPX #$28         ; 40 colonne
    BNE fill_row

    ; fase 2: passaggio minimo a bitmap mode
    ; ORA imposta bit a 1 mantenendo gli altri invariati
    LDA VIC_CTRL1
    ORA #%00100000   ; bit 5 = bitmap mode ON
    STA VIC_CTRL1

    ; D018: screen RAM = $0400 (high nibble=1), bitmap = $2000 (bit 3 = 1)
    LDA #$18
    STA VIC_MPTR

    RTS
