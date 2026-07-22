[🏠 Home](../../../index.md)

# Lezione 071 - Audio eventi SID

> **Obiettivo:** aggiungere effetti sonori per gli eventi principali.

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

- gestione audio a eventi con flag (`shot`, `hit`, `game over`);
- uso di SID voice 1 per tone SFX;
- envelope breve e timer audio per rilasciare il gate automaticamente.

---

## 🤖 Come ragiona il 6510

Il 6510 premia routine brevi e stato esplicito: separare input, update, render e audio riduce regressioni e facilita il debug.

---

## 💡 Esempio pratico

```asm
play_audio:
	LDA sfx_gameover
	BEQ check_hit_sfx
	JSR sfx_gameover_tone

check_shot_sfx:
	LDA sfx_shot_flag
	BEQ tick_audio
	JSR sfx_shot_tone

sfx_shot_tone:
	LDA #$40
	STA SID_V1_FREQ_LO
	LDA #$21
	STA SID_V1_CTRL
```

Comportamento della demo:

- su sparo parte un tono corto;
- su danno al player parte un tono distinto;
- in game over parte un tono lungo e grave.

---

## ⚠️ Errori comuni

- introdurre piu sistemi insieme nella stessa lezione;
- rompere il loop principale mentre si integra una feature;
- non verificare i limiti di memoria e indirizzi usati.

---

## 🧪 Esercizi

1. Sposta gli SFX su voice 2 lasciando libera voice 1.
2. Aggiungi un pitch sweep per l'esplosione.
3. Introduci un volume diverso per shot/hit/game over.

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
