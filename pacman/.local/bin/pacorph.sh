#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if command -v doas >/dev/null 2>&1; then
	PRIVESC="doas"
else
	PRIVESC="sudo"
fi

if command -v paru >/dev/null 2>&1; then
	PKGMAN="paru"
else
	PKGMAN="pacman"
fi

mapfile -t ORPHANS < <("$PKGMAN" --query --quiet --deps --unrequired)

if [ "${#ORPHANS[@]}" -eq 0 ]; then
	printf 'No orphaned packages found.\n'
	exit 0
fi

declare -a MARK_EXPLICIT=()
declare -a REMOVE=()

for pkg in "${ORPHANS[@]}"; do
	printf "\n============================================================\n"
	printf "Package: %s\n" "$pkg"
	"$PKGMAN" --query --info "$pkg"
	printf "============================================================\n"

	while true; do
		printf "\n$pkg: [e]xplicit, [r]emove, [s]kip, [q]uit: "
		read -r answer

		case "$answer" in
			e|E)
				MARK_EXPLICIT+=("$pkg")
				break
				;;
			r|R)
				REMOVE+=("$pkg")
				break
				;;
			s|S|'')
				break
				;;
			q|Q)
				goto_summary=true
				break 2
				;;
			*)
				printf 'Invalid input.\n'
				;;
		esac
	done
done

printf '\nPackages to mark explicit:\n'
printf '  %s\n' "${MARK_EXPLICIT[@]:-<none>}"

printf '\nPackages to remove:\n'
printf '  %s\n' "${REMOVE[@]:-<none>}"

printf '\nProceed? [y/N]: '
read -r confirm

case "$confirm" in
	y|Y|yes|YES)
		if [ "${#MARK_EXPLICIT[@]}" -gt 0 ]; then
			"$PRIVESC" "$PKGMAN" --asexplicit "${MARK_EXPLICIT[@]}"
		fi

		if [ "${#REMOVE[@]}" -gt 0 ]; then
			"$PRIVESC" "$PKGMAN" --remove --unneeded --nosave --recursive "${REMOVE[@]}"
		fi
		;;
	*)
		printf 'Aborted.\n'
		;;
esac
