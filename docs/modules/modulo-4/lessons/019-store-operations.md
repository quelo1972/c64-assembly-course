[🏠 Home](../../../index.md)

# Lezione 19 — Store operations: STA, STX, STY

> **Obiettivo:** capire come scrivere dati dalla CPU alla memoria usando STA, STX, STY è le diverse modalità di indirizzamento.

---

## 🎯 Obiettivi

- comprendere STA, STX, STY è quando usarli;
- usare tutte le modalità di indirizzamento con store;
- confrontare con load operations;
- implementare logica di scrittura in memoria.

---

## 🧠 Introduzione

Finora abbiamo principalmente **letto** dalla memoria con LDA/LDX/LDY.

Ma per creare programmi utili, dobbiamo **scrivere** nella memoria.

**STA** scrive il registro A in memoria.
**STX** scrive il registro X in memoria.
**STY** scrive il registro Y in memoria.

Sono il complemento di LDA/LDX/LDY.

---

## 📘 Teoria

### Sintassi

```asm
STA addr       ; memoria[addr] ← A
STX addr       ; memoria[addr] ← X
STY addr       ; memoria[addr] ← Y
```

Supportano tutte le modalità di indirizzamento (tranne Immediate, non ha senso):

| Modalità          | Opcode (STA) | Bytes | Cicli |
|-------------------|--------------|-------|-------|
| Zero Page         | `$85`        | 2     | 3     |
| Zero Page, X      | `$95`        | 2     | 4     |
| Absolute          | `$8D`        | 3     | 4     |
| Absolute, X       | `$9D`        | 3     | 5     |
| Absolute, Y       | `$99`        | 3     | 5     |
| Indirect, X       | `$81`        | 2     | 6     |
| Indirect, Y       | `$91`        | 2     | 6     |

### Flag

Store operations **non modificano alcun flag**: Z, C, N, V rimangono invariati.

### Differenze STX/STY

STX e STY hanno meno modalità supportate:

```asm
STX addr       ; Assoluto, Zero Page, Zero Page Y (no X)
STY addr       ; Assoluto, Zero Page, Zero Page X (no Y)
```

---

## 🤖 Come ragiona il 6510

### `STA $D020`

1. **Fetch opcode**: `$8D` (STA assoluto)
2. **Fetch indirizzo basso**: `$20`
3. **Fetch indirizzo alto**: `$D0`
4. **Write**: memoria[$D020] ← A
5. **Nessun flag modificato**

In totale: **3 byte**, **4 cicli**.

### `STA $40,X` con X = $05

1. **Fetch opcode**: `$95` (STA ZP, X)
2. **Fetch indirizzo**: `$40`
3. **Calculate**: `$40 + X = $45`
4. **Write**: memoria[$45] ← A
5. **Nessun flag modificato**

In totale: **2 byte**, **4 cicli**.

---

## 💡 Esempio pratico

```asm
; Lezione 023 — Store operations
; Scrivi dati nella memoria
*= $0801

; Scrivi il colore bianco nel bordo
LDA #$01
STA $D020

; Scrivi una sequenza di byte in Zero Page
LDA #$42       ; 'B'
STA $02
LDA #$43       ; 'C'
STA $03
LDA #$44       ; 'D'
STA $04

; Scrivi usando indicizzazione
LDX #$00
LDA #$FF
STA $0400,X    ; scrivi in schermo + 0

LDX #$01
STA $0400,X    ; scrivi in schermo + 1

RTS
```

Compila:

```bash
64tass --cbm-prg -o bin/023.prg src/modulo-4/023.asm
```

---

## ⚠️ Errori comuni

- **Assumere che STA modifichi A**: A rimane invariato. STA è una copia, non una move.
- **Confondere STX e STY**: STX scrive X, STY scrive Y. Diversi registri.
- **Dimenticare le limitazioni di STX/STY**: hanno meno modalità di STA.
- **Flag rimasti dopo store**: store operations non cambiano flag, quindi CMP prima di STA ha effetto duraturo.

---

## 🧪 Esercizi

1. Scrivi una sequenza di byte (es: "HELLO") in screen RAM (`$0400`).
2. Usa STX e STY per scrivere i valori dei registri X e Y in Zero Page.
3. Scrivi in un array usando indexing con X/Y.

---

## 📌 Riassunto

| Concetto   | Spiegazione                              |
|-----------|------------------------------------------|
| STA       | Store A in memory                       |
| STX       | Store X in memory                       |
| STY       | Store Y in memory                       |
| Modalità  | Zero Page, ZP,X/Y, Absolute, Abs,X/Y, Indirect |
| Flag      | Non modificati da store operations       |
| Cicli     | 3–6 dipende dalla modalità               |

---

## 🔜 Preparazione alla lezione successiva

Nella lezione 024 vedremo **Addizione e sottrazione**: ADC e SBC con gestione del carry.

---

## 🔎 Approfondimento — Dentro il 6510

**Distinzione STX vs STY:**

```
STA: tutte le modalità
STX: addr, addr,Y (nota Y, non X!)
STY: addr, addr,X (nota X, non Y!)
```

Questo è dovuto all'architettura del 6510: X è l'index per addressing esterno, Y è l'index per indirect indexed.

---

## 🔎 Approfondimento - Dentro il 6510

Nelle store operation, la stabilita deriva dal controllo del punto di scrittura: indirizzo giusto, timing corretto e verifica dell effetto in memoria. Scrivere con intenzione previene bug silenziosi difficili da isolare.

## ✅ Checklist finale

- [ ] l'esempio compila con `64tass`
- [ ] STA scrive correttamente in memoria
- [ ] i diversi modalità di indirizzamento funzionano
- [ ] il contenuto è progressivo rispetto alle lezioni precedenti
