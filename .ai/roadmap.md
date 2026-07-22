# Roadmap del corso

> Stato: Bozza 2 — allineata al workflow incrementale del corso.

Questa roadmap definisce il percorso completo del corso di programmazione Assembly per Commodore 64. L'ordine dei moduli è pensato per introdurre un solo concetto alla volta, costruendo progressivamente competenze pratiche e conoscenze sull'hardware.

---

# Modulo 0 – Ambiente di sviluppo

Contenuti:

* Toolchain: `64tass`, `vice`, build scripts
* Git e GitHub: gestione del codice, branch e PR
* Editor e strumenti: VS Code/VSCodium, debugger, terminale
* Virtualizzazione: VICE e immagini disco
* Automazione: Makefile / task per build ed esempi

Mini-progetto: compilare ed eseguire il primo programma e pubblicare una versione del sito con MkDocs.

---

# Modulo 1 – Fondamenti

Contenuti:

* Architettura 8-bit: concetti chiave
* Sistema binario e esadecimale
* Byte, word e little-endian
* Mappa di memoria del C64 (RAM, ROM, I/O)
* Concetti di indirizzo e contenuto

Mini-progetto: analizzare un file PRG e determinare l'indirizzo di caricamento e il contenuto di alcune celle.

---

# Modulo 2 – CPU MOS 6510

Contenuti:

* Struttura del 6510: registri principali (A,X,Y,SP,PC,SR)
* Ciclo macchina, fetch/decode/execute
* Flags e come interpretarli
* Timing elementare delle istruzioni (concetti di cicli)

Mini-progetto: tracciare l'esecuzione passo-passo di un piccolo programma e calcolare i cambi di PC e flags.

---

# Modulo 3 – Linguaggio Assembly e tooling

Contenuti:

* Mnemonici e opcode
* Direttive assembler, etichette e costanti
* Macro semplici e organizzazione dei file sorgente
* Convenzioni di stile e commenti

Mini-progetto: creare un piccolo programma modulare con direttive e commenti chiari.

---

# Modulo 4 – Prime istruzioni e pratiche

Contenuti:

* Caricamento dati: `LDA/LDX/LDY`
* Trasferimento tra registri: `TAX/TAY/TXA/TYA`
* Incremento/decremento: `INX/INY/DEX/DEY`
* Uso dei registri come contatori

Mini-progetto: modificare il colore del bordo con loop controllati da registri.

---

# Modulo 5 – Modalità di indirizzamento (dettagliato)

Contenuti:

* Immediate, Zero Page, Absolute
* Indexed (X/Y), Indirect, Indirect Indexed
* Relative addressing per salti condizionati
* Implicazioni di performance e casi d'uso

**Comandi coperti:**
- `LDA/LDX/LDY` (caricamento con tutte le modalità)
- `STA/STX/STY` (archiviazione)
- Implicit e Absolute modalità avanzate

Mini-progetto: riscrivere lo stesso algoritmo usando diverse modalità di indirizzamento e confrontare il codice e i cicli macchina.

---

# Modulo 6 – Controllo del flusso e subroutine

Contenuti:

* Salti condizionati su flag Z/N: `BEQ/BNE/BPL/BMI`
* Salti condizionati su flag C/V: `BCC/BCS/BVC/BVS`
* Salti incondizionati: `JMP`
* Subroutine: `JSR`/`RTS` e convenzioni di passaggio parametri
* Stack e Stack Pointer: uso, preservazione dei registri
* Operazioni di stack: `PHA/PLA/PHP/PLP`, trasferimenti `TSX/TXS`

**Comandi coperti:**
- `BEQ/BNE/BPL/BMI/BCC/BCS/BVC/BVS` (tutti i salti condizionati)
- `JMP`, `JSR`, `RTS`
- `PHA/PLA/PHP/PLP/TSX/TXS`

Mini-progetto: implementare una libreria di utility (es: routine di stampa, delay) e chiamarla da un programma principale.

---

# Modulo 7 – Operazioni aritmetiche, logiche e di memoria

Contenuti:

* Addizione e sottrazione con `ADC`/`SBC` (gestione carry)
* Operazioni logiche: `AND/OR/EOR/ASL/LSR/ROL/ROR`
* Test di bit: `BIT` (confronto senza modifica)
* Incremento/decremento di memoria: `INC/DEC` (non solo registri)
* Compare operations: `CMP/CPX/CPY` (confronto con flag)
* Moltiplicazione e divisione (algoritmi software)

**Comandi coperti:**
- `ADC/SBC` (con carry)
- `AND/ORA/EOR` (logici bit)
- `ASL/LSR/ROL/ROR` (shift)
- `INC/DEC` (memoria e registri)
- `CMP/CPX/CPY` (compare)
- `BIT` (bit test)

Mini-progetto: implementare routine di moltiplicazione e divisione a 8/16 bit.

---

# Modulo 8 – I/O e periferiche

Contenuti:

* Mappa I/O del C64: VIC-II, SID, CIA, porte joystick
* Uso della memoria video e character/screen RAM
* Accesso al kernel e chiamate ROM (KERNAL)

Mini-progetto: scrivere una routine che legge joystick e aggiorna lo schermo.

---

# Modulo 9 – Grafica con VIC-II

Contenuti:

* Modalità testo vs bitmap
* Sprites: definizione, posizionamento e collisione
* Raster interrupts e sincronizzazione
* Tiles, charset e scorrimento hardware

Mini-progetto: creare una scena con sprite animati e semplice scrolling.

---

# Modulo 10 – Suono con SID

Contenuti:

* Registri principali del SID
* Generazione di toni, inviluppi e filtri
* Playback di semplici pattern musicali

Mini-progetto: riprodurre una melodia semplice con il SID.

---

# Modulo 11 – Interrupt, CIA, e gestione tempo

Contenuti:

* Tipi di interrupt (NMI, IRQ)
* Gestione interrupt: `CLI/SEI` (enable/disable interrupt flag), `RTI` (return from interrupt)
* CIA chips: timers, serial, keyboard matrix
* Uso degli interrupt per timing e input
* Flag di stato e interrupt mask

**Comandi coperti:**
- `CLI/SEI` (clear/set interrupt disable)
- `RTI` (return from interrupt)
- `BRK` (break/interrupt)

Mini-progetto: usare un timer per generare eventi periodici controllati da interrupt.

---

# Modulo 12 – File system, cassette e disk I/O

Contenuti:

* Comunicazione con il drive 1541 (serial protocol)
* Uso delle routine KERNAL per I/O su disco/nastro
* Formati PRG e D64

Mini-progetto: salvare e caricare dati semplici su disco (o immagine D64 in VICE).

---

# Modulo 13 – Ottimizzazione e tecniche avanzate

Contenuti:

* Ottimizzazione per cicli e memoria
* Paging e bank switching (MEMORY MAP avanzata)
* Tecniche di compressione e data packing

Mini-progetto: ottimizzare una routine esistente per ridurre cicli e/o spazio.

---

# Modulo 14 – Progetto finale

Contenuti:

* Definizione del progetto (gioco o demo)
* Pianificazione, modularizzazione e test
* Packaging e release (PRG/D64 e sito)
* Track consigliata: shoot 'em up rudimentale

Mini-progetto: completare e presentare il progetto finale.

---

# Track integrata – Shoot 'em up rudimentale

Obiettivo:

Realizzare un mini gioco completo a schermo singolo con movimento del player, proiettili, nemici, collisioni, punteggio e game over.

Sistemi da implementare (in ordine):

1. Game loop a tick fisso (IRQ raster o timer CIA)
2. Input joystick con debounce minimo
3. Movimento player e limiti schermo
4. Sistema proiettili (pool fisso in RAM)
5. Spawn nemici a ondate semplici
6. Collisioni player/proiettile/nemico
7. HUD base: score, vite, stato partita
8. Audio eventi (sparo, hit, esplosione)
9. Stato partita: title, playing, game over, restart
10. Ottimizzazione cicli (update solo entita attive)

Milestone suggerite:

* M1: player controllabile + fuoco
* M2: nemici + collisioni + score
* M3: audio + game over + bilanciamento base
* M4: packaging finale PRG/D64 + documentazione tecnica

Mappa dipendenze con i moduli:

* Input e controllo tempo: Moduli 8 e 11
* Sprite, rendering e collisioni: Modulo 9
* Suono eventi: Modulo 10
* Struttura codice e subroutine: Moduli 3, 6 e 7
* Ottimizzazione finale: Modulo 13

Gap minimi da aggiungere al corso (se volete piu robustezza):

* Lezione breve su architettura game state machine
* Lezione breve su object pool in Zero Page e RAM
* Lezione breve su debug delle collisioni (hitbox semplificate)

Scaletta lezioni finali consigliata (065+):

* 065-game-loop-e-state-machine: loop a tick fisso, stati title/playing/game-over
* 066-player-input-e-movimento: joystick, limiti schermo, velocita e feeling
* 067-sparo-e-object-pool: pool proiettili, rate of fire, lifecycle attivo/inattivo
* 068-nemici-e-spawn-controller: pattern base di spawn, movimento verticale/orizzontale
* 069-collisioni-e-danno: AABB semplificata, hit player e hit nemico, invulnerabilita breve
* 070-score-vite-hud: punteggio, vite residue, difficolta progressiva minima
* 071-audio-eventi-sid: sfx per sparo, hit, esplosione e game over
* 072-polish-e-packaging-finale: bilanciamento, refactoring, build PRG/D64, release note
* 073-nemici-multipli-pattern-avanzati (opzionale): wave avanzate e comportamento nemici differenziato

Percorsi file consigliati (senza conflitti con lezioni esistenti):

* Sorgenti ASM: src/lessons/065-.../main.asm fino a src/lessons/072-.../main.asm
* Output compilati: bin/065-....prg fino a bin/072-....prg
* Documentazione: docs/modules/modulo-14/lessons/065-....md fino a 072-....md

Naming completo suggerito:

* src/lessons/065-game-loop-e-state-machine/main.asm -> bin/065-game-loop-e-state-machine.prg
* src/lessons/066-player-input-e-movimento/main.asm -> bin/066-player-input-e-movimento.prg
* src/lessons/067-sparo-e-object-pool/main.asm -> bin/067-sparo-e-object-pool.prg
* src/lessons/068-nemici-e-spawn-controller/main.asm -> bin/068-nemici-e-spawn-controller.prg
* src/lessons/069-collisioni-e-danno/main.asm -> bin/069-collisioni-e-danno.prg
* src/lessons/070-score-vite-hud/main.asm -> bin/070-score-vite-hud.prg
* src/lessons/071-audio-eventi-sid/main.asm -> bin/071-audio-eventi-sid.prg
* src/lessons/072-polish-e-packaging-finale/main.asm -> bin/072-polish-e-packaging-finale.prg
* src/lessons/073-nemici-multipli-pattern-avanzati/main.asm -> bin/073-nemici-multipli-pattern-avanzati.prg

Deliverable per ogni lezione:

* 1 file sorgente principale incrementale
* 1 versione compilata in bin
* 1 checklist di test manuali (3-5 casi)

---

# Appendici e risorse

* Glossario esteso
* Mappe di memoria e riferimenti hardware
* FAQ e troubleshooting per 64tass/VICE
* Esempi pronti e script di build
