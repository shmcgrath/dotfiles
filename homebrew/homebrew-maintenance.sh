#!/usr/bin/env bash

set -euo pipefail

if [ -z "${TMUX-}" ]; then
    echo "Not in a tmux session, safe to run homebrew maintenance."
	brew update --verbose
	brew upgrade --verbose
	brew cleanup --verbose
else
    echo "It is not safe to run homebrew maintenance in tmux. Exit tmux and try again."
fi
