[🏠 Home](../../../index.md)

# Lezione 066 - Player input e movimento

> **Obiettivo:** gestire joystick, movimento player e limiti schermo.

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

- joystick porta 2 su `$DC00` con segnali attivi bassi (0 = premuto);
- limiti schermo applicati su coordinate logiche `player_x/player_y`;
- rendering in text mode: cancella posizione precedente e disegna la nuova.

---

## 🤖 Come ragiona il 6510

Il 6510 premia routine brevi e stato esplicito: separare input, update, render e audio riduce regressioni e facilita il debug.

---

## 💡 Esempio pratico

```asm
; LEFT / RIGHT attivi bassi (bit 2 e 3)
LDA JOYSTICK_PORT2
AND #%00000100
BNE check_right

LDA player_x
CMP #MIN_X
BEQ check_right
DEC player_x

check_right:
LDA JOYSTICK_PORT2
AND #%00001000
BNE check_up

LDA player_x
CMP #MAX_X
BEQ check_up
INC player_x
```

Comportamento della demo:

- FIRE in `TITLE` avvia `PLAYING`;
- in `PLAYING` il player si muove in 4 direzioni con limiti;
- il marker viene cancellato e ridisegnato a ogni tick;
- FIRE in `GAME_OVER` (stato riservato alle lezioni successive) riporta a `TITLE`.

---

## ⚠️ Errori comuni

- introdurre piu sistemi insieme nella stessa lezione;
- rompere il loop principale mentre si integra una feature;
- non verificare i limiti di memoria e indirizzi usati.

---

## 🧪 Esercizi

1. Riduci l'area di movimento (es. finestra centrale) modificando solo i limiti.
2. Aggiungi una velocita' a 2 livelli (normale e rapida) con una cadenza a frame.
3. Sostituisci il marker testuale con sprite hardware mantenendo la stessa logica di input.

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
