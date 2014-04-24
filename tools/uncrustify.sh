#!/bin/bash

DIR=$(cd $(dirname $0)/../ && pwd)

cd $DIR
if [ "$1" == '--all' ]; then
FILES=`find . \( -name '*.h' -o -name '*.m' \)`;
else
FILES=`git status | grep modified | awk '{print $2}' | egrep '\.(m|h)$'`
fi

ORG_IFS=$IFS
IFS=$'\n'
for FILE in $FILES
do
    /usr/local/bin/uncrustify -c "$DIR"/tools/objc.cfg --no-backup "$DIR"/"$FILE"
done
IFS=ORG_IFS
