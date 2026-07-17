[🏠 Home](../../../index.md)

# Lezione 26 — Salti condizionati

> **Obiettivo:** capire come usare i flag del 6510 è le istruzioni di salto condizionato (BEQ, BNE, BPL, BMI) per controllare il flusso di esecuzione.

---

## 🎯 Obiettivi

- comprendere i flag Z, C, N, V è come vengono settati;
- usare BEQ/BNE per saltare in base al flag Z;
- usare BPL/BMI per saltare in base al flag N;
- implementare loop condizionali semplici.

---

## 🧠 Introduzione

Fin qui abbiamo eseguito istruzioni in sequenza. Ma come facciamo a prendere decisioni?

In Assembly, le decisioni si basano sui **flag** del processore:
- **Z** (Zero): è `1` se il risultato è zero, `0` altrimenti
- **C** (Carry): è `1` se c'è overflow aritmetico
- **N** (Negative): è `1` se il risultato è negativo (bit 7 = 1)
- **V** (oVerflow): è `1` se overflow signed

Le istruzioni di **salto condizionato** controllano il flusso leggendo questi flag.

---

## 📘 Teoria

### Flag Z (Zero)

Molte istruzioni (LDA, ADC, INX, etc.) settano il flag Z:

- Se il risultato è zero → Z = 1
- Se il risultato non è zero → Z = 0

```asm
LDA #$00       ; risultato è zero → Z = 1
LDA #$05       ; risultato è non-zero → Z = 0
INX            ; se X diventa $00, Z = 1
```

### Flag N (Negative)

Il flag N è il bit 7 del risultato:

```asm
LDA #$7F       ; 0111 1111 → bit 7 = 0 → N = 0
LDA #$80       ; 1000 0000 → bit 7 = 1 → N = 1
```

### Salti condizionati

| Istruzione | Salta se | Flag | Opcode | Bytes |
|-----------|----------|------|--------|-------|
| BEQ label | Z = 1 (è zero) | Z | `$F0` | 2 |
| BNE label | Z = 0 (non zero) | Z | `$D0` | 2 |
| BPL label | N = 0 (positivo) | N | `$10` | 2 |
| BMI label | N = 1 (negativo) | N | `$30` | 2 |

> Nota: BEQ = Branch if EQual; BNE = Branch if Not Equal; BPL = Branch if PLus; BMI = Branch if MInus.

### Addressing relativo

I salti usano **relative addressing**: l'offset è relativo al PC.

```asm
BEQ +5         ; salta 5 byte avanti
BNE -3         ; salta 3 byte indietro
```

L'offset è a **1 byte con segno** (-128 a +127).

---

## 🤖 Come ragiona il 6510

`INX` seguito da `BEQ loop`:

1. **Execute INX**: X = X + 1, aggiorna Z flag
2. **Fetch BEQ**: legge opcode `$F0`
3. **Fetch offset**: legge il valore relativo
4. **Check flag**: se Z = 1, aggiunge offset a PC e salta; altrimenti continua

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
; Lezione 015 — Salti condizionati
; Loop che azzera 16 byte


    .word 0


; Nota: BEQ label salta se Z=1 (risultato zero).
; Nota: BNE label salta se Z=0 (risultato non-zero).
; Nota: INX incrementa X e setta il flag Z.

LDX #$10       ; carica 16 in X

loop:
  ; azzera la cella
  LDA #$00
  STA $0400,X
  
  DEX            ; decrementa X, setta Z se X = 0
  BNE loop       ; se X non è zero, ripeti

RTS
```

Compila:

```bash
64tass --cbm-prg -o bin/015.prg src/modulo-6/015.asm
```

---

## ⚠️ Errori comuni

- **Offset fuori range**: se il salto è > 127 byte, riceverai un errore di assemblaggio. Usa JMP per salti lunghi (vedi lezione 016).
- **Dimenticare che i flag cambiano**: ogni istruzione che modifica registri setta i flag. Non assumerli stabili.
- **Confondere BPL/BMI con flag diversi**: BPL/BMI controllano il flag N (bit 7), non lo status generale.

---

## 🧪 Esercizi

1. Scrivi un loop che legge 10 byte da `$0400` fino a trovare uno zero (usa BEQ per uscire).
2. Copia una stringa da `$0400` a `$0500` finché non leggi uno zero.
3. Conta quanti byte sono non-zero in un'area di memoria.

---

## 📌 Riassunto

| Concetto          | Spiegazione                                    |
|-------------------|------------------------------------------------|
| Flag Z            | 1 se risultato è zero, 0 altrimenti            |
| Flag N            | Bit 7 del risultato (1 = negativo)             |
| BEQ / BNE         | Salta basato su flag Z                         |
| BPL / BMI         | Salta basato su flag N                         |
| Addressing relativo | Offset ± 127 byte dal PC corrente            |

---

## 🔜 Preparazione alla lezione successiva

Nella lezione 016 vedremo le **subroutine**: come chiamare funzioni con JSR e rientrare con RTS, usando lo stack per salvare l'indirizzo di ritorno.

---

## 🔎 Approfondimento — Dentro il 6510

I 6 flag del 6510 (nell'ordine 76543210):

```
7: N (Negative)
6: V (oVerflow)
5: unused
4: B (Break)
3: D (Decimal)
2: I (Interrupt)
1: Z (Zero)
0: C (Carry)
```

Le istruzioni di branch non influenzano altri flag.

---

## 🔎 Approfondimento - Dentro il 6510

Nei salti e nelle subroutine, la stabilita dipende dalla chiarezza del flusso di controllo: condizioni esplicite, ritorni coerenti e uso disciplinato dello stack. Questo rende il comportamento del programma prevedibile anche nei casi limite.

## ✅ Checklist finale

- [ ] l'esempio compila con `64tass`
- [ ] il loop BNE funziona e itera il numero corretto di volte
- [ ] la differenza tra BEQ, BNE, BPL, BMI è chiara
- [ ] il contenuto è progressivo rispetto alle lezioni precedenti
