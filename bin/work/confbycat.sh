#! /usr/bin/env bash

db=
if [[ $1 = "shared" ]]; then
  db="ezrez_shared_$(get_release_version.sh)"
else
  db="qaone"
fi

cat="$(get_configuration_categories.sh $db | fzf -0 -1 | awk -F: '{print $1 " +" $2}')"

if [[ -n $cat ]]; then
  get_configurations.sh $db $cat
fi
