[🏠 Home](../../../index.md)

# Lezione 23 — Indirizzamento indicizzato

> **Obiettivo:** capire come usare i registri X e Y per indicizzare un indirizzo base e accedere ad array e tabelle in modo elegante e efficiente.

---

## 🎯 Obiettivi

- comprendere l'indirizzamento indicizzato con X e Y;
- usare X/Y per scansionare tabelle e stringhe;
- confrontare cicli di Zero Page indicizzato vs assoluto indicizzato;
- implementare cicli su array.

---

## 🧠 Introduzione

Spesso vogliamo accedere a sequenze di byte: array, tabelle, stringhe.

Potremmo scrivere:

```asm
LDA $0400      ; carica byte 0
LDA $0401      ; carica byte 1
LDA $0402      ; carica byte 2
```

Ma è noioso e ripetitivo. La soluzione: **indirizzamento indicizzato**.

Carichiamo un indirizzo base in X (o Y) e l'istruzione legge da `indirizzo + X`.

---

## 📘 Teoria

### Indirizzamento indicizzato con X

```asm
LDA $0400,X    ; legge da $0400 + valore di X
```

Se `X = $00`, legge `$0400`.
Se `X = $05`, legge `$0405`.
Se `X = $10`, legge `$0410`.

### Sintassi

Due varianti:

| Forma | Indirizzo max | Opcode | Bytes | Cicli | Uso                    |
|-------|---------------|--------|-------|-------|------------------------|
| `$40,X` (ZP) | `$FF` | `$B5` | 2 | 4 | Piccoli array in ZP    |
| `$0400,X` (assoluto) | `$FFFF` | `$BD` | 3 | 4* | Array in qualsiasi loc |

*+ 1 ciclo se attraversa boundary di pagina.

### Overflow in Zero Page

Se `X = $FF` e usi `$FF,X`, leggi da `$FE` (wrapping inside ZP).

```asm
LDX #$05
LDA $FB,X      ; legge da $FB + $05 = $100 (wrap a $00 in ZP)
```

### Registri X e Y

Entrambi possono fare indexing, con lievi differenze:

| Operazione | X | Y |
|------------|---|---|
| `LDA n,X` | ✓ | ✗ |
| `LDX n,Y` | ✗ | ✓ |
| `LDA (n,X)` | ✓ | ✗ |
| `LDA (n),Y` | ✗ | ✓ |

Per questa lezione: focus su `n,X` e `n,Y`.

---

## 🤖 Come ragiona il 6510

`LDA $0400,X` con `X = $03`:

1. **Fetch opcode**: legge `$BD` (LDA assoluto, X)
2. **Fetch byte basso**: legge `$00`
3. **Fetch byte alto**: legge `$04`
4. **Calculate address**: `$0400 + X` = `$0400 + $03` = `$0403`
5. **Read memory**: legge il contenuto di `$0403`
6. **Execute**: scrive il valore in A

In totale: **3 byte**, **4 cicli** (+ 1 se boundary).

---

## 💡 Esempio pratico

```asm
; Lezione 014 — Indirizzamento indicizzato
; Leggi una stringa da screen RAM e copia nella screen RAM sottostante
*= $0801

; Nota: `LDA indirizzo,X` legge da (indirizzo + X).
; Nota: `STA indirizzo,X` scrive A in (indirizzo + X).

; Inizializza X come contatore
LDX #$00       ; X = 0 (primo byte)

; Loop: leggi 10 byte da $0400, scrivili in $0500
loop:
  LDA $0400,X  ; leggi byte da schermo + offset X
  STA $0500,X  ; scrivi in seconda riga + offset X
  INX           ; incrementa X
  CPX #$0A      ; X == 10?
  BNE loop       ; se no, ripeti

RTS
```

Compila:

```bash
64tass --cbm-prg -o bin/014.prg src/modulo-5/014.asm
```

---

## ⚠️ Errori comuni

- **Dimenticare di inizializzare X/Y**: se non carichi il valore, leggerai da indirizzi casuali.
- **Overflow in Zero Page non inteso**: `$FF,X` con `X=$01` legge da `$00`, non `$100`.
- **Confondere modalità**: `LDA $0400,X` è assoluto; `LDA $40,X` è Zero Page.
- **Boundary crossing**: l'indirizzamento assoluto indicizzato costa 1 ciclo extra se `indirizzo + X` attraversa un boundary di pagina (es. `$03FF + $01`).

---

## 🧪 Esercizi

1. Scrivi un ciclo che azzera 16 byte consecutivi a partire da `$0400`.
2. Copia 8 byte da `$D800` (Color RAM) a `$0400` (Screen RAM).
3. Leggi una tabella di colori (8 byte) e applicali in sequenza ai registri VIC-II (avanzato).

---

## 📌 Riassunto

| Concetto                  | Spiegazione                                |
|---------------------------|--------------------------------------------|
| Indirizzamento indicizzato | `indirizzo,X` o `indirizzo,Y`              |
| X / Y indexing            | Aggiunge il valore di X o Y all'indirizzo  |
| Modalità ZP indicizzato   | `$40,X` (2 byte, 4 cicli)                  |
| Modalità assoluta indicizzata | `$0400,X` (3 byte, 4 cicli + boundary)    |
| Wraparound                | In ZP, `$FF,X` con X=$01 legge da `$00`   |

---

## 🔜 Preparazione alla lezione successiva

Nella lezione 015 vedremo i **salti condizionati**: come controllare il flusso di esecuzione in base ai flag del processore. Essenziale per loop e decisioni.

---

## 🔎 Approfondimento — Dentro il 6510

Opcode per modalità indicizzate:

| Istruzione | ZP,X | Assoluto,X | Cicli ZP | Cicli Assoluto |
|------------|------|-----------|---------|--------|
| LDA        | `$B5` | `$BD`    | 4       | 4*     |
| STA        | `$95` | `$9D`    | 4       | 5*     |
| INX        | N/A  | N/A      | 2       | 2      |

Boundary crossing aggiunge 1 ciclo a letture assolute indicizzate.

---

## ✅ Checklist finale

- [ ] l'esempio compila con `64tass`
- [ ] il ciclo con X funziona e legge i byte giusti
- [ ] la differenza tra `$40,X` e `$0400,X` è chiara
- [ ] il contenuto è progressivo rispetto alle lezioni 011–013
