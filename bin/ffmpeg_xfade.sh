#!/bin/bash
# usage: ls -1 something*.mp4 | ffmpeg_xfade.sh output.mp4

fdur=0.5
ftrans=pixelize
f0n=0
f1n=1
alld=0

while read f; do
	allvf="$allvf$vf"
	allaf="$allaf$af"
	inputs="$inputs -i $f "
	d=$(ffprobe -v error -select_streams v:0 -show_entries stream=duration -of default=noprint_wrappers=1:nokey=1 "$f")
	alld=$(bc -l <<< "$alld + $d")
	offset=$(bc -l <<< "$alld - $fdur * $f1n")
	vf="[vfade$f0n][$f1n:v]xfade=transition=$ftrans:duration=$fdur:offset=$offset[vfade$f1n];"
	af="[afade$f0n][$f1n:a]acrossfade=d=$fdur[afade$f1n];"
	(( f0n++ ))
	(( f1n++ ))
done

f0n=$(( f0n - 1 ))
allvf="[0:v]copy[vfade0];$allvf[vfade$f0n]format=yuv420p"
allaf="[0:a]acopy[afade0];$allaf[afade$f0n]acopy"

set -vx
ffmpeg -y -hide_banner $inputs \
	-filter_complex "$allvf;$allaf" \
	-c:v h264_nvenc -preset p7 -profile:v high -rc-lookahead 8 -spatial_aq 1 -pix_fmt yuv420p \
	-c:a libopus \
	"$1"
