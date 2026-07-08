[🏠 Home](../../../index.md)

# Lezione 017 — Indirizzamento indiretto

> **Obiettivo:** capire come usare l'indirizzamento indiretto per accedere a memoria usando un puntatore memorizzato in Zero Page.

---

## 🎯 Obiettivi

- comprendere l'indirizzamento indiretto (JMP indiretto e LDA indiretto);
- usare Zero Page come contenitore di indirizzi puntatori;
- applicare l'indirizzamento indiretto per traversare strutture dati dinamiche;
- confrontare con altre modalità di indirizzamento.

---

## 🧠 Introduzione

Finora abbiamo usato indirizzi concreti: `LDA $D020`, `LDA $0400,X`.

Ma spesso vogliamo **indirizzare un indirizzo contenuto in memoria**.

Esempi:
- Un puntatore a una stringa
- Un indirizzo di una tabella dati
- Una routine calcolata dinamicamente

**Indirizzamento indiretto** risolve questo: `LDA (addr)` legge l'indirizzo da `addr` e da lì carica il dato.

---

## 📘 Teoria

### Sintassi e operazione

```asm
LDA ($40)      ; legge l'indirizzo da $40 e $41, poi legge il dato da quell'indirizzo
```

1. Leggi il byte basso da `$40`
2. Leggi il byte alto da `$41`
3. Riconstruisci l'indirizzo (16 bit)
4. Leggi il dato da quell'indirizzo

Se `$40` contiene `$00` e `$41` contiene `$04`, l'indirizzo è `$0400`.

### Wraparound in Zero Page

Se usi `LDA ($FF)`, il 6510 legge:
- Byte basso da `$FF`
- Byte alto da `$00` (wrapping in Zero Page!)

Non da `$100`.

### Opcode e performance

| Modalità           | Opcode | Bytes | Cicli |
|-------------------|--------|-------|-------|
| Indiretto (JMP)   | `$6C`  | 3     | 5     |
| Indiretto (LDA)   | `$B2`  | 2     | 5*    |

*Con 64tass e C64, il 6510 usa JMP `($xxxx)` indiretto, ma LDA usa diverse modalità.

### Uso comune

L'indirizzamento indiretto è utile per:
- **Puntatori a funzioni**: JSR ($40) salta a una subroutine il cui indirizzo è in `$40`/$41`
- **Traversal di liste**: memorizza l'indirizzo della prossima cella, salta a quella
- **Tabelle dinamiche**: carica l'indirizzo della tabella in Zero Page, traversa

---

## 🤖 Come ragiona il 6510

`LDA ($40)` con `$40` = `$00`, `$41` = `$04`:

1. **Fetch opcode**: legge `$B2` (LDA indiretto) — nota: questo dipende dal modo di addressing
2. **Fetch puntatore**: legge `$40` (indirizzo del puntatore)
3. **Read indirizzo basso**: legge il byte basso da `$40` → `$00`
4. **Read indirizzo alto**: legge il byte alto da `$41` → `$04`
5. **Reconstruct address**: `$0400`
6. **Read memory**: legge il contenuto di `$0400`
7. **Execute**: scrive in A

In totale: **2–3 byte**, **5+ cicli**.

---

## 💡 Esempio pratico

```asm
; Lezione 017 — Indirizzamento indiretto
; Usa puntatori in Zero Page per accedere a dati
*= $0801

; Nota: LDA (indirizzo_puntatore) legge da un indirizzo memorizzato in ZP

; Inizializza il puntatore in $40/$41
; Vogliamo puntare a $D020 (VIC-II)
LDA #$20       ; byte basso di $D020
STA $40
LDA #$D0       ; byte alto di $D020
STA $41

; Ora usa il puntatore
LDA ($40)      ; legge il valore attuale di $D020
INC            ; incrementa
STA ($40)      ; scrive il nuovo valore in $D020

RTS
```

Compila:

```bash
64tass --cbm-prg -o bin/017.prg src/modulo-5/017.asm
```

---

## ⚠️ Errori comuni

- **Wraparound Zero Page**: `($FF)` legge da `$FF` e `$00`, non da `$FF` e `$100`.
- **Puntatori non inizializzati**: se il puntatore in Zero Page non è settato, leggi dati casuali.
- **Endianness**: ricorda che il byte basso è in `addr`, byte alto in `addr + 1`.

---

## 🧪 Esercizi

1. Crea un puntatore a `$0400`, leggi il primo byte, incrementalo e scrivilo back.
2. Usa due puntatori per copiare dati da una locazione a un'altra.
3. Crea un array di puntatori e traversa dinamicamente.

---

## 📌 Riassunto

| Concetto               | Spiegazione                                      |
|------------------------|--------------------------------------------------|
| Indirizzamento indiretto | `(indirizzo_puntatore)` legge da un indirizzo    |
| Puntatore              | Indirizzo memorizzato in ZP (2 byte)             |
| Opcode                 | Dipende dall'istruzione (JMP `$6C`, LDA `$B2`)  |
| Cicli                  | 5+ (dipende da boundary crossing)                |
| Wraparound             | In Zero Page, `($FF)` wraps a `$00`             |

---

## 🔜 Preparazione alla lezione successiva

Nella lezione 018 vedremo l'**indirizzamento indiretto indicizzato**: combina puntatori con indexing per accedere a array di strutture.

---

## 🔎 Approfondimento — Dentro il 6510

L'indirizzamento indiretto è usato anche per:

```asm
JSR ($40)      ; salta a una subroutine il cui indirizzo è in $40/$41
JMP ($40)      ; salta incondizionatamente a $40/$41
```

Nota: JMP ha un bug storico nel 6502/6510 con page boundary crossing, ma è stato corretto nei processori successivi.

---

## ✅ Checklist finale

- [ ] l'esempio compila con `64tass`
- [ ] il puntatore viene inizializzato correttamente
- [ ] il valore è letto e scritto attraverso il puntatore
- [ ] il contenuto è progressivo rispetto alle lezioni precedenti
