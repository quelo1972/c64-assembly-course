[🏠 Home](../index.md)

# Appendice 001 - Regole sintattiche del 64tass

> Obiettivo: definire in modo operativo la sintassi base di 64tass e separarla dalla semantica della CPU MOS 6510.

---

## 1. Principio fondamentale

- Il MOS 6510 esegue **opcode** in linguaggio macchina.
- 64tass legge **testo Assembly** e lo trasforma in byte.

Quindi:

- `LDA #$01` descrive una istruzione CPU (diventera opcode + operando).
- `VALUE = $10` e `.byte $01` sono costrutti dell'assembler, non istruzioni CPU.

---

## 2. Struttura di una riga

Forma tipica:

```asm
[label]   [istruzione_o_direttiva]   [operandi]   ; commento
```

Esempi:

```asm
START:    LDA #$01          ; istruzione CPU
VALUE =   $10               ; costante assembler
TABLE:    .byte $01, $02    ; direttiva assembler
```

---

## 3. Etichette (label)

Le label nominano indirizzi o posizioni nel codice.

```asm
LOOP:
    INX
    BNE LOOP
```

Regole pratiche consigliate:

- usare nomi descrittivi (`MAIN_LOOP`, `DRAW_CURSOR`);
- mantenere naming coerente in tutto il file;
- evitare label ambigue come `L1`, `X1` se non strettamente necessario.

---

## 4. Costanti e simboli

64tass consente simboli assegnati con `=`:

```asm
BORDER_COLOR = $D020
GREEN        = $05
```

Uso:

```asm
LDA #GREEN
STA BORDER_COLOR
```

Vantaggio didattico: separa il significato dal valore numerico.

---

## 5. Numeri e basi

Formati comuni nel corso:

- esadecimale: `$D020`
- binario: `%00001111`
- decimale: `40`

Esempio:

```asm
LDA #%00000001
CPX #40
LDA #$0E
```

---

## 6. Commenti

Commento di linea con `;`:

```asm
LDA #$01      ; carica 1 in A
```

Buona pratica:

- spiegare il **perche** della riga, non solo il cosa;
- evitare commenti ridondanti su istruzioni ovvie quando il contesto e gia chiaro.

---

## 7. Posizionamento del codice

Nel repository e frequente:

```asm
*= $0801
```

Significato: imposta il program counter assembler all'indirizzo di partenza desiderato. Non e una istruzione del 6510.

---

## 8. Mini esempio completo

```asm
*= $0801

BORDER_COLOR = $D020
GREEN        = $05

START:
    LDA #GREEN
    STA BORDER_COLOR
    RTS
```

Cosa e CPU:

- `LDA`, `STA`, `RTS`

Cosa e 64tass:

- `*= $0801`, `BORDER_COLOR = $D020`, `GREEN = $05`, `START:`

---

## 9. Errori tipici

- Trattare `.byte` come istruzione CPU.
- Pensare che una label "esista" a runtime come variabile automatica.
- Confondere `*= $0801` con un opcode.

---

## 10. Checklist rapida

- Ogni simbolo ha nome chiaro?
- Valori hardware definiti come costanti?
- Distinzione CPU/assembler esplicita nei commenti didattici?
