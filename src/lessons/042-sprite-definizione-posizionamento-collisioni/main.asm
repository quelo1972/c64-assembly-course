; Lezione 042 - Sprite 0 base + collision flag read
*= $0801

SPRITE0_X      = $D000
SPRITE0_Y      = $D001
SPRITE1_X      = $D002
SPRITE1_Y      = $D003
SPRITE_ENABLE  = $D015
SPRITE0_COLOR  = $D027
SPRITE1_COLOR  = $D028
SPRITE_COLL    = $D01E
SPRITE_PTR0    = $07F8
SPRITE_PTR1    = $07F9
BORDER         = $D020

SPRITE_DATA    = $2000

start:
    LDA #$80
    STA SPRITE0_X
    LDA #$60
    STA SPRITE0_Y

    ; sprite 1 quasi sovrapposto allo sprite 0 per forzare collisione
    LDA #$88
    STA SPRITE1_X
    LDA #$60
    STA SPRITE1_Y

    LDA #%00000011
    STA SPRITE_ENABLE  ; abilita sprite 0 e sprite 1

    LDA #$01
    STA SPRITE0_COLOR
    LDA #$07
    STA SPRITE1_COLOR

    LDA #(SPRITE_DATA / 64)
    STA SPRITE_PTR0
    STA SPRITE_PTR1

loop:
    LDA SPRITE_COLL
    AND #%00000011     ; bit sprite 0 o 1 coinvolti in collisione
    BEQ no_coll

    LDA #$02
    STA BORDER         ; rosso se collisione
    RTS

no_coll:
    LDA #$06
    STA BORDER         ; blu se nessuna collisione
    RTS

* = SPRITE_DATA
    .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    .byte $FF,$00,$00,$00,$00,$00,$00,$00,$FF
    .byte $FF,$00,$FF,$FF,$FF,$FF,$FF,$00,$FF
    .byte $FF,$00,$FF,$00,$00,$00,$FF,$00,$FF
    .byte $FF,$00,$FF,$FF,$FF,$FF,$FF,$00,$FF
    .byte $FF,$00,$00,$00,$00,$00,$00,$00,$FF
    .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
