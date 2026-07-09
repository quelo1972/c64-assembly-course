[🏠 Home](../../../index.md)

# Lezione 042 - Sprite: definizione, posizionamento e collisioni

> **Obiettivo:** usare gli sprite hardware del VIC-II per mostrare un oggetto su schermo, spostarlo e rilevare collisioni base.

---

## 🎯 Obiettivi

- attivare uno sprite hardware;
- impostare coordinate X/Y dello sprite;
- collegare un puntatore sprite in memoria;
- leggere il registro di collisione sprite-sprite.

---

## 🧠 Introduzione

Gli sprite hardware sono uno dei punti forti del C64: permettono oggetti mobili senza riscrivere continuamente tutta la bitmap. In questa lezione ci concentriamo su sprite 0 e collisione base.

---

## 📘 Teoria

Registri essenziali VIC-II:

- `$D015`: abilita sprite (bit 0 = sprite 0);
- `$D000/$D001`: X/Y sprite 0;
- `$D027`: colore sprite 0;
- `$D01E`: collisioni sprite-sprite (flag);
- puntatori sprite in Screen RAM alta (es. `$07F8` per sprite 0).

Dati sprite:

- uno sprite standard usa 63 byte;
- i dati devono stare in area RAM accessibile al VIC-II;
- il puntatore indica il blocco sprite (`indirizzo/64`).

---

## 🤖 Come ragiona il 6510

La CPU prepara dati e registri; il VIC-II renderizza lo sprite ogni frame. La collisione viene aggiornata dal VIC-II nel relativo registro, poi la CPU la legge con `LDA` e verifica bit con `AND`.

---

## 💡 Esempio pratico

```asm
; Lezione 042 - Sprite 0 base + collision flag read
*= $0801

SPRITE0_X      = $D000
SPRITE0_Y      = $D001
SPRITE1_X      = $D002
SPRITE1_Y      = $D003
SPRITE_ENABLE  = $D015
SPRITE0_COLOR  = $D027
SPRITE1_COLOR  = $D028
SPRITE_COLL    = $D01E
SPRITE_PTR0    = $07F8
SPRITE_PTR1    = $07F9
BORDER         = $D020

SPRITE_DATA    = $2000

start:
    LDA #$80
    STA SPRITE0_X
    LDA #$60
    STA SPRITE0_Y

    ; sprite 1 quasi sovrapposto allo sprite 0 per forzare collisione
    LDA #$88
    STA SPRITE1_X
    LDA #$60
    STA SPRITE1_Y

    LDA #%00000011
    STA SPRITE_ENABLE  ; abilita sprite 0 e sprite 1

    LDA #$01
    STA SPRITE0_COLOR
    LDA #$07
    STA SPRITE1_COLOR

    LDA #(SPRITE_DATA / 64)
    STA SPRITE_PTR0
    STA SPRITE_PTR1

loop:
    LDA SPRITE_COLL
    AND #%00000011     ; bit sprite 0 o 1 coinvolti in collisione
    BEQ no_coll

    LDA #$02
    STA BORDER         ; rosso se collisione
    JMP loop

no_coll:
    LDA #$06
    STA BORDER         ; blu se nessuna collisione
    JMP loop

* = SPRITE_DATA
    .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
    .byte $FF,$00,$00,$00,$00,$00,$00,$00,$FF
    .byte $FF,$00,$FF,$FF,$FF,$FF,$FF,$00,$FF
    .byte $FF,$00,$FF,$00,$00,$00,$FF,$00,$FF
    .byte $FF,$00,$FF,$FF,$FF,$FF,$FF,$00,$FF
    .byte $FF,$00,$00,$00,$00,$00,$00,$00,$FF
    .byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
```

`AND` applica una maschera bit. `BEQ` salta quando il risultato e zero. Questo è il pattern tipico per leggere flag nei registri hardware.

---

## ⚠️ Errori comuni

- puntatore sprite errato (indirizzo non diviso 64);
- dati sprite fuori banca VIC-II visibile;
- dimenticare di abilitare il bit sprite in `$D015`.

---

## 🧪 Esercizi

1. Sposta lo sprite di 1 pixel a destra ogni frame.
2. Cambia colore sprite quando rilevi collisione.

---

## 📌 Riassunto

| Concetto | Spiegazione breve |
|----------|-------------------|
| `$D015` | Abilita/disabilita sprite hardware |
| `$D000/$D001` | Coordinate sprite 0 |
| `$D01E` | Registro collisione sprite-sprite |

---

## 🔜 Preparazione alla lezione successiva

Dopo sprite base, introduciamo raster interrupt per sincronizzare aggiornamenti grafici in punti precisi dello schermo.

---

## 🔎 Approfondimento - Dentro il 6510

Gli sprite hardware riducono carico CPU rispetto al ridisegno software continuo. Il costo si sposta sulla gestione registri e sincronizzazione temporale dei cambi stato.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
