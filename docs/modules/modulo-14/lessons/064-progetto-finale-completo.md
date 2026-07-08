[🏠 Home](../../../index.md)

# Lezione 064 - Progetto finale completo

> **Obiettivo:** consolidare il percorso del corso consegnando un progetto completo, stabile e presentabile.

---

## 🎯 Obiettivi

- integrare input, logica, grafica/audio in un unico progetto;
- validare stabilita con test finali;
- preparare materiale di presentazione;
- chiudere il corso con una release concreta.

---

## 🧠 Introduzione

Questa lezione e il traguardo: un progetto funzionante che dimostra competenze su CPU 6510, memoria, I/O, grafica, audio e processo di rilascio.

---

## 📘 Teoria

Consegna finale consigliata:

- codice modulare leggibile;
- eseguibile PRG (e D64 opzionale);
- documentazione minima di uso;
- changelog aggiornato.

Criteri di accettazione:

1. avvio corretto;
2. loop stabile;
3. interazione prevista funzionante;
4. nessun crash nei percorsi principali;
5. release pubblicata e verificabile.

---

## 🤖 Come ragiona il 6510

Nel progetto completo il 6510 esegue un ciclo continuo orchestrando moduli specializzati. La chiave e mantenere stato coerente tra frame/tick e separare responsabilita.

---

## 💡 Esempio pratico

```asm
; Lezione 064 - Skeleton finale integrato
*= $0801

BORDER = $D020

start:
    JSR init

main_loop:
    JSR input_step
    JSR update_step
    JSR render_step
    JSR audio_step
    JMP main_loop

init:
    LDA #$00
    STA BORDER
    RTS

input_step:
    RTS

update_step:
    RTS

render_step:
    INC BORDER
    RTS

audio_step:
    RTS
```

`INC` aggiorna una cella memoria in-place: qui usato come feedback visivo minimo che il loop e vivo.

---

## ⚠️ Errori comuni

- voler aggiungere feature dopo il freeze della release;
- non separare bugfix da nuove feature;
- trascurare test finale su build "pulita".

---

## 🧪 Esercizi

1. Definisci una "release candidate" e testala con checklist completa.
2. Registra i bug trovati e classificali (bloccante/non bloccante).
3. Pubblica una release finale con note concise.

---

## 📌 Riassunto

| Output finale | Stato atteso |
|---------------|--------------|
| codice | modulare e stabile |
| build | ripetibile |
| docs | aggiornate |
| release | pubblicata |

---

## 🔜 Preparazione alla lezione successiva

Il corso e completato. Da qui puoi iterare sul progetto con cicli brevi: feature, quality check, release.

---

## 🔎 Approfondimento - Dentro il 6510

Chiudere un progetto e una competenza tecnica: decidere cosa non aggiungere e importante quanto decidere cosa implementare.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
