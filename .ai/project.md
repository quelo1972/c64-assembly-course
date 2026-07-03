# C64 Assembly Course - Project Manifest

> Documento guida del progetto.

Questo file definisce gli obiettivi, la filosofia, gli standard qualitativi e il metodo di sviluppo del corso. Ogni nuova lezione, esempio o modifica dovrà essere coerente con quanto descritto qui.

---

# Visione

Realizzare il miglior corso in lingua italiana dedicato alla programmazione Assembly per Commodore 64.

Il corso deve accompagnare uno studente senza alcuna esperienza fino alla capacità di sviluppare software reale per Commodore 64, comprendendo non solo la sintassi dell'Assembly, ma anche il funzionamento della macchina.

L'obiettivo non è insegnare a copiare esempi, ma insegnare a ragionare come il MOS 6510.

---

# Obiettivi

Alla fine del corso lo studente dovrà essere in grado di:

* comprendere l'architettura del Commodore 64;
* leggere e interpretare codice Assembly 6510;
* sviluppare programmi completi;
* utilizzare VIC-II, SID e CIA;
* comprendere mappe di memoria e registri hardware;
* utilizzare strumenti di sviluppo moderni.

---

# Filosofia didattica

Ogni concetto deve essere introdotto gradualmente.

Non verranno presentate istruzioni Assembly senza che siano stati prima spiegati i concetti necessari per comprenderle.

Ogni lezione deve rispondere a quattro domande fondamentali:

1. Che cos'è?
2. Perché esiste?
3. Come lo utilizza il 6510?
4. Come lo utilizzo in un programma reale?

---

# Standard qualitativi

Ogni esempio pubblicato deve essere:

* compilabile con 64tass;
* eseguibile in VICE;
* verificato prima della pubblicazione;
* commentato quando necessario;
* coerente con le lezioni precedenti.

Nessun esempio dovrà essere inserito solo perché "funziona".

Ogni riga dovrà avere uno scopo didattico.

---

# Struttura di una lezione

Ogni lezione seguirà questo schema:

1. Obiettivi
2. Introduzione
3. Teoria
4. Come ragiona il 6510
5. Esempio pratico
6. Errori comuni
7. Esercizi
8. Riassunto
9. Preparazione alla lezione successiva
10. Approfondimento "Dentro il 6510" (facoltativo)

---

# Esempi pratici

Ogni lezione che introduce codice avrà una cartella dedicata in `src/`.

Esempio:

src/012-lda/

con almeno:

* `main.asm`
* `README.md`

Quando utile potranno essere aggiunti altri file di supporto.

---

# Convenzioni del codice

* utilizzare sempre indentazione coerente;
* preferire etichette descrittive;
* mantenere gli esempi piccoli e focalizzati;
* introdurre una sola novità significativa per esempio.

---

# Diagrammi

Quando un concetto è difficile da visualizzare dovrà essere accompagnato da un diagramma.

I diagrammi saranno conservati in:

```
docs/images/
```

e saranno preferibilmente realizzati appositamente per il corso.

---

# Glossario

Ogni nuovo termine tecnico dovrà essere aggiunto al glossario del progetto.

Il glossario dovrà contenere definizioni semplici e coerenti.

---

# Roadmap

Il corso sarà organizzato in moduli progressivi.

Ogni modulo introdurrà solo i concetti necessari per affrontare quello successivo.

---

# Strumenti di sviluppo

Ambiente di riferimento:

* VSCodium / Visual Studio Code
* WSL
* 64tass
* VICE
* Git
* GitHub

---

# Gestione del repository

Ogni modifica significativa dovrà essere accompagnata da un commit chiaro e descrittivo.

Le lezioni e gli esempi dovranno rimanere sincronizzati.

---

# Principio fondamentale

La comprensione viene prima della velocità.

Il corso potrà essere più lungo rispetto ad altri, ma ogni concetto dovrà risultare realmente compreso.

L'obiettivo finale è formare programmatori Assembly, non semplici lettori di tutorial.
