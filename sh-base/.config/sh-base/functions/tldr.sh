tldr() {
if ! command -v tldr >/dev/null 2>&1; then
	printf '%s\n' 'install tealdeer' >&2
	return 127
fi
	[ "$#" -gt 0 ] && { command tldr "$@"; return; }
	command tldr --list | fzf | xargs -r tldr
}
