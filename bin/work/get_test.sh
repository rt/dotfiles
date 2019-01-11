#! /usr/bin/env bash

# Get test for current file
rpath="$1"
filePart=${rpath##*/} #remove longest part (greedily) from the front

# adjust name depending on file type
case $filePart in

  *.js)
    rpath=${rpath/scripts/test}
    rpath=${rpath/.js/_spec.js}
    ;;

  *.java)
    rpath=${rpath/main/test}
    rpath=${rpath/.java/Test.java}
    ;;

esac


# sometimes its in the wrong directory, could do a "find .." 

echo "$rpath"


