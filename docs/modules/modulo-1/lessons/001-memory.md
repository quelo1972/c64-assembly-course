[🏠 Home](/index.md)
# Lezione 001 - La memoria del Commodore 64

> **Obiettivo:** comprendere come il processore MOS 6510 vede la memoria del Commodore 64.

---

## 🎯 Obiettivi

- capire come la CPU vede la memoria del C64;
- distinguere indirizzo e contenuto;
- riconoscere la differenza tra RAM e registri hardware.

## 🧠 Introduzione

Prima di imparare una sola istruzione Assembly è fondamentale capire una cosa:

**la CPU non vede uno schermo, una tastiera o uno sprite.**

Per il processore esistono soltanto **indirizzi di memoria** e **valori**.

Tutto ciò che il Commodore 64 fa è il risultato di letture e scritture in memoria.

---

## 📘 Teoria

La memoria del C64 è una sequenza di celle, ognuna identificata da un indirizzo. Il 6510 legge e scrive byte in queste celle, e ogni byte ha un significato che dipende dall'hardware o dal programma.

## Lo spazio di indirizzamento

Il processore MOS 6510 dispone di **16 linee di indirizzo**.

Ogni linea può assumere due stati:

- 0
- 1

Con 16 bit è possibile rappresentare:

2^16 = 65.536 indirizzi

Gli indirizzi vanno da:

```
$0000
```

a

```
$FFFF
```

Questa è tutta la memoria che il processore può indirizzare in un dato momento.

---

## Un indirizzo contiene un byte

Ogni indirizzo contiene un solo byte.

Un byte è composto da **8 bit** e può contenere un valore compreso tra:

```
0
```

e

```
255
```

oppure, in esadecimale:

```
$00
```

fino a

```
$FF
```

---

## La memoria come una fila di cassette

Possiamo immaginare la memoria come una lunghissima fila di cassette postali.

```
Indirizzo     Contenuto

$0000         25
$0001         13
$0002         255
$0003         0
$0004         42
...
$FFFF
```

Il processore legge e scrive continuamente questi valori.

---

## La Zero Page

I primi 256 byte della memoria prendono il nome di **Zero Page**.

Comprendono gli indirizzi:

```
$0000
```

fino a

```
$00FF
```

Questa zona è molto importante perché il 6510 dispone di istruzioni dedicate che la rendono più veloce da utilizzare.

Studieremo questo argomento in dettaglio nelle prossime lezioni.

---

## La memoria non contiene solo RAM

Nel Commodore 64 alcuni indirizzi non rappresentano memoria RAM.

Ad esempio:

| Intervallo | Contenuto |
|------------|-----------|
| $A000-$BFFF | BASIC ROM |
| $D000-$DFFF | Registri hardware e caratteri |
| $E000-$FFFF | KERNAL ROM |

Più avanti vedremo che alcune di queste aree possono cambiare contenuto grazie al **bank switching** del 6510.

---

## Un esempio famoso: $D020

L'indirizzo:

```
$D020
```

è uno dei registri del chip video VIC-II.

Scrivendo un numero in questo indirizzo si modifica il colore del bordo dello schermo.

Ad esempio:

```
$06
```

corrisponde al colore blu.

La CPU non sa cosa sia un colore.

Sa soltanto che deve scrivere il valore **6** nell'indirizzo **$D020**.

È il chip video a interpretare quel valore come un colore.

---

## 🤖 Come ragiona il 6510

La CPU non "vede" schermo, tastiera o colori. Per lei esistono soltanto indirizzi e valori. Quando un programma scrive un byte in $D020, non è la CPU a interpretarlo come colore: è il chip video VIC-II a farlo.

## 💡 Esempio pratico

Immaginiamo di voler cambiare il bordo. Il programma non parla di “blu”: scrive un byte nell'indirizzo corretto e lascia che l'hardware interpreti quel valore.

## ⚠️ Errori comuni

- confondere un indirizzo con il contenuto della cella;
- pensare che la CPU conosca il colore direttamente;
- dimenticare che alcuni indirizzi controllano hardware e non RAM semplice.

## Concetti fondamentali

Alla fine di questa lezione dovresti aver capito che:

- la CPU lavora esclusivamente con indirizzi e valori;
- il Commodore 64 dispone di 65.536 indirizzi;
- ogni indirizzo contiene un byte;
- alcuni indirizzi controllano direttamente l'hardware.

---

## 🧪 Esercizi

1. Perché il 6510 può indirizzare esattamente 65.536 celle di memoria?
2. Che cos'è la Zero Page?
3. Perché scrivere nell'indirizzo `$D020` modifica il colore del bordo?
4. Qual è il valore massimo che può essere contenuto in un byte?

---

## 📌 Riassunto

- la memoria è una sequenza di indirizzi e contenuti;
- il 6510 lavora sempre con byte;
- alcuni indirizzi controllano hardware;
- capire la memoria è il prerequisito per ogni programma Assembly.

## 🔜 Preparazione alla lezione successiva

Nella prossima lezione studieremo il sistema binario e l'esadecimale, perché sono il linguaggio con cui il 6510 legge e scrive i numeri.

## 🔎 Approfondimento - Dentro il 6510

Nel Commodore 64 la CPU vive in un mondo di indirizzi e valori. Anche il colore del bordo è solo un valore scritto in una posizione di memoria.

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
