if [[ -z "$1" ]] ;then echo "Input file missing" ;exit ;fi

#cv="-c:v libx264 -pix_fmt yuv420p -preset veryslow -crf 18 -tune zerolatency"
#cv="-c:v h264_nvenc -preset p7 -profile:v high -zerolatency 1 -rc-lookahead 128 -spatial_aq 1 -pix_fmt yuv420p"
cv="-c:v h264_nvenc -preset p7 -profile:v high -zerolatency 1 -rc-lookahead 128 -spatial_aq 1 -pix_fmt yuv420p"
ffmpeg -i "$1" $cv -threads $(getconf _NPROCESSORS_ONLN) -c:a copy "$2"
