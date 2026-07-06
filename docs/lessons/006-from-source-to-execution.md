[🏠 Home](../index.md)

# Lezione 006 - Dal sorgente all'esecuzione

> **Obiettivo:** capire cosa succede quando un file Assembly diventa un programma eseguibile sul Commodore 64.

---

## 🎯 Obiettivi

- capire il percorso da un file `.asm` a un programma `.prg`;
- distinguere sorgente, assembler e memoria del C64;
- riconoscere il ruolo di 64tass e VICE.

## 🧠 Introduzione

Finora abbiamo studiato:

- la memoria
- il sistema binario
- la CPU
- i registri

Ma c'è una domanda fondamentale:

> Come fa un file `.asm` a diventare un programma che il Commodore 64 può eseguire?

---

## 📘 Teoria

Un file Assembly è un testo che descrive istruzioni per la CPU. Per diventare eseguibile, quel testo deve essere tradotto in codice macchina e caricato nella memoria giusta.

## Il file sorgente

Quando scriviamo:

```asm
* = $1000

    rts
```

stiamo creando un semplice file di testo.

Per il computer questo file non è ancora un programma.

Contiene solo caratteri ASCII.

---

## Il ruolo dell'assembler

L'assembler (nel nostro caso **64tass**) legge il file sorgente e traduce ogni istruzione nel corrispondente codice macchina.

Ad esempio:

```
RTS
```

diventa:

```
60
```

dove `$60` è l'opcode dell'istruzione RTS.

---

## Il file PRG

L'output dell'assembler è un file con estensione:

```
.prg
```

Un file PRG del Commodore 64 inizia con due byte speciali:

```
00 10
```

Questi rappresentano l'indirizzo di caricamento `$1000` (little-endian).

Subito dopo troviamo il codice macchina.

Per il nostro primo esempio:

```
00 10 60
```

---

## Dal PRG alla memoria

Quando VICE carica il file:

```
hello.prg
```

succede questo:

1. legge i primi due byte (`00 10`);
2. capisce che il programma va caricato da `$1000`;
3. copia il resto del file in memoria;
4. il programma è pronto per essere eseguito.

---

Nota rapida: `RTS` (ReTurn from Subroutine) è l'istruzione che termina una subroutine tornando all'indirizzo chiamante. In semplici esempi `RTS` appare come istruzione finale per terminare l'esecuzione.


# Come ragiona il 6510

La CPU non sa cosa sia un file.

Quando il programma parte, vede solo:

```
Memoria

$1000 → 60
```

Legge `$60` e sa che significa:

```
RTS
```

Per la CPU non esistono Assembly, PRG o file.

Esiste solo memoria.

---

# Dietro le quinte

Il percorso completo è:

```
main.asm
      │
      ▼
64tass
      │
      ▼
hello.prg
      │
      ▼
VICE
      │
      ▼
RAM del Commodore 64
      │
      ▼
MOS 6510
```

---

## 🤖 Come ragiona il 6510

La CPU non vede file, cartelle o nomi. Quando il programma viene caricato, vede solo byte in memoria e segue l'indirizzo di partenza del PRG.

## 💡 Esempio pratico

Se il sorgente contiene `* = $1000`, l'assembler produce un PRG che viene caricato a partire da quell'indirizzo.

## ⚠️ Errori comuni

- confondere il file sorgente con il file eseguibile;
- dimenticare che il PRG contiene anche l'indirizzo di caricamento;
- pensare che la CPU esegua direttamente il file `.asm`.

## 🧪 Esercizi

Compila il programma:

```asm
* = $1000

    rts
```

e osserva:

- viene creato `hello.prg`;
- il file è più grande di un solo byte;
- i primi due byte indicano l'indirizzo di caricamento.

---

## 📌 Riassunto

In questa lezione hai imparato che:

- un file `.asm` è semplice testo;
- 64tass lo traduce in codice macchina;
- il file `.prg` contiene anche l'indirizzo di caricamento;
- il 6510 esegue solo i byte presenti in memoria.

## 🔜 Preparazione alla lezione successiva

Finalmente inizieremo a programmare. Studieremo la nostra prima vera istruzione, `LDA`, e vedremo cosa succede dentro la CPU quando un valore viene caricato nel registro A.

Nota: `LDA #value` carica un valore immediato nel registro `A` (accumulatore). Questa breve nota introduce il mnemonico che sarà spiegato in dettaglio nella lezione dedicata.

## 🔎 Approfondimento - Dentro il 6510

Il processo di assemblaggio non fa altro che tradurre testo in byte, che poi il 6510 legge come istruzioni numeriche in memoria.

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
