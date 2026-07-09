;========================================
; Lesson 007
; LDA immediate addressing
;========================================

* = $1000

    lda #$0a       ; carica il valore 10 nell'accumulatore
    sta $d020      ; scrive il valore nel colore del bordo
    lda #$00       ; carica il valore 0 nell'accumulatore
    sta $d021      ; scrive il valore nel colore di sfondo
    rts
