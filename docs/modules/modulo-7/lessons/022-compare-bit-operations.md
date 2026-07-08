[🏠 Home](../../../index.md)

# Lezione 022 — Compare e BIT test operations

> **Obiettivo:** capire come usare CMP/CPX/CPY per confrontare senza modifica, e BIT per testare bit specifici.

---

## 🎯 Obiettivi

- comprendere CMP, CPX, CPY e come settano i flag;
- usare BIT per testare bit specifici di una cella;
- implementare logica di confronto complessa;
- scegliere tra CMP e BIT a seconda del caso d'uso.

---

## 🧠 Introduzione

Spesso vogliamo **confrontare valori senza modificarli**.

`CMP A, memoria` è come `SBC` ma non modifica A:

```asm
CMP #$50       ; confronta A con $50
; A rimane invariato
; Ma Z, C, N sono settati in base al risultato
```

`BIT` è ancora più specifico: testa se **certi bit** di una cella sono settati.

---

## 📘 Teoria

### CMP, CPX, CPY

| Istruzione | Operazione | Flag |
|-----------|-----------|------|
| CMP | A - memoria | Z, C, N |
| CPX | X - memoria | Z, C, N |
| CPY | Y - memoria | Z, C, N |

**Sottrae senza modificare il registro**, ma setta:
- **Z = 1**: se A == memoria (risultato = 0)
- **C = 0**: se A < memoria (borrow)
- **C = 1**: se A ≥ memoria (no borrow)
- **N = 1**: se A < memoria (signed)

### Opcode e cicli

| Istruzione | Immediato | Zero Page | Absolute |
|-----------|-----------|-----------|----------|
| CMP | `$C9` (2 cicli) | `$C5` (3) | `$CD` (4) |
| CPX | `$E0` (2) | `$E4` (3) | `$EC` (4) |
| CPY | `$C0` (2) | `$C4` (3) | `$CC` (4) |

### BIT - Bit test

```asm
BIT addr       ; testa i bit di addr senza modificare A
```

**BIT** setta i flag direttamente dai bit della cella:

1. **Z**: è 1 se (A AND memoria) = 0
2. **N**: prende il bit 7 di memoria (non di A!)
3. **V**: prende il bit 6 di memoria

A rimane invariato.

### Opcode e cicli

| Modalità      | Opcode | Bytes | Cicli |
|---------------|--------|-------|-------|
| Zero Page     | `$24`  | 2     | 3     |
| Absolute      | `$2C`  | 3     | 4     |

---

## 🤖 Come ragiona il 6510

### `CMP #$50` con A = $40

1. **Fetch opcode**: `$C9`
2. **Fetch dato**: `$50`
3. **Subtract**: A - $50 = $40 - $50 = -$10 (risultato negativo)
4. **Set flags**:
   - Z = 0 (risultato non è zero)
   - C = 0 (A < $50, c'è borrow)
   - N = 1 (risultato è negativo)

Dopo: BCS **non salta** (carry = 0), BPL **non salta** (N = 1).

### `BIT $40` con A = $FF e memoria[$40] = $C0

1. **Fetch opcode**: `$24`
2. **Fetch indirizzo**: `$40`
3. **Read**: legge memoria[$40] = $C0 = 1100 0000
4. **Test**: A AND $C0 = $FF AND $C0 = $C0 ≠ 0
5. **Set flags**:
   - Z = 0 (A AND memoria ≠ 0)
   - N = 1 (bit 7 di memoria = 1)
   - V = 1 (bit 6 di memoria = 1)

---

## 💡 Esempio pratico

```asm
; Lezione 022 — Compare e BIT test operations
; Confronta valori e testa bit
*= $0801

; Variabile in Zero Page
value = $02

; Carica un valore
LDA #$50

; Confronta con una soglia
CMP #$40
BCC below    ; salta se A < $40
; A >= $40
LDA #$03     ; colore ciano
JMP set_color

below:
  LDA #$01   ; colore bianco

set_color:
  STA $D020  ; visualizza il risultato

; Testa se un bit è settato
BIT value    ; testa memoria[value]
BMI bit7set  ; salta se bit 7 è settato
; bit 7 non è settato
BVC bit6notset
; bit 6 è settato
JMP done

bit7set:
  ; bit 7 è settato
  JMP done

bit6notset:
  ; bit 6 non è settato
  JMP done

done:
  RTS
```

Compila:

```bash
64tass --cbm-prg -o bin/022.prg src/modulo-7/022.asm
```

---

## ⚠️ Errori comuni

- **Confondere CMP con SBC**: CMP non modifica A, SBC sì.
- **Dimenticare il significato di C**: C = 0 significa A < memoria (borrow). C = 1 significa A ≥ memoria.
- **Usare BIT per test complessi**: BIT testa solo bit 6 e 7 via N/V. Per altri bit, usi AND e CMP.

---

## 🧪 Esercizi

1. Confronta A con una serie di soglie e salta a routine diverse.
2. Usa BIT per testare se il bit 7 di una variabile è settato.
3. Implementa un validatore: se A < 100 AND A > 50, procedi; altrimenti ritorna.

---

## 📌 Riassunto

| Concetto        | Spiegazione                                      |
|-----------------|--------------------------------------------------|
| CMP / CPX / CPY | Confronta senza modifica, setta Z/C/N           |
| Z flag          | 1 se uguali, 0 se diversi                        |
| C flag          | 0 se A < memoria, 1 se A ≥ memoria              |
| BIT             | Testa A AND memoria, setta Z da risultato        |
| N/V da BIT      | Prendono i bit 7/6 di memoria, non da A         |

---

## 🔜 Preparazione alla lezione successiva

Abbiamo completato i comandi fondamentali del 6510. Prossimi moduli: operazioni aritmetiche avanzate, I/O, periferiche, grafica.

---

## 🔎 Approfondimento — Dentro il 6510

**Uso di CMP per loop:**

```asm
LDX #$00
loop:
  ; codice
  INX
  CPX #$10       ; confronta X con 16
  BNE loop       ; ripeti se X ≠ 16
```

**Uso di BIT per testare flag hardware:**

```asm
BIT $D019      ; testa il registro VIC-II IRQ
BMI interrupt_occurred
```

---

## ✅ Checklist finale

- [ ] l'esempio compila con `64tass`
- [ ] CMP confronta correttamente e setta i flag
- [ ] BIT testa i bit e setta N/V
- [ ] il contenuto è progressivo rispetto alle lezioni precedenti
