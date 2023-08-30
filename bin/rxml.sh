#!/bin/bash

# set target dir on selected torrents:
# bash rxml.sh list | grep ... | cut -f1 | bash rxml.sh set_dir /mnt/03/torrent/gd
# select completed torrents:
# bash rxml.sh list | cut -f 2,5 | grep '1.00$' | cut -f1 | bash rxml.sh ...
# set first custom tag:
# bash rxml.sh list | ... | cut -f1 | bash rxml.sh c1 arbitrary_sting_1
# filter by tag 1:
# bash rxml.sh list | cut -f 1,6 | grep 'arbitrary_sting_1$' | cut -f1 | bash rxml.sh ...


#P=RPCrut
P=RPCgd

filter_string() {
    grep String | sed "s/.*String: '\(.*\)'/\1/"
}

filter_int() {
    grep integer | sed 's/64-bit integer: //'
}

x() {
    xmlrpc http://rutorrent.lan/$P $@
}

xs() {
    x $@ | filter_string
}

xi() {
    x $@ | filter_int
}

info_line() {
    #set -vx
    (
        hash=$1
        echo $hash
        xs d.name $hash
        #echo "name"
        xs d.directory $hash
        cb=$(xi d.completed_bytes $hash)
        size=$(xi d.size_bytes $hash)
        echo $cb/$size
        printf %.2f$'\n' $(bc -l <<< "$cb / $size")
        xs d.custom1 $hash
        xs d.custom2 $hash
        xi d.down.rate $hash
        xi d.up.rate $hash
    ) | paste -s
}

export -f info_line xi xs x filter_int filter_string
export P

case $1 in
cache)
    cat $(ls -1t /tmp/rxml_$P.cache* | head -n1)
;;
dlist)
    x download_list | filter_string
;;
list)
    xmlrpc http://rutorrent.lan/$P download_list | filter_string | \
        parallel -k -j8 info_line | tee /tmp/rxml_$P.cache_$(date +%F_%R)
;;
ls)
    parallel -k -j8 info_line
;;
help)
    echo "hash name dir completed/total percent custom1 custom2 down up"
    echo "1    2    3   4               5       6       7       8    9"
;;
set_dir)
    while read hash; do
        x d.directory.set $hash "$2"
    done
;;
dbase_set)
    while read hash; do
        x d.directory_base.set $hash $2
    done
;;
check)
    while read hash; do
        x d.check_hash $hash
    done
;;
restart)
    while read hash; do
        x d.stop $hash
        x d.start $hash
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
fcount)
    while read hash; do
        xi d.size_files $hash
    done
;;
flist)
    while read hash; do
        c=$(echo $hash | $0 fcount)
        for i in $(seq 0 $c); do
        eco $i $c
        done
    done
;;
add_peer)
    while read hash; do
        x d.add_peer $2
    done
;;
x)
    while read hash; do
        echo xx $2 $hash ${@:3}
    done
;;
xx)
    set -vx
    while read hash; do
        x $2 $hash ${@:3}
    done
;;


# commands that read whole list

done)
    $0 cache | grep -P '\s1.00\s'
;;
notdone)
    $0 cache | grep -v -P '\s1.00\s'
;;


*)
    echo what?
;;
esac
