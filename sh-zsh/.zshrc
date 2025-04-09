# prompt and vim mode
# Set vi keybindings
bindkey -v

# Secondary prompt (for line continuation)
PS2="continue --> "

# Function to build the full prompt dynamically
function update_prompt {
  local datetime=$(date '+%a %Y.%m.%d %H:%M:%S')
  PROMPT_BASE="%F{white}%n@%m:%~%f %#"
  PROMPT="_______________________
$datetime || %~"
  zle-keymap-select  # apply mode-specific prefix
}

# Show current vi mode in prompt
function zle-keymap-select {
  case $KEYMAP in
    vicmd) PROMPT="%F{green}[N]%f $PROMPT\n$PROMPT_BASE" ;;
    viins) PROMPT="%F{blue}[I]%f $PROMPT\n$PROMPT_BASE" ;;
  esac
  zle reset-prompt
}

# Hook to update prompt before each display
autoload -Uz add-zsh-hook
add-zsh-hook precmd update_prompt
zle -N zle-keymap-select

#readline equivalent
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

# Expand ~ to home
setopt AUTO_PARAM_KEYS  # not quite the same but related

# Show symlinked dirs with @ etc.
setopt MARK_DIRS

# History
HISTFILE="$XDG_DATA_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

eval "$(zoxide init --cmd cd zsh)"
