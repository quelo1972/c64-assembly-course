[🏠 Home](../index.md)

# Appendice 003 - Macro, scope e organizzazione del codice

> Obiettivo: usare macro e organizzazione multi-file senza perdere chiarezza didattica.

---

## 1. Quando usare una macro

Usare macro quando:

- una sequenza ricorre spesso;
- i parametri cambiano ma la struttura resta uguale;
- vuoi ridurre duplicazione mantenendo leggibilita.

Non usarla quando:

- il blocco e usato una sola volta;
- nasconde troppo il comportamento CPU per studenti alle prime lezioni.

---

## 2. Macro e costo reale

Una macro non e una subroutine: viene espansa inline.

Conseguenze:

- pro: zero overhead `JSR/RTS`;
- contro: codice piu grande se usata molte volte.

---

## 3. Scope dei simboli (regola pratica)

Per evitare collisioni:

- prefissa costanti globali in modo coerente (es. `VIC_`, `CIA_`);
- mantieni label locali vicine al loro blocco logico;
- separa i file per responsabilita (costanti, utility, main).

---

## 4. Organizzazione consigliata nel corso

Schema semplice:

```text
src/modulo-N/
  main.asm
  constants.asm
  utils.asm
```

Con `main.asm`:

```asm
.include "constants.asm"
.include "utils.asm"

*= $0801

START:
    JSR init
    RTS
```

---

## 5. Pattern consigliati

### Pattern A - Costanti centralizzate

```asm
; constants.asm
VIC_BORDER = $D020
VIC_BG0    = $D021
```

### Pattern B - Macro piccole e trasparenti

```asm
.macro set_border color
    LDA #color
    STA VIC_BORDER
.endm
```

### Pattern C - Subroutine per logica vera

```asm
init:
    set_border $06
    RTS
```

---

## 6. Anti-pattern da evitare

- Macro "giganti" con side effect non evidenti.
- Troppe astrazioni nelle prime lezioni.
- Convenzioni di naming diverse tra file simili.

---

## 7. Checklist di mantenibilita

- Ogni file ha un ruolo chiaro?
- Le macro sono brevi e leggibili?
- Le costanti hardware sono centralizzate?
- Uno studente riesce a seguire il flusso senza espansione mentale eccessiva?
