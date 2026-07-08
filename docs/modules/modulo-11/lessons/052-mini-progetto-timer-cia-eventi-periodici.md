[🏠 Home](../../../index.md)

# Lezione 052 - Mini-progetto: timer CIA per eventi periodici

> **Obiettivo:** implementare un mini scheduler periodico con IRQ da CIA1 Timer A.

---

## 🎯 Obiettivi

- configurare CIA1 Timer A in modalita IRQ;
- installare una ISR custom con vettore IRQ RAM;
- generare tick periodici per logica di gioco/demo;
- mantenere main loop pulito e reattivo.

---

## 🧠 Introduzione

Questo mini-progetto chiude il modulo 11: costruiamo una base timing-driven dove il timer CIA produce tick costanti e la ISR aggiorna lo stato. E il passo naturale verso engine piu complessi.

---

## 📘 Teoria

Componenti del progetto:

1. setup vettore IRQ (`$0314/$0315`);
2. configurazione CIA1 timer A (`$DC04/$DC05/$DC0D/$DC0E`);
3. handler con save/restore registri;
4. acknowledge interrupt CIA leggendo ICR;
5. `RTI` per uscita corretta.

In questa versione usiamo un contatore tick per cambiare colore bordo a intervalli regolari.

---

## 🤖 Come ragiona il 6510

Il main loop non misura il tempo: reagisce a stato aggiornato dalla ISR. Questa separazione riduce coupling e rende piu stabile il frame logic rispetto a delay busy-wait sparsi.

---

## 💡 Esempio pratico

```asm
; Lezione 052 - CIA Timer A IRQ mini scheduler
*= $0801

IRQ_VEC_LO = $0314
IRQ_VEC_HI = $0315
CIA1_TA_LO = $DC04
CIA1_TA_HI = $DC05
CIA1_ICR   = $DC0D
CIA1_CRA   = $DC0E
BORDER     = $D020

TICK      = $02
DIVIDER   = $03

start:
    SEI

    ; setup IRQ vector
    LDA #<irq_handler
    STA IRQ_VEC_LO
    LDA #>irq_handler
    STA IRQ_VEC_HI

    ; stop timer A
    LDA #$00
    STA CIA1_CRA

    ; timer period (valore demo)
    LDA #$FF
    STA CIA1_TA_LO
    LDA #$30
    STA CIA1_TA_HI

    ; clear pending CIA interrupts
    LDA CIA1_ICR

    ; enable CIA1 timer A IRQ (bit7=1 set mask, bit0=timer A)
    LDA #%10000001
    STA CIA1_ICR

    ; start timer A continuous
    LDA #%00010001
    STA CIA1_CRA

    LDA #$00
    STA TICK
    STA DIVIDER

    CLI

main_loop:
    ; qui andrebbe la logica principale (input, update, render)
    JMP main_loop

irq_handler:
    PHA
    TXA
    PHA
    TYA
    PHA

    ; acknowledge CIA1 interrupt source
    LDA CIA1_ICR

    INC TICK
    INC DIVIDER

    LDA DIVIDER
    CMP #$10
    BNE irq_exit

    LDA #$00
    STA DIVIDER
    INC BORDER

irq_exit:
    PLA
    TAY
    PLA
    TAX
    PLA
    RTI
```

`CMP` confronta A con un valore e aggiorna i flag senza modificare A. Qui serve per eseguire un'azione solo ogni 16 tick.

---

## ⚠️ Errori comuni

- non abilitare la mask CIA corretta (`$DC0D`);
- usare `RTS` al posto di `RTI`;
- fare troppo lavoro in ISR e aumentare jitter/perdita eventi.

---

## 🧪 Esercizi

1. Sostituisci il cambio bordo con update di una posizione sprite.
2. Aggiungi un flag "tick_ready" letto dal main loop.
3. Implementa due task periodici con divisori diversi (es. 8 e 32 tick).

---

## 📌 Riassunto

| Blocco | Ruolo |
|--------|-------|
| CIA timer IRQ | base temporale periodica |
| ISR breve | update stato deterministico |
| main loop | logica non time-critical |

---

## 🔜 Preparazione alla lezione successiva

Nel modulo 12 useremo questa disciplina temporale anche per I/O su disco e seriale, dove robustezza e sincronizzazione diventano fondamentali.

---

## 🔎 Approfondimento - Dentro il 6510

Un sistema a tick permette di passare da codice "lineare" a codice "event-driven". Questo pattern e un mattone chiave per demo, giochi e player musicali stabili su C64.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
