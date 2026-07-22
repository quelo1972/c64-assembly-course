[🏠 Home](../../../index.md)

# Lezione 067 - Sparo e object pool

> **Obiettivo:** introdurre il fuoco con pool fisso di proiettili.

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

- object pool fisso da 4 proiettili con flag attivo/inattivo;
- spawn su pressione FIRE (edge press) solo in stato `PLAYING`;
- update verticale dei proiettili e disattivazione al limite alto.

---

## 🤖 Come ragiona il 6510

Il 6510 premia routine brevi e stato esplicito: separare input, update, render e audio riduce regressioni e facilita il debug.

---

## 💡 Esempio pratico

```asm
spawn_shot:
	LDA shot0_active
	BEQ spawn_shot0
	LDA shot1_active
	BEQ spawn_shot1
	LDA shot2_active
	BEQ spawn_shot2
	LDA shot3_active
	BEQ spawn_shot3
	RTS

update_shot0:
	LDA shot0_active
	BEQ shot0_done
	LDA shot0_y
	CMP #MIN_Y
	BEQ shot0_deactivate
	DEC shot0_y
```

Comportamento della demo:

- FIRE in `TITLE` avvia `PLAYING`;
- FIRE in `PLAYING` crea un proiettile nel primo slot libero del pool;
- i proiettili salgono verso l'alto e si disattivano quando raggiungono `MIN_Y`;
- il rendering cancella la posizione precedente e ridisegna la nuova.

---

## ⚠️ Errori comuni

- introdurre piu sistemi insieme nella stessa lezione;
- rompere il loop principale mentre si integra una feature;
- non verificare i limiti di memoria e indirizzi usati.

---

## 🧪 Esercizi

1. Porta il pool da 4 a 8 proiettili mantenendo la stessa logica.
2. Aggiungi rate-of-fire temporizzato (es. uno sparo ogni N frame).
3. Introduci un limite di un solo proiettile attivo per colonna X.

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
