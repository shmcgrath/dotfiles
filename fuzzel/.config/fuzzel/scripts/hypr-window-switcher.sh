#!/usr/bin/env bash

set -euo pipefail

MOVE_TO_CURRENT_WORKSPACE=false

# Check for --move-to-current-workspace flag
if [[ "${1:-}" == "--move-to-current-workspace" ]]; then
  MOVE_TO_CURRENT_WORKSPACE=true
fi

# Config paths
GENERAL_CONFIG_PATH="/etc/hypr-window-switcher/extra_dispatches.txt"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
USER_CONFIG_PATH="$CONFIG_DIR/hypr-window-switcher/extra_dispatches.txt"
CONFIG_PATH="$GENERAL_CONFIG_PATH"
[[ -f "$USER_CONFIG_PATH" ]] && CONFIG_PATH="$USER_CONFIG_PATH"

# Read extra dispatches (first line only)
EXTRA_DISPATCHES=""
[[ -f "$CONFIG_PATH" ]] && EXTRA_DISPATCHES=$(head -n 1 "$CONFIG_PATH")

# Get list of visible windows
windows_json=$(hyprctl -j clients)
windows=$(echo "$windows_json" | jq -c '[.[] | select(.hidden == false and .monitor != -1)] | sort_by(.focusHistoryID)')
window_count=$(echo "$windows" | jq 'length')

# Add first window again at the end to mimic fallback behavior
if (( window_count > 0 )); then
  windows=$(echo "$windows" | jq '. + [.[0]]')
fi

# Generate fuzzel menu input
fuzzel_input=$(echo "$windows" | jq -r '.[] | "[\(.workspace.name)] \(.title) | \(.class)\u0000icon\u001f\(.class)"')
selected_index=$(echo "$fuzzel_input" | fuzzel --dmenu --index | tr -d '\n')

# If nothing selected, exit
[[ -z "$selected_index" ]] && exit 0

# Convert index to integer
selected_index_int=$((selected_index))
selected_window=$(echo "$windows" | jq ".[$selected_index_int]")
selected_address=$(echo "$selected_window" | jq -r '.address')

# Active window
active_window=$(hyprctl -j activewindow | jq)
current_address=$(echo "$active_window" | jq -r '.address // empty')

# Exit if already focused
if [[ "$selected_address" == "$current_address" ]]; then
  echo "Already focused. Exiting."
  exit 0
fi

# Get workspace ID
active_workspace_id=$(hyprctl -j activeworkspace | jq -r '.id')
destination_workspace_id=$(echo "$selected_window" | jq -r '.workspace.id')
[[ "$MOVE_TO_CURRENT_WORKSPACE" == "true" ]] && destination_workspace_id="$active_workspace_id"

# Check for full-screen windows to minimize
swallowing_windows=$(echo "$windows" | jq \
  --argjson dest "$destination_workspace_id" \
  --arg sel "$selected_address" \
  '[.[] | select(.workspace.id == $dest and .fullscreen == true and .address != $sel)]')

swallowing_cmds=$(echo "$swallowing_windows" | jq -r '.[] | "dispatch focuswindow address:\(.address); dispatch fullscreen 0;"')

# Choose final dispatch command
if [[ "$MOVE_TO_CURRENT_WORKSPACE" == "true" ]]; then
  destination_cmd="dispatch movetoworkspace $active_workspace_id,address:$selected_address"
else
  destination_cmd="dispatch focuswindow address:$selected_address"
fi

# Build and run final command
full_cmd="$swallowing_cmds $destination_cmd; $EXTRA_DISPATCHES"
echo "Running: $full_cmd"
hyprctl --batch "$full_cmd"

