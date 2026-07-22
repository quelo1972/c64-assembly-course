[🏠 Home](../../../index.md)

# Lezione 070 - Score, vite e HUD

> **Obiettivo:** visualizzare punteggio, vite e stato partita.

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

- score a due cifre (`score_tens`, `score_units`) aggiornato periodicamente;
- vite giocatore visualizzate in HUD;
- HUD scritto direttamente in screen RAM nella riga superiore.

---

## 🤖 Come ragiona il 6510

Il 6510 premia routine brevi e stato esplicito: separare input, update, render e audio riduce regressioni e facilita il debug.

---

## 💡 Esempio pratico

```asm
render_hud:
	; S
	LDA #$53
	STA char_value
	LDX #$00
	LDY #$00
	JSR draw_cell

	; score
	LDA score_tens
	JSR hud_digit_to_char
	LDX #$01
	LDY #$00
	JSR draw_cell

tick_score:
	LDA frame_counter
	AND #$07
	BNE tick_score_done
	INC score_units
```

Comportamento della demo:

- la HUD mostra score, vite e stato (`T/P/G`);
- lo score cresce durante il gameplay;
- il layout resta stabile in TITLE, PLAYING e GAME_OVER.

---

## ⚠️ Errori comuni

- introdurre piu sistemi insieme nella stessa lezione;
- rompere il loop principale mentre si integra una feature;
- non verificare i limiti di memoria e indirizzi usati.

---

## 🧪 Esercizi

1. Converti lo score a tre cifre mantenendo aggiornamento efficiente.
2. Aggiungi indicatore wave nella HUD.
3. Cambia colore HUD quando le vite scendono a 1.

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
