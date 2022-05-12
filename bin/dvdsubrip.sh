#!/bin/bash

# time ls -1 *.mkv | parallel -d '\n' dvdsubrip.sh

set -vx

f="$1"
ffmpeg -n -i "$f" -map 0:s -c copy "$f".sub.mkv
t=0
ffprobe "$f" |& grep Subtitle | cut -f2 -d: | tr -dc 'a-z\n' | while read lang; do
   mkvextract "$f".sub.mkv tracks $t:"$f"-$lang.idx
   vobsub2srt --verbose "$f"-$lang
   rm -v "$f"-$lang.idx "$f"-$lang.sub
   (( t++ ))
done
rm -v "$f".sub.mkv

