
set -eu

mp=/mnt/testfs
mkdir -p $mp

dev=/dev/nvme0n1p50

#set +vx

writefiles() {
    cat /tmp/linux.kernel.c.h.tar | pv -rab | tar x -C $mp
    umount $dev
}

testfs() {
    echo
    echo
    echo "$f"
    mount $dev $mp -o $o >/dev/null
    mount | grep $dev
    read _w _rw <<< $(vmstat -p $dev | tail -n1 | awk '{print $3,$4}')
    time writefiles
    read w rw <<< $(vmstat -p $dev | tail -n1 | awk '{print $3,$4}')
    echo -n writes:
    bc -l <<< "$w - $_w"
    echo -n requested writes:
    bc -l <<< "$rw - $_rw"

    mount $dev $mp -o $o >/dev/null
    read _r _rr <<< $(vmstat -p $dev | tail -n1 | awk '{print $1,$2}')
    time grep fuck $mp -r | wc -l
    read r rr <<< $(vmstat -p $dev | tail -n1 | awk '{print $1,$2}')
    umount $dev
    echo -n reads:
    bc -l <<< "$r - $_r"
    echo -n requested reads:
    bc -l <<< "$rr - $_rr"
}

#f=extra_attr,inode_checksum,sb_checksum
#o=atgc,gc_merge,lazytime
#mkfs.f2fs -q -O $f -f $dev
#time testfs

#f=extra_attr,inode_checksum,sb_checksum,compression
#o=compress_algorithm=zstd:9,compress_extension=txt,compress_extension=c,compress_extension=h,compress_chksum,atgc,gc_merge,lazytime
#mkfs.f2fs -q -O $f -f $dev
#time testfs

f=
o=lazytime
mkfs.btrfs -q -f $dev
time testfs


