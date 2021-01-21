sudo mkdir /mnt/hgfs
sudo mount -t fuse.vmhgfs-fuse .host:/ /mnt/hgfs -o allow_other
ls /mnt/hgfs

#cd $HOME/dotfiles
#stow git -t $HOME
#stow vim -t $HOME
#stow 
