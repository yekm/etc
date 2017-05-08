#!/bin/bash

pulseaudio --start
/usr/bin/alsa_out -d hw:PCH,0 -r192000 -j onboard &
/usr/bin/alsa_in -d hw:PCH,0 -r192000 -j onboard_in &
sleep 1
chrt --rr 99 jalv.gtk --jack-name eq12 -l ~/etc/audio/lv2/12band http://calf.sourceforge.net/plugins/Equalizer12Band &
chrt --rr 99 jalv.gtk --jack-name eq12o -l ~/etc/audio/lv2/onboard http://calf.sourceforge.net/plugins/Equalizer12Band &
chrt --rr 99 jalv.gtk --jack-name stereotools -l ~/etc/audio/lv2/stools http://calf.sourceforge.net/plugins/StereoTools &
chrt --rr 99 jalv.gtk --jack-name comp -l ~/etc/audio/lv2/comp http://calf.sourceforge.net/plugins/Compressor &
#chrt --rr 99 jalv.gtk --jack-name deesser http://calf.sourceforge.net/plugins/Deesser &
#chrt --rr 99 jalv.gtk --jack-name analyzer -l ~/etc/audio/lv2/analyzer http://calf.sourceforge.net/plugins/Analyzer &
sleep 1
mpd

