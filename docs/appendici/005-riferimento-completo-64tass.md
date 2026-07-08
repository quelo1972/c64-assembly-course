[🏠 Home](../index.md)

# Appendice 005 - Riferimento completo 64tass (oltre il corso)

> Obiettivo: avere un riferimento esteso su 64tass anche per feature non usate direttamente nelle lezioni.

---

## 1) Fonti e versione

Questo riferimento integra:

- output locale `64tass --help` (workspace): `64tass v1.59.3120`;
- manuale online ufficiale 64tass (`tass64.sourceforge.net`), che al momento riporta `v1.60`.

Nota: alcune feature possono variare tra versioni. In caso di dubbi, vale sempre la versione installata nel tuo ambiente build.

---

## 2) Mappa completa delle aree 64tass

Aree principali coperte dalla reference ufficiale:

1. Usage tips
2. Expressions and data types
3. Compiler directives
4. Pseudo instructions
5. Turbo Assembler compatibility
6. Command line options
7. Messages (warning/error/fatal)
8. Default translations and escape sequences
9. Opcode tables per CPU target

Questa appendice e pensata come "indice tecnico" trasversale alle appendici 001-004.

---

## 3) Direttive assembler 64tass (inventario esteso)

Elenco esteso (alfabetico) delle direttive citate nella reference ufficiale:

- `.addr`
- `.al`
- `.align`
- `.alignblk`
- `.alignind`
- `.alignpageind`
- `.as`
- `.assert`
- `.autsiz`
- `.bend`
- `.binary`
- `.binclude`
- `.bfor`
- `.block`
- `.break`
- `.breakif`
- `.brept`
- `.bwhile`
- `.byte`
- `.case`
- `.cdef`
- `.cerror`
- `.char`
- `.check`
- `.comment`
- `.continue`
- `.continueif`
- `.cpu`
- `.cwarn`
- `.databank`
- `.default`
- `.dint`
- `.dpage`
- `.dsection`
- `.dstruct`
- `.dunion`
- `.dword`
- `.edef`
- `.elif`
- `.else`
- `.elsif`
- `.enc`
- `.encode`
- `.end`
- `.endalignblk`
- `.endblock`
- `.endc`
- `.endcomment`
- `.endencode`
- `.endf`
- `.endfor`
- `.endfunction`
- `.endif`
- `.endlogical`
- `.endm`
- `.endmacro`
- `.endn`
- `.endnamespace`
- `.endp`
- `.endpage`
- `.endproc`
- `.endrept`
- `.ends`
- `.endsection`
- `.endsegment`
- `.endstruct`
- `.endswitch`
- `.endu`
- `.endunion`
- `.endv`
- `.endvirtual`
- `.endweak`
- `.endwhile`
- `.endwith`
- `.eor`
- `.error`
- `.fi`
- `.fill`
- `.for`
- `.from`
- `.function`
- `.goto`
- `.here`
- `.hidemac`
- `.if`
- `.ifeq`
- `.ifmi`
- `.ifne`
- `.ifpl`
- `.include`
- `.lbl`
- `.lint`
- `.logical`
- `.long`
- `.macro`
- `.mansiz`
- `.namespace`
- `.next`
- `.null`
- `.offs`
- `.option`
- `.page`
- `.pend`
- `.proc`
- `.proff`
- `.pron`
- `.ptext`
- `.rept`
- `.rta`
- `.section`
- `.seed`
- `.segment`
- `.send`
- `.sfunction`
- `.shift`
- `.shiftl`
- `.showmac`
- `.sint`
- `.struct`
- `.switch`
- `.tdef`
- `.text`
- `.union`
- `.var`
- `.virtual`
- `.warn`
- `.weak`
- `.while`
- `.with`
- `.word`
- `.xl`
- `.xs`

---

## 4) Funzioni built-in 64tass (inventario esteso)

Funzioni matematiche e utility (elenco esteso):

- `abs`, `acos`, `asin`, `atan`, `atan2`
- `cbrt`, `ceil`, `cos`, `cosh`
- `deg`, `exp`, `floor`, `frac`
- `hypot`, `log`, `log10`, `pow`
- `rad`, `round`, `sign`, `sin`, `sinh`
- `sqrt`, `tan`, `tanh`, `trunc`

Funzioni byte/numeriche:

- `byte`, `char`
- `word`, `sint`
- `long`, `lint`
- `dword`, `dint`
- `addr`, `rta`

Funzioni strutturali e dati:

- `all`, `any`, `binary`, `format`
- `len`, `random`, `range`, `repr`
- `size`, `sort`

---

## 5) Tipi built-in

Tipi citati dalla reference:

- `address`
- `bits`
- `bool`
- `bytes`
- `code`
- `dict`
- `float`
- `gap`
- `int`
- `list`
- `str`
- `symbol`
- `tuple`
- `type`

---

## 6) Modello dati/espressioni (feature avanzate)

64tass include feature avanzate non comuni in assembler classici:

- interi arbitrary precision;
- bit string e byte string con slicing/indexing;
- float e operatori misti;
- liste, tuple, dizionari;
- funzioni custom (`.sfunction`, `.function`);
- broadcasting su operazioni tra collezioni;
- range generation e trasformazioni compile-time.

Queste feature sono potenti ma fuori dal "core beginner path" del corso.

---

## 7) Pseudo-instructions e alias

Aree principali:

- alias mnemonici (es. `BLT/BGE`, `SHL/SHR`);
- generic instructions (`LDR`, `STR`, `PSH`, `PUL`, ecc.);
- always-taken branch pseudo (`GEQ`, `GNE`, `GCC`, ...);
- long branch support (automatico con opzione CLI dedicata).

---

## 8) Compatibilita Turbo Assembler (TASM)

Area dedicata in manuale:

- migrazione sorgenti legacy;
- differenze su parser espressioni e operatori;
- macro/reference differences;
- bug storici non replicati.

Opzione chiave: `--tasm-compatible`.

---

## 9) CPU target supportati da 64tass

Famiglie principali:

- 6502 / 65xx standard
- 6502i (NMOS + illegal opcodes)
- 65C02 (CMOS)
- R65C02 / W65C02
- 65DTV02
- 65816
- 65EL02
- 65CE02
- 4510
- 45GS02

Quindi 64tass e molto piu ampio del solo contesto C64/MOS 6510.

---

## 10) Link rapidi reference ufficiale

- Manuale: https://tass64.sourceforge.net/
- Direttive: https://tass64.sourceforge.net/#directives
- Funzioni: https://tass64.sourceforge.net/#functions
- Tipi: https://tass64.sourceforge.net/#types
- Opzioni CLI: https://tass64.sourceforge.net/#commandline-options
- Messaggi diagnostici: https://tass64.sourceforge.net/#messages
- Opcode tables: https://tass64.sourceforge.net/#opcodes

---

## 11) Come usare questa appendice nel corso

1. Studente beginner: continua con i moduli e usa questa appendice solo come dizionario tecnico.
2. Studente intermedio: usa questa appendice per capire differenze tra "assembler language" e "CPU ISA".
3. Studente avanzato: usa questa appendice come mappa per metaprogrammazione e build pipeline sofisticate.
