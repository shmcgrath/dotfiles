#!/usr/bin/env bash

SELECTION="$(printf "Lock\nSuspend\nReboot\nReboot to UEFI\nHard reboot\nShutdown\nHyprland reload\nHyprland exit\nHyprland restart waybar\nsway reload config\nsway exit\nriver exit" | fuzzel --dmenu --lines 11 --prompt "Power Menu > ")"

case $SELECTION in
	*"Lock")
		swaylock;;
	*"Suspend")
		systemctl suspend;;
	*"Reboot")
		systemctl reboot;;
	*"Reboot to UEFI")
		systemctl reboot --firmware-setup;;
	*"Hard reboot")
		pkexec "echo b > /proc/sysrq-trigger";;
	*"Shutdown")
		systemctl poweroff;;
	*"Hyprland reload")
		hyprctl reload;;
	*"Hyprland exit")
		hyprctl dispatch exec uwsm stop;;
	*"Hyprland restart waybar")
		systemctl --user restart waybar;;
	*"sway reload config")
		swaymsg reload;;
	*"sway exit")
		swaymsg exit;;
	*"river exit")
		riverctl exit;;
esac
