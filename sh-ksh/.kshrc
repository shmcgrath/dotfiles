# ==ENVIRONMENT
#check if dir and files exist then source this all
for file in $HOME/.config/environment-vars/*; do
	. $file
done

# ==PROMPT
#test -r "$HOME/.promptrc" && . "$HOME/.promptrc"

# ==HISTORY
export HISTFILE="$XDG_DATA_HOME/ksh/.ksh_history"

# ==ALIASES
# source common aliases from .aliases
test -r "$XDG_CONFIG_HOME/sh-base/aliasrc" && . "$XDG_CONFIG_HOME/sh-base/aliasrc"
