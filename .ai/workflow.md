# Workflow di sviluppo

Questo documento descrive il processo standard da seguire per ogni modifica al progetto.

L'obiettivo è mantenere il repository coerente, verificabile e facile da mantenere.

---

# Creazione di una nuova lezione

Per ogni nuova lezione seguire sempre questi passaggi:

1. Creare il file della lezione in `docs/lessons/`.
2. Creare la cartella corrispondente in `src/`.
3. Preparare almeno un esempio Assembly compilabile.
4. Verificare che l'esempio venga compilato con 64tass.
5. Verificare l'esecuzione in VICE.
6. Verificare brevemente la generazione del sito con `mkdocs build`.
7. Aggiornare `docs/index.md`.
8. Aggiornare, se necessario, il glossario.
9. Aggiornare coerentemente `CHANGELOG.md`.
10. Eseguire commit e push.

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
