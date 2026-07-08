[🏠 Home](../../../index.md)

# Lezione 063 - Release e pubblicazione del progetto

> **Obiettivo:** preparare una release completa e ripetibile: binari, documentazione, changelog e pubblicazione sito.

---

## 🎯 Obiettivi

- definire artefatti finali da distribuire;
- creare una procedura release ripetibile;
- validare coerenza tra repository e sito;
- pubblicare con criteri minimi di qualita.

---

## 🧠 Introduzione

Una release e un prodotto, non solo un commit. Deve essere ripetibile, documentata e verificabile da terzi.

---

## 📘 Teoria

Checklist release consigliata:

1. quality check globale;
2. build artefatti (PRG/D64 se previsti);
3. aggiornamento `CHANGELOG.md`;
4. commit e push;
5. deploy sito su `gh-pages`.

Artefatti minimi:

- codice sorgente aggiornato;
- documentazione moduli/lezioni;
- note di rilascio sintetiche.

---

## 🤖 Come ragiona il 6510

La CPU non sa nulla di versioning, ma il progetto si: garantire coerenza tra codice, documentazione e build evita bug "di processo" che sul C64 diventano costosi da diagnosticare.

---

## 💡 Esempio pratico

```asm
; Lezione 063 - Build marker semplice
*= $0801

SCREEN = $0400

start:
    LDA #'R'
    STA SCREEN
    LDA #'1'
    STA SCREEN+1
    LDA #'0'
    STA SCREEN+2

loop:
    JMP loop
```

Usare un build marker aiuta a distinguere rapidamente versioni diverse in test manuali.

---

## ⚠️ Errori comuni

- pubblicare senza quality check finale;
- aggiornare docs ma non changelog;
- deployare da stato locale non allineato a main.

---

## 🧪 Esercizi

1. Definisci una checklist release in 8 passi massimo.
2. Inserisci un build marker visivo nel tuo progetto.
3. Simula una "release dry-run" senza deploy e verifica tutti gli output.

---

## 📌 Riassunto

| Passo | Risultato |
|-------|-----------|
| quality check | riduzione regressioni |
| release artifacts | distribuzione coerente |
| deploy | documentazione live aggiornata |

---

## 🔜 Preparazione alla lezione successiva

Nell ultima lezione chiuderemo il corso con il progetto finale completo e una retrospettiva tecnica.

---

## 🔎 Approfondimento - Dentro il 6510

La qualita finale nasce dalla ripetibilita: stessi input, stessa pipeline, stesso risultato. Questo principio vale per codice e per processi di pubblicazione.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
