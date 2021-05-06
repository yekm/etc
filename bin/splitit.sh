#!/bin/sh
[ -z "$DIR" ] && DIR="."
#tmpcue=$(mktemp --dry-run)
failedcue=0
export failedcue
tmpcue="/tmp/tmp_cue_${USER}_`date +%N`.cue"
[ -n "$NOSPLIT" ] && cueiname='-o -iname "*.cue"'
find -L "$DIR" -iname "*.ape" -o -iname "*.flac" -o -iname "*.wv" -o -iname "*.wav" $cueiname -type f | {
while read f; do
	base=${f##"$DIR"}
	base=${base##/}
	dn=$(dirname "$base")
	[ -z "$FAKE" ] && mkdir -p "$dn"

	echo "::: $f"
	dir=$(dirname "$f")
	cue="$f.cue"
	[ ! -f "$cue" ] && echo "$f" | grep "\.wv$" && `wvunpack -c "$f" >"$cue-unpack.cue"` && cue="$cue-unpack.cue"
#	if [ $? == 0 ] cue="$cue-unpack"
	if [ ! -f "$cue" ] ; then
		# cut the extention of source file
		cue=${f%.*}.cue
		echo -n "new cue $cue... "
		if [ ! -f "$cue" ] ; then
			cue=$(find -L "$dir" -iname "*.cue")
			echo -n "new cue $cue... "
			if [ $(echo -n "$cue" | wc -c) -eq 0 -o $(echo "$cue" | wc -l) -ne 1 ]; then
				echo "cant find cuesheet or found more than 1. skipping."
				let "failedcue+=1"
				continue
			fi
		fi
		echo "ok"
	fi
	echo "	$cue
dir	$dir
dn	$dn"
	if [ -z "$FAKE" ]; then
		if [ -n "$CODEPAGE" ]; then
			iconv -f $CODEPAGE "$cue" >"$tmpcue"
			cue="$tmpcue"
		fi
		if [ -z "$NOSPLIT" ]; then
#			if shnsplit -f "$cue" -t "%a - %n - %t" -o flac "$f" -d "$dn"; then
			if shnsplit -O never -f "$cue" -t "%n - %t" -o flac "$f" -d "$dn"; then
		   		[ -n "$REMOVE" ] && rm -v "$f"
			fi
		fi
		if [ -z "$NOTAG" ]; then
            if DIR="$dn" CUE="$cue" FAKE=$FAKE cue2metaflac.sh; then
                [ -n "$REMOVE" ] && rm -v "$cue"
            fi
        fi
		if [ -z "$NOMCP" ]; then
            from="$dir" what="*.jpg" to="$dn" create=1 mcp.sh
            from="$dir" what="*.tif" to="$dn" create=1 mcp.sh
            from="$dir" what="*.tiff" to="$dn" create=1 mcp.sh
            from="$dir" what="*.png" to="$dn" create=1 mcp.sh
        fi
	fi
done
echo "cant find $failedcue cuesheets"
}
[ -n "$CODEPAGE" ] && rm "$tmpcue"

