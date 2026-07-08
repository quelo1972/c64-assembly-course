[🏠 Home](../../../index.md)

# Lezione 023 — Macro e organizzazione del codice

> **Obiettivo:** capire come usare macro per riutilizzare codice e organizzare programmi complessi in moduli.

---

## 🎯 Obiettivi

- comprendere le macro e come definirle;
- riutilizzare blocchi di codice con macro;
- organizzare programmi in file separati;
- usare include per modularizzazione.

---

## 🧠 Introduzione

Spesso ripeti lo stesso codice:

```asm
LDA $D020
ADC #$01
STA $D020
```

Invece di copiare-incollare, puoi definire una **macro**:

```asm
inc_border
  LDA $D020
  ADC #$01
  STA $D020
.endm
```

Poi usarla come comando:

```asm
inc_border      ; espande a 3 istruzioni
```

---

## 📘 Teoria

### Definizione di macro

```asm
.macro inc_register
  ADC #$01
.endm
```

### Parametri

```asm
.macro inc_at addr
  LDA addr
  ADC #$01
  STA addr
.endm

inc_at $D020   ; incrementa bordo
inc_at $D021   ; incrementa sfondo
```

### Include per moduli

File `utils.asm`:

```asm
.macro delay_cycles count
  ; loop di delay
.endm
```

Main file:

```asm
.include "utils.asm"

delay_cycles 10
```

### Organizzazione file

```
src/
  main.asm           ; programma principale
  utils.asm          ; routine riutilizzabili
  hardware.asm       ; definizioni hardware
  constants.asm      ; costanti globali
```

---

## 🤖 Come ragiona il 6510

Quando trovi una macro:

```asm
.macro inc_border
  LDA $D020
  ADC #$01
  STA $D020
.endm

inc_border
```

1. **Definizione**: 64tass memorizza le 3 istruzioni
2. **Invocazione**: quando vede `inc_border`, espande in-place
3. **Assembly**: le 3 istruzioni vengono assemblate

Risultato: come se avessi scritto le 3 istruzioni direttamente.

---

## 💡 Esempio pratico

```asm
; Lezione 029 — Macro e organizzazione
; main.asm
.include "constants.asm"
.include "utils.asm"

* = program_start

init:
  set_border_color color_red
  clear_screen
  
loop:
  inc_border
  delay_ms 10
  JMP loop

program_start = $0801
```

File `constants.asm`:

```asm
color_red = $02
color_blue = $06
screen_ram = $0400
screen_size = 1000
border_register = $D020
```

File `utils.asm`:

```asm
.macro set_border_color color
  LDA #color
  STA border_register
.endm

.macro clear_screen
  LDA #$00
  LDX #$00
loop_clear:
  STA screen_ram,X
  INX
  CPX #screen_size
  BNE loop_clear
.endm

.macro inc_border
  LDA border_register
  ADC #$01
  STA border_register
.endm

.macro delay_ms milliseconds
  ; delay loop (semplificato)
  LDX #milliseconds
loop_delay:
  DEX
  BNE loop_delay
.endm
```

---

## ⚠️ Errori comuni

- **Macro ricorsive**: una macro che chiama se stessa causa stack overflow
- **Conflitti di nome**: una macro non può avere lo stesso nome di una label
- **Scope dei parametri**: i parametri della macro sono locali
- **Include path**: controlla che i file include siano nel path giusto

---

## 🧪 Esercizi

1. Crea 3 macro per operazioni comuni (delay, color change, write)
2. Organizza il codice dei moduli precedenti in file separati con include
3. Scrivi una macro con parametri che assembla un loop

---

## 📌 Riassunto

| Concetto | Uso |
|----------|-----|
| Macro | Riutilizza blocchi di codice |
| Parametri | Rendi le macro generiche |
| Include | Importa da altri file |
| Modularizzazione | Organizza in file logici |

---

## 🔜 Preparazione alla lezione successiva

Nella lezione 030 vedremo come implementare moltiplicazione usando solo istruzioni base.

---

## 🔎 Approfondimento — Dentro 64tass

64tass supporta anche:

```asm
.struct Point
  x: 1    ; 1 byte
  y: 1
.endstruct

.align 256   ; allinea al prossimo multiplo di 256
```

---

## ✅ Checklist finale

- [ ] L'esempio compila
- [ ] Le macro sono definite e usate
- [ ] Il codice è organizzato in file
- [ ] Il contenuto è progressivo rispetto alle lezioni precedenti
