; Lezione 054 - Load KERNAL con check carry
*= $0801

SETLFS = $FFBA
SETNAM = $FFBD
LOAD   = $FFD5
BORDER = $D020

start:
    ; Nome file "DEMO"
    LDA #$04
    LDX #<fname
    LDY #>fname
    JSR SETNAM

    ; LFN=1, device=8, SA=0
    LDA #$01
    LDX #$08
    LDY #$00
    JSR SETLFS

    ; LOAD con indirizzo dal file (A=0)
    LDA #$00
    LDX #$00
    LDY #$00
    JSR LOAD

    BCC ok_load

err_load:
    LDA #$02
    STA BORDER
    JMP done

ok_load:
    LDA #$05
    STA BORDER

done:
    JMP done

fname:
    .text "DEMO"
