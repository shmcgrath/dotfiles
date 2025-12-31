# source shbaserc
if [ -f "$XDG_CONFIG_HOME/sh-base/shbaserc" ]; then
    . "$XDG_CONFIG_HOME/sh-base/shbaserc"
else
	printf 'Warning: %s not found\n' "$XDG_CONFIG_HOME/sh-base/shbaserc"
fi

# prompt and vim mode{{{2
# Set vi keybindings
bindkey -v

# Base prompt definition — set once
PROMPT_HEADER=$'_______________________\n'
PROMPT_MAIN=$'%~\n%n@%m \$ '

# This will be prepended by the mode (e.g., [I] or [N])
function set_prompt {
  PROMPT="${1}${PROMPT_HEADER} ${PROMPT_MAIN}"
}

# Function to show current vi mode in prompt
function zle-keymap-select {
  local mode=""
  case $KEYMAP in
    vicmd) mode="%F{green}[N]%f " ;;  # Normal mode
    viins) mode="%F{blue}[I]%f " ;;   # Insert mode
  esac

  set_prompt "$mode"
  zle reset-prompt
}
zle -N zle-keymap-select

# Ensure a prompt is initially set on shell startup
function precmd_update_prompt {
  # Default to insert mode on startup
  set_prompt "%F{blue}[I]%f "
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd precmd_update_prompt

#readline equivalent{{{2
autoload -Uz up-line-or-search down-line-or-search
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

bindkey -M vicmd 'k' up-line-or-history
bindkey -M vicmd 'j' down-line-or-history

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

# Expand ~ to home{{{2
setopt AUTO_PARAM_KEYS  # not quite the same but related

# Show symlinked dirs with @ etc.{{{2
setopt MARK_DIRS

# History{{{2
HISTFILE="$XDG_DATA_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

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

# keybinds{{{2
bindkey -s ^f "tmux-sessionizer.sh\n"
# cli tools eval{{{2
eval "$(zoxide init --cmd cd zsh)"
eval "$(navi widget zsh)" #CTRL+G
lfcd () {
    # `command` is needed in case `lfcd` is aliased to `lf`
    cd "$(command lf -print-last-dir "$@")"
}
