[🏠 Home](../index.md)

# Appendice 004 - Mappa di confine: MOS 6510 vs 64tass

> Obiettivo: avere una mappa decisionale rapida per capire se un costrutto appartiene alla CPU o all'assembler.

---

## 1. Regola di classificazione immediata

Se il costrutto:

- produce azione a runtime sul processore, e istruzione CPU;
- modifica struttura del sorgente o emissione byte in build, e direttiva assembler.

---

## 2. Mappa pratica

| Costrutto | Categoria | Fase |
|-----------|-----------|------|
| `LDA`, `STA`, `ADC`, `JSR`, `RTS` | MOS 6510 | Runtime |
| Label (`LOOP:`) | 64tass | Assemblaggio |
| Costanti (`NAME = value`) | 64tass | Assemblaggio |
| `*= $0801` | 64tass | Assemblaggio |
| `.byte/.word/.text` | 64tass | Assemblaggio |
| `.include` | 64tass | Assemblaggio |
| `.macro/.endm` | 64tass | Assemblaggio |

---

## 3. Esempio annotato riga per riga

```asm
*= $0801              ; [64tass] posizione di assemblaggio

BORDER = $D020        ; [64tass] simbolo costante

START:                ; [64tass] label
    LDA #$00          ; [MOS 6510] opcode A9
    STA BORDER        ; [MOS 6510] opcode 8D + indirizzo risolto da 64tass
    RTS               ; [MOS 6510] opcode 60
```

Interpretazione corretta:

- 64tass risolve `BORDER` in `$D020` durante build;
- il 6510 in esecuzione vede solo byte macchina, non i nomi simbolici.

---

## 4. Domande diagnostiche (debug mentale)

Quando qualcosa non torna, chiediti:

1. Errore di sintassi/assembler o errore logico CPU?
2. Il simbolo e stato risolto correttamente?
3. L'istruzione scelta modifica i flag attesi?
4. Sto misurando un effetto di build o runtime?

---

## 5. Esempi di confusione tipica

- "La macro e lenta": in realta il costo e del codice espanso.
- "La label contiene un valore": in realta e un riferimento risolto in indirizzo.
- "`.word` esegue una conversione runtime": no, emette byte in output.

---

## 6. Checklist finale rapida

- Separazione CPU/assembler esplicitata nei materiali?
- Nuove direttive introdotte con spiegazione di fase (build vs runtime)?
- Esempi verificabili con `64tass` e osservabili in VICE?
