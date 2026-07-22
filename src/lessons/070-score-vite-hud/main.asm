* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

; Lezione 070 - Score, vite e HUD

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

enemy0_x        = $1D
enemy1_x        = $1E
enemy2_x        = $1F
enemy0_y        = $20
enemy1_y        = $21
enemy2_y        = $22
enemy0_active   = $23
enemy1_active   = $24
enemy2_active   = $25
enemy0_prev_y   = $26
enemy1_prev_y   = $27
enemy2_prev_y   = $28
enemy0_dir      = $29
enemy1_dir      = $2A
enemy2_dir      = $2B
spawn_timer     = $2C
player_lives    = $2D
invuln_timer    = $2E
score_units     = $2F
score_tens      = $30

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
    STA spawn_timer
    STA invuln_timer
    STA score_units
    STA score_tens

    LDA #$03
    STA player_lives

    LDA #$14
    STA player_x
    STA player_prev_x

    LDA #$0C
    STA player_y
    STA player_prev_y

    LDA #STATE_TITLE
    STA game_state

    JSR reset_shots
    JSR reset_enemies
    RTS

wait_tick:
wait_raster_top:
    LDA $D012
    BNE wait_raster_top
wait_raster_leave_top:
    LDA $D012
    BEQ wait_raster_leave_top
    INC frame_counter
    INC spawn_timer
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
    STA spawn_timer
    LDA #$03
    STA player_lives
    LDA #$00
    STA invuln_timer
    STA score_units
    STA score_tens
    JSR reset_shots
    JSR reset_enemies
    JMP movement_dispatch
check_restart:
    CMP #STATE_GAME_OVER
    BNE try_fire_shot
    LDA #STATE_TITLE
    STA game_state
    LDA #$00
    STA frame_counter
    STA spawn_timer
    LDA #$03
    STA player_lives
    LDA #$00
    STA invuln_timer
    STA score_units
    STA score_tens
    JSR reset_shots
    JSR reset_enemies
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
    LDA invuln_timer
    BEQ invuln_done
    DEC invuln_timer
invuln_done:
    JSR tick_score
    JSR update_shots
    JSR maybe_spawn_enemy
    JSR update_enemies
    JSR check_shot_enemy_collisions
    JSR check_player_enemy_collision
    RTS

update_game_over:
    RTS

check_player_enemy_collision:
    LDA invuln_timer
    BNE player_collision_done
    JSR check_player_vs_enemy0
    JSR check_player_vs_enemy1
    JSR check_player_vs_enemy2
player_collision_done:
    RTS

check_player_vs_enemy0:
    LDA enemy0_active
    BEQ player_enemy0_done
    LDA player_x
    CMP enemy0_x
    BNE player_enemy0_done
    LDA player_y
    CMP enemy0_y
    BNE player_enemy0_done
    JSR damage_player
    LDA #$00
    STA enemy0_active
player_enemy0_done:
    RTS

check_player_vs_enemy1:
    LDA enemy1_active
    BEQ player_enemy1_done
    LDA player_x
    CMP enemy1_x
    BNE player_enemy1_done
    LDA player_y
    CMP enemy1_y
    BNE player_enemy1_done
    JSR damage_player
    LDA #$00
    STA enemy1_active
player_enemy1_done:
    RTS

check_player_vs_enemy2:
    LDA enemy2_active
    BEQ player_enemy2_done
    LDA player_x
    CMP enemy2_x
    BNE player_enemy2_done
    LDA player_y
    CMP enemy2_y
    BNE player_enemy2_done
    JSR damage_player
    LDA #$00
    STA enemy2_active
player_enemy2_done:
    RTS

damage_player:
    LDA player_lives
    BEQ damage_done
    DEC player_lives
    LDA #$18
    STA invuln_timer
    LDA player_lives
    BNE damage_done
    LDA #STATE_GAME_OVER
    STA game_state
damage_done:
    RTS

check_shot_enemy_collisions:
    JSR check_shot0_hits
    JSR check_shot1_hits
    JSR check_shot2_hits
    JSR check_shot3_hits
    RTS

check_shot0_hits:
    LDA shot0_active
    BEQ shot0_hits_done
    JSR shot0_vs_enemy0
    JSR shot0_vs_enemy1
    JSR shot0_vs_enemy2
shot0_hits_done:
    RTS

shot0_vs_enemy0:
    LDA shot0_active
    BEQ shot0e0_done
    LDA enemy0_active
    BEQ shot0e0_done
    LDA shot0_x
    CMP enemy0_x
    BNE shot0e0_done
    LDA shot0_y
    CMP enemy0_y
    BNE shot0e0_done
    LDA #$00
    STA shot0_active
    STA enemy0_active
shot0e0_done:
    RTS

shot0_vs_enemy1:
    LDA shot0_active
    BEQ shot0e1_done
    LDA enemy1_active
    BEQ shot0e1_done
    LDA shot0_x
    CMP enemy1_x
    BNE shot0e1_done
    LDA shot0_y
    CMP enemy1_y
    BNE shot0e1_done
    LDA #$00
    STA shot0_active
    STA enemy1_active
shot0e1_done:
    RTS

shot0_vs_enemy2:
    LDA shot0_active
    BEQ shot0e2_done
    LDA enemy2_active
    BEQ shot0e2_done
    LDA shot0_x
    CMP enemy2_x
    BNE shot0e2_done
    LDA shot0_y
    CMP enemy2_y
    BNE shot0e2_done
    LDA #$00
    STA shot0_active
    STA enemy2_active
shot0e2_done:
    RTS

check_shot1_hits:
    LDA shot1_active
    BEQ shot1_hits_done
    JSR shot1_vs_enemy0
    JSR shot1_vs_enemy1
    JSR shot1_vs_enemy2
shot1_hits_done:
    RTS

shot1_vs_enemy0:
    LDA shot1_active
    BEQ shot1e0_done
    LDA enemy0_active
    BEQ shot1e0_done
    LDA shot1_x
    CMP enemy0_x
    BNE shot1e0_done
    LDA shot1_y
    CMP enemy0_y
    BNE shot1e0_done
    LDA #$00
    STA shot1_active
    STA enemy0_active
shot1e0_done:
    RTS

shot1_vs_enemy1:
    LDA shot1_active
    BEQ shot1e1_done
    LDA enemy1_active
    BEQ shot1e1_done
    LDA shot1_x
    CMP enemy1_x
    BNE shot1e1_done
    LDA shot1_y
    CMP enemy1_y
    BNE shot1e1_done
    LDA #$00
    STA shot1_active
    STA enemy1_active
shot1e1_done:
    RTS

shot1_vs_enemy2:
    LDA shot1_active
    BEQ shot1e2_done
    LDA enemy2_active
    BEQ shot1e2_done
    LDA shot1_x
    CMP enemy2_x
    BNE shot1e2_done
    LDA shot1_y
    CMP enemy2_y
    BNE shot1e2_done
    LDA #$00
    STA shot1_active
    STA enemy2_active
shot1e2_done:
    RTS

check_shot2_hits:
    LDA shot2_active
    BEQ shot2_hits_done
    JSR shot2_vs_enemy0
    JSR shot2_vs_enemy1
    JSR shot2_vs_enemy2
shot2_hits_done:
    RTS

shot2_vs_enemy0:
    LDA shot2_active
    BEQ shot2e0_done
    LDA enemy0_active
    BEQ shot2e0_done
    LDA shot2_x
    CMP enemy0_x
    BNE shot2e0_done
    LDA shot2_y
    CMP enemy0_y
    BNE shot2e0_done
    LDA #$00
    STA shot2_active
    STA enemy0_active
shot2e0_done:
    RTS

shot2_vs_enemy1:
    LDA shot2_active
    BEQ shot2e1_done
    LDA enemy1_active
    BEQ shot2e1_done
    LDA shot2_x
    CMP enemy1_x
    BNE shot2e1_done
    LDA shot2_y
    CMP enemy1_y
    BNE shot2e1_done
    LDA #$00
    STA shot2_active
    STA enemy1_active
shot2e1_done:
    RTS

shot2_vs_enemy2:
    LDA shot2_active
    BEQ shot2e2_done
    LDA enemy2_active
    BEQ shot2e2_done
    LDA shot2_x
    CMP enemy2_x
    BNE shot2e2_done
    LDA shot2_y
    CMP enemy2_y
    BNE shot2e2_done
    LDA #$00
    STA shot2_active
    STA enemy2_active
shot2e2_done:
    RTS

check_shot3_hits:
    LDA shot3_active
    BEQ shot3_hits_done
    JSR shot3_vs_enemy0
    JSR shot3_vs_enemy1
    JSR shot3_vs_enemy2
shot3_hits_done:
    RTS

shot3_vs_enemy0:
    LDA shot3_active
    BEQ shot3e0_done
    LDA enemy0_active
    BEQ shot3e0_done
    LDA shot3_x
    CMP enemy0_x
    BNE shot3e0_done
    LDA shot3_y
    CMP enemy0_y
    BNE shot3e0_done
    LDA #$00
    STA shot3_active
    STA enemy0_active
shot3e0_done:
    RTS

shot3_vs_enemy1:
    LDA shot3_active
    BEQ shot3e1_done
    LDA enemy1_active
    BEQ shot3e1_done
    LDA shot3_x
    CMP enemy1_x
    BNE shot3e1_done
    LDA shot3_y
    CMP enemy1_y
    BNE shot3e1_done
    LDA #$00
    STA shot3_active
    STA enemy1_active
shot3e1_done:
    RTS

shot3_vs_enemy2:
    LDA shot3_active
    BEQ shot3e2_done
    LDA enemy2_active
    BEQ shot3e2_done
    LDA shot3_x
    CMP enemy2_x
    BNE shot3e2_done
    LDA shot3_y
    CMP enemy2_y
    BNE shot3e2_done
    LDA #$00
    STA shot3_active
    STA enemy2_active
shot3e2_done:
    RTS

; Enemy and shot movement/render routines from 068 reused.
maybe_spawn_enemy:
    LDA spawn_timer
    AND #$1F
    BNE spawn_done
    LDA enemy0_active
    BEQ spawn_enemy0
    LDA enemy1_active
    BEQ spawn_enemy1
    LDA enemy2_active
    BEQ spawn_enemy2
    RTS
spawn_enemy0:
    JSR init_enemy0
    JMP spawn_done
spawn_enemy1:
    JSR init_enemy1
    JMP spawn_done
spawn_enemy2:
    JSR init_enemy2
spawn_done:
    RTS

init_enemy0:
    LDA #$06
    STA enemy0_x
    LDA #MIN_Y
    STA enemy0_y
    STA enemy0_prev_y
    LDA #$01
    STA enemy0_active
    LDA #$01
    STA enemy0_dir
    RTS
init_enemy1:
    LDA #$14
    STA enemy1_x
    LDA #MIN_Y
    STA enemy1_y
    STA enemy1_prev_y
    LDA #$01
    STA enemy1_active
    LDA #$00
    STA enemy1_dir
    RTS
init_enemy2:
    LDA #$22
    STA enemy2_x
    LDA #MIN_Y
    STA enemy2_y
    STA enemy2_prev_y
    LDA #$01
    STA enemy2_active
    LDA #$01
    STA enemy2_dir
    RTS

update_enemies:
    JSR update_enemy0
    JSR update_enemy1
    JSR update_enemy2
    RTS
update_enemy0:
    LDA enemy0_active
    BEQ enemy0_done
    JSR move_enemy0
enemy0_done:
    RTS
update_enemy1:
    LDA enemy1_active
    BEQ enemy1_done
    JSR move_enemy1
enemy1_done:
    RTS
update_enemy2:
    LDA enemy2_active
    BEQ enemy2_done
    JSR move_enemy2
enemy2_done:
    RTS

move_enemy0:
    LDA frame_counter
    AND #$01
    BNE enemy0_check_bottom
    INC enemy0_y
enemy0_check_bottom:
    LDA enemy0_y
    CMP #MAX_Y
    BCC enemy0_horizontal
    BEQ enemy0_deactivate
    JMP enemy0_horizontal
enemy0_deactivate:
    LDA #$20
    STA char_value
    LDA #$01
    STA color_value
    LDX enemy0_x
    LDY enemy0_y
    JSR draw_cell
    LDA #$00
    STA enemy0_active
    RTS
enemy0_horizontal:
    LDA frame_counter
    AND #$03
    BNE enemy0_done_move
    LDA enemy0_dir
    BEQ enemy0_go_left
enemy0_go_right:
    LDA enemy0_x
    CMP #MAX_X
    BNE enemy0_inc
    LDA #$00
    STA enemy0_dir
    JMP enemy0_done_move
enemy0_inc:
    INC enemy0_x
    JMP enemy0_done_move
enemy0_go_left:
    LDA enemy0_x
    CMP #MIN_X
    BNE enemy0_dec
    LDA #$01
    STA enemy0_dir
    JMP enemy0_done_move
enemy0_dec:
    DEC enemy0_x
enemy0_done_move:
    RTS

move_enemy1:
    LDA frame_counter
    AND #$01
    BNE enemy1_check_bottom
    INC enemy1_y
enemy1_check_bottom:
    LDA enemy1_y
    CMP #MAX_Y
    BCC enemy1_horizontal
    BEQ enemy1_deactivate
    JMP enemy1_horizontal
enemy1_deactivate:
    LDA #$20
    STA char_value
    LDA #$01
    STA color_value
    LDX enemy1_x
    LDY enemy1_y
    JSR draw_cell
    LDA #$00
    STA enemy1_active
    RTS
enemy1_horizontal:
    LDA frame_counter
    AND #$03
    BNE enemy1_done_move
    LDA enemy1_dir
    BEQ enemy1_go_left
enemy1_go_right:
    LDA enemy1_x
    CMP #MAX_X
    BNE enemy1_inc
    LDA #$00
    STA enemy1_dir
    JMP enemy1_done_move
enemy1_inc:
    INC enemy1_x
    JMP enemy1_done_move
enemy1_go_left:
    LDA enemy1_x
    CMP #MIN_X
    BNE enemy1_dec
    LDA #$01
    STA enemy1_dir
    JMP enemy1_done_move
enemy1_dec:
    DEC enemy1_x
enemy1_done_move:
    RTS

move_enemy2:
    LDA frame_counter
    AND #$01
    BNE enemy2_check_bottom
    INC enemy2_y
enemy2_check_bottom:
    LDA enemy2_y
    CMP #MAX_Y
    BCC enemy2_horizontal
    BEQ enemy2_deactivate
    JMP enemy2_horizontal
enemy2_deactivate:
    LDA #$20
    STA char_value
    LDA #$01
    STA color_value
    LDX enemy2_x
    LDY enemy2_y
    JSR draw_cell
    LDA #$00
    STA enemy2_active
    RTS
enemy2_horizontal:
    LDA frame_counter
    AND #$03
    BNE enemy2_done_move
    LDA enemy2_dir
    BEQ enemy2_go_left
enemy2_go_right:
    LDA enemy2_x
    CMP #MAX_X
    BNE enemy2_inc
    LDA #$00
    STA enemy2_dir
    JMP enemy2_done_move
enemy2_inc:
    INC enemy2_x
    JMP enemy2_done_move
enemy2_go_left:
    LDA enemy2_x
    CMP #MIN_X
    BNE enemy2_dec
    LDA #$01
    STA enemy2_dir
    JMP enemy2_done_move
enemy2_dec:
    DEC enemy2_x
enemy2_done_move:
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
    JSR render_hud
    RTS
render_playing:
    LDA invuln_timer
    AND #$02
    BEQ border_normal
    LDA #$07
    STA BORDER
    JMP border_done
border_normal:
    LDA #$00
    STA BORDER
border_done:
    LDA #$00
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
    JSR render_enemies
    JSR render_hud
    RTS
render_game_over:
    LDA #$02
    STA BORDER
    LDA #$00
    STA BG_COLOR
    JSR render_hud
    RTS

tick_score:
    LDA frame_counter
    AND #$07
    BNE tick_score_done

    INC score_units
    LDA score_units
    CMP #$0A
    BCC tick_score_done

    LDA #$00
    STA score_units
    INC score_tens
    LDA score_tens
    CMP #$0A
    BCC tick_score_done
    LDA #$09
    STA score_tens

tick_score_done:
    RTS

render_hud:
    ; S
    LDA #$53
    STA char_value
    LDA #$01
    STA color_value
    LDX #$00
    LDY #$00
    JSR draw_cell

    ; score tens
    LDA score_tens
    JSR hud_digit_to_char
    LDA #$01
    STA color_value
    LDX #$01
    LDY #$00
    JSR draw_cell

    ; score units
    LDA score_units
    JSR hud_digit_to_char
    LDA #$01
    STA color_value
    LDX #$02
    LDY #$00
    JSR draw_cell

    ; L
    LDA #$4C
    STA char_value
    LDA #$01
    STA color_value
    LDX #$05
    LDY #$00
    JSR draw_cell

    ; lives
    LDA player_lives
    JSR hud_digit_to_char
    LDA #$01
    STA color_value
    LDX #$06
    LDY #$00
    JSR draw_cell

    ; state marker
    LDA game_state
    CMP #STATE_TITLE
    BEQ hud_state_title
    CMP #STATE_PLAYING
    BEQ hud_state_playing
    LDA #$47
    JMP hud_state_draw

hud_state_title:
    LDA #$54
    JMP hud_state_draw

hud_state_playing:
    LDA #$50

hud_state_draw:
    STA char_value
    LDA #$01
    STA color_value
    LDX #$0A
    LDY #$00
    JSR draw_cell
    RTS

hud_digit_to_char:
    CLC
    ADC #$30
    STA char_value
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

render_enemies:
    JSR render_enemy0
    JSR render_enemy1
    JSR render_enemy2
    RTS
render_enemy0:
    LDA enemy0_active
    BEQ render_enemy0_done
    LDA #$20
    STA char_value
    LDA #$01
    STA color_value
    LDX enemy0_x
    LDY enemy0_prev_y
    JSR draw_cell
    LDA #$45
    STA char_value
    LDA #$02
    STA color_value
    LDX enemy0_x
    LDY enemy0_y
    JSR draw_cell
    LDA enemy0_y
    STA enemy0_prev_y
render_enemy0_done:
    RTS
render_enemy1:
    LDA enemy1_active
    BEQ render_enemy1_done
    LDA #$20
    STA char_value
    LDA #$01
    STA color_value
    LDX enemy1_x
    LDY enemy1_prev_y
    JSR draw_cell
    LDA #$45
    STA char_value
    LDA #$02
    STA color_value
    LDX enemy1_x
    LDY enemy1_y
    JSR draw_cell
    LDA enemy1_y
    STA enemy1_prev_y
render_enemy1_done:
    RTS
render_enemy2:
    LDA enemy2_active
    BEQ render_enemy2_done
    LDA #$20
    STA char_value
    LDA #$01
    STA color_value
    LDX enemy2_x
    LDY enemy2_prev_y
    JSR draw_cell
    LDA #$45
    STA char_value
    LDA #$02
    STA color_value
    LDX enemy2_x
    LDY enemy2_y
    JSR draw_cell
    LDA enemy2_y
    STA enemy2_prev_y
render_enemy2_done:
    RTS

spawn_shot:
    LDA player_y
    CMP #MIN_Y
    BEQ spawn_shot_done
    LDA shot0_active
    BEQ spawn_shot0
    LDA shot1_active
    BEQ spawn_shot1
    LDA shot2_active
    BEQ spawn_shot2
    LDA shot3_active
    BEQ spawn_shot3
    JMP spawn_shot_done
spawn_shot0:
    JSR init_shot0
    JMP spawn_shot_done
spawn_shot1:
    JSR init_shot1
    JMP spawn_shot_done
spawn_shot2:
    JSR init_shot2
    JMP spawn_shot_done
spawn_shot3:
    JSR init_shot3
spawn_shot_done:
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

reset_enemies:
    LDA #$00
    STA enemy0_active
    STA enemy1_active
    STA enemy2_active
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
    RTS
