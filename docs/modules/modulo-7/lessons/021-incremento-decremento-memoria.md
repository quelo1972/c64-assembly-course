[🏠 Home](../../../index.md)

# Lezione 021 — Incremento e decremento in memoria

> **Obiettivo:** capire come usare INC/DEC per modificare direttamente celle di memoria, oltre ai registri X/Y.

---

## 🎯 Obiettivi

- comprendere le differenze tra INX/DEX (registri) e INC/DEC (memoria);
- usare INC/DEC per modificare contatori e variabili in memoria;
- confrontare cicli e dimensioni: registro vs memoria;
- implementare logica che modifica variabili globali.

---

## 🧠 Introduzione

Finora abbiamo usato INX/DEX per incrementare/decrementare solo il registro X.

Ma spesso vogliamo modificare una **variabile in memoria**:

```asm
INC $40        ; incrementa il byte in $40
DEC $50        ; decrementa il byte in $50
```

Questo è utile per:
- Contatori globali
- Flag booleani
- Variabili di stato

---

## 📘 Teoria

### Sintassi

```asm
INC addr       ; incrementa il byte in addr
DEC addr       ; decrementa il byte in addr
INC addr,X     ; incrementa il byte in addr + X
DEC addr,X     ; decrementa il byte in addr + X
```

### Modalità di indirizzamento

| Modalità | Opcode | Bytes | Cicli |
|----------|--------|-------|-------|
| Zero Page | `$E6` (INC), `$C6` (DEC) | 2 | 5 |
| Zero Page, X | `$F6` (INC), `$D6` (DEC) | 2 | 6 |
| Absolute | `$EE` (INC), `$CE` (DEC) | 3 | 6 |
| Absolute, X | `$FE` (INC), `$DE` (DEC) | 3 | 7 |

### Flag settati

INC e DEC settano:
- **Z**: 1 se il risultato è zero, 0 altrimenti
- **N**: 1 se il risultato ha bit 7 = 1, 0 altrimenti

**Non modificano il flag C (Carry).**

### Wraparound

Se incrementi `$FF`, ottieni `$00` con Z = 1.
Se decrementi `$00`, ottieni `$FF` con N = 1.

---

## 🤖 Come ragiona il 6510

### `INC $40`

1. **Fetch opcode**: `$E6`
2. **Fetch indirizzo**: `$40`
3. **Read**: legge il byte da `$40`
4. **Increment**: aggiungi 1
5. **Write**: scrivi il risultato in `$40`
6. **Set flags**: Z e N in base al risultato

In totale: **2 byte**, **5 cicli**.

### `INC $40,X` con X = $05

1. **Fetch opcode**: `$F6`
2. **Fetch indirizzo**: `$40`
3. **Calculate**: `$40 + X = $45`
4. **Read**: legge da `$45`
5. **Increment**
6. **Write**: scrivi in `$45`
7. **Set flags**

In totale: **2 byte**, **6 cicli**.

---

## 💡 Esempio pratico

```asm
; Lezione 021 — Incremento e decremento in memoria
; Modifica variabili globali in Zero Page
*= $0801

; Variabili in Zero Page
counter = $02
accumulator = $03

; Incrementa il counter
INC counter    ; counter = counter + 1

; Se counter raggiunge 10, decrementa accumulator
LDA counter
CMP #$0A       ; confronta con 10
BNE skip

DEC accumulator ; decrementa se counter == 10
LDA #$00
STA counter    ; reset counter

skip:
  RTS
```

Compila:

```bash
64tass --cbm-prg -o bin/021.prg src/modulo-7/021.asm
```

---

## ⚠️ Errori comuni

- **Confondere INX con INC**: INX incrementa il registro X, INC incrementa una cella di memoria.
- **Assumere che INC modifichi Carry**: INC setta solo Z e N, non C.
- **Performance**: INC memoria è più lento (5-7 cicli) che INX (2 cicli). Usa INX quando possibile.

---

## 🧪 Esercizi

1. Scrivi un loop che incrementa un contatore in Zero Page finché non raggiunge 100.
2. Usa INC indicizzato per incrementare 10 variabili consecutive.
3. Implementa un decremento con controllo di zero: se una variabile raggiunge 0, setta un flag.

---

## 📌 Riassunto

| Concetto      | Spiegazione                                      |
|---------------|--------------------------------------------------|
| INC           | Incrementa una cella di memoria                  |
| DEC           | Decrementa una cella di memoria                  |
| Modalità      | Zero Page, ZP indicizzato, Assoluto, Abs indicizzato |
| Flag          | Z e N settati, C non modificato                  |
| Cicli         | 5–7 dipende dalla modalità                       |
| Wraparound    | `$FF + 1 = $00` (con Z = 1)                      |

---

## 🔜 Preparazione alla lezione successiva

Nella lezione 022 vedremo le **operazioni di confronto**: CMP, CPX, CPY e BIT test.

---

## 🔎 Approfondimento — Dentro il 6510

**Confronto con INX/DEX:**

```
INX: 1 byte, 2 cicli (registri solo)
INC $40: 2 byte, 5 cicli (memoria)
INC $40,X: 2 byte, 6 cicli (memoria indicizzata)
```

Per loop stretti su registri, usa INX/DEX. Per variabili globali, usa INC/DEC.

---

## ✅ Checklist finale

- [ ] l'esempio compila con `64tass`
- [ ] INC modifica correttamente la variabile in memoria
- [ ] il flag Z è settato quando il risultato è zero
- [ ] il contenuto è progressivo rispetto alle lezioni precedenti
