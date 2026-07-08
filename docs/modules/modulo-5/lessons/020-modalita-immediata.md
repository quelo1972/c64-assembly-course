[🏠 Home](../../../index.md)

# Lezione 20 — Indirizzamento immediato, revisited

> **Obiettivo:** capire in modo preciso cosa significa "immediato" come modalità di indirizzamento e perché è la più semplice — e la più limitata.

---

## 🎯 Obiettivi

- definire il concetto di "modalità di indirizzamento";
- capire perché l'indirizzamento immediato si chiama così;
- distinguere quando usarlo e quando non basta;
- riconoscere la sintassi `#` in `64tass`.

---

## 🧠 Introduzione

Nelle lezioni precedenti abbiamo usato istruzioni come:

```asm
LDA #$05
LDX #10
```

Il simbolo `#` è stato introdotto senza spiegarlo a fondo. Ora è il momento di capire cosa fa davvero, e perché esiste un intero capitolo sulle "modalità di indirizzamento".

---

## 📘 Teoria

### Cosa è una modalità di indirizzamento?

Il 6510, come ogni CPU, ha bisogno di sapere **dove trovare i dati** su cui operare.

Ogni istruzione Assembly può usare diverse strategie per trovare quel dato. Queste strategie si chiamano **modalità di indirizzamento**.

Il MOS 6510 ne supporta diverse. L'indirizzamento **immediato** è la più semplice:

> il valore è scritto direttamente nell'istruzione stessa.

### La sintassi `#`

In `64tass`, il simbolo `#` prima di un valore indica la modalità immediata.

```asm
LDA #$41   ; carica il valore $41 (65 decimale, 'A' ASCII) nell'accumulatore A
```

> Nota: `LDA #valore` è l'istruzione "Load Accumulator" in modalità immediata. Il processore legge il byte che segue l'opcode nel flusso del programma e lo carica nel registro A.

Il valore può essere espresso in vari formati:

| Sintassi       | Significato     | Valore decimale |
|----------------|-----------------|-----------------|
| `#$41`         | esadecimale     | 65              |
| `#65`          | decimale        | 65              |
| `#%01000001`   | binario         | 65              |
| `#'A'`         | carattere ASCII | 65              |

Tutte e quattro le forme caricano lo stesso valore nell'accumulatore.

---

## 🤖 Come ragiona il 6510

Quando il processore esegue `LDA #$41`:

1. **Fetch opcode**: legge `$A9` dalla memoria (opcode di `LDA` immediato)
2. **Fetch operando**: legge il byte successivo `$41`
3. **Execute**: scrive `$41` nel registro A

In totale: **2 byte di programma**, **2 cicli macchina**.

Questo lo rende il modo più veloce e compatto per caricare un valore fisso. Il limite è che il valore deve essere noto al momento dell'assemblaggio — non può venire dalla memoria a runtime.

---

## 💡 Esempio pratico

```asm
; Lezione 011 — Indirizzamento immediato
; Cambia il colore del bordo e dello sfondo del C64
*= $0801

; Nota: LDA #valore carica il byte nel registro A (accumulatore).
; Nota: STA indirizzo scrive il contenuto di A alla locazione di memoria indicata.

LDA #$05        ; carica il valore $05 (verde) in A
STA $D020       ; scrivi il colore del bordo  (registro VIC-II $D020)

LDA #$00        ; carica $00 (nero) in A
STA $D021       ; scrivi il colore di sfondo  (registro VIC-II $D021)

RTS             ; ritorna — fine del programma
```

> Nota: `$D020` e `$D021` sono registri hardware del chip grafico VIC-II. Scriverci un valore cambia rispettivamente il colore del bordo e dello sfondo dello schermo.

Compila con:

```bash
64tass --cbm-prg -o bin/011.prg src/modulo-5/011.asm
```

---

## ⚠️ Errori comuni

- **Dimenticare il `#`**: `LDA $41` è valido, ma ha un significato diverso — legge il contenuto della cella di memoria all'indirizzo `$41` (Zero Page). È un errore silenzioso.
- **Valori fuori range**: un byte può contenere solo valori `$00`–`$FF` (0–255). Scrivere `LDA #$100` genera un errore di assemblaggio.
- **Confondere dato e indirizzo**: `LDA #$0400` non carica un indirizzo a 16 bit — `A` è un registro a 8 bit e può contenere solo un byte.

---

## 🧪 Esercizi

1. Carica il colore `$06` (blu) nel bordo e `$0E` (azzurro) nello sfondo.
2. Scrivi la lettera `'C'` (ASCII `$43`) nella prima cella dello schermo (`$0400`). Usa `LDA #'C'` e `STA $0400`.

---

## 📌 Riassunto

| Concetto                    | Spiegazione                                          |
|-----------------------------|------------------------------------------------------|
| Modalità di indirizzamento  | Strategia usata per trovare il dato dell'istruzione  |
| Indirizzamento immediato    | Il dato è scritto direttamente nell'istruzione       |
| Sintassi `#`                | Indica modalità immediata in `64tass`                |
| Dimensione / cicli          | 2 byte, 2 cicli                                      |
| Limite                      | Il valore deve essere costante (noto al compile time)|

---

## 🔜 Preparazione alla lezione successiva

Nella lezione 012 vedremo l'**indirizzamento Zero Page**: invece di includere il dato direttamente nell'istruzione, specifichiamo un indirizzo nei primi 256 byte della memoria (`$00`–`$FF`). Questo permette di leggere e scrivere variabili con istruzioni compatte (1 byte di indirizzo invece di 2).

---

## 🔎 Approfondimento — Dentro il 6510

L'opcode per `LDA` in modalità immediata è `$A9`. Il programma `LDA #$05` occupa solo 2 byte:

```
Indirizzo   Valore    Significato
$0801       $A9       opcode LDA immediato
$0802       $05       operando
```

Lo stesso mnemonico `LDA` ha opcode diversi a seconda della modalità:

| Modalità   | Opcode | Byte totali | Cicli |
|------------|--------|-------------|-------|
| Immediato  | `$A9`  | 2           | 2     |
| Zero Page  | `$A5`  | 2           | 3     |
| Assoluto   | `$AD`  | 3           | 4     |

---

## ✅ Checklist finale

- [ ] l'esempio compila con `64tass`
- [ ] ogni istruzione nuova è spiegata prima dell'uso
- [ ] la differenza tra `LDA #$41` e `LDA $41` è chiara
- [ ] il contenuto è progressivo rispetto alle lezioni precedenti
