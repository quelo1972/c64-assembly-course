;========================================
; Lesson 009
; Register transfer instructions
;========================================

* = $1000

    lda #$06       ; carica il valore 6 nell'accumulatore
    tax            ; copia A in X

    lda #$0a       ; carica il valore 10 nell'accumulatore
    tay            ; copia A in Y

    txa            ; copia X in A, A diventa 6
    tya            ; copia Y in A, A diventa 10

    rts
