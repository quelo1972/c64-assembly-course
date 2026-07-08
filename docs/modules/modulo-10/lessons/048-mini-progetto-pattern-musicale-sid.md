[🏠 Home](../../../index.md)

# Lezione 048 - Mini-progetto: playback di un pattern musicale SID

> **Obiettivo:** costruire un mini player monofonico che legge un pattern di note e lo riproduce con il SID.

---

## 🎯 Obiettivi

- organizzare una tabella note/durate in memoria;
- implementare playback sequenziale con loop;
- usare gate on/off per articolare le note;
- ottenere una piccola melodia ripetibile.

---

## 🧠 Introduzione

Chiudiamo il modulo 10 con un mini-progetto completo: un pattern player essenziale. Non e un tracker, ma mostra la struttura base usata in molti engine audio: dati + interprete + timing.

---

## 📘 Teoria

Architettura minima del player:

1. tabella frequenze (lo/hi) per ciascuna nota;
2. indice corrente nel pattern;
3. routine play-note:
   - carica frequenza;
   - gate on;
   - attende durata;
   - gate off;
4. incremento indice e wrap a fine pattern.

Per semplicita usiamo una sola voce (voice 1).

---

## 🤖 Come ragiona il 6510

Il 6510 esegue sempre lo stesso ciclo: legge byte dal pattern, li traduce in scritture SID, applica delay, passa alla nota successiva. Questa ripetizione deterministica e la base dei player musicali realtime su macchine 8-bit.

---

## 💡 Esempio pratico

```asm
; Lezione 048 - Mini pattern player monofonico
*= $0801

SID_V1_FREQ_LO = $D400
SID_V1_FREQ_HI = $D401
SID_V1_CTRL    = $D404
SID_V1_AD      = $D405
SID_V1_SR      = $D406
SID_VOL        = $D418

PAT_INDEX      = $02

start:
    LDA #$0F
    STA SID_VOL

    ; ADSR base
    LDA #$12
    STA SID_V1_AD
    LDA #$A3
    STA SID_V1_SR

    LDA #$00
    STA PAT_INDEX

main_loop:
    LDX PAT_INDEX

    ; carica frequenza dalla tabella
    LDA notes_lo,X
    STA SID_V1_FREQ_LO
    LDA notes_hi,X
    STA SID_V1_FREQ_HI

    ; gate on + triangle
    LDA #%00010001
    STA SID_V1_CTRL

    ; durata nota
    LDA note_len,X
    JSR wait_units

    ; gate off
    LDA #%00010000
    STA SID_V1_CTRL

    ; piccolo spazio tra note
    LDA #$04
    JSR wait_units

    INX
    CPX #$08
    BNE save_index
    LDX #$00

save_index:
    STX PAT_INDEX
    JMP main_loop

; Attende A unita di tempo
wait_units:
    TAY
wu_outer:
    LDX #$FF
wu_inner:
    DEX
    BNE wu_inner
    DEY
    BNE wu_outer
    RTS

; Scala semplice (valori indicativi)
notes_lo:
    .byte $11,$38,$61,$8B,$B8,$E8,$1B,$52
notes_hi:
    .byte $11,$12,$13,$14,$15,$16,$18,$19

note_len:
    .byte $18,$18,$18,$18,$18,$18,$18,$24
```

`LDX` carica l'indice pattern nel registro X. `CPX` confronta X con un valore e aggiorna i flag per gestire il wrap del pattern.

---

## ⚠️ Errori comuni

- dimenticare di aggiornare l'indice e riascoltare sempre la stessa nota;
- usare tabelle con lunghezze diverse (note vs durata);
- scegliere delay non calibrati e ottenere ritmo troppo veloce/lento.

---

## 🧪 Esercizi

1. Aggiungi una seconda tabella per cambiare waveform ogni nota.
2. Implementa una "pausa" con valore speciale nel pattern.
3. Raddoppia la lunghezza del pattern e crea una frase A-B.

---

## 📌 Riassunto

| Componente | Funzione |
|------------|----------|
| Tabelle pattern | Definiscono melodia e durata |
| Loop player | Interpreta pattern in realtime |
| Gate on/off | Articola inizio/fine nota |

---

## 🔜 Preparazione alla lezione successiva

Nel modulo 11 passeremo alla gestione del tempo con interrupt e CIA, fondamentale per scheduler audio/video piu stabili.

---

## 🔎 Approfondimento - Dentro il 6510

Un player robusto separa logica musicale (pattern) da timing hardware (interrupt). In questo esempio il timing e a busy-wait per chiarezza; nel mondo reale spesso si usa IRQ periodico.

Per estendere questo player a configurazioni moderne con piu SID attivi in contemporanea, vedi [Appendice 008 - SID multipli su U64EII e C64U](../../../appendici/008-sid-multipli-u64eii-c64u.md).

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
