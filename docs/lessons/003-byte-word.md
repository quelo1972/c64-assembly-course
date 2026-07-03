[🏠 Home](../index.md)

# Lezione 003 - Byte, Word e limiti della memoria

> **Obiettivo:** capire cosa può contenere un byte, cosa succede quando si superano i limiti e perché l’overflow è fondamentale nel C64.

---

## 📦 Cos’è un byte?

Un **byte** è un’unità di memoria composta da:

```
8 bit
```

Un bit può essere:

```
0 oppure 1
```

Quindi un byte può rappresentare:

```
00000000 → 0
11111111 → 255
```

👉 In totale: **256 valori possibili**

---

## ⚠️ Il limite del byte

Un byte NON può contenere valori superiori a 255.

Esempio:

```
255 + 1 = ?
```

In un sistema a 8 bit:

```
11111111 + 1 = 00000000
```

👉 Il risultato “riparte da zero”

Questo fenomeno si chiama:

> **overflow**

---

## 🔁 Perché succede?

Perché la CPU lavora con registri a dimensione fissa.

Se hai solo 8 bit:

- puoi contare solo da 0 a 255
- oltre… torni all’inizio

---

## 🧠 Esempio pratico mentale

Immagina un contachilometri vecchio:

```
99999 → 00000
```

La CPU funziona allo stesso modo.

---

## 📏 Cos’è una word?

Nel contesto del 6510:

- 1 byte = 8 bit
- 2 byte = 16 bit

Una coppia di byte si chiama spesso:

> **word (16 bit)**

Esempio:

```
$1234
```

è composto da:

```
$12  $34
```

---

## 🧭 Perché 16 bit sono importanti?

Con 16 bit possiamo rappresentare:

```
2^16 = 65536 valori
```

👉 cioè tutto lo spazio di memoria del C64

---

## 💥 Overflow nella pratica del C64

Gli overflow non sono errori nel C64.

Sono **normali e usati continuamente**.

Esempio:

- contatori che ripartono da 0
- animazioni
- timer hardware
- gestione sprite

---

## 🧠 Concetto chiave

La CPU NON “si confonde”.

Fa solo quello che può fare con i bit disponibili.

---

## 🧪 Esercizi

1. Quanto vale:
   - 11111111 + 1 (in binario)?
2. Perché 255 è il massimo di un byte?
3. Quanti valori può contenere una word da 16 bit?
4. Cosa succede dopo 65535 + 1 in 16 bit?

---

## 🔜 Prossima lezione

Studieremo:

> **La CPU MOS 6510**

e inizieremo a capire:

- registri
- istruzioni
- come la CPU esegue realmente un programma
