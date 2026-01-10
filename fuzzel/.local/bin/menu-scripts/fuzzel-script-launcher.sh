#!/usr/bin/env bash

SCRIPT_DIR="$HOME/.local/bin/menu-scripts"

# Use POSIX-compatible way to get executable files and strip paths
SCRIPT_LIST=$(find -L "$SCRIPT_DIR" -maxdepth 1 -type f -executable | while read -r file; do basename "$file"; done | sort)

# Let the user select one with fuzzel
SCRIPT_CHOICE=$(printf "%s\n" "$SCRIPT_LIST" | fuzzel --dmenu --prompt="Fuzzel Scripts > ")

# Execute the selected script
[ -n "$SCRIPT_CHOICE" ] && "$SCRIPT_DIR/$SCRIPT_CHOICE"
