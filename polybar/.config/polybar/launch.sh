#!/usr/bin/env bash

# Terminate already running bar instances
#killall -q polybar
pkill polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# set name of primary monitor in xrandr
monitor_primary=$(xrandr --query | grep -w "primary" | cut -d" " -f1)

if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		echo $m
		if [ $m == $monitor_primary ]; then
			MONITOR=$m polybar --reload bspwm_primary &
		else
			MONITOR=$m polybar --reload bspwm_secondary &
		fi
	done
else
	polybar --reload bspwm_primary &
fi
