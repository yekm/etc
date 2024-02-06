
# parallel --eta bash ~/bin/sxiv-thumb.sh ::: *.jpg

p=$(realpath "$1")
o="$HOME/.cache/sxiv/$p"
mkdir -p $(dirname "$o")

#[ -s "$o" ] && exit

[ -s "$o" ] || magick "$1" -thumbnail '160x160' "$o"
touch -r "$1" "$o"
