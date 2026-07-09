#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

normalize_file() {
  local file="$1"
  perl -0777 -i -pe '
    my @parts = split(/(```[\s\S]*?```)/, $_);
    for (my $i = 0; $i < @parts; $i += 2) {
      my $t = $parts[$i];

      # High-confidence replacements for essere (third person singular).
      $t =~ s/\bnon e\b/non è/g;
      $t =~ s/\bNon e\b/Non è/g;

      # Frequent generated forms in prose.
      $t =~ s/\be il chip\b/è il chip/g;
      $t =~ s/\be il passo\b/è il passo/g;
      $t =~ s/\be il traguardo\b/è il traguardo/g;
      $t =~ s/\be il modo\b/è il modo/g;
      $t =~ s/\be una\b/è una/g if $t =~ /\b(CPU|routine|lezione|fase|base|chiave|struttura)\b/;

      # Sentence-start standalone E used as verb.
      $t =~ s/(^|[\.!\?]\s+)E\s+(?=(?:un|una|il|lo|la|stato|stata|utile|possibile|importante|fondamentale|necessario|obbligatorio|semplice|meglio|chiaro|normale)\b)/$1È /g;

      $parts[$i] = $t;
    }
    $_ = join(q{}, @parts);
  ' "$file"
}

while IFS= read -r lesson; do
  normalize_file "$lesson"
done < <(find docs/modules -type f -path '*/lessons/*.md' ! -name 'lesson-template.md' | sort)

echo "[text-normalize-italian] OK"
