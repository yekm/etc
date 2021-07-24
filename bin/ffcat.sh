ffmpeg -f concat -safe 0 -i <(printf "file '$PWD/%s'\n" $@) -c copy ffcat.mp4
