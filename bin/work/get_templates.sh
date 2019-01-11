#! /usr/bin/env bash

# core-webapp/src/main/webapp/resources/shopping/scripts/components/*
# core-webapp/src/main/webapp/resources/shopping/scripts/controllers/search_results|checkout
rpath="$1"

rpath=${rpath/\/Users\/rtsunoda\/dev\/repos\/dev\//} # sometimes? vim passes absolute path
modulePath=${rpath%%/*} #remove from end greedily, get module path
tmpPath=${rpath#*/} #remove module from beg
tmpPath=${tmpPath%/*} #remove file part from the end
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


if [[ $2 = "debug" ]]; then
  # debug
  echo "$modulePath" 
  echo "$tmpPath" 
  echo "$filePart"
else
  # here we allow for .hbs, base.hbs, or .handheld.hbs
  #find $searchPath -regex "$filePart\(|.base|.handheld|-handheld\).hbs" 
  #find "$modulePath/$tmpPath" -name "$filePart*.hbs" 
  echo "$modulePath/$tmpPath/"
  #echo "$filePart*.hbs" 
  echo "$filePart.hbs" 
fi


