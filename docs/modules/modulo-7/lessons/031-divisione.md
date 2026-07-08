[🏠 Home](../../../index.md)

# Lezione 031 — Divisione: algoritmi software

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

; Chiamata: LDA div_hi, LDX div_lo, LDY divisore, JSR div
; Risultato: A = quoziente, X = resto

div:
  ; A = dividendo byte alto
  ; X = dividendo byte basso
  ; Y = divisore
  ; Risultato: A = quoziente, X = resto
  
  CMP #$00       ; se divisore = 0, errore
  BEQ err_div0
  
  ; Setup
  LDA #$00       ; A = quoziente
  STX remainder  ; remainder = dividendo basso
  
  LDX #$08       ; 8 iterazioni per 8 bit
  
loop:
  ASL remainder  ; shift remainder (dividendo)
  ROL            ; rotate quoziente (accumula risultato)
  
  SEC
  SBC Y          ; sottrai divisore
  BCC skip       ; se < 0 (borrow), skip
  
  ; quoziente risultato |= 1 (carry)
  ORA #$01
  
skip:
  DEX
  BNE loop
  
  STX remainder  ; remainder = il valore di X (che è rimasto)
  
err_div0:
  RTS

remainder = $02
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

Con la lezione 031, abbiamo completato la copertuta dei comandi base e le operazioni fondamentali. Prossimi moduli: I/O, periferiche, grafica.

---

## 🔎 Approfondimento — Dentro il 6510

**Metodi alternativi:**

1. **Lookup table**: per divisori fissi (veloce)
2. **Newton-Raphson**: per divisione veloce (complesso)
3. **BCD divide**: per aritmetica decimale

---

## ✅ Checklist finale

- [ ] L'esempio compila
- [ ] La divisione funziona per almeno 3 casi di test
- [ ] Il borrow è gestito correttamente
- [ ] Il resto è calcolato correttamente
- [ ] Il contenuto è progressivo rispetto alle lezioni precedenti
