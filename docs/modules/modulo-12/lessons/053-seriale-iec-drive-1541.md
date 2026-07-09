[🏠 Home](../../../index.md)

# Lezione 053 - Comunicazione seriale IEC e drive 1541

> **Obiettivo:** comprendere la comunicazione base tra C64 e drive 1541 tramite bus seriale IEC.

---

## 🎯 Obiettivi

- capire il ruolo del bus IEC nel trasferimento dati;
- distinguere device number, command channel e data channel;
- riconoscere il flusso base OPEN -> scambio dati/comandi -> CLOSE;
- introdurre i limiti prestazionali del protocollo seriale standard.

---

## 🧠 Introduzione

Il drive 1541 è una periferica intelligente con propria CPU. Il C64 comunica con il drive via bus seriale IEC, non come semplice RAM esterna.

Per questo le operazioni su file sono uno scambio di comandi e dati, non una lettura diretta del disco settore per settore.

---

## 📘 Teoria

Elementi chiave:

- **Device number**: tipicamente 8 per il drive principale;
- **Command channel**: canale logico per comandi (es. apertura file, status);
- **Data channel**: canale usato per leggere/scrivere byte del file.

Pattern operativo semplificato:

1. aprire canale e indirizzare device;
2. inviare comando o richiesta dati;
3. leggere/scrivere stream;
4. chiudere canale.

Prestazioni:

- il seriale standard del C64 è relativamente lento;
- la robustezza del protocollo è prioritaria rispetto alla velocita;
- accelerazioni (fastloader) esistono, ma vanno considerate extra rispetto al percorso base.

---

## 🤖 Come ragiona il 6510

Il 6510 non "vede" il disco direttamente: richiama routine KERNAL che orchestrano il dialogo IEC con il 1541. La CPU coordina, il drive esegue comandi sul supporto.

---

## 💡 Esempio pratico

```asm
; Lezione 053 - Apertura logica del canale verso device 8 (dimostrativo)
*= $0801

SETLFS = $FFBA
SETNAM = $FFBD
OPEN   = $FFC0
CLOSE  = $FFC3
CLRCHN = $FFCC

start:
    ; Nome file "TEST"
    LDA #$04
    LDX #<filename
    LDY #>filename
    JSR SETNAM

    ; LFN=1, device=8, SA=2
    LDA #$01
    LDX #$08
    LDY #$02
    JSR SETLFS

    ; OPEN channel
    JSR OPEN

    ; cleanup canali
    LDA #$01
    JSR CLOSE
    JSR CLRCHN

loop:
    JMP loop

filename:
    .text "TEST"
```

`JSR` chiama una routine ROM KERNAL. `SETLFS` imposta file number logico, device e secondary address.

---

## ⚠️ Errori comuni

- confondere numero file logico con device number;
- dimenticare `CLOSE`, lasciando canali aperti;
- usare secondary address casuali senza convenzione.

---

## 🧪 Esercizi

1. Cambia device da 8 a 9 e verifica il comportamento in VICE.
2. Prova nomi file diversi e controlla errori di apertura.
3. Inserisci gestione minima errore leggendo status channel (concettuale).

---

## 📌 Riassunto

| Concetto | Funzione |
|----------|----------|
| Device number | identifica la periferica IEC |
| LFN/SA | identificano canale e modalita |
| OPEN/CLOSE | ciclo di vita della connessione logica |

---

## 🔜 Preparazione alla lezione successiva

Nella prossima lezione useremo le routine KERNAL principali per I/O su disco e nastro in modo piu strutturato.

---

## 🔎 Approfondimento - Dentro il 6510

Il modello "CPU locale + periferica intelligente" del C64 anticipa pattern moderni: la CPU centrale delega operazioni specializzate a dispositivi con logica propria.

---

## ✅ Checklist finale

- [ ] l'esempio compila con 64tass;
- [ ] l'esempio è coerente con la lezione;
- [ ] indice, glossario e changelog sono aggiornati;
- [ ] il contenuto è semplice e progressivo.
