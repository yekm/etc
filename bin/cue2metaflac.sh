#!/bin/sh
[ -z "$CUE" ] && exit 1
[ -z "$DIR" ] && DIR="."
echo CUE = $CUE
echo DIR = $DIR
n=0
find "$DIR" -maxdepth 1 -iname "*.flac" | sort | while read f; do
	echo "$f" | grep "pregap.flac" && continue
	let "n+=1"
	echo "$f :: $n"
	cueinfo=$(cueprint -n $n -t 'ARRANGER=%A\nCOMPOSER=%C\nGENRE=%G\nMESSAGE=%M\nTRACKNUMBER=%n\nARTIST=%p\nTITLE=%t\nALBUM=%T\n' "$CUE" | egrep -v '=$')
	GENRE=$(head -n 6 "$CUE" | grep -i "GENRE" | sed "s/REM GENRE //i" )
	DATE=$(head -n 6 "$CUE" | grep -i "DATE" | sed "s/REM DATE //i" )
	echo -e "$cueinfo\nGENRE=$GENRE\nDATE=$DATE"
	[ -z "$FAKE" ] && echo "$cueinfo" | metaflac --set-tag "GENRE=$GENRE" --set-tag "DATE=$DATE" "$f" --import-tags-from=-
	echo
done

