; Lezione 047 - ADSR + filtro low-pass base
*= $0801

SID_V1_FREQ_LO = $D400
SID_V1_FREQ_HI = $D401
SID_V1_CTRL    = $D404
SID_V1_AD      = $D405
SID_V1_SR      = $D406
SID_FC_LO      = $D415
SID_FC_HI      = $D416
SID_RES_FILT   = $D417
SID_MODE_VOL   = $D418

start:
    ; volume 15 + low-pass on
    LDA #%00011111
    STA SID_MODE_VOL

    ; cutoff medio
    LDA #$80
    STA SID_FC_LO
    LDA #$04
    STA SID_FC_HI

    ; resonance media + route voice1 in filtro
    LDA #%01000001
    STA SID_RES_FILT

    ; frequenza nota test
    LDA #$00
    STA SID_V1_FREQ_LO
    LDA #$24
    STA SID_V1_FREQ_HI

    ; ADSR: attack rapido, decay medio, sustain alto, release medio
    LDA #$27
    STA SID_V1_AD
    LDA #$C5
    STA SID_V1_SR

play_note:
    ; saw + gate on
    LDA #%00100001
    STA SID_V1_CTRL
    JSR delay

    ; gate off (release)
    LDA #%00100000
    STA SID_V1_CTRL
    JSR delay

    JMP play_note

delay:
    LDY #$30
d1:
    LDX #$FF
d2:
    DEX
    BNE d2
    DEY
    BNE d1
    RTS
