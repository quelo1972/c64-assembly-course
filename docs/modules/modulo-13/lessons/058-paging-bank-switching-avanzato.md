[🏠 Home](../../../index.md)

# Lezione 058 - Paging e bank switching (memory map avanzata)

> **Obiettivo:** capire come controllare visibilita ROM/I-O/RAM per sfruttare meglio lo spazio memoria del C64.

---

## 🎯 Obiettivi

- ripassare il ruolo del registro `$01` nel memory mapping;
- capire il concetto di bank switching logico sul C64;
- evitare conflitti quando si cambia mappa durante runtime;
- applicare una sequenza sicura save-switch-restore.

---

## 🧠 Introduzione

Il C64 non espone sempre la stessa mappa: alcune finestre cambiano tra RAM/ROM/I/O in base ai bit del registro di processore `$01`.

---

## 📘 Teoria

Registro `$01`:

- controlla quali aree sono visibili in certe fasce indirizzi;
- usato con cautela permette accesso a RAM sottostante o ROM di sistema.

Pattern sicuro:

1. salva valore corrente di `$01`;
2. applica nuova mappa;
3. esegui operazione breve;
4. ripristina mappa originale.

Nota istruzione:

- `PHA` salva A sullo stack, `PLA` lo ripristina: utile per preservare stato durante switch temporanei.

---

## 🤖 Come ragiona il 6510

La CPU esegue sempre indirizzi numerici, ma il contenuto dietro quegli indirizzi puo cambiare con la mappa. Quindi stesso `LDA $A000` puo leggere RAM o ROM a seconda del contesto.

---

## 💡 Esempio pratico

```asm
; Lezione 058 - Save/switch/restore del registro $01
*= $0801

PORT01 = $0001
BORDER = $D020

start:
    LDA PORT01
    PHA                 ; salva mappa attuale

    ; esempio: cambia temporaneamente bit mappa (dimostrativo)
    LDA PORT01
    AND #%11111000
    ORA #%00000101
    STA PORT01

    ; operazione protetta (placeholder)
    INC BORDER

    PLA
    STA PORT01          ; ripristina mappa originaria

loop:
    JMP loop
```

`AND` e `ORA` permettono read-modify-write su bit specifici senza distruggere l intero valore originale.

---

## ⚠️ Errori comuni

- non ripristinare `$01` e lasciare il sistema in stato incoerente;
- fare operazioni lunghe durante mappa temporanea;
- sovrascrivere bit non previsti per assenza di maschere.

---

## 🧪 Esercizi

1. Aggiungi routine che salva/restora A, X, Y oltre a `$01`.
2. Inserisci due switch distinti e verifica che la mappa finale resti corretta.
3. Documenta nel codice quali bit stai modificando e perche.

---

## 📌 Riassunto

| Passo | Scopo |
|-------|-------|
| save `$01` | preserva stato mapping |
| switch controllato | abilita operazione mirata |
| restore `$01` | stabilita del sistema |

---

## 🔜 Preparazione alla lezione successiva

Nella prossima lezione vedremo tecniche di compressione e data packing per risparmiare RAM e storage.

---

## 🔎 Approfondimento - Dentro il 6510

Il bank switching e potente ma fragile: piu e breve e locale, meno rischi introduce. La disciplina dei restore e parte integrante della correttezza.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
