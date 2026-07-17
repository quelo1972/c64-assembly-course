[🏠 Home](../../../index.md)

# Lezione 059 - Tecniche di compressione e data packing

> **Obiettivo:** introdurre strategie pratiche per ridurre spazio occupato da dati e risorse su C64.

---

## 🎯 Obiettivi

- distinguere compressione runtime da packing statico;
- capire quando conviene una LUT o una codifica compatta;
- introdurre RLE come tecnica didattica semplice;
- valutare costo CPU vs guadagno memoria.

---

## 🧠 Introduzione

Su C64, memoria e storage sono limitati. Ridurre dati è una leva cruciale, ma decomprimere costa cicli CPU. L equilibrio dipende dal contesto.

---

## 📘 Teoria

Approcci comuni:

- **packing statico**: struttura dati piu compatta senza decompressore complesso;
- **compressione leggera**: es. RLE per pattern ripetitivi;
- **compressione avanzata**: migliore rapporto, maggiore costo implementativo.

Regola pratica:

- dati statici molto ripetitivi -> compressione utile;
- dati piccoli o dinamici -> packing semplice spesso basta.

---

## 🤖 Come ragiona il 6510

Il 6510 converte una sequenza compressa in dati espansi attraverso loop semplici. Ogni byte risparmiato in memoria puo costare istruzioni aggiuntive durante la decompressione.

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
; Lezione 059 - RLE decode minimale: [count][value]


    .word 0


SRC = $C200
DST = $0400

start:
    LDY #$00            ; indice sorgente
    LDX #$00            ; indice destinazione

decode_next:
    LDA SRC,Y           ; count
    BEQ done            ; 0 = fine stream
    STA count
    INY

    LDA SRC,Y           ; value
    STA value
    INY

write_loop:
    LDA value
    STA DST,X
    INX
    DEC count
    BNE write_loop
    JMP decode_next

done:
    JMP done

count:
    .byte $00
value:
    .byte $00

* = SRC
    .byte 10,$41, 5,$20, 10,$42, 0
```

`DEC count` decrementa il contatore del run e aggiorna i flag; con `BNE` ottieni un loop controllato da conteggio esplicito.

---

## ⚠️ Errori comuni

- dimenticare marker di fine stream;
- non validare overflow destinazione;
- usare compressione complessa senza reale beneficio.

---

## 🧪 Esercizi

1. Sostituisci il marker fine stream con lunghezza totale nota.
2. Aggiungi controllo che blocchi scritture oltre 256 byte.
3. Confronta dimensione dati raw vs RLE su un pattern test.

---

## 📌 Riassunto

| Tecnica | Pro | Contro |
|---------|-----|--------|
| packing | semplice | guadagno limitato |
| RLE | ottima su pattern ripetuti | richiede decode runtime |

---

## 🔜 Preparazione alla lezione successiva

Nel mini-progetto applicheremo ottimizzazione completa su una routine reale misurando guadagni pratici.

---

## 🔎 Approfondimento - Dentro il 6510

L ottimizzazione dati è un contratto tra memoria e CPU: ogni scelta di formato deve essere valutata insieme al costo di accesso e trasformazione.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
