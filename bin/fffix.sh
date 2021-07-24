#duration=$(ffprobe -v error -select_streams v:0 -show_entries stream=duration -of default=noprint_wrappers=1:nokey=1 -sexagesimal "$1")
#ffmpeg -i "$1" -to $duration -movflags +faststart -c copy /mnt/nvme256/$(basename "$1")
ffmpeg -i "$1" -movflags +faststart -c copy /mnt/nvme/fffix/$(basename "$1")
