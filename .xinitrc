#export BROWSER=google-chrome
export BROWSER=chromium
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

redshift -l 55.81:37.58 -t 5700:3600 -g 0.8 -m randr &

date >>~/.log/awesome

#exec startlxqt

#if [ "$DISPLAY" = ":0" ]; then
    awesome >>~/.cache/awesome/log 2>&1
#else
#    qtile
#fi

