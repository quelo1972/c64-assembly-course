[🏠 Home](../../../index.md)

# Lezione 027 — Subroutine: JSR e RTS

> **Obiettivo:** capire come organizzare il codice in subroutine chiamabili, usare JSR per saltare, RTS per rientrare, e sfruttare lo stack per salvare l'indirizzo di ritorno.

---

## 🎯 Obiettivi

- comprendere cosa sono le subroutine e perché sono utili;
- usare JSR per chiamare una subroutine;
- usare RTS per rientrare al chiamante;
- capire come lo stack salva l'indirizzo di ritorno;
- preservare i registri quando necessario.

---

## 🧠 Introduzione

Finora abbiamo scritto programmi lineari: fetch → decode → execute → RTS.

Ma spesso vogliamo **riutilizzare codice**. Se devo stampare molti messaggi, voglio una funzione unica, non copiarla ogni volta.

**JSR** (Jump to SubRoutine) chiama una subroutine.
**RTS** (ReTurn from Subroutine) rientra.

Lo **stack** (in memoria `$0100`–`$01FF`) salva automaticamente l'indirizzo di ritorno.

---

## 📘 Teoria

### JSR e RTS

```asm
main:
  JSR print_msg  ; salta a print_msg, salva PC sullo stack
  ; il codice di print_msg esegue
  ; ... quando incontra RTS, lo stack è usato per rientrare qui
  RTS

print_msg:
  ; codice della subroutine
  RTS            ; ritorna al chiamante
```

### Lo Stack

Il 6510 ha uno **Stack Pointer** (SP, in `$0100` | SP):

```
$01FF          top dello stack
$01FE
...
$0100          bottom dello stack
SP             punta al prossimo slot libero
```

**JSR** fa un PUSH dell'indirizzo (PC - 1) sullo stack.
**RTS** fa un POP dell'indirizzo e salta.

### Preservare registri

Se una subroutine usa X, Y, A, potrebbe danneggiare il codice del chiamante:

```asm
main:
  LDX #$10
  JSR delay      ; delay modifica X!
  ; X è stato cambiato — problema!
```

Soluzione: usare lo stack per salvare registri:

```asm
delay:
  PHA            ; salva A sullo stack
  ; lavora con A
  PLA            ; ripristina A
  RTS
```

### Passing dei parametri

I parametri passati a una subroutine di solito vanno in registri:

```asm
; Chiama una subroutine che stampa il valore in A
LDA #$41       ; 'A'
JSR print_char

print_char:
  ; usa A per stampare
  RTS
```

Oppure in Zero Page:

```asm
STA $02        ; parametro in $02
JSR myfunc

myfunc:
  LDA $02
  ; lavora
  RTS
```

---

## 🤖 Come ragiona il 6510

`JSR print_msg` quando PC = `$0803`:

1. **Fetch JSR**: legge opcode `$20`
2. **Fetch indirizzo**: legge `$08` e `$09` (indirizzo subroutine)
3. **Stack operations**: 
   - Salva byte alto di (PC - 1) sullo stack
   - Salva byte basso di (PC - 1) sullo stack
   - Decrementa SP di 2
4. **Jump**: PC = `$0809` (indirizzo subroutine)

Quando RTS:
1. **Stack operations**:
   - Incrementa SP di 2
   - Legge byte basso dallo stack
   - Legge byte alto dallo stack
2. **Jump**: PC = indirizzo salvato + 1

In totale: **JSR 3 byte, 6 cicli; RTS 1 byte, 6 cicli**.

---

## 💡 Esempio pratico

```asm
; Lezione 016 — Subroutine: JSR e RTS
; Chiama una subroutine per stampare caratteri
*= $0801

; Nota: JSR indirizzo salta a una subroutine, salva PC sullo stack.
; Nota: RTS rientra al chiamante usando lo stack.
; Nota: PHA salva A sullo stack; PLA ripristina.

main:
  LDA #$42       ; 'B'
  JSR print_char
  
  LDA #$05       ; colore verde
  JSR set_border
  
  RTS            ; fine programma

; Subroutine: stampa il carattere in A
print_char:
  PHA            ; salva A
  STA $0400      ; scrivi nella screen RAM
  PLA            ; ripristina A
  RTS

; Subroutine: setta il colore bordo (A contiene il colore)
set_border:
  PHA
  STA $D020      ; scrivi nel registro VIC-II
  PLA
  RTS
```

Compila:

```bash
64tass --cbm-prg -o bin/016.prg src/modulo-6/016.asm
```

---

## ⚠️ Errori comuni

- **Dimenticare RTS**: se una subroutine non termina con RTS, il flusso continua nel codice seguente (bug).
- **Non preservare registri**: se una subroutine modifica A, X, Y senza salvarli, il codice chiamante si rompe silenziosamente.
- **Overflow dello stack**: troppe chiamate annidate o troppe PUSH senza POP fanno sovrascrivere la stack area. Rare, ma possibili.
- **JSR a indirizzi calcolati**: JSR non usa modalità indicizzate. Per salti calcolati usi JMP $0400,X (lezione successiva).

---

## 🧪 Esercizi

1. Scrivi una subroutine che azzera 10 byte da un indirizzo base.
2. Crea due subroutine: una che setta il bordo a un colore, una che setta lo sfondo. Chiamale dal main.
3. Scrivi una subroutine di delay che riceve il numero di iterazioni in A.

---

## 📌 Riassunto

| Concetto           | Spiegazione                                   |
|--------------------|-----------------------------------------------|
| JSR                | Jump to SubRoutine; salva PC sullo stack      |
| RTS                | ReTurn from Subroutine; usa PC dallo stack    |
| Stack              | Area di memoria `$0100`–`$01FF`               |
| SP                 | Stack Pointer; punta al prossimo slot libero  |
| PHA / PLA          | Push/Pop accumulatore                         |
| Preservazione      | Salva registri modificati prima di usarli     |

---

## 🔜 Preparazione alla lezione successiva

Nella lezione 017 vedremo altri salti: **JMP** (salto incondizionato) e **BRK** (breakpoint), oltre a modalità di indirizzamento indirette per subroutine calcolate.

---

## 🔎 Approfondimento — Dentro il 6510

**JSR** salva PC - 1 (l'indirizzo dell'ultimo byte di JSR):

```
PC = $0803, JSR at $0803–$0805
JSR salva PC - 1 = $0804 (byte alto + byte basso)
```

Quando **RTS** legge dal stack, aggiunge 1: ritorna a `$0804 + 1 = $0805`.

Questo è cruciale per evitare salti infiniti.

---

## ✅ Checklist finale

- [ ] l'esempio compila con `64tass`
- [ ] le subroutine vengono richiamate e rientrano correttamente
- [ ] i registri sono preservati quando necessario
- [ ] il contenuto è progressivo rispetto alle lezioni precedenti
