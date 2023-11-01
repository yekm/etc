set -vxeu

w=${1:-"2480"}
h=${2:-"3508"}

#3840x2160 4k lg tv

gm convert -size "${w}x$h" xc:white -pointsize 40 -fill "#ff08" label:'qweqwe' white.bmp

echo fill black >draw.txt
echo stroke black >>draw.txt
#echo strokewidth 3 >>draw.txt

y=0
x=0
rw=1
if [ -n "${do1+x}" ]; then
    rw=1
    w=$rw
    while [ $y -lt 3508 ]; do
        #echo "rectangle 0,$(( $y - $w/2)),2480,$(( $y + $w/2 ))" >> draw.txt
        echo "rectangle $(( $x - $w/2)),0,$(( $x + $w/2 )),3508" >> draw.txt
        (( w++ ))
        (( y += w+32 ))
        (( x += w+16 ))
    done
else
    inc=100
    while [ $y -lt $h ]; do
        echo "line 0,$y,$w,$y" >> draw.txt
        (( y += $inc ))
    done
    
    while [ $x -lt $w ]; do
        echo "line $x,0,$x,$h" >> draw.txt
        (( x += $inc ))
    done
fi

gm mogrify -stroke black -strokewidth 1 -draw @draw.txt white.bmp
