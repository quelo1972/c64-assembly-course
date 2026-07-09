[🏠 Home](../../../index.md)

# Lezione 2 — Git e GitHub: versionamento e collaborazione

> **Obiettivo:** comprendere Git e GitHub per tracciare cambiamenti, collaborare e condividere codice Assembly.

---

## 🎯 Obiettivi

- comprendere versioning e perché serve;
- usare Git per commit, branch e history;
- settare repository remoto su GitHub;
- collaborare via pull request;
- gestire merge e conflitti.

---

## 🧠 Introduzione

Quando scrivi codice Assembly, hai bisogno di:

1. **Tracciare cambiamenti**: chi ha modificato cosa è quando
2. **Tornare indietro**: se sbagli, ripristini versioni precedenti
3. **Collaborare**: più persone lavorano sullo stesso codice
4. **Condividere**: pubblica il lavoro online

**Git** è lo strumento di versionamento standard. **GitHub** è il servizio cloud per repository remoti.

---

## 📘 Teoria

### Git: 3 stati fondamentali

```
Working Dir → Staging Area → Repository (commits)
```

- **Working Dir**: file modificati localmente
- **Staging Area**: file pronti per commit
- **Repository**: cronologia di commit

### Comandi Git essenziali

```bash
git init                    # Crea repository locale
git add .                   # Aggiungi file a staging
git commit -m "messaggio"   # Salva snapshot
git log                     # Vedi cronologia
git status                  # Vedi stato working dir
git diff                    # Vedi differenze
git branch                  # Crea/lista branch
git checkout -b feature     # Crea e switch a branch
git merge feature           # Merge branch in main
git push origin main        # Carica su GitHub
git pull origin main        # Scarica da GitHub
```

### GitHub: flusso collaborativo

1. Fork repository
2. Crea branch locale
3. Commit e push
4. Apri Pull Request
5. Review e merge
6. Main aggiornato

---

## 🤖 Come ragiona Git

Quando esegui `git commit`:

1. **Snapshot**: Git cattura lo stato di tutti i file
2. **Hash**: Genera un hash univoco per il commit (es: `a3f5b2c`)
3. **Metadata**: Salva autore, data, messaggio
4. **Puntatore**: Il branch punta al nuovo commit

Quando fai `git log`:

```
a3f5b2c (HEAD -> main) docs: add lesson 035
8ea7f4e docs: update CHANGELOG
c618e1e docs: add 6 critical lessons
```

HEAD punta sempre al commit attuale.

---

## 💡 Esempio pratico

```asm
; Lezione 002 - Programma minimo tracciabile in Git
*= $0801

BORDER = $D020

start:
	LDA #$06
	STA BORDER

loop:
	JMP loop
```

### Setup iniziale

```bash
# Clona il repository
git clone https://github.com/quelo1972/c64-assembly-course.git
cd c64-assembly-course

# Configura identità
git config user.name "Your Name"
git config user.email "email@example.com"
```

### Workflow tipico

```bash
# Crea feature branch
git checkout -b add-sprite-lesson

# Modifica file, salva, test
echo "Lezione su sprite..." > docs/sprite-lesson.md

# Vedi lo stato
git status

# Aggiungi e commit
git add docs/sprite-lesson.md
git commit -m "docs: add sprite lesson"

# Carica su GitHub
git push origin add-sprite-lesson

# Su GitHub: apri Pull Request, review, merge
```

### Sincronizzazione

```bash
# Scarica cambiamenti dal main
git pull origin main

# Risolvi conflitti se ce ne sono (edit file manualmente)
git add .
git commit -m "Resolve merge conflicts"
git push origin add-sprite-lesson
```

---

## ⚠️ Errori comuni

- **Commit messaggi vaghi**: scrivere "fix" invece di "fix: stack overflow in multiplication routine"
- **Commita file grandi**: binari PRG non dovrebbero essere in repo (usa .gitignore)
- **Forget to pull**: prima di lavorare, scarica i cambiamenti dal main
- **Conflitti non risolti**: Git ferma merge se ci sono conflitti
- **Perdere lavoro**: salva sempre con `git add` prima di `checkout` o `reset`

---

## 🧪 Esercizi

1. Clona il repository del corso
2. Crea un branch locale, aggiungi una nuova lezione stub, commit e push
3. Apri una Pull Request e vedi il flusso GitHub
4. Risolvi un merge conflict manualmente (crea il scenario)

---

## 📌 Riassunto

| Comando | Effetto |
|---------|---------|
| `git add` | Stage file per commit |
| `git commit -m` | Salva snapshot con messaggio |
| `git push origin branch` | Carica branch remoto |
| `git pull origin main` | Scarica e merge da remoto |
| `git branch` | Crea/lista branch |
| `git log` | Vedi cronologia commit |

---

## 🔜 Preparazione alla lezione successiva

Nella lezione 033 configureremo VS Code per Assembly e debugging.

---

## 🔎 Approfondimento — Dentro Git

**Merge vs Rebase:**

```bash
git merge feature       # Crea commit merge (storia non-lineare)
git rebase feature      # Riscrive history (lineare, più pulita)
```

**Stash per lavoro temporaneo:**

```bash
git stash              # Salva lavoro non-committed
git stash pop          # Ripristina
```

---

## 🤖 Come ragiona il 6510

Anche in questa lezione il 6510 segue un flusso semplice: esegue istruzioni in sequenza, aggiorna registri e memoria, e interagisce con l hardware tramite registri I/O quando necessario.

## 🔎 Approfondimento - Dentro il 6510

In questa fase iniziale, la stabilita nasce da un ambiente ripetibile: toolchain coerente, emulatori configurati e workflow ordinato. Costruire fondamenta solide qui evita attrito tecnico nei moduli successivi.

## ✅ Checklist finale

- [ ] Git installato e configurato
- [ ] Repository clonato e testato
- [ ] Push/pull funzionano
- [ ] Capisco il flusso branch → commit → PR
