[🏠 Home](../../../index.md)

# Lezione 5 — Automazione: Makefile e task build

> **Obiettivo:** automatizzare build, testing e deployment con Makefile e script shell.

---

## 🎯 Obiettivi

- comprendere Makefile e target;
- creare regole di build automatiche;
- scriptare operazioni ricorrenti (compile, run, deploy);
- integrare con CI/CD (GitHub Actions);
- ridurre errori manuali.

---

## 🧠 Introduzione

Manualmente:

```bash
64tass --cbm-prg -o bin/output.prg src/main.asm
x64 bin/output.prg
git add .
git commit -m "..."
git push origin main
mkdocs build
mkdocs gh-deploy
```

è tedioso e soggetto a errori.

**Makefile** e script automatizzano queste operazioni.

---

## 📘 Teoria

### Sintassi Makefile

```makefile
TARGET: PREREQUISITES
	COMMAND

build: src/main.asm
	64tass --cbm-prg -o bin/output.prg src/main.asm

run: build
	x64 bin/output.prg

clean:
	rm -f bin/*.prg
```

- **TARGET**: nome della regola (es: `build`)
- **PREREQUISITES**: dipendenze (se cambia, ri-esegui)
- **COMMAND**: azioni da eseguire (indentato con TAB)

### Variabili Makefile

```makefile
ASM = 64tass
CFLAGS = --cbm-prg
OUTPUT = bin/output.prg
SOURCE = src/main.asm

build:
	$(ASM) $(CFLAGS) -o $(OUTPUT) $(SOURCE)
```

### .PHONY targets

Per target che non creano file:

```makefile
.PHONY: build run clean deploy

build:
	...

clean:
	rm -f bin/*.prg
```

---

## 🤖 Come ragiona Make

Quando esegui `make run`:

1. Cerca target `run`
2. Guarda prerequisiti: `build`
3. Se `build` non esiste, esegui `build`
4. Se `build` esiste e `src/main.asm` non è cambiato, salta
5. Se `src/main.asm` è più recente di `build`, ri-esegui
6. Dopo `build` completato, esegui `run`

---

## 💡 Esempio pratico

```asm
* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0
; Lezione 005 - Sorgente minimo per pipeline make build/run


    .word 0


BORDER = $D020

start:
	LDA #$05
	STA BORDER
	RTS
```

### Makefile completo

```makefile
.PHONY: build run clean deploy all

# Variabili
ASM = 64tass
EMULATOR = x64
PYTHON = .venv/bin/python3
MKDOCS = .venv/bin/mkdocs

OUTPUT = bin/legacy/hello.prg
SOURCE = src/legacy/000-toolchain/hello.asm

# Target default
all: build

# Build Assembly
build: $(SOURCE)
	@echo "🔨 Building C64 program..."
	$(ASM) --cbm-prg -o $(OUTPUT) $(SOURCE)
	@echo "✅ Build complete: $(OUTPUT)"

# Run in emulator
run: build
	@echo "🎮 Launching VICE..."
	$(EMULATOR) $(OUTPUT)

# Clean build artifacts
clean:
	@echo "🧹 Cleaning..."
	rm -f bin/*.prg
	@echo "✅ Clean complete"

# Build documentation
docs:
	@echo "📚 Building docs..."
	$(MKDOCS) build -q

# Deploy docs to GitHub Pages
deploy: docs
	@echo "🚀 Deploying to GitHub Pages..."
	$(MKDOCS) gh-deploy --clean -b gh-pages -r origin
	@echo "✅ Deployed"

# Full pipeline
full: build deploy
	@echo "✅ Full pipeline complete"

# Help
help:
	@echo "Available targets:"
	@echo "  make build    - Compile C64 program"
	@echo "  make run      - Run in VICE emulator"
	@echo "  make clean    - Remove build artifacts"
	@echo "  make docs     - Build documentation"
	@echo "  make deploy   - Deploy docs to GitHub Pages"
	@echo "  make full     - Build and deploy"
```

### Uso

```bash
# Build only
make build

# Build and run
make run

# Full pipeline (build + deploy docs)
make full

# Help
make help
```

### Script shell per operazioni complesse

File `scripts/build-all.sh`:

```bash
#!/bin/bash
set -e

echo "🔨 Building all modules..."
for mod in 0 1 2 3 4; do
  echo "  Building modulo-$mod..."
  64tass --cbm-prg -o bin/mod$mod.prg src/modulo-$mod/main.asm
done

echo "📚 Building docs..."
.venv/bin/mkdocs build -q

echo "✅ Build complete!"
```

---

## ⚠️ Errori comuni

- **TAB vs spaces**: COMMAND deve essere indentato con TAB, non spazi
- **Prerequisiti dimenticati**: Make non sa se ri-eseguire
- **Ordine dipendenze**: se `run` dipende da `build`, esegui `build` prima
- **@ command silenzioso**: `@echo` non stampa il comando stesso
- **Path hardcoded**: usa variabili per portabilità

---

## 🧪 Esercizi

1. Scrivi un Makefile che compila, esegue e pulisce
2. Aggiungi target per deploy docs
3. Integra uno script shell per build multi-modulo
4. Aggiungi GitHub Actions per CI/CD

---

## 📌 Riassunto

| Componente | Uso |
|-----------|-----|
| Makefile | Automazione build |
| Target | Regola (build, run, clean) |
| Prerequisiti | Dipendenze (re-run se cambiano) |
| Shell script | Logica complessa |
| .PHONY | Target senza file output |

---

## 🔜 Modulo 0 completato!

Hai imparato:
- ✅ Toolchain (64tass, VICE)
- ✅ Git e GitHub
- ✅ VS Code setup
- ✅ VICE e disco
- ✅ Automazione Makefile

Sei pronto per il Modulo 1: Fondamenti Assembly!

---

## 🔎 Approfondimento — Dentro Make

**Pattern rules (%.rule):**

```makefile
%.prg: %.asm
	$(ASM) --cbm-prg -o $@ $<

# Usa:
# make src/legacy/000-toolchain/hello.prg  → compila src/legacy/000-toolchain/hello.asm → src/legacy/000-toolchain/hello.prg
```

**Funzioni Make:**

```makefile
SOURCES = $(wildcard src/*.asm)
OBJECTS = $(SOURCES:.asm=.prg)

build: $(OBJECTS)
```

---

## 🤖 Come ragiona il 6510

Anche in questa lezione il 6510 segue un flusso semplice: esegue istruzioni in sequenza, aggiorna registri e memoria, e interagisce con l hardware tramite registri I/O quando necessario.

## 🔜 Preparazione alla lezione successiva

Nella prossima lezione useremo questi concetti come base e aggiungeremo un livello in piu di controllo sul flusso del programma e sulla relazione tra CPU e periferiche.

## 🔎 Approfondimento - Dentro il 6510

In questa fase iniziale, la stabilita nasce da un ambiente ripetibile: toolchain coerente, emulatori configurati e workflow ordinato. Costruire fondamenta solide qui evita attrito tecnico nei moduli successivi.

## ✅ Checklist finale

- [ ] Makefile creato e testato
- [ ] Build target funziona
- [ ] Run target funziona
- [ ] Deploy target funziona
- [ ] Tutto automatizzato senza errori manuali
