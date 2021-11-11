#!/bin/bash

fname="$1"
[ -z "$1" ] && fname=x11grab_$(date +%F_%R).mp4

ffmpeg -f jack -thread_queue_size 4096 -i ffmpeg_x11grab \
    -video_size 1920x1080 -framerate 60 -f x11grab -thread_queue_size 4096 -i :0.0+1200,0 \
    -c:a libopus -b:a 128K \
    -threads 8 -c:v libx264rgb -crf 16 -preset veryfast "$fname"
#echo "ffmpeg -i $fname -c:v libx264 -crf 14 -preset veryslow -c:a copy crf14-$fname"
#echo "time ffmpeg -ss 00:00:00 -to 00:00:00 -i '$fname' -c:v libx264 -crf 14 -preset veryslow -tune zerolatency -pix_fmt yuv420p -c:a copy 'zl-$fname'"
