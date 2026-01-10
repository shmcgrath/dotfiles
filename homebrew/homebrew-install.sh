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
exec $0
printf "\n%s" "ran exec $0, and running brew update to confirm installation."
brew update
printf "\n%s\n" "turning off analytics and installing from Brewfile..."
brew analytics off && brew analytics
brew bundle --file="$HOME/dotfiles/homebrew/Brewfile"
