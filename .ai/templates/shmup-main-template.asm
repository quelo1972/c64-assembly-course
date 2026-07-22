* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

; Template base per lezioni shoot 'em up (track 065+)

BORDER          = $D020
BG_COLOR        = $D021
JOYSTICK_PORT2  = $DC00

STATE_TITLE     = $00
STATE_PLAYING   = $01
STATE_GAME_OVER = $02

player_x        = $02
player_y        = $03
player_cooldown = $04
game_state      = $05
frame_counter   = $06

start:
    JSR init

main_loop:
    JSR wait_tick
    JSR read_input
    JSR update_game
    JSR render_game
    JSR play_audio
    JMP main_loop

init:
    LDA #$00
    STA BORDER
    STA BG_COLOR
    LDA #STATE_TITLE
    STA game_state
    RTS

wait_tick:
    ; Integrazione prevista: IRQ raster o timer CIA.
    RTS

read_input:
    ; Integrazione prevista: lettura joystick + gestione fire cooldown.
    RTS

update_game:
    LDA game_state
    CMP #STATE_TITLE
    BEQ update_title
    CMP #STATE_PLAYING
    BEQ update_playing
    CMP #STATE_GAME_OVER
    BEQ update_game_over
    RTS

update_title:
    RTS

update_playing:
    RTS

update_game_over:
    RTS

render_game:
    ; Integrazione prevista: sprite/hud.
    INC BORDER
    RTS

play_audio:
    ; Integrazione prevista: eventi SID.
    RTS
