[🏠 Home](../../../index.md)

# Lezione 020 — Operazioni di stack avanzate

> **Obiettivo:** capire come usare TSX/TXS/PHP/PLP per manipolare direttamente lo stack pointer e salvare il processor status.

---

## 🎯 Obiettivi

- comprendere i trasferimenti TSX/TXS tra X e Stack Pointer;
- usare PHP/PLP per salvare e ripristinare il processor status;
- manipolare direttamente lo stack;
- implementare logica di diagnostica su stack.

---

## 🧠 Introduzione

Finora abbiamo usato PHA/PLA per salvare A.

Ma spesso vogliamo:
- **Leggere o scrivere lo Stack Pointer**: TSX (Transfer Stack to X), TXS (Transfer X to Stack)
- **Salvare i flag**: PHP (Push Processor status), PLP (Pull Processor status)

Queste operazioni sono essenziali per:
- Salvare/ripristinare lo stato completo del processore
- Manipolare lo stack per trucchi avanzati
- Diagnosticare lo stato della stack durante debugging

---

## 📘 Teoria

### TSX e TXS

| Istruzione | Effetto | Flag |
|-----------|---------|------|
| TSX | X ← SP | Z, N |
| TXS | SP ← X | None |

**TSX** copia lo Stack Pointer in X (leggi dove è lo stack).
**TXS** copia X nello Stack Pointer (scrivi dove deve essere lo stack).

### PHP e PLP

| Istruzione | Effetto | Cicli |
|-----------|---------|-------|
| PHP | Stack ← SR (processor status) | 3 |
| PLP | SR ← Stack | 4 |

**PHP** salva i flag (N, V, B, D, I, Z, C) sullo stack in una sola istruzione.
**PLP** ripristina i flag dallo stack.

### Uso comune

```asm
; Salva tutti i flag
PHP

; Cambia i flag (es: ADC modifica Z, C, V, N)
LDA #$7F
ADC #$01

; Ripristina i flag originali
PLP
```

### Stack Pointer nel 6510

Lo Stack Pointer (SP) è contenuto in `$0100 + SP`.

Lo stack cresce verso il basso (dalla `$01FF` verso `$0100`).

```
SP = $FF → stack in $01FF
SP = $00 → stack in $0100
```

Quando fai PUSH, SP viene decrementato.
Quando fai POP, SP viene incrementato.

---

## 🤖 Come ragiona il 6510

### TSX

1. **Fetch opcode**: `$BA`
2. **Read SP**: legge il valore corrente dello SP
3. **Transfer**: X ← SP
4. **Set flags**: Z se X = 0, N se X ≥ $80

### TXS

1. **Fetch opcode**: `$9A`
2. **Write SP**: SP ← X
3. **No flags changed**

### PHP

1. **Fetch opcode**: `$08`
2. **Prepare status**: raccoglie i flag in un byte
3. **Push**: decrementa SP e scrive il byte sullo stack

### PLP

1. **Fetch opcode**: `$28`
2. **Pop**: incrementa SP e legge il byte dallo stack
3. **Restore**: carica il byte nei flag

---

## 💡 Esempio pratico

```asm
; Lezione 020 — Operazioni di stack avanzate
; Salva e ripristina lo stato del processore
*= $0801

; Salva i flag attuali
PHP

; Simula un'operazione che cambia i flag
LDA #$FF
ADC #$01       ; overflow, carry, ecc.

; Qui i flag sono cambiati

; Ripristina i flag originali
PLP

; I flag sono tornati allo stato prima dell'ADC

; Leggi lo Stack Pointer attuale
TSX            ; X ← SP
; X contiene ora il valore dello SP (per debug)

; Modifica lo SP (attenzione! è pericoloso)
; TXS            ; SP ← X

RTS
```

Compila:

```bash
64tass --cbm-prg -o bin/020.prg src/modulo-6/020.asm
```

---

## ⚠️ Errori comuni

- **Confondere TSX con PHA**: TSX modifica X ma non usa lo stack. PHA modifica lo stack.
- **Usare TXS senza sapere cosa fai**: modificare lo SP può rompere lo stack. Usa solo se intendi salvare/ripristinare in coppia.
- **Dimenticare che PHP salva il flag B**: il flag B è settato a 1 da PHP quando pushato, e a 0 in altre circostanze.

---

## 🧪 Esercizi

1. Usa TSX per leggere il valore dello SP e scrivilo nel bordo (per debug).
2. Salva i flag con PHP, cambia A con diverse operazioni, ripristina con PLP.
3. Usa TXS per spostare lo stack (avanzato, pericoloso!).

---

## 📌 Riassunto

| Concetto       | Spiegazione                              |
|-----------------|------------------------------------------|
| TSX             | Transfer Stack Pointer to X              |
| TXS             | Transfer X to Stack Pointer              |
| PHP             | Push Processor status on stack           |
| PLP             | Pull Processor status from stack         |
| Stack Pointer   | Contiene l'offset di $0100–$01FF         |
| Processor Status | Byte contente tutti i 6 flag             |

---

## 🔜 Preparazione alla lezione successiva

Nella lezione 021 vedremo **INC/DEC in memoria**: come incrementare/decrementare direttamente celle di memoria, oltre ai registri.

---

## 🔎 Approfondimento — Dentro il 6510

**Byte di processor status (salvato da PHP):**

```
Bit 7: N (Negative)
Bit 6: V (oVerflow)
Bit 5: unused (sempre 1 quando pushato)
Bit 4: B (Break flag)
Bit 3: D (Decimal mode)
Bit 2: I (Interrupt Disable)
Bit 1: Z (Zero)
Bit 0: C (Carry)
```

PHP aggiunge il bit B e il bit 5 come 1 quando salva.

---

## ✅ Checklist finale

- [ ] l'esempio compila con `64tass`
- [ ] TSX legge correttamente lo Stack Pointer
- [ ] PHP/PLP salvano e ripristinano i flag
- [ ] il contenuto è progressivo rispetto alle lezioni precedenti
