# C64 Assembly Course

Corso completo di programmazione Assembly per **Commodore 64** basato su tool moderni:

- 64tass assembler
- VS Code su WSL
- VICE emulator
- Git + GitHub

---

## 🎯 Obiettivo

Questo progetto nasce per costruire un percorso completo che porti a:

- comprendere il funzionamento del MOS 6510
- capire la memoria del Commodore 64
- programmare direttamente hardware (VIC-II, SID, CIA)
- scrivere piccoli programmi e giochi in Assembly

Alla fine del corso sarai in grado di sviluppare software reale per C64.

---

## 🚀 Quick Start

Clona il repository:

```bash
git clone https://github.com/quelo1972/c64-assembly-course.git
cd c64-assembly-course
```

Apri in VS Code (WSL):

```bash
code .
```

Compila il primo esempio:

```
Ctrl + Shift + B
```

Output generato:

```
bin/hello.prg
```

---

## 🧰 Requisiti

Assicurati di avere installato:

- WSL (Ubuntu consigliato)
- Visual Studio Code
- 64tass (`/usr/bin/64tass`)
- VICE (`x64sc`)
- Git

---

## ⚙️ Build

Il progetto usa 64tass.

Compilazione:

```bash
64tass --cbm-prg \
  -o bin/hello.prg \
  src/000-toolchain/hello.asm
```

Oppure direttamente da VS Code:

```
Ctrl + Shift + B
```

---

## 📁 Struttura del progetto

```
c64-assembly-course/
│
├── docs/              # Lezioni in Markdown
│   └── lessons/
│       └── 001-memory.md
│
├── src/               # Codice Assembly
│   ├── 000-toolchain/
│   ├── 001-memory/
│   ├── 002-binary/
│
├── bin/               # Output compilati (.prg)
│
├── .vscode/          # Configurazione VS Code
├── README.md
└── LICENSE
```

---

## 📚 Roadmap del corso

### Parte 0 - Toolchain
- [x] Setup ambiente
- [x] 64tass + VS Code + VICE
- [ ] Workflow di build completo

### Parte 1 - Fondamenti
- [x] Memoria del C64
- [ ] Sistema binario
- [ ] Sistema esadecimale
- [ ] Byte e rappresentazione dati

### Parte 2 - CPU 6510
- [ ] Registri (A, X, Y)
- [ ] Stack
- [ ] Program Counter
- [ ] Flag

### Parte 3 - Assembly base
- [ ] LDA / STA
- [ ] Operazioni matematiche
- [ ] Salti e loop

### Parte 4 - Hardware C64
- [ ] VIC-II
- [ ] SID
- [ ] CIA
- [ ] Memory-mapped I/O

### Parte 5 - Progetti
- [ ] Hello screen
- [ ] Sprite movement
- [ ] Sound
- [ ] Mini game

---

## 📖 Lezioni

Le lezioni sono in:

```
docs/lessons/
```

Ogni lezione ha:

- teoria (Markdown)
- esempi in Assembly
- esercizi

---

## 🧪 Primo programma

Il primo programma del corso è:

```asm
* = $1000

    rts
```

Serve solo per verificare che la toolchain funzioni correttamente.

---

## 🛠 Toolchain

Questo progetto usa:

- **64tass** come assembler
- **VICE x64sc** come emulatore
- **VS Code** come IDE
- **Git** per versionamento

---

## 📌 Stato del progetto

🚧 In sviluppo attivo
📘 Lezione 001 in corso

---

## 📜 Licenza

MIT License

---

## 🤝 Obiettivo finale

Questo repository vuole diventare:

> Un corso completo, gratuito e strutturato in italiano per imparare Assembly 6510 su Commodore 64 con strumenti moderni.

---

## 🔥 Nota

Questo non è un semplice insieme di esempi.

È un percorso progressivo che porta dalla teoria alla scrittura di veri programmi per C64.
