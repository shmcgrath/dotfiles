if [ -d "$XDG_CONFIG_HOME/bash_functions/pathCheckSet.sh" ]; then
	source "$XDG_CONFIG_HOME/bash_functions/pathCheckSet.sh"
	pathCheckSet $HOME/.local/bin/"
elif [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:${PATH}"
else
	echo "no $HOME/.local/bin folder added to PATH via .xinitrc"
fi

# rotate right monitor to vertical postition
xrandr --output DP-2 --rotate left

# check for and merge .Xresrouces
# -merge option indicates that the input should be merged and lexicographically sorted with,
# instead of replacing, the current contents of the specified properties.
# -I$HOME This option is passed through to the preprocessor and is used to specify
# a directory to search for files that are referenced with #include.
[[ -f "$XDG_CONFIG_HOME/X11/.Xresources ]] && xrdb -merge -I$HOME $XDG_CONFIG_HOME/X11/.Xresources

# set askpass program name
#export SSH_ASKPASS=ssh-askpass

#qtile start
exec awesome

# vim:ft=cfg:
