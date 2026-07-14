[🏠 Home](../../../index.md)
# Lezione 7 — - Sistema binario ed esadecimale

> **Obiettivo:** imparare a leggere e ragionare in binario ed esadecimale, come fa il MOS 6510.

---

## 🎯 Obiettivi

- capire perché il 6510 usa solo bit;
- riconoscere il valore dei bit in un byte;
- leggere numeri in esadecimale come $D020.

## 🧠 Introduzione

Il processore del Commodore 64 non lavora in decimale.

Non capisce:

```
10, 20, 100
```

Capisce solo:

```
0 e 1
```

Tutto il resto è una nostra convenzione.

---

## 📘 Teoria

Il processore del Commodore 64 non pensa in decimale. Per lui ogni informazione è una sequenza di bit, e noi usiamo binario ed esadecimale per rappresentarla in modo leggibile.

## 🔢 Il sistema binario

Il sistema binario usa solo due cifre:

```
0
1
```

Ogni cifra si chiama **bit**.

---

## 📦 Esempio con 4 bit

```
0000 = 0
0001 = 1
0010 = 2
0011 = 3
0100 = 4
0101 = 5
0110 = 6
0111 = 7
1000 = 8
```

---

## 📊 Il valore dei bit

Ogni posizione vale una potenza di 2:

```
bit:   8 4 2 1
       ----------
       1 0 1 1  = 11
```

Quindi:

```
1011 = 8 + 2 + 1 = 11
```

---

## 💾 8 bit = 1 byte

Un byte è composto da 8 bit:

```
00000000 = 0
11111111 = 255
```

👉 Questo è il motivo per cui un byte va da 0 a 255.

---

## ⚡ Il sistema esadecimale

Scrivere binario è scomodo.

Esempio:

```
11111111
```

Per questo usiamo l’esadecimale.

---

## 🔣 Cos’è l’esadecimale?

È un sistema in base 16:

```
0 1 2 3 4 5 6 7 8 9 A B C D E F
```

---

## 🔁 Conversione

Un byte si divide in due gruppi da 4 bit:

```
1111 1111
  F    F
```

Quindi:

```
11111111 = $FF = 255
```

---

## 📌 Tabella base

```
Binario  Hex  Dec
0000     0    0
0001     1    1
0010     2    2
0011     3    3
0100     4    4
0101     5    5
0110     6    6
0111     7    7
1000     8    8
1001     9    9
1010     A    10
1011     B    11
1100     C    12
1101     D    13
1110     E    14
1111     F    15
```

---

## 🧮 Perché l’esadecimale è usato nel C64?

Perché:

- un byte = 2 cifre hex
- è compatto
- è leggibile
- è standard nei manuali hardware

Esempio:

```
$D020
```

è molto più leggibile di:

```
1101 0000 0010 0000
```

---

## 🧠 Collegamento con il C64

Quando scriveremo:

```asm
lda #$0A
sta $D020
```

significa:

- carica il valore 10
- scrivilo nel registro del bordo

Nota: `LDA #value` carica il valore immediato nel registro `A` (accumulatore). `STA address` scrive il contenuto del registro `A` nell'indirizzo di memoria specificato. Qui usiamo questi comandi come esempio illustrativo; vedremo `LDA` e `STA` in dettaglio nelle lezioni dedicate.

---

## 🤖 Come ragiona il 6510

Il 6510 non legge “dieci” o “quindici”: legge 0 e 1. L'esadecimale è soltanto una forma più compatta per scrivere questi bit.

## 💡 Esempio pratico

Il valore $D020 può essere scritto come una sequenza di bit, ma per noi è molto più semplice leggerlo come un numero esadecimale.

```asm
; Lezione 007 - Uso di costanti esadecimali
*= $0801

BORDER = $D020

start:
   LDA #$0A
   STA BORDER

   RTS
```

## ⚠️ Errori comuni

- confondere binario e decimale;
- dimenticare che un byte è composto da 8 bit;
- leggere $0A come “zero A” invece che come 10.

## 🧪 Esercizi

1. Converti in decimale:
   - 00001111
   - 00010000

2. Converti in esadecimale:
   - 11110000
   - 10101010

3. Quanto vale:
   - $FF
   - $10
   - $A0

---

## 📌 Riassunto

- il binario è il linguaggio naturale della CPU;
- l'esadecimale è una forma più leggibile per rappresentare byte;
- conoscere queste basi rende più semplice leggere indirizzi e valori nel C64.

## 🔜 Preparazione alla lezione successiva

Nella prossima lezione parleremo di byte, word e overflow, e vedremo cosa succede quando superiamo 255.

## 🔎 Approfondimento - Dentro il 6510

L'unità di controllo del 6510 vede numeri binari in ogni cella di memoria ed esadecimale è lo strumento che ci permette di descriverli con meno errori.

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
