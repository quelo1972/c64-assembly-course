[🏠 Home](../index.md)

# Appendice 008 - SID multipli su U64EII e C64U

> Obiettivo: spiegare in modo operativo e completo come funziona il paradigma multi-SID sulle board moderne (Ultimate 64 Elite II / C64U family), con strategie di coding compatibili e fallback robusti.

---

## 1) Contesto storico: da mono-SID a multi-SID

Sul C64 classico, il software scrive quasi sempre su un solo SID all'indirizzo base `$D400`.

Con board moderne FPGA (come U64EII/C64U), il concetto si estende:

- un SID principale resta mappato a `$D400`;
- uno o piu SID aggiuntivi possono essere abilitati in parallelo;
- l'uscita audio puo essere mixata o separata su canali L/R.

Risultato pratico: da 3 voci hardware si puo passare a 6 (dual SID) o oltre in alcune configurazioni.

---

## 2) Cosa cambia per il programmatore 6510

La CPU non usa nuove istruzioni: continuano a valere `LDA/STA/JSR/...`.

Cambia il modello di indirizzamento I/O audio:

- SID 1: base classica `$D400`;
- SID 2/3/4: basi alternative configurabili dalla board/firmware.

Quindi il player deve sapere "dove" scrivere i registri del secondo (o terzo) SID.

---

## 3) Address map: regola generale e indirizzi comuni

Ogni SID occupa 32 registri (offset `0..31`).

Formula generale:

- `SIDn_REG = SIDn_BASE + offset`

Esempio:

- `FREQ LO voice1` e `BASE + 0`
- `CONTROL voice1` e `BASE + 4`
- `MODE/VOLUME` e `BASE + 24`

### Indirizzi secondari comuni nel mondo stereo-SID

Nel panorama software/hardware C64 sono comuni (a seconda di board e firmware) basi come:

- `$D420`
- `$D500`
- `$DE00`
- `$DF00`

Nota importante:

- su U64EII/C64U la lista esatta dipende da firmware e configurazione menu;
- va sempre verificata nella configurazione macchina prima di fissarla nel codice.

---

## 4) Routing audio: dual mono, stereo, mix

Le board moderne permettono normalmente di:

- assegnare SID1/SID2 a L/R;
- fare mix centrato;
- scegliere modelli SID differenti per i vari slot (6581/8580 emulati).

Pattern tipici:

1. Mono compatibile: solo SID1 (legacy-safe).
2. Dual SID mirror: stessa patch su SID1+SID2 per suono piu pieno.
3. Dual SID split: voci lead su SID1, bass/pad su SID2 (stereo musicale).

---

## 5) 6581 vs 8580 in setup multi-SID

Con piu SID puoi combinare modelli diversi. Questo aumenta le possibilita timbriche ma introduce variabili:

- risposta filtri diversa;
- differenze nel comportamento digisample (`$D418` tricks);
- bilanciamento volume non identico tra modelli.

Consiglio pratico:

- definire preset separati "6581-like" e "8580-like";
- evitare hardcode unico di cutoff/resonance senza test A/B.

---

## 6) Strategia software consigliata (robusta)

Per progetti didattici/produttivi:

1. Definisci basi SID come costanti configurabili.
2. Mantieni sempre percorso fallback mono-SID.
3. Se multi-SID non e certo, usa profilo runtime selezionabile (launcher/menu).
4. Seleziona una mappa indirizzi documentata nel readme del progetto.

---

## 7) Pattern di codice: astrazione base registri

```asm
; Configurazione base (esempio)
SID1_BASE = $D400
SID2_BASE = $D420    ; esempio comune, da confermare sulla board

; Offset registri utili
SID_FREQ_LO = 0
SID_FREQ_HI = 1
SID_CTRL    = 4
SID_AD      = 5
SID_SR      = 6
SID_VOL     = 24
```

Scrittura su SID1 e SID2 (mirror patch):

```asm
; Inizializza volume su entrambi i SID
LDA #$0F
STA SID1_BASE + SID_VOL
STA SID2_BASE + SID_VOL

; Stessa frequenza su voice1
LDA #$00
STA SID1_BASE + SID_FREQ_LO
STA SID2_BASE + SID_FREQ_LO

LDA #$20
STA SID1_BASE + SID_FREQ_HI
STA SID2_BASE + SID_FREQ_HI

; ADSR
LDA #$11
STA SID1_BASE + SID_AD
STA SID2_BASE + SID_AD
LDA #$F2
STA SID1_BASE + SID_SR
STA SID2_BASE + SID_SR

; Gate on + triangle
LDA #%00010001
STA SID1_BASE + SID_CTRL
STA SID2_BASE + SID_CTRL
```

---

## 8) Pattern di codice: split musicale a 6 voci

Schema logico comune:

- SID1 voice1/2: lead + arp
- SID1 voice3: fx/noise
- SID2 voice1/2: bass + chord
- SID2 voice3: support/pad

Vantaggio:

- piu headroom compositiva rispetto al vincolo 3 voci classico.

Costo:

- scheduler note piu complesso;
- maggiore traffico su registri I/O per frame/tick.

---

## 9) Rilevazione multi-SID: cosa e realistico

Rilevare automaticamente SID aggiuntivi dal solo codice C64 non e sempre affidabile:

- molti registri SID sono write-only;
- alcune letture non permettono discriminazione forte;
- comportamenti possono dipendere dalla board/fpga core.

Approccio consigliato:

- configurazione esplicita utente (mono/dual);
- profili build o flag runtime;
- fallback automatico a mono quando il profilo non e noto.

---

## 10) Compatibilita con player legacy SID

Molto software storico e mono-SID. Su board moderne:

- puoi lasciare SID2 inattivo per compatibilita pura;
- puoi anche route/mix automatico lato board senza toccare il codice storico.

Per codice nuovo:

- non rompere il path mono;
- rendi opzionale l'estensione multi-SID.

---

## 11) Pitfall comuni

1. Hardcode di `SID2_BASE` senza documentare prerequisiti firmware.
2. Uso di filtri identici su modelli 6581/8580 diversi.
3. Assenza fallback mono e crash sonoro su hardware non configurato.
4. Clipping dovuto a mix volume troppo aggressivo su piu SID.
5. Timing jitter quando il player aggiorna troppi registri fuori IRQ stabile.

---

## 12) Checklist di progetto multi-SID

- [ ] esiste una costante configurabile per ogni base SID;
- [ ] esiste modalita mono compatibile;
- [ ] il readme indica chiaramente mappa indirizzi richiesta;
- [ ] volume/mix testati su cuffie e uscita line;
- [ ] comportamento verificato su almeno due preset (es. 6581-like, 8580-like).

---

## 13) Mini roadmap pratica per estendere un player del corso

Partendo dalla lezione 048:

1. duplica routine write-note su `SID2_BASE`;
2. inizializza anche `SID2_BASE + 24` (volume);
3. aggiungi flag `MULTI_SID_ENABLE`;
4. se flag=0 scrivi solo su SID1;
5. se flag=1 applica mirror o split pattern;
6. porta il timing su IRQ per stabilita musicale.

---

## 14) Riferimenti utili

- SID base architecture e registri classici: https://www.c64-wiki.com/wiki/SID
- Datasheet 6581/8580 (per comportamento analogico):
  - http://www.6502.org/documents/datasheets/mos/mos_6581_sid.pdf
  - http://www.6502.org/documents/datasheets/mos/mos_6582_sid.pdf

Per U64EII/C64U:

- verifica sempre nel menu di configurazione board/firmware le opzioni effettive di SID count, SID model, SID base address e audio routing, perche possono variare con release firmware.
