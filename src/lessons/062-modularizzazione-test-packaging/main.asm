* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0

; Lezione 062 - Main con moduli separati

start:
    JSR mod_init

main_loop:
    JSR mod_input
    JSR mod_update
    JSR mod_render
    JMP main_loop

mod_init:
    RTS

mod_input:
    RTS

mod_update:
    RTS

mod_render:
    RTS
