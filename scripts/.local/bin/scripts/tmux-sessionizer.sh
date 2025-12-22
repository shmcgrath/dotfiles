#!/usr/bin/env bash

# Based off of ThePrimeagen's tmux-sessionizer https://github.com/ThePrimeagen/tmux-sessionizer

sessionizer_dir="$XDG_CONFIG_HOME/tmux/sessionizer"

switch_to() {
    if [[ -z $TMUX ]]; then
        tmux attach-session -t $1
    else
        tmux switch-client -t $1
    fi
}

has_session() {
    tmux list-sessions | grep -q "^$1:"
}

load_session_config() {
    if [ -f "$2/.tmux-sessionizer" ]; then
        tmux send-keys -t $1 "source $2/.tmux-sessionizer" C-m
		return
	fi

	if [ -f "${sessionizer_dir}/$1" ]; then
		if [ -x "${sessionizer_dir}/$1" ]; then
			"${sessionizer_dir}/$1"
		else
			tmux source-file "${sessionizer_dir}/$1"
		fi
		return
	fi

    if [ -f "${sessionizer_dir}/default" ]; then
        tmux send-keys -t $1 "source ${sessionizer_dir}/default" C-m
    fi
}

if [[ $# -eq 1 ]]; then
    selected=$1
else
	current_sessions=$(tmux list-sessions | cut -d: -f1)
	presets=$(find -L "${sessionizer_dir}" -type f -exec basename {} \;)

	session_entries=""

	for session in $current_sessions; do
		session_entries+="tmux:$session"$'\n'
	done

	for preset in $presets; do
		if ! printf "$current_sessions" | grep -qx "$preset"; then
			session_entries+="preset:$preset"$'\n'
		fi
	done

    dirs=$(find ~/projects ~/ -mindepth 1 -maxdepth 1 -type d)
	actions=$(printf "action:reload-config")
	selected=$(printf "%s\n%s\n%s\n" "$session_entries" "$actions" "$dirs" | awk 'NF' | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

case "$selected" in
    tmux:*|preset:*)
        selected_name="${selected#*:}"
        ;;
    *)
        selected_name="$(basename "$selected")"
        ;;
esac

selected_name="${selected_name//./_}"
tmux_running=$(pgrep tmux)

# action: reload config
if [[ $selected == action:reload-config ]]; then
	if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
		printf "\n%s" "No tmux server running, cannot reload config."
	else
		tmux source-file "$XDG_CONFIG_HOME/tmux/tmux.conf"
		tmux display-message "tmux config reloaded"
	fi
	exit 0
fi

if [[ $selected == tmux:* ]]; then
	session_name="${selected#tmux:}"
	switch_to "$session_name"
	exit 0
fi

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    load_session_config $selected_name $selected
    exit 0
fi

if ! has_session $selected_name; then
    tmux new-session -ds $selected_name -c $selected
    load_session_config $selected_name $selected
fi

switch_to $selected_name
