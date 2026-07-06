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

Ogni lezione dovrebbe contenere:

* Obiettivi
* Introduzione
* Teoria
* Come ragiona il 6510
* Esempio pratico
* Errori comuni
* Esercizi
* Riassunto
* Preparazione alla lezione successiva

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
* non sono stati introdotti file temporanei nel repository.

---

# Principio fondamentale

Mai sacrificare la comprensione per la velocità.

Ogni esempio e ogni spiegazione devono essere verificati e mantenuti il più semplici possibile.
