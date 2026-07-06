;========================================
; Lesson 008
; STA store accumulator
;========================================

* = $1000

    lda #$06       ; carica il valore 6 nell'accumulatore
    sta $d020      ; scrive il valore nel colore del bordo
    lda #$01       ; carica il valore 1 nell'accumulatore
    sta $d021      ; scrive il valore nel colore di sfondo
    rts
