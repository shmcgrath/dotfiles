source_file() {
	for file in "$@"; do
		if [ -f "$file" ]; then
			. "$file"
		else
			printf "%s\n" "Warning! file not found: $file" >&2
		fi
	done
}
