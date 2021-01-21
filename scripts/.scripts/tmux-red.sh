#!/usr/bin/env bash
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
tmux attach -t red
