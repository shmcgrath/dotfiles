#!/usr/bin/env bash

SCRIPT_DIR="$HOME/.config/fuzzel/scripts"

# List all executable files in the script directory
scripts=$(find "$SCRIPT_DIR" -maxdepth 1 -type f -executable -printf "%f\n" | sort)

# Let the user select one with fuzzel
choice=$(printf "%s\n" "$scripts" | fuzzel --dmenu --prompt="Fuzzel Scripts > ")

# Execute the selected script
[ -n "$choice" ] && "$SCRIPT_DIR/$choice"
