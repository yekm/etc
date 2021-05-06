#!/bin/bash -e

arecord -D "$1" mic.raw &
sleep 10
killall arecord
sox -r 8000 -b 8 -c 1 -e unsigned -t raw mic.raw -n spectrogram
sxiv spectrogram.png
