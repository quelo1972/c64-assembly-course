[🏠 Home](../../../index.md)

# Lezione 28 — Salti condizionati: Carry e Overflow

> **Obiettivo:** capire come usare i flag C (Carry) e V (oVerflow) per condizionare salti, utili in operazioni aritmetiche.

---

## 🎯 Obiettivi

- comprendere il flag C (Carry) è quando viene settato;
- comprendere il flag V (oVerflow) per aritmetica signed;
- usare BCC/BCS per salti su carry;
- usare BVC/BVS per salti su overflow;
- implementare logica di validazione su aritmetica.

---

## 🧠 Introduzione

Finora abbiamo usato BEQ/BNE (flag Z) e BPL/BMI (flag N).

Il flag **C (Carry)** è settato da operazioni aritmetiche quando c'è overflow:
- `ADC` crea carry se il risultato > 255
- `SBC` crea carry se il risultato < 0 (borrow)

Il flag **V (oVerflow)** è settato quando il risultato signed è fuori range:
- Range signed: -128 a +127
- Se sommi due positivi e ottieni un negativo, V = 1

Questi flag sono fondamentali per validare operazioni aritmetiche.

---

## 📘 Teoria

### Flag C (Carry)

| Istruzione | Causa C = 1 | Causa C = 0 |
|-----------|------------|-----------|
| ADC | Risultato > 255 | Risultato ≤ 255 |
| SBC | Risultato < 0 (borrow) | Risultato ≥ 0 |
| ASL | Bit 7 del risultato | Bit 7 = 0 |
| LSR | Bit 0 del risultato | Bit 0 = 0 |

### Flag V (oVerflow)

Setato se il risultato **signed** è fuori range:

```asm
LDA #$7F       ; +127 (max positivo)
ADC #$02       ; aggiungi 2
; risultato = 129 (fuori range)
; V = 1 (overflow)
```

### Salti su Carry

| Istruzione | Salta se | Opcode | Uso |
|-----------|----------|--------|-----|
| BCC | C = 0 (no carry) | `$90` | Risultato OK |
| BCS | C = 1 (carry) | `$B0` | Overflow aritmetico |

### Salti su Overflow

| Istruzione | Salta se | Opcode | Uso |
|-----------|----------|--------|-----|
| BVC | V = 0 (no overflow) | `$50` | Risultato signed OK |
| BVS | V = 1 (overflow) | `$70` | Overflow signed |

---

## 🤖 Come ragiona il 6510

`ADC #$80` con A = $80:

1. **Fetch opcode**: `$69` (ADC immediato)
2. **Fetch dato**: `$80`
3. **Add**: A + $80 = $80 + $80 = $100
4. **Set flags**:
   - Risultato troncato a 8 bit = $00 → Z = 1
   - Carry da bit 7 → C = 1
   - Overflow signed (negativo + negativo = positivo) → V = 1

Dopo questa operazione:
- BCS salta (carry è settato)
- BVS salta (overflow è settato)
- BEQ salta (risultato è zero)

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
; Lezione 019 — Salti su Carry e Overflow
; Valida operazioni aritmetiche


    .word 0


; Somma con validazione di carry
LDA #$FF       ; carica 255
ADC #$02       ; aggiungi 2 → risultato = $101 = 1 con C=1

BCS carry_set  ; se c'è carry, salta
JMP no_carry

carry_set:
  LDA #$05     ; colore verde (debug)
  JMP set_color

no_carry:
  LDA #$01     ; colore bianco (debug)

set_color:
  STA $D020    ; visualizza il risultato nel bordo
  RTS
```

Compila:

```bash
64tass --cbm-prg -o bin/019.prg src/modulo-6/019.asm
```

---

## ⚠️ Errori comuni

- **Confondere C e V**: C è per operazioni unsigned, V per signed.
- **Dimenticare che ADC/SBC cambiano C**: ogni addizione/sottrazione setta questi flag.
- **Assumere V dalla semplice somma**: V è un concetto signed, è complesso. Usa solo se sai cosa fai.

---

## 🧪 Esercizi

1. Scrivi un loop che somma numeri finché non c'è carry, poi ferma.
2. Valida una sottrazione: se borrow (C=1 dopo SBC), il risultato era negativo.
3. Implementa un sommatore con validazione di overflow.

---

## 📌 Riassunto

| Concetto        | Spiegazione                                  |
|-----------------|----------------------------------------------|
| Flag C          | Carry da operazioni unsigned                 |
| Flag V          | Overflow da operazioni signed                |
| BCC / BCS       | Salta su Carry Clear / Carry Set             |
| BVC / BVS       | Salta su oVerflow Clear / oVerflow Set       |
| ADC / SBC       | Setta entrambi C e V                         |
| Shift (ASL/LSR) | Setta C dal bit trascinato                   |

---

## 🔜 Preparazione alla lezione successiva

Nella lezione 020 vedremo **operazioni di stack avanzate**: TSX/TXS, PHP/PLP per salvare/ripristinare lo status processor.

---

## 🔎 Approfondimento — Dentro il 6510

**Flag di stato nel 6510 (SR):**

```
7: N (Negative)
6: V (oVerflow)      ← Lezione 019
5: unused
4: B (Break)
3: D (Decimal)
2: I (Interrupt Disable)
1: Z (Zero)
0: C (Carry)         ← Lezione 019
```

ADC e SBC setta C, Z, N, V in base al risultato.

---

## 🔎 Approfondimento - Dentro il 6510

Nei salti e nelle subroutine, la stabilita dipende dalla chiarezza del flusso di controllo: condizioni esplicite, ritorni coerenti e uso disciplinato dello stack. Questo rende il comportamento del programma prevedibile anche nei casi limite.

## ✅ Checklist finale

- [ ] l'esempio compila con `64tass`
- [ ] i salti su carry funzionano correttamente
- [ ] la logica condizionale su carry è chiara
- [ ] il contenuto è progressivo rispetto alle lezioni precedenti
