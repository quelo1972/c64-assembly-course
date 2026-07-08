[🏠 Home](../../../index.md)

# Lezione 044 - Mini-progetto: scena con sprite animati e scrolling

> **Obiettivo:** integrare sprite, charset/tile map e scorrimento orizzontale semplice in una scena coerente.

---

## 🎯 Obiettivi

- costruire un loop grafico base per scena dinamica;
- animare uno sprite tramite frame pointer;
- applicare uno scrolling orizzontale semplice;
- usare tile/charset per sfondo leggero.

---

## 🧠 Introduzione

Questa lezione completa il modulo 9: mettiamo insieme i concetti del VIC-II in una pipeline minima da "gioco": sfondo a tile (charset), sprite animato e scorrimento hardware base.

---

## 📘 Teoria

Componenti del mini-progetto:

- **Background**: griglia caratteri (tile semplici) in Screen RAM;
- **Sprite actor**: sprite 0 con due frame alternati;
- **Scrolling**: offset orizzontale aggiornato nel tempo;
- **Timing**: update sincronizzato (idealmente con raster IRQ).

Schema update:

1. read input / AI semplice;
2. update posizione sprite;
3. update frame animazione;
4. update scroll registro;
5. render minimo.

---

## 🤖 Come ragiona il 6510

Il 6510 aggiorna registri VIC-II e memoria video a piccoli passi. La fluidita deriva da update frequenti e coerenti, non da blocchi monolitici. Le operazioni critiche per il frame timing vanno mantenute brevi.

---

## 💡 Esempio pratico

```asm
; Lezione 044 - Mini scena: sprite animato + scrolling semplice
*= $0801

SPRITE0_X     = $D000
SPRITE0_Y     = $D001
SPRITE_EN     = $D015
SPRITE0_COLOR = $D027
SPRITE_PTR0   = $07F8
SCROLL_X      = $D016

FRAME_COUNTER = $02
SPRITE_POS_X  = $03

SPRITE_FRAME0 = $2000
SPRITE_FRAME1 = $2040

start:
    LDA #$01
    STA SPRITE_EN

    LDA #$50
    STA SPRITE0_Y

    LDA #$01
    STA SPRITE0_COLOR

    LDA #$40
    STA SPRITE_POS_X

main_loop:
    ; movimento sprite
    LDA SPRITE_POS_X
    CLC
    ADC #$01
    STA SPRITE_POS_X
    STA SPRITE0_X

    ; animazione 2 frame
    LDA FRAME_COUNTER
    AND #%00001000
    BEQ frame0

    LDA #(SPRITE_FRAME1 / 64)
    STA SPRITE_PTR0
    JMP scroll_step

frame0:
    LDA #(SPRITE_FRAME0 / 64)
    STA SPRITE_PTR0

scroll_step:
    ; scroll orizzontale fine (3 bit bassi)
    LDA FRAME_COUNTER
    AND #%00000111
    ORA #%00001000      ; mantiene settaggio base multicolor/text bit pattern esempio
    STA SCROLL_X

    INC FRAME_COUNTER
    JMP main_loop

* = SPRITE_FRAME0
    .byte $18,$3C,$7E,$FF,$FF,$7E,$3C,$18
    .fill 55, $00

* = SPRITE_FRAME1
    .byte $00,$18,$3C,$7E,$7E,$3C,$18,$00
    .fill 55, $00
```

`ADC` somma con carry. `INC` incrementa un byte in memoria. `AND` maschera i bit utili per animazione e scroll.

---

## ⚠️ Errori comuni

- non separare update sprite e update scroll;
- usare dati sprite con lunghezza sbagliata;
- aspettarsi scrolling "a tile" completo senza gestione colonna entrante.

---

## 🧪 Esercizi

1. Aggiungi wrapping della posizione sprite quando supera 255.
2. Inserisci un secondo sprite con velocita diversa.
3. Implementa inserimento nuova colonna tile quando il fine scroll torna a 0.

---

## 📌 Riassunto

| Concetto | Spiegazione breve |
|----------|-------------------|
| Sprite animation | Cambio puntatore frame nel tempo |
| Fine scrolling | Offset orizzontale gestito via registro VIC-II |
| Tile/charset layer | Sfondo leggero e veloce da aggiornare |

---

## 🔜 Preparazione alla lezione successiva

Nel modulo 10 passeremo dal video all'audio: registri SID, oscillatori, inviluppi e pattern semplici.

---

## 🔎 Approfondimento - Dentro il 6510

Una scena stabile usa budget cicli per frame: prima timing critico, poi logica extra. Questo approccio evita regressioni quando aggiungi nuove feature grafiche.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
