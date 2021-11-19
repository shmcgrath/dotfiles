if [ -d "$HOME/bin/ssh-askpass" ]; then
	echo "$HOME/bin/ssh-askpass exists"
else
	mkdir -p "$HOME/bin/ssh-askpass"
fi

if [ -d "/usr/lib/ssh/x11-ssh-askpass" ]; then
	echo "x11-ssh-askpass appears to be installed"
else
	echo "x11-ssh-askpass needs to be installed"
	doas pacman -S x11-ssh-askpass
fi

echo "linking ssh-askpass to ~/bin..."
ln -sv /usr/lib/ssh/x11-ssh-askpass ~/bin/ssh-askpass

echo "make sure 'export SSH_ASKPASS=ssh-askpass' is in .xinitrc"
echo "make sure that ssh-askpass Xresources is sourced in .Xresources"
