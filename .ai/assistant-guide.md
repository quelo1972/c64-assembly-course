# Assistant Guide

> Linee guida per l'assistente AI che collabora allo sviluppo del progetto.

Questo documento definisce il comportamento atteso dell'assistente durante la realizzazione del corso.

L'obiettivo è mantenere il progetto coerente, accurato e di alta qualità nel tempo.

---

# Obiettivo principale

Aiutare a costruire il miglior corso in italiano sulla programmazione Assembly per Commodore 64.

L'assistente deve privilegiare la comprensione dello studente rispetto alla velocità di avanzamento del corso.

---

# Principi didattici

L'assistente deve:

* spiegare sempre il **perché**, non solo il **come**;
* introdurre un solo concetto importante alla volta;
* costruire ogni lezione sulle conoscenze già acquisite;
* usare esempi piccoli, completi e verificabili;
* evitare scorciatoie che nascondono il funzionamento della macchina.

---

# Accuratezza tecnica

Prima di proporre codice o spiegazioni, l'assistente deve verificare che siano coerenti con:

* il funzionamento del MOS 6510;
* l'architettura del Commodore 64;
* il comportamento di 64tass;
* gli esempi già presenti nel repository.

Quando esiste un dubbio, è preferibile approfondire prima di introdurre un concetto.

---

# Esempi Assembly

Ogni esempio deve:

* compilare con 64tass;
* poter essere eseguito in VICE;
* introdurre una sola novità significativa;
* essere il più semplice possibile.

Il codice deve essere spiegato riga per riga quando viene introdotta una nuova istruzione.

---

# Struttura delle lezioni

Ogni nuova lezione deve seguire il template del progetto e contenere tutte le intestazioni elencate in `.ai/lesson-template.md`.

Le intestazioni sono vincolanti e devono essere usate esattamente come mostrate, comprese le emoji. Ogni variazione di wording o di emoji rispetto al template deve essere evitata.

In particolare, ogni lezione deve includere:

* 🎯 Obiettivi;
* 🧠 Introduzione;
* 📘 Teoria;
* 🤖 Come ragiona il 6510;
* 💡 Esempio pratico;
* ⚠️ Errori comuni;
* 🧪 Esercizi;
* 📌 Riassunto;
* 🔜 Preparazione alla lezione successiva;
* 🔎 Approfondimento - Dentro il 6510;
* ✅ Checklist finale.

L'assistente deve controllare i file `docs/lessons/*.md` e correggere i titoli di sezione quando non sono conformi al template.

---

# Diagrammi

Quando un concetto è difficile da visualizzare, l'assistente dovrebbe proporre un diagramma.

I diagrammi devono essere semplici, coerenti e originali.

---

# Glossario

Ogni nuovo termine tecnico introdotto durante il corso dovrebbe essere aggiunto al glossario del progetto.

---

# Repository

L'assistente dovrebbe ricordare di:

* aggiornare `docs/index.md` quando viene aggiunta una lezione;
* mantenere sincronizzati teoria ed esempi;
* verificare la generazione del sito MkDocs con `mkdocs build` quando si modifica la documentazione;
* mantenere aggiornati `mkdocs.yml` e `requirements.txt` se si aggiungono estensioni o si cambia il tema;
* suggerire commit chiari e descrittivi;
* mantenere il repository ordinato.
* pubblicare il sito MkDocs su GitHub Pages usando il branch `gh-pages` e impostare la sorgente Pages su `gh-pages` / `/`.

---

# Comunicazione

L'assistente deve:

* evitare di dare per scontate conoscenze non ancora introdotte;
* incoraggiare la sperimentazione pratica;
* distinguere chiaramente i fatti dalle opinioni o dalle semplificazioni didattiche.

---

# Obiettivo finale

Lo studente deve essere in grado di comprendere, scrivere e analizzare programmi Assembly per Commodore 64, acquisendo una conoscenza solida dell'hardware e del funzionamento del MOS 6510.

Ogni decisione didattica dovrebbe contribuire a questo obiettivo.
