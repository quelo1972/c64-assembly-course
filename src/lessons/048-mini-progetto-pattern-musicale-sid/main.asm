* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0
; Lezione 048 - Mini pattern player monofonico


    .word 0


SID_V1_FREQ_LO = $D400
SID_V1_FREQ_HI = $D401
SID_V1_CTRL    = $D404
SID_V1_AD      = $D405
SID_V1_SR      = $D406
SID_VOL        = $D418

PAT_INDEX      = $02

start:
    LDA #$0F
    STA SID_VOL

    ; ADSR base
    LDA #$12
    STA SID_V1_AD
    LDA #$A3
    STA SID_V1_SR

    LDA #$00
    STA PAT_INDEX

main_loop:
    LDX PAT_INDEX

    ; carica frequenza dalla tabella
    LDA notes_lo,X
    STA SID_V1_FREQ_LO
    LDA notes_hi,X
    STA SID_V1_FREQ_HI

    ; gate on + triangle
    LDA #%00010001
    STA SID_V1_CTRL

    ; durata nota
    LDA note_len,X
    JSR wait_units

    ; gate off
    LDA #%00010000
    STA SID_V1_CTRL

    ; piccolo spazio tra note
    LDA #$04
    JSR wait_units

    INX
    CPX #$08
    BNE save_index
    LDX #$00

save_index:
    STX PAT_INDEX
    JMP main_loop

; Attende A unita di tempo
wait_units:
    TAY
wu_outer:
    LDX #$FF
wu_inner:
    DEX
    BNE wu_inner
    DEY
    BNE wu_outer
    RTS

; Scala semplice (valori indicativi)
notes_lo:
    .byte $11,$38,$61,$8B,$B8,$E8,$1B,$52
notes_hi:
    .byte $11,$12,$13,$14,$15,$16,$18,$19

note_len:
    .byte $18,$18,$18,$18,$18,$18,$18,$24
