#!/usr/bin/env bash

read -p "When xplr loads, press #. Press enter to continue..."
xplrver="$(xplr | grep ^version | cut -d' ' -f 2)"

echo "The current version of xplr is $xplrver"
