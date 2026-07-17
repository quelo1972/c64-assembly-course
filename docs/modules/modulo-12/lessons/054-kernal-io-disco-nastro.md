[🏠 Home](../../../index.md)

# Lezione 054 - Routine KERNAL per I/O su disco e nastro

> **Obiettivo:** usare il set minimo di routine KERNAL per caricare e salvare file senza accedere ai dettagli fisici del supporto.

---

## 🎯 Obiettivi

- usare `SETNAM`, `SETLFS`, `LOAD`;
- distinguere indirizzo di load automatico e indirizzo esplicito;
- capire il ruolo del carry flag nelle routine KERNAL;
- costruire una sequenza base di load con gestione esito.

---

## 🧠 Introduzione

Le routine KERNAL astraggono disco e nastro dietro una API stabile. Per il corso è il modo migliore per acquisire praticita prima di affrontare livelli piu bassi.

---

## 📘 Teoria

Routine chiave:

- `SETNAM` (`$FFBD`): nome file;
- `SETLFS` (`$FFBA`): logical file/device/secondary;
- `LOAD` (`$FFD5`): carica file;
- `SAVE` (`$FFD8`): salva range memoria.

Caricamento tipico:

1. imposti nome e device;
2. `A=0` in `LOAD` per usare load address del file PRG;
3. controlli esito via carry flag.

Nota istruzione:

- `BCC` (Branch if Carry Clear) salta se carry=0, quindi in questo contesto indica spesso "operazione riuscita".

---

## 🤖 Come ragiona il 6510

Il 6510 prepara parametri nei registri e delega il trasferimento alle routine ROM. Dopo la `JSR`, usa i flag di stato per decidere il percorso successivo (successo/errore).

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
; Lezione 054 - Load KERNAL con check carry


    .word 0


SETLFS = $FFBA
SETNAM = $FFBD
LOAD   = $FFD5
BORDER = $D020

start:
    ; Nome file "DEMO"
    LDA #$04
    LDX #<fname
    LDY #>fname
    JSR SETNAM

    ; LFN=1, device=8, SA=0
    LDA #$01
    LDX #$08
    LDY #$00
    JSR SETLFS

    ; LOAD con indirizzo dal file (A=0)
    LDA #$00
    LDX #$00
    LDY #$00
    JSR LOAD

    BCC ok_load

err_load:
    LDA #$02
    STA BORDER
    JMP done

ok_load:
    LDA #$05
    STA BORDER

done:
    JMP done

fname:
    .text "DEMO"
```

`BCC` controlla il carry flag dopo `LOAD`. Se clear, seguiamo il percorso di successo.

---

## ⚠️ Errori comuni

- usare nome file ma dimenticare `SETLFS`;
- interpretare al contrario il carry flag;
- dare per scontato lo stesso comportamento tra device diversi.

---

## 🧪 Esercizi

1. Cambia colore errore/successo e prova file inesistente.
2. Sostituisci `BCC` con `BCS` e osserva il flusso invertito.
3. Scrivi la variante con save minimale (concettuale).

---

## 📌 Riassunto

| Routine | Scopo |
|---------|-------|
| `SETNAM` | definisce nome file |
| `SETLFS` | definisce canale logico e device |
| `LOAD/SAVE` | trasferimento dati |

---

## 🔜 Preparazione alla lezione successiva

Nella prossima lezione analizzeremo i formati PRG e D64 per capire cosa stiamo realmente caricando o salvando.

---

## 🔎 Approfondimento - Dentro il 6510

L uso dei flag dopo una routine ROM è una tecnica fondamentale: riduce branching superfluo e rende esplicita la gestione degli errori.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
