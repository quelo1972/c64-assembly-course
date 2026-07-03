[🏠 Home](../index.md)

# Lezione 005 - Registri A, X e Y

> **Obiettivo:** capire i tre registri principali della CPU 6510 e come vengono usati.

---

# 🧠 Cos’è un registro?

Un registro è una piccola memoria interna alla CPU.

È:

- velocissima
- molto limitata
- direttamente dentro il processore

---

# 📦 I tre registri principali

Il 6510 ha 3 registri fondamentali:

```
A  = Accumulatore
X  = Registro indice X
Y  = Registro indice Y
```

---

# ⚡ Registro A (Accumulatore)

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

# 🧠 Il concetto chiave

Quasi tutte le operazioni passano da A.

Esempio:

```
RAM → A → RAM
```

---

# 📍 Registri X e Y

Sono registri di supporto.

Servono per:

- cicli
- indirizzamenti
- contatori
- accesso a tabelle

---

# 🔁 Esempio mentale

Immagina:

- A = mani
- X = indice
- Y = secondo indice

---

# 📦 Differenza tra A e X/Y

| Registro | Ruolo |
|----------|------|
| A        | dati principali |
| X        | contatore / indice |
| Y        | contatore / indice |

---

# 🧠 Esempio semplice (concettuale)

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

# ⚡ Perché servono tre registri?

Perché la CPU può lavorare su più cose contemporaneamente:

- A → dato principale
- X → posizione
- Y → supporto

---

# 🧠 Importante

I registri NON sono memoria RAM.

Sono dentro la CPU.

Quindi:

- molto veloci
- ma pochi

---

# 💡 Concetto chiave

> I registri sono il punto in cui i dati diventano “attivi”.

---

# 🔜 Prossima lezione

Studieremo:

> Stack Pointer e Program Counter

e inizieremo a capire come la CPU “ricorda” le cose mentre esegue il programma.
