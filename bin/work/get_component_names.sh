#! /usr/bin/env bash

scriptsPath="/Users/rtsunoda/dev/repos/dev/core-webapp/src/main/webapp/resources/shopping/scripts/components"

for file in $(ls $scriptsPath); do
  file=${file/.js/}
  echo ${file//_/-}
done

