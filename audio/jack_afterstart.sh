#!/bin/bash

SR=192000
#SR=96000
SR=48000

killall pulseaudio
pulseaudio --start
/usr/bin/alsa_out -d hw:PCH,0 -r$SR -j onboard &
/usr/bin/alsa_in -d hw:PCH,0 -r$SR -j onboard_in &

chrt --rr 99 calfjackhost --load ~/etc/audio/cjh.xml &

#chrt --rr 99 jalv.gtk --jack-name eq12 -l ~/etc/audio/lv2/12band http://calf.sourceforge.net/plugins/Equalizer12Band &
#chrt --rr 99 jalv.gtk --jack-name eq12o -l ~/etc/audio/lv2/onboard http://calf.sourceforge.net/plugins/Equalizer12Band &
#chrt --rr 99 jalv.gtk --jack-name stereotools -l ~/etc/audio/lv2/stools http://calf.sourceforge.net/plugins/StereoTools &
#chrt --rr 99 jalv.gtk --jack-name comp -l ~/etc/audio/lv2/comp http://calf.sourceforge.net/plugins/Compressor &
#chrt --rr 99 jalv.gtk --jack-name deesser http://calf.sourceforge.net/plugins/Deesser &
#chrt --rr 99 jalv.gtk --jack-name analyzer -l ~/etc/audio/lv2/analyzer http://calf.sourceforge.net/plugins/Analyzer &
sleep 1
mpd
#ionice -c realtime mpd

