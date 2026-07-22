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
wait_tick:
wait_raster_top:
	LDA $D012
	BNE wait_raster_top

wait_raster_leave_top:
	LDA $D012
	BEQ wait_raster_leave_top

	INC frame_counter
	RTS

; FIRE su joystick 2 (bit 4 attivo basso):
; TITLE -> PLAYING, GAME_OVER -> TITLE
read_input:
	LDA JOYSTICK_PORT2
	AND #$10
	BNE fire_released
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
