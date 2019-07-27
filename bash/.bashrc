# Sarah H. McGrath .bashrc{{{1
# I took this layout and some settings from:
# References:
#  [natelandau/.bash_profile](https://gist.github.com/natelandau/10654137/)
#
# Sections:
# Environment Configuration
# Make Terminal Better (remapping defaults and adding functionality)
# File and Folder Management
# Searching
# Process Management
# Networking
# System Operations & Information
# git
# Python
# tmux
# Reminders & Notes

# ENVIRONMENT CONFIGURATION{{{2

# Change Prompt
export PS1="________________________________________________________________________________\n\D{%a %Y-%m-%d %H:%M:%S}\n\w\n[\u@\h]$ "
export PS2="continue-> "

# PROMPT_COMMAND
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(hostname) $(pwd) $(history 1)" >> ~/Dropbox/bash-history/bash-log-$(date "+%Y-%m").log; fi'

# Set Default Editor
export VISUAL=vim
export EDITOR="$VISUAL"
export RANGER_LOAD_DEFAULT_RC=FALSE
export NOTES=$HOME/Dropbox/notes

#   Set default blocksize for ls, df, du
#   from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
export BLOCKSIZE=1k

# History Size
export HISTIGNORE="ls:ll:cd:pwd"
export HISTFILESIZE=100000
export HISTSIZE=100000
export HISTCONTROL="ignoredups:erasedups"
shopt -s histappend                      # append to history, don't overwrite it

# Paths
function nonzero_return() {
RETVAL=$?
[ $RETVAL -ne 0 ] && echo "$RETVAL"
}

function grep_bash_history() {
#alias gbl="grep -h logcat ~/Dropbox/bash-history/bash-log-*"
args=("$@")
grepTerm=${args[0]}
grep -h $grepTerm ~/Dropbox/bash-history/*
}

# MAKE TERMINAL BETTER{{{2
alias ":q"="exit"
alias pbc="pbcopy"
alias pbcopy="xclip -selection clipboard"
alias pbp="pbpaste"
alias pbpaste="xclip -selection clipboard -o"
alias dropbox='dropbox.py'
alias b64='base64 -o b64 -i'
alias ytdl='youtube-dl'
alias makemkv='makemkvcon' #alias not rememberable makemkv command
alias aln='w3m https://www.archlinux.org/news/' #Get archlinux news
alias pacsyu='aln && sudo pacman -Syu'      # get arch news and syu
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp --time-style=long-iso'                       # Preferred 'ls' implementation
cdll() { builtin cd "$@"; ll; }             # Always list directory contents upon 'cd'
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias .1='cd ../'                           # Go back 1 directory level
alias .2='cd ../../'                        # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias findo='open -a Finder ./'             # findo:    Opens current directory in MacOS Finder
alias ~="cd ~"                              # ~:        Go Home
alias ~r="cd ~ && ranger"                   # Go home and launch ranger
alias ~d="cd ~/Dropbox"						# ~d:		Go to Dropbox
alias ~ddf="cd ~/Dropbox/dotfiles"          # ~ddf:     Go to Dotfiles
alias ~dl="cd ~/Downloads"					# ~dl:		Go to Downloads
alias ~dn="cd ~/Dropbox/notes"			    # ~dn:	    Go to Notes directory
alias ~dnt="cd ~/Dropbox/notes/00-tasks"    # ~dnt:	    Go to tasks directory
alias ~bean="cd ~/Dropbox/beancount"        # ~bean:    Go to beancount directory
alias ~dc="cd ~/Dropbox/code"                # ~dc       Go to code directory
alias cls='clear'							# cls:      Clear terminal display
alias hst='history'						# hist:		Show command history
alias ghst="history | grep"				# histg:	Search through command history
alias gbh="grep_bash_history"
alias j='jobs -1'							# j:		Show jobs
alias DT='tee ~/Desktop/terminalOut.txt'    # DT:       Pipe content to file on MacOS Desktop
alias sbrc='source ~/.bash_profile'			# rerc:		Reloads bash_profile and bashrc
alias ztest='ls -a'							# ztest:	List used for testing of reload
alias disk?='df -h'                         # disk?:    Shows disk space and percentage used
alias weather='curl wttr.in/Pittsburgh?q'   # weather   Weather in Pittsburgh
alias bcs='brew cask search'               # bcs: brew cask search
alias bci='brew cask install'              # bci: brew cask install
alias dockstart='sudo docker start rtorrentOPEN rtorrentCAN plex fava calibre-comics calibre-library organizr tautulli home-assistant huginn'
# FILE AND FOLDER MANAGEMENT{{{2

zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder
alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir
alias make1mb='mkfile 1m ./1MB.dat'         # make1mb:      Creates a file of 1mb size (all zeros)
alias make5mb='mkfile 5m ./5MB.dat'         # make5mb:      Creates a file of 5mb size (all zeros)
alias make10mb='mkfile 10m ./10MB.dat'      # make10mb:     Creates a file of 10mb size (all zeros)

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
extract () {
if [ -f $1 ] ; then
  case $1 in
    *.tar.bz2)   tar xjf $1     ;;
    *.tar.gz)    tar xzf $1     ;;
    *.bz2)       bunzip2 $1     ;;
    *.rar)       unrar e $1     ;;
    *.gz)        gunzip $1      ;;
    *.tar)       tar xf $1      ;;
    *.tbz2)      tar xjf $1     ;;
    *.tgz)       tar xzf $1     ;;
    *.zip)       unzip $1       ;;
    *.Z)         uncompress $1  ;;
    *.7z)        7z x $1        ;;
    *)     echo "'$1' cannot be extracted via extract()" ;;
     esac
 else
     echo "'$1' is not a valid file"
 fi
}
# md5check: checks the md5sum of a file by hand
md5check() { md5sum "$1" | grep "$2";}

# SEARCHING{{{2

alias qfind="find . -name "                 # qfind:    Quickly search for file
ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

#   spotlight: Search for a file using MacOS Spotlight's metadata
spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }

# PROCESS MANAGEMENT{{{2

# NETWORKING{{{2
alias myip="curl icanhazip.com/s"				#Get current public IP address

# SYSTEMS OPERATIONS & INFORMATION{{{2

#   finderShowHidden:   Show hidden files in Finder
#   finderHideHidden:   Hide hidden files in Finder
alias finderShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'
alias finderHideHidden='defaults write com.apple.finder ShowAllFiles FALSE'

# PYTHON{{{2
alias py2="python2"
alias py3="python3"
alias dex='deactivate && exit'				# dex:		deactivate && exit for virtualenv
alias pei='pipenv install'					# pei:		pipenv install for pipenv
alias pes='pipenv shell'					# pes:		pipenv shell for pipenv
alias mvenv="python3 -m venv env"            # make virutal encironment
alias avenv="source env/bin/activate"        # activate virtual environment
alias dvenv="deactivate"                    #deactivate virtual encironment

# TMUX{{{2
#alias tmux="tmux -2"                            #tmux:      set 256 colors by default
# REMINDERS & NOTES{{{2
#   ---------------------------------------

#   remove_disk: spin down unneeded disk
#   ---------------------------------------
#   diskutil eject /dev/disk1s3

#   to change the password on an encrypted disk image:
#   ---------------------------------------
#   hdiutil chpass /path/to/the/diskimage

#   to mount a read-only disk image as read-write:
#   ---------------------------------------
#   hdiutil attach example.dmg -shadow /tmp/example.shadow -noverify

#   mounting a removable drive (of type msdos or hfs)
#   ---------------------------------------
#   mkdir /Volumes/Foo
#   ls /dev/disk*   to find out the device to use in the mount command)
#   mount -t msdos /dev/disk1s1 /Volumes/Foo
#   mount -t hfs /dev/disk1s1 /Volumes/Foo

#   to create a file of a given size: /usr/sbin/mkfile or /usr/bin/hdiutil
#   ---------------------------------------
#   e.g.: mkfile 10m 10MB.dat
#   e.g.: hdiutil create -size 10m 10MB.dmg
#   the above create files that are almost all zeros - if random bytes are desired
#   then use: ~/Dev/Perl/randBytes 1048576 > 10MB.dat


# bash_profile vs bashrc http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html
