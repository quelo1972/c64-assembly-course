[🏠 Home](../../../index.md)

# Lezione 13 — Direttive assembler, etichette e costanti

> **Obiettivo:** capire come usare direttive assembler, etichette symboliche e costanti per scrivere codice leggibile e riutilizzabile.

---

## 🎯 Obiettivi

- comprendere le direttive assembler principali (*, =, .byte, .word, .text);
- usare etichette per nominare indirizzi;
- definire costanti simboliche;
- scrivere codice modularmente organizzato.

---

## 🧠 Introduzione

L'Assembly è difficile da leggere perché usa indirizzi numerici:

```asm
* = $0801
LDA #$0B
STA $D020
JMP $0801
```

Con etichette e costanti, diventa:

```asm
* = program_start
LDA #border_color_brown
STA border_register
JMP program_start

program_start = $0801
border_register = $D020
border_color_brown = $0B
```

Molto più leggibile!

---

## 📘 Teoria

### Direttiva `*` (set program counter)

```asm
* = $0801      ; assembla il codice a partire da $0801
```

Il 6510 carica il programma qui. Se ometti, 64tass assume `$1000`.

### Direttiva `=` (alias per *)

```asm
* = $0801      ; equivalente a: program = $0801
```

### Etichette (label)

```asm
target:
  LDA #$50
  STA $D020
  JMP target   ; salta all'etichetta target
```

64tass traduce `loop` all'indirizzo effettivo durante assembly.

### Costanti

```asm
border_register = $D020
border_color = $0B

LDA #border_color
STA border_register
```

Equivalente a scrivere `LDA #$0B` e `STA $D020` ma molto più leggibile.

### Direttiva `.byte` (byte literals)

```asm
.byte $0B, $01, $FF
```

Assemble 3 byte in memoria.

### Direttiva `.word` (word literals, little-endian)

```asm
.word $0801    ; assembla $01, $08 (little-endian)
```

### Direttiva `.text` (stringhe)

```asm
.text "HELLO C64"
```

Assembla i codici ASCII.

---

## 🤖 Come ragiona il 6510

Durante parsing di un'etichetta:

```asm
loop:
  LDA #$50
```

1. **Riconoscimento**: `loop` = etichetta
2. **Indirizzo attuale**: PC = $0801
3. **Memorizzazione**: `loop = $0801`
4. **Parsing istruzioni**: `LDA` assembla normalmente

Quando vedi un salto a un'etichetta come `JMP target`:

1. **Lookup**: `loop` → `$0801`
2. **Assembly**: JMP diventa `$4C $01 $08`

---

## 💡 Esempio pratico

```asm
; Lezione 028 — Direttive e organizzazione
; Usa etichette, costanti e direttive
* = program_start

; Costanti hardware
vic2_border = $D020
vic2_bg = $D021
color_white = $01
color_black = $00
color_red = $02

; Costanti programma
max_count = $10

; Programma
init:
  LDA #color_black
  STA vic2_bg

loop:
  LDA #color_red
  STA vic2_border

  ; conta fino a max_count
  LDX #$00
count_loop:
  INX
  CPX #max_count
  BNE count_loop

  RTS

program_start = $0801
```

---

## ⚠️ Errori comuni

- **Etichette senza `:`**: `loop` deve avere il colon `:` per essere riconosciuta
- **Ordine di definizione**: usa costanti prima di assemble, o define in anticipo
- **Conflict di nomi**: non usare nomi riservati di 64tass (es: `A`, `X`, `Y`)
- **Little-endian confusion**: `.word` assembla con byte basso prima

---

## 🧪 Esercizi

1. Riscrivi il primo programma usando etichette e costanti
2. Crea una macro per azzerare un registro
3. Organizza un programma multi-sezione con init, loop, end

---

## 📌 Riassunto

| Direttiva | Effetto |
|-----------|---------|
| `* = addr` | Set program counter |
| `label:` | Crea un'etichetta |
| `constant = value` | Crea una costante |
| `.byte` | Inserisci byte |
| `.word` | Inserisci word (2 byte) |
| `.text` | Inserisci stringhe ASCII |

---

## 🔜 Preparazione alla lezione successiva

Nella lezione 029 vedremo come organizzare codice complesso con macro e moduli.

---

## 🔎 Approfondimento — Dentro 64tass

64tass supporta anche:

```asm
#if condition
  ; assembly condizionale
#endif

; Espressioni
constant = 10 * 2 + 5   ; aritmetica in assembly
```

---

## 🔎 Approfondimento - Dentro il 6510

Quando studi mnemonici, opcode e macro, la stabilita dipende dalla precisione del linguaggio: nomi chiari, direttive esplicite e struttura leggibile. Questa disciplina rende il codice assemblato piu comprensibile e verificabile.

## ✅ Checklist finale

- [ ] L'esempio compila
- [ ] Etichette e costanti sono riconosciute
- [ ] Il codice è leggibile e ben organizzato
- [ ] Il contenuto è progressivo rispetto alle lezioni precedenti
