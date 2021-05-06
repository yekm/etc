#!/bin/sh
[ -n $DOIT ] && cmd="rm -v"
[ -z $DOIT ] && cmd="echo Will delete "
find . \( \
	   -iname '*.log' \
	-o -iname '*.m3u' \
	-o -iname 'Thumb.jpg' \
	-o -iname 'folder.jpg' \
	-o -iname 'Thumbs.db' \
	-o -iname 'Info.txt' \
	-o -iname '00 - pregap.flac' \
	\) \
	-print0 | xargs -0 -n1 $cmd

