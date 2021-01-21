#!/usr/bin/env bash
tmux has-session -t red 2>/dev/null
if [ $? != 0 ]; then
    tmux new-session -s red -n vpn -d
    tmux send-keys -t red "cd $HOME/hacking-security/vpn" C-m
    tmux send-keys -t red "echo 'to connect to vpn sudo openvpn'" C-m
	tmux new-window -n enumeration -t red
    tmux select-window -t red:1
    #tmux select-pane -U
fi
tmux attach -t red
