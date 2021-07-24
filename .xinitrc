export BROWSER=google-chrome
#export BROWSER=chromium
export EDITOR=vim
export LC_TIME=en_GB.UTF-8

export QT_QPA_PLATFORMTHEME=qt5ct

# https://superuser.com/a/1128905
systemctl --user import-environment PATH DBUS_SESSION_BUS_ADDRESS DISPLAY
#systemctl --no-block --user start xsession.target

xrdb -merge ~/.Xresources
xrdb -merge ~/.colors
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

#vo=$(xrandr | grep \ connected | cut -f1 -d\ )
#xrandr --output $vo --auto --set "Broadcast RGB" "Full" --output HDMI1 --auto --right-of VGA1
xrandr --output HDMI-0 --auto --output HDMI3 --auto  --right-of HDMI-0
#xrandr --output HDMI-0  --rotate right
xrandr --output HDMI3 --set "Broadcast RGB" "Full"
#xcalib -d :0 ~/etc/benq_gw2760hs.icc

xhost local:boinc

#redshift -l 55.81:37.58 -t 5700:2500 -g 0.6 -m randr &
redshift -l 55.81:37.58 -t 5700:2500 -g 0.9 -m randr &

urxvtd -q -f -o

#irxevent -d

kr restart

date >>~/.cache/awesome/log

udiskie -t &
#xbindkeys

#export PATH="~/firejail:$PATH"

#exec startlxqt

#if [ "$DISPLAY" = ":0" ]; then
    awesome >>~/.cache/awesome/log 2>&1
#else
#    qtile
#fi

#exec startkde
