
while true; do
    xclip -o
    echo
    sleep 0.1
done | stdbuf -o0 -i0 uniq | tee /tmp/xclip_grab_$(date +%F_%R)
