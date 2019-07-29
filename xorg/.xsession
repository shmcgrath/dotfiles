export LANG=en_US.UTF-8
export ENV=$HOME/.kshrc
xrdb -merge $HOME/.Xresources
xrdb -merge $HOME/.themes/papercolor-dark-xterm
xrdb -merge $HOME/.themes/papercolor-dark-URxvt
xrdv -merge $HOME/.URxvt-Xresources
xsetroot -solid dimgray
xidle &
LANG= xclock -strftime "%a %Y-%m-%d %I:%M%p" &
setxkbmap -option ctrl:nocaps
exec cwm
