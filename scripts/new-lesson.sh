#!/usr/bin/env bash
# new-lesson.sh — Crea una nuova lezione nel modulo indicato
# Uso: ./scripts/new-lesson.sh <modulo> <numero> <titolo-slug> <"Titolo esteso">
# Esempio:
#   ./scripts/new-lesson.sh 5 011 "modalita-immediata" "Modalità di indirizzamento immediato"

set -euo pipefail

MODULO="${1:-}"
NUM="${2:-}"
SLUG="${3:-}"
TITLE="${4:-}"

if [[ -z "$MODULO" || -z "$NUM" || -z "$SLUG" || -z "$TITLE" ]]; then
  echo "Uso: $0 <modulo> <numero> <titolo-slug> <\"Titolo esteso\">"
  echo "Esempio: $0 5 011 modalita-immediata \"Modalità di indirizzamento immediato\""
  exit 1
fi

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LESSONS_DIR="$ROOT/docs/modules/modulo-${MODULO}/lessons"
TEMPLATE="$LESSONS_DIR/lesson-template.md"
TARGET="$LESSONS_DIR/${NUM}-${SLUG}.md"
MODULE_INDEX="$ROOT/docs/modules/modulo-${MODULO}.md"
MKDOCS="$ROOT/mkdocs.yml"

# -- Validazioni ---------------------------------------------------------------
if [[ ! -d "$LESSONS_DIR" ]]; then
  echo "Errore: cartella lessons non trovata per modulo-${MODULO}: $LESSONS_DIR"
  exit 1
fi

if [[ ! -f "$TEMPLATE" ]]; then
  echo "Errore: lesson-template.md non trovato in $LESSONS_DIR"
  exit 1
fi

if [[ -f "$TARGET" ]]; then
  echo "Errore: il file esiste già: $TARGET"
  exit 1
fi

# -- Crea il file lezione dal template -----------------------------------------
cp "$TEMPLATE" "$TARGET"

# Sostituisce i placeholder nel file copiato
sed -i \
  -e "s/Lezione NNN — Titolo della lezione/Lezione ${NUM} - ${TITLE}/" \
  -e "s/descrivere in una frase l'obiettivo concreto di questa lezione./TODO: obiettivo di questa lezione./" \
  "$TARGET"

echo "✅ Creato: $TARGET"

# -- Aggiunge la voce nell'indice del modulo ------------------------------------
if grep -q "${NUM}-${SLUG}" "$MODULE_INDEX"; then
  echo "ℹ️  Voce già presente in $MODULE_INDEX, salto."
else
  # Inserisce prima della riga '## Obiettivo'
  sed -i "/^## Obiettivo/i - [Lezione ${NUM} - ${TITLE}](modulo-${MODULO}/lessons/${NUM}-${SLUG}.md)" "$MODULE_INDEX"
  echo "✅ Aggiunto indice: $MODULE_INDEX"
fi

# -- Aggiunge la voce nel nav di mkdocs.yml ------------------------------------
NAV_LINE="      - Lezione ${NUM} - ${TITLE}: modules/modulo-${MODULO}/lessons/${NUM}-${SLUG}.md"

if grep -qF "${NUM}-${SLUG}" "$MKDOCS"; then
  echo "ℹ️  Voce già presente in mkdocs.yml, salto."
else
  # Inserisce dopo l'ultima lezione del modulo corrente o dopo l'indice del modulo
  ANCHOR="      - Modulo ${MODULO} - Indice: modules/modulo-${MODULO}.md"
  if grep -qF "$ANCHOR" "$MKDOCS"; then
    sed -i "s|${ANCHOR}|${ANCHOR}\n${NAV_LINE}|" "$MKDOCS"
    echo "✅ Aggiunto a mkdocs.yml"
  else
    echo "⚠️  Non ho trovato l'ancora in mkdocs.yml. Aggiungi manualmente:"
    echo "   $NAV_LINE"
  fi
fi

echo ""
echo "📋 Prossimi passi:"
echo "  1. Scrivi il contenuto in: $TARGET"
echo "  2. Controlla mkdocs.yml e docs/modules/modulo-${MODULO}.md"
echo "  3. git add . && git commit -m 'docs(mod${MODULO}): add lesson ${NUM} - ${TITLE}'"
echo "  4. .venv/bin/mkdocs gh-deploy --clean -b gh-pages -r origin"
