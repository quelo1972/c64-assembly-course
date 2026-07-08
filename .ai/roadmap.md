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

Mini-progetto: completare e presentare il progetto finale.

---

# Appendici e risorse

* Glossario esteso
* Mappe di memoria e riferimenti hardware
* FAQ e troubleshooting per 64tass/VICE
* Esempi pronti e script di build
