[🏠 Home](../../../index.md)

# Lezione 043 - Raster interrupts e sincronizzazione video

> **Obiettivo:** sincronizzare aggiornamenti grafici con il raster per ridurre flicker e ottenere timing stabile.

---

## 🎯 Obiettivi

- capire cos'e una raster line;
- configurare un IRQ raster minimo;
- distinguere aggiornamenti in main loop vs IRQ;
- riconoscere i rischi di sincronizzazione non controllata.

---

## 🧠 Introduzione

Se aggiorni grafica in momenti casuali, puoi ottenere flicker o tearing. Con un raster interrupt chiedi al VIC-II di interrompere la CPU su una linea specifica, cosi l'update avviene in un punto temporale prevedibile.

---

## 📘 Teoria

Registri chiave (schema base):

- `$D012`: linea raster target;
- `$D01A`: abilita sorgenti IRQ VIC-II;
- `$D019`: acknowledge IRQ VIC-II;
- vettore IRQ CPU in RAM: `$0314/$0315`.

Flusso semplice:

1. scrivi indirizzo handler in `$0314/$0315`;
2. imposti linea raster in `$D012`;
3. abiliti bit IRQ raster in `$D01A`;
4. nel handler fai lavoro breve e azzeri flag in `$D019`.

---

## 🤖 Come ragiona il 6510

Quando arriva la linea raster impostata, la CPU salva contesto implicito dell'interrupt e salta all'handler. Il codice IRQ deve essere corto e deterministico. Se non riconosci l'IRQ su `$D019`, l'interrupt puo ripetersi in modo anomalo.

---

## 💡 Esempio pratico

```asm
; Lezione 043 - Raster IRQ minimale
*= $0801

IRQ_VECTOR_LO = $0314
IRQ_VECTOR_HI = $0315
VIC_RASTER    = $D012
VIC_IRQ_STAT  = $D019
VIC_IRQ_MASK  = $D01A
BORDER        = $D020

setup:
    SEI

    LDA #<irq_handler
    STA IRQ_VECTOR_LO
    LDA #>irq_handler
    STA IRQ_VECTOR_HI

    LDA #$64
    STA VIC_RASTER      ; linea raster 100

    LDA #%00000001
    STA VIC_IRQ_MASK    ; abilita IRQ raster

    CLI

main:
    JMP main

irq_handler:
    PHA

    LDA #$05
    STA BORDER          ; segnale visivo nel punto raster

    LDA #%00000001
    STA VIC_IRQ_STAT    ; acknowledge IRQ raster

    PLA
    RTI
```

`SEI` disabilita interrupt durante setup. `CLI` li riabilita. `RTI` ritorna da interrupt e ripristina lo stato CPU salvato dall'hardware.

---

## ⚠️ Errori comuni

- dimenticare acknowledge su `$D019`;
- fare troppo lavoro nell'IRQ;
- non proteggere i registri usati nell'handler.

---

## 🧪 Esercizi

1. Cambia colore bordo in due linee raster diverse.
2. Muovi lo sprite solo da IRQ e confronta fluidita col main loop.

---

## 📌 Riassunto

| Concetto | Spiegazione breve |
|----------|-------------------|
| Raster IRQ | Trigger temporizzato su linea video |
| `$D012` | Selezione linea raster |
| `$D019` | Conferma/clear evento IRQ VIC-II |

---

## 🔜 Preparazione alla lezione successiva

Ora uniamo i pezzi: sprite, sincronizzazione raster, charset/tiles e semplice scrolling hardware in un mini-progetto completo.

---

## 🔎 Approfondimento - Dentro il 6510

Una pipeline robusta separa update logico (main) e update video critico (IRQ). Questa divisione riduce jitter e rende il comportamento piu prevedibile frame-to-frame.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
