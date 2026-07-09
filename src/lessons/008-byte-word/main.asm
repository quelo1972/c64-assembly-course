; Lezione 008 - Overflow di un contatore a 8 bit
*= $0801

COUNTER = $C000

start:
   LDA #$FF
   STA COUNTER

   INC COUNTER     ; $FF -> $00 (wrap a 8 bit)

loop:
   JMP loop
