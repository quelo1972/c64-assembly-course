[🏠 Home](../../../index.md)

# Lezione 056 - Mini-progetto: salvataggio e caricamento dati

> **Obiettivo:** realizzare un mini flusso persistente: inizializzare dati in RAM, salvarli e predisporre il caricamento con routine KERNAL.

---

## 🎯 Obiettivi

- definire un buffer dati semplice in memoria;
- costruire sequenza KERNAL di save;
- predisporre sequenza KERNAL di load;
- consolidare gestione base successo/errore.

---

## 🧠 Introduzione

Questo mini-progetto chiude il modulo 12 unendo protocollo, routine KERNAL e formati pratici in un flusso unico ripetibile.

---

## 📘 Teoria

Pipeline minima:

1. riempi buffer con dati noti;
2. imposta nome file e device;
3. salva range memoria;
4. ricarica e verifica marker.

Per mantenere il focus didattico, usiamo un buffer piccolo è una validazione visiva tramite colore bordo.

---

## 🤖 Come ragiona il 6510

La CPU prepara parametri (indirizzi, nome, device), chiama routine KERNAL e interpreta flag/stato di ritorno. Il valore didattico e nella disciplina del flusso, non nel volume dati.

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
; Lezione 056 - Mini save/load flow (dimostrativo)


    .word 0


SETLFS = $FFBA
SETNAM = $FFBD
SAVE   = $FFD8
LOAD   = $FFD5
BORDER = $D020

BUF_START = $C100
BUF_END   = $C110

start:
    ; inizializza buffer con pattern
    LDX #$00
fill:
    TXA
    STA BUF_START,X
    INX
    CPX #$10
    BNE fill

    ; nome file "DATA"
    LDA #$04
    LDX #<fname
    LDY #>fname
    JSR SETNAM

    ; LFN=1, device=8, SA=1
    LDA #$01
    LDX #$08
    LDY #$01
    JSR SETLFS

    ; SAVE: A=low(start), X=high(start), Y=high(end)
    LDA #<BUF_START
    LDX #>BUF_START
    LDY #>BUF_END
    JSR SAVE

    BCC save_ok
    LDA #$02
    STA BORDER
    JMP done

save_ok:
    ; LOAD dallo stesso nome
    LDA #$04
    LDX #<fname
    LDY #>fname
    JSR SETNAM

    LDA #$01
    LDX #$08
    LDY #$00
    JSR SETLFS

    LDA #$00
    LDX #$00
    LDY #$00
    JSR LOAD

    BCC load_ok
    LDA #$06
    STA BORDER
    JMP done

load_ok:
    LDA #$05
    STA BORDER

done:
    JMP done

fname:
    .text "DATA"
```

`CPX` confronta X con un valore aggiornando i flag; qui chiude il loop di riempimento buffer.

---

## ⚠️ Errori comuni

- usare range save incoerente con il buffer reale;
- aspettarsi che load e save usino sempre lo stesso SA in tutti i contesti;
- non controllare esito e proseguire come se fosse successo.

---

## 🧪 Esercizi

1. Cambia dimensione buffer a 32 byte e adatta il codice.
2. Inserisci un marker fisso nel primo byte e verificane presenza dopo load.
3. Implementa due slot (`DATA1`, `DATA2`) con stessa routine.

---

## 📌 Riassunto

| Fase | Azione |
|------|--------|
| Init | prepara dati in RAM |
| Save | persiste su device |
| Load | ripristina in memoria |
| Check | conferma visiva/flag |

---

## 🔜 Preparazione alla lezione successiva

Nel modulo 13 entreremo in ottimizzazione: cicli, memoria, bank switching e packing dati.

---

## 🔎 Approfondimento - Dentro il 6510

I mini-progetti robusti nascono da flussi deterministici e verificabili. Anche quando il supporto è lento, una buona disciplina di I/O evita corruzioni è stati inconsistenti.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
