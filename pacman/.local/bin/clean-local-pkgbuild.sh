#!/usr/bin/env bash

set -euo pipefail

root="${HOME}/dotfiles/pacman/pkgbuild"
keep_gitignore="${root}/.gitignore"

echo "Scanning: ${root}"
echo

mapfile -t files < <(
    find "${root}" -type f \
        ! -name "PKGBUILD" \
        ! -name ".SRCINFO" \
        ! -path "${keep_gitignore}"
)

if [[ ${#files[@]} -eq 0 ]]; then
    echo "Nothing to clean."
    exit 0
fi

echo "The following files will be deleted:"
echo

for f in "${files[@]}"; do
    echo "  ${f}"
done

echo
read -r -p "Delete these files? [y/N]: " confirm

case "${confirm}" in
    y|Y|yes|YES)
        echo
        echo "Deleting..."
        for f in "${files[@]}"; do
            rm -v -- "${f}"
        done
        echo "Done."
        ;;
    *)
        echo "Aborted."
        ;;
esac
