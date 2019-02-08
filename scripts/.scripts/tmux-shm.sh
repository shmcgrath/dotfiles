#/bim.bash
tmux has-session -t shm 2>/dev/null
if [ $? != 0 ]; then
    tmux new-session -s shm -n shell-notes -d
    tmux send-keys -t shm "cd $HOME" C-m
    tmux split-window -v -p 20 -t shm
    tmux send-keys -t shm:1.2 "cd $HOME/Dropbox/notes" C-m
    if [ -d "$HOME/projects" ]; then
        tmux new-window -n dev -t shm
        tmux send-keys -t shm:2 "cd $HOME/projects" C-m
        tmux split-window -v -p 50 -t shm:2
        tmux send-keys -t shm:2.2 "cd $HOME/projects" C-m
    else
        if [ -d "$HOME/Documents/projects" ]; then
            tmux new-window -n dev -t shm
            tmux send-keys -t shm:2 "cd $HOME/Documents/projects/" C-m
            tmux split-window -v -p 50 -t shm:2
            tmux send-keys -t shm:2.2 "cd $HOME/Documents/projects/" C-m
        fi
    fi 
    tmux select-window -t shm:1
    tmux select-pane -U
fi
tmux attach -t shm
