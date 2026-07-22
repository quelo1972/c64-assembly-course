[🏠 Home](../../../index.md)

# Lezione 073 - Nemici multipli e pattern avanzati

> **Obiettivo:** gestire ondate con pattern multipli e movimento nemici differenziato.

---

## 🎯 Obiettivi

- introdurre pattern di spawn multipli basati su `wave_index`;
- differenziare il movimento dei nemici per aumentare la variabilita;
- mantenere compatibilita con collisioni, HUD e audio delle lezioni precedenti.

---

## 🧠 Introduzione

Dopo avere stabilizzato loop, input, sparo, collisioni e HUD, il passo naturale e rendere il comportamento dei nemici meno prevedibile. In questa lezione lo facciamo senza cambiare l'architettura di base.

---

## 📘 Teoria

- selezione pattern tramite `wave_index` per variare le posizioni di spawn;
- movimenti differenziati per nemico (discesa e drift con cadenze diverse);
- riuso del pool fisso per contenere complessita e costo in cicli.

---

## 🤖 Come ragiona il 6510

Con pochi registri e memoria limitata, conviene usare pattern deterministici: maschere su contatori (`AND`) e branching (`CMP`/`BEQ`) permettono variazioni credibili con costo minimo.

---

## 💡 Esempio pratico

```asm
maybe_spawn_enemy:
    LDA spawn_timer
    AND spawn_mask
    BNE spawn_done

spawn_enemy0:
    JSR init_enemy0
    INC wave_index

init_enemy0:
    LDA wave_index
    AND #$03
    CMP #$00
    BEQ enemy0_pattern_a
```

Comportamento della demo:

- gli spawn alternano pattern in base a `wave_index`;
- i nemici non condividono tutti la stessa velocita verticale/orizzontale;
- la pressione sul player cresce in modo piu organico.

---

## ⚠️ Errori comuni

- applicare pattern troppo complessi senza strumenti di debug visuale;
- perdere il controllo dei limiti X/Y durante drift veloci;
- introdurre variabili nuove senza documentare mappa e scopo.

---

## 🧪 Esercizi

1. Aggiungi un quarto pattern che inverte la direzione iniziale di tutti i nemici.
2. Introduci una mini-wave speciale ogni 10 incrementi di `wave_index`.
3. Sostituisci le soglie fisse con una tabella pattern in RAM.

---

## 📌 Riassunto

| Punto | Esito atteso |
|-------|--------------|
| pattern multipli | ondate meno prevedibili |
| movimento differenziato | maggiore pressione di gioco |
| compatibilita | nessuna regressione su sistemi precedenti |

---

## 🔜 Preparazione alla lezione successiva

- usare questi pattern come base per enemy type differenti (veloci, tank, zig-zag).

---

## 🔎 Approfondimento - Dentro il 6510

Un pattern system robusto non dipende da formule complesse: su 6510 la priorita e mantenere update brevi e prevedibili, delegando la varieta a piccoli stati e contatori.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio e coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto e semplice e progressivo;
