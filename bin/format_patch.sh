#!/bin/bash -vx

[ -z "$1" ] && exit -1
c="$2"
[ -z "$2" ] && c='russian chiphers'

b=$(git rev-parse --abbrev-ref HEAD)

git branch tmp $1
git checkout tmp
git merge --squash $b
git commit -am "$(basename $(pwd)) $b $(date +%F) $c from $1"
git format-patch --filename-max-length=333 -n -1
git checkout $b
git branch -D tmp

