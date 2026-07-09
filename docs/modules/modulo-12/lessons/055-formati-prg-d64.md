[🏠 Home](../../../index.md)

# Lezione 055 - Formati PRG e D64

> **Obiettivo:** capire struttura e uso pratico dei formati PRG e D64 nel flusso di sviluppo C64.

---

## 🎯 Obiettivi

- distinguere PRG da immagine disco D64;
- interpretare i primi byte di un file PRG;
- capire quando usare solo PRG è quando usare D64;
- preparare un flusso di test robusto in emulatore.

---

## 🧠 Introduzione

Nel corso usiamo spesso PRG per velocita. Ma nel mondo reale C64 e comune distribuire anche immagini D64, soprattutto per software complesso o multi-file.

---

## 📘 Teoria

### PRG

- file binario con i primi 2 byte = load address little-endian;
- segue il payload da copiare in RAM;
- rapido da compilare/testare.

### D64

- immagine di un floppy 1541;
- contiene directory, blocchi e file come su disco reale;
- ideale per test di flussi disco realistici.

Scelta pratica:

- prototipo rapido: PRG;
- test workflow disco/menu/loaders: D64.

---

## 🤖 Come ragiona il 6510

Per la CPU cambia poco: riceve byte in memoria secondo un indirizzo di load. Il formato esterno determina il percorso di trasporto, non la semantica finale delle istruzioni in RAM.

---

## 💡 Esempio pratico

```asm
; Lezione 055 - Stub PRG semplice
*= $0801

SCREEN = $0400
COLOR  = $D800

start:
    LDA #$48          ; 'H'
    STA SCREEN
    LDA #$01
    STA COLOR

loop:
    JMP loop
```

Se compilato in PRG con `--cbm-prg`, i primi 2 byte del file rappresentano l'indirizzo di caricamento.

---

## ⚠️ Errori comuni

- pensare che PRG contenga metadata ricchi come un container moderno;
- confondere D64 con singolo file eseguibile;
- ignorare il load address e sovrascrivere aree non previste.

---

## 🧪 Esercizi

1. Compila un PRG e ispeziona i primi due byte in esadecimale.
2. Crea una D64 in VICE e copia un PRG dentro l'immagine.
3. Confronta tempi e praticita tra avvio PRG diretto e load da D64.

---

## 📌 Riassunto

| Formato | Uso principale |
|---------|----------------|
| PRG | sviluppo/test rapido |
| D64 | test distribuzione realistica |

---

## 🔜 Preparazione alla lezione successiva

Nel mini-progetto useremo queste nozioni per salvare e ricaricare dati in modo semplice e verificabile.

---

## 🔎 Approfondimento - Dentro il 6510

Comprendere il confine tra "formato file" e "stato memoria" evita molti errori: il 6510 esegue sempre codice in RAM, indipendentemente dal percorso con cui quei byte sono arrivati.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
