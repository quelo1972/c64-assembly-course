[🏠 Home](../index.md)

# Appendice 007 - Linguaggio avanzato 64tass non usato nel corso

> Obiettivo: documentare feature 64tass avanzate non centrali nel percorso beginner del corso, ma utili in progetti reali.

---

## 1) Espressioni e tipi avanzati

Feature rilevanti oltre il percorso base:

- integer arbitrary precision;
- bit string e byte string con slicing/indexing;
- float compile-time;
- tuple/list/dict con operazioni vettoriali e broadcasting;
- tipi espliciti (`int`, `bits`, `bytes`, `dict`, `code`, ecc.);
- operatori avanzati (`<=>`, `??`, `<?`, `>?`, fold con `...`).

Quando usarle:

- generazione di tabelle;
- metaprogrammazione compile-time;
- packing/trasformazioni dati senza tool esterni.

---

## 2) Scoping e organizzazione ad alto livello

Costrutti oltre il minimo didattico:

- `.namespace` / `.endnamespace`
- `.with` / `.endwith`
- `.weak` / `.endweak`
- `.proc` (compila solo se referenziata)
- `.section` / `.dsection` per layout multi-area

Use case tipici:

- librerie modulari con simboli pubblici/privati;
- dead code reduction automatica;
- mapping complesso memoria/banche.

---

## 3) Macros e funzioni custom

Oltre `.macro` classica:

- macro con parameter references (`\1..\9`, `\name`, `\@`);
- text references (`@1..@9`);
- `.segment` come macro "testuale";
- `.sfunction` (single-expression);
- `.function` multi-line con ritorno valori.

Rischi didattici:

- aumentano potenza e complessita;
- possono nascondere il flusso CPU a chi inizia.

---

## 4) Repetition/flow compile-time avanzati

Costrutti non beginner ma molto potenti:

- `.for`, `.bfor`, `.rept`, `.brept`, `.while`, `.bwhile`;
- `.break`, `.continue`, versioni condizionali;
- forme iterative con `in range(...)`;
- packing tuple/list in loop multi-variabile.

Use case:

- LUT sin/cos, mappe, tabelle sprite, generatori pattern.

---

## 5) Text encoding e escape system avanzato

Sistema encoding completo:

- `.enc`, `.encode`;
- definizione mapping (`.cdef`, `.tdef`, `.edef`);
- conversioni tra none/screen/custom;
- supporto Unicode source con `-a`.

Questo e molto oltre il "solo PETSCII" e utile in toolchain internazionali.

---

## 6) Directive families non core-C64

Famiglie avanzate spesso fuori corso base:

- sectioning esteso (`.section`, `.dsection`);
- relocation/virtualizzazione (`.logical`, `.virtual`, `.offs`);
- alignment indiretto (`.alignind`, `.alignpageind`);
- 65816-size state (`.as/.al`, `.xs/.xl`, `.autsiz/.mansiz`);
- target switching (`.cpu`) multi-architettura.

---

## 7) Pseudo-instructions e multi-CPU extras

Aree avanzate:

- generic instruction family (`LDR`, `STR`, `PSH`, `PUL`, ...);
- always-taken branch pseudo;
- automatic long-branch pipeline;
- alias opcodes e naming compatibility set.

---

## 8) Diagnostica professionale (non beginner)

Per progetti grandi e manutenzione:

- `-Wshadow`, `-Wunused*`, `-Wstrict-bool`;
- `-Woptimize` per hint micro-ottimizzazione;
- `--dependencies` + `--make-phony` per integrazione build system;
- symbol export multiplo (`--labels-root`, `--labels-section`, format VICE/altro).

---

## 9) Compatibilita e migrazione legacy

64tass fornisce anche percorso compatibilita Turbo Assembler (`-T`), ma:

- non tutte le vecchie pratiche sono consigliate oggi;
- conviene migrare gradualmente verso sintassi moderna e warning puliti.

---

## 10) Regola didattica del corso

Queste feature esistono e sono documentate qui per completezza tecnica.

Nel percorso principale del corso restiamo comunque su progressione controllata: un concetto nuovo significativo per volta, esempi piccoli e verificabili.

---

## 11) Link ufficiali per approfondimento completo

- Table of contents: https://tass64.sourceforge.net/#contents
- Directives: https://tass64.sourceforge.net/#directives
- Functions: https://tass64.sourceforge.net/#functions
- Types: https://tass64.sourceforge.net/#types
- Pseudo instructions: https://tass64.sourceforge.net/#pseudo-instructions
- Messages: https://tass64.sourceforge.net/#messages
- Opcodes: https://tass64.sourceforge.net/#opcodes
