#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

tmp_file="$(mktemp)"
trap 'rm -f "$tmp_file"' EXIT

# High-confidence signals of missing accent on verb essere.
grep -RIn "\bnon e\b|\bNon e\b|\bE (un|una|il|lo|la|stato|stata|utile|importante|fondamentale|possibile|necessario|obbligatorio|semplice)\b" docs/modules/modulo-*/lessons/*.md > "$tmp_file" || true

# Ignore code fences in a simple way: discard lines that are code-fence markers.
grep -Ev '^.*```' "$tmp_file" > "$tmp_file.filtered" || true

if [[ -s "$tmp_file.filtered" ]]; then
  echo "[text-lint-italian] FAILED: possibili forme 'e' verbale senza accento"
  cat "$tmp_file.filtered"
  echo "[text-lint-italian] Suggerimento: eseguire ./scripts/text-normalize-italian.sh e rivedere i casi segnalati"
  rm -f "$tmp_file.filtered"
  exit 1
fi

rm -f "$tmp_file.filtered"
echo "[text-lint-italian] OK"
