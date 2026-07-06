# Changelog

## 2026-07-06 — Riepilogo modifiche recenti

### Sintesi
- Espansa la roadmap del corso in `.ai/roadmap.md` (moduli 0–14 + appendici).
- Aggiornato `.ai/lesson-template.md` con una regola che richiede spiegazioni per le istruzioni citate prima della loro lezione dedicata.
- Normalizzate e aggiunte lezioni fino alla 010; create esempi skeleton in `src/001`–`src/010` e compilati localmente con `64tass`.
- Configurato MkDocs (`mkdocs.yml`) e installate le dipendenze; sito generabile localmente e pubblicato su GitHub Pages.
- Aggiunta una GitHub Action CI che esegue `mkdocs build` e assembla gli esempi con `64tass`.
- Aggiornati `docs/index.md` e `CHANGELOG.md` con le nuove lezioni.

## 2026-07-06

### Aggiunto
- Nuova lezione 007: LDA e indirizzamento immediato
- Esempio pratico e README nella cartella src/007-lda
- Nuova lezione 008: STA e scrittura in memoria
- Esempio pratico e README nella cartella src/008-sta
- Nuova lezione 009: Trasferimento tra registri
- Esempio pratico e README nella cartella src/009-trasferimento-tra-registri
- Nuova lezione 010: Incremento e decremento
- Esempio pratico e README nella cartella src/010-increment-decrement

### Modificato
- Aggiornato l'indice del corso con la nuova lezione
- Aggiunto il termine "Indirizzamento immediato" al glossario
- Allineate le lezioni 001-006 alla struttura richiesta dalla cartella .ai
