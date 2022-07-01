#for i in $(seq -w 1 4); do
#    hp-scan -m color -r 1200 -xraw -o$i-1200.png
#done
#
#enf() {
#    exp=$1
#    sat=$2
#    con=$3
#    ent=$4
#
#    enfuse -v --output $exp-$sat-$con-$ent.tif \
#        --exposure-weight=$exp \
#        --saturation-weight=$sat \
#        --contrast-weight=$con \
#        --entropy-weight=$ent \
#        *-1200.png
#}
#
#enf 1 0 0 0
#enf 1 0 0 1
#enf 1 0.5 0.5 0.5
#enf 1 0.5 0.5 1

read n <.n
(( n ++ ))
echo $n
n0=$(printf '%.6d' $n)
t=/tmp/tmpscan.png
hp-scan -m color -r 1200 -xraw -o$t
gm convert $t -quality 90 $n0-$(date +%F_%R).jpg
rm $t
echo $n >.n

