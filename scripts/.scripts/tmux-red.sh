#!/usr/bin/env bash
tmux has-session -t red 2>/dev/null
if [ $? != 0 ]; then
    tmux new-session -s red -n shell-note -d
    tmux send-keys -t shm "cd $HOME" C-m
	tmux new-window -n vpn -t red
    #tmux send-keys -t shm:1.2 "cd $HOME/Dropbox/notes" C-m
    tmux select-window -t red:1
    #tmux select-pane -U
fi
tmux attach -t red
