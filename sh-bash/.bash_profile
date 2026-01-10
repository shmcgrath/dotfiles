# sourcing ~/.profile explicitly loads XDG env vars
[ -f "$HOME/.profile" ] && . "$HOME/.profile"

if [ -d "$XDG_CONFIG_HOME/sh-base/functions" ]; then
	for functionFile in "$XDG_CONFIG_HOME/sh-base/functions"/*; do
		if [ -f "$functionFile" ]; then
			. "$functionFile"
		fi
	done
else
	printf "%s\n" "$XDG_CONFIG_HOME/sh-base/functions is missing!"
fi

if [ "$(uname)" = "Linux" ]; then
	export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

if [ "$(uname)" = "Darwin" ]; then
	[ -f "$XDG_CONFIG_HOME/homebrew/brew-env" ] && . "$XDG_CONFIG_HOME/homebrew/brew-env"
fi

[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
