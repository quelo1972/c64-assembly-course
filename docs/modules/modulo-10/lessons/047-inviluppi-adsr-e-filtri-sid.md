[🏠 Home](../../../index.md)

# Lezione 047 - Inviluppi ADSR e filtri SID

> **Obiettivo:** controllare l'evoluzione temporale del suono (ADSR) e introdurre l'uso base del filtro del SID.

---

## 🎯 Obiettivi

- capire i parametri ADSR (Attack, Decay, Sustain, Release);
- programmare inviluppi diversi per note corte/lunghe;
- introdurre cutoff e resonance del filtro SID;
- applicare filtro in una patch semplice.

---

## 🧠 Introduzione

Un suono credibile non è solo "nota on/off": serve dinamica. L'ADSR definisce come il volume evolve nel tempo, mentre il filtro modella il contenuto armonico.

In questa lezione lavoriamo con una singola voce per tenere tutto leggibile.

---

## 📘 Teoria

Registri ADSR voce 1:

- `$D405` = Attack (nibble alto) + Decay (nibble basso)
- `$D406` = Sustain (nibble alto) + Release (nibble basso)

Regola base:

- gate on: parte Attack, poi Decay fino a Sustain;
- gate off: entra Release fino a silenzio.

Filtro globale SID:

- `$D415/$D416`: cutoff (11 bit)
- `$D417`: resonance + routing voci nel filtro
- `$D418`: volume master + modalita filtro (LP/BP/HP)

Per iniziare: usa low-pass semplice con resonance moderata.

---

## 🤖 Come ragiona il 6510

Il 6510 scrive parametri statici (ADSR/filtro), poi usa gate on/off per innescare le fasi temporali interne del SID. Quindi la curva di volume continua anche senza loop CPU dedicati per ogni campione.

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
; Lezione 047 - ADSR + filtro low-pass base


    .word 0


SID_V1_FREQ_LO = $D400
SID_V1_FREQ_HI = $D401
SID_V1_CTRL    = $D404
SID_V1_AD      = $D405
SID_V1_SR      = $D406
SID_FC_LO      = $D415
SID_FC_HI      = $D416
SID_RES_FILT   = $D417
SID_MODE_VOL   = $D418

start:
    ; volume 15 + low-pass on
    LDA #%00011111
    STA SID_MODE_VOL

    ; cutoff medio
    LDA #$80
    STA SID_FC_LO
    LDA #$04
    STA SID_FC_HI

    ; resonance media + route voice1 in filtro
    LDA #%01000001
    STA SID_RES_FILT

    ; frequenza nota test
    LDA #$00
    STA SID_V1_FREQ_LO
    LDA #$24
    STA SID_V1_FREQ_HI

    ; ADSR: attack rapido, decay medio, sustain alto, release medio
    LDA #$27
    STA SID_V1_AD
    LDA #$C5
    STA SID_V1_SR

play_note:
    ; saw + gate on
    LDA #%00100001
    STA SID_V1_CTRL
    JSR delay

    ; gate off (release)
    LDA #%00100000
    STA SID_V1_CTRL
    JSR delay

    JMP play_note

delay:
    LDY #$30
d1:
    LDX #$FF
d2:
    DEX
    BNE d2
    DEY
    BNE d1
    RTS
```

`AND` e `ORA` sono spesso usati per modificare solo alcuni bit di registri complessi; in questo esempio usiamo valori completi pre-calcolati per chiarezza.

---

## ⚠️ Errori comuni

- confondere nibble alto/basso in `AD` e `SR`;
- dimenticare il routing voce nel filtro (`$D417`);
- usare cutoff estremo e pensare che il suono sia "rotto".

---

## 🧪 Esercizi

1. Crea due preset ADSR: "plucked" (attacco rapido, release breve) e "pad" (attacco lento, release lunga).
2. Aumenta resonance e valuta il cambio timbrico.
3. Disattiva il filtro e confronta il risultato a parita di ADSR.

---

## 📌 Riassunto

| Blocco | Registro |
|--------|----------|
| ADSR voce 1 | `$D405/$D406` |
| Cutoff filtro | `$D415/$D416` |
| Resonance/routing | `$D417` |
| Modalita filtro + volume | `$D418` |

---

## 🔜 Preparazione alla lezione successiva

Nella prossima lezione useremo tutto insieme per un mini-player a pattern musicale semplice.

---

## 🔎 Approfondimento - Dentro il 6510

Demandare al SID l'evoluzione dell'inviluppo riduce carico CPU: la routine principale puo concentrarsi su timing note e cambio parametri macro.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
