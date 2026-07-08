# Changelog

## 2026-07-08 — Completamento coverage comandi 6510: 6 lezioni su modalità indirette e operazioni critiche

### Aggiornamento roadmap.md
- Integrati argomenti mancanti nei moduli 5, 6, 7, 11
- Modulo 5: esteso per coprire tutte le modalità di indirizzamento (Indirect, Indirect Indexed)
- Modulo 6: aggiunto coverage per salti su Carry/Overflow (BCC/BCS/BVC/BVS) e stack operations avanzate (TSX/TXS/PHP/PLP)
- Modulo 7: aggiunto INC/DEC in memoria, CMP/CPX/CPY, BIT operations
- Modulo 11: aggiunto CLI/SEI/RTI per interrupt handling

### Nuove lezioni - Modulo 5 (completamento modalità di indirizzamento)
- **Lezione 017 — Indirizzamento indiretto**: `LDA (addr)`, puntatori in Zero Page, traversal di strutture dati dinamiche, opcode JMP indiretto, bug storico del 6502
- **Lezione 018 — Indirizzamento indiretto indicizzato**: distinzione `(addr,X)` vs `(addr),Y`, uso con array di strutture e liste, boundary crossing

### Nuove lezioni - Modulo 6 (estensione controllo flusso)
- **Lezione 019 — Salti condizionati: Carry e Overflow**: flag C (carry from arithmetic), flag V (signed overflow), BCC/BCS, BVC/BVS, validazione aritmetica
- **Lezione 020 — Operazioni di stack avanzate**: TSX/TXS (trasferimento SP↔X), PHP/PLP (save/restore processor status), manipolazione diretta dello stack

### Nuove lezioni - Modulo 7 (estensione operazioni aritmetiche)
- **Lezione 021 — Incremento e decremento in memoria**: INC/DEC con modalità ZP/ZP,X/Absolute/Absolute,X, distinzione INX vs INC, flag Z/N (non C), wraparound
- **Lezione 022 — Compare e BIT test operations**: CMP/CPX/CPY (confronto senza modifica), flag behavior (Z=equal, C=borrow), BIT test (Z da AND, N/V da memoria)

### Validazione
- `mkdocs build`: 0 errori, tutte le 6 lezioni linkate correttamente in nav
- Titoli con due punti quotati in mkdocs.yml per evitare errori YAML
- Totale righe lezioni: 1176 (media ~196 righe per lezione)

### Analisi coverage comandi MOS 6510
**Comandi completamente coperti (022 lezioni):**
- Caricamento: LDA, LDX, LDY ✓
- Archiviazione: STA, STX, STY ✓
- Trasferimento: TAX, TAY, TXA, TYA, TSX, TXS ✓
- Aritmetica: ADC, SBC ✓
- Logica: AND, ORA, EOR, ASL, LSR, ROL, ROR, BIT ✓
- Incremento/Decremento: INX, INY, DEX, DEY, INC, DEC ✓
- Salti: JMP, BEQ, BNE, BPL, BMI, BCC, BCS, BVC, BVS ✓
- Subroutine: JSR, RTS ✓
- Stack: PHA, PLA, PHP, PLP ✓
- Confronto: CMP, CPX, CPY ✓
- Interrupt: CLI, SEI (RTI in Modulo 11) ✓

**Modalità di indirizzamento coperte:**
- Implicit ✓, Accumulator ✓, Immediate ✓
- Zero Page ✓, Zero Page,X/Y ✓
- Absolute ✓, Absolute,X/Y ✓
- Indirect ✓ (Lezione 017)
- Indirect Indexed X ✓ (Lezione 018)
- Indirect Indexed Y ✓ (Lezione 018)
- Relative ✓ (Lezione 015)

---

## 2026-07-07 — Aggiunte 4 nuove lezioni (013–016)

### Nuove lezioni - Modulo 5 (Modalità di indirizzamento)
- **Lezione 013 — Indirizzamento assoluto**: indirizzi a 16 bit, accesso a registri hardware (VIC-II, SID), comparazione con Zero Page, fetch/execute nel 6510
- **Lezione 014 — Indirizzamento indicizzato**: indexing con X/Y per array e tabelle, wraparound in Zero Page, modalità ZP indicizzato vs assoluto indicizzato

### Nuove lezioni - Modulo 6 (Controllo del flusso e subroutine)
- **Lezione 015 — Salti condizionati**: flag Z/N, BEQ/BNE/BPL/BMI, relative addressing, implementazione di loop condizionali
- **Lezione 016 — Subroutine: JSR e RTS**: chiamata a subroutine, stack pointer, preservazione di registri, passing di parametri via registri/Zero Page

### Aggiornamenti tecnici
- Corretto YAML in `mkdocs.yml`: titoli con due punti sono ora quotati (line 36: "Lezione 016 - Subroutine: JSR e RTS")
- Tutte le 4 lezioni seguono il template pedagogico standard (11 sezioni: Obiettivi, Intro, Teoria, 6510, Esempio, Errori, Esercizi, Riassunto, Prep, Approfondimento, Checklist)
- `mkdocs build` verificato, 0 errori

---

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

### Nuove lezioni - Modulo 5 (Modalità di indirizzamento)
- **Lezione 013 — Indirizzamento assoluto**: indirizzi a 16 bit, accesso a registri hardware (VIC-II, SID), comparazione con Zero Page, fetch/execute nel 6510
- **Lezione 014 — Indirizzamento indicizzato**: indexing con X/Y per array e tabelle, wraparound in Zero Page, modalità ZP indicizzato vs assoluto indicizzato

### Nuove lezioni - Modulo 6 (Controllo del flusso e subroutine)
- **Lezione 015 — Salti condizionati**: flag Z/N, BEQ/BNE/BPL/BMI, relative addressing, implementazione di loop condizionali
- **Lezione 016 — Subroutine: JSR e RTS**: chiamata a subroutine, stack pointer, preservazione di registri, passing di parametri via registri/Zero Page

### Aggiornamenti tecnici
- Corretto YAML in `mkdocs.yml`: titoli con due punti sono ora quotati (line 36: "Lezione 016 - Subroutine: JSR e RTS")
- Tutte le 4 lezioni seguono il template pedagogico standard (11 sezioni: Obiettivi, Intro, Teoria, 6510, Esempio, Errori, Esercizi, Riassunto, Prep, Approfondimento, Checklist)
- `mkdocs build` verificato, 0 errori

---

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
