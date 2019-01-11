#! /usr/bin/env bash

# Usages of <cfile> under the cursor
# core-webapp/aa/bb/cc
rpath="$1"
cfile="$2"

rpath=${rpath/\/Users\/rtsunoda\/dev\/repos\/dev\//} # sometimes? vim passes absolute path
rpath=${rpath%%/*} #remove from end greedily to just the module

echo "$rpath"
echo "$cfile"

