# Workflow di sviluppo

Questo documento definisce le regole operative obbligatorie per creare o modificare moduli e lezioni del corso.

## Regola non negoziabile: 1 lezione = 1 esempio asm compilabile

Ogni lezione deve avere SEMPRE:

1. un blocco codice `asm` nella sezione `## 💡 Esempio pratico`;
2. un sorgente compilabile corrispondente;
3. una build verificata con `64tass`.

Nel repository questa regola e gestita automaticamente da `scripts/build-lesson-examples.sh`, che:

1. estrae il blocco `asm` della sezione `## 💡 Esempio pratico` di ogni lezione;
2. genera/aggiorna il file `src/lessons/<NNN-slug>/main.asm`;
3. compila ogni sorgente in `bin/lessons/<NNN-slug>.prg`.

Se anche una sola lezione non ha esempio asm valido o non compila, il check fallisce.

## Struttura standard

Le lezioni vivono in:

```text
docs/modules/modulo-{N}/lessons/{NNN}-{slug}.md
```

Le sorgenti esempi compilati vivono in:

```text
src/lessons/{NNN}-{slug}/main.asm
```

Gli output compilati vivono in:

```text
bin/{NNN}-{slug}.prg
```

Artefatti storici (pipeline precedente) vivono in:

```text
bin/legacy/*.prg
```

## Flusso obbligatorio per nuove lezioni o modifiche

Seguire SEMPRE questa sequenza:

1. creare/aggiornare la lezione in `docs/modules/.../lessons/...`;
2. verificare che `## 💡 Esempio pratico` contenga un blocco `asm` completo e standalone;
3. eseguire build esempi:
   - `make build-lessons`
4. correggere eventuali errori e ripetere finche la build esempi e tutta verde;
5. eseguire quality check globale:
   - `make quality-check`
6. solo dopo quality check OK: commit e push;
7. solo dopo push riuscito: deploy su `gh-pages`.

Regola vincolante:

- Mai fare commit/push/deploy se `make build-lessons` o `make quality-check` falliscono.
- Non mescolare nuovi output lezione con artefatti legacy: i file legacy restano in `bin/legacy`.

## Comandi standard

Build di tutti gli esempi lezione:

```bash
make build-lessons
```

Quality check globale (include build di tutti gli esempi):

```bash
make quality-check
```

Release completa (quality check -> commit -> push -> deploy):

```bash
./scripts/release-docs.sh "messaggio commit"
```

Deploy manuale (solo dopo quality check e push):

```bash
.venv/bin/mkdocs gh-deploy --clean -b gh-pages -r origin
```

## Requisiti editoriali lezioni

Ogni lezione deve contenere le intestazioni richieste dal template e mantenere coerenza didattica.

Intestazioni obbligatorie:

- `## 🎯 Obiettivi`
- `## 🧠 Introduzione`
- `## 📘 Teoria`
- `## 🤖 Come ragiona il 6510`
- `## 💡 Esempio pratico`
- `## ⚠️ Errori comuni`
- `## 🧪 Esercizi`
- `## 📌 Riassunto`
- `## 🔜 Preparazione alla lezione successiva`
- `## 🔎 Approfondimento - Dentro il 6510`
- `## ✅ Checklist finale`

## Requisiti dell esempio asm

Ogni esempio asm deve essere:

1. coerente con il tema della lezione;
2. minimo ma completo;
3. compilabile con `64tass --cbm-prg` senza errori;
4. privo di placeholder non assemblabili;
5. autosufficiente (niente include mancanti, simboli non definiti, pseudo-codice dentro il blocco).

## Appendici e navigazione

La sezione Appendici deve restare in fondo alla nav (`mkdocs.yml`) e in fondo al blocco moduli su `docs/index.md`.

## Hook e automazione

Il repository usa hook pre-push in `.githooks/pre-push` che esegue il quality check.

Installazione hook (una volta per clone):

```bash
make hook-install
```
