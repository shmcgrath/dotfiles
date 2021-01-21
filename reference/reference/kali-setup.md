# Kali Linux Setup

01. Extract VM to Documents/vm
	- Filename should end in .vmwarevm
02. Launch VMWare Workstation Pro
03. Open VM in VMWare
04. Give VM 8GB of RAM
05. In Settings, go to Options tab.
06. Go to Shared Folders. Make sure Shared Folders is enabled. Add both the vm-share folder and the hacking-security Dropbox folder.
07. Boot the VM
08. change the shell to bash instead of zsh sudo "chsh --shell /bin/bash/ kali"
09. sudo apt update && sudo apt upgrade && sudo apt autoremove
10. restart machine
11. open qterminal and run "sudo apt update && sudo apt upgrade" again
12. echo $SHELL and echo $0 to confirm you are in bash. confirm that you can open the terminal and the file explorer
13. "sudo apt-get install vim-gtk python3-pip flameshot stow"
14. pull down dotfiles to system
15. stow the stow folder from dotfiles manually "stow -v --ignore ".DS_Store" -t ~/ stow"
16. "mv ~/.bashrc ~/.bashrc-default"
17. stow sh-base, sh-bash, and scripts and restart the system
18. run kali-shm.sh

# Kali Notes
- alias for "sudo mount -t fuse.vmhgfs-fuse .host:/ /mnt/hgfs -o allow_other" is kvm
