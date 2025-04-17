# .profile centralizes the login environment across shells
# XDG Base Directories fallback
#: "${XDG_CONFIG_HOME:=$HOME/.config}"
#: "${XDG_CACHE_HOME:=$HOME/.cache}"
#: "${XDG_DATA_HOME:=$HOME/.local/share}"
#: "${XDG_STATE_HOME:=$HOME/.local/state}"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
