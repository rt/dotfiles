#! /usr/bin/env bash

# get <cfile> under the cursor
# core-webapp/aa/bb/cc
name="$1"

root="~/dev/repos/dev/"
templatesPath="/Users/rtsunoda/dev/repos/dev/core-webapp/src/main/webapp/resources/shopping/templates"
scriptsPath="/Users/rtsunoda/dev/repos/dev/core-webapp/src/main/webapp/resources/shopping/scripts"
handlebarsHelpersPath="/Users/rtsunoda/dev/repos/dev/core-webapp/src/main/webapp/resources/shopping/scripts/handlebars_helpers"

results=$(find $templatesPath -name ${name}.hbs)

if [[ -z $results ]]; then
  name=${name//-/_}
  results=$(find $scriptsPath -name ${name}.js)

  if [[ -z $results ]]; then
    name=${name}_helper
    results=$(find $handlebarsHelpersPath -name ${name}.js)
  fi

fi

echo "$results"

