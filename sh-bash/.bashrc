# .bashrc{{{1

# SECTIONS:
# ==Environment
# ==Source Bash Functions
# ==Path
# ==PROMPT
# Make Terminal Better (remapping defaults and adding functionality)
# File and Folder Management
# Searching
# Networking
# System Operations & Information
# Python
# Reminders & Notes

# ==Environment{{{2
export VISUAL=vim
export EDITOR="$VISUAL"
export PAGER="less"
#export OPENER="xdg-open"
export RANGER_LOAD_DEFAULT_RC=FALSE
export NOTES=$HOME/Dropbox/notes
# Other XDG paths
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_STATE_HOME=${XDG_STATE_HOME:="$HOME/.local/state"}



# Set default blocksize for ls, df, du
# from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
export BLOCKSIZE=1k

# ==Source Bash Functions{{{2
if [ -d "$XDG_CONFIG_HOME/bash_functions" ]; then
	for functionFile in "$XDG_CONFIG_HOME/bash_functions"/*; do
		if [ -f "$functionFile" ]; then
			source "$functionFile"
		fi
	done
else
	echo ".shm/bash_functions is missing!"
fi

# ==Path{{{2
pathCheckSet "$HOME/.local/bin/scripts"
pathCheckSet "$HOME/bin"
echo 'PATH: '$PATH

# ==PROMPT{{{2
[[ -f "$HOME/.shm/sh-base/promptrc" ]] && source $HOME/.shm/sh-base/promptrc && echo 'sourcing $HOME/.shm/sh-base/promptrc'


# ==HISTORY{{{2
export HISTIGNORE="ls:ll:cd:pwd:history:ranger:lf:cls:pacsyu"
export HISTFILESIZE=100000
export HISTSIZE=100000
export HISTCONTROL="ignoredups:erasedups"
export HISTTIMEFORMAT="%F %T " # timestamp to histroy
shopt -s histappend # append to history, don't overwrite it
shopt -s cmdhist # store multi-line commands in one histroy entry
export PROMPT_COMMAND='history -a; history -r'
export HISTFILE="$XDG_DATA_HOME"/bash/.bash_history

# Paths
function nonzero_return() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo "$RETVAL"
}

# ==ALIASES{{{2
[[ -f "$HOME/.shm/sh-base/aliasrc" ]] && source $HOME/.shm/sh-base/aliasrc && echo 'sourcing $HOME/.shm/sh-base/aliasrc'

alias ll='ls -FGlAhp --time-style=long-iso --color'
alias ls='ls -x --classify --almost-all --group-directories-first --color' # -x list entries by lines instead of cols
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -selection clipboard -o"
alias sbrc="source ~/.bashrc && echo 'sourcing $HOME/.bashrc'" # reloads bashrc
cdll() { builtin cd "$@"; ll; }             # Always list directory contents upon 'cd'

# ==PASTEBIN{{{2
# Paste file to https://paste.rs
function pastebin() {
	local pastefile=${1:-/dev/stdin}
	curl --data-binary @${pastefile} https://paste.rs
}

# FILE AND FOLDER MANAGEMENT{{{2

zipf () { zip -r "$1".zip "$1" ; } # zipf: To create a ZIP archive of a folder
alias numFiles='echo $(ls -1 | wc -l)' # numFiles: Count of non-hidden files in current dir
alias make1mb='mkfile 1m ./1MB.dat' # make1mb: Creates a file of 1mb size (all zeros)
alias make5mb='mkfile 5m ./5MB.dat' # make5mb: Creates a file of 5mb size (all zeros)
alias make10mb='mkfile 10m ./10MB.dat' # make10mb: Creates a file of 10mb size (all zeros)

# extract: Extract most know archives with one command
# ==========
extract () {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2) tar xjf $1 ;;
			*.tar.gz) tar xzf $1 ;;
			*.bz2) bunzip2 $1 ;;
			*.rar) unrar e $1 ;;
			*.gz) gunzip $1 ;;
			*.tar) tar xf $1 ;;
			*.tbz2) tar xjf $1 ;;
			*.tgz) tar xzf $1 ;;
			*.zip) unzip $1 ;;
			*.Z) uncompress $1 ;;
			*.7z) 7z x $1 ;;
			*) echo "'$1' cannot be extracted via extract()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

# md5check: checks the md5sum of a file by hand
md5check() {
	md5sum "$1" | grep "$2";
}

# SEARCHING{{{2

alias qfind="find . -iname "                 # qfind:    Quickly search for file
ff () { /usr/bin/find . -iname "$@" ; }      # ff:       Find file under the current directory
ffs () { /usr/bin/find . -iname "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -iname '*'"$@" ; }  # ffe:      Find file whose name ends with a given string
ffc () { /usr/bin/find . -iname '*'"$@"'*' ; }  # ffc: Find file whose name contains a given string

#   spotlight: Search for a file using MacOS Spotlight's metadata
spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }

# REMINDERS & NOTES{{{2
# ==========
# remove_disk: spin down unneeded disk
# ==========
# diskutil eject /dev/disk1s3
# to change the password on an encrypted disk image:
# ==========
# hdiutil chpass /path/to/the/diskimage
# to mount a read-only disk image as read-write:
# hdiutil attach example.dmg -shadow /tmp/example.shadow -noverify
# mounting a removable drive (of type msdos or hfs)
# ==========
# mkdir /Volumes/Foo
# ls /dev/disk*   to find out the device to use in the mount command)
# mount -t msdos /dev/disk1s1 /Volumes/Foo
# mount -t hfs /dev/disk1s1 /Volumes/Foo
# to create a file of a given size: /usr/sbin/mkfile or /usr/bin/hdiutil
# ==========
# e.g.: mkfile 10m 10MB.dat
# e.g.: hdiutil create -size 10m 10MB.dmg
# the above create files that are almost all zeros - if random bytes are desired
# then use: ~/Dev/Perl/randBytes 1048576 > 10MB.dat
# bash_profile vs bashrc http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html

# == Source fzf colors

[[ -f "$HOME/.shm/themes/dracula-fzf" ]] && source $HOME/.shm/themes/dracula-fzf

# ==Autostart X at login{{{2
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx "$XDG_CONFIG_HOME/X11/.xinitrc"
fi
# ==ZSH as Interactive Shell{{{2
#exec zsh
