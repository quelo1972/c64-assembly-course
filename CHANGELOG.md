# Changelog

## 2026-07-07 — Riorganizzazione modulare, helper script e nuove lezioni

### Struttura documentazione
- Ristrutturata la cartella `docs/` in moduli: `docs/modules/modulo-{0..14}/`
- Ogni modulo ha ora una propria cartella `lessons/` con le lezioni assegnate
- Spostati i file `docs/lessons/*.md` nelle sottocartelle dei moduli corretti:
  - Modulo 1 (Fondamenti): lezioni 001, 002, 003
  - Modulo 2 (CPU MOS 6510): lezioni 004, 005
  - Modulo 3 (Linguaggio e tooling): lezione 006
  - Modulo 4 (Prime istruzioni): lezioni 007, 008, 009, 010
  - Modulo 5 (Modalità di indirizzamento): lezioni 011, 012
- Creati file indice `docs/modules/modulo-{0..14}.md` con descrizione, contenuti e mini-progetto da `.ai/roadmap.md`
- Modulo 0 ridefinito come "Ambiente di sviluppo" (non contiene lezioni, ma documenta toolchain e setup)
- Aggiornato `docs/index.md` con lista completa dei moduli

### Navigazione MkDocs
- Aggiornato `mkdocs.yml` per riflettere la struttura a moduli 0–14
- Corretta l'indentazione YAML del blocco `nav` (bug che impediva la build)
- Corretti tutti i link `Home` nelle lezioni da `/index.md` a percorsi relativi `../../../index.md`
- Aggiornato il deploy su `gh-pages` con `mkdocs gh-deploy`; il sito https://quelo1972.github.io/c64-assembly-course/ riflette la struttura a moduli

### Script helper
- Aggiunto `scripts/new-lesson.sh`: crea una lezione da template, aggiorna `mkdocs.yml` e l'indice del modulo automaticamente

### Nuove lezioni (Modulo 5)
- **Lezione 011** — Indirizzamento immediato, revisited: teoria completa, tabella formati, cicli macchina, tabella opcode, esempio VIC-II
- **Lezione 012** — Indirizzamento Zero Page: confronto con modalità immediata e assoluta, variabili in ZP, esercizi

### Infrastruttura
- Aggiunti `lesson-template.md` in ogni cartella `lessons/` di modulo 5–14 per scaffolding rapido
- Corretti i workflow GitHub Actions: usa `peaceiris/actions-gh-pages@v4` (v5 non esiste)

---

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
