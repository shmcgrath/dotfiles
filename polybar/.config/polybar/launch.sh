#!/usr/bin/env bash

# Terminate already running bar instances
#killall -q polybar
pkill polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# set name of primary monitor in xrandr
primary_monitor="DP-1"

if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		echo $m
		if [ $m == $primary_monitor ]; then
			MONITOR=$m polybar --reload bspwm_primary &
		else
			MONITOR=$m polybar --reload bspwm_secondary &
		fi
	done
else
	polybar --reload bspwm_primary &
fi
