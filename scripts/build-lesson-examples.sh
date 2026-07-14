#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

LESSONS_DIR="docs/modules"
SRC_ROOT="src/lessons"
BIN_ROOT="bin"

mkdir -p "$SRC_ROOT" "$BIN_ROOT"

extract_example() {
  local lesson_file="$1"
  local out_file="$2"

  awk '
    BEGIN { in_example=0; in_code=0; found=0 }
    /^## 💡 Esempio pratico/ { in_example=1; next }
    in_example && /^## / { if (!in_code) exit; }
    in_example && /^```asm[[:space:]]*$/ {
      in_code=1
      next
    }
    in_code && /^```[[:space:]]*$/ {
      found=1
      exit
    }
    in_code {
      print
    }
    END {
      if (!found) {
        exit 2
      }
    }
  ' "$lesson_file" > "$out_file"
}

wrap_with_basic_stub() {
  local input_file="$1"
  local output_file="$2"

  if grep -q '^[[:space:]]*\.byte[[:space:]]\+\$9e' "$input_file" && \
     grep -q '^next_line:' "$input_file"; then
    cp "$input_file" "$output_file"
    return
  fi

  awk '
    BEGIN { removed_origin=0 }
    !removed_origin && $0 ~ /^[[:space:]]*\*\s*=\s*\$0801([[:space:]]*;.*)?$/ {
      removed_origin=1
      next
    }
    { print }
  ' "$input_file" | {
    printf '* = $0801\n\n'
    printf '    .word next_line\n'
    printf '    .word 10\n'
    printf '    .byte $9e\n'
    printf '    .text "2061"\n'
    printf '    .byte 0\n\n'
    printf 'next_line:\n'
    printf '    .word 0\n\n'
    cat
  } > "$output_file"
}

echo "[lesson-build] Extracting asm examples from lessons"
fail=0
count=0
while IFS= read -r lesson; do
  base="$(basename "$lesson" .md)"
  src_dir="$SRC_ROOT/$base"
  src_file="$src_dir/main.asm"
  extracted_file="$(mktemp)"

  mkdir -p "$src_dir"

  if ! extract_example "$lesson" "$extracted_file"; then
    echo "MISSING_ASM_BLOCK: $lesson"
    rm -f "$extracted_file"
    fail=1
    continue
  fi

  if [[ ! -s "$extracted_file" ]]; then
    echo "EMPTY_ASM_BLOCK: $lesson"
    rm -f "$extracted_file"
    fail=1
    continue
  fi

  wrap_with_basic_stub "$extracted_file" "$src_file"
  rm -f "$extracted_file"

  count=$((count + 1))
done < <(find "$LESSONS_DIR" -type f -path '*/lessons/*.md' ! -name 'lesson-template.md' | sort)

if [[ $fail -ne 0 ]]; then
  echo "[lesson-build] FAILED during extraction"
  exit 1
fi

echo "[lesson-build] Extracted $count lesson examples"

echo "[lesson-build] Compiling lesson examples with 64tass"
fail=0
while IFS= read -r src_file; do
  base="$(basename "$(dirname "$src_file")")"
  out_file="$BIN_ROOT/$base.prg"

  if ! 64tass --cbm-prg -o "$out_file" "$src_file" >/tmp/lesson-build.log 2>&1; then
    echo "BUILD_FAIL: $src_file"
    cat /tmp/lesson-build.log
    fail=1
  fi
done < <(find "$SRC_ROOT" -type f -name 'main.asm' | sort)

if [[ $fail -ne 0 ]]; then
  echo "[lesson-build] FAILED: some examples do not compile"
  exit 1
fi

echo "[lesson-build] OK: all lesson examples compile"
