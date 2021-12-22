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
alias la="ls -AF"
alias ll="ls -AFlh"
alias ls="ls -F"
alias mkdir="mkdir -p"
alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -selection clipboard -o"
alias skrc=". $HOME/.kshrc && echo 'sourcing $HOME/.kshrc'"
alias su="doas"
