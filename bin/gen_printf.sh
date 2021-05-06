#!/bin/bash

buf=$(cat)
name=$1
[ -z "$name" ] && name="val"

function pdefine
{
    while read define name value; do
        #echo "process $define $name $value"
        echo "    case $name: return \"$name\"; break;"
    done
}

function penum
{
    tr -d ',' | cut -d= -f1 | while read value; do
        #echo "process $define $name $value"
        [ -n "$value" ] && echo "    case $value: return \"$value\"; break;"
    done
}

cat << EOF
static const char * print_$name(int val)
{
    switch(val)
    {
EOF

if echo "$buf" | grep '#define' >/dev/null ; then
    echo "$buf" | pdefine
else
    echo "$buf" | penum
fi


cat << EOF
    default: return sprintf("error: unimplemented %d", val); break;
    }
}
EOF

