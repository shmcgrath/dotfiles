#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

emoji_file="${HOME}/.local/share/doc/emoji.txt"

selection="$(
    fzf \
        --delimiter=$'\t' \
        --with-nth=1,2,3 \
        --layout=reverse \
        --prompt='emoji> ' \
        < "${emoji_file}"
)"

[ -n "${selection}" ] || exit 0

emoji="${selection%%$'\t'*}"

printf '%s\n' "${emoji}"

# Wayland clipboard
if [ -n "${WAYLAND_DISPLAY:-}" ] && command -v wl-copy >/dev/null 2>&1; then
    printf '%s' "${emoji}" | wl-copy
    exit 0
fi

# X11 clipboard
if [ -n "${DISPLAY:-}" ]; then
    if command -v xclip >/dev/null 2>&1; then
        printf '%s' "${emoji}" | xclip --selection clipboard
        exit 0
    fi

    if command -v xsel >/dev/null 2>&1; then
        printf '%s' "${emoji}" | xsel --clipboard --input
        exit 0
    fi
fi

# macOS clipboard
if command -v pbcopy >/dev/null 2>&1; then
    printf '%s' "${emoji}" | pbcopy
    exit 0
fi

# tmux clipboard
if [ -n "${TMUX:-}" ]; then
    printf '%s' "${emoji}" | tmux load-buffer -
fi

