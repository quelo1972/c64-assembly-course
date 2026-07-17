; Lezione 062 - Main con moduli separati
*= $0801

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
