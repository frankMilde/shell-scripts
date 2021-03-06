#!/bin/sh
# original script
#    http://www.macosxhints.com/article.php?story=20030217172653485
#    author: Shane Celis <shane (at) gnufoo (dot) org>

if [ $# -eq 0 ]; then
        echo "usage: trashit <files...>" >&2
        exit 2;
fi

for file in "$@"; do
        # get just file name 
        destfile="`basename \"$file\"`"
        suffix='';
        i=0;

        # If that file already exists, change the name
        while [ -e "$HOME/.Trash/${destfile}${suffix}" ]; do
                suffix="_copy_$i";
                i=`expr $i + 1`
        done

        mv -vi "$file" "$HOME/.Trash/${destfile}${suffix}"
done
