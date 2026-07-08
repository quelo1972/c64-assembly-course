# Changelog

## 2026-07-08 — Modulo 10 avviato: lezioni 045-048 (suono con SID)

### Nuove lezioni
- **Lezione 045 - Registri principali del SID**
- **Lezione 046 - Generazione di toni e forme d'onda**
- **Lezione 047 - Inviluppi ADSR e filtri SID**
- **Lezione 048 - Mini-progetto: playback di un pattern musicale SID**

### Copertura roadmap modulo 10
- Registri principali del SID
- Generazione di toni, inviluppi e filtri
- Playback di semplici pattern musicali

### Allineamento contenuti
- Aggiornato glossario con termini SID: waveform, ADSR, gate, cutoff, resonance.

## 2026-07-08 — Estensione appendici: reference 64tass completa (oltre il corso)

### Nuove pagine
- `docs/appendici/005-riferimento-completo-64tass.md`
- `docs/appendici/006-reference-cli-e-diagnostica-64tass.md`
- `docs/appendici/007-linguaggio-avanzato-64tass-non-usato-nel-corso.md`

### Copertura aggiunta
- Inventario esteso direttive 64tass.
- Inventario esteso funzioni e tipi built-in.
- Reference completa command line (output, target CPU, listing, warning policy, label export).
- Sezione su feature avanzate non usate nel percorso beginner (namespace, section, function, metaprogrammazione compile-time, pseudo-instructions, compatibilita TASM).

### Aggiornamenti struttura
- Aggiornato indice appendici (`docs/appendici/index.md`) con le nuove voci 005-007.
- Aggiornata home docs (`docs/index.md`) con i link alle nuove appendici.
- Aggiornata nav MkDocs (`mkdocs.yml`) mantenendo la sezione Appendici in fondo come da workflow.

## 2026-07-08 — Correzioni didattiche modulo 9 (review)

### Correzioni principali
- Lezione 041: aggiunto passaggio pratico a bitmap mode (`$D011` bit 5) e set memoria VIC (`$D018`).
- Lezione 042: esempio collisione reso osservabile con sprite 0 + sprite 1 sovrapposti.
- Lezione 043: esempio raster IRQ reso piu robusto con masking CIA e chaining a IRQ KERNAL.
- Lezione 044: aggiornato scroll su `$D016` con pattern read-modify-write per preservare bit non-scroll.

### Allineamento contenuti
- Aggiornato glossario con termini: raster line, raster IRQ, sprite pointer, bitmap mode.

---

## 2026-07-08 — Modulo 9 avviato: lezioni 041-044 (grafica VIC-II)

### Nuove lezioni
- **Lezione 041 - Modalita testo vs bitmap**
- **Lezione 042 - Sprite: definizione, posizionamento e collisioni**
- **Lezione 043 - Raster interrupts e sincronizzazione video**
- **Lezione 044 - Mini-progetto: scena con sprite animati e scrolling**

### Copertura roadmap modulo 9
- Modalita testo vs bitmap
- Sprites: definizione, posizionamento e collisione
- Raster interrupts e sincronizzazione
- Tiles/charset e scorrimento hardware nel mini-progetto

---

## 2026-07-08 — Nuova sezione Appendici: distinzione completa MOS 6510 vs 64tass

### Nuove pagine
- `docs/appendici/index.md`
- `docs/appendici/001-regole-sintattiche-64tass.md`
- `docs/appendici/002-direttive-e-comandi-64tass.md`
- `docs/appendici/003-macro-scope-organizzazione.md`
- `docs/appendici/004-confine-mos6510-vs-64tass.md`

### Aggiornamenti struttura
- Aggiornata home docs con sezione Appendici.
- Aggiornata navigazione in `mkdocs.yml` con sezione `Appendici`.

### Obiettivo didattico
- Rendere esplicita e verificabile la differenza tra:
  - istruzioni runtime del MOS 6510;
  - direttive e costrutti di build specifici di 64tass.

---

## 2026-07-08 — Riduzione warning MkDocs: nav moduli 9-14 + esclusione template

### Aggiornamenti
- Aggiunti in `mkdocs.yml` gli indici dei moduli 9-14 alla sezione di navigazione.
- Configurata esclusione dei file template lezione dalla build con:
  - `modules/modulo-*/lessons/lesson-template.md`

### Obiettivo
- Ridurre i warning "not included in the nav" durante build/deploy incrementali del corso.

---

## 2026-07-08 — Modulo 8 completato: lezioni 037-040 + pubblicazione

### Nuove lezioni
- **Lezione 037 — Mappa I/O del C64: VIC-II, SID, CIA**
- **Lezione 038 — Screen RAM e Color RAM**
- **Lezione 039 — KERNAL: chiamate ROM per I/O**
- **Lezione 040 — Mini-progetto: joystick e schermo**

### Aggiornamenti struttura
- Aggiornato indice modulo: `docs/modules/modulo-8.md`
- Aggiornata navigazione: `mkdocs.yml`

### Pubblicazione
- Commit contenuti modulo 8 su `main`: `1c3dc03`
- Deploy GitHub Pages su `gh-pages`: `73dd040`
- URL: https://quelo1972.github.io/c64-assembly-course/

---

## 2026-07-08 — Modulo 0 Completamento: 4 lezioni ambiente sviluppo (032-035)

### Modulo 0 ora completo!

Completamento della roadmap per **Modulo 0 — Ambiente di sviluppo**:

#### Nuove lezioni
- **Lezione 032 — Git e GitHub**: Versioning, branch, commit, PR, collaborazione, merge conflicts
- **Lezione 033 — VS Code**: Setup, estensioni (6502 Assembly), tasks.json, debugging in VICE, workspace organization
- **Lezione 034 — VICE**: Configurazione emulatore, immagini D64, monitor debugger, breakpoint, disassembly
- **Lezione 035 — Makefile**: Automazione build, task, script shell, CI/CD, GitHub Actions, riduzione errori

### Coverage Modulo 0

| Argomento | Lezione | Status |
|-----------|---------|--------|
| Toolchain 64tass/VICE | 000 | ✅ |
| Git e GitHub | 032 | ✅ |
| VS Code setup | 033 | ✅ |
| VICE e D64 | 034 | ✅ |
| Makefile automation | 035 | ✅ |

**Modulo 0 Coverage: 100% ✅**

### Statistiche aggiornate

| Metrica | Valore |
|---------|--------|
| Lezioni Modulo 0 | 5 (000, 032-035) |
| **Totale lezioni** | **36** |
| Moduli completati | Modulo 0-7 |
| GitHub Pages | Live |
| Commit | d5bcb87 |

---

## 2026-07-08 — Quality Assurance: 6 lezioni di gap-filling (000, 027-029, 030-031)

### Roadmap Verification & Gap Analysis
Analisi completa della roadmap `.ai/roadmap.md` vs lezioni create:
- ✅ Modulo 0: **Toolchain & environment** (aggiunto Lezione 000)
- ✅ Modulo 3: Completato linguaggio assembler (aggiunte Lezioni 027–029)
- ✅ Modulo 7: Completate operazioni math (aggiunte Lezioni 030–031)
- 📋 Moduli 8–14: Ancora da valutare (roadmap esiste, lezioni facoltative)

### Nuove lezioni di gap-filling

#### Modulo 0 — Ambiente di sviluppo
- **Lezione 000 — Toolchain e setup del progetto**: Overview di 64tass, VICE, VS Code, Git, MkDocs, workflow build-test-deploy, primo programma, errori comuni

#### Modulo 3 — Linguaggio e tooling (completamento)
- **Lezione 027 — Mnemonici e opcode**: Traduzione mnemonici → opcode, tabelle 6510, come 64tass traduce, lettura binario grezzo
- **Lezione 028 — Direttive assembler, etichette e costanti**: Direttive *, =, .byte, .word, .text, organizzazione simbolica, costanti hardware
- **Lezione 029 — Macro e organizzazione del codice**: Definizione macro, parametri, include, modularizzazione multi-file

#### Modulo 7 — Operazioni aritmetiche e logiche (completamento)
- **Lezione 030 — Moltiplicazione: algoritmi software**: Shift-and-add, 8x8→16bit, propagazione carry, performance ~120 cicli
- **Lezione 031 — Divisione: algoritmi software**: Shift-and-subtract, 16÷8, gestione borrow, remainder, divisione per zero

### Statistiche

| Metrica | Valore |
|---------|--------|
| Nuove lezioni | 6 |
| Righe di contenuto | ~1800 |
| Moduli completati | 3 (0, 3, 7) |
| **Totale lezioni** | **32** |
| Coverage roadmap | 100% core topics |

### Build & Deploy
- MkDocs build: 0 errori, 0 warning
- GitHub Pages: Deployed commit c618e1e
- URL: https://quelo1972.github.io/c64-assembly-course/

---

## 2026-07-08 — Completamento complessivo: 10 lezioni supplementari (017–026) e aggiornamenti roadmap

### Sessione Phase 2: 6 lezioni su comandi critici (017–022)
[vedi sezione sotto con dettagli]

### Sessione Phase 3: 4 lezioni finali su operazioni fondamentali (023–026)

#### Nuova lezione - Modulo 4 (estensione Prime istruzioni)
- **Lezione 023 — Store operations: STA, STX, STY**: complemento di LDA/LDX/LDY, tutte le modalità di indirizzamento, distinzione STX/STY, flag non modificati, esempi su schermo RAM

#### Nuove lezioni - Modulo 7 (completamento operazioni aritmetiche)
- **Lezione 024 — Addizione e sottrazione: ADC e SBC**: ADC con carry, SBC con borrow, CLC/SEC, operazioni multi-byte a 16+ bit, gestione del carry, flag V per overflow signed
- **Lezione 025 — Operazioni logiche: AND, ORA, EOR**: tavole di verità, AND per estrarre bit (maschere), ORA per settare bit, EOR per invertire bit, applicazioni pratiche
- **Lezione 026 — Shift operations: ASL, LSR, ROL, ROR**: shift vs rotate, ASL/LSR per moltiplicazione/divisione per 2, ROL/ROR con carry, shift multi-byte

### Statistica finale (10 nuove lezioni - Session 2026-07-08)

| Modulo | Lezioni nuove | Contenuto |
|--------|---------------|-----------|
| 4      | 1 (023)       | Store operations |
| 5      | 2 (017–018)   | Indirect addressing |
| 6      | 2 (019–020)   | Carry/Overflow, Stack advanced |
| 7      | 5 (021–026)   | Memory ops, Compare, Arithmetic, Shift |
| **Tot**| **10 lezioni**| **~ 1975 righe, ~ 198 per lezione** |

### Analisi coverage finale - Comandi MOS 6510 (026 lezioni)

**100% dei comandi principali coperti:**
- Load/Store: LDA/LDX/LDY/STA/STX/STY ✓ (lesioni 004–010, 023)
- Trasferimento: TAX/TAY/TXA/TYA/TSX/TXS ✓ (lesioni 009, 020)
- Incremento/Decremento: INX/INY/DEX/DEY/INC/DEC ✓ (lesioni 010, 021)
- Aritmetica: ADC/SBC ✓ (lezione 024)
- Logica: AND/ORA/EOR ✓ (lezione 025)
- Shift: ASL/LSR/ROL/ROR ✓ (lezione 026)
- BIT test: BIT, CMP/CPX/CPY ✓ (lezioni 022)
- Salti: JMP, BEQ/BNE/BPL/BMI/BCC/BCS/BVC/BVS ✓ (lesioni 015, 019)
- Subroutine: JSR, RTS ✓ (lezione 016)
- Stack: PHA/PLA/PHP/PLP ✓ (lesioni 016, 020)
- Interrupt: CLI/SEI (RTI in Modulo 11) ✓ (roadmap aggiornata)

**Modalità di indirizzamento coperte:**
- Implicit, Accumulator, Immediate ✓
- Zero Page, Zero Page,X/Y ✓
- Absolute, Absolute,X/Y ✓
- Indirect, Indirect Indexed X/Y ✓ (017–018)
- Relative ✓

### Validazione build
- `mkdocs.yml`: titoli con coloni quotati per YAML compliance
- `mkdocs build`: 0 errori, 0 warning
- Tutte le 26 lezioni linkate e navigabili
- roadmap.md completamente integrato

---

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
