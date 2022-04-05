#!/bin/sh
# Detects the width of running trayer-srg window (xprop name 'panel')
# and creates a string of x spaces where x = trayer's program specified
# size divided by 2.
#
# Code Originally by jonascj: https://github.com/jaor/xmobar/issues/239
#
# Run script from xmobar:
# `Run Com "/where/ever/xmobar-trayer-padding.sh" [] "trayerPad" 10`
# and use `%trayerPad%` in your template.

trayerMinWidth=5
trayerSpaceString="-----"

# Width of the trayer window
currentTrayerWidth=$(xprop -name trayer | grep 'program specified size' | cut -d ' ' -f 4)
halfTrayerWidth=$(($currentTrayerWidth/2))

set_trayer_spaces () {
	i=$halfTrayerWidth
	while [ $i -gt 0 ]
	do
		trayerSpaceString+="-"
		let "i-=1"
	done
}

if [ $halfTrayerWidth -gt $trayerMinWidth ]
then
	set_trayer_spaces
fi

# Output the icon tag for xmobar
echo "${trayerSpaceString//-/ }"
