#!/bin/sh

tasks=2
[ -n "$1" ] && tasks=$1
while [ $(jobs | wc -l) -gt $tasks  ] ; do
	echo -n w
	sleep '0.2'
done

