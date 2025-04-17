pastebin() {
	pastefile=${1:-/dev/stdin}
	url=
	syntax=

	if [ ! -f "$pastefile" ] && [ "$pastefile" != "/dev/stdin" ]; then
		printf "File not found: %s\n" "$pastefile" >&2
		return 1
	fi

	# Detect MIME type if it's not stdin
	if [ "$pastefile" != "/dev/stdin" ]; then
		mime=$(file --mime-type -b "$pastefile")
	else
		mime="text/plain"
	fi

	case "$pastefile" in
		*.sh) syntax=bash ;;
		*.c) syntax=c ;;
		*.h) syntax=c ;;
		*.cpp|*.cc|*.cxx) syntax=cpp ;;
		*.py) syntax=python ;;
		*.js) syntax=javascript ;;
		*.json) syntax=json ;;
		*.html) syntax=html ;;
		*.css) syntax=css ;;
		*.lua) syntax=lua ;;
		*.md) syntax=markdown ;;
		*.rb) syntax=ruby ;;
		*.rs) syntax=rust ;;
		*.java) syntax=java ;;
		*.go) syntax=go ;;
		*.php) syntax=php ;;
		*.pl) syntax=perl ;;
		*) syntax=plain ;;
	esac

	if printf %s\\n "$mime" | grep -q '^text/'; then
		url=$(curl -s -X POST https://dpaste.org/api/ \
			-d "content=$(cat "$pastefile")" \
			-d "syntax=$syntax" \
			-d "expiry_days=7")
		if [ -z "$url" ]; then
			printf "dpaste.org failed, trying 0x0.st...\n" >&2
			url=$(curl -s -F "file=@$pastefile" https://0x0.st)
		fi
	else
		printf "Non-text file detected, using 0x0.st...\n" >&2
		url=$(curl -s -F "file=@$pastefile" https://0x0.st)
	fi

	if [ -z "$url" ]; then
		printf "Upload failed.\n" >&2
		return 1
	fi

	printf "Paste URL: %s\n" "$url"

	# Copy to clipboard
	if command -v wl-copy >/dev/null 2>&1; then
		printf "%s" "$url" | wl-copy
	elif command -v pbcopy >/dev/null 2>&1; then
		printf "%s" "$url" | pbcopy
	elif command -v xclip >/dev/null 2>&1; then
		printf "%s" "$url" | xclip -selection clipboard
	elif command -v xsel >/dev/null 2>&1; then
		printf "%s" "$url" | xsel --clipboard --input
	else
		printf "No clipboard tool found; URL not copied\n" >&2
	fi
}

# vim:ft=sh:
