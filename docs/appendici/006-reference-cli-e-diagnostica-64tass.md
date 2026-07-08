[🏠 Home](../index.md)

# Appendice 006 - Reference CLI e diagnostica 64tass

> Obiettivo: avere una reference operativa completa della command line 64tass, incluse warning policy e output tooling.

---

## 1) Sintassi base

```bash
64tass [OPTIONS...] SOURCES
```

Versione rilevata nel workspace: `64tass Turbo Assembler Macro V1.59.3120`.

---

## 2) Output e formati

Opzioni output principali:

- `-o`, `--output`
- `--output-append`
- `--no-output`
- `--output-section`
- `--output-exec`
- `--map`, `--map-append`, `--no-map`
- `-b`, `--nostart`
- `-f`, `--flat`
- `-n`, `--nonlinear`
- `-X`, `--long-address`

Formati disponibili:

- `--cbm-prg`
- `--atari-xex`
- `--apple-ii`
- `--intel-hex`
- `--mos-hex`
- `--s-record`
- `--c256-pgx`
- `--c256-pgz`

---

## 3) Operazione generale

- `-a`, `--ascii`
- `-B`, `--long-branch`
- `-C`, `--case-sensitive`
- `-D <label>=<value>`
- `-I <path>`
- `-M`, `--dependencies`
- `--dependencies-append`
- `--make-phony`
- `-q`, `--quiet`
- `-T`, `--tasm-compatible`

---

## 4) CPU target selection

- `--m65xx`
- `-i`, `--m6502`
- `-c`, `--m65c02`
- `--m65ce02`
- `-t`, `--m65dtv02`
- `-x`, `--m65816`
- `-e`, `--m65el02`
- `--mr65c02`
- `--mw65c02`
- `--m4510`

---

## 5) Label e listing

Label output:

- `-l`, `--labels`
- `--labels-append`
- `--normal-labels`
- `--export-labels`
- `--vice-labels`
- `--vice-labels-numeric`
- `--dump-labels`
- `--simple-labels`
- `--labels-root`
- `--labels-section`
- `--labels-add-prefix`

Assembly listing:

- `-L`, `--list`
- `--list-append`
- `-m`, `--no-monitor`
- `-s`, `--no-source`
- `--line-numbers`
- `--tab-size`
- `--verbose-list`

---

## 6) Diagnostica (warning/error)

Controllo globale:

- `-w`, `--no-warn`
- `-Wall`
- `-Werror`
- `-Werror=<name>`
- `-Wno-error=<name>`
- `-E`, `--error`
- `--error-append`
- `--no-error`
- `--no-caret-diag`
- `--macro-caret-diag`

Warning switch (inventario esteso):

- `-Walias`
- `-Walign`
- `-Waltmode`
- `-Wbranch-page`
- `-Wcase-symbol`
- `-Wimmediate`
- `-Wimplied-reg`
- `-Wleading-zeros`
- `-Wlong-branch`
- `-Wmacro-prefix`
- `-Wno-deprecated`
- `-Wno-float-compare`
- `-Wno-float-round`
- `-Wno-ignored`
- `-Wno-jmp-bug`
- `-Wno-label-left`
- `-Wno-page`
- `-Wno-wrap-addr`
- `-Wno-wrap-bank0`
- `-Wno-wrap-dpage`
- `-Wno-wrap-mem`
- `-Wno-wrap-pbank`
- `-Wno-wrap-pc`
- `-Wno-pitfalls`
- `-Wno-portable`
- `-Wno-priority`
- `-Wno-size-larger`
- `-Wno-star-assign`
- `-Wold-equal`
- `-Woptimize`
- `-Wshadow`
- `-Wstrict-bool`
- `-Wunused`
- `-Wunused-macro`
- `-Wunused-const`
- `-Wunused-label`
- `-Wunused-variable`

---

## 7) Utility options

- `-?`, `--help`
- `--usage`
- `-V`, `--version`

Supporto option file:

- `@argsfile` per caricare opzioni da file.

---

## 8) Profili consigliati (pronti all'uso)

Profilo sviluppo didattico C64:

```bash
64tass --cbm-prg -a -Wall -Wshadow -Wunused -o bin/out.prg src/main.asm
```

Profilo strict CI:

```bash
64tass --cbm-prg -a -Wall -Werror -Wshadow -Wstrict-bool -Wunused -o bin/out.prg src/main.asm
```

Profilo compatibilita TASM legacy:

```bash
64tass -T -C -a --cbm-prg -o bin/out.prg src/legacy.asm
```

Profilo debug (listing + labels VICE):

```bash
64tass --cbm-prg -a -L build/listing.txt --vice-labels -l build/vice.lbl -o bin/out.prg src/main.asm
```

---

## 9) Nota pratica per questo repository

Per il sito/documentazione del corso, i comandi validati sono:

```bash
.venv/bin/mkdocs build -q
.venv/bin/mkdocs gh-deploy --clean -b gh-pages -r origin
```

Per esempi C64 del corso, il formato atteso e normalmente `--cbm-prg`.
