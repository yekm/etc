#!/bin/bash

# https://trac.ffmpeg.org/wiki/FancyFilteringExamples

set -vxu
ffmpeg  -f jack -i ffmpeg_cqt -flush_packets 1 -flags low_delay -muxdelay 0.01 -fflags nobuffer -f wav -c copy - | \
    mpv - --profile=low-latency -untimed \
        --lavfi-complex="[aid1]showspectrum=color=channel:slide=lreplace:scale=5thrt:data=magnitude:fscale=lin:legend=0:orientation=horizontal:overlap=1:s=270x480[vo]"

# "showspectrum=color=channel:scale=cbrt:orientation=vertical:overlap=1:s=2048x1024"
# "[aid1]showspectrum=color=fire:scale=log:s=1080x1920[vo]"
