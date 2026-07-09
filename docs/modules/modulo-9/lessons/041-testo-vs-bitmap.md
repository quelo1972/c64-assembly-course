[🏠 Home](../../../index.md)

# Lezione 041 - Modalita testo vs bitmap

> **Obiettivo:** capire differenze pratiche tra modalita testo e bitmap del VIC-II e sapere quando scegliere l'una o l'altra.

---

## 🎯 Obiettivi

- distinguere memoria e limiti delle due modalita;
- capire costo in RAM e flessibilita grafica;
- attivare una configurazione base in modalita testo.

---

## 🧠 Introduzione

Nel C64 non esiste una sola modalita grafica. In questa fase è importante capire la scelta architetturale: modalita testo (piu economica e veloce per UI/tabelle) contro bitmap (piu libera ma costosa in memoria).

---

## 📘 Teoria

### Modalita testo

- usa Screen RAM (tipicamente `$0400`) per i codici carattere;
- usa Color RAM (`$D800`) per il colore per cella;
- griglia 40x25 = 1000 celle;
- ideale per HUD, menu, debug, giochi tile-based semplici.

### Modalita bitmap (high-resolution)

- usa una bitmap da 8000 byte;
- permette controllo pixel molto piu fine;
- richiede piu RAM e gestione piu complessa;
- utile per schermate grafiche ricche.

### Trade-off principale

- testo: meno memoria, piu struttura a celle;
- bitmap: piu memoria, piu liberta grafica.

---

## 🤖 Come ragiona il 6510

La CPU non "disegna" pixel da sola: scrive valori nei registri e nelle aree RAM che il VIC-II legge durante il refresh video. Cambiando configurazione, cambia come il VIC-II interpreta la memoria.

---

## 💡 Esempio pratico

```asm
; Lezione 041 - Confronto pratico: testo -> bitmap
*= $0801

SCREEN_RAM = $0400
COLOR_RAM  = $D800
BORDER     = $D020
BG0        = $D021
VIC_CTRL1  = $D011
VIC_MPTR   = $D018

start:
    ; fase 1: modalita testo (riempie la prima riga)
    LDA #$00
    STA BG0          ; sfondo nero
    LDA #$06
    STA BORDER       ; bordo blu

    LDX #$00
fill_row:
    LDA #$01         ; codice carattere
    STA SCREEN_RAM,X ; scrive in screen RAM
    LDA #$0E
    STA COLOR_RAM,X  ; colore cella
    INX
    CPX #$28         ; 40 colonne
    BNE fill_row

    ; fase 2: passaggio minimo a bitmap mode
    ; ORA imposta bit a 1 mantenendo gli altri invariati
    LDA VIC_CTRL1
    ORA #%00100000   ; bit 5 = bitmap mode ON
    STA VIC_CTRL1

    ; D018: screen RAM = $0400 (high nibble=1), bitmap = $2000 (bit 3 = 1)
    LDA #$18
    STA VIC_MPTR

    RTS
```

`STA` salva un valore in memoria o registro I/O. `CPX` confronta X con un limite. `BNE` continua il ciclo finche il confronto non risulta uguale. `ORA` imposta bit specifici senza azzerare gli altri bit del registro.

---

## ⚠️ Errori comuni

- confondere Screen RAM e Color RAM;
- aspettarsi controllo pixel in modalita testo;
- dimenticare il limite 40 colonne quando si riempie una riga.

---

## 🧪 Esercizi

1. Scrivi la seconda riga (offset +40) con altro colore.
2. Cambia solo il bordo ogni frame mantenendo invariata la Screen RAM.

---

## 📌 Riassunto

| Concetto | Spiegazione breve |
|----------|-------------------|
| Modalita testo | Griglia 40x25, veloce e leggera |
| Modalita bitmap | Pixel-level, piu RAM e complessita |
| Trade-off | Scegli in base a obiettivo grafico e memoria |

---

## 🔜 Preparazione alla lezione successiva

Nella prossima lezione passiamo agli sprite hardware: definizione, attivazione, posizione e collisioni.

---

## 🔎 Approfondimento - Dentro il 6510

Molti giochi misti usano testo o charset per HUD e bitmap/sprite per scena. La scelta ibrida riduce costo CPU e RAM nelle aree meno dinamiche.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
