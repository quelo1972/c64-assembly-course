[🏠 Home](../../../index.md)

# Lezione 038 - Screen RAM e Color RAM

> **Obiettivo:** scrivere caratteri e colori sullo schermo manipolando direttamente Screen RAM e Color RAM.

---

## 🎯 Obiettivi

- capire la differenza tra codice carattere e colore;
- usare gli indirizzi base `$0400` e `$D800`;
- riempire una porzione di schermo con un ciclo;
- allineare contenuto e attributi colore.

---

## 🧠 Introduzione

Nel C64, il testo visualizzato è composto da due aree separate:

- una memoria che contiene quale carattere mostrare;
- una memoria che contiene il colore di ogni cella.

Questa separazione è il cuore del rendering in modalita testo.

---

## 📘 Teoria

Riferimenti standard:

- `Screen RAM`: `$0400-$07E7` (1000 celle, 40x25)
- `Color RAM`: `$D800-$DBE7` (1000 celle, 4 bit colore utili)

Ogni posizione dello schermo è una coppia:

- byte in Screen RAM: codice PETSCII/screen code;
- byte in Color RAM: colore del carattere.

Esempio: posizione 0 (angolo alto sinistra)

- `$0400` = carattere
- `$D800` = colore

---

## 🤖 Come ragiona il 6510

Con un indice in `X`, la CPU puo scrivere su due aree parallele:

- `STA $0400,X` per il carattere;
- `STA $D800,X` per il colore.

Incrementando `X` (`INX`) e controllando il limite (`CPX` + `BNE`), il 6510 riempie una riga o una porzione di schermo in modo molto efficiente.

---

## 💡 Esempio pratico

```asm
; Lezione 038 - Scrittura in Screen RAM e Color RAM
*= $0801

  LDX #$00          ; X = indice posizione

fill_line:
  LDA #$01          ; screen code 1 (tipicamente 'A' nel charset standard)
  STA $0400,X       ; scrive carattere sulla prima riga

  LDA #$0E          ; colore azzurro chiaro
  STA $D800,X       ; scrive colore cella corrispondente

  INX               ; posizione successiva
  CPX #$28          ; 40 colonne decimali = $28
  BNE fill_line     ; continua finche X != 40

  RTS
```

`LDX` inizializza il contatore, `STA addr,X` usa indirizzamento assoluto indicizzato, `CPX` confronta `X` con il limite, `BNE` chiude il ciclo.

---

## ⚠️ Errori comuni

- Scrivere solo in Screen RAM e dimenticare Color RAM (testo con colore inatteso).
- Usare un limite sbagliato nel loop (es. 39 invece di 40).
- Confondere PETSCII e screen code quando scegli i caratteri.

---

## 🧪 Esercizi

1. Riempi la seconda riga (offset +40) con un altro carattere.
2. Applica un gradiente colore alternando due valori in Color RAM.

---

## 📌 Riassunto

| Concetto | Spiegazione breve |
|----------|-------------------|
| Screen RAM `$0400` | Quale carattere mostrare |
| Color RAM `$D800` | Colore per ciascuna cella |
| Loop con `X` | Metodo base per scrivere blocchi di schermo |

---

## 🔜 Preparazione alla lezione successiva

Dopo accesso diretto alla memoria video, vediamo come sfruttare le routine ROM del KERNAL per I/O piu rapido da integrare.

---

## 🔎 Approfondimento - Dentro il 6510

L'indirizzamento assoluto indicizzato (`addr,X`) evita di modificare continuamente l'operando in memoria: il calcolo dell'indirizzo effettivo avviene durante l'esecuzione dell'istruzione.

---

## ✅ Checklist finale

- [ ] l'esempio compila con `64tass`
- [ ] l'esempio e coerente con la lezione
- [ ] ogni istruzione nuova e spiegata prima dell'uso
- [ ] indice, glossario e changelog sono aggiornati
- [ ] il contenuto è semplice e progressivo
