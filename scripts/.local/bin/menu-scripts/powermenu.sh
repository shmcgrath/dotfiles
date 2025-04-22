#!/usr/bin/env bash

PWR_OPTIONS="Lock
Suspend
Reboot
Reboot to UEFI
Hard reboot
Shutdown
river exit
waybar restart
Hyprland reload
Hyprland exit
Hyprland restart waybar
sway reload config
sway exit"

SELECTION=$(printf "%s\n" "$PWR_OPTIONS" | fuzzel --dmenu --lines 12 --prompt "Power Menu > ")

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
	*"river exit")
		riverctl exit;;
	*"waybar restart")
		systemctl --user restart waybar;;
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
esac
