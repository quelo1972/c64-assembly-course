[🏠 Home](../../../index.md)

# Lezione 069 - Collisioni e danno

> **Obiettivo:** implementare collisioni base e gestione danno.

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

- collisioni cella-a-cella tra proiettili e nemici (hit immediata);
- collisione player-nemico con gestione vite;
- finestra di invulnerabilita temporanea per evitare danni multipli nello stesso istante.

---

## 🤖 Come ragiona il 6510

Il 6510 premia routine brevi e stato esplicito: separare input, update, render e audio riduce regressioni e facilita il debug.

---

## 💡 Esempio pratico

```asm
shot0_vs_enemy0:
	LDA shot0_active
	BEQ shot0e0_done
	LDA enemy0_active
	BEQ shot0e0_done
	LDA shot0_x
	CMP enemy0_x
	BNE shot0e0_done
	LDA shot0_y
	CMP enemy0_y
	BNE shot0e0_done
	LDA #$00
	STA shot0_active
	STA enemy0_active

damage_player:
	DEC player_lives
	LDA #$18
	STA invuln_timer
```

Comportamento della demo:

- i proiettili eliminano i nemici al contatto;
- il player perde vite al contatto diretto con un nemico;
- a vite terminate lo stato passa a `GAME_OVER`.

---

## ⚠️ Errori comuni

- introdurre piu sistemi insieme nella stessa lezione;
- rompere il loop principale mentre si integra una feature;
- non verificare i limiti di memoria e indirizzi usati.

---

## 🧪 Esercizi

1. Passa da collisione punto-a-punto a hitbox 2x2.
2. Aggiungi un knockback minimo al player quando subisce danno.
3. Introduci invulnerabilita lampeggiante con durata variabile per livello.

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
