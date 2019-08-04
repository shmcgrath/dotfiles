export LANG=en_US.UTF-8
export ENV=$HOME/.kshrc
xrdb -merge $HOME/.Xresources
xsetroot -solid dimgray
xidle &
LANG= xclock -strftime "%a %Y-%m-%d %I:%M%p" &
setxkbmap -option ctrl:nocaps
exec cwm
