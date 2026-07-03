[🏠 Home](../index.md)
# Lezione 002 - Sistema binario ed esadecimale

> **Obiettivo:** imparare a leggere e ragionare in binario ed esadecimale, come fa il MOS 6510.

---

## 🧠 Perché ci serve?

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

# 🔢 Il sistema binario

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

# ⚡ Il sistema esadecimale

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

# 🧮 Perché l’esadecimale è usato nel C64?

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

# 🧠 Collegamento con il C64

Quando scriveremo:

```asm
lda #$0A
sta $D020
```

significa:

- carica il valore 10
- scrivilo nel registro del bordo

---

# 🧪 Esercizi

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

# 🔜 Prossima lezione

Nella prossima lezione parleremo di:

> **Byte, signed/unsigned e overflow**

e vedremo cosa succede quando superiamo 255.
