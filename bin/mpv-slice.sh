#!/bin/bash -vx

ffmpeg -v warning -y -stats \
    -ss $2 -i "$1" -t $3 \
    -c copy \
    "$1-at-$2.mkv"


#ffmpeg -v warning -y -stats \
#    -ss $2 -i "$1" -t $3 \
#    -c:v libvpx-vp9 -b:v 0 -crf 30 -pass 1 -row-mt 1 -an -f webm -y /dev/null
#ffmpeg -v warning -y -stats \
#    $@ \
#    -c:v libvpx-vp9 -b:v 0 -crf 30 -pass 2 -row-mt 1 -c:a libopus ""

