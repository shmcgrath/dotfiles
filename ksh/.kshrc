# ==PATH
export PATH="$HOME/.scripts/:${PATH}"

# ==ENVIRONMENT
export VISUAL=vim
export EDITOR=$VISUAL
export CLICOLOR=1
export FCEDIT=$EDITOR
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LESS='-iMR -x4'
export PAGER=less
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"

# ==PROMPT
test -r "$HOME/.promptrc" && . "$HOME/.promptrc"

# ==HISTORY
export HISTIGNORE=".1:.2:.3:cd:ls:ll:pwd"
export HISTCONTROL="ignoredups:erasedups"
export HISTFILE=$HOME/.ksh_history
export HISTSIZE=20000

# ==ALIASES
# source common aliases from .aliases
test -r "$HOME/.aliasrc" && . "$HOME/.aliasrc"
alias la="ls -AF"
alias ll="ls -AFlh"
alias ls="ls -F"
alias mkdir="mkdir -p"
alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -selection clipboard -o"
alias skrc=". $HOME/.kshrc && echo 'sourcing $HOME/.kshrc'"
alias su="doas"
