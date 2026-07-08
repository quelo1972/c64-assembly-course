# Appendici

Sezione di riferimento per distinguere in modo netto:

- cosa appartiene al processore MOS 6510 (istruzioni CPU);
- cosa appartiene al linguaggio dell'assembler 64tass (direttive, macro, simboli).

Questa distinzione evita confusione didattica: la CPU esegue opcode, l'assembler genera opcode.

## Indice appendici

- [Appendice 001 - Regole sintattiche del 64tass](001-regole-sintattiche-64tass.md)
- [Appendice 002 - Direttive e comandi specifici 64tass](002-direttive-e-comandi-64tass.md)
- [Appendice 003 - Macro, scope e organizzazione del codice](003-macro-scope-organizzazione.md)
- [Appendice 004 - Mappa di confine: MOS 6510 vs 64tass](004-confine-mos6510-vs-64tass.md)
- [Appendice 005 - Riferimento completo 64tass (oltre il corso)](005-riferimento-completo-64tass.md)
- [Appendice 006 - Reference CLI e diagnostica 64tass](006-reference-cli-e-diagnostica-64tass.md)
- [Appendice 007 - Linguaggio avanzato 64tass non usato nel corso](007-linguaggio-avanzato-64tass-non-usato-nel-corso.md)

## Come usare queste appendici

1. Se hai un dubbio su una parola che inizia con punto (es. `.byte`, `.word`, `.macro`), parti da Appendice 002.
2. Se hai dubbi su etichette, costanti o espressioni, parti da Appendice 001.
3. Se stai leggendo codice e vuoi capire chi fa cosa, vai a Appendice 004.
4. Se cerchi una copertura estesa di tutte le aree 64tass (anche fuori corso), parti da Appendice 005.

## Nota terminologica

- CPU corretta: **MOS 6510**.
- `64tass` e un assembler moderno per famiglia 6502/6510.
