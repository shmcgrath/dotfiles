# sourcing ~/.profile explicitly loads XDG env vars
[ -f "$HOME/.profile" ] && . "$HOME/.profile"

if [ "$(uname)" = "Linux" ]; then
	export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

if [ "$(uname)" = "Darwin" ]; then
	[ -f "$XDG_CONFIG_HOME/homebrew/brew-env" ] && . "$XDG_CONFIG_HOME/homebrew/brew-env"
fi

[ -f "$HOME/.zshrc" ] && . "$HOME/.zshrc"
