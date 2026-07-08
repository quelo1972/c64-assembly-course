[🏠 Home](../../../index.md)

# Lezione 10 — - Registri A, X e Y

> **Obiettivo:** capire i tre registri principali della CPU 6510 e come vengono usati.

---

## 🎯 Obiettivi

- capire cosa sono i registri della CPU;
- distinguere A, X e Y;
- capire perché il 6510 usa registri diversi per compiti diversi.

## 🧠 Introduzione

Un registro è una piccola memoria interna alla CPU.

È:

- velocissima
- molto limitata
- direttamente dentro il processore

---

## 📦 I tre registri principali

Il 6510 ha 3 registri fondamentali:

```
A  = Accumulatore
X  = Registro indice X
Y  = Registro indice Y
```

---

## ⚡ Registro A (Accumulatore)

È il registro più importante.

Serve per:

- operazioni matematiche
- trasferimenti di dati
- interazione con la memoria

Immagina la CPU come un piccolo banco da lavoro. Sul banco c'è pochissimo spazio. Il registro A è il piano principale dove il 6510 appoggia il dato su cui sta lavorando. Se il dato è ancora nella RAM, la CPU non può usarlo direttamente: prima deve prenderlo e metterlo sul banco, cioè nell'Accumulatore.

Esempio:

```asm
LDA #$01
```

👉 carica il valore 1 dentro A

---

## 🧠 Il concetto chiave

Quasi tutte le operazioni passano da A.

Esempio:

```
RAM → A → RAM
```

---

## 📘 Teoria

Un registro è una piccola memoria interna alla CPU, molto più veloce della RAM. È il posto dove la CPU tiene i dati su cui sta lavorando in questo preciso istante.

## 📍 Registri X e Y

Sono registri di supporto.

Servono per:

- cicli
- indirizzamenti
- contatori
- accesso a tabelle

---

## 🔁 Esempio mentale

Immagina:

- A = mani
- X = indice
- Y = secondo indice

---

## 📦 Differenza tra A e X/Y

| Registro | Ruolo |
|----------|------|
| A        | dati principali |
| X        | contatore / indice |
| Y        | contatore / indice |

---

## 🧠 Esempio semplice (concettuale)

```asm
LDA #$05
LDX #$10
LDY #$20
```

Significa:

- A = 5
- X = 16
- Y = 32

---

## ⚡ Perché servono tre registri?

Perché la CPU può lavorare su più cose contemporaneamente:

- A → dato principale
- X → posizione
- Y → supporto

---

## 🧠 Importante

I registri NON sono memoria RAM.

Sono dentro la CPU.

Quindi:

- molto veloci
- ma pochi

---

## 💡 Concetto chiave

> I registri sono il punto in cui i dati diventano “attivi”.

---

## 🤖 Come ragiona il 6510

Il 6510 usa A come registro principale per i dati, mentre X e Y servono come supporto per contatori e indirizzamenti. Questa divisione semplifica molte operazioni comuni.

## 💡 Esempio pratico

Se il programma deve lavorare su una tabella, X o Y possono indicare la posizione corrente, mentre A contiene il dato attuale da elaborare.

## ⚠️ Errori comuni

- confondere registri con celle di memoria;
- pensare che X e Y siano identici ad A;
- dimenticare che i registri sono molto più veloci della RAM.

## 📌 Riassunto

- A è l'accumulatore principale;
- X e Y sono registri di supporto;
- i registri sono dentro la CPU e non nella RAM.

## 🔜 Preparazione alla lezione successiva

Nella prossima lezione studieremo Stack Pointer e Program Counter, per capire come la CPU organizza il flusso del programma.

## 🔎 Approfondimento - Dentro il 6510

Nel 6510 il registro A è destinato alle operazioni principali, mentre X e Y sono progettati per puntare indirizzi e contare elementi in memoria.

## 🧪 Esercizi

1. Ripeti l esempio principale variando un parametro alla volta e annota cosa cambia.
2. Verifica i registri o i flag coinvolti dopo ogni passaggio chiave.
3. Riscrivi l esempio in forma minima mantenendo lo stesso risultato.

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
