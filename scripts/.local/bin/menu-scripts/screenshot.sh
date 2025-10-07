#!/usr/bin/env bash

OPTIONS="Selection to File
Selection to Clipboard
All Windows"

SELECTION=$(printf "%s\n" "$PWR_OPTIONS" | fuzzel --dmenu --lines 12 --prompt "Screenshot > ")

case $SELECTION in
	*"Selection to File")
		grim -g "$(slurp)";;
	*"Selection to Clipboard")
		grim -g "$(slurp)" - | wl-copy;;
	*"All Windows")
		grim;;
esac
