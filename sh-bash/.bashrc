# .bashrc{{{1
# source shbaserc
if [ -f "$XDG_CONFIG_HOME/sh-base/shbaserc" ]; then
    . "$XDG_CONFIG_HOME/sh-base/shbaserc"
else
	printf 'Warning: %s not found\n' "$XDG_CONFIG_HOME/sh-base/shbaserc"
fi

# source functions
if [ -d "$XDG_CONFIG_HOME/sh-base/functions" ]; then
	for functionFile in "$XDG_CONFIG_HOME/sh-base/functions"/*; do
		if [ -f "$functionFile" ]; then
			. "$functionFile"
		fi
	done
else
	printf "%s\n" "$XDG_CONFIG_HOME/sh-base/functions is missing!"
fi

# Set default blocksize for ls, df, du
# from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
export BLOCKSIZE=1k

# ==ENVIRONMENT VARIABLES{{{2
# common environment vars are sourced from shbaserc

# ==PATH{{{2
# common PATH additions are sourced from shbaserc

# ==Prompt{{{2
export PS1="_______________________\n\w\n\u@\h \$ "
export PS2="continue --> "

# ==Aliases{{{2
# common aliases are sourced from shbaserc

# ==History{{{2
export HISTFILE="$XDG_DATA_HOME/bash/.bash_history"
export HISTFILESIZE=100000
export HISTSIZE=100000
export HISTCONTROL="ignoredups:ignorespace:erasedups"
export HISTTIMEFORMAT="%y-%m-%d %T " # timestamp to histroy
shopt -s histappend # append to history, don't overwrite it
shopt -s cmdhist # store multi-line commands in one histroy entry
PROMPT_COMMAND='history -a; history -r'
HISTIGNORE_FILE="$XDG_CONFIG_HOME/sh-base/histignore-list"

if [ -f "$HISTIGNORE_FILE" ]; then
	HISTIGNORE="$(grep -vE '^\s*#|^\s*$' "$HISTIGNORE_FILE" | paste -sd: -)"
	export HISTIGNORE
else
	printf "%s\n" "histignore-list not found"
fi


# == cli tools eval{{{2
eval "$(zoxide init --cmd cd bash)" # cd is zoxide and cdi is fzf search of zoxide database
eval "$(navi widget bash)" #CTRL+G
eval "$(wikiman -W bash)" #CTRL+F
# uncomment the line below to disable CTRL+T and ALT+C
# FZF_CTRL_T_COMMAND= FZF_ALT_C_COMMAND= eval "$(fzf --bash)"
eval "$(fzf --bash)" #ALT+C CTRL+R CTRL+T
# ALT+C fzf_cd
# CTRL+R fzf_history
# CTRL+T fzf_select
