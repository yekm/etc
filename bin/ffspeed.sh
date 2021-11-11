ffmpeg -y \
	-i "$1" -an \
	-filter:v "setpts=$2*PTS,drawtext=text='1/$2 speed':fontcolor=white:fontsize=36:x=20:y=20" \
	-c:v libx264 -pix_fmt yuv420p -crf 20 -preset slower -tune zerolatency \
	"$1.slow.mp4"
