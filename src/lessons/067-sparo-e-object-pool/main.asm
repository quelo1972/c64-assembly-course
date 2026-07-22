* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

; Lezione 067 - Sparo e object pool

BORDER          = $D020
BG_COLOR        = $D021
JOYSTICK_PORT2  = $DC00
SCREEN_BASE_LO  = <$0400
SCREEN_BASE_HI  = >$0400

STATE_TITLE     = $00
STATE_PLAYING   = $01
STATE_GAME_OVER = $02

MIN_X           = $01
MAX_X           = $26
MIN_Y           = $02
MAX_Y           = $16

player_x        = $02
player_y        = $03
fire_latch      = $04
game_state      = $05
frame_counter   = $06
player_prev_x   = $07
player_prev_y   = $08
ptr_lo          = $09
ptr_hi          = $0A
char_value      = $0B
color_value     = $0C

shot0_x         = $0D
shot1_x         = $0E
shot2_x         = $0F
shot3_x         = $10
shot0_y         = $11
shot1_y         = $12
shot2_y         = $13
shot3_y         = $14
shot0_active    = $15
shot1_active    = $16
shot2_active    = $17
shot3_active    = $18
shot0_prev_y    = $19
shot1_prev_y    = $1A
shot2_prev_y    = $1B
shot3_prev_y    = $1C

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
    STA fire_latch

    LDA #$14
    STA player_x
    STA player_prev_x

    LDA #$0C
    STA player_y
    STA player_prev_y

    LDA #STATE_TITLE
    STA game_state

    JSR reset_shots
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
    LDA fire_latch
    BNE movement_dispatch

    LDA #$01
    STA fire_latch

    LDA game_state
    CMP #STATE_TITLE
    BNE check_restart

    LDA #STATE_PLAYING
    STA game_state
    LDA #$00
    STA frame_counter
    JSR reset_shots
    JMP movement_dispatch

check_restart:
    CMP #STATE_GAME_OVER
    BNE try_fire_shot

    LDA #STATE_TITLE
    STA game_state
    LDA #$00
    STA frame_counter
    JSR reset_shots
    JMP movement_dispatch

try_fire_shot:
    CMP #STATE_PLAYING
    BNE movement_dispatch
    JSR spawn_shot
    JMP movement_dispatch

fire_released:
    LDA #$00
    STA fire_latch

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
    JSR update_shots
    RTS

update_game_over:
    RTS

update_shots:
    JSR update_shot0
    JSR update_shot1
    JSR update_shot2
    JSR update_shot3
    RTS

update_shot0:
    LDA shot0_active
    BEQ shot0_done
    LDA shot0_y
    CMP #MIN_Y
    BEQ shot0_deactivate
    DEC shot0_y
    JMP shot0_done
shot0_deactivate:
    LDA #$20
    STA char_value
    LDA #$01
    STA color_value
    LDX shot0_x
    LDY shot0_y
    JSR draw_cell
    LDA #$00
    STA shot0_active
shot0_done:
    RTS

update_shot1:
    LDA shot1_active
    BEQ shot1_done
    LDA shot1_y
    CMP #MIN_Y
    BEQ shot1_deactivate
    DEC shot1_y
    JMP shot1_done
shot1_deactivate:
    LDA #$20
    STA char_value
    LDA #$01
    STA color_value
    LDX shot1_x
    LDY shot1_y
    JSR draw_cell
    LDA #$00
    STA shot1_active
shot1_done:
    RTS

update_shot2:
    LDA shot2_active
    BEQ shot2_done
    LDA shot2_y
    CMP #MIN_Y
    BEQ shot2_deactivate
    DEC shot2_y
    JMP shot2_done
shot2_deactivate:
    LDA #$20
    STA char_value
    LDA #$01
    STA color_value
    LDX shot2_x
    LDY shot2_y
    JSR draw_cell
    LDA #$00
    STA shot2_active
shot2_done:
    RTS

update_shot3:
    LDA shot3_active
    BEQ shot3_done
    LDA shot3_y
    CMP #MIN_Y
    BEQ shot3_deactivate
    DEC shot3_y
    JMP shot3_done
shot3_deactivate:
    LDA #$20
    STA char_value
    LDA #$01
    STA color_value
    LDX shot3_x
    LDY shot3_y
    JSR draw_cell
    LDA #$00
    STA shot3_active
shot3_done:
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

    JSR render_shots
    RTS

render_game_over:
    LDA #$02
    STA BORDER
    LDA #$00
    STA BG_COLOR
    RTS

render_shots:
    JSR render_shot0
    JSR render_shot1
    JSR render_shot2
    JSR render_shot3
    RTS

render_shot0:
    LDA shot0_active
    BEQ render_shot0_done

    LDA #$20
    STA char_value
    LDA #$01
    STA color_value
    LDX shot0_x
    LDY shot0_prev_y
    JSR draw_cell

    LDA #$2A
    STA char_value
    LDA #$07
    STA color_value
    LDX shot0_x
    LDY shot0_y
    JSR draw_cell

    LDA shot0_y
    STA shot0_prev_y
render_shot0_done:
    RTS

render_shot1:
    LDA shot1_active
    BEQ render_shot1_done

    LDA #$20
    STA char_value
    LDA #$01
    STA color_value
    LDX shot1_x
    LDY shot1_prev_y
    JSR draw_cell

    LDA #$2A
    STA char_value
    LDA #$07
    STA color_value
    LDX shot1_x
    LDY shot1_y
    JSR draw_cell

    LDA shot1_y
    STA shot1_prev_y
render_shot1_done:
    RTS

render_shot2:
    LDA shot2_active
    BEQ render_shot2_done

    LDA #$20
    STA char_value
    LDA #$01
    STA color_value
    LDX shot2_x
    LDY shot2_prev_y
    JSR draw_cell

    LDA #$2A
    STA char_value
    LDA #$07
    STA color_value
    LDX shot2_x
    LDY shot2_y
    JSR draw_cell

    LDA shot2_y
    STA shot2_prev_y
render_shot2_done:
    RTS

render_shot3:
    LDA shot3_active
    BEQ render_shot3_done

    LDA #$20
    STA char_value
    LDA #$01
    STA color_value
    LDX shot3_x
    LDY shot3_prev_y
    JSR draw_cell

    LDA #$2A
    STA char_value
    LDA #$07
    STA color_value
    LDX shot3_x
    LDY shot3_y
    JSR draw_cell

    LDA shot3_y
    STA shot3_prev_y
render_shot3_done:
    RTS

spawn_shot:
    LDA player_y
    CMP #MIN_Y
    BEQ spawn_done

    LDA shot0_active
    BEQ spawn_shot0
    LDA shot1_active
    BEQ spawn_shot1
    LDA shot2_active
    BEQ spawn_shot2
    LDA shot3_active
    BEQ spawn_shot3
    JMP spawn_done

spawn_shot0:
    JSR init_shot0
    JMP spawn_done
spawn_shot1:
    JSR init_shot1
    JMP spawn_done
spawn_shot2:
    JSR init_shot2
    JMP spawn_done
spawn_shot3:
    JSR init_shot3

spawn_done:
    RTS

init_shot0:
    LDA player_x
    STA shot0_x
    LDA player_y
    SEC
    SBC #$01
    STA shot0_y
    STA shot0_prev_y
    LDA #$01
    STA shot0_active
    RTS

init_shot1:
    LDA player_x
    STA shot1_x
    LDA player_y
    SEC
    SBC #$01
    STA shot1_y
    STA shot1_prev_y
    LDA #$01
    STA shot1_active
    RTS

init_shot2:
    LDA player_x
    STA shot2_x
    LDA player_y
    SEC
    SBC #$01
    STA shot2_y
    STA shot2_prev_y
    LDA #$01
    STA shot2_active
    RTS

init_shot3:
    LDA player_x
    STA shot3_x
    LDA player_y
    SEC
    SBC #$01
    STA shot3_y
    STA shot3_prev_y
    LDA #$01
    STA shot3_active
    RTS

reset_shots:
    LDA #$00
    STA shot0_active
    STA shot1_active
    STA shot2_active
    STA shot3_active
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
