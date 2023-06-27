export BROWSER=google-chrome
#export BROWSER=chromium
export EDITOR=vim
export LC_TIME=en_GB.UTF-8

export QT_QPA_PLATFORMTHEME=qt5ct

# https://superuser.com/a/1128905
systemctl --user import-environment PATH DBUS_SESSION_BUS_ADDRESS DISPLAY
#systemctl --no-block --user start xsession.target

xrdb -merge ~/.Xresources
#xrdb -merge ~/.colors
#xrdb -merge ~/.colors-dracula
xrdb -merge ~/.colors-zenburn
xmodmap ~/.Xmodmap

# with -a no transparancy, without -a 30fps
#xcompmgr -a &

#xsetroot -cursor_name vanilla-dmz

xset r rate 200 100
#xset m 0 0
xset m 4/3 0
setxkbmap -layout us,ru -variant ,winkeys -option grp:caps_toggle,grp_led:caps,terminate:ctrl_alt_bksp,compose:ralt

# https://www.linux.org.ru/forum/desktop/9112231
xkbcomp $DISPLAY - | egrep -v "group . = AltGr;" | xkbcomp - $DISPLAY

#o2="DisplayPort-0"
#o1="HDMI-A-0"
o2="DP-1"
o1="HDMI-0"
#vo=$(xrandr | grep \ connected | tail -n1 | cut -f1 -d\ )
xrandr --output $o2 --auto --output $o1 --auto --left-of $o2
xrandr --output $o2 --rotate right
#xrandr --output HDMI-0 --set "Broadcast RGB" "Full"
#xrandr --output DP-1 --set "Broadcast RGB" "Full"
#xcalib -d :0 ~/etc/benq_gw2760hs.icc

xinput --set-prop 'Logitech Advanced Corded Mouse M500s' 157 0.3, 0, 0, 0, 0.3, 0, 0, 0, 1

xhost local:boinc

#redshift -l 55.81:37.58 -t 5700:2500 -g 0.6 -m randr &
#redshift -l 55.81:37.58 -t 5700:2500 -g 0.9 -m randr &

#urxvtd -q -f -o

#irxevent -d

kr restart

date >>~/.cache/awesome/log

udiskie -t &
#xbindkeys

xscreensaver -no-splash &

export SSH_AUTH_SOCK=/run/user/$UID/ssh-agent.socket

#export PATH="~/firejail:$PATH"

#exec startlxqt

#if [ "$DISPLAY" = ":0" ]; then
    awesome >>~/.cache/awesome/log 2>&1
#else
#    qtile
#fi

#exec startkde
