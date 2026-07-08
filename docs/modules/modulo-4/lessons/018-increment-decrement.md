[🏠 Home](../../../index.md)
# Lezione 18 — - Incremento e decremento

> **Obiettivo:** imparare le istruzioni `INX`, `INY`, `DEX`, `DEY` e il loro uso pratico.

---

## 🎯 Obiettivi

- conoscere le istruzioni `INX`, `INY`, `DEX`, `DEY`;
- capire come usarle per contatori e cicli;
- confrontare l'uso dei registri vs memoria per incrementare/decrementare valori.

## 🧠 Introduzione

Incrementare o decrementare registri è fondamentale per contare, scorrere tabelle o gestire loop semplici.

Usare i registri per queste operazioni è molto più veloce che usare memoria.

---

## 📘 Teoria

Le istruzioni:

- `INX` → incrementa il registro X di 1;
- `INY` → incrementa il registro Y di 1;
- `DEX` → decrementa il registro X di 1;
- `DEY` → decrementa il registro Y di 1.

Queste istruzioni aggiornano i flag Zero e Negative in base al risultato.

Sono spesso usate insieme a `BEQ`, `BNE`, `BPL`, `BMI` per creare cicli condizionati.

Brevi definizioni (per chiarezza):

- `BEQ` (Branch if EQual): salta se il flag Zero è settato (risultato = 0).
- `BNE` (Branch if Not Equal): salta se il flag Zero non è settato (risultato ≠ 0).
- `BPL` (Branch if PLus): salta se il flag Negative non è settato (risultato positivo o zero).
- `BMI` (Branch if MInus): salta se il flag Negative è settato (risultato negativo).

Queste brevi note spiegano il comportamento dei salti condizionati menzionati nell'esempio; approfondiremo i salti e le subroutine nella lezione dedicata.

---

## 🤖 Come ragiona il 6510

Il 6510 incrementa o decrementa i registri molto rapidamente perché l'operazione avviene internamente, senza leggere o scrivere in memoria.

Questo permette cicli stretti e operazioni con basso overhead.

---

## 💡 Esempio pratico

```asm
* = $1000

    lda #$00   ; A = 0
    tax        ; X = 0

loop:
    inx        ; X++
    txa        ; A = X
    sta $d020  ; mostra X come colore del bordo (per vedere il cambiamento)
    cpx #$05   ; confronta X con 5
    bne loop   ; ripeti finché X != 5

Nota: `CPX #value` confronta il registro `X` con un valore immediato e aggiorna i flag (Zero, Negative) come risultato, senza modificare `X`. È spesso usato insieme a `BNE` o `BEQ` per controllare loop.

    rts
```

Spiegazione:

- inizializziamo `X` a 0;
- in ogni iterazione incrementiamo `X` e mostriamo il valore;
- il ciclo termina quando `X` raggiunge 5.

---

## ⚠️ Errori comuni

- aspettarsi che `INX` modifichi A (non lo fa);
- dimenticare che il confronto con `CPX` non cambia il registro X;
- non aggiornare i flag quando si conta per condizioni.

---

## 🧪 Esercizi

1. Modifica l'esempio in modo che decrementi da 5 a 0 usando `DEX`.
2. Usa `INY` per creare un ciclo annidato che modifica anche Y.
3. Spiega perché è preferibile usare X/Y come contatori invece della memoria.

---

## 📌 Riassunto

- `INX`, `INY`, `DEX`, `DEY` sono istruzioni veloci per contare;
- aggiornano i flag Zero e Negative;
- sono strumenti fondamentali per loop e scorrimenti.

## 🔜 Preparazione alla lezione successiva

Nella prossima lezione introdurremo i salti condizionati e le subroutine (`JMP`, `JSR`, `RTS`).

Brevi definizioni:

- `JMP address`: salto incondizionato all'indirizzo specificato.
- `JSR address`: salta a una subroutine memorizzando l'indirizzo di ritorno sullo stack (usato con `RTS` per tornare).


## 🔎 Approfondimento - Dentro il 6510

I registri consentono di evitare accessi a memoria costosi in termini di cicli macchina; incrementare un registro è un'operazione a basso costo.

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
