[🏠 Home](../../../index.md)

# Lezione 062 - Modularizzazione, test e packaging

> **Obiettivo:** trasformare il prototipo in un progetto modulare, testabile e pronto alla distribuzione.

---

## 🎯 Obiettivi

- separare il codice in moduli con responsabilita chiare;
- definire test minimi di regressione;
- scegliere formato di distribuzione (PRG/D64);
- allineare build locale e release.

---

## 🧠 Introduzione

Senza modularizzazione, ogni bugfix diventa rischio sistemico. Nel progetto finale servono confini netti: input, update, render, audio, storage.

---

## 📘 Teoria

Schema modulare consigliato:

- `init.asm`
- `input.asm`
- `update.asm`
- `render.asm`
- `audio.asm`
- `main.asm` (orchestrazione)

Test minimi:

- avvio corretto;
- loop stabile;
- assenza crash su input ripetuti;
- output atteso su schermo/suono.

Packaging:

- PRG per test rapido;
- D64 per distribuzione piu "realistica".

---

## 🤖 Come ragiona il 6510

Subroutine piccole e isolate riducono side effect. Il 6510 non perdona stato implicito: ogni modulo deve sapere cosa legge e cosa scrive.

---

## 💡 Esempio pratico

```asm
; Lezione 062 - Main con moduli separati
*= $0801

start:
    JSR mod_init

main_loop:
    JSR mod_input
    JSR mod_update
    JSR mod_render
    JMP main_loop

mod_init:
    RTS

mod_input:
    RTS

mod_update:
    RTS

mod_render:
    RTS
```

`JMP` trasferisce il controllo senza salvare ritorno; nel main loop e ideale per iterazione infinita controllata.

---

## ⚠️ Errori comuni

- test solo "a vista" senza check ripetibili;
- dipendenze circolari tra moduli;
- packaging deciso troppo tardi.

---

## 🧪 Esercizi

1. Dividi il tuo codice in almeno 3 moduli reali.
2. Crea una checklist regressione da eseguire prima di ogni release.
3. Produci una build PRG e una D64 con stesso contenuto applicativo.

---

## 📌 Riassunto

| Area | Pratica |
|------|---------|
| modularita | routine a responsabilita unica |
| test | regressione breve ma ripetibile |
| packaging | PRG rapido, D64 distribuzione |

---

## 🔜 Preparazione alla lezione successiva

Nella prossima lezione prepareremo release e pubblicazione, inclusa documentazione e changelog finale.

---

## 🔎 Approfondimento - Dentro il 6510

Una buona modularizzazione riduce la complessita cognitiva: la CPU resta la stessa, ma il design determina quanto velocemente puoi iterare senza introdurre regressioni.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
