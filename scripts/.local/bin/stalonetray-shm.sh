#!/usr/bin/env bash
# Start stalonetray for RiverWM + Waybar

# Wait a few seconds for Waybar to start
sleep 2

# Launch stalonetray
stalonetray \
    --geometry 1x1-0+0 \   # width x height and offset from top-right
    --icon-size 22 \       # match Waybar icon height
    --transparent true \   # make background transparent
    --skip-taskbar true \  # hide from task switching
    --bg-color 0x00000000 &

# mark it as floating (RiverWM) automatically via RiverWM rules if needed
