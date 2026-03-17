#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Choose privilege escalation tool
if command -v doas >/dev/null 2>&1; then
	PRIVESC="doas"
else
	PRIVESC="sudo"
fi

# Choose package manager wrapper or pacman
if command -v paru >/dev/null 2>&1; then
	PKGMAN="paru"
else
	PKGMAN="pacman"
fi

mapfile -t ORPHANS < <($PKGMAN --query --quiet --deps --unrequired)

if [ "${#ORPHANS[@]}" -eq 0 ]; then
	printf 'No orphaned packages found.\n'
	exit 0
fi

for pkg in "${ORPHANS[@]}"; do
	printf '\n============================================================\n'
	printf 'Package: %s\n' "$pkg"
	$PKGMAN --query --info "$pkg"
	printf '============================================================\n\n'

	while true; do
		printf '\nMark %s as explicitly installed instead of removing? [y/N]: ' "$pkg"
		read -r explicit
		case "$explicit" in
			y|Y|yes|YES)
				$PRIVESC $PKGMAN --asexplicit "$pkg"
				printf '%s marked as explicitly installed.\n' "$pkg"
				break 2  # skip removal prompt
				;;
			n|N|no|NO|'')
				# continue to removal prompt
				break
				;;
			*)
				printf 'Invalid input. Use y or n.\n'
				;;
		esac
	done

	while true; do
		printf '\nRemove %s with: %s %s --remove --recursive --nosave %s ? [y/N/q]: ' "$pkg" "$PRIVESC" "$PKGMAN" "$pkg"
		read -r answer

		case "$answer" in
			y|Y|yes|YES)
				$PRIVESC $PKGMAN --remove --recursive --nosave "$pkg"
				break
				;;
			n|N|no|NO|'')
				printf 'Skipping %s\n' "$pkg"
				break
				;;
			q|Q|quit|QUIT)
				printf 'Quitting.\n'
				exit 0
				;;
			*)
				printf 'Invalid input. Use y, n, or q.\n'
				;;
		esac
	done
done
