[🏠 Home](../../../index.md)

# Lezione 8 — - Byte, Word e limiti della memoria

> **Obiettivo:** capire cosa può contenere un byte, cosa succede quando si superano i limiti e perché l’overflow è fondamentale nel C64.

---

## 🎯 Obiettivi

- capire il limite di un byte;
- distinguere byte e word;
- riconoscere il significato dell'overflow.

## 🧠 Introduzione

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

## 📘 Teoria

Nel 6510 i dati hanno dimensioni fisse. Un byte può contenere solo 8 bit, quindi ha un limite preciso. Quando si supera quel limite, la CPU riparte dall'inizio del range.

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

## 🤖 Come ragiona il 6510

Il 6510 non “capisce” il concetto di infinito. Sa solo che il registro disponibile ha un numero massimo di valori possibili, quindi l'overflow è un comportamento naturale del hardware.

## 💡 Esempio pratico

Se un contatore raggiunge 255, il passo successivo lo riporta a 0. Questo è esattamente il tipo di comportamento che si vede in molti programmi semplici del C64.

```asm
; Lezione 008 - Overflow di un contatore a 8 bit
*= $0801

COUNTER = $C000

start:
   LDA #$FF
   STA COUNTER

   INC COUNTER     ; $FF -> $00 (wrap a 8 bit)

loop:
   JMP loop
```

## ⚠️ Errori comuni

- pensare che l'overflow sia un errore di programma;
- dimenticare che un byte va da 0 a 255;
- confondere byte e word.

## 🧪 Esercizi

1. Quanto vale:
   - 11111111 + 1 (in binario)?
2. Perché 255 è il massimo di un byte?
3. Quanti valori può contenere una word da 16 bit?
4. Cosa succede dopo 65535 + 1 in 16 bit?

---

## 📌 Riassunto

- un byte contiene 8 bit e va da 0 a 255;
- una word contiene 16 bit;
- l'overflow è il comportamento naturale quando si supera il limite dei bit disponibili.

## 🔜 Preparazione alla lezione successiva

Nella prossima lezione studieremo la CPU MOS 6510 e capiremo come i registri e le istruzioni lavorano insieme per eseguire un programma.

## 🔎 Approfondimento - Dentro il 6510

Per il 6510 i bit sono la rappresentazione fisica dei dati. Capire l'overflow significa comprendere i limiti di questo livello hardware.

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
