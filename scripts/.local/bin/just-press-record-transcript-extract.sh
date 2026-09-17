#!/bin/bash

directory="$HOME/Library/Mobile Documents/iCloud~com~openplanetsoftware~just-press-record/Documents"
output="just-press-record-extraction-$(date '+%Y-%m-%d_%H-%M-%S').md"

{
    printf '# Just Press Record Extraction\n\n'

    find "$directory" -type f -name '*.m4a' -print0 |
    while IFS= read -r -d '' file; do
        filename="$(basename "$file")"
        date="$(basename "$(dirname "$file")")"

        transcript="$(
            strings "$file" |
            tail -n 1 |
            sed 's/^[^{]*//' |
            jq -r '._root.txscriptv2.tx._data' |
            base64 --decode
        )"

        printf '## %s — %s\n\n' "$date" "$filename"
        printf '%s\n\n' "$transcript"
    done
} > "$output"

printf 'Saved to: %s\n' "$output"
