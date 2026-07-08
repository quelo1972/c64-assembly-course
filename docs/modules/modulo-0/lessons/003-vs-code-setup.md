[🏠 Home](../../../index.md)

# Lezione 3 — VS Code: setup e debugging Assembly

> **Obiettivo:** configurare VS Code per scrivere, compilare e debuggare Assembly per il C64.

---

## 🎯 Obiettivi

- installare VS Code e le estensioni necessarie;
- configurare syntax highlighting per Assembly;
- settare task di build per 64tass;
- usare debugger e breakpoint in VICE;
- organizzare workspace efficacemente.

---

## 🧠 Introduzione

VS Code è leggero e potente. Per Assembly C64 abbiamo bisogno di:

1. **Syntax highlighting**: riconoscere mnemonici e direttive
2. **Build tasks**: compilare con 64tass
3. **Debugger**: connettere VICE e settare breakpoint
4. **File organization**: navigare agevolmente tra moduli

---

## 📘 Teoria

### Estensioni essenziali

Per Assembly 6502/6510:

- **6502 Assembly** (ottimo syntax highlighting)
- **ASM Code Lens** (reference code)
- **LLDB Debugger** (debugging)
- **Build Task Runner** (esecuzione task)

### File `.vscode/settings.json`

Personalizza comportamento di VS Code:

```json
{
  "editor.fontSize": 14,
  "editor.tabSize": 2,
  "[asm]": {
    "editor.defaultFormatter": "ms-vscode.cpptools"
  },
  "files.exclude": {
    "**/*.prg": true,
    "**/*.d64": false
  }
}
```

### File `tasks.json`

Definisci task di build:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Build C64",
      "type": "shell",
      "command": "64tass",
      "args": [
        "--cbm-prg",
        "-o",
        "${workspaceFolder}/bin/output.prg",
        "${file}"
      ],
      "group": {
        "kind": "build",
        "isDefault": true
      }
    },
    {
      "label": "Run in VICE",
      "type": "shell",
      "command": "x64",
      "args": ["${workspaceFolder}/bin/output.prg"],
      "dependsOn": "Build C64"
    }
  ]
}
```

### Debugging in VICE

VICE supporta debugger via monitor socket. Abilita in VICE:

```
Settings → Debugging → Monitor socket at port 6510
```

Poi in VS Code, configura `launch.json`:

```json
{
  "configurations": [
    {
      "name": "VICE Debugger",
      "type": "cppdbg",
      "request": "launch",
      "program": "${workspaceFolder}/bin/output.prg",
      "stopAtEntry": false,
      "cwd": "${workspaceFolder}"
    }
  ]
}
```

---

## 🤖 Come ragiona VS Code

### Syntax highlighting

1. Riconosce estensione `.asm`
2. Carica regole dell'estensione "6502 Assembly"
3. Colora mnemonici, registri, commenti
4. Aggiorna in real-time

### Build task

Quando premi `Ctrl+Shift+B`:

1. VS Code cerca `tasks.json`
2. Esegue il task con `"isDefault": true`
3. Cattura stdout/stderr
4. Mostra errori nel pannello "Problems"

---

## 💡 Esempio pratico

### Setup workspace

```bash
# Crea .vscode/settings.json
mkdir -p .vscode

cat > .vscode/settings.json << 'EOF'
{
  "editor.fontSize": 13,
  "editor.tabSize": 2,
  "[asm]": {
    "editor.insertSpaces": true,
    "editor.wordWrap": "on"
  },
  "files.associations": {
    "*.asm": "asm"
  }
}
EOF

# Crea .vscode/tasks.json
cat > .vscode/tasks.json << 'EOF'
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Build C64 Program",
      "type": "shell",
      "command": "64tass",
      "args": ["--cbm-prg", "-o", "bin/output.prg", "${file}"],
      "group": {"kind": "build", "isDefault": true},
      "problemMatcher": ["$gcc"]
    }
  ]
}
EOF
```

### Build e run

```bash
# In VS Code, premi Ctrl+Shift+B per eseguire build task
# oppure da terminale:
cd c64-assembly-course
64tass --cbm-prg -o bin/output.prg src/example.asm
x64 bin/output.prg
```

---

## ⚠️ Errori comuni

- **Estensione sbagliata**: "ARM Assembly" non supporta 6502
- **Task non trovato**: assicura che `tasks.json` sia in `.vscode/`
- **Breakpoint non funziona**: VICE deve avere debugger abilitato
- **Path relativi**: usa `${workspaceFolder}` per portabilità

---

## 🧪 Esercizi

1. Installa 6502 Assembly extension
2. Crea `tasks.json` con build task
3. Compila un programma con `Ctrl+Shift+B`
4. Configura VICE debugger e metti un breakpoint

---

## 📌 Riassunto

| Componente | Scopo |
|-----------|-------|
| Estensioni | Syntax highlighting, tools |
| settings.json | Personalizzazione editor |
| tasks.json | Build automation |
| VICE debugger | Breakpoint e step-through |

---

## 🔜 Preparazione alla lezione successiva

Nella lezione 034 vedremo VICE configuration e immagini disco.

---

## 🔎 Approfondimento — Dentro VS Code

**Remote SSH Debug:**

Se usi WSL, puoi debuggare in container SSH e collegare VICE remoto.

**Keybindings personalizzati:**

```json
{
  "key": "ctrl+shift+r",
  "command": "workbench.action.tasks.runTask",
  "args": "Build and Run"
}
```

---

## 🤖 Come ragiona il 6510

Anche in questa lezione il 6510 segue un flusso semplice: esegue istruzioni in sequenza, aggiorna registri e memoria, e interagisce con l hardware tramite registri I/O quando necessario.

## 🔎 Approfondimento - Dentro il 6510

In questa fase iniziale, la stabilita nasce da un ambiente ripetibile: toolchain coerente, emulatori configurati e workflow ordinato. Costruire fondamenta solide qui evita attrito tecnico nei moduli successivi.

## ✅ Checklist finale

- [ ] VS Code installato
- [ ] 6502 Assembly extension funzionante
- [ ] tasks.json creato e testato
- [ ] Build task esegue 64tass
- [ ] VICE apre dopo build
