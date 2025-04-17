clipcopy() {
	if command -v wl-copy >/dev/null 2>&1; then
		wl-copy
	elif command -v pbcopy >/dev/null 2>&1; then
		pbcopy
	elif command -v xclip >/dev/null 2>&1; then
		xclip -selection clipboard
	elif command -v xsel >/dev/null 2>&1; then
		xsel --clipboard --input
	else
		printf "No clipboard utility found\n" >&2
		return 1
	fi
}

clippaste() {
	if command -v wl-paste >/dev/null 2>&1; then
		wl-paste
	elif command -v pbpaste >/dev/null 2>&1; then
		pbpaste
	elif command -v xclip >/dev/null 2>&1; then
		xclip -selection clipboard -o
	elif command -v xsel >/dev/null 2>&1; then
		xsel --clipboard --output
	else
		printf "No clipboard utility found\n" >&2
		return 1
	fi
}

# vim:ft=sh:
