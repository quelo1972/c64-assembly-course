[🏠 Home](../../../index.md)

# Lezione 35 — Moltiplicazione: algoritmi software

> **Obiettivo:** capire come implementare moltiplicazione di interi usando solo istruzioni base del 6510.

---

## 🎯 Obiettivi

- comprendere l'algoritmo shift-and-add per moltiplicazione;
- implementare moltiplicazione 8x8 → 16 bit;
- usare shift e loop per operazioni iterative;
- verificare overflow e carry.

---

## 🧠 Introduzione

Il 6510 non ha un'istruzione `MUL`. Invece usiamo:

1. Shift left (ASL) per moltiplicare per 2
2. Add (ADC) per accumul summare
3. Loop fino a completamento

Esempio: 5 × 3

```
5 = 0000 0101
3 = 0000 0011

Bit 0 di 3 = 1 → somma 5 << 0 = 5
Bit 1 di 3 = 1 → somma 5 << 1 = 10
Bit 2 di 3 = 0 → salta

Risultato: 5 + 10 = 15 ✓
```

---

## 📘 Teoria

### Algoritmo shift-and-add

```
result = 0
for each bit in multiplier:
  if bit = 1:
    result += multiplicand
  multiplicand <<= 1  (shift left)
```

### Pseudo-codice

```
mult (A × X → Y:A)
{
  Y = 0              ; byte alto risultato
  result_lo = A      ; inizializza risultato basso (A era il moltiplicando)

  for i = 0 to 7:
    if (X & 1) = 1:
      result_lo += result_lo
      if carry: Y++
    X >>= 1
    result_lo <<= 1
    if carry: Y++
}
```

### Performance

- Moltiplicazione 8x8: 8 iterazioni
- Cicli per iterazione: 10–15
- Totale: ~120 cicli (vs ~50 per una CPU con MUL)

---

## 🤖 Come ragiona il 6510

`mult 5 × 3`:

1. **A = 5** (moltiplicando), **X = 3** (moltiplicatore)
2. **Y = 0**, **result = 5**
3. **Iterazione 0**: X & 1 = 1 → add 5, risultato = 10, shift X → 1
4. **Iterazione 1**: X & 1 = 1 → add 10, risultato = 20, carry → Y = 1, shift X → 0
5. **Iterazioni 2–7**: X = 0, skip
6. **Risultato**: Y:A = $00:15 = 15 ✓

---

## 💡 Esempio pratico

```asm
; Lezione 030 — Moltiplicazione
; Moltiplicazione 8x8 → 16 bit
*= $0801

factor_a = $C000
factor_b = $C001
result_lo = $C002
result_hi = $C003

start:
  LDA #$05
  STA factor_a
  LDA #$03
  STA factor_b

  LDA #$00
  STA result_lo
  STA result_hi

  LDX factor_b
mul_loop:
  CLC
  LDA result_lo
  ADC factor_a
  STA result_lo
  LDA result_hi
  ADC #$00
  STA result_hi
  DEX
  BNE mul_loop

  LDA result_lo
  STA $D020

  RTS
```

---

## ⚠️ Errori comuni

- **Carry non gestito**: dimenticare di propagare il carry al byte alto
- **Ordine degli shift**: shift moltiplicando vs moltiplicatore
- **Loop infinito**: contatore non decrementato correttamente
- **Overflow**: se risultato > 65535, perde i bit alti

---

## 🧪 Esercizi

1. Implementa moltiplicazione 16x16 usando il metodo shift-and-add
2. Misura i cicli della tua routine vs ASL loop
3. Estendi a moltiplicazione di interi negativi (signed)

---

## 📌 Riassunto

| Concetto | Spiegazione |
|----------|-------------|
| Shift-and-add | Algoritmo fondamentale per moltiplicazione |
| Bit testing | Controllo di ogni bit del moltiplicatore |
| Carry propagation | Gestione dell'overflow tra byte |
| Performance | ~120 cicli per moltiplicazione 8x8 |

---

## 🔜 Preparazione alla lezione successiva

Nella lezione 031 vedremo la divisione usando il metodo opposto: shift e sottrazione.

---

## 🔎 Approfondimento — Dentro il 6510

Algoritmi alternativi:

1. **Lookup table**: tabella precalcolata (più veloce, meno memoria)
2. **Shifted accumulator**: usa A come accumulo shifting
3. **BCD multiply**: per aritmetica decimale

---

## 🔎 Approfondimento - Dentro il 6510

Nelle routine aritmetiche e bitwise, la stabilita nasce dalla gestione rigorosa di carry, overflow e bit di stato. Piccole verifiche intermedie mantengono correttezza e facilitano il debug delle operazioni composte.

## ✅ Checklist finale

- [ ] L'esempio compila
- [ ] La moltiplicazione funziona per almeno 3 casi di test
- [ ] Il carry è gestito correttamente
- [ ] Il contenuto è progressivo rispetto alle lezioni precedenti
