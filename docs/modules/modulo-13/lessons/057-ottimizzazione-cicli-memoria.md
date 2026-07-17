[🏠 Home](../../../index.md)

# Lezione 057 - Ottimizzazione per cicli e memoria

> **Obiettivo:** introdurre metodi pratici per ridurre cicli CPU e footprint memoria senza perdere leggibilita.

---

## 🎯 Obiettivi

- riconoscere colli di bottiglia comuni su 6510;
- confrontare trade-off tra velocita e dimensione codice;
- usare zero page in modo strategico;
- impostare una metodologia di micro-ottimizzazione.

---

## 🧠 Introduzione

Ottimizzare su C64 non significa "rendere tutto incomprensibile": significa concentrare gli sforzi nei punti caldi mantenendo il resto del codice chiaro.

---

## 📘 Teoria

Linee guida base:

- ottimizza solo dopo misura/osservazione;
- preferisci accessi zero page nei percorsi hot;
- evita lavoro ridondante dentro loop frequenti;
- considera tabelle pre-calcolate quando conviene.

Trade-off tipici:

- piu velocita -> spesso piu memoria;
- piu compattezza -> talvolta piu cicli;
- la scelta dipende dall obiettivo del modulo/progetto.

---

## 🤖 Come ragiona il 6510

Ogni istruzione costa cicli. In loop molto eseguiti, anche un risparmio piccolo per iterazione produce differenze percepibili su frame rate o tempo risposta.

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
; Lezione 057 - Loop copia RAM minimale


    .word 0


SRC = $C000
DST = $0400

start:
    LDX #$00
copy_loop:
    LDA SRC,X
    STA DST,X
    INX
    BNE copy_loop

done:
    JMP done
```

`BNE` salta se Z=0. Con X che va da 0 a 255, ottieni un loop compatto su 256 byte.

---

## ⚠️ Errori comuni

- ottimizzare codice non critico;
- confondere "piu corto" con "piu veloce";
- rimuovere chiarezza ovunque invece che nei soli hot spot.

---

## 🧪 Esercizi

1. Sposta `SRC` in zero page e confronta il codice risultante.
2. Duplica il loop per 512 byte usando due pagine.
3. Inserisci un contatore bordo per percepire il costo temporale.

---

## 📌 Riassunto

| Principio | Effetto |
|-----------|---------|
| ottimizzare hot path | migliora impatto reale |
| zero page strategica | riduce costo accessi |
| trade-off espliciti | evita scelte casuali |

---

## 🔜 Preparazione alla lezione successiva

Nella prossima lezione affrontiamo paging e bank switching, fondamentali quando lo spazio lineare non basta.

---

## 🔎 Approfondimento - Dentro il 6510

Una buona ottimizzazione mantiene invariata la semantica. Prima validi correttezza, poi misuri costo: mai il contrario.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
