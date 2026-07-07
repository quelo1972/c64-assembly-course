[🏠 Home](/index.md)
# Lezione 009 - Trasferimento tra registri

> **Obiettivo:** capire come il MOS 6510 copia valori tra i registri A, X e Y senza usare la memoria.

---

## 🎯 Obiettivi

- conoscere le istruzioni `TAX`, `TAY`, `TXA` e `TYA`;
- capire il trasferimento diretto dei dati tra registri;
- vedere come ridurre l'accesso a memoria usando i registri.

## 🧠 Introduzione

Nel 6510 i registri possono scambiarsi valori direttamente.

Questo è utile quando vogliamo conservare temporaneamente un valore o usarlo in un registro diverso da A.

Senza queste istruzioni dovremmo salvare il valore in memoria e rileggerlo, con un costo maggiore.

---

## 📘 Teoria

I registri non sono tutti uguali: A è l'accumulatore principale, mentre X e Y sono spesso usati come indici o supporto.

Le istruzioni di trasferimento fanno copia diretta di un byte da un registro all'altro.

Queste istruzioni non modificano i flags tranne `TAX`, `TAY`, `TXA` e `TYA` che aggiornano i flag Zero e Negative come se fosse stato caricato il valore in A.

Le istruzioni principali sono:

- `TAX` → copia da A a X;
- `TAY` → copia da A a Y;
- `TXA` → copia da X ad A;
- `TYA` → copia da Y ad A.

Usare questi comandi è più veloce che salvare e leggere dalla memoria.

---

## 🤖 Come ragiona il 6510

Nel 6510 il registro A è spesso il punto centrale di lavoro.

Quando usi `TAX`, il processore prende il valore già presente in A e lo mette in X, senza andare in memoria.

Questo è come se avessi un tavolo di lavoro e spostassi un oggetto da una scatola all'altra all'interno della CPU.

Il valore rimane anche in A, perché si tratta di copia, non di spostamento.

---

## 💡 Esempio pratico

```asm
* = $1000

    lda #$06   ; A = 6
    tax        ; X = 6

    lda #$0a   ; A = 10
    tay        ; Y = 10

    txa        ; A = 6
    tya        ; A = 10

    rts
```

Spieghiamo la sequenza:

- `lda #$06` carica 6 in A;
- `tax` copia 6 in X;
- `lda #$0a` sostituisce A con 10;
- `tay` copia 10 in Y;
- `txa` riporta il valore 6 in A da X;
- `tya` riporta il valore 10 in A da Y.

Grazie a queste istruzioni possiamo usare X e Y come depositi temporanei senza salvare in memoria.

---

## ⚠️ Errori comuni

- pensare che `TAX` svuoti A (in realtà fa copia, non spostamento);
- usare `TXA` e `TYA` prima di aver caricato il registro X o Y;
- confondere i registri di origine e destinazione;
- credere che queste istruzioni modifichino la memoria.

---

## 🧪 Esercizi

1. Scrivi un programma che carica `#$03` in A, copia in X, poi carica `#$07` e copia in Y.
2. Usa `TXA` e `TYA` per riportare prima X e poi Y in A.
3. Aggiungi i commenti alle righe per spiegare esattamente cosa avviene.

---

## 📌 Riassunto

- `TAX`, `TAY`, `TXA`, `TYA` copiano valori tra registri;
- non usano memoria;
- sono utili per conservare valori temporanei nei registri;
- copiare un valore non lo cancella dal registro di origine.

## 🔜 Preparazione alla lezione successiva

Nella prossima lezione studieremo le istruzioni di incremento e decremento, come `INX`, `INY`, `DEX` e `DEY`.

## 🔎 Approfondimento - Dentro il 6510

Il trasferimento tra registri mostra una caratteristica chiave del 6510: molti dati sono gestiti internamente e non transitano sempre dalla memoria.

Usare i registri in modo efficiente rende il programma più veloce.

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
