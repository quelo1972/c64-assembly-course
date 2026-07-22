[🏠 Home](../../../index.md)

# Lezione 068 - Nemici e spawn controller

> **Obiettivo:** aggiungere spawn e movimento base dei nemici.

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

- pool nemici fisso da 3 slot con flag attivo/inattivo;
- spawn periodico controllato da `spawn_timer`;
- movimento misto: discesa verticale + drift orizzontale con cambio direzione ai bordi.

---

## 🤖 Come ragiona il 6510

Il 6510 premia routine brevi e stato esplicito: separare input, update, render e audio riduce regressioni e facilita il debug.

---

## 💡 Esempio pratico

```asm
maybe_spawn_enemy:
	LDA spawn_timer
	AND #$1F
	BNE spawn_done

	LDA enemy0_active
	BEQ spawn_enemy0
	LDA enemy1_active
	BEQ spawn_enemy1
	LDA enemy2_active
	BEQ spawn_enemy2

move_enemy0:
	LDA frame_counter
	AND #$01
	BNE enemy0_check_bottom
	INC enemy0_y
```

Comportamento della demo:

- nemici generati a ondate regolari;
- movimento verso il basso con oscillazione orizzontale;
- deallocazione automatica quando escono dall'area di gioco.

---

## ⚠️ Errori comuni

- introdurre piu sistemi insieme nella stessa lezione;
- rompere il loop principale mentre si integra una feature;
- non verificare i limiti di memoria e indirizzi usati.

---

## 🧪 Esercizi

1. Aumenta il pool nemici da 3 a 5 slot.
2. Introduci due pattern di spawn alternati in base al frame.
3. Modifica il drift orizzontale per avere un movimento a zig-zag piu marcato.

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
