# source shbaserc
if [ -f "$XDG_CONFIG_HOME/sh-base/shbaserc" ]; then
    . "$XDG_CONFIG_HOME/sh-base/shbaserc"
else
	printf 'Warning: %s not found\n' "$XDG_CONFIG_HOME/sh-base/shbaserc"
fi

# prompt{{{2
# Base prompt definition — set once
PROMPT_HEADER=$'_______________________\n'
PROMPT_MAIN=$'%~\n%n@%m \❯ '
PROMPT="${PROMPT_HEADER}${PROMPT_MAIN}"


# vim mode and cursor settings{{{2
# Set vi keybindings
bindkey -v

# Change cursor shape for different vi modes
zle-keymap-select() {
  case $KEYMAP in
    vicmd) 
      printf '\e[2 q'   # Normal mode: steady block
      ;;
    viins|main|'') 
      printf '\e[6 q'   # Insert mode: steady beam
      ;;
  esac
}

zle -N zle-keymap-select

# set cursor on start as part of precmd_functions
_fix_cursor() {
  case $KEYMAP in
    vicmd) printf '\e[2 q' ;;
    viins|main|'') printf '\e[6 q' ;;
  esac
}

precmd_functions+=(_fix_cursor)

#readline equivalent{{{2
autoload -Uz history-beginning-search-backward history-beginning-search-forward
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

bindkey -M vicmd 'k' history-beginning-search-backward
bindkey -M vicmd 'j' history-beginning-search-forward

# command autocomplete
autoload -Uz compinit
compinit

# Ignore case when completing
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Colored completions
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Show all matches if unambiguous
zstyle ':completion:*' completions 1
zstyle ':completion:*' menu select

setopt globdots
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' file-patterns '*' '.*(N)'

bindkey " " magic-space # do history expansion on space

# Expand ~ to home{{{2
setopt AUTO_PARAM_KEYS  # not quite the same but related

# Show symlinked dirs with @ etc.{{{2
setopt MARK_DIRS

# History{{{2
HISTFILE="$XDG_DATA_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

# Ignore commands with a preceeding space
setopt HIST_IGNORE_SPACE

# Append to the history file, do not overwrite
setopt APPEND_HISTORY

# Share history between sessions immediately
setopt SHARE_HISTORY

# Combine multiline commands into one entry
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# Avoid duplicates
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST

# Add timestamp
setopt EXTENDED_HISTORY

HISTIGNORE_FILE="$XDG_CONFIG_HOME/sh-base/histignore-list"

if [ -f "$HISTIGNORE_FILE" ]; then
	HISTORY_IGNORE="$(grep -vE '^\s*#|^\s*$' "$HISTIGNORE_FILE" | paste -sd: -)"
	export HISTORY_IGNORE
else
	printf "%s\n" "histignore-list not found"
fi

# keybinds{{{2
bindkey -s ^k "tmux-sessionizer.sh\n"
# cli tools eval{{{2
eval "$(zoxide init --cmd cd zsh)" # cd is zoxide and cdi is fzf search of zoxide database
eval "$(navi widget zsh)" #CTRL+G
eval "$(wikiman -W zsh)" #CTRL+F
# uncomment the line below to disable CTRL+T and ALT+C
# FZF_CTRL_T_COMMAND= FZF_ALT_C_COMMAND= source <(fzf --zsh)
source <(fzf --zsh) #ALT+C CTRL+R CTRL+T
# ALT+C default: fzf_cd
# CTRL+R default: fzf_history
# CTRL+T default: fzf_select
# note ** <tab> makes it so fzf is used to fill in so i can use cd **
