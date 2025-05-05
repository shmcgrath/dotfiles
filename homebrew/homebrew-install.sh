#!/usr/bin/env bash

set -euo pipefail

BREW_PREFIX="$HOME/.brew"
HOMEBREW_REPO="$BREW_PREFIX/.homebrew"
MKDIR="mkdir -pv"

$MKDIR "$BREW_PREFIX"
$MKDIR "$HOMEBREW_REPO"
$MKDIR "$BREW_PREFIX/bin"
$MKDIR "$BREW_PREFIX/etc"
$MKDIR "$BREW_PREFIX/share"
$MKDIR "$BREW_PREFIX/var"
$MKDIR "$BREW_PREFIX/Cellar"
$MKDIR "$HOME/.config/homebrew"
$MKDIR "$HOME/.local/share/terminfo"

# Clone Homebrew core
if [ -d "$HOMEBREW_REPO/.git" ]; then
	printf "homebrew already cloned"
else
	printf "cloning homebrew... "
	git clone https://github.com/Homebrew/brew "$HOMEBREW_REPO"
fi

# Symlink brew to ~/.brew/bin
ln -sf "$HOMEBREW_REPO/bin/brew" "$BREW_PREFIX/bin/brew"
# Symlink brew-env to $XDG_CONFIG_HOME/homebrew
ln -sf "$HOME/dotfiles/homebrew/.config/homebrew/brew-env" "$HOME/.config/homebrew/brew-env"

printf "\nHomebrew installed to %s and configured to avoid system paths." "$BREW_PREFIX"
printf "\nOpen a new zsh shell and run brew update to confirm installation."
printf "\nTo install from a Bewfile run brew bundle --file=$HOME/dotfiles/homebrew/Brewfile"
