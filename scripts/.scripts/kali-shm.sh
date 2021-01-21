cd $HOME
sudo mkdir /mnt/hgfs
sudo mount -t fuse.vmhgfs-fuse .host:/ /mnt/hgfs -o allow_other
echo 'ls /mnt/hgfs:'
ls /mnt/hgfs
ln --symbolic /mnt/hgfs/hacking-security $HOME/hacking-security
ln --symbolic /mnt/hgfs/vm-share $HOME/vm-share
mkdir $HOME/Dropbox
ln --symbolic $HOME/hacking-security/bash-logs $HOME/Dropbox/bash-history 
cd $HOME/dotfiles
stow git -t $HOME
stow vim -t $HOME
stow tmux -t $HOME
stow reference -t $HOME
stow bookmarks -t $HOME
