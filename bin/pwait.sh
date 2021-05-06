#!/bin/sh

task=$1
[ -z "$task" ] && exit -1
tasks=2
[ -n "$2" ] && tasks=$2
timeout=0
[ -n "$3" ] && timeout=$3
d="0.2"
[ -n "$4" ] && d=$4
all=0
while [ $(pgrep $task | wc -l) -gt $tasks  ] ; do
    echo -n w
    sleep $d
    [ "$timeout" != 0 ] && all=$(echo $d+$all | bc) && [ $(echo "$all>$timeout" | bc) = "1" ] && echo timeout $timeout && exit 2
done

