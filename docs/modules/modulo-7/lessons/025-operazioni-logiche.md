[🏠 Home](../../../index.md)

# Lezione 025 — Operazioni logiche: AND, ORA, EOR

> **Obiettivo:** capire come manipolare bit usando operazioni logiche AND (AND), ORA (OR), EOR (XOR) per maschere e combinazioni di bit.

---

## 🎯 Obiettivi

- comprendere AND, ORA, EOR e la loro tavola di verità;
- usare AND per estrarre bit (maschere);
- usare ORA per settare bit;
- usare EOR per invertire bit;
- implementare logica di manipolazione di bit.

---

## 🧠 Introduzione

A volte vogliamo manipolare **singoli bit** o **gruppi di bit**.

Esempi:
- Estrarre il bit 7 da A: `AND #$80`
- Settare il bit 3: `ORA #$08`
- Invertire il bit 0: `EOR #$01`

Le operazioni logiche bit-by-bit risolvono questi problemi.

---

## 📘 Teoria

### AND (Bitwise AND)

```asm
AND operand    ; A ← A AND operand (bit-by-bit)
```

Truth table:
```
A | op | result
--|----|---------
0 | 0  | 0
0 | 1  | 0
1 | 0  | 0
1 | 1  | 1
```

Uso: **estrarre bit**. Una maschera di 1 conserva i bit, una maschera di 0 azzera.

### ORA (Bitwise OR)

```asm
ORA operand    ; A ← A ORA operand (bit-by-bit)
```

Truth table:
```
A | op | result
--|----|---------
0 | 0  | 0
0 | 1  | 1
1 | 0  | 1
1 | 1  | 1
```

Uso: **settare bit**. Una maschera di 1 setta i bit, una maschera di 0 non li modifica.

### EOR (Bitwise XOR / EXclusive OR)

```asm
EOR operand    ; A ← A EOR operand (bit-by-bit)
```

Truth table:
```
A | op | result
--|----|---------
0 | 0  | 0
0 | 1  | 1
1 | 0  | 1
1 | 1  | 0
```

Uso: **invertire (toggle) bit**. Una maschera di 1 inverte, una maschera di 0 non modifica.

### Opcode e flag

| Istruzione | Opcode (immediato) | Bytes | Cicli | Flag |
|-----------|-------------------|-------|-------|------|
| AND       | `$29`             | 2     | 2     | Z, N |
| ORA       | `$09`             | 2     | 2     | Z, N |
| EOR       | `$49`             | 2     | 2     | Z, N |

Settano Z e N, non modificano C o V.

---

## 🤖 Come ragiona il 6510

### `AND #$0F` con A=$A5 (1010 0101)

1. **Fetch opcode**: `$29`
2. **Fetch operando**: `$0F` (0000 1111)
3. **AND bit-by-bit**:
   ```
   1010 0101
   0000 1111
   ---------
   0000 0101 = $05
   ```
4. **Set flags**: Z=0 (risultato ≠ 0), N=0 (bit 7 = 0)

### `ORA #$F0` con A=$0A (0000 1010)

1. **Fetch opcode**: `$09`
2. **Fetch operando**: `$F0` (1111 0000)
3. **ORA bit-by-bit**:
   ```
   0000 1010
   1111 0000
   ---------
   1111 1010 = $FA
   ```
4. **Set flags**: Z=0, N=1 (bit 7 = 1)

---

## 💡 Esempio pratico

```asm
; Lezione 025 — Operazioni logiche
; Manipolazione di bit
*= $0801

; Estrai il nibble basso (4 bit bassi)
LDA #$A5       ; 1010 0101
AND #$0F       ; AND con 0000 1111
; Risultato: 0000 0101 = $05 (nibble basso estratto)

; Setta il bit 3 (aggiungi $08)
LDA #$42       ; 0100 0010
ORA #$08       ; ORA con 0000 1000
; Risultato: 0100 1010 = $4A (bit 3 settato)

; Inverti il bit 7
LDA #$00       ; 0000 0000
EOR #$80       ; EOR con 1000 0000
; Risultato: 1000 0000 = $80 (bit 7 invertito da 0 a 1)

; Azzera i bit alti (mantieni i bassi)
LDA #$FF       ; 1111 1111
AND #$0F       ; AND con 0000 1111
; Risultato: 0000 1111 = $0F (solo nibble basso)

RTS
```

Compila:

```bash
64tass --cbm-prg -o bin/025.prg src/modulo-7/025.asm
```

---

## ⚠️ Errori comuni

- **Confondere AND/ORA**: AND azzera i bit, ORA li setta.
- **Invertire la maschera**: se vuoi estrarre i bit bassi, usa `AND #$0F`, non `AND #$F0`.
- **EOR per azzera**: EOR inverte, non azzera. Per azzera, usa `AND #$00` o `LDA #$00`.

---

## 🧪 Esercizi

1. Estrai il bit 7 da A usando AND: `AND #$80` e verifica con BEQ/BMI.
2. Setta il bit 5: `ORA #$20`.
3. Inverti tutti i bit usando `EOR #$FF` (il complemento).

---

## 📌 Riassunto

| Concetto  | Spiegazione                              |
|-----------|------------------------------------------|
| AND       | Azzera i bit dove la maschera è 0       |
| ORA       | Setta i bit dove la maschera è 1        |
| EOR       | Inverte i bit dove la maschera è 1      |
| Flag      | Z, N modificati; C, V non modificati    |
| Uso tipico| Maschere, flag checking, bit toggling   |

---

## 🔜 Preparazione alla lezione successiva

Nella lezione 026 vedremo **Shift operations**: ASL, LSR, ROL, ROR per spostare i bit a sinistra/destra.

---

## 🔎 Approfondimento — Dentro il 6510

**Applicazioni pratiche:**

```asm
; Controlla se il bit 7 è settato
BIT $40        ; oppure: LDA $40 AND #$80
BEQ bit7_not_set

; Azzera il byte pari di colore
LDA $D020      ; leggi colore
AND #$0F       ; mantieni solo nibble basso (azzera alto)
STA $D020      ; scrivi back
```

---

## ✅ Checklist finale

- [ ] l'esempio compila con `64tass`
- [ ] AND, ORA, EOR funzionano correttamente
- [ ] le maschere di bit sono corrette
- [ ] il contenuto è progressivo rispetto alle lezioni precedenti
