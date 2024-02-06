set -vx

while read msg; do
    echo "message: $msg"
    virsh -c qemu:///system $msg
done < <(nbutton "start archlinux-swmac1" "destroy archlinux-swmac1")

exit

while read msg; do
    echo "message: $msg"
    virsh -c qemu:///system $msg
done < <(nbutton "start archlinux-a1" "destroy archlinux-a1" "start archlinux-a2" "destroy archlinux-a2" "start archlinux-a3" "destroy archlinux-a3")

exit

while read msg; do
    echo "message: $msg"
    case "$msg" in
    "restart client")
        virsh -c qemu:///system start z37o-gluster-client
        ;;
    "destroy client")
        virsh -c qemu:///system destroy z37o-gluster-client
        ;;
    "restart server")
        virsh -c qemu:///system start z37o-gluster
        ;;
    "destroy server")
        virsh -c qemu:///system destroy z37o-gluster
        ;;
    esac
done < <(nbutton "restart client" "destroy client" "restart server" "destroy server")

exit

while read msg; do
    echo "message: $msg"
    case "$msg" in
    "restart main")
        virsh -c qemu:///system start z37o
        ;;
    "destroy main")
        virsh -c qemu:///system destroy z37o
        ;;
    "restart nfsd")
        virsh -c qemu:///system start z37o-nfsd
        ;;
    "destroy nfsd")
        virsh -c qemu:///system destroy z37o-nfsd
        ;;
    esac
done < <(nbutton "restart main" "destroy main" "restart nfsd" "destroy nfsd")
