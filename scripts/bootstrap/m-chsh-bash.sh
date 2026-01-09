#!/usr/bin/env sh

set -e

brew_prefix="$(brew --prefix)"
bash_path="$brew_prefix/bin/bash"

# make sure bash is installed and is the latest version
if brew list --formula --versions bash >/dev/null 2>&1; then
    brew upgrade bash
else
    brew install bash
fi

# verify bash exists and is executable
if [ ! -x "$bash_path" ]; then
    printf "%s\n" "Error: $bash_path does not exist or is not executable" >&2
    exit 1
fi

# add to /etc/shells only if missing
if ! grep -Fx "$bash_path" /etc/shells >/dev/null 2>&1; then
	echo "${bash_path}" | sudo tee -a /etc/shells
fi

# change default shell only if needed
if [ "$SHELL" != "$bash_path" ]; then
    chsh -s "$bash_path"
fi

printf "%s" "Exit shell to make bash default shell? [y/N] "
IFS= read -r reply

case $reply in
    y|Y)
        exit 0
        ;;
esac
