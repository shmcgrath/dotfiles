#!/usr/bin/env bash

PWR_OPTIONS="Lock
Hard reboot
Reboot to UEFI
Reboot
Suspend
swayidle
Shutdown
sway -> reload config
sway -> restart
sway -> exit
waybar restart
dropbox systemd restart
sway -> power monitors off
sway -> power monitors on
kanshi"

SELECTION=$(printf "%s\n" "$PWR_OPTIONS" | fuzzel --dmenu --minimal-lines --prompt "Power Menu > " --select="swayidle")

case $SELECTION in
	*"Lock")
		swaylock;;
	*"Hard reboot")
		#pkexec "echo b > /proc/sysrq-trigger";;
		pkexec sh -c 'echo 1 > /proc/sys/kernel/sysrq; echo b > /proc/sysrq-trigger';;
	*"Reboot to UEFI")
		systemctl reboot --firmware-setup;;
	*"Reboot")
		systemctl reboot;;
	*"Suspend")
		swaylock && sleep 2 && systemctl suspend;;
	*"swayidle")
		sleep 2 && pkill -SIGUSR1 --exact swayidle;;
	*"Shutdown")
		systemctl poweroff;;
	*"sway -> reload config")
		swaymsg reload;;
	*"sway -> restart")
		swaymsg restart;;
	*"sway -> exit")
		swaymsg exit;;
	*"waybar restart")
		systemctl --user restart waybar@*;;
	*"dropbox systemd restart")
		systemctl --user restart dropbox;;
	*"sway -> power monitors off")
		swaymsg "output * power off";;
	*"sway -> power monitors on")
		swaymsg "output * power on";;
	*"kanshi")
		systemctl --user restart kanshi;;
esac
