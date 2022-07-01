#!/bin/bash -vx

[ -z "$3" ] && exit -1
[ -z "$2" ] && exit -1

mode=cut
#mode=gif
#mode=gifsub

cv="-c:v libx264 -pix_fmt yuv420p -crf 22 -preset slower -tune zerolatency"
#cv="-c:v h264_nvenc -preset p7 -tune ll -profile:v high -rc-lookahead 8 -spatial_aq 1 -pix_fmt yuv420p"

case $mode in
    cut)
    ffmpeg -v warning -y -stats \
        -ss $2 -t $3 -i "$1" \
        -c:a copy \
        -c:v copy \
        "$1-at-$4.mp4"
    ;;
    gif)
    ffmpeg -v warning -y -stats \
        -ss $2 -t $3 -i "$1" \
        -filter:v "scale='trunc(oh*a/2)*2:480':flags=spline" \
        -an \
        $cv \
        "$1-at-$4-gif.mp4"
    ;;
    gifsub)
    set -x
    ffmpeg -v info -y -stats \
        -ss $2 -t $3 -copyts -i "$1" \
        -ss $2 \
        -filter:v "scale='trunc(oh*a/2)*2:480':flags=spline,subtitles='$1':stream_index=0:force_style='Fontsize=30,Fontname=SourceCodePro-Black'" \
        -an \
        $cv \
        "$1-at-$4-gif.mp4"
    ;;
    wiki)
    ffmpeg -v warning -y -stats \
        -ss $2 -t $3 -i "$1" \
        -c:v libvpx-vp9 -b:v 0 -crf 30 -pass 1 -row-mt 1 -an -f webm -y /dev/null
    ffmpeg -v warning -y -stats \
        $@ \
        -c:v libvpx-vp9 -b:v 0 -crf 30 -pass 2 -row-mt 1 -c:a libopus \
        "$1-at-$4.mp4"
    ;;
esac

# libx264 -crf 17 -preset fast -tune zerolatency
#         -filter:v "scale='trunc(oh*a/2)*2:360',subtitles='$1':stream_index=0" \

