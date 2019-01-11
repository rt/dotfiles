#! /usr/bin/env bash

# core-webapp/src/main/webapp/resources/shopping/templates/components/*
# core-webapp/src/main/webapp/resources/shopping/templates/search_results|checkout
rpath="$1"

## This could be once script to immediately find the other
#### Ember to Backing js (manipulate rpath and search in scripts)
#- change to snake case and search
#- consider the template path > search in controllers
#- remove .handheld .base

rpath=${rpath/\/Users\/rtsunoda\/dev\/repos\/dev\//} # sometimes? vim passes absolute path
modulePath=${rpath%%/*} #remove from end greedily, get module path
tmpPath=${rpath#*/} #remove module from beg
tmpPath=${tmpPath%/*} #remove file part from the end
filePart=${rpath##*/} #remove longest part (greedily) from the front

tmpPath=${tmpPath/templates/scripts} # change to templates dir
filePart=${filePart/.hbs/} #remove hbs
filePart=${filePart/.base/} #remove .base
filePart=${filePart/.handheld/} #remove .handheld
filePart=${filePart//-/_} # change _ to - we only do this for controllers

if [[ ! $tmpPath = *"/components" ]]; then
  #controller
  tmpPath=${tmpPath/scripts/scripts/controllers} #add controllers/ (templates dont have this directory)
  tmpPath=${tmpPath//-/_} # change _ to - we only do this for controllers
  filePart=${filePart}_controller.js #add _controller.js
else
  filePart=${filePart}.js #add .js
fi


if [[ $2 = "debug" ]]; then
  echo "modulePath: $modulePath"
  echo "tmpPath: $tmpPath"
  echo "filePart: $filePart"
else
  echo "$modulePath/$tmpPath/$filePart"
fi


