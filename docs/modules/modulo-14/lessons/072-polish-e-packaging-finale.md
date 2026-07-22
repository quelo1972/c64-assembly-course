[🏠 Home](../../../index.md)

# Lezione 072 - Polish e packaging finale

> **Obiettivo:** rifinire, validare e preparare la release finale.

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

- difficolta progressiva con `spawn_mask` dinamico legato allo score;
- reset robusto dello stato in `GAME_OVER` per restart immediato;
- rifinitura visiva degli stati (title animato, game over lampeggiante).

---

## 🤖 Come ragiona il 6510

Il 6510 premia routine brevi e stato esplicito: separare input, update, render e audio riduce regressioni e facilita il debug.

---

## 💡 Esempio pratico

```asm
update_difficulty:
	LDA score_tens
	CMP #$06
	BCS diff_hard
	CMP #$03
	BCS diff_mid

diff_easy:
	LDA #$1F
	STA spawn_mask

maybe_spawn_enemy:
	LDA spawn_timer
	AND spawn_mask
	BNE spawn_done
```

Comportamento della demo:

- la frequenza di spawn aumenta con il punteggio;
- in game over il sistema mantiene pool puliti e restart rapido;
- title e game over hanno feedback visivo piu leggibile.

---

## ⚠️ Errori comuni

- introdurre piu sistemi insieme nella stessa lezione;
- rompere il loop principale mentre si integra una feature;
- non verificare i limiti di memoria e indirizzi usati.

---

## 🧪 Esercizi

1. Aggiungi due livelli di difficolta extra oltre `diff_hard`.
2. Salva un record locale (hi-score) in RAM persistente durante la sessione.
3. Prepara una checklist release (build, run in VICE, test regressione) e applicala.

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
