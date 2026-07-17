[🏠 Home](../../../index.md)

# Lezione 25 — Indirizzamento indiretto indicizzato

> **Obiettivo:** capire come combinare indirizzamento indiretto con indexing per navigare array di strutture e liste.

---

## 🎯 Obiettivi

- comprendere l'indirizzamento indiretto indicizzato con X e Y;
- usare puntatori + indexing per traversare strutture dati;
- distinguere tra `(addr,X)` (indexed indirect) e `(addr),Y` (indirect indexed);
- implementare cicli su strutture complesse.

---

## 🧠 Introduzione

Nella lezione 017 abbiamo visto puntatori semplici: `LDA ($40)`.

Ma spesso vogliamo leggere da un **offset dentro una struttura puntata**.

Esempi:
- Array di strutture: leggi il campo N di una struttura
- Matrice: accedi a `matrix[row][col]`
- Record dati: puntatore al record + offset al campo

**Indirect Indexed** risolve questo.

---

## 📘 Teoria

### Due modalità: Indexed Indirect vs Indirect Indexed

#### 1. Indexed Indirect: `(addr,X)`

```asm
LDA ($40,X)    ; indirizzo_effettivo = ($40 + X)
```

1. Aggiungi X a `$40` (wrapping in ZP)
2. Leggi l'indirizzo da `($40 + X)` e `($40 + X + 1)`
3. Leggi il dato da quell'indirizzo

Uso: **lista di puntatori**, e X seleziona quale puntatore.

#### 2. Indirect Indexed: `(addr),Y`

```asm
LDA ($40),Y    ; indirizzo_effettivo = ($40) + Y
```

1. Leggi l'indirizzo da `$40` e `$41`
2. Aggiungi Y a quell'indirizzo
3. Leggi il dato

Uso: **array in memoria**, dove il puntatore punta all'inizio, Y è l'offset.

### Opcode e performance

| Modalità             | Opcode | Bytes | Cicli |
|---------------------|--------|-------|-------|
| Indexed Indirect    | `$A1`  | 2     | 6     |
| Indirect Indexed    | `$B1`  | 2     | 5*    |

*+ 1 ciclo se Y attraversa page boundary.

---

## 🤖 Come ragiona il 6510

#### `LDA ($40,X)` con X = $02, `$42` = $00, `$43` = $04

1. **Fetch**: opcode `$A1`
2. **Fetch**: puntatore `$40`
3. **Calculate**: `$40 + X = $42`
4. **Read indirizzo basso**: da `$42` → `$00`
5. **Read indirizzo alto**: da `$43` → `$04`
6. **Calculate**: indirizzo effettivo = `$0400`
7. **Read**: legge da `$0400`

#### `LDA ($40),Y` con Y = $05, `$40` = $00, `$41` = $04

1. **Fetch**: opcode `$B1`
2. **Fetch**: puntatore `$40`
3. **Read indirizzo basso**: da `$40` → `$00`
4. **Read indirizzo alto**: da `$41` → `$04`
5. **Calculate**: indirizzo effettivo = `$0400 + Y = $0405`
6. **Read**: legge da `$0405`

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
; Lezione 018 — Indirizzamento indiretto indicizzato
; Leggi da un array usando puntatore + offset


    .word 0


; Setup puntatore base in Zero Page
	LDA #<data
	STA $40
	LDA #>data
	STA $41

start:
	LDX #$00
	LDA ($40,X)    ; indexed indirect: legge da indirizzo puntato da $40/$41
	STA $D020

	LDY #$01
	LDA ($40),Y    ; indirect indexed: legge da (puntatore + Y)
	STA $D021

	RTS

data:
	.byte $06,$0B
```

Compila:

```bash
64tass --cbm-prg -o bin/018.prg src/modulo-5/018.asm
```

---

## ⚠️ Errori comuni

- **Confondere le due modalità**: `(addr,X)` usa X per selezionare il puntatore; `(addr),Y` usa Y per l'offset.
- **Wraparound in Zero Page**: `($FF,X)` con X=$01 legge da `$00` e `$01`, non da `$100`.
- **Boundary crossing**: `(addr),Y` costa un ciclo extra se attraversa page boundary.
- **Inizializzazione di puntatori**: devi memorizzare i puntatori prima di usarli.

---

## 🧪 Esercizi

1. Crea un array di puntatori e usa `(addr,X)` per accedere a diversi array.
2. Usa `(addr),Y` per copiare 10 byte da un array a un altro.
3. Implementa una lista collegata usando indirect indexed addressing.

---

## 📌 Riassunto

| Concetto                   | Spiegazione                                      |
|---------------------------|--------------------------------------------------|
| Indexed Indirect `(addr,X)` | X seleziona il puntatore in ZP                   |
| Indirect Indexed `(addr),Y` | Y è l'offset dentro la struttura puntata         |
| Puntatori                  | Memorizzati consecutivamente in ZP               |
| Cicli                      | 6 (indexed indirect), 5–6 (indirect indexed)    |
| Wraparound                 | In ZP per indexed indirect, in memoria per Y    |

---

## 🔜 Preparazione alla lezione successiva

Nella lezione 019 vedremo altri **salti condizionati**: BCC/BCS (carry), BVC/BVS (overflow).

---

## 🔎 Approfondimento — Dentro il 6510

**Tabella di indirizzamento indiretto:**

```
LDA ($40,X)   → Indexed Indirect  (6 cicli)
LDA ($40),Y   → Indirect Indexed  (5+ cicli)
JMP ($40,X)   → Non supportato direttamente
JSR ($40,X)   → Non supportato direttamente
```

**Uso tipico:**

```asm
; Array di puntatori
$40: $00 $04   (puntatore a $0400)
$42: $00 $05   (puntatore a $0500)
$44: $00 $06   (puntatore a $0600)

; Accedi al puntatore in posizione X
LDX #$02
LDA ($40,X)    ; legge da ($44/$45 + 0) = $0600
```

---

## 🔎 Approfondimento - Dentro il 6510

Con le modalita di indirizzamento, la stabilita si ottiene scegliendo sempre il modo piu adatto al dato e al costo in cicli. Distinguere con precisione immediate, zero page e assoluto riduce errori logici e regressioni.

## ✅ Checklist finale

- [ ] l'esempio compila con `64tass`
- [ ] i puntatori sono inizializzati correttamente
- [ ] sia `(addr,X)` che `(addr),Y` funzionano
- [ ] il contenuto è progressivo rispetto alle lezioni precedenti
