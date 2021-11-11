#!/bin/bash -vx

[ -z "$3" ] && exit -1
[ -z "$2" ] && exit -1

mode=cut

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
        -ss $2 -t $3 -copyts -i "$1" \
        -filter:v "scale='trunc(oh*a/2)*2:480':flags=spline" \
        -an \
        -c:v libx264 -pix_fmt yuv420p -crf 22 -preset slower -tune zerolatency \
        "$1-at-$4-gif.mp4"
    ;;
    gifsub)
    ffmpeg -v warning -y -stats \
        -ss $2 -t $3 -copyts -i "$1" \
        -filter:v "scale='trunc(oh*a/2)*2:480':flags=spline,subtitles='$1':stream_index=0:9:force_style='Fontsize=30,Fontname=SourceCodePro-Black'" \
        -an \
        -c:v libx264 -pix_fmt yuv420p -crf 22 -preset slower -tune zerolatency \
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

