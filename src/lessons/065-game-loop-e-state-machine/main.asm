* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

; Lezione 065 - Game loop e state machine

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
    STA frame_counter
    STA player_cooldown
    LDA #STATE_TITLE
    STA game_state
    RTS

wait_tick:
wait_raster_top:
    LDA $D012
    BNE wait_raster_top

wait_raster_leave_top:
    LDA $D012
    BEQ wait_raster_leave_top

    INC frame_counter
    RTS

read_input:
    ; Joystick port 2: FIRE e' attivo basso (bit 4 = 0 quando premuto).
    LDA JOYSTICK_PORT2
    AND #$10
    BNE fire_released

fire_pressed:
    LDA player_cooldown
    BNE input_done

    LDA #$01
    STA player_cooldown

    LDA game_state
    CMP #STATE_TITLE
    BNE check_restart

    LDA #STATE_PLAYING
    STA game_state
    LDA #$00
    STA frame_counter
    JMP input_done

check_restart:
    CMP #STATE_GAME_OVER
    BNE input_done

    LDA #STATE_TITLE
    STA game_state
    LDA #$00
    STA frame_counter
    JMP input_done

fire_released:
    LDA #$00
    STA player_cooldown

input_done:
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
    ; Demo state flow: dopo alcuni secondi passa a GAME OVER.
    LDA frame_counter
    CMP #$C8
    BCC playing_done

    LDA #STATE_GAME_OVER
    STA game_state
    LDA #$00
    STA frame_counter

playing_done:
    RTS

update_game_over:
    ; Nessuna logica di gioco: solo attesa restart via FIRE.
    RTS

render_game:
    LDA game_state
    CMP #STATE_TITLE
    BEQ render_title
    CMP #STATE_PLAYING
    BEQ render_playing
    CMP #STATE_GAME_OVER
    BEQ render_game_over
    RTS

render_title:
    LDA #$06
    STA BORDER
    LDA #$00
    STA BG_COLOR
    RTS

render_playing:
    LDA frame_counter
    AND #$0F
    STA BORDER
    LDA #$00
    STA BG_COLOR
    RTS

render_game_over:
    LDA frame_counter
    AND #$10
    BEQ game_over_dark

    LDA #$02
    STA BORDER
    LDA #$06
    STA BG_COLOR
    RTS

game_over_dark:
    LDA #$00
    STA BORDER
    LDA #$00
    STA BG_COLOR
    RTS

play_audio:
    ; TODO: eventi SID.
    RTS
