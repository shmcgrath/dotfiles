#!/usr/bin/env bash

OPTIONS="Selection to File
Selection to Clipboard
Selection to Satty
Monitor to File
Monitor to Clipboard
All Windows to File
All Windows to Clipboard"

SELECTION=$(printf "%s\n" "$OPTIONS" | fuzzel --dmenu --minimal-lines --prompt "Screenshot > " --select="Selection to Satty")

case $SELECTION in
	*"Selection to File")
		grim -g "$(slurp)";;
	*"Selection to Clipboard")
		grim -g "$(slurp)" - | wl-copy;;
	*"Selection to Satty")
		grim -g "$(slurp)" - | satty --filename - --output-filename ~/Pictures/satty/$(date '+%Y%m%d-%H%M%S').png;;
	*"Monitor to File")
		grim -g "$(slurp -o)";;
	*"Monitor to Clipboard")
		grim -g "$(slurp -o)" - | wl-copy;;
	*"All Windows to File")
		grim;;
	*"All Windows to Clipboard")
		grim - | wl-copy;;
esac
