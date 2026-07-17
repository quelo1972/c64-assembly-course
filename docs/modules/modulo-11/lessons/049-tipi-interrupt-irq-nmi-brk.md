[🏠 Home](../../../index.md)

# Lezione 049 - Tipi di interrupt: IRQ, NMI e BRK

> **Obiettivo:** distinguere chiaramente IRQ, NMI e BRK nel contesto del C64 e capire come influenzano il flusso del 6510.

---

## 🎯 Obiettivi

- capire la differenza tra interrupt mascherabili e non mascherabili;
- riconoscere ruolo di IRQ, NMI e BRK;
- introdurre i vettori interrupt usati dal C64;
- osservare una base di handler con `RTI`.

---

## 🧠 Introduzione

Un interrupt interrompe temporaneamente il programma corrente, esegue una routine specifica (handler), poi torna al punto precedente.

Nel C64 i tre casi fondamentali sono:

- **IRQ**: interrupt mascherabile (puo essere disabilitato con flag I);
- **NMI**: interrupt non mascherabile (non bloccato da `SEI`);
- **BRK**: software interrupt generato da istruzione.

---

## 📘 Teoria

### IRQ

- origine tipica: VIC-II (raster), CIA timer;
- controllato dal flag I nel registro stato;
- se I=1, IRQ viene ignorato finche non viene fatto `CLI`.

Nota: `CLI` (Clear Interrupt Disable) abilita gli IRQ mascherabili. `SEI` (Set Interrupt Disable) li disabilita.

### NMI

- origine tipica sul C64: linea RESTORE;
- non dipende dal flag I;
- usato per eventi critici/non mascherabili.

### BRK

- istruzione software che forza un interrupt-like flow;
- utile in debug e monitor;
- in molti contesti C64 pratici si usa con cautela per evitare side effects non desiderati.

### Vettori principali lato C64/KERNAL

- IRQ RAM vector: `$0314/$0315`
- NMI RAM vector: `$0318/$0319`

Questi vettori RAM permettono di intercettare e reindirizzare le routine di servizio.

---

## 🤖 Come ragiona il 6510

Quando arriva un interrupt, il 6510 salva contesto minimo sullo stack, carica il vettore della routine e salta all'handler. Per uscire correttamente si usa `RTI`.

`RTI` (Return from Interrupt) ripristina stato e program counter dal contesto salvato durante l'ingresso interrupt.

---

## 💡 Esempio pratico

```asm
* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0
; Lezione 049 - Skeleton: installazione vettore IRQ RAM e handler base


    .word 0


IRQ_VEC_LO = $0314
IRQ_VEC_HI = $0315
KERNAL_IRQ = $EA31
BORDER     = $D020

start:
    SEI                     ; disabilita IRQ mascherabili durante setup

    LDA #<irq_handler
    STA IRQ_VEC_LO
    LDA #>irq_handler
    STA IRQ_VEC_HI

    CLI                     ; riabilita IRQ mascherabili

main_loop:
    JMP main_loop

irq_handler:
    ; dimostrazione: tocca bordo e poi passa a KERNAL
    INC BORDER
    JMP KERNAL_IRQ
```

`INC` incrementa un byte in memoria. Qui modifica il colore bordo a ogni IRQ servito.

---

## ⚠️ Errori comuni

- confondere IRQ e NMI come se fossero equivalenti;
- usare `SEI` e dimenticare `CLI`, bloccando IRQ attesi;
- terminare un handler custom senza `RTI` (o senza chaining corretto al KERNAL).

---

## 🧪 Esercizi

1. Modifica l'handler per cambiare solo i 4 bit bassi del bordo.
2. Salva il vecchio vettore IRQ e implementa restore prima di uscire.
3. Aggiungi un contatore in RAM incrementato a ogni IRQ.

---

## 📌 Riassunto

| Tipo | Mascherabile | Fonte tipica |
|------|--------------|--------------|
| IRQ  | Si           | VIC-II, CIA |
| NMI  | No           | RESTORE |
| BRK  | Software     | Istruzione `BRK` |

---

## 🔜 Preparazione alla lezione successiva

Nella prossima lezione vedremo in dettaglio `CLI/SEI/RTI`, masking e struttura robusta di handler interrupt.

---

## 🔎 Approfondimento - Dentro il 6510

Gli interrupt sono la base del multitasking cooperativo "per eventi" nei sistemi 8-bit: il main loop fa lavoro generale, gli handler gestiscono segnali temporizzati con latenza prevedibile.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
