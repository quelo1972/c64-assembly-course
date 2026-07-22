#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <input.asm> <output.prg>" >&2
  exit 2
fi

INPUT_FILE="$1"
OUTPUT_FILE="$2"

if [[ ! -f "$INPUT_FILE" ]]; then
  echo "Input file not found: $INPUT_FILE" >&2
  exit 1
fi

prepare_build_source() {
  local input_file="$1"
  local output_file="$2"

  # Inject a minimal BASIC launcher only for sources based at $0801
  # that do not already define a SYS line.
  if ! grep -q '^[[:space:]]*\*\s*=\s*\$0801\([[:space:]]*;.*\)\?$' "$input_file"; then
    cp "$input_file" "$output_file"
    return
  fi

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

tmp_file="$(mktemp)"
cleanup() { rm -f "$tmp_file"; }
trap cleanup EXIT

prepare_build_source "$INPUT_FILE" "$tmp_file"
mkdir -p "$(dirname "$OUTPUT_FILE")"
64tass --cbm-prg -o "$OUTPUT_FILE" "$tmp_file"
