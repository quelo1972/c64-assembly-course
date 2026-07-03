[🏠 Home](../index.md)

# Lezione 006 - Dal sorgente all'esecuzione

> **Obiettivo:** capire cosa succede quando un file Assembly diventa un programma eseguibile sul Commodore 64.

---

# Introduzione

Finora abbiamo studiato:

- la memoria
- il sistema binario
- la CPU
- i registri

Ma c'è una domanda fondamentale:

> Come fa un file `.asm` a diventare un programma che il Commodore 64 può eseguire?

---

# Il file sorgente

Quando scriviamo:

```asm
* = $1000

    rts
```

stiamo creando un semplice file di testo.

Per il computer questo file non è ancora un programma.

Contiene solo caratteri ASCII.

---

# Il ruolo dell'assembler

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

# Il file PRG

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

# Dal PRG alla memoria

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

# Esercizio

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

# Riassunto

In questa lezione hai imparato che:

- un file `.asm` è semplice testo;
- 64tass lo traduce in codice macchina;
- il file `.prg` contiene anche l'indirizzo di caricamento;
- il 6510 esegue solo i byte presenti in memoria.

---

# Prossima lezione

Finalmente inizieremo a programmare.

Studieremo la nostra prima vera istruzione:

> **LDA - Load Accumulator**

e vedremo cosa succede dentro la CPU quando un valore viene caricato nel registro A.
