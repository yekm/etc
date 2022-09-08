nn=$(nproc)
a=lz4
m=512M
modprobe zram num_devices=$nn
seq 0 $nn | while read n; do
    echo $a > /sys/block/zram$n/comp_algorithm
    echo $m >/sys/block/zram$n/disksize
    mkswap --label zram$n /dev/zram$n
    swapon --priority 123 /dev/zram$n
done

