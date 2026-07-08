[🏠 Home](../../../index.md)

# Lezione 039 - KERNAL: chiamate ROM per I/O

> **Obiettivo:** usare le routine KERNAL per output a schermo e input da tastiera senza gestire tutto a basso livello.

---

## 🎯 Obiettivi

- capire cosa offre il KERNAL ROM;
- chiamare routine note come `CHROUT` e `GETIN`;
- passare parametri nei registri richiesti;
- integrare chiamate ROM in un programma Assembly.

---

## 🧠 Introduzione

Non sempre conviene parlare direttamente con ogni registro hardware. Il C64 mette a disposizione routine KERNAL in ROM: funzioni gia pronte per input/output, gestione dispositivi e utility di sistema.

---

## 📘 Teoria

Routine KERNAL molto usate:

| Routine | Indirizzo | Uso |
|---------|-----------|-----|
| `CHROUT` | `$FFD2` | Stampa il carattere in A |
| `GETIN` | `$FFE4` | Legge un carattere da input (A=0 se nessuno) |
| `CHRIN` | `$FFCF` | Legge da canale input corrente |

Regola base: prima della `JSR`, devi mettere i parametri nel registro corretto (spesso `A`). Dopo il ritorno (`RTS` interno alla routine KERNAL), leggi il risultato dai registri documentati.

---

## 🤖 Come ragiona il 6510

Con `JSR $FFD2`:

1. la CPU salva il return address sullo stack;
2. salta alla routine ROM;
3. la routine usa A come carattere da stampare;
4. al termine esegue `RTS` e la CPU riprende dal chiamante.

Lo stesso schema vale per `GETIN`, che restituisce il dato in `A`.

---

## 💡 Esempio pratico

```asm
; Lezione 039 - Uso base di CHROUT e GETIN
*= $0801

start:
  LDA #'A'         ; carica il carattere ASCII/PETSCII da stampare
  JSR $FFD2        ; CHROUT: stampa A sullo schermo

wait_key:
  JSR $FFE4        ; GETIN: A = tasto, oppure 0 se nessun tasto
  CMP #$00         ; verifica se e arrivato input
  BEQ wait_key     ; se A=0 continua ad aspettare

  JSR $FFD2        ; stampa il tasto premuto
  JMP wait_key
```

`JSR` chiama la routine ROM, `CMP #$00` testa presenza input, `BEQ` mantiene il polling finche non arriva un carattere.

---

## ⚠️ Errori comuni

- Chiamare `CHROUT` senza caricare `A`.
- Aspettarsi input bloccante da `GETIN` (non blocca, ritorna 0 se vuoto).
- Dimenticare che alcune routine possono modificare registri non preservati.

---

## 🧪 Esercizi

1. Stampa una stringa corta carattere per carattere usando `CHROUT`.
2. Leggi due tasti consecutivi con `GETIN` e visualizzali su schermo.

---

## 📌 Riassunto

| Concetto | Spiegazione breve |
|----------|-------------------|
| KERNAL ROM | Libreria di routine di sistema gia disponibili |
| `CHROUT` `$FFD2` | Output di un carattere in A |
| `GETIN` `$FFE4` | Input non bloccante da tastiera |

---

## 🔜 Preparazione alla lezione successiva

Mettiamo insieme I/O hardware e memoria video in un mini-progetto: lettura joystick e aggiornamento dello schermo in tempo reale.

---

## 🔎 Approfondimento - Dentro il 6510

Le chiamate KERNAL semplificano il codice ma aggiungono overhead rispetto all'accesso diretto ai registri hardware. Nel tempo reale spinto, spesso si preferisce il controllo diretto.

---

## ✅ Checklist finale

- [ ] l'esempio compila con `64tass`
- [ ] l'esempio e coerente con la lezione
- [ ] ogni istruzione nuova e spiegata prima dell'uso
- [ ] indice, glossario e changelog sono aggiornati
- [ ] il contenuto e semplice e progressivo
