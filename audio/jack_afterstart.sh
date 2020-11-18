#!/bin/bash

#SR=192000
#SR=96000
#SR=48000
#SR=44100

#killall pulseaudio
#killall -9 alsa_in
#killall -9 alsa_out
#killall mpd
#sleep 0.5
#pulseaudio --start
#/usr/bin/alsa_out -d hw:PCH,0 -r$SR -j onboard &
#/usr/bin/alsa_in -d hw:PCH,0 -r$SR -j onboard_in &

x42-meter 0 &
x42-meter 13 &
x42-meter 14 &
#x42-meter 10 -j rms &
#x42-meter 10 -j rms_o &
#x42-meter 10 -j dumb-client &
sleep 0.5

#calf=~/src/repos/lv2/calf/inst/bin/calfjackhost
calf=/bin/calfjackhost
#$calf --load ~/etc/audio/cjh.xml &
$calf -c meincalf --load ~/etc/audio/cjh.xml &
$calf -c bcalf    --load ~/etc/audio/bcalf.xml &
#jalv.gtk3 https://github.com/lucianodato/noise-repellent &
#chrt --rr 99 $calf --client inputs --load ~/etc/audio/inputs.xml &

#chrt --rr 99 jalv.gtk --jack-name eq12 -l ~/etc/audio/lv2/12band http://calf.sourceforge.net/plugins/Equalizer12Band &
#chrt --rr 99 jalv.gtk --jack-name eq12o -l ~/etc/audio/lv2/onboard http://calf.sourceforge.net/plugins/Equalizer12Band &
#chrt --rr 99 jalv.gtk --jack-name stereotools -l ~/etc/audio/lv2/stools http://calf.sourceforge.net/plugins/StereoTools &
#chrt --rr 99 jalv.gtk --jack-name comp -l ~/etc/audio/lv2/comp http://calf.sourceforge.net/plugins/Compressor &
#chrt --rr 99 jalv.gtk --jack-name deesser http://calf.sourceforge.net/plugins/Deesser &
#chrt --rr 99 jalv.gtk --jack-name analyzer -l ~/etc/audio/lv2/analyzer http://calf.sourceforge.net/plugins/Analyzer &

jack_load netmanager &
