[🏠 Home](../../../index.md)

# Lezione 1 — Toolchain e setup del progetto

> **Obiettivo:** comprendere il toolchain per Assembly del Commodore 64 e configurare l'ambiente di sviluppo.

---

## 🎯 Obiettivi

- comprendere il ruolo di 64tass, VICE, Git e MkDocs;
- configurare VS Code per Assembly;
- creare il primo programma e compilarlo;
- comprendere il workflow build-test-deploy.

---

## 🧠 Introduzione

Per programmare in Assembly per il C64, abbiamo bisogno di strumenti specifici:

- **Assembler** (64tass): traduce `.asm` in `.prg`
- **Emulatore** (VICE): esegue i programmi su un C64 simulato
- **Editor** (VS Code): scrive il codice sorgente
- **Versionamento** (Git): traccia i cambiamenti
- **Documentazione** (MkDocs): pubblica il corso

Questo corso usa tutti questi strumenti insieme per un workflow professionale.

---

## 📘 Teoria

### 64tass (Turbo Assembler v1.56.2885)

Assembler moderno per 6502/65c02:

```bash
64tass --cbm-prg -o output.prg input.asm
```

Opzioni comuni:
- `--cbm-prg`: output formato CBM PRG (con indirizzo di caricamento)
- `-o`: file di output
- `-W`: warning and diagnostics

### VICE (Versatile Commodore Emulator)

Emulatore del Commodore 64:

```bash
x64 -fullscreen output.prg
```

Permette debugging con breakpoint, trace, memoria viewer.

### VS Code Extensions

Per Assembly C64, installa:
- **6502 Assembly** (per syntax highlighting)
- **x86 and x86_64 Assembly** (per 6502 syntax)
- **Build Tools for Visual Studio**

### Makefile / Task per Build

Automatizza la compilazione:

```bash
make build          # compila
make run            # esegue in VICE
make deploy         # pubblica su GitHub Pages
```

---

## 🤖 Come ragiona il 6510

Durante la compilazione:

1. **Assembler** legge il sorgente `.asm`
2. **Parsing**: traduce mnemonici in opcode
3. **Linking**: risolve indirizzi e etichette
4. **Output**: scrive il file `.prg` con indirizzo di caricamento
5. **Loader**: il C64 carica il programma in memoria

---

## 💡 Esempio pratico

### Primo programma: Hello C64

```asm
; hello.asm
* = $0801        ; indirizzo BASIC di caricamento

    .text
    "10 PRINT"HELLO C64""
    "
"
    "20 END"
    "
"
    
    RTS
```

### Build

```bash
64tass --cbm-prg -o hello.prg hello.asm
x64 hello.prg
```

Risultato: il programma carica e stampa "HELLO C64".

---

## ⚠️ Errori comuni

- **Indirizzo di caricamento sbagliato**: `* = $0801` è standard per BASIC, `* = $1000` per Assembly
- **Dimenticare il `.cbm-prg` flag**: senza questo, manca l'indirizzo di caricamento
- **Path relativi in build**: usa path assoluti o relativi coerenti
- **VICE non trova il file**: controlla percorsi e permessi

---

## 🧪 Esercizi

1. Installa 64tass, VICE, VS Code e verifica le versioni
2. Scrivi un programma che carica un valore in A e lo scrive in `$D020`
3. Compila e esegui in VICE

---

## 📌 Riassunto

| Strumento | Ruolo | Comando |
|-----------|-------|---------|
| 64tass | Assembler | `64tass --cbm-prg -o out.prg in.asm` |
| VICE | Emulatore | `x64 out.prg` |
| VS Code | Editor | Configurate con extensions |
| Git | Versionamento | `git add/commit/push` |
| MkDocs | Documentazione | `mkdocs build/gh-deploy` |

---

## 🔜 Preparazione alla lezione successiva

Nella lezione 001 vedremo i fondamenti: la memoria del Commodore 64 e come i dati sono organizzati.

---

## 🔎 Approfondimento — Dettagli toolchain

**Indirizzo di caricamento PRG:**

```
Byte 0-1: Indirizzo basso-alto (little-endian)
Byte 2+: Codice programma
```

Ad esempio `$0801` significa:
- Byte 0: `$01` (basso)
- Byte 1: `$08` (alto) = `$0801`

---

## 🔎 Approfondimento - Dentro il 6510

In questa fase iniziale, la stabilita nasce da un ambiente ripetibile: toolchain coerente, emulatori configurati e workflow ordinato. Costruire fondamenta solide qui evita attrito tecnico nei moduli successivi.

## ✅ Checklist finale

- [ ] 64tass versione verificata
- [ ] VICE installato e testato
- [ ] VS Code con extensions
- [ ] Primo programma compila e esegue
