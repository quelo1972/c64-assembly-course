# Workflow di sviluppo

Questo documento descrive il processo standard da seguire per ogni modifica al progetto.

L'obiettivo è mantenere il repository coerente, verificabile e facile da mantenere.

---

## Struttura della documentazione

Le lezioni vivono in:

```
docs/modules/modulo-{N}/lessons/{NNN}-{slug}.md
```

Ogni modulo ha:
- `docs/modules/modulo-{N}.md` — pagina indice del modulo
- `docs/modules/modulo-{N}/lessons/` — cartella lezioni
- `docs/modules/modulo-{N}/lessons/lesson-template.md` — template da copiare

---

## Creazione di una nuova lezione (metodo raccomandato)

Usare lo script helper:

```bash
./scripts/new-lesson.sh <modulo> <numero> <slug> "<Titolo esteso>"
# Esempio:
./scripts/new-lesson.sh 5 013 "indirizzamento-assoluto" "Indirizzamento assoluto"
```

Lo script:
1. Copia `lesson-template.md` nella cartella `lessons/` corretta
2. Aggiorna l'indice del modulo (`docs/modules/modulo-N.md`)
3. Aggiunge la voce nav in `mkdocs.yml`

Dopo l'esecuzione:
1. Scrivi il contenuto completo nel file creato
2. Aggiungi l'esempio Assembly in `src/modulo-{N}/`
3. Verifica che l'esempio compili con `64tass`
4. Esegui `mkdocs build` e controlla i warning
5. Aggiorna `CHANGELOG.md`
6. Esegui commit e push su `main`
7. Pubblica con `.venv/bin/mkdocs gh-deploy --clean -b gh-pages -r origin`

---

## Creazione manuale di una lezione

Se preferisci senza lo script:

1. Copia `docs/modules/modulo-{N}/lessons/lesson-template.md` → `{NNN}-{slug}.md`
2. Compila tutte le sezioni del template (vedi `.ai/lesson-template.md`)
3. Aggiungi la voce in `docs/modules/modulo-{N}.md` sotto `## Lezioni incluse`
4. Aggiungi la voce nav in `mkdocs.yml` sotto il modulo corretto
5. Segui i passi 2–7 del metodo raccomandato

---

## Regola posizione Appendici (navigazione web)

Le **Appendici** devono comparire **sempre in fondo** alla navigazione del corso nel sito MkDocs.

Regole operative:

1. In `mkdocs.yml`, la sezione `Appendici` deve essere l'ultima sezione della `nav`.
2. Nessun nuovo modulo o sezione del corso deve essere aggiunto dopo `Appendici`.
3. In `docs/index.md`, il blocco "Appendici" deve rimanere dopo l'elenco dei moduli.

---

## Modus operandi obbligatorio (moduli e lezioni)

Per ogni nuovo modulo o batch di lezioni, seguire **sempre** questa sequenza senza eccezioni:

1. **Creazione contenuti**
	- creare lezioni, indice modulo, nav `mkdocs.yml`, eventuale glossario e `CHANGELOG.md`.
2. **Quality check globale (prima del commit)**
	- build completa: `.venv/bin/mkdocs build -q`;
	- verifica conformita intestazioni template su tutte le lezioni (`docs/modules/**/lessons/*.md`, esclusi i template);
	- verifica link/nav e assenza file temporanei.
3. **Solo dopo quality check OK**
	- eseguire commit su `main`;
	- eseguire push su `origin/main`.
4. **Solo dopo push riuscito**
	- eseguire deploy: `.venv/bin/mkdocs gh-deploy --clean -b gh-pages -r origin`.

Regola vincolante:

- **Mai fare commit/push/deploy prima del quality check globale**.
- Se il quality check fallisce, si corregge prima e si ripete il check fino a esito positivo.

### Comando standard (copia/incolla) per quality check globale

Usare questo comando unico prima di ogni commit/push/deploy su moduli e lezioni:

```bash
cd /home/andros/Projects/c64-assembly-course && \
.venv/bin/mkdocs build -q && \
req=("## 🎯 Obiettivi" "## 🧠 Introduzione" "## 📘 Teoria" "## 🤖 Come ragiona il 6510" "## 💡 Esempio pratico" "## ⚠️ Errori comuni" "## 🧪 Esercizi" "## 📌 Riassunto" "## 🔜 Preparazione alla lezione successiva" "## 🔎 Approfondimento - Dentro il 6510" "## ✅ Checklist finale") && \
missing=0 && \
while IFS= read -r f; do
	for h in "${req[@]}"; do
		grep -Fq "$h" "$f" || { echo "MISSING: $f :: $h"; missing=1; }
	done
done < <(find docs/modules -path '*/lessons/*.md' ! -name 'lesson-template.md' | sort) && \
[[ $missing -eq 0 ]]
```

Interpretazione esito:

- Se il comando termina senza output, quality check globale OK.
- Se appaiono righe `MISSING: ...`, correggere prima di procedere.

### Standard operativo repository (script + hook)

Per evitare dimenticanze future, usare sempre gli strumenti versionati nel repository:

1. `./scripts/quality-check.sh`
	- esegue build MkDocs, conformita intestazioni template, controllo file temporanei.
2. `./scripts/release-docs.sh "messaggio commit"`
	- esegue quality check, commit (solo staged), push e deploy in sequenza.
3. Hook pre-push versionato in `.githooks/pre-push`
	- blocca `git push` se il quality check fallisce.

Installazione hook (una volta per clone):

```bash
make hook-install
```

---

## Regole per gli esempi

Ogni esempio deve:

* compilare senza warning o errori con `64tass --cbm-prg`;
* essere il più piccolo possibile;
* introdurre un solo concetto nuovo;
* essere coerente con quanto spiegato nella lezione.

---

## Regole per le lezioni

Ogni lezione deve contenere esattamente queste intestazioni, con questo wording e le icone corrispondenti:

* 🎯 Obiettivi
* 🧠 Introduzione
* 📘 Teoria
* 🤖 Come ragiona il 6510
* 💡 Esempio pratico
* ⚠️ Errori comuni
* 🧪 Esercizi
* 📌 Riassunto
* 🔜 Preparazione alla lezione successiva
* 🔎 Approfondimento - Dentro il 6510
* ✅ Checklist finale

Ogni nuova lezione deve essere confrontata con `.ai/lesson-template.md` prima del merge.

Regola istruzioni: non citare o usare istruzioni Assembly senza fornire una breve spiegazione contestuale nella stessa lezione, a meno che l'istruzione sia già stata trattata in una lezione precedente.

---

## Deploy su GitHub Pages

**Non modificare mai il branch `gh-pages` manualmente.**

Per pubblicare:

```bash
.venv/bin/mkdocs gh-deploy --clean -b gh-pages -r origin
```

Per dettagli vedere `.ai/deployment.md`.

---

## Commit

Messaggi di commit nel formato:

```
tipo(scope): descrizione breve

# Esempi:
docs(mod5): add lesson 013 - Indirizzamento assoluto
feat(scripts): add new-lesson.sh helper
fix(nav): correct mkdocs.yml indentation
chore(docs): add lesson-template.md to modules 5-14
```

---

# Regole per gli esempi

Ogni esempio deve:

* compilare senza warning o errori;
* essere il più piccolo possibile;
* introdurre un solo concetto nuovo;
* essere coerente con quanto spiegato nella lezione.

---

# Regole per le lezioni

Ogni lezione deve contenere esattamente queste intestazioni, con questo wording e le icone corrispondenti:

* 🎯 Obiettivi
* 🧠 Introduzione
* 📘 Teoria
* 🤖 Come ragiona il 6510
* 💡 Esempio pratico
* ⚠️ Errori comuni
* 🧪 Esercizi
* 📌 Riassunto
* 🔜 Preparazione alla lezione successiva
* 🔎 Approfondimento - Dentro il 6510
* ✅ Checklist finale

Ogni nuova lezione deve essere confrontata con `.ai/lesson-template.md` prima del merge. Le intestazioni devono corrispondere esattamente al template, compresi emoji e wording.

---

# Commit

Preferire messaggi di commit chiari e descrittivi.

Esempi:

* `Add lesson 007 - Program Counter`
* `Improve lesson 003 exercises`
* `Fix example for LDA immediate addressing`

---

# Controlli prima del push

Prima di eseguire il push verificare:

* il sito GitHub Pages continua a funzionare;
* gli esempi compilano;
* i link tra le lezioni sono corretti;
* non sono stati introdotti file temporanei nel repository;
* tutte le lezioni `docs/lessons/*.md` contengono le intestazioni del template esattamente come in `.ai/lesson-template.md`;
* tutte le lezioni hanno `## Approfondimento - Dentro il 6510` e `## Checklist finale` quando previsto dal template.
* la pubblicazione MkDocs usa il branch `gh-pages` e non il percorso `main/docs`.
* la sezione `Appendici` e in fondo alla navigazione (`mkdocs.yml`) e in fondo al blocco moduli in `docs/index.md`.

---

# Pubblicazione MkDocs

Per una pubblicazione coerente e ripetibile del sito MkDocs, seguire sempre questa procedura:

1. Generare il sito localmente con `.venv/bin/mkdocs build`.
2. Verificare che il sito locale sia corretto.
3. Eseguire il deploy su GitHub Pages usando il branch `gh-pages`.
4. Verificare che la configurazione GitHub Pages punti a `gh-pages` con `path: /`.
5. Non usare `main/docs` come sorgente di Pages per questo progetto; `docs/` contiene le sorgenti markdown, non il sito generato.

Questa procedura evita che la versione remota mostri un sito diverso da quella generata da MkDocs.

---

# Principio fondamentale

Mai sacrificare la comprensione per la velocità.

Ogni esempio e ogni spiegazione devono essere verificati e mantenuti il più semplici possibile.
