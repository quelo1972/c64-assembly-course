[🏠 Home](../../../index.md)

# Lezione 045 - Registri principali del SID

> **Obiettivo:** capire la mappa registri del SID è come inizializzare una voce audio in modo controllato.

---

## 🎯 Obiettivi

- riconoscere l'area SID nella mappa I/O del C64;
- distinguere registri per voce (frequenza, pulse width, controllo, ADSR);
- capire i registri globali (filtro, volume);
- scrivere una prima inizializzazione audio minima.

---

## 🧠 Introduzione

Il SID (MOS 6581/8580) è il chip audio del C64. Per produrre suono, il 6510 scrive nei registri SID in area I/O, come abbiamo gia fatto con VIC-II nel modulo grafico.

L'idea è semplice: scegli una voce, imposti frequenza e forma d'onda, abiliti il gate, è il SID inizia a suonare.

---

## 📘 Teoria

Base address SID: `$D400`.

Tre voci indipendenti:

- Voce 1: `$D400-$D406`
- Voce 2: `$D407-$D40D`
- Voce 3: `$D40E-$D414`

Registri principali per ogni voce:

- `FREQ LO/HI` (frequenza)
- `PW LO/HI` (pulse width per onda pulse)
- `CONTROL` (forma d'onda + gate + sync/ring/test)
- `ATTACK/DECAY`
- `SUSTAIN/RELEASE`

Registri globali utili:

- `$D415-$D417`: cutoff/resonance/filter routing
- `$D418`: volume master + bit mode speciali

Nota pratica: la frequenza SID non è in Hz diretti. Usi valori a 16 bit; la conversione precisa dipende dal clock PAL/NTSC.

---

## 🤖 Come ragiona il 6510

Il 6510 non genera audio da solo: configura il SID scrivendo byte nei suoi registri. Una volta attivato il gate, il SID continua a oscillare secondo i parametri correnti, mentre la CPU puo fare altro.

---

## 💡 Esempio pratico

```asm
; Lezione 045 - Init minima SID voice 1
*= $0801

SID_V1_FREQ_LO = $D400
SID_V1_FREQ_HI = $D401
SID_V1_PW_LO   = $D402
SID_V1_PW_HI   = $D403
SID_V1_CTRL    = $D404
SID_V1_AD      = $D405
SID_V1_SR      = $D406
SID_VOL        = $D418

start:
    ; volume master = 15 (max)
    LDA #$0F
    STA SID_VOL

    ; frequenza iniziale (valore di prova)
    LDA #$00
    STA SID_V1_FREQ_LO
    LDA #$20
    STA SID_V1_FREQ_HI

    ; pulse width = 0x0800 (se useremo onda pulse)
    LDA #$00
    STA SID_V1_PW_LO
    LDA #$08
    STA SID_V1_PW_HI

    ; ADSR semplice
    LDA #$11          ; attack=1, decay=1
    STA SID_V1_AD
    LDA #$F2          ; sustain=15, release=2
    STA SID_V1_SR

    ; CONTROL: triangle + gate on
    LDA #%00010001
    STA SID_V1_CTRL

loop:
    JMP loop
```

`STA` scrive il contenuto di A in memoria I/O. Qui ogni `STA` configura un parametro del SID.

---

## ⚠️ Errori comuni

- dimenticare il volume (`$D418`) e non sentire nulla;
- usare `CONTROL` senza gate (`bit 0`) pensando di aver avviato il suono;
- sovrascrivere accidentalmente registri di un'altra voce.

---

## 🧪 Esercizi

1. Cambia la frequenza (`$D400/$D401`) e ascolta differenze di altezza.
2. Imposta `CONTROL` su sawtooth e confronta il timbro.
3. Riduci `SUSTAIN` in `$D406` e osserva il cambio di dinamica.

---

## 📌 Riassunto

| Registro | Ruolo |
|----------|-------|
| `$D400/$D401` | Frequenza voce 1 |
| `$D404` | Forma d'onda e gate |
| `$D405/$D406` | Inviluppo ADSR |
| `$D418` | Volume master |

---

## 🔜 Preparazione alla lezione successiva

Nella prossima lezione vedremo come scegliere forme d'onda e costruire toni controllati con gate on/off.

---

## 🔎 Approfondimento - Dentro il 6510

Il 6510 tratta il SID come periferica memory-mapped: stessa istruzione (`STA`) usata per RAM e I/O, ma effetto hardware completamente diverso.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
