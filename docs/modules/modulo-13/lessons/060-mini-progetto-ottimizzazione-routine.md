[🏠 Home](../../../index.md)

# Lezione 060 - Mini-progetto: ottimizzazione di una routine

> **Obiettivo:** applicare una metodologia concreta di ottimizzazione su una routine esistente con criterio misurabile.

---

## 🎯 Obiettivi

- definire baseline di una routine;
- applicare ottimizzazioni incrementali;
- verificare che il risultato resti corretto;
- documentare guadagno e trade-off.

---

## 🧠 Introduzione

Un ottimo esercizio finale per il modulo 13 e prendere una routine semplice e migliorarla senza romperla. Qui mostriamo il processo, non solo il risultato.

---

## 📘 Teoria

Metodo in 4 passi:

1. baseline: codice funzionante è chiaro;
2. hotspot: identifica sezione critica (loop copy/update);
3. ottimizzazione mirata (zero page, meno accessi, meno branch);
4. regressione: verifica output invariato.

Metriche pratiche:

- cicli approssimati per iterazione;
- byte di codice;
- robustezza/manutenibilita.

---

## 🤖 Come ragiona il 6510

Il 6510 non premia l intuizione, premia la sequenza effettiva di istruzioni. Ogni eliminazione di lavoro ridondante in loop frequenti si traduce in miglioramento reale.

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
; Lezione 060 - Baseline vs versione compatta (dimostrativa)


    .word 0


SRC = $C300
DST = $0400

start:
    ; versione compatta: copia 256 byte
    LDX #$00
copy:
    LDA SRC,X
    STA DST,X
    INX
    BNE copy

done:
    JMP done
```

`INX` incrementa X e aggiorna Z quando torna a 0, permettendo un loop naturale su 256 elementi con `BNE`.

---

## ⚠️ Errori comuni

- cambiare algoritmo e perdere equivalenza funzionale;
- ottimizzare senza baseline iniziale;
- fare micro-ottimizzazioni premature in codice non critico.

---

## 🧪 Esercizi

1. Crea versione alternativa con indice Y e confronta leggibilita.
2. Aggiungi contatore cicli stimato nei commenti.
3. Misura impatto spostando sorgente in zero page.

---

## 📌 Riassunto

| Fase | Regola |
|------|--------|
| baseline | prima correttezza |
| optimize | poi costo |
| verify | sempre equivalenza |

---

## 🔜 Preparazione alla lezione successiva

Nel modulo 14 useremo queste pratiche in un progetto completo: pianificazione, build, test e release finale.

---

## 🔎 Approfondimento - Dentro il 6510

L ottimizzazione sostenibile è una disciplina di progetto: risultati misurabili, rollback semplice e motivazioni chiare per ogni modifica.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
