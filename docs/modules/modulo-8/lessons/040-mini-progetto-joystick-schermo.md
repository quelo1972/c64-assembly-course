[🏠 Home](../../../index.md)

# Lezione 040 - Mini-progetto: joystick e schermo

> **Obiettivo:** integrare lettura joystick, aggiornamento Screen RAM e feedback visivo in un loop continuo.

---

## 🎯 Obiettivi

- leggere direzioni joystick da CIA1;
- aggiornare una posizione cursore su schermo;
- separare logica input e logica rendering;
- costruire una base riusabile per giochi semplici.

---

## 🧠 Introduzione

Questa lezione chiude il modulo 8 con un mini-progetto completo: un cursore che si muove sulla prima riga in base al joystick. Useremo input hardware reale e output diretto su memoria video.

---

## 📘 Teoria

Componenti del mini-progetto:

- input: `CIA1 Port A` (`$DC00`), bit attivi bassi;
- stato: posizione cursore (`cursor_x`) in RAM;
- output: scrittura in `Screen RAM` (`$0400 + x`).

Strategia:

1. cancella vecchia posizione;
2. leggi joystick;
3. aggiorna coordinata con limiti (0..39);
4. disegna nuova posizione;
5. ripeti.

---

## 🤖 Come ragiona il 6510

Il loop principale è composto da piccole subroutine:

- `erase_cursor` e `draw_cursor` lavorano su `$0400,X`;
- `read_input` legge `$DC00` e decide incremento/decremento;
- confronti (`CPX`) e salti (`BCC/BCS`) evitano uscita dai limiti.

Questo approccio rende il programma piu leggibile e modulare.

---

## 💡 Esempio pratico

```asm
; Lezione 040 - Mini progetto joystick + schermo
*= $0801

cursor_x = $02

start:
  LDA #$00
  STA cursor_x

main_loop:
  JSR erase_cursor
  JSR read_input
  JSR draw_cursor
  JMP main_loop

erase_cursor:
  LDX cursor_x
  LDA #$20        ; spazio
  STA $0400,X
  RTS

read_input:
  LDA $DC00

  AND #%00000100  ; LEFT (0 = premuto)
  BNE check_right

  LDX cursor_x
  CPX #$00
  BEQ check_right
  DEX
  STX cursor_x

check_right:
  LDA $DC00
  AND #%00001000  ; RIGHT (0 = premuto)
  BNE done_input

  LDX cursor_x
  CPX #$27        ; 39 decimale
  BEQ done_input
  INX
  STX cursor_x

done_input:
  RTS

draw_cursor:
  LDX cursor_x
  LDA #$51        ; codice simbolo cursore (esempio)
  STA $0400,X
  LDA #$01        ; bianco
  STA $D800,X
  RTS
```

`JSR` divide il programma in blocchi logici. `AND` applica maschere ai bit joystick. `CPX` impone i limiti schermata.

---

## ⚠️ Errori comuni

- Non cancellare la posizione precedente: resta una scia di caratteri.
- Usare bit joystick errati (LEFT/RIGHT invertiti).
- Dimenticare i limiti 0..39 e uscire dalla riga.

---

## 🧪 Esercizi

1. Aggiungi supporto UP/DOWN su due righe diverse.
2. Usa un colore diverso quando il cursore e in movimento.
3. Aggiungi una piccola delay routine per rallentare il movimento.

---

## 📌 Riassunto

| Concetto | Spiegazione breve |
|----------|-------------------|
| Loop di gioco base | Input -> update -> render |
| Stato in RAM | `cursor_x` mantiene la posizione |
| I/O integrato | CIA1 per input, Screen/Color RAM per output |

---

## 🔜 Preparazione alla lezione successiva

Dal prossimo modulo andiamo oltre il testo: grafica VIC-II con sprite, raster e tecniche per animazioni.

---

## 🔎 Approfondimento - Dentro il 6510

Separare il codice in subroutine riduce la complessita cognitiva e facilita il profiling: puoi misurare cicli per blocco (`input`, `update`, `render`) e ottimizzare dove serve.

---

## ✅ Checklist finale

- [ ] l'esempio compila con `64tass`
- [ ] l'esempio e coerente con la lezione
- [ ] ogni istruzione nuova e spiegata prima dell'uso
- [ ] indice, glossario e changelog sono aggiornati
- [ ] il contenuto è semplice e progressivo
