* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

; Lezione 066 - Player input e movimento

BORDER          = $D020
BG_COLOR        = $D021
JOYSTICK_PORT2  = $DC00
SCREEN_BASE_LO  = <$0400
SCREEN_BASE_HI  = >$0400
COLOR_BASE_LO   = <$D800
COLOR_BASE_HI   = >$D800

STATE_TITLE     = $00
STATE_PLAYING   = $01
STATE_GAME_OVER = $02

MIN_X           = $01
MAX_X           = $26
MIN_Y           = $02
MAX_Y           = $16

player_x        = $02
player_y        = $03
player_cooldown = $04
game_state      = $05
frame_counter   = $06
player_prev_x   = $07
player_prev_y   = $08
ptr_lo          = $09
ptr_hi          = $0A
char_value      = $0B
color_value     = $0C

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

    LDA #$14
    STA player_x
    STA player_prev_x

    LDA #$0C
    STA player_y
    STA player_prev_y

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
    LDA JOYSTICK_PORT2
    AND #$10
    BNE fire_released

fire_pressed:
    LDA player_cooldown
    BNE movement_dispatch

    LDA #$01
    STA player_cooldown

    LDA game_state
    CMP #STATE_TITLE
    BNE check_restart

    LDA #STATE_PLAYING
    STA game_state
    LDA #$00
    STA frame_counter
    JMP movement_dispatch

check_restart:
    CMP #STATE_GAME_OVER
    BNE movement_dispatch

    LDA #STATE_TITLE
    STA game_state
    LDA #$00
    STA frame_counter
    JMP movement_dispatch

fire_released:
    LDA #$00
    STA player_cooldown

movement_dispatch:
    LDA game_state
    CMP #STATE_PLAYING
    BNE input_done

    LDA JOYSTICK_PORT2
    AND #%00000100
    BNE check_right

    LDA player_x
    CMP #MIN_X
    BEQ check_right
    DEC player_x

check_right:
    LDA JOYSTICK_PORT2
    AND #%00001000
    BNE check_up

    LDA player_x
    CMP #MAX_X
    BEQ check_up
    INC player_x

check_up:
    LDA JOYSTICK_PORT2
    AND #%00000001
    BNE check_down

    LDA player_y
    CMP #MIN_Y
    BEQ check_down
    DEC player_y

check_down:
    LDA JOYSTICK_PORT2
    AND #%00000010
    BNE input_done

    LDA player_y
    CMP #MAX_Y
    BEQ input_done
    INC player_y

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
    ; In questa lezione rimaniamo nello stato PLAYING per testare il movimento.
    RTS

update_game_over:
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
    LDA #$00
    STA BORDER
    STA BG_COLOR

    LDA #$20
    STA char_value
    LDA #$01
    STA color_value
    LDX player_prev_x
    LDY player_prev_y
    JSR draw_cell

    LDA #$51
    STA char_value
    LDA #$01
    STA color_value
    LDX player_x
    LDY player_y
    JSR draw_cell

    LDA player_x
    STA player_prev_x
    LDA player_y
    STA player_prev_y
    RTS

render_game_over:
    LDA #$02
    STA BORDER
    LDA #$00
    STA BG_COLOR
    RTS

draw_cell:
    JSR compute_cell_ptr

    LDY #$00
    LDA char_value
    STA (ptr_lo),Y

    CLC
    LDA ptr_lo
    ADC #<( $D800 - $0400 )
    STA ptr_lo
    LDA ptr_hi
    ADC #>( $D800 - $0400 )
    STA ptr_hi

    LDA color_value
    STA (ptr_lo),Y
    RTS

compute_cell_ptr:
    LDA #SCREEN_BASE_LO
    STA ptr_lo
    LDA #SCREEN_BASE_HI
    STA ptr_hi

    TYA
    BEQ add_x_offset

add_row_loop:
    CLC
    LDA ptr_lo
    ADC #$28
    STA ptr_lo
    LDA ptr_hi
    ADC #$00
    STA ptr_hi
    DEY
    BNE add_row_loop

add_x_offset:
    TXA
    CLC
    ADC ptr_lo
    STA ptr_lo
    BCC ptr_done
    INC ptr_hi

ptr_done:
    RTS

play_audio:
    ; TODO: eventi SID.
    RTS
