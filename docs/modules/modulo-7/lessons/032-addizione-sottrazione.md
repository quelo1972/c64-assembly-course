[🏠 Home](../../../index.md)

# Lezione 32 — Addizione e sottrazione: ADC e SBC

> **Obiettivo:** capire come fare operazioni aritmetiche con ADC (Add with Carry) e SBC (Subtract with Carry), gestendo il flag carry per operazioni multi-byte.

---

## 🎯 Obiettivi

- comprendere ADC e SBC con il flag carry;
- gestire il carry per addizioni/sottrazioni a 16+ bit;
- usare CLC e SEC per inizializzare il carry;
- implementare logica aritmetica complessa.

---

## 🧠 Introduzione

`ADC` non è una semplice addizione: **incllude il carry** nel risultato.

```asm
ADC #$50       ; A = A + $50 + C
```

Questo è utile per:
- Addizioni su numeri > 8 bit
- Sottrazioni con borrow tracking
- Operazioni aritmetiche con valuta carry (BCD)

---

## 📘 Teoria

### ADC (Add with Carry)

```asm
ADC operand    ; A ← A + operand + C
```

Se il risultato > 255, setta C = 1.

| Situazione | Esempio |
|-----------|---------|
| Nessun overflow | A=$50, operand=$30 → A=$80, C=0 |
| Overflow unsigned | A=$FF, operand=$02 → A=$01, C=1 |
| Con carry iniziale | A=$FF, C=1, operand=$00 → A=$00, C=1 |

### SBC (Subtract with Carry)

```asm
SBC operand    ; A ← A - operand - (1 - C)
```

Nota: SBC sottrae sia l'operando che **NOT carry**. Se C=0, sottrae un byte extra (borrow).

| Situazione | Esempio |
|-----------|---------|
| C=1 (no borrow) | A=$50, operand=$30, C=1 → A=$20, C=1 |
| C=0 (borrow) | A=$30, operand=$30, C=0 → A=$FF, C=0 |

### Flag settati

ADC e SBC settano:
- **Z**: 1 se risultato = 0
- **C**: 1 se carry (overflow per ADC, borrow per SBC)
- **N**: 1 se risultato bit 7 = 1
- **V**: 1 se overflow signed

### CLC e SEC

```asm
CLC            ; Clear Carry (C ← 0)
SEC            ; Set Carry (C ← 1)
```

Essenziali per inizializzare il carry prima di operazioni multi-byte.

---

## 🤖 Come ragiona il 6510

### `ADC #$50` con A=$F0, C=0

1. **Fetch opcode**: `$69`
2. **Fetch operando**: `$50`
3. **Add**: `$F0 + $50 + 0 = $140`
4. **Truncate**: `$40` (8 bit)
5. **Set flags**:
   - Z = 0 (risultato ≠ 0)
   - C = 1 (overflow: risultato > 255)
   - N = 0 (bit 7 = 0)
   - V = 0 (no overflow signed)

### `SBC #$30` con A=$20, C=0

1. **Fetch opcode**: `$E9`
2. **Fetch operando**: `$30`
3. **Subtract**: `$20 - $30 - (1-0) = $20 - $30 - 1 = -$11`
4. **Borrow**: risultato negativo
5. **Set flags**:
   - C = 0 (borrow occurred)
   - N = 1 (risultato trattato come signed negativo)
   - Z = 0
   - V = 0

---

## 💡 Esempio pratico

```asm
; Lezione 024 — Addizione e sottrazione
; Aritmetica con carry
*= $0801

; Addizione semplice
CLC            ; Azzera il carry prima di ADC
LDA #$50
ADC #$30       ; A = $50 + $30 + 0 = $80

; Addizione con overflow
CLC
LDA #$FF
ADC #$02       ; A = $FF + $02 + 0 = $101 → $01 con C=1

; Sottrazione semplice
SEC            ; Setta il carry (no borrow)
LDA #$50
SBC #$30       ; A = $50 - $30 - 0 = $20

; Addizione a 16 bit
CLC
LDA #$FF       ; byte basso
ADC #$01       ; aggiungi 1 al byte basso
STA $02        ; salva il risultato

LDA #$00       ; byte alto
ADC #$00       ; aggiungi carry (se presente)
STA $03        ; salva byte alto

RTS
```

Compila:

```bash
64tass --cbm-prg -o bin/024.prg src/modulo-7/024.asm
```

---

## ⚠️ Errori comuni

- **Dimenticare CLC/SEC**: il carry dall'operazione precedente influenza ADC/SBC.
- **Confondere SBC**: SBC sottrae `operand + (1 - C)`, non solo operand.
- **Overflow signed vs unsigned**: C è overflow unsigned, V è overflow signed. Usa BVS per signed.
- **16-bit arithmetic**: per somme > 8 bit, devi propagare il carry tra bytes.

---

## 🧪 Esercizi

1. Somma due numeri a 8 bit e verifica il carry.
2. Somma due numeri a 16 bit (4 byte) correttamente.
3. Implementa una sottrazione a 16 bit con borrow propagation.

---

## 📌 Riassunto

| Concetto     | Spiegazione                              |
|-------------|------------------------------------------|
| ADC         | A ← A + operand + C                      |
| SBC         | A ← A - operand - (1 - C)               |
| CLC / SEC   | Inizializza il carry                     |
| Flag        | Z, C, N, V settati                       |
| Multi-byte  | Propaga il carry tra bytes               |

---

## 🔜 Preparazione alla lezione successiva

Nella lezione 025 vedremo **Operazioni logiche**: AND, ORA, EOR per manipolare bit.

---

## 🔎 Approfondimento — Dentro il 6510

**Overflow signed vs unsigned:**

```
A=$7F, ADC #$01 → A=$80, V=1, C=0
; +127 + 1 = -128 (signed overflow, ma C=0 perché < 256)

A=$FF, ADC #$01 → A=$00, V=0, C=1
; 255 + 1 = 256 (unsigned overflow, C=1)
```

Usa BCS per borrow (unsigned), BVS per signed overflow.

---

## 🔎 Approfondimento - Dentro il 6510

La stabilita del software su C64 dipende da una disciplina costante: passi piccoli, stato esplicito e ordine prevedibile nelle scritture su memoria e I/O. Questo approccio riduce errori difficili da tracciare nelle fasi successive del corso.

## ✅ Checklist finale

- [ ] l'esempio compila con `64tass`
- [ ] ADC e SBC funzionano con CLC/SEC
- [ ] il carry è propagato correttamente
- [ ] il contenuto è progressivo rispetto alle lezioni precedenti
