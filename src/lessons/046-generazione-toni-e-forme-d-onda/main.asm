; Lezione 046 - Tone test: triangle, saw, pulse
*= $0801

SID_V1_FREQ_LO = $D400
SID_V1_FREQ_HI = $D401
SID_V1_PW_LO   = $D402
SID_V1_PW_HI   = $D403
SID_V1_CTRL    = $D404
SID_V1_AD      = $D405
SID_V1_SR      = $D406
SID_VOL        = $D418

start:
    LDA #$0F
    STA SID_VOL

    ; ADSR veloce per test
    LDA #$11
    STA SID_V1_AD
    LDA #$F1
    STA SID_V1_SR

    ; frequenza test
    LDA #$00
    STA SID_V1_FREQ_LO
    LDA #$28
    STA SID_V1_FREQ_HI

    ; pulse width media
    LDA #$00
    STA SID_V1_PW_LO
    LDA #$08
    STA SID_V1_PW_HI

triangle_note:
    LDA #%00010001
    STA SID_V1_CTRL
    JSR delay
    LDA #%00010000
    STA SID_V1_CTRL
    JSR delay

saw_note:
    LDA #%00100001
    STA SID_V1_CTRL
    JSR delay
    LDA #%00100000
    STA SID_V1_CTRL
    JSR delay

pulse_note:
    LDA #%01000001
    STA SID_V1_CTRL
    JSR delay
    LDA #%01000000
    STA SID_V1_CTRL
    JSR delay

    JMP triangle_note

delay:
    LDY #$20
d1:
    LDX #$FF
d2:
    DEX
    BNE d2
    DEY
    BNE d1
    RTS
