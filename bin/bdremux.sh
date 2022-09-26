for p in BDMV/PLAYLIST/*.mpls; do
    echo $p
    mkvmerge $p -o $(basename $p).mkv
done
