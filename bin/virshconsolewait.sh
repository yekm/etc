set -u

name=$1
while true; do
    pgrep -f $name, && virsh  -c qemu:///system console $name
    sleep 0.1
    #reset
done
