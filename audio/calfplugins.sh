#!/bin/bash -vx

#SR=192000
#SR=96000
SR=48000
#SR=44100

#/usr/bin/alsa_out -d hw:PCH,0 -r$SR -j onboard &
#/usr/bin/alsa_in -d hw:PCH,0 -r$SR -j onboard_in &

#calf=~/src/repos/lv2/calf/inst/bin/calfjackhost
#chrt --rr 99 $calf --load ~/etc/audio/cjh.xml &
#chrt --rr 99 $calf --client inputs --load ~/etc/audio/inputs.xml &

function jalvrun
{
	[ -z "$1" ] && return
	bn=$(basename "$1")
	d="/home/yekm/etc/audio/lv2/$bn"
	[ -d "$d" ] || mkdir -p "$d"
	if [ -s "$d/state.ttl" ]; then
		chrt --rr 99 jalv.gtk --jack-name $bn -l $d $1 &
	else
		chrt --rr 99 jalv.gtk --jack-name $bn $1 &
	fi
}

jalvrun http://calf.sourceforge.net/plugins/Equalizer12Band
jalvrun http://calf.sourceforge.net/plugins/StereoTools
jalvrun http://calf.sourceforge.net/plugins/Deesser
jalvrun http://calf.sourceforge.net/plugins/Analyzer
jalvrun http://calf.sourceforge.net/plugins/Equalizer8Band
jalvrun http://calf.sourceforge.net/plugins/Exciter
jalvrun http://calf.sourceforge.net/plugins/Limiter
jalvrun
jalvrun
jalvrun
jalvrun
jalvrun
jalvrun
jalvrun
jalvrun
jalvrun
jalvrun
jalvrun
jalvrun
jalvrun

