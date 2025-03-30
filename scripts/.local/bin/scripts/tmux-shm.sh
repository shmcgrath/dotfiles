#!/usr/bin/env bash

tmux has-session -t shm 2>/dev/null
if [ $? != 0 ]; then
    tmux new-session -s shm -n irc-rss -d
	tmux send-keys -t shm:1 "tiny" C-m
	tmux split-window -v -p 50 -t shm:1
	tmux send-keys -t shm:1.2 "newsboat" C-m
	tmux new-window -n mail -t shm
	tmux send-keys -t shm:2 "neomutt" C-m
	tmux new-window -n notes -t shm
	if [ -d "$HOME/Dropbox/obsidian/shm" ]; then
		tmux send-keys -t shm:3 "cd $HOME/Dropbox/shm" C-m
	fi
	tmux new-window -n files -t shm
    if [ -d "$HOME/projects" ]; then
        tmux new-window -n dev -t shm
        tmux send-keys -t shm:5 "cd $HOME/projects" C-m
    else
        if [ -d "$HOME/Documents/projects" ]; then
            tmux new-window -n dev -t shm
            tmux send-keys -t shm:5 "cd $HOME/Documents/projects/" C-m
        fi
    fi
    tmux select-window -t shm:1
    tmux select-pane -U
fi

tmux has-session -t red 2>/dev/null
if [ $? != 0 ]; then
    tmux new-session -s red -n vpn-tools -d
    tmux send-keys -t red "cd $HOME/hacking-security/vpn" C-m
    tmux send-keys -t red "echo 'to connect to vpn sudo openvpn'" C-m
	tmux split-window -v -p 50 -t red:1
	tmux send-keys -t red:1.2 "cd $HOME/bin" C-m
	tmux split-window -h -p 30 -t red:1.1
    tmux send-keys -t red "cd $HOME/dotfiles" C-m
    tmux select-pane -t red:1.1
	tmux new-window -n scratchpad -t red
	tmux split-window -v -p 50 -t red:2
	tmux send-keys -t red:2.2 "cd $HOME/hacking-security" C-m
	tmux send-keys -t red:2.2 "vim oscp.md" C-m
	tmux new-window -n enumeration -t red
    tmux select-window -t red:2
    tmux select-pane -t red:2.1
fi

tmux attach -t shm
