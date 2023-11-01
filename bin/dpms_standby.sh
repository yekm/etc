xinput disable 'Logitech Advanced Corded Mouse M500s'
xinput disable 'pointer:Razer Razer DeathAdder Essential'
xinput disable 'Kensington Slimblade Trackball'

xset dpms force standby

while true; do
    status="$(xset q)"
    
    if [[ $status == *"Monitor is On"* ]]; then
        xinput enable 'Logitech Advanced Corded Mouse M500s'
        xinput enable 'Kensington Slimblade Trackball'
        xinput enable 'pointer:Razer Razer DeathAdder Essential'
        exit
    fi

    #if [[ $status == *"Monitor is Off"* ]]; then
    #    
    #fi

    sleep 0.1
done
