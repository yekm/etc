#!/bin/bash

# set target dir on selected torrents:
# bash rxml.sh list | grep ... | cut -f1 | bash rxml.sh set_dir /mnt/03/torrent/gd
# select completed torrents:
# bash rxml.sh list | cut -f 2,5 | grep '1.00$' | cut -f1 | bash rxml.sh ...
# set first custom tag:
# bash rxml.sh list | ... | cut -f1 | bash rxml.sh c1 arbitrary_sting_1
# filter by tag 1:
# bash rxml.sh list | cut -f 1,6 | grep 'arbitrary_sting_1$' | cut -f1 | bash rxml.sh ...


filter_string() {
    grep String | sed "s/.*String: '\(.*\)'/\1/"
}

filter_int() {
    grep integer | sed 's/64-bit integer: //'
}

x() {
    xmlrpc rutorrent.lan $@
}

xs() {
    x $@ | filter_string
}

xi() {
    x $@ | filter_int
}

case $1 in
list)
xmlrpc rutorrent.lan download_list | filter_string | \
    while read hash; do
        (
        echo $hash
        xs d.name $hash
        xs d.directory $hash
        cb=$(xi d.completed_bytes $hash)
        size=$(xi d.size_bytes $hash)
        echo $cb/$size
        printf %.2f$'\n' $(bc -l <<< "$cb / $size")
        xs d.custom1 $hash
        xs d.custom2 $hash
        ) | paste -s
    done
;;
set_dir)
    while read hash; do
        x d.directory.set $hash $2
    done
;;
check)
    while read hash; do
        x d.check_hash $hash
    done
;;
start)
    while read hash; do
        x d.start $hash
    done
;;
stop)
    while read hash; do
        x d.stop $hash
    done
;;
c1)
    while read hash; do
        x d.custom1.set $hash $2
    done
;;
c2)
    while read hash; do
        x d.custom2.set $hash $2
    done
;;
x)
    while read hash; do
        echo x $2 $hash ${@:3}
    done
;;
esac
