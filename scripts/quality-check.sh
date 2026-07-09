#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

REQ_HEADERS=(
  "## 🎯 Obiettivi"
  "## 🧠 Introduzione"
  "## 📘 Teoria"
  "## 🤖 Come ragiona il 6510"
  "## 💡 Esempio pratico"
  "## ⚠️ Errori comuni"
  "## 🧪 Esercizi"
  "## 📌 Riassunto"
  "## 🔜 Preparazione alla lezione successiva"
  "## 🔎 Approfondimento - Dentro il 6510"
  "## ✅ Checklist finale"
)

echo "[quality-check] MkDocs build"
./.venv/bin/mkdocs build -q

echo "[quality-check] Lesson template headings"
missing=0
while IFS= read -r file; do
  for header in "${REQ_HEADERS[@]}"; do
    if ! grep -Fq "$header" "$file"; then
      echo "MISSING: $file :: $header"
      missing=1
    fi
  done
done < <(find docs/modules -path '*/lessons/*.md' ! -name 'lesson-template.md' | sort)

if [[ $missing -ne 0 ]]; then
  echo "[quality-check] FAILED: missing required template headings"
  exit 1
fi

echo "[quality-check] Temporary file hygiene"
if find . -maxdepth 1 -type f \( -name '.tmp-*' -o -name '*.tmp' \) | grep -q .; then
  echo "[quality-check] FAILED: temporary files found in repo root"
  find . -maxdepth 1 -type f \( -name '.tmp-*' -o -name '*.tmp' \)
  exit 1
fi

echo "[quality-check] Build all lesson asm examples"
./scripts/build-lesson-examples.sh

echo "[quality-check] Italian lesson text lint"
./scripts/text-lint-italian.sh

echo "[quality-check] OK"
