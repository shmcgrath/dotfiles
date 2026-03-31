#!/usr/bin/env bash

set -uo pipefail

if [ -z "${TMUX-}" ]; then
    printf "%s\n" "Not in a tmux session, safe to run homebrew maintenance."
	brew update --verbose || { printf '%s\n' 'brew update failed'; exit 1; }
	brew upgrade --verbose || { printf '%s\n' 'brew upgrade failed'; exit 1; }
	brew cleanup --verbose || { printf '%s\n' 'brew cleanup failed'; exit 1; }
	printf "%s\n" "If there is a non-failing error that doesn't make sense,"
	printf "%s\n" "it might be worth manually running brew --upgrade"
	printf "%s\n" "standalone so that it eliminates notification fails/errors."
else
    printf "%s\n" "It is not safe to run homebrew maintenance in tmux. Exit tmux and try again."
	exit 1
fi
