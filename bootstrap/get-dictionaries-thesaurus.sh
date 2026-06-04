#!/usr/bin/env sh

WORD_DIR="$XDG_DATA_HOME/doc/words"
mkdir -pv "$WORD_DIR"

# download thesaurus from Project Gutenberg
curl --location --fail --show-error \
	--output "$WORD_DIR/mthesaur.txt" \
	"https://www.gutenberg.org/files/3202/files/mthesaur.txt"
# use nvim to replace CRLF to Unix newline
nvim "$WORD_DIR/mthesaur.txt" -c "set ff=unix" -c ":wq"
file "$WORD_DIR/mthesaur.txt"

# download google-10000-english-usa
curl --location --fail --show-error \
	--output "$WORD_DIR/google-10000-english-usa.txt" \
	"https://raw.githubusercontent.com/first20hours/google-10000-english/refs/heads/master/google-10000-english-usa.txt"
file "$WORD_DIR/google-10000-english-usa.txt"

# download Webster's Unabridged Dictionary Late 19th Century
# from Project Gutenberg https://www.gutenberg.org/ebooks/29765
curl --location --fail --show-error \
	--output "$WORD_DIR/websters-unabridged-dictionary.txt" \
	"https://www.gutenberg.org/cache/epub/29765/pg29765.txt"
nvim "$WORD_DIR/websters-unabridged-dictionary.txt" -c "set ff=unix" -c ":wq"
file "$WORD_DIR/websters-unabridged-dictionary.txt"

# download Roget's Thesaurus published in 1911
curl --location --fail --show-error \
	--output "$WORD_DIR/rogets-thesaurus.txt" \
	"https://www.gutenberg.org/files/3202/files/roget13a.txt"
nvim "$WORD_DIR/rogets-thesaurus.txt" -c "set ff=unix" -c ":wq"
file "$WORD_DIR/rogets-thesaurus.txt"
