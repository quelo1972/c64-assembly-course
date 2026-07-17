* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0
; Lezione 016 — Subroutine: JSR e RTS
; Chiama una subroutine per stampare caratteri


    .word 0


; Nota: JSR indirizzo salta a una subroutine, salva PC sullo stack.
; Nota: RTS rientra al chiamante usando lo stack.
; Nota: PHA salva A sullo stack; PLA ripristina.

main:
  LDA #$42       ; 'B'
  JSR print_char
  
  LDA #$05       ; colore verde
  JSR set_border
  
  RTS            ; fine programma

; Subroutine: stampa il carattere in A
print_char:
  PHA            ; salva A
  STA $0400      ; scrivi nella screen RAM
  PLA            ; ripristina A
  RTS

; Subroutine: setta il colore bordo (A contiene il colore)
set_border:
  PHA
  STA $D020      ; scrivi nel registro VIC-II
  PLA
  RTS
