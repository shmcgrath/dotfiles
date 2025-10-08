#!/usr/bin/env bash

PWR_OPTIONS="Lock
Suspend
Reboot
Reboot to UEFI
Hard reboot
Shutdown
river exit
waybar restart"

SELECTION=$(printf "%s\n" "$PWR_OPTIONS" | fuzzel --dmenu --minimal-lines --prompt "Power Menu > " --select="Suspend")

case $SELECTION in
	*"Lock")
		swaylock;;
	*"Suspend")
		swaylock && systemctl suspend;;
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
		systemctl --user restart waybar@*;;
esac
