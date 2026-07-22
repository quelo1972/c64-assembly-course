[🏠 Home](../../../index.md)

# Lezione 065 - Game loop e state machine

> **Obiettivo:** impostare loop a tick fisso e stati title/playing/game-over.

---

## 🎯 Obiettivi

- implementare il sistema previsto dalla lezione;
- mantenere il build compilabile rispetto alla lezione precedente;
- validare con test manuali su VICE.

---

## 🧠 Introduzione

Questa lezione estende la track shoot 'em up in modo incrementale, mantenendo un singolo obiettivo tecnico principale.

---

## 📘 Teoria

- tick fisso sincronizzato al raster: una iterazione logica per frame;
- state machine minima con tre stati (`TITLE`, `PLAYING`, `GAME_OVER`);
- input FIRE su joystick porta 2 come evento di transizione tra stati.

---

## 🤖 Come ragiona il 6510

Il 6510 premia routine brevi e stato esplicito: separare input, update, render e audio riduce regressioni e facilita il debug.

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

; Lezione 065 - Game loop e state machine

BORDER          = $D020
BG_COLOR        = $D021
JOYSTICK_PORT2  = $DC00

STATE_TITLE     = $00
STATE_PLAYING   = $01
STATE_GAME_OVER = $02

player_x        = $02
player_y        = $03
player_cooldown = $04
game_state      = $05
frame_counter   = $06

start:
    JSR init

main_loop:
    JSR wait_tick
    JSR read_input
    JSR update_game
    JSR render_game
    JSR play_audio
    JMP main_loop

init:
    LDA #$00
    STA BORDER
    STA BG_COLOR
    STA frame_counter
    STA player_cooldown
    LDA #STATE_TITLE
    STA game_state
    RTS

wait_tick:
wait_raster_top:
    LDA $D012
    BNE wait_raster_top

wait_raster_leave_top:
    LDA $D012
    BEQ wait_raster_leave_top

    INC frame_counter
    RTS

read_input:
    ; Joystick port 2: FIRE e' attivo basso (bit 4 = 0 quando premuto).
    LDA JOYSTICK_PORT2
    AND #$10
    BNE fire_released

fire_pressed:
    LDA player_cooldown
    BNE input_done

    LDA #$01
    STA player_cooldown

    LDA game_state
    CMP #STATE_TITLE
    BNE check_restart

    LDA #STATE_PLAYING
    STA game_state
    LDA #$00
    STA frame_counter
    JMP input_done

check_restart:
    CMP #STATE_GAME_OVER
    BNE input_done

    LDA #STATE_TITLE
    STA game_state
    LDA #$00
    STA frame_counter
    JMP input_done

fire_released:
    LDA #$00
    STA player_cooldown

input_done:
    RTS

update_game:
    LDA game_state
    CMP #STATE_TITLE
    BEQ update_title
    CMP #STATE_PLAYING
    BEQ update_playing
    CMP #STATE_GAME_OVER
    BEQ update_game_over
    RTS

update_title:
    RTS

update_playing:
    ; Demo state flow: dopo alcuni secondi passa a GAME OVER.
    LDA frame_counter
    CMP #$C8
    BCC playing_done

    LDA #STATE_GAME_OVER
    STA game_state
    LDA #$00
    STA frame_counter

playing_done:
    RTS

update_game_over:
    ; Nessuna logica di gioco: solo attesa restart via FIRE.
    RTS

render_game:
    LDA game_state
    CMP #STATE_TITLE
    BEQ render_title
    CMP #STATE_PLAYING
    BEQ render_playing
    CMP #STATE_GAME_OVER
    BEQ render_game_over
    RTS

render_title:
    LDA #$06
    STA BORDER
    LDA #$00
    STA BG_COLOR
    RTS

render_playing:
    LDA frame_counter
    AND #$0F
    STA BORDER
    LDA #$00
    STA BG_COLOR
    RTS

render_game_over:
    LDA frame_counter
    AND #$10
    BEQ game_over_dark

    LDA #$02
    STA BORDER
    LDA #$06
    STA BG_COLOR
    RTS

game_over_dark:
    LDA #$00
    STA BORDER
    LDA #$00
    STA BG_COLOR
    RTS

play_audio:
    ; TODO: eventi SID.
    RTS
```

Comportamento della demo:

- all'avvio il gioco e in `TITLE`;
- premendo FIRE entra in `PLAYING`;
- dopo ~200 frame passa a `GAME_OVER`;
- premendo FIRE in `GAME_OVER` torna a `TITLE`.

---

## ⚠️ Errori comuni

- introdurre piu sistemi insieme nella stessa lezione;
- rompere il loop principale mentre si integra una feature;
- non verificare i limiti di memoria e indirizzi usati.

---

## 🧪 Esercizi

1. Sostituisci il passaggio automatico a `GAME_OVER` con una condizione reale (es. vite a zero).
2. Aggiungi un contatore in HUD per verificare visivamente i tick.
3. Porta `wait_tick` su timer CIA e confronta stabilita e semplicità del codice.

---

## 📌 Riassunto

| Punto | Esito atteso |
|-------|--------------|
| sistema introdotto | funzionante |
| build | compilazione ok |
| test manuali | checklist completata |

---

## 🔜 Preparazione alla lezione successiva

- Consolidare questo step prima di introdurre la feature successiva della track.

---

## 🔎 Approfondimento - Dentro il 6510

In questa lezione la stabilita dipende dalla separazione netta tra input, update e render: con routine piccole e stato esplicito il debug resta prevedibile anche quando aumentano entita e collisioni.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio e coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto e semplice e progressivo;
