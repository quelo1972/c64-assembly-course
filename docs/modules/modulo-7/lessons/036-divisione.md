[🏠 Home](../../../index.md)

# Lezione 36 — Divisione: algoritmi software

> **Obiettivo:** capire come implementare divisione di interi usando shift e sottrazione.

---

## 🎯 Obiettivi

- comprendere l'algoritmo shift-and-subtract per divisione;
- implementare divisione 16 ÷ 8 → quoziente + resto;
- usare carry e borrow nella divisione;
- verificare corner cases (divisione per zero, overflow).

---

## 🧠 Introduzione

Divisione è il contrario di moltiplicazione:

```
15 ÷ 3

Risultato: quoziente = 5, resto = 0
```

Algoritmo: shift a sinistra il divisore finché non è > dividendo, quindi sottrai e continua.

---

## 📘 Teoria

### Algoritmo shift-and-subtract

```
quoziente = 0
for i = 0 to 15:
  quoziente <<= 1
  if (dividendo >= divisore):
    dividendo -= divisore
    quoziente |= 1
  divisore >>= 1
```

### Pseudo-codice

```
div (A:X ÷ Y → A=quoziente, X=resto)
{
  quoziente = 0

  for i = 0 to 7:
    quoziente <<= 1
    if divisor_hi bit:
      quoziente |= 1
    divisor >>= 1
}
```

### Performance

- Divisione 16 ÷ 8: 8 iterazioni
- Cicli per iterazione: 15–20
- Totale: ~150 cicli

---

## 🤖 Come ragiona il 6510

`div 15 ÷ 3`:

1. **Y = 3** (divisore)
2. **A = 15** (dividendo hi), **X = 0** (dividendo lo)
3. **Iterazione 0**: A = 00, shift, A >= Y? No
4. **Iterazione 1**: A = 01, shift, A >= Y? No
5. **Iterazione 2**: A = 03, A >= Y? Yes → sottrai Y, A = 0, quoziente |= 1
6. **Iterazioni 3–7**: A < Y, skip
7. **Risultato**: A = 5 (quoziente), X = 0 (resto) ✓

---

## 💡 Esempio pratico

```asm
; Lezione 031 — Divisione
; Divisione 16 ÷ 8 → quoziente + resto
*= $0801

dividend = $C010
divisor = $C011
quotient = $C012
remainder = $C013

start:
  LDA #$0F
  STA dividend
  LDA #$03
  STA divisor
  LDA #$00
  STA quotient

div_loop:
  LDA dividend
  CMP divisor
  BCC done
  SEC
  SBC divisor
  STA dividend
  INC quotient
  JMP div_loop

done:
  LDA dividend
  STA remainder

  LDA quotient
  STA $D020
  LDA remainder
  STA $D021

loop:
  JMP loop
```

---

## ⚠️ Errori comuni

- **Divisione per zero**: verificare se Y = 0
- **Shift non sincronizzato**: remainder e quoziente devono shiftare insieme via carry
- **Borrow vs carry**: SBC setta carry se NO borrow (A >= Y)
- **Overflow in divisione**: se quoziente > 255, perde bit

---

## 🧪 Esercizi

1. Implementa divisione 32 ÷ 16 (dividendo 32-bit, divisore 16-bit)
2. Estendi a divisione con resto ben definito
3. Implementa divisione di numeri negativi (signed)

---

## 📌 Riassunto

| Concetto | Spiegazione |
|----------|-------------|
| Shift-and-subtract | Algoritmo per divisione |
| Quoziente | Risultato della divisione (A) |
| Resto | Residuo della divisione (X) |
| Borrow tracking | Gestione del segno in sottrazione |

---

## 🔜 Preparazione alla lezione successiva

Con la lezione 031, abbiamo completato la copertuta dei comandi base è le operazioni fondamentali. Prossimi moduli: I/O, periferiche, grafica.

---

## 🔎 Approfondimento — Dentro il 6510

**Metodi alternativi:**

1. **Lookup table**: per divisori fissi (veloce)
2. **Newton-Raphson**: per divisione veloce (complesso)
3. **BCD divide**: per aritmetica decimale

---

## 🔎 Approfondimento - Dentro il 6510

Nelle routine aritmetiche e bitwise, la stabilita nasce dalla gestione rigorosa di carry, overflow e bit di stato. Piccole verifiche intermedie mantengono correttezza e facilitano il debug delle operazioni composte.

## ✅ Checklist finale

- [ ] L'esempio compila
- [ ] La divisione funziona per almeno 3 casi di test
- [ ] Il borrow è gestito correttamente
- [ ] Il resto è calcolato correttamente
- [ ] Il contenuto è progressivo rispetto alle lezioni precedenti
