#!/usr/bin/env bash

# Check if there is an ssh session, if there is restart
# swayidle-river.service. This is the cleanest way to reset
# the swayidle timer if I have an ssh connection

if ss --tcp --numeric --all | grep -q ':22 .*ESTAB'; then
	systemctl --user restart swayidle-river.service
	printf "[%s] SSH session detected - restarting swayidle-river" "$(date)"
	exit 0
else
	exit 0
	printf "[%s] SSH session not detected via swayidle-river" "$(date)"
fi

