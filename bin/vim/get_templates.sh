#! /usr/bin/env bash

rpath="$1"
tmpPath=${rpath%/*} #remove file part from the end
filePart=${rpath##*/} #remove longest part (greedily) from the front
filePart=${filePart/.js/} #remove js

tmpPath=${tmpPath/scripts/templates} # change to templates dir

tmpPath=${tmpPath//_/-} # change _ to - 

if [[ $filePart = *"_controller" ]]; then
  tmpPath=${tmpPath/controllers/} #remove controllers/ (templates dont have this directory)
  filePart=${filePart/_controller/} #remove controller
else
  filePart=${filePart//_/-} # change _ to -
fi

# here we allow for .hbs, base.hbs, or .handheld.hbs
#find $searchPath -regex "$filePart\(|.base|.handheld|-handheld\).hbs" 
#find "$modulePath/$tmpPath" -name "$filePart*.hbs" 
echo "$tmpPath/"
#echo "$filePart*.hbs" 
echo "$filePart.hbs" 


