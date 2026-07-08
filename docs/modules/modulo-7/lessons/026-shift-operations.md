[🏠 Home](../../../index.md)

# Lezione 026 — Shift operations: ASL, LSR, ROL, ROR

> **Obiettivo:** capire come spostare i bit a sinistra/destra usando ASL (Arithmetic Shift Left), LSR (Logical Shift Right), ROL (Rotate Left), ROR (Rotate Right).

---

## 🎯 Obiettivi

- comprendere ASL, LSR, ROL, ROR e le loro differenze;
- usare shift per moltiplicazione/divisione veloci;
- usare rotate per manipolazione circolare di bit;
- implementare operazioni di bit shifting multi-byte.

---

## 🧠 Introduzione

A volte vogliamo **spostare i bit** a sinistra o destra:

- **Shift left**: sposta tutti i bit verso sinistra, bit più basso diventa 0
- **Shift right**: sposta tutti i bit verso destra, bit più alto diventa 0
- **Rotate**: sposta ma "avvolge" il bit che esce al lato opposto

Usi:
- Moltiplicazione/divisione veloci per 2
- Manipolazione di dati compattati
- Estrazione di bit da byte

---

## 📘 Teoria

### ASL (Arithmetic Shift Left)

```asm
ASL            ; A ← A << 1 (shift a sinistra)
ASL addr       ; memoria[addr] ← memoria[addr] << 1
```

Operazione:
```
Bit: 7 6 5 4 3 2 1 0
     ↙ ↙ ↙ ↙ ↙ ↙ ↙
         C ← 0
```

Il bit 7 va in C, il bit 0 diventa 0.

### LSR (Logical Shift Right)

```asm
LSR            ; A ← A >> 1 (shift a destra)
LSR addr       ; memoria[addr] ← memoria[addr] >> 1
```

Operazione:
```
Bit: 7 6 5 4 3 2 1 0
             ↘ ↘ ↘ ↘ ↘ ↘ ↘ ↘
         C ←
              0 →
```

Il bit 0 va in C, il bit 7 diventa 0.

### ROL (Rotate Left)

```asm
ROL            ; ruota A a sinistra via carry
```

Operazione:
```
Bit: 7 6 5 4 3 2 1 0
     ↙ ↙ ↙ ↙ ↙ ↙ ↙
         C ← ↺ ← C
```

Il bit 7 va in C, C va nel bit 0.

### ROR (Rotate Right)

```asm
ROR            ; ruota A a destra via carry
```

Operazione:
```
Bit: 7 6 5 4 3 2 1 0
                   ↘ ↘ ↘ ↘ ↘ ↘ ↘ ↘
         C → ↻ → C
```

Il bit 0 va in C, C va nel bit 7.

### Flag e opcode

| Istruzione | Opcode (A) | Bytes | Cicli | Flag |
|-----------|-----------|-------|-------|------|
| ASL A     | `$0A`     | 1     | 2     | Z, N, C |
| LSR A     | `$4A`     | 1     | 2     | Z, N, C |
| ROL A     | `$2A`     | 1     | 2     | Z, N, C |
| ROR A     | `$6A`     | 1     | 2     | Z, N, C |

Anche ASL/LSR/ROL/ROR supportano memoria (Zero Page, Absolute, con indexing).

---

## 🤖 Come ragiona il 6510

### `ASL` con A = $81 (1000 0001), C = 0

1. **Fetch opcode**: `$0A`
2. **Shift**: sposta tutti i bit a sinistra
   ```
   1000 0001 → 0000 0010, C = 1 (bit 7 uscito)
   ```
3. **Set flags**: Z=0, N=0, C=1

### `ROR` con A = $01 (0000 0001), C = 1

1. **Fetch opcode**: `$6A`
2. **Rotate**: sposta via carry
   ```
   0000 0001 → 1000 0000, C = 1 (bit 0 in C, C in bit 7)
   ```
3. **Set flags**: Z=0, N=1, C=1

---

## 💡 Esempio pratico

```asm
; Lezione 026 — Shift operations
; Spostamento e rotazione di bit
*= $0801

; Moltiplicazione per 2 (shift left)
LDA #$50       ; 0101 0000
ASL            ; shift a sinistra → 1010 0000 = $A0 (moltiplicato per 2)

; Divisione per 2 (logical shift right)
LDA #$80       ; 1000 0000
LSR            ; shift a destra → 0100 0000 = $40 (diviso per 2)

; Estrai il bit 7 con rotate
LDA #$80       ; 1000 0000
ROL            ; ruota a sinistra → 0000 0000 con C=1
BCS bit7_set   ; salta se bit 7 era settato

; Multi-byte shift (es: 16 bit left shift)
CLC            ; azzera carry
LDA $02        ; byte basso
ASL            ; shift a sinistra
STA $02        ; salva byte basso

LDA $03        ; byte alto
ROL            ; ruota con carry dal byte basso
STA $03        ; salva byte alto

bit7_set:
  RTS
```

Compila:

```bash
64tass --cbm-prg -o bin/026.prg src/modulo-7/026.asm
```

---

## ⚠️ Errori comuni

- **Confondere ASL con ROL**: ASL azzera il bit 0, ROL lo prende dal carry.
- **LSR e ROR**: LSR azzera il bit 7, ROR lo prende dal carry.
- **Multi-byte shifts**: devi concatenare gli shift via carry, ASL per il primo byte, ROL/ROR per i successivi.
- **Carry non pulito**: prima di una sequenza di shift, usa CLC per azzera il carry.

---

## 🧪 Esercizi

1. Moltiplica un numero per 4: `ASL` due volte.
2. Dividi per 8: `LSR` tre volte.
3. Ruota A a sinistra 8 volte (rotazione completa): `ROL` 8 volte e verifica che torna al valore originale.

---

## 📌 Riassunto

| Istruzione | Effetto              | Carry |
|-----------|----------------------|-------|
| ASL       | Shift left, bit 7 → C | Bit 7 |
| LSR       | Shift right, 0 ← C   | Bit 0 |
| ROL       | Rotate left via C    | Bit 7 |
| ROR       | Rotate right via C   | Bit 0 |

---

## 🔜 Preparazione alla lezione successiva

Con la lezione 026, abbiamo coperto tutti i comandi fondamentali del 6510. Prossimi moduli: I/O, periferiche, grafica, sound.

---

## 🔎 Approfondimento — Dentro il 6510

**Moltiplicazione veloce per potenze di 2:**

```asm
LDA #$10
ASL            ; * 2 = $20
ASL            ; * 4 = $40
ASL            ; * 8 = $80 (nota: overflow se LSB = 1 in origine)
```

**Divisione veloce:**

```asm
LDA #$80
LSR            ; / 2 = $40
LSR            ; / 4 = $20
LSR            ; / 8 = $10
```

---

## ✅ Checklist finale

- [ ] l'esempio compila con `64tass`
- [ ] ASL/LSR funzionano per shift
- [ ] ROL/ROR funzionano per rotate
- [ ] il multi-byte shift funziona via carry
- [ ] il contenuto è progressivo rispetto alle lezioni precedenti
