* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0
; Lezione 044 - Mini scena: sprite animato + scrolling semplice


    .word 0


SPRITE0_X     = $D000
SPRITE0_Y     = $D001
SPRITE_EN     = $D015
SPRITE0_COLOR = $D027
SPRITE_PTR0   = $07F8
SCROLL_X      = $D016
SCREEN_RAM    = $0400

FRAME_COUNTER = $02
SPRITE_POS_X  = $03
SCROLL_BASE   = $04

SPRITE_FRAME0 = $2000
SPRITE_FRAME1 = $2040

start:
    ; sfondo tile minimale: due righe piene per percepire lo scorrimento
    LDX #$00
bg_fill:
    LDA #$51
    STA SCREEN_RAM,X
    STA SCREEN_RAM+40,X
    INX
    CPX #$28
    BNE bg_fill

    LDA #$01
    STA SPRITE_EN

    LDA #$50
    STA SPRITE0_Y

    LDA #$01
    STA SPRITE0_COLOR

    LDA #$40
    STA SPRITE_POS_X

main_loop:
    ; movimento sprite
    LDA SPRITE_POS_X
    CLC
    ADC #$01
    STA SPRITE_POS_X
    STA SPRITE0_X

    ; animazione 2 frame
    LDA FRAME_COUNTER
    AND #%00001000
    BEQ frame0

    LDA #(SPRITE_FRAME1 / 64)
    STA SPRITE_PTR0
    JMP scroll_step

frame0:
    LDA #(SPRITE_FRAME0 / 64)
    STA SPRITE_PTR0

scroll_step:
    ; scroll orizzontale fine (3 bit bassi), preservando gli altri bit di D016
    LDA SCROLL_X
    AND #%11111000
    STA SCROLL_BASE

    LDA FRAME_COUNTER
    AND #%00000111
    ORA SCROLL_BASE
    STA SCROLL_X

    INC FRAME_COUNTER
    JMP main_loop

* = SPRITE_FRAME0
    .byte $18,$3C,$7E,$FF,$FF,$7E,$3C,$18
    .fill 55, $00

* = SPRITE_FRAME1
    .byte $00,$18,$3C,$7E,$7E,$3C,$18,$00
    .fill 55, $00
