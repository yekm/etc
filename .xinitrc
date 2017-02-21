export BROWSER=google-chrome
#export BROWSER=chromium
export EDITOR=vim

xrdb -merge ~/.Xresources
xrdb -merge ~/.colors
xmodmap ~/.Xmodmap

#xsetroot -cursor_name vanilla-dmz

xset r rate 200 100
#xset m 0 0
xset m 4/3 0
setxkbmap -layout us,ru -variant ,winkeys -option grp:caps_toggle,grp_led:caps,terminate:ctrl_alt_bksp,compose:ralt

# https://www.linux.org.ru/forum/desktop/9112231
xkbcomp $DISPLAY - | egrep -v "group . = AltGr;" | xkbcomp - $DISPLAY

vo=$(xrandr | grep \ connected | cut -f1 -d\ )
xrandr --output $vo --set "Broadcast RGB" "Full"

xhost local:boinc

urxvtd -q -f -o
date >>~/.cache/awesome/log
ssh-agent awesome >>~/.cache/awesome/log 2>&1

