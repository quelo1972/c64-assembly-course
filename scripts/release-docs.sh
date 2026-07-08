#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

if ! git diff --quiet; then
  echo "[release-docs] ERROR: ci sono modifiche non stageate. Esegui prima git add." >&2
  exit 1
fi

if git diff --cached --quiet; then
  echo "[release-docs] ERROR: nessuna modifica stageata. Stagea i file prima del rilascio." >&2
  exit 1
fi

COMMIT_MSG="${1:-docs: update documentation}"

echo "[release-docs] Quality check"
./scripts/quality-check.sh

echo "[release-docs] Commit"
git commit -m "$COMMIT_MSG"

echo "[release-docs] Push"
git push origin main

echo "[release-docs] Deploy"
./.venv/bin/mkdocs gh-deploy --clean -b gh-pages -r origin

echo "[release-docs] DONE"
