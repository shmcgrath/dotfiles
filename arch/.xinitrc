if [ -d "$HOME/.shm/bash_functions/pathCheckSet.sh" ]; then
	source "$HOME/.shm/bash_functions/pathCheckSet.sh"
	pathCheckSet $HOME/.shm/scripts
elif [ -d "$HOME/.shm/scripts" ]; then
	PATH="$HOME/.shm/scripts:${PATH}"
else
	echo "no script folder added to PATH via .xinitrc"
fi

# rotate right monitor to vertical postition
xrandr --output DP-2 --rotate left

# check for and merge .Xresrouces
# -merge option indicates that the input should be merged and lexicographically sorted with,
# instead of replacing, the current contents of the specified properties.
# -I$HOME This option is passed through to the preprocessor and is used to specify
# a directory to search for files that are referenced with #include.
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# set askpass program name
#export SSH_ASKPASS=ssh-askpass

#qtile start
exec awesome
