#!/usr/bin/env bash

set -euo pipefail

HISTORY_FILE="${XDG_DATA_HOME:-$HOME/.local/share}/menu-qalc/history"
mkdir -p "$(dirname "$HISTORY_FILE")"
touch "$HISTORY_FILE"

LAST_RESULT=""
PROMPT_SYMBOL="🧮"

while true; do
    # Display fuzzel prompt with previous expression as prefix
    PROMPT="${PROMPT_SYMBOL} ${LAST_RESULT}"
    INPUT=$(tac "$HISTORY_FILE" | fuzzel --dmenu --prompt "$PROMPT" --lines 10)

    # If user cancels
    [ -z "$INPUT" ] && exit 0

    # Copy last result to clipboard
    if [[ "$INPUT" == "y" ]]; then
        [ -n "$LAST_RESULT" ] && echo -n "$LAST_RESULT" | wl-copy
        exit 0
    fi

    # Evaluate with qalc (disable terminal interaction)
    RESULT=$(printf "%s\n" "$INPUT" | qalc -t --quiet < /dev/null | head -n 1)

    # Handle empty result (invalid input)
    if [ -z "$RESULT" ]; then
        LAST_RESULT="error"
        continue
    fi

    # Save to history if not a duplicate
    grep -Fxq "$INPUT" "$HISTORY_FILE" || echo "$INPUT" >> "$HISTORY_FILE"

    LAST_RESULT="$RESULT"
done
