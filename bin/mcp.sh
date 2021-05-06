#!/bin/sh

[ -z "$to" ] && to=.

list=$(find -L "$from" -iname "$what" -type f | sort)
count=$(echo "$list" | wc -l)
echo "$list" | while read f ; do
    let "c = c + 1"
    echo -n "$c/$count "
    fn=$(basename "$f")
    base=${f##$from}
    base=${base##/}
    dn=$(dirname "$base")
    if [ ! -d "$to/$dn" ] ; then
        # if destination folder do not exist...
        [ -z $create ] && continue # ...skip
        # ...or create and proceed
        mkdir -p "$to/$dn"
    fi
    case "$todo" in
    thumb)
        o1="$to/$dn/$fn"
        o2="$to/$dn/small_$fn"
        [ -z $FAKE ] && [ ! -f "$o1" ] && convert "$f" -resize x400 "$o1"
        [ -z $FAKE ] && [ ! -f "$o2" ] && convert "$o1" -resize x20 "$o2"
    ;;
    fat)
        tofn=$(echo -n "$fn" | iconv -c -t cp1252 | iconv -c -f cp1251 | perl -pe 's/[^абвгдеёжзийклмнопрстуфхцчшщэюыяьъАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЭЮЯЫЬЪa-z0-9A-Z\-\(\) \.]/_/g')
        tofn=$(echo -n "$fn" | iconv -c -t cp1251 | iconv -c -f cp1251 | perl -pe 's/[^абвгдеёжзийклмнопрстуфхцчшщэюыяьъАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЭЮЯЫЬЪa-z0-9A-Z\-\(\) \.]/_/g')
        #todn=$(echo "$dn" | tr -d '\/:*?<>|')
        t="$to/$dn/$tofn"
        if [ -f "$t" ]; then
            if [ $(du -b "$f" | cut -f1) -gt $(du -b "$t" | cut -f1) ] ; then
                [ -z $FAKE ] && cp "$f" "$t"
                echo -n "copied"
            else
                echo -n "skipped"
            fi
        else
            [ -z $FAKE ] && cp "$f" "$t"
            echo -n "copied"
        fi
        echo " $f -> $t"
        sync
    ;;
    tojpeg)
        jpeg="$to/$dn/${fn%.*}.jpg"
        echo -e "$f \t\t $jpeg"
        gm convert "$f" -quality 90 "$jpeg"
    ;;
    custom)
        echo "ccp $f --- $to/$dn/$tofn"
        customcp "$f" "$to/$dn/$tofn"
    ;;
    ogg)
        tofn=$(echo -n "$fn" | iconv -c -t cp1251 | iconv -c -f cp1251 | perl -pe 's/[^абвгдеёжзийклмнопрстуфхцчшщэюыяьъАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЭЮЯЫЬЪa-z0-9A-Z\-\(\) \.]/_/g')
        t="$to/$dn/$tofn"
        #t=$(echo "$t" | sed -e 's/\.flac$/\.ogg/i'); # sed can into "case insensitive"
        t=${t%.*}.ogg
        echo -n "$f -> $t"
#        p="/tmp/ccp.pipe"
#        mkfifo $p 2>/dev/null
#        mplayer -vc null -vo null -ao pcm:waveheader:fast:file="$p" $MOPTS "$f" &
#        mplayer -really-quiet -vc null -vo null -ao pcm:waveheader:fast:file="$p" $MOPTS "$f" &
        if [ -s "$t" ]; then
#            if oggdec ; then
#                [ -z $FAKE ] && oggenc -Q -q 7 -o "$t" "$f"
#               pwait.sh oggenc 1
#                echo " copied"
#            else
                echo " skipped"
#            fi
        else
            #[ -z $FAKE ] && nice oggenc -Q -q 7 -o "$t" "$f" &
            [ -z $FAKE ] && nice ffmpeg -loglevel error -i "$f" -c:a libvorbis -q:a 7 "$t" </dev/null &
            pwait.sh ffmpeg 4
            echo " copied"
        fi
    ;;
    opus)
        tofn=$(echo -n "$fn" | iconv -c -t cp1251 | iconv -c -f cp1251 | perl -pe 's/[^абвгдеёжзийклмнопрстуфхцчшщэюыяьъАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЭЮЯЫЬЪa-z0-9A-Z\-\(\) \.]/_/g')
        t="$to/$dn/$tofn"
        t=${t%.*}.opus
        echo "$f -> $t"
        [ -z $FAKE ] && nice ffmpeg -loglevel error -i "$f" -c:a libopus -b:a 128000 "$t" </dev/null &
        pwait.sh ffmpeg 4
    ;;
    *)
        echo -e "$f \t\t $to/$dn"
        [ -z $FAKE ] && cp -v "$f" "$to/$dn"
    ;;
    esac
done

wait

