[🏠 Home](../../../index.md)

# Lezione 051 - CIA: timer, seriale e keyboard matrix

> **Obiettivo:** capire il ruolo dei due CIA nel C64 e usare il timer A del CIA1 come base per eventi periodici.

---

## 🎯 Obiettivi

- distinguere CIA1 e CIA2 nel sistema C64;
- comprendere timer A/B e interrupt control register;
- introdurre la keyboard matrix a livello hardware;
- costruire un esempio con timer CIA in polling.

---

## 🧠 Introduzione

I CIA (Complex Interface Adapter) sono centrali per tempo e I/O. Anche se spesso si parte dal VIC-II per raster timing, i timer CIA sono una base robusta per eventi periodici e gestione input.

---

## 📘 Teoria

### CIA1 vs CIA2 (visione rapida)

- **CIA1** (`$DC00-$DC0F`): tastiera, joystick port 2, timer utili al sistema.
- **CIA2** (`$DD00-$DD0F`): serial bus, gestione linee complementari e timer.

### Registri timer CIA1 (essenziali)

- `$DC04/$DC05`: Timer A latch lo/hi
- `$DC06/$DC07`: Timer B latch lo/hi
- `$DC0D`: Interrupt Control Register (ICR)
- `$DC0E`: Control Register Timer A

Timer A tipico:

1. carichi latch lo/hi;
2. configuri start/one-shot/free-run;
3. controlli flag interrupt in ICR.

### Keyboard matrix (concetto)

La tastiera C64 è una matrice righe/colonne: si pilotano linee e si leggono stati via CIA1. Molte routine pratiche usano KERNAL scanner, ma capire la matrice aiuta a debug avanzato.

---

## 🤖 Come ragiona il 6510

Con polling, il 6510 interroga periodicamente un registro (es. ICR). Con interrupt, lascia che l'evento arrivi da solo. Polling è semplice ma spreca cicli; interrupt è piu efficiente per scheduler stabili.

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
; Lezione 051 - CIA1 Timer A in polling


    .word 0


CIA1_TA_LO = $DC04
CIA1_TA_HI = $DC05
CIA1_ICR   = $DC0D
CIA1_CRA   = $DC0E
BORDER     = $D020

start:
    ; stop timer A
    LDA #$00
    STA CIA1_CRA

    ; carica latch timer A
    LDA #$FF
    STA CIA1_TA_LO
    LDA #$20
    STA CIA1_TA_HI

    ; clear pending ICR by read
    LDA CIA1_ICR

    ; start timer A, continuous mode
    LDA #%00010001
    STA CIA1_CRA

main_loop:
wait_ta:
    LDA CIA1_ICR
    AND #%00000001          ; bit0: timer A underflow
    BEQ wait_ta

    INC BORDER
    JMP main_loop
```

`AND` applica una maschera bit-a-bit. Qui isola il bit 0 dell'ICR per verificare l'evento timer A.

---

## ⚠️ Errori comuni

- dimenticare di fermare il timer prima di cambiare latch;
- non leggere ICR e lasciare flag pendenti ambigui;
- confondere polling con IRQ reali e aspettarsi stesso timing.

---

## 🧪 Esercizi

1. Prova valori latch diversi e misura la frequenza del cambio bordo.
2. Passa da timer A a timer B con registri dedicati.
3. Integra un controllo tastiera KERNAL in parallelo al polling timer.

---

## 📌 Riassunto

| Blocco CIA | Uso |
|------------|-----|
| Timer A/B | eventi temporali periodici |
| ICR | stato e controllo interrupt |
| Porte I/O | tastiera/joystick/seriale |

---

## 🔜 Preparazione alla lezione successiva

Nel mini-progetto useremo il timer CIA con IRQ per generare tick periodici affidabili.

---

## 🔎 Approfondimento - Dentro il 6510

Polling su CIA e didatticamente ottimo: rende visibile la relazione diretta tra register read e evento hardware. In produzione, però, un IRQ periodico riduce jitter e libera CPU.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
