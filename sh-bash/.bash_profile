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

if [ "$(uname)" = "Darwin" ]; then
	source_file \
		"$HOME/.zshrc" \
fi

if [ "$(uname)" = "Linux" ]; then
	source_file \
		"$HOME/.zshrc" \
		"$XDG_CONFIG_HOME/sh-base/ssh-agent-auth-socket"
fi
