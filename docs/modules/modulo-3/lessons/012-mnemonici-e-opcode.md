[🏠 Home](../../../index.md)

# Lezione 035 — Mnemonici e opcode

> **Obiettivo:** capire la relazione tra mnemonici (LDA, STA, etc.) e opcode (hex), e come l'assembler li traduce.

---

## 🎯 Obiettivi

- comprendere cosa sono mnemonici e opcode;
- memorizzare i principali opcode del 6510;
- capire come 64tass traduce mnemonici in opcode;
- leggere e interpretare codice macchina grezzo.

---

## 🧠 Introduzione

Scrivere Assembly significa scrivere **mnemonici** umani:

```asm
LDA #$50       ; carica 0x50 in A
STA $D020      ; scrivi A in 0xD020
```

Ma la CPU esegue solo **opcode numerici**:

```
$A9 $50        ; opcode per LDA immediato, dato 0x50
$8D $20 $D0    ; opcode per STA assoluto, indirizzo 0xD020
```

L'**assembler** (64tass) traduce automaticamente i mnemonici in opcode.

---

## 📘 Teoria

### Mnemonici

Sono abbreviazioni di comandi inglesi:

- `LDA`: Load Accumulator
- `STA`: Store Accumulator
- `ADC`: Add with Carry
- `ASL`: Arithmetic Shift Left
- etc.

Ogni mnemonico può avere **multiple forme** (immediate, zero page, assoluto, etc.) con opcode diversi.

### Opcode (1 byte = 0–255)

Identifica l'istruzione:

```
$A9 = LDA immediato
$A5 = LDA zero page
$AD = LDA assoluto
$B5 = LDA zero page, X
$BD = LDA assoluto, X
```

Lo stesso mnemonico con modalità diversa = opcode diverso.

### Tabella di traduzione

| Mnemonico | Immediato | Zero Page | Assoluto | ZP,X | Abs,X |
|-----------|-----------|-----------|----------|------|-------|
| LDA | `$A9` | `$A5` | `$AD` | `$B5` | `$BD` |
| LDX | `$A2` | `$A6` | `$AE` | — | `$BE` |
| LDY | `$A0` | `$A4` | `$AC` | `$B4` | `$BC` |
| STA | — | `$85` | `$8D` | `$95` | `$9D` |
| ADC | `$69` | `$65` | `$6D` | `$75` | `$7D` |

---

## 🤖 Come ragiona 64tass

### Parsing

```asm
LDA #$50
```

1. **Riconoscimento**: mnemonic = `LDA`
2. **Parsing operando**: `#$50` = immediato
3. **Lookup tabella**: LDA immediato = `$A9`
4. **Output**: `$A9 $50` (2 byte)

### Validazione

Se scrivi:

```asm
LDX $D020,Y
```

64tass controlla:
- LDX supporta questa modalità? No → **Errore**

### Assembly a mano (raramente necessario)

Per debug, puoi leggere l'opcode grezzo:

```
.hex A9 50    ; LDA #$50
.hex 8D 20 D0 ; STA $D020
.hex 60       ; RTS
```

---

## 💡 Esempio pratico

```asm
; Lezione 027 — Mnemonici e opcode
; Caricamento e scrittura tramite mnemonici
*= $0801

; Mnemonico: LDA #$0B
; Tradotto a: $A9 $0B
LDA #$0B       ; opcode A9, dato 0B

; Mnemonico: STA $D020
; Tradotto a: $8D $20 $D0
STA $D020      ; opcode 8D, indirizzo D020

; Mnemonico: RTS
; Tradotto a: $60
RTS            ; opcode 60
```

Compila e guarda il binario:

```bash
64tass --cbm-prg -o bin/027.prg src/modulo-3/027.asm
hexdump -C bin/027.prg
```

Vedi:
```
00000000: 01 08 a9 0b 8d 20 d0 60
```

Decode:
- `01 08`: indirizzo di caricamento = `$0801`
- `a9 0b`: opcode `A9`, dato `0B` = `LDA #$0B`
- `8d 20 d0`: opcode `8D`, indirizzo `$D020` = `STA $D020`
- `60`: opcode `60` = `RTS`

---

## ⚠️ Errori comuni

- **Confondere immediato con zero page**: `#$50` (immediato) → `$50` (zero page) hanno opcode diversi
- **Assumere portabilità**: alcuni mnemonici non supportano tutte le modalità
- **Leggere opcode in big-endian**: il C64 è little-endian, indirizzo basso prima, alto dopo
- **Dimenticare che l'assembler sceglie**: se scrivi `LDA $50`, 64tass sceglie automaticamente ZP; se scrivi `LDA $0050`, sceglie Absolute

---

## 🧪 Esercizi

1. Scrivi un programma con 5 mnemonici diversi e hexdump per vedere gli opcode
2. Converti manualmente un mnemonico in opcode usando la tabella
3. Modifica un .prg esistente manualmente cambiando gli opcode e vedi cosa succede

---

## 📌 Riassunto

| Concetto | Spiegazione |
|----------|-------------|
| Mnemonico | Abbreviazione umana del comando (LDA, STA, etc.) |
| Opcode | Valore numerico che la CPU esegue |
| Assembler | Traduce mnemonici → opcode |
| Immediato | Opcode diverso da Zero Page |
| Modalità | Cambia l'opcode anche se mnemonico uguale |

---

## 🔜 Preparazione alla lezione successiva

Nella lezione 028 vedremo come l'assembler usa **direttive** per controllare assembly, etichette per nomi simbolici e costanti.

---

## 🔎 Approfondimento — Dentro 64tass

64tass ha una **tabella opcode completa** per il 6510. Se usi un mnemonico/modalità non supportata, 64tass dà un errore invece di assemblare codice errato.

Puoi anche forzare modalità:

```asm
LDA $50      ; 64tass sceglie ZP automaticamente
LDA a $50    ; force accumulator mode
LDA z $50    ; force zero page
LDA l $50    ; force long address
```

---

## ✅ Checklist finale

- [ ] l'esempio compila con `64tass`
- [ ] Conosci almeno 10 opcode comuni
- [ ] Puoi hexdump un file .prg e riconoscere gli opcode
- [ ] Il contenuto è progressivo rispetto alle lezioni precedenti
