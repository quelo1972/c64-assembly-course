; Lezione 056 - Mini save/load flow (dimostrativo)
*= $0801

SETLFS = $FFBA
SETNAM = $FFBD
SAVE   = $FFD8
LOAD   = $FFD5
BORDER = $D020

BUF_START = $C100
BUF_END   = $C110

start:
    ; inizializza buffer con pattern
    LDX #$00
fill:
    TXA
    STA BUF_START,X
    INX
    CPX #$10
    BNE fill

    ; nome file "DATA"
    LDA #$04
    LDX #<fname
    LDY #>fname
    JSR SETNAM

    ; LFN=1, device=8, SA=1
    LDA #$01
    LDX #$08
    LDY #$01
    JSR SETLFS

    ; SAVE: A=low(start), X=high(start), Y=high(end)
    LDA #<BUF_START
    LDX #>BUF_START
    LDY #>BUF_END
    JSR SAVE

    BCC save_ok
    LDA #$02
    STA BORDER
    JMP done

save_ok:
    ; LOAD dallo stesso nome
    LDA #$04
    LDX #<fname
    LDY #>fname
    JSR SETNAM

    LDA #$01
    LDX #$08
    LDY #$00
    JSR SETLFS

    LDA #$00
    LDX #$00
    LDY #$00
    JSR LOAD

    BCC load_ok
    LDA #$06
    STA BORDER
    JMP done

load_ok:
    LDA #$05
    STA BORDER

done:
    JMP done

fname:
    .text "DATA"
