#!/bin/bash

find . -iname "$2" | while read l; do
    dst=$(echo "$l" | perl -pe "$1")
    [ "$l" = "$dst" ] && continue
    echo -e "$l\n$dst\n"
    [ -n "$DOIT" ] && mv -v "$l" "$dst"
done

