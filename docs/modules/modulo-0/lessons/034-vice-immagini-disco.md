[🏠 Home](../../../index.md)

# Lezione 034 — VICE: configurazione e immagini disco

> **Obiettivo:** configurare VICE completamente e lavorare con immagini disco D64 per il C64.

---

## 🎯 Obiettivi

- comprendere la struttura di VICE e i suoi strumenti;
- configurare VICE per Assembly development;
- creare e gestire immagini disco D64;
- salvare/caricare programmi da disco;
- debuggare con monitor e breakpoint.

---

## 🧠 Introduzione

**VICE** (Versatile Commodore Emulator) emula il C64 completo: CPU, RAM, ROM, chip grafici (VIC-II), audio (SID).

Per Assembly, usiamo VICE per:

1. **Testing**: eseguire programmi compilati
2. **Debugging**: monitor, breakpoint, disassembly
3. **Disco**: creare immagini D64 e salvare programmi

---

## 📘 Teoria

### Struttura VICE

```
x64 (emulatore C64)
├── CPU 6510
├── RAM 64KB
├── ROM (KERNAL, BASIC, charset)
├── VIC-II (grafica)
├── SID (audio)
├── CIA (input/timer)
└── Drive 1541 (opzionale)
```

### Immagini disco D64

File `.d64` = immagine completa di un disco 3.5" Commodore:

```
Header (label, ID)
Track 1-35:
  └─ Sector 0-20: 256 byte ciascuno
Directory track: catalogo file
BAM: bitmap allocazione
```

### Monitor VICE

Debugger integrato di VICE:

```
monitors> g 0801          ; Go to address 0x0801
monitors> l 0801 0810     ; List memory 0x0801-0x0810
monitors> d 0801 0810     ; Disassemble 0x0801-0x0810
monitors> n                ; Next istruzione (step)
monitors> c                ; Continue
monitors> b 0801          ; Breakpoint at 0x0801
```

---

## 🤖 Come ragiona VICE

### Boot process

1. **ROM load**: VIC-II, SID, CPU dal file ROM
2. **Memoria inizializzazione**: KERNAL setup
3. **BASIC prompt**: display "READY"
4. **Program load**: carica `.prg` in memoria
5. **Esecuzione**: CPU esegue da indirizzo di caricamento

### Immagine D64

Settore 0 del drive 1541 (disco reale):

```
Byte 0-1: Checksum
Byte 2-17: Disk label
Byte 18-21: Creation date
... (track/sector info)
```

VICE crea/legge questi settori per salvare file PRG.

---

## 💡 Esempio pratico

### Configura VICE per development

```bash
# Apri VICE e vai a Settings
x64

# Settings → VIC-II → Full window
# Settings → Sound → Enable
# Settings → Monitor → Enable at port 6510

# Salva configurazione
Settings → Save settings on exit (checkbox)
```

### Crea e usa immagine D64

```bash
# Crea immagine disco vuota
c1541 -format "MYCODE,ID" d64 mycode.d64

# Copia un PRG in disco
c1541 -attach mycode.d64 -write hello.prg hello.prg,p

# Verifica contenuto
c1541 -attach mycode.d64 -list

# Avvia VICE con disco
x64 -8 mycode.d64
```

Poi in VICE BASIC:

```basic
LOAD "HELLO.PRG",8,1
RUN
```

### Monitor debugging

```bash
# Avvia VICE con monitor
x64 -monitorlist
# -> monitor: VICE monitor activated

# Nel monitor:
monitor> b 0801          ; Breakpoint
monitor> c                ; Continue (esegui fino breakpoint)
monitor> d 0801 0810     ; Disassembly
monitor> l 0801 0810     ; List memoria
monitor> n                ; Next step
monitor> q                ; Quit
```

---

## ⚠️ Errori comuni

- **D64 corrotto**: ri-crea usando c1541 se il caricamento fallisce
- **Monitor non attivo**: abilita in Settings → Monitor
- **ROM mancanti**: VICE ha bisogno di file ROM (kernal.901227-03.bin, etc.)
- **Permessi disco**: assicura che il file D64 è scrivibile
- **Accesso drive remoto**: 1541 emulato potrebbe avere latenza

---

## 🧪 Esercizi

1. Crea un'immagine D64 vuota
2. Scrivi un programma Assembly, compilalo e caricalo nel disco
3. Carica in VICE e esegui
4. Abilita monitor, setta breakpoint, step through il programma

---

## 📌 Riassunto

| Concetto | Uso |
|----------|-----|
| x64 | Emulatore C64 |
| D64 | Immagine disco |
| Monitor | Debugger VICE |
| c1541 | Tool per gestire disco |
| Breakpoint | Ferma esecuzione |

---

## 🔜 Preparazione alla lezione successiva

Nella lezione 035 vedremo automazione con Makefile e task.

---

## 🔎 Approfondimento — Dentro VICE

**Monitor avanzato:**

```
monitor> e 0801 = 0xA9 0x0B   ; Scrivi byte in memoria
monitor> b 0801 if A=0x0B     ; Breakpoint condizionale
monitor> trace                 ; Abilita trace (molto lento)
```

**Snapshot:**

```
File → Save snapshot: salva stato completo VICE
File → Restore snapshot: ripristina
```

---

## ✅ Checklist finale

- [ ] VICE funziona
- [ ] ROM file trovati
- [ ] Monitor debugger abile
- [ ] D64 creato e testato
- [ ] PRG caricabile da disco
