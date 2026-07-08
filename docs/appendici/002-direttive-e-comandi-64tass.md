[🏠 Home](../index.md)

# Appendice 002 - Direttive e comandi specifici 64tass

> Obiettivo: catalogare le direttive 64tass piu importanti distinguendole dalle istruzioni del MOS 6510.

---

## 1. Direttive dati

### `.byte`
Inserisce uno o piu byte nel codice oggetto.

```asm
TABLE:
    .byte $01, $02, $FF
```

### `.word`
Inserisce word a 16 bit in little-endian.

```asm
VECTORS:
    .word $0801, $C000
```

### `.text`
Inserisce byte da stringa.

```asm
MSG:
    .text "HELLO"
```

Nota: la codifica visuale dipende dal contesto C64 (PETSCII/screen code), ma `.text` resta una direttiva assembler.

---

## 2. Direttive codice e organizzazione

### `.include`
Include un altro file sorgente.

```asm
.include "constants.asm"
.include "utils.asm"
```

Uso consigliato:

- costanti hardware in file dedicato;
- routine comuni in file separati;
- file principale pulito e leggibile.

### `.align`
Allinea il punto di assemblaggio a un multiplo.

```asm
.align 256
```

---

## 3. Macro (direttive, non opcode)

### `.macro` / `.endm`
Definisce riuso di blocchi parametrici.

```asm
.macro set_border color
    LDA #color
    STA $D020
.endm

set_border $06
```

Espansione: l'assembler sostituisce il testo macro in fase di assemblaggio.

---

## 4. Direttive strutturali avanzate

Nel materiale del corso compaiono anche forme avanzate, ad esempio:

- `.struct` / `.endstruct`
- costrutti condizionali o iterativi assembler (`.if`, `.for`) in contesti avanzati.

Questi costrutti sono utili, ma didatticamente vanno introdotti solo quando la base CPU e solida.

---

## 5. Tabella: CPU vs 64tass

| Esempio | Tipo | Eseguito dalla CPU? |
|---------|------|---------------------|
| `LDA #$01` | Istruzione MOS 6510 | Si |
| `STA $D020` | Istruzione MOS 6510 | Si |
| `.byte $01` | Direttiva 64tass | No |
| `.include "x.asm"` | Direttiva 64tass | No |
| `.macro ... .endm` | Direttiva 64tass | No |
| `*= $0801` | Assegnazione location counter | No |

---

## 6. Errori frequenti

- Usare direttive senza spiegare che sono preprocessing assembler.
- Aspettarsi che una macro abbia costo runtime "magico": il costo dipende dal codice espanso.
- Confondere `.word` con ordine big-endian (sul 6510 e little-endian).

---

## 7. Esempio didattico completo

```asm
*= $0801

BORDER = $D020

MSG:
    .text "HI"

.macro set_border color
    LDA #color
    STA BORDER
.endm

START:
    set_border $02
    RTS
```

In questo listato:

- `.text`, `.macro`, `*=`, costante `BORDER` sono 64tass;
- `LDA`, `STA`, `RTS` sono istruzioni CPU.

---

## 8. Costrutti 64tass effettivamente usati nel corso (moduli 0-14)

Per mantenere allineamento pratico tra teoria e lezioni, ecco il set di costrutti 64tass realmente usati nei listati del corso.

### Direttive ricorrenti

- `.byte`
- `.word`
- `.text`
- `.fill`
- `.include`
- `.macro` / `.endm`
- `.align`
- `.struct` / `.endstruct` (casi avanzati)

### Sintassi assembler usata frequentemente

- `*= $0801` (location counter / indirizzo di assemblaggio)
- `NAME = $D020` (costanti simboliche)
- `#<label` e `#>label` (byte basso/alto di un indirizzo)

### Comando CLI 64tass usato nel workflow corso

```bash
64tass --cbm-prg -o bin/output.prg src/percorso/main.asm
```

Per la reference completa di opzioni CLI (warning policy, listing, target multipli), vedi Appendice 006.
