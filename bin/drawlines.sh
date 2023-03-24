gm convert -size 2480x3508 xc:white white.bmp

echo fill black >draw.txt

y=0
x=0
w=1
while [ $y -lt 3508 ]; do
    #echo "rectangle 0,$(( $y - $w/2)),2480,$(( $y + $w/2 ))" >> draw.txt
    echo "rectangle $(( $x - $w/2)),0,$(( $x + $w/2 )),3508" >> draw.txt
    (( w++ ))
    (( y += w+32 ))
    (( x += w+16 ))
done

gm mogrify -draw @draw.txt white.bmp

