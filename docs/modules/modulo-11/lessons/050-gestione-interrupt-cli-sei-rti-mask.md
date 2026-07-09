[🏠 Home](../../../index.md)

# Lezione 050 - Gestione interrupt: CLI, SEI, RTI e mask

> **Obiettivo:** costruire una routine IRQ robusta gestendo correttamente enable/disable interrupt, acknowledge e ritorno con `RTI`.

---

## 🎯 Obiettivi

- usare `SEI` e `CLI` nel punto giusto;
- capire perche `RTI` è obbligatorio negli handler custom;
- configurare mask interrupt di VIC-II/CIA;
- applicare save/restore registri in una ISR.

---

## 🧠 Introduzione

Gli interrupt sono potenti ma delicati: basta un acknowledge mancante o un registro non ripristinato per causare glitch o blocchi.

In questa lezione fissiamo un pattern pratico da riusare.

---

## 📘 Teoria

### Istruzioni chiave

- `SEI`: imposta il flag I e blocca IRQ mascherabili.
- `CLI`: azzera il flag I e riabilita IRQ mascherabili.
- `RTI`: ritorno da interrupt con ripristino stato completo.

### Mask principali su C64

- VIC-II interrupt enable: `$D01A`
- VIC-II interrupt request/ack: `$D019`
- CIA1 interrupt control: `$DC0D`
- CIA2 interrupt control: `$DD0D`

Strategia comune:

1. `SEI` durante setup;
2. disabilita fonti IRQ non usate;
3. abilita solo sorgente desiderata;
4. installa vettore;
5. `CLI`.

---

## 🤖 Come ragiona il 6510

Il 6510 entra in IRQ in mezzo al flusso normale. Se l'handler altera A/X/Y senza ripristino, il main loop riparte in stato incoerente. Per questo una ISR affidabile salva e ripristina sempre i registri usati.

---

## 💡 Esempio pratico

```asm
; Lezione 050 - Raster IRQ robusto (pattern base)
*= $0801

IRQ_VEC_LO = $0314
IRQ_VEC_HI = $0315
RASTER     = $D012
VIC_IRQ_EN = $D01A
VIC_IRQ_FL = $D019
CIA1_ICR   = $DC0D
CIA2_ICR   = $DD0D
BORDER     = $D020

start:
    SEI

    ; disabilita e pulisci CIA IRQ
    LDA #$7F
    STA CIA1_ICR
    STA CIA2_ICR
    LDA CIA1_ICR
    LDA CIA2_ICR

    ; raster line target
    LDA #$80
    STA RASTER

    ; abilita solo raster IRQ del VIC-II
    LDA #%00000001
    STA VIC_IRQ_EN

    ; installa vettore IRQ custom
    LDA #<irq_handler
    STA IRQ_VEC_LO
    LDA #>irq_handler
    STA IRQ_VEC_HI

    CLI

main_loop:
    JMP main_loop

irq_handler:
    PHA
    TXA
    PHA
    TYA
    PHA

    ; acknowledge VIC raster IRQ
    LDA #%00000001
    STA VIC_IRQ_FL

    INC BORDER

    PLA
    TAY
    PLA
    TAX
    PLA
    RTI
```

`PHA` salva A sullo stack, `PLA` lo ripristina. `TXA/TYA` trasferiscono X/Y in A per poterli salvare con `PHA`.

---

## ⚠️ Errori comuni

- usare `RTS` al posto di `RTI` in una ISR;
- dimenticare acknowledge (`$D019`) e restare in interrupt continuo;
- non salvare registri e corrompere la logica del main loop.

---

## 🧪 Esercizi

1. Sostituisci `INC BORDER` con alternanza tra due colori.
2. Sposta la raster line da `$80` a `$30` e osserva la differenza.
3. Inserisci un contatore IRQ in zero page e stampane il valore a schermo.

---

## 📌 Riassunto

| Elemento | Regola pratica |
|----------|----------------|
| `SEI/CLI` | setup atomico, poi enable |
| Save/restore A/X/Y | evita corruzione stato |
| Acknowledge IRQ | evita loop interrupt infinito |
| `RTI` | uscita corretta da ISR |

---

## 🔜 Preparazione alla lezione successiva

Ora che il pattern ISR è chiaro, passiamo ai CIA: timer, seriale e keyboard matrix.

---

## 🔎 Approfondimento - Dentro il 6510

Il costo cicli di una ISR include ingresso/uscita + salvataggi + lavoro utile. Per timing stabile, mantieni la routine breve e sposta elaborazioni pesanti nel main loop.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
