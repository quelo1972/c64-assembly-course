[🏠 Home](../../../index.md)

# Lezione 037 - Mappa I/O del C64: VIC-II, SID, CIA

> **Obiettivo:** orientarsi nella mappa I/O del C64 e accedere ai registri base di VIC-II, SID e CIA.

---

## 🎯 Obiettivi

- capire dove vivono i registri I/O nello spazio di memoria;
- distinguere VIC-II, SID, CIA1 e CIA2;
- leggere un input hardware semplice (joystick) via CIA1;
- usare il risultato per modificare un registro video.

---

## 🧠 Introduzione

Finora abbiamo lavorato soprattutto con RAM e operazioni CPU. Nel C64, pero, una parte fondamentale della memoria è mappata su periferiche hardware: quando scrivi in un certo indirizzo, non stai scrivendo in RAM, stai controllando un chip.

---

## 📘 Teoria

Intervalli I/O principali (bank standard):

- `VIC-II`: `$D000-$D3FF`
- `SID`: `$D400-$D7FF`
- `Color RAM`: `$D800-$DBFF`
- `CIA1`: `$DC00-$DCFF`
- `CIA2`: `$DD00-$DDFF`

Registri molto usati:

| Registro | Indirizzo | Uso |
|----------|-----------|-----|
| Border color | `$D020` | Colore bordo |
| Background color 0 | `$D021` | Colore sfondo |
| CIA1 Port A | `$DC00` | Joystick porta 2 |
| CIA1 Port B | `$DC01` | Tastiera/joystick |

Nel joystick i bit sono attivi a livello basso: `0` significa premuto.

---

## 🤖 Come ragiona il 6510

Quando la CPU esegue `LDA $DC00`, il bus indirizzi punta all'area CIA1 e legge lo stato del port A. Con `AND` puo filtrare un solo bit (es. direzione su). Se poi fa `STA $D020`, il valore non va in RAM ma nel registro colore bordo del VIC-II.

---

## 💡 Esempio pratico

```asm
; Lezione 037 - Lettura joystick e scrittura su border color
*= $0801

loop:
  LDA $DC00      ; legge CIA1 Port A (joystick porta 2)
  AND #%00000001 ; isola bit UP (0 = premuto)
  BNE not_up     ; se bit = 1, non premuto

  LDA #$05       ; verde
  STA $D020      ; bordo = verde
  RTS

not_up:
  LDA #$02       ; rosso
  STA $D020      ; bordo = rosso
  RTS
```

`LDA` carica il valore dal registro hardware in A. `AND` maschera i bit non necessari. `BNE` salta quando il risultato non è zero. `STA` scrive nel registro colore.

---

## ⚠️ Errori comuni

- Confondere RAM e I/O: scrivere in `$D020` non modifica una cella RAM ma il chip video.
- Dimenticare logica attiva bassa del joystick: `0` = premuto, non il contrario.
- Usare maschera bit sbagliata con `AND`.

---

## 🧪 Esercizi

1. Leggi il bit LEFT del joystick e cambia colore sfondo (`$D021`) invece del bordo.
2. Gestisci due direzioni (UP e DOWN) con due colori diversi.

---

## 📌 Riassunto

| Concetto | Spiegazione breve |
|----------|-------------------|
| I/O mapped memory | Intervallo memoria collegato a chip hardware |
| CIA1 `$DC00` | Lettura input joystick/tastiera |
| VIC-II `$D020/$D021` | Controllo colori bordo e sfondo |

---

## 🔜 Preparazione alla lezione successiva

Nella prossima lezione passiamo dalla mappa I/O alla memoria video vera e propria: screen RAM e color RAM.

---

## 🔎 Approfondimento - Dentro il 6510

Le letture/scritture su I/O usano gli stessi opcode delle letture/scritture RAM. Cambia solo il dispositivo che risponde sul bus per quell'indirizzo.

---

## ✅ Checklist finale

- [ ] l'esempio compila con `64tass`
- [ ] l'esempio e coerente con la lezione
- [ ] ogni istruzione nuova e spiegata prima dell'uso
- [ ] indice, glossario e changelog sono aggiornati
- [ ] il contenuto è semplice e progressivo
