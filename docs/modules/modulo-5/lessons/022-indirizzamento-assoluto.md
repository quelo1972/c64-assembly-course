[🏠 Home](../../../index.md)

# Lezione 22 — Indirizzamento assoluto

> **Obiettivo:** capire come accedere a qualsiasi indirizzo di memoria (0–65535) con l'indirizzamento assoluto, e quando usarlo per registri hardware come VIC-II e SID.

---

## 🎯 Obiettivi

- comprendere la differenza tra indirizzi a 8 bit (Zero Page) e 16 bit (assoluto);
- usare l'indirizzamento assoluto per accedere a registri hardware;
- confrontare size e cicli: Zero Page vs Assoluto;
- scegliere la modalità giusta in base all'indirizzo.

---

## 🧠 Introduzione

La Zero Page è veloce e compatta, ma raggiunge solo i primi 256 byte di memoria (`$0000`–`$00FF`).

I registri hardware del C64 (VIC-II, SID, CIA) sono però oltre la Zero Page:
- VIC-II: `$D000`–`$D0FF`
- SID: `$D400`–`$D7FF`
- CIA: `$DC00`–`$DD00`

Per accedervi, usiamo l'**indirizzamento assoluto**: un indirizzo a **16 bit** che raggiunge qualsiasi cella.

---

## 📘 Teoria

### Indirizzi a 16 bit

Nella modalità assoluta, l'indirizzo occupa **2 byte** (16 bit):

```asm
LDA $D020      ; Zero Page (1 byte indirizzo) — NO, $D0 > $FF
LDA $D020      ; Assoluto (2 byte indirizzo) — indirizzo completo $D020
```

Quando `64tass` vede un indirizzo > `$FF`, lo assembla automaticamente in modalità assoluta.

### Sintassi

```asm
LDA $D020      ; legge il registro colore bordo VIC-II
STA $D020      ; scrive nel registro colore bordo
```

L'indirizzo è a 16 bit little-endian in memoria:

```
Indirizzo in memoria   Byte basso   Byte alto
$0801                  $20          $D0
```

### Comparazione modalità

| Modalità   | Opcode | Bytes | Cicli | Indirizzo max |
|------------|--------|-------|-------|---------------|
| Zero Page  | `$A5`  | 2     | 3     | `$00FF`       |
| Assoluto   | `$AD`  | 3     | 4     | `$FFFF`       |

L'assoluto costa 1 byte in più e 1 ciclo, ma raggiunge ovunque.

---

## 🤖 Come ragiona il 6510

`LDA $D020`:

1. **Fetch opcode**: legge `$AD` (opcode LDA assoluto)
2. **Fetch byte basso**: legge `$20` (parte bassa indirizzo)
3. **Fetch byte alto**: legge `$D0` (parte alta indirizzo)
4. **Read memory**: legge il contenuto di `$D020`
5. **Execute**: scrive il valore in A

In totale: **3 byte**, **4 cicli**.

L'indirizzo viene ricostruito come `$D0` (alto) + `$20` (basso) = `$D020`.

---

## 💡 Esempio pratico

```asm
; Lezione 013 — Indirizzamento assoluto
; Controlla registri VIC-II e SID
*= $0801

; Nota: LDA indirizzo (assoluto) legge il byte da quell'indirizzo a 16 bit.
; Nota: STA indirizzo (assoluto) scrive A in quell'indirizzo a 16 bit.

; Cambia colore bordo (VIC-II $D020)
LDA #$0B           ; carica il colore marrone
STA $D020          ; scrivi nel registro colore bordo (assoluto)

; Leggi il registro SID di controllo (SID $D404)
LDA $D404          ; leggi il registro SID Control Voice 1
STA $D020          ; rifletti il valore nel bordo (per debug)

RTS
```

Compila:

```bash
64tass --cbm-prg -o bin/013.prg src/modulo-5/013.asm
```

---

## ⚠️ Errori comuni

- **Confondere assoluto con Zero Page**: `$D020` non è ZP (il byte alto `$D0` > `$FF`). `64tass` lo assembla come assoluto automaticamente.
- **Dimenticare il byte basso dell'indirizzo**: `$D020` è indivisibile. Non puoi usare `$D0` — è un indirizzo incompleto.
- **Assumere che assoluto sia lento**: è solo 1 ciclo in più della ZP, spesso è una scelta ragionevole.

---

## 🧪 Esercizi

1. Leggi il colore bordo (`$D020`), incrementalo di 1 con `INC`, e riscrivilo.
2. Leggi il colore sfondo (`$D021`) e scrivilo nel bordo.
3. Usa un ciclo per azzerare 10 byte consecutivi a partire da `$D020`.

---

## 📌 Riassunto

| Concetto            | Spiegazione                                 |
|---------------------|---------------------------------------------|
| Indirizzamento assoluto | Usa indirizzo a 16 bit per raggiungere qualsiasi cella |
| Opcode              | `$AD` per LDA assoluto                      |
| Bytes               | 3 (opcode + byte basso + byte alto)         |
| Cicli               | 4 (1 in più della Zero Page)                |
| Uso tipico          | Registri hardware oltre `$00FF`             |
| Endianness          | Little-endian (byte basso prima, alto dopo) |

---

## 🔜 Preparazione alla lezione successiva

Nella lezione 014 vedremo l'**indirizzamento indicizzato**: combina un indirizzo base con un indice nei registri X/Y per accedere a tabelle e array. Utile per cicli su memoria.

---

## 🔎 Approfondimento — Dentro il 6510

La mappa memoria del C64 usa indirizzi assoluti:

```
$0000–$00FF   Zero Page
$0100–$01FF   Stack
$0200–$3FFF   RAM libera (Basic RAM)
$4000–$7FFF   Cartuccia ROM (normalmente libera)
$8000–$9FFF   ROM BASIC (banked)
$A000–$BFFF   Cartuccia ROM
$C000–$CFFF   ROM KERNAL (banked)
$D000–$D0FF   VIC-II (chip grafico)
$D100–$D3FF   SID (chip audio)
$D400–$D7FF   SID mirror
$D800–$D8FF   Color RAM
$DC00–$DDFF   CIA 1 e 2 (I/O, timer)
$E000–$FFFF   ROM KERNAL
```

Ogni indirizzo è a 16 bit.

---

## 🔎 Approfondimento - Dentro il 6510

Con le modalita di indirizzamento, la stabilita si ottiene scegliendo sempre il modo piu adatto al dato e al costo in cicli. Distinguere con precisione immediate, zero page e assoluto riduce errori logici e regressioni.

## ✅ Checklist finale

- [ ] l'esempio compila con `64tass`
- [ ] la differenza tra ZP (`$40`) e assoluto (`$D020`) è chiara
- [ ] la struttura little-endian dell'indirizzo è compresa
- [ ] il contenuto è progressivo rispetto alle lezioni 011–012
