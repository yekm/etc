export BROWSER=google-chrome
export EDITOR=vim

xrdb -merge ~/.Xresources
xmodmap ~/.Xmodmap

#xsetroot -cursor_name vanilla-dmz

xset r rate 200 100

urxvtd -q -f -o
date >>~/.cache/awesome/log
ssh-agent awesome >>~/.cache/awesome/log 2>&1

