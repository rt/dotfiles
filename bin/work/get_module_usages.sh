#! /usr/bin/env bash

# Usages of the current file %

# core-webapp/aa/bb/cc
rpath="$1"

rpath=${rpath/\/Users\/rtsunoda\/dev\/repos\/dev\//} # sometimes? vim passes absolute path
modulePath=${rpath%%/*} #remove from end greedily, get module path
filePart=${rpath##*/} #remove longest part (greedily) from the front

name=${filePart%.*} #remove extension

# adjust name depending on file type
case $filePart in

  *.hbs)
    #name=${name/(handheld.|base.)/}
    name=${name/.handheld/}
    name=${name/.base/}
    ;;

  *.js)
    #filePart=$(echo "$filePart" | sed -r 's/(^|_)([a-z])/\U\2/g') OSX doesnt like this sed with -r
    name=$(echo "$name" | perl -pe 's/(^|_)./uc($&)/ge;s/_//g')
    #name="(${name}\(|${name}\s)"
    ;;

  *.java)
    # need regex
    ## search for instantiations
    #name="${name}("
    ## with space
    #name="${name} "

    #name="(${name}\(|${name}\s)"
    ;;

esac

if [[ $2 = "debug" ]]; then
  echo "name: $name"
  echo "modulePath: $modulePath"
  #ag "$name" -rl ~/dev/repos/dev/$modulePath

else 
  echo "$modulePath"
  echo "$name"
  #ag "$name" -rl $modulePath
fi

