[🏠 Home](../../../index.md)

# Lezione 046 - Generazione di toni e forme d'onda

> **Obiettivo:** produrre toni controllati scegliendo frequenza, waveform e gestione corretta del gate.

---

## 🎯 Obiettivi

- capire la relazione tra registro frequenza e altezza percepita;
- usare le forme d'onda principali del SID;
- accendere e spegnere una nota con gate on/off;
- creare una piccola routine di test timbrico.

---

## 🧠 Introduzione

Dopo aver visto i registri, passiamo al cuore sonoro: oscillatore + waveform. La stessa frequenza su triangle, sawtooth o pulse produce timbri molto diversi.

Per controllare inizio/fine nota usiamo il bit gate nel registro CONTROL.

---

## 📘 Teoria

Per la voce 1:

- frequenza: `$D400/$D401`
- controllo waveform/gate: `$D404`

Bit tipici in `CONTROL`:

- bit 0: GATE (1 nota attiva, 0 rilascio)
- bit 4: TRIANGLE
- bit 5: SAWTOOTH
- bit 6: PULSE
- bit 7: NOISE

Esempi rapidi:

- triangle + gate: `%00010001`
- sawtooth + gate: `%00100001`
- pulse + gate: `%01000001`

Nota: il SID permette combinazioni di waveform, ma per iniziare è meglio usare una forma alla volta.

---

## 🤖 Come ragiona il 6510

Il 6510 cambia i registri "a scatti". Ogni scrittura puo alterare subito il suono. Per questo conviene definire un ordine: prima frequenza e ADSR, poi gate on; per spegnere, gate off.

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
; Lezione 046 - Tone test: triangle, saw, pulse


    .word 0


SID_V1_FREQ_LO = $D400
SID_V1_FREQ_HI = $D401
SID_V1_PW_LO   = $D402
SID_V1_PW_HI   = $D403
SID_V1_CTRL    = $D404
SID_V1_AD      = $D405
SID_V1_SR      = $D406
SID_VOL        = $D418

start:
    LDA #$0F
    STA SID_VOL

    ; ADSR veloce per test
    LDA #$11
    STA SID_V1_AD
    LDA #$F1
    STA SID_V1_SR

    ; frequenza test
    LDA #$00
    STA SID_V1_FREQ_LO
    LDA #$28
    STA SID_V1_FREQ_HI

    ; pulse width media
    LDA #$00
    STA SID_V1_PW_LO
    LDA #$08
    STA SID_V1_PW_HI

triangle_note:
    LDA #%00010001
    STA SID_V1_CTRL
    JSR delay
    LDA #%00010000
    STA SID_V1_CTRL
    JSR delay

saw_note:
    LDA #%00100001
    STA SID_V1_CTRL
    JSR delay
    LDA #%00100000
    STA SID_V1_CTRL
    JSR delay

pulse_note:
    LDA #%01000001
    STA SID_V1_CTRL
    JSR delay
    LDA #%01000000
    STA SID_V1_CTRL
    JSR delay

    JMP triangle_note

delay:
    LDY #$20
d1:
    LDX #$FF
d2:
    DEX
    BNE d2
    DEY
    BNE d1
    RTS
```

`JSR` salta a subroutine salvando il ritorno sullo stack. `RTS` torna al chiamante.

---

## ⚠️ Errori comuni

- spegnere la nota azzerando tutto `CONTROL` senza criterio;
- non impostare `PW` quando usi pulse;
- fare delay troppo brevi e non percepire differenze timbriche.

---

## 🧪 Esercizi

1. Sostituisci la frequenza test con tre frequenze diverse in sequenza.
2. Prova noise waveform e descrivi differenze con triangle.
3. Modifica pulse width (`$D402/$D403`) e annota come cambia il suono.

---

## 📌 Riassunto

| Concetto | Pratica |
|----------|---------|
| Frequenza | Definisce altezza nota |
| Waveform | Definisce timbro |
| Gate | Accende/spegne la nota |

---

## 🔜 Preparazione alla lezione successiva

La prossima lezione introduce inviluppi ADSR e filtri SID per modellare dinamica e colore timbrico.

---

## 🔎 Approfondimento - Dentro il 6510

L'ordine delle scritture su registri audio è una forma di "protocollo software": prima setup stabile, poi trigger (gate). Questo riduce artefatti.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
