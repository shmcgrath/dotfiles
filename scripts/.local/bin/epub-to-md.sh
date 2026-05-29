#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ $# -ne 1 ]]; then
    printf "Usage: %s <input.epub>\n" "$0"
    exit 1
fi

input_file="$1"

if [[ ! -f "$input_file" ]]; then
    printf "Error: File not found: %s\n" "$input_file"
    exit 1
fi

case "$input_file" in
    *.epub) ;;
    *)
        printf "Error: Input file must have .epub extension\n"
        exit 1
        ;;
esac

base_name="$(basename -- "$input_file" .epub)"
html_file="${base_name}.html"
media_dir="${base_name}_media"
htmlz="${base_name}.htmlz"
html_dir="${base_name}_html"

printf "Converting %s → html and markdown\n" "$input_file"

/Applications/calibre.app/Contents/MacOS/ebook-convert "$input_file" "$htmlz" --unsmarten-punctuation  --expand-css --sr1-search '<i(.*?)</i>' --sr1-replace '<em\1</em>' --sr2-search '<b(.*?)</b>' --sr2-replace '<strong\1</strong>'
mkdir -p "$html_dir"
unzip "$htmlz" -d "$html_dir"

find "$html_dir" -name "*.html" -print0 | while IFS= read -r -d '' file; do

    # Tidy / prettify
    tidy -m -i --drop-empty-elements no --tidy-mark no -wrap 0 "$file" || true

    # Clean Calibre noise
    perl "$HOME/fix-html.pl" "$file"

    # Post-tidy
    tidy -m -i --drop-empty-elements no --tidy-mark no -wrap 0 "$file" || true

    # Convert HTML → Markdown in the same folder
    md_file="${file%.html}.md"
    pandoc --from=html --to=markdown --wrap=none -o "$md_file" "$file"

    echo "Processed $file → $md_file"
done


#pandoc \
    #--from=epub \
    #--to=html \
    #--wrap=none \
    #--extract-media="$media_dir" \
    #--output="$html_file" \
    #"$input_file"

# Remove empty divs and spans
#perl -0777 -pi -e '
# Remove empty divs with height:0pt
#s|<div[^>]*style="height:0pt"[^>]*>.*?</div>||sg;

# Remove any empty spans (with or without id, possibly whitespace inside)
#s|<span[^>]*>\s*</span>||sg;
#' "$html_file"

printf "Processing complete!\n"
