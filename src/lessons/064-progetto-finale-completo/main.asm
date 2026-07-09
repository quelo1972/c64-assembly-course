; Lezione 064 - Skeleton finale integrato
*= $0801

BORDER = $D020

start:
    JSR init

main_loop:
    JSR input_step
    JSR update_step
    JSR render_step
    JSR audio_step
    JMP main_loop

init:
    LDA #$00
    STA BORDER
    RTS

input_step:
    RTS

update_step:
    RTS

render_step:
    INC BORDER
    RTS

audio_step:
    RTS
