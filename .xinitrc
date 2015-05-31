export BROWSER=google-chrome
#export BROWSER=chromium
export EDITOR=vim

xrdb -merge ~/.Xresources
xmodmap ~/.Xmodmap

#xsetroot -cursor_name vanilla-dmz

xset r rate 200 100
xset m 0 0
setxkbmap -layout us,ru -variant ,winkeys -option grp:caps_toggle,grp_led:scroll,terminate:ctrl_alt_bksp,compose:ralt
xrandr --output HDMI-3 --set "Broadcast RGB" "Full"

urxvtd -q -f -o
date >>~/.cache/awesome/log
ssh-agent awesome >>~/.cache/awesome/log 2>&1

ps axf | egrep chrom | awk '{print $1}' | xargs kill &
sleep 3 && ps axf | egrep chrom | awk '{print $1}' | xargs kill -9 &

