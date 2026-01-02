# .bashrc{{{1
# source shbaserc
if [ -f "$XDG_CONFIG_HOME/sh-base/shbaserc" ]; then
    . "$XDG_CONFIG_HOME/sh-base/shbaserc"
else
	printf 'Warning: %s not found\n' "$XDG_CONFIG_HOME/sh-base/shbaserc"
fi

# Set default blocksize for ls, df, du
# from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
export BLOCKSIZE=1k

# ==Environment{{{2
# common environment vars are sourced from env-01-universal by shbaserc

# ==PATH{{{2
# common PATH additions are sourced from shbaserc

# ==Prompt{{{2
export PS1="_______________________\n\w\n\u@\h \$ "
export PS2="continue --> "

# ==Aliases{{{2
# common aliases are sourced from aliasrc by shbaserc

# ==History{{{2
export HISTFILE="$XDG_DATA_HOME/bash/.bash_history"
export HISTFILESIZE=100000
export HISTSIZE=100000
export HISTCONTROL="ignoredups:erasedups"
export HISTTIMEFORMAT="%y-%m-%d %T " # timestamp to histroy
shopt -s histappend # append to history, don't overwrite it
shopt -s cmdhist # store multi-line commands in one histroy entry
export PROMPT_COMMAND='history -a; history -r'

# == Source fzf colors{{{2

#[[ -f "$HOME/$XDG_CONFIG_HOME/themes/dracula-fzf" ]] && source $HOME/$XDG_CONFIG_HOME/themes/dracula-fzf

# == cli tools eval{{{2
eval "$(zoxide init --cmd cd bash)"
eval "$(navi widget bash)" #CTRL+G
eval "$(wikiman -W bash)" #CTRL+F
