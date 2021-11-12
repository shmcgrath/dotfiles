if [ -d "$HOME/.shm/bash_functions/pathCheckSet.sh" ]; then
	source "$HOME/.shm/bash_functions/pathCheckSet.sh"
	pathCheckSet $HOME/.shm/scripts
elif [ -d "$HOME/.shm/scripts" ]; then
	PATH="$HOME/.scripts:${PATH}"
else
	echo "no script folder added to PATH via .xinitrc"
fi
qtile start
