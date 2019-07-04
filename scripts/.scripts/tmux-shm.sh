#!/usr/bin/env bash
tmux has-session -t shm 2>/dev/null
if [ $? != 0 ]; then
    tmux new-session -s shm -n shell-note-dot -d
    tmux send-keys -t shm "cd $HOME" C-m
    tmux split-window -v -p 30 -t shm
    tmux send-keys -t shm:1.2 "cd $HOME/Dropbox/notes" C-m
    tmux split-window -h -p 50 -t shm:1.2
    tmux send-keys -t shm:1.3 "cd $HOME/Dropbox/dotfiles" C-m
    if [ -d "$HOME/projects" ]; then
        tmux new-window -n dev -t shm
        tmux send-keys -t shm:2 "cd $HOME/projects" C-m
        tmux split-window -v -p 30 -t shm:2
        tmux send-keys -t shm:2.2 "cd $HOME/projects" C-m
    else
        if [ -d "$HOME/Documents/projects" ]; then
            tmux new-window -n dev -t shm
            tmux send-keys -t shm:2 "cd $HOME/Documents/projects/" C-m
            tmux split-window -h -p 30 -t shm:2
            tmux send-keys -t shm:2.2 "cd $HOME/Documents/projects/" C-m
        fi
    fi 
    tmux select-window -t shm:1
    tmux select-pane -U
fi
tmux attach -t shm
