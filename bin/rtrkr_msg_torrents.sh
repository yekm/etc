cache=/tmp/rtrkr_cache.html
[ -s $cache ] || rtrkr_curl.sh "$1" | tee $cache
cat $cache | \
    iconv -f cp1251 | \
    fq -d html -o array=true -r '.. | select(.[0] == "a" and (.[1].href|test("viewtopic.php.t=[0-9]+$")))? .[1].href' |
    sed 's/.*t=\([0-9]\+\).*/\1/' | \
    while read id; do
        [ -s $id.torrent ] && continue
        echo $id
        rtrkr_curl.sh https://rutracker.org/forum/dl.php?t=$id >$id.torrent
    done

