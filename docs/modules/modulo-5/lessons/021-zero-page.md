[🏠 Home](../../../index.md)

# Lezione 21 — Indirizzamento Zero Page

> **Obiettivo:** capire cos'è la Zero Page, perché è speciale sul 6510 è come usare le istruzioni in modalità Zero Page per accedere a variabili in modo efficiente.

---

## 🎯 Obiettivi

- capire cosa sono i primi 256 byte della memoria e perché si chiamano "Zero Page";
- usare l'indirizzamento Zero Page per leggere e scrivere variabili;
- confrontare dimensione e cicli di Zero Page vs indirizzamento assoluto;
- saper scegliere quando usare la Zero Page.

---

## 🧠 Introduzione

Nella lezione precedente abbiamo visto che `LDA #$05` carica il valore `$05` direttamente dall'istruzione.

Ma cosa succede se il valore che vogliamo usare **cambia a runtime**? Non possiamo scriverlo nell'istruzione — dobbiamo leggerlo dalla memoria.

La forma più veloce e compatta per farlo è l'**indirizzamento Zero Page**.

---

## 📘 Teoria

### La Zero Page

I primi 256 byte della memoria del C64, da `$0000` a `$00FF`, sono chiamati **Zero Page** (pagina zero).

Il nome deriva dal fatto che l'indirizzo alto (il "numero di pagina") è `$00` — cioè zero.

Sul 6510, questa zona è speciale per un motivo preciso:

> gli indirizzi Zero Page si rappresentano con **un solo byte** (invece di due).

Questo rende le istruzioni che usano la Zero Page:
- **più corte**: 2 byte invece di 3
- **più veloci**: 3 cicli invece di 4

### Sintassi

```asm
LDA $40   ; carica in A il byte contenuto nella cella di memoria $0040
STA $41   ; scrive il contenuto di A nella cella $0041
```

> Nota: `LDA indirizzo` (senza `#`) non carica il valore `indirizzo`, ma legge il byte contenuto in quella cella di memoria.
> Nota: `STA indirizzo` scrive il contenuto del registro A nella cella di memoria indicata.

Se l'indirizzo è a un byte (`$00`–`$FF`), `64tass` genera automaticamente la versione Zero Page più efficiente.

---

## 🤖 Come ragiona il 6510

Quando il processore esegue `LDA $40`:

1. **Fetch opcode**: legge `$A5` (opcode di `LDA` Zero Page)
2. **Fetch operando**: legge `$40` (l'indirizzo Zero Page)
3. **Read memory**: legge il contenuto di `$0040`
4. **Execute**: scrive quel valore nel registro A

In totale: **2 byte di programma**, **3 cicli macchina**.

---

## 💡 Esempio pratico

```asm
* = $0801

    .word next_line
    .word 10
    .byte $9e
    .text "2061"
    .byte 0

next_line:
    .word 0
; Lezione 012 — Indirizzamento Zero Page
; Usa la Zero Page come area di variabili temporanee


    .word 0


; Variabili in Zero Page (indirizzi $02-$FF sono liberi da usare)
; $02 = colore bordo da usare

; Nota: LDA indirizzo legge il byte contenuto alla cella di memoria indicata.
; Nota: STA indirizzo scrive il contenuto di A nella cella di memoria indicata.

; Inizializza la variabile colore bordo a $05 (verde)
LDA #$05        ; carica il valore $05 in A (modalità immediata)
STA $02         ; salva $05 nella cella $0002 (Zero Page)

; Leggi la variabile e applicala al bordo VIC-II
LDA $02         ; carica in A il contenuto di $0002 (Zero Page)
STA $D020       ; scrivi nel registro colore bordo VIC-II

; Cambia la variabile e riapplica
LDA #$02        ; rosso
STA $02         ; aggiorna la variabile
LDA $02
STA $D020

RTS             ; fine del programma
```

Compila con:

```bash
64tass --cbm-prg -o bin/012.prg src/modulo-5/012.asm
```

---

## ⚠️ Errori comuni

- **Usare indirizzi Zero Page già occupati**: i byte `$00`–`$01` sono usati dal 6510 internamente (puntatori di stack temporanei). Parti da `$02` in su per le tue variabili.
- **Confondere `LDA #$40` con `LDA $40`**: il primo carica il valore 64 nell'accumulatore; il secondo legge il byte contenuto nella cella `$0040`. Errore frequentissimo.
- **Aspettarsi che la Zero Page persista tra reset**: il suo contenuto è RAM volatile; inizializzarla sempre prima dell'uso.

---

## 🧪 Esercizi

1. Scrivi `$07` (giallo) in `$02`, poi leggilo e applicalo al bordo.
2. Usa due variabili (`$02` per il bordo, `$03` per lo sfondo) e applicale entrambe ai registri VIC-II `$D020` e `$D021`.
3. Confronta la dimensione del programma compilato usando `STA $D020` (assoluto, 3 byte) vs `STA $02` + `LDA $02` + `STA $D020`. Quando conviene usare la Zero Page?

---

## 📌 Riassunto

| Concetto               | Spiegazione                                              |
|------------------------|----------------------------------------------------------|
| Zero Page              | I primi 256 byte di memoria (`$0000`–`$00FF`)            |
| Indirizzamento ZP      | L'indirizzo occupa 1 byte; risparmia 1 byte e 1 ciclo    |
| `LDA $40`              | Legge il contenuto della cella `$0040`                   |
| `STA $40`              | Scrive A nella cella `$0040`                             |
| Differenza da immediato| Immediato porta il dato; ZP porta l'indirizzo del dato   |

---

## 🔜 Preparazione alla lezione successiva

Nella lezione 013 vedremo l'**indirizzamento assoluto**: simile allo Zero Page, ma usa un indirizzo a 16 bit per raggiungere qualsiasi cella della memoria (`$0000`–`$FFFF`). Serve per accedere a registri hardware come VIC-II, SID e CIA.

---

## 🔎 Approfondimento — Dentro il 6510

Confronto degli opcode per `LDA`:

| Modalità   | Opcode | Bytes | Cicli | Quando usarla                         |
|------------|--------|-------|-------|---------------------------------------|
| Immediata  | `$A9`  | 2     | 2     | Valore costante noto a compile time   |
| Zero Page  | `$A5`  | 2     | 3     | Variabile nei primi 256 byte          |
| Assoluta   | `$AD`  | 3     | 4     | Qualsiasi indirizzo (es. registri HW) |

La Zero Page è la scelta preferita per variabili temporanee, contatori e puntatori usati frequentemente.

---

## 🔎 Approfondimento - Dentro il 6510

Con le modalita di indirizzamento, la stabilita si ottiene scegliendo sempre il modo piu adatto al dato e al costo in cicli. Distinguere con precisione immediate, zero page e assoluto riduce errori logici e regressioni.

## ✅ Checklist finale

- [ ] l'esempio compila con `64tass`
- [ ] la differenza tra `LDA #$40`, `LDA $40` e `LDA $D020` è chiara
- [ ] le variabili usate non sovrascrivono aree riservate
- [ ] il contenuto è progressivo rispetto alla lezione 011
