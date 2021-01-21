#!/usr/bin/env bash
tmux has-session -t red 2>/dev/null
if [ $? != 0 ]; then
    tmux new-session -s red -n vpn -d
    tmux send-keys -t red "cd $HOME/hacking-security/vpn" C-m
    tmux send-keys -t red "echo 'to connect to vpn sudo openvpn'" C-m
	tmux new-window -n scratchpad -t red
	tmux split-window -v -p 50 -t red:2
	tmux send-keys -t red:2.2 "cd $HOME/hacking-security" C-m
	tmux new-window -n enumeration -t red
    tmux select-window -t red:22
    tmux select-pane -t red:2.2
fi
tmux attach -t red
