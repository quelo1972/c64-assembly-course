[🏠 Home](../../../index.md)

# Lezione 061 - Definizione e pianificazione del progetto finale

> **Obiettivo:** impostare scope, obiettivi e milestone del progetto finale (gioco o demo) in modo realistico.

---

## 🎯 Obiettivi

- definire un progetto fattibile su C64;
- separare requisiti minimi da funzionalita opzionali;
- costruire una roadmap incrementale;
- evitare scope creep nelle fasi iniziali.

---

## 🧠 Introduzione

Il modulo finale non è solo codice: e gestione del progetto. Una pianificazione chiara riduce blocchi e aumenta probabilita di arrivare a una release completa.

---

## 📘 Teoria

Struttura minima consigliata:

- **Core loop**: cosa fa il programma a ogni tick/frame;
- **Input/Output**: tastiera/joystick, video, audio;
- **Persistenza** (opzionale): load/save;
- **Build/Release**: PRG o D64 finale.

Roadmap in sprint brevi:

1. prototipo eseguibile;
2. feature base complete;
3. rifinitura e ottimizzazione;
4. packaging e pubblicazione.

---

## 🤖 Come ragiona il 6510

Il 6510 premia design semplici: loop corto, stato esplicito, responsabilita nette tra moduli. Una buona architettura riduce il costo delle modifiche tardive.

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
; Lezione 061 - Skeleton progetto finale


    .word 0


BORDER = $D020

start:
    JSR init

main_loop:
    JSR input_step
    JSR update_step
    JSR render_step
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
```

`RTS` termina una subroutine e torna al chiamante: è la base della modularizzazione del progetto.

---

## ⚠️ Errori comuni

- partire da feature avanzate senza core funzionante;
- non fissare un MVP minimo;
- mescolare logica, rendering e I/O in un blocco unico.

---

## 🧪 Esercizi

1. Definisci un MVP in 5 punti massimi.
2. Scrivi 3 milestone con criterio "done" verificabile.
3. Aggiungi una backlog opzionale separata dal core.

---

## 📌 Riassunto

| Fase | Obiettivo |
|------|-----------|
| definizione | ridurre ambiguita |
| pianificazione | rendere il lavoro incrementale |
| skeleton | validare architettura |

---

## 🔜 Preparazione alla lezione successiva

Nella prossima lezione organizzeremo il progetto in moduli testabili con pipeline di build e packaging.

---

## 🔎 Approfondimento - Dentro il 6510

La complessita su 8-bit si controlla con disciplina architetturale: interfacce semplici tra routine e cambi piccoli ma verificabili.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
