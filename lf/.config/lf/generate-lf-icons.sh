#!/usr/bin/env bash

input_file="${1:-icons-gen}"
current_icon=
print_literal=false

while IFS= read -r line || [[ -n "$line" ]]; do
	if [[ "$line" == print_literal=* ]]; then
		print_literal="${line#print_literal=}"
		continue
	fi

	if [[ "$print_literal" == "true" ]]; then
		printf "%s\n" "$line"
		continue
	fi

	[[ -z "$line" ]] && continue

	if [[ "$line" == \#* ]]; then
		printf "%s\n" "$line"
		continue
	fi

	if [[ "$line" == icon=* ]]; then
		current_icon="${line#icon=}"
		continue
	fi

	if [[ "$line" == *" "* ]]; then
		ext="${line%% *}"
		icon="${line#* }"
		printf "%s %s\n" "$ext" "$icon"
	else
		ext="$line"
		icon="$current_icon"
		printf "%s %s\n" "$ext" "$icon"
	fi

done <"$input_file"
