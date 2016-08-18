export EDITOR=vim
export TERMINAL=urxvt

xrdb -merge ~/.Xresources
xrdb -merge ~/.colors
xmodmap ~/.Xmodmap

#xsetroot -cursor_name vanilla-dmz

xset r rate 200 100
xset m 0 0
setxkbmap -layout us,ru -variant ,winkeys -option grp:caps_toggle,grp_led:scroll,terminate:ctrl_alt_bksp,compose:ralt
#xrandr --output HDMI-0 --set "Broadcast RGB" "Full"
xrandr --output HDMI-1 --set "Broadcast RGB" "Full" --auto --output VGA-1 --auto --right-of HDMI-1
#xrandr --output VGA-0 --auto --output HDMI-0 --auto --left-of VGA-0

urxvtd -q -f -o
date >>~/.local/share/awesome.log
ssh-agent awesome >>~/.local/share/awesome.log 2>&1
#ssh-agent i3 -V >>~/.local/share/i3.log 2>&1

