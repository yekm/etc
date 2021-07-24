set -vxe
duration=$(ffprobe -v error -select_streams v:0 -show_entries stream=duration -of default=noprint_wrappers=1:nokey=1 -sexagesimal "$1")
ffmpeg -y -i "$1" -af adelay=$2,loudnorm -to $duration -c:v copy -c:a libopus "$1-adelay.mp4"
