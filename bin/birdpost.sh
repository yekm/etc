#!/bin/bash

set -ue

#set +vx
sdir=$(dirname ${BASH_SOURCE[0]})
. $sdir/tglib/tglib.sh
#set -vx

ffjson() {
    ffprobe -v quiet -print_format json -show_format -show_streams "$1"
}

CH=$FEEDER_CH
# birds test channel:
#CH=-1001430422431

o="$1"

#a=${ARTIST:-$(ffjson.sh "$o" | jq -r '.format.tags.artist')}
#t=${TITLE:-$(ffjson.sh "$o" | jq -r '.format.tags.title')}
dur=$(ffjson "$o" | jq -r '.streams[0].duration')
dur=$(printf %.0f $dur)

apicall \
	sendVideo \
	-F chat_id="$CH" \
	-F video=@"$o" \
	-F title="$o" \
	-F duration=$dur \
	-F disable_notification=true \
	-F protect_content=false \
	-F supports_streaming=true \
    -F width=$(ffjson "$o" | jq -r '.streams[0].width') \
    -F height=$(ffjson "$o" | jq -r '.streams[0].height')

rm -v apicall.log

